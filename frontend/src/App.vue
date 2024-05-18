<template>
  <div id="app">
    <nav>
      <router-link to="/menu-bakso">Lihat Menu Bakso</router-link>
      <router-link to="/order-form">Buat Pesanan</router-link>
      <router-link to="/order-list">Lihat Daftar Pesanan</router-link>
    </nav>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'App'
};
</script>

<style scoped>
nav {
  display: flex;
  gap: 1em;
  margin-bottom: 1em;
}

router-link {
  text-decoration: none;
  color: #007BFF;
}

router-link:hover {
  text-decoration: underline;
}
</style>
