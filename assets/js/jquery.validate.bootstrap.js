(function(){
var eClass = 'error'; // for bootstrap
var sClass = 'success'; // for bootstrap
$.validator.setDefaults({
    errorElement:"span" //not required.
    , errorClass:eClass//result is <span class="help-inline">xxx</span>
    , validClass:sClass //not required.
    , errorPlacement: function(error,element) {
       return true;
    }
    , highlight: function (element, errorClass, validClass) {
        var $element;
        if (element.type === 'radio') {
            $element = this.findByName(element.name);
        } else {
            $element = $(element);
        }
        $element.addClass(errorClass).removeClass(validClass);
        $element.parents("div.control-group").addClass(errorClass);
    }
    , unhighlight: function (element, errorClass, validClass) {
        var $element;
        if (element.type === 'radio') {
            $element = this.findByName(element.name);
        } else {
            $element = $(element);
        }
        $element.removeClass(errorClass).addClass(validClass);
        $element.parents("div.control-group").removeClass(errorClass);
    }
    , showErrors: function (errorMap, errorList) {

        $.each(this.successList, function (index, value) {
            var pop = $(value).popover({});

            pop.on('show shown hide hidden', function(e){
                e.stopPropagation();
            });

            $(value).popover('hide');
        });

        $.each(errorList, function (index, value) {
            var pop = $(value.element).popover({
                trigger: 'manual',
                content: value.message,
                template: '<div class="popover"><div class="arrow"></div><div class="popover-inner"><div class="popover-content"><p></p></div></div></div>'
            }).on('show shown hide hidden', function(e){
                e.stopPropagation();
            });

            pop.data('popover').options.content = value.message;

            $(value.element).popover('show');

        });
        this.defaultShowErrors();
    }
    , onkeyup: false
    , onclick: false
    , onsubmit: true
});
})();