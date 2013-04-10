package jsc;

import format.zip.Data.Entry;
import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.zip.Reader;

using funk.collections.immutable.List;

class ZipExtractor {

    private var _reader : Reader;

    public function new(bytes : Bytes) {
        _reader = new Reader(new BytesInput(bytes));        
    }

    public function extract(expr : EReg) : List<Entry> {
        var list = Nil;
        var entries = _reader.read();
        for (entry in entries) {
            if (expr.match(entry.fileName)) {
                list = list.prepend(entry);
            }
        }
        return list;
    }
}