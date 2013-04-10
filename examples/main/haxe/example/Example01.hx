package ;

import jsc.DynamicLoader;

class Example01 {

    public static function main() {
        var loader = new DynamicLoader("zip.zip");
        loader.loadAll();
    }
}