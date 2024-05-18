<template>
  <div>
    <h1>Daftar Pesanan</h1>
    <ul>
      <li v-for="order in orders" :key="order.id">
        {{ order.nama }} - {{ order.meja }} - {{ order.pesanan }} - {{ order.status }}
        <button @click="deleteOrder(order.id)">Hapus</button>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      orders: []
    };
  },
  created() {
    this.fetchOrders();
  },
  methods: {
    async fetchOrders() {
      try {
        const response = await axios.get('http://127.0.0.1:8000/api/orderlist/');
        this.orders = response.data;
      } catch (error) {
        console.error(error);
      }
    },
    async deleteOrder(id) {
      try {
        await axios.delete(`http://127.0.0.1:8000/api/orderlist/${id}/`);
        this.orders = this.orders.filter(order => order.id !== id);
      } catch (error) {
        console.error(error);
      }
    }
  }
};
</script>

<style scoped>
/* Tambahkan gaya khusus di sini */
</style>
