<template>
  <div id="exam">
      <el-input class="search" v-model="input" placeholder="请输入内容"></el-input>
    <template>
      <el-table :data="userArr" border style="width: 100%">
        <el-table-column prop="info.name" label="用户名" width="180"></el-table-column>
        <el-table-column prop="phone" label="电话" width="180"></el-table-column>
        <el-table-column prop="info.wechat" label="微信"></el-table-column>
        <el-table-column prop="info.adress" label="地址"></el-table-column>
        <el-table-column prop="info.msg" label="简介"></el-table-column>
        <el-table-column fixed="right" label="操作" width="220">
          <template slot-scope="scope">
            <el-button @click="handleClick(scope.row)" type="text" size="small">主页</el-button>
            <el-select style="width: 140px" v-model="scope.row.power" placeholder="请选择" @change="change(scope.row)">
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              ></el-option>
            </el-select>
          </template>
        </el-table-column>
      </el-table>
    </template>
  </div>
</template>
  </div>
</template>
<script>
import { mapState, mapMutations, mapActions } from "vuex";
export default {
  data() {
    return {
      timer: "",
      input:'',
    };
  },
  created() {
    this.$emit("choose", 1);
    this.updateUser();
    this.timer = setInterval(this.updateUser, 3000);
  },
  beforeDestroy() {
    clearInterval(this.timer);
  },
  computed: {
    ...mapState(["user", "power","optionsAll"]),
    options(){
        return this.optionsAll.slice(0,this.power)
    },
    userArr(){
        let arr = this.user.filter(val=>{
            return val.info.name.match(this.input) || val.phone.match(this.input) || val.info.adress.match(this.input) || val.info.msg.match(this.input) || val.info.wechat.match(this.input)
        })
        return arr;
    }
  },
  methods: {
    ...mapMutations(["setUser"]),
    ...mapActions(["updateUser"]),
    handleClick(val) {
        // console.log(val)
      window.location.href = "http://www.animal.com/info?id=" + val.id;
    },
    change(item){
        // console.log(item.power)
        this.$axios.post('/api/user/adminChange',{'id':item.id,'power':item.power})
        .then(res=>{
            if(res.data==1){
                 this.$message({
                     message:'修改成功',
                     offset:100,
                     duration:2000
                 });
            }
        })
    }
  }
};
</script>
<style scoped>
.search{
    margin-bottom:20px;
    width:300px;
}
#exam {
  line-height: 1.6em;
}
.el-button {
    margin-right:10px;
}
</style>