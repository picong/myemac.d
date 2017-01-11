function foo(){
    console.log("aaa");
}
foo();
(function(namespace){
    buster.testCase("test",{
	setup : function(){
	    this.controller = {};
	    this.panel = panel.create();
	    this.listener = this.spy();
	},
    });
})()
