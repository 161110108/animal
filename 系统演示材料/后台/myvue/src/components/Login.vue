<template>
  <div id="login">
    <ul>
      <li class="title">管理员登陆</li>
      <li>
        <span class="name">手机号</span>
        <el-input class="inp" placeholder="请输入账号" v-model="user" clearable></el-input>
      </li>
      <li>
        <span class="name">密码</span>
        <el-input class="inp" placeholder="请输入密码" v-model="psd" show-password></el-input>
      </li>
      <li class="btn">
        <button @click="login">登陆</button>
      </li>
    </ul>
  </div>
</template>
<script>
export default {
    data(){
        return {
            user:null,
            psd:'',
            checkUser: /^1([38]\d|5[0-35-9]|7[3678])\d{8}$/,
            checkPsd: /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,10}$/,
            tipUser:'请输入正确的手机号',
            tipPsd:'6~10位由数字和26个英文字母混合而成的密码'
        }
    },
    methods:{
        login(){
            // console.log(this.checkUser.test(this.user),'user')
            // console.log(this.checkPsd.test(this.psd),'psd')
            if(!(this.checkUser.test(this.user))){
                this.$message({
                    message:this.tipUser,
                    offset:100
                })
                return false
            }
            if(!(this.checkPsd.test(this.psd))){
                this.$message({
                    message:this.tipPsd,
                    offset:100
                })
                return false
            }
            this.$axios.post('/api/user/adminLogin',{
                user:this.user,
                psd:this.psd
            }).then(res=>{
                if(res.data.state=='1'){
                    localStorage.setItem('user',res.data.name);
                    this.$router.push('/')
                }else{
                    this.$message({
                        message:'账号密码不正确',
                        offset:100
                    })
                }
            })
        }
    }
}
</script>
<style scoped>
#login {
  width: 400px;
  /* height: 200px; */
  background-color: #fff;
  margin: 20px auto;
}
.name {
  display: inline-block;
  width: 80px;
}
.inp {
  width: 200px;
}
ul {
  padding: 20px;
}
li {
  margin: 20px;
}
.title {
  text-align: center;
  font-size: 1.2em;
  padding: 0;
}
.btn {
  text-align: center;
  margin-top: 40px;
}
.btn button {
  width: 200px;
  height: 40px;
  border-radius: 5px;
}
</style>