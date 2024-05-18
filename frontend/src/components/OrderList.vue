<template>
  <div>
    <h1>Daftar Pesanan</h1>
    <ul>
      <li v-for="order in orders" :key="order.id">
        {{ order.nama }} - {{ order.meja }} - {{ order.porsi_details }} - {{ order.status }}
        <button v-if="userRole !== 'pembeli'" @click="deleteOrder(order.id)">Hapus</button>
        <button @click="editOrder(order.id)">Edit</button> <!-- Tetap gunakan id -->
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      orders: [],
      userRole: '' // role pengguna akan disimpan di sini
    };
  },
  created() {
    this.fetchOrders();
    this.getUserRole();
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
    },
    async getUserRole() {
      try {
        const response = await axios.get('http://127.0.0.1:8000/api/get_user_role/');
        this.userRole = response.data.role;
      } catch (error) {
        console.error(error);
      }
    },
    editOrder(id) {
      // Implementasikan logika untuk mengedit pesanan di sini
      console.log(id); // Contoh penggunaan id
    }
  }
};
</script>

<style scoped>
/* Tambahkan gaya khusus di sini */
</style>
