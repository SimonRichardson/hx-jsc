(function() {
    var File01 = function File01(){
        this.init.apply(this, arguments);
    };
    File01.prototype = {
        init: function() {
            console.log("File 01 init");

            var file02 = new File02();
            file02.doSomething();
        }
    };
})();