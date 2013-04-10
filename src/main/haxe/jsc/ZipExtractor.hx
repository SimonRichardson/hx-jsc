package jsc;

import format.zip.Data.Entry;
import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.zip.Reader;

using funk.collections.immutable.List;

class ZipExtractor {

    private var _reader : Reader;

    public function new(bytes : Bytes) {
        trace(bytes.toHex().toUpperCase());
        var input = new BytesInput(bytes);
        _reader = new Reader(input);        
    }

    public function extract(expr : EReg) : List<Entry> {
        var list = Nil;
        for (entry in _reader.read()) {
            if (expr.match(entry.fileName)) {
                list = list.prepend(entry);
            }
        }
        return list;
    }
}