<template>
  <div id="app">
    <header>后台管理系统</header>
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
*{
  padding:0;
  margin:0;
}
html,body{
  height: 100%;
}
#app{
  height: 100%;
  background-color:#e9eef3;
}
header{
    background-color: #B3C0D1;
    color: #333;
    font-size:24px;
    text-align: center;
    line-height: 60px;
}
li{
  list-style: none;
}
a{
  color:inherit;
  text-decoration: none;
}
</style>
