
    // 展览图
    function imgMove(attr, x) {
        let temp = attr - $('.img-box').offset()[x]
        if (x == 'left') {
            // var temp = attr-getPos('offsetLeft')
            var c = $('.img-box').width();
        } else if (x == 'top') {
            // var temp = attr-getPos('offsetTop')
            var c = $('.img-box').height();
        } else {
            throw console.log('参数不正确')
        }
        if (temp < 50) {
            return 0;
        } else if (temp > c - 50) {
            return (c - 100)
        }
        return temp - 50;

    }
    $('.img-box').mousemove(function (ev) {
        let w = $(this).width() * 3 + 'px';
        let h = $(this).height() * 3 + 'px';
        let oleft = imgMove(ev.pageX, 'left');
        let otop = imgMove(ev.pageY, 'top');
        $('.choose').css('display', 'block');
        $('.choose').css({ 'left': oleft + 'px', 'top': otop + 'px' });
        $('.showDetail').css({ 'display': 'block', 'background': 'url(' + $('.tag-img').attr('src') + ') ' + (-3 * oleft) + 'px ' + (-3 * otop) + 'px no-repeat', 'background-size': w + ' ' + h });
    })
    $('.img-box').mouseleave(() => {
        $('.choose').css('display', 'none')
        $('.showDetail').css('display', 'none')
    })
    // 选项卡
    $btn = $('.menu-nav').children();
    $btn.click(function () {
        $btn.removeClass('select');
        $(this).addClass('select');
        $('.footer').children(':not(.menu-nav)').css('display', 'none');
        $('.footer').children(':not(.menu-nav)').eq($(this).index()).css('display', 'block')
    })

    //切换图片
    $img = $('.nail').children('img');
    $img.click(function(){
        if($(this).attr('src')!=''){
            console.log(1)
            $('.tag-img').attr('src',$(this).attr('src'))  ;
        }
    })