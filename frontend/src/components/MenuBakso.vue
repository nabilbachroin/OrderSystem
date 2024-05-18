<template>
  <div>
    <h1>Menu Bakso</h1>
    <ul>
      <li v-for="item in menu" :key="item.id">
        {{ item.nama }} - {{ item.isi_porsi }} - {{ item.harga }}
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      menu: []
    };
  },
  created() {
    this.fetchMenu();
  },
  methods: {
    async fetchMenu() {
      try {
        const response = await axios.get('http://127.0.0.1:8000/api/menubakso/');
        this.menu = response.data;
      } catch (error) {
        console.error('Failed to fetch menu:', error);
      }
    }
  }
};
</script>

<style scoped>
/* Tambahkan gaya khusus di sini */
</style>
