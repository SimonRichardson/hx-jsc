(function() {
    var File02 = function File02(){
        this.init.apply(this, arguments);
    };
    File02.prototype = {
        init: function() {
            console.log("File02 init");
        },
        doSomething: function() {
            console.log("File02 doSomething");
        }
    };
})();