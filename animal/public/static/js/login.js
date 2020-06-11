//登陆验证
$data1 = $('<span class="warn">请输入正确的手机号</span>');
$data2 = $('<span class="warn">6~10位由数字和26个英文字母混合而成的密码</span>');
let checkUser = /^1([38]\d|5[0-35-9]|7[3678])\d{8}$/;
let checkPsd = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,10}$/;
$(':input').focus(function () {
    $(':input').parent().removeClass('inselect');
    $(this).parent().addClass('inselect')
})
$(':input[name=username]').change(function () {

    if (!checkUser.test(this.value)) {
        console.log(1);
        $(this).parent().after($data1)
    } else {
        $data1.remove();
    }
})
$(':input[name=password]').change(function () {
    if (!checkPsd.test(this.value)) {
        $(this).parent().after($data2)
    } else {
        $data2.remove();
    }
})

$('form').submit(function () {
    let username = this.username.value;
    let password = this.password.value;
    let autologin = $(this.autologin).is(":checked");
    // if((!checkUser.test(username)) || (!checkPsd.test(password))){
    //     return false; 
    // }
    if (!checkUser.test(username)) {
        $(':input[name=username]').focus();
        return false;
    } else if (!checkPsd.test(password)) {
        $(':input[name=password]').focus();
        return false;
    }
    $('.ver').css('display', 'block');
    var $captcha = $('#captcha').sliderCaptcha({
        repeatIcon: 'fa fa-redo',
        setSrc: function () {
            return 'http://imgs.sdgxgz.com/images/Pic' + Math.round(Math.random() * 136) + '.jpg';
        },
        onSuccess: function () {
            Post('./user/check', {
                'username': username,
                'password': password,
                'autologin': autologin
            })
        },
    });
    return false;
})

function Post(URL, PARAMTERS) {
    //创建form表单
    var temp_form = document.createElement("form");
    temp_form.action = URL;
    //如需打开新窗口，form的target属性要设置为'_blank'
    temp_form.target = "_self";
    temp_form.method = "post";
    temp_form.style.display = "none";
    //添加参数
    for (var item in PARAMTERS) {
        var opt = document.createElement("textarea");
        opt.name = item;
        opt.value = PARAMTERS[item];
        temp_form.appendChild(opt);
    }
    document.body.appendChild(temp_form);
    //提交数据
    temp_form.submit();
}