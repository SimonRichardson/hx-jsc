package jsc;

import funk.futures.Deferred;
import funk.types.Attempt;
import haxe.io.Bytes;

using funk.types.Option;
using funk.net.http.UriRequest;
using funk.futures.Promise;

class DynamicLoader {

    private var _bytes : Deferred<Bytes>;

    public function new(url : String) {
        _bytes = new Deferred();

        loadUrl(url);
    }

    public function loadAll(?resolve : Bool = true) : Void {
        _bytes.promise().when(function(attempt) {
            switch(attempt) {
                case Success(value): 
                    var extractor = new ZipExtractor(value);
                    trace(extractor.extract(~/^.*\.js$/));

                case _:
            }
        });
    }

    private function loadUrl(url : String) : Void {
        url.fromUri().get().map(function(value) return convertToBytes(value.body)).pipe(_bytes);
    }

    private function convertToBytes(possible : Option<String>) : Bytes {
        return switch(possible) {
            case Some(value): Bytes.ofString(value);
            case _: Bytes.alloc(0);
        }
    }
}