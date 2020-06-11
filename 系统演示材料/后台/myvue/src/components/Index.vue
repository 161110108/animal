<template>
  <div id="main">
    <el-container class="flex">
      <el-container class="child">

        <el-aside width="200px">
          <ul class="aside">
            <li @click="change('exam',0)" :class="{'aside-active':0==choose}">待审核</li>
            <li @click="change('power',1)" :class="{'aside-active':1==choose}">用户管理</li>
            <li @click="change('animal',2)" :class="{'aside-active':2==choose}">信息管理</li>

          </ul>
        </el-aside>
        <el-main><router-view @choose="fn"></router-view></el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>

export default {
  name: "HelloWorld",
  data() {
    return {
      choose:0
    };
  },
  methods: {
    change(p,i){
      this.choose = i;
      this.$router.push('/'+p)
    },
    fn(ind){
      this.choose = ind;
      console.log(ind)
    }
  },
  created() {
    
  }
};
</script>

<style scoped>
#main {
  height: 100%;
}
.flex {
  display: flex;
  height: 100%;
  flex-direction: column;
}
.child {
  flex: 1;
}

.aside{
  text-align: center;
  line-height: 50px;
  font-size: 16px;
}
.aside li{
  cursor: pointer;
}
.aside-active{
  background-color:#e9eef3 ;
}




/* 组件样式 */
.el-header,
.el-footer {
  background-color: #b3c0d1;
  color: #333;
  text-align: center;
  line-height: 60px;
}

.el-aside {
  background-color: #d3dce6;
  color: #333;
  text-align: center;
  /* line-height: 200px; */
}

.el-main {
  background-color: #e9eef3;
  color: #333;
  text-align: center;
  line-height: 160px;
}

body > .el-container {
  margin-bottom: 40px;
}

.el-container:nth-child(5) .el-aside,
.el-container:nth-child(6) .el-aside {
  line-height: 260px;
}

.el-container:nth-child(7) .el-aside {
  line-height: 320px;
}
</style>
