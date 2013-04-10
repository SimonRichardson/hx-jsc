package jsc;

import funk.futures.Deferred;
import funk.types.Attempt;
import haxe.io.Bytes;

#if sys
import sys.io.File;
#end

using funk.types.Option;
using funk.net.http.UriRequest;
using funk.futures.Promise;
using funk.collections.immutable.List;

class DynamicLoader {

    private var _bytes : Deferred<Bytes>;

    public function new(path : String) {
        _bytes = new Deferred();

        load(path);
    }

    public function loadAll(?resolve : Bool = true) : Void {
        _bytes.promise().when(function(attempt) {
            switch(attempt) {
                case Success(value): 
                    var extractor = new ZipExtractor(value);
                    extractor.extract(~/^.*\.js$/).foreach(function(entry) {
                        trace(entry.fileName);
                    });
                case _:
            }
        });
    }

    private function load(path : String) : Void {
        #if sys
        _bytes.resolve(File.getBytes(path));
        #else
        path.fromUri().get().map(function(value) return convertToBytes(value.body)).pipe(_bytes);
        #end
    }

    private function convertToBytes(possible : Option<String>) : Bytes {
        return switch(possible) {
            case Some(value): Bytes.ofString(value);
            case _: Bytes.alloc(0);
        }
    }
}