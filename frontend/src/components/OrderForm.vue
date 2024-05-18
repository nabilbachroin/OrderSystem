<template>
  <div>
    <h1>Buat Pesanan</h1>
    <form @submit.prevent="submitOrder" v-if="!orderSubmitted">
      <div>
        <label>Nama:</label>
        <input type="text" v-model="order.nama" required />
      </div>
      <div>
        <label>Meja:</label>
        <input type="text" v-model="order.meja" required />
      </div>
      <div>
        <label>Pesanan:</label>
        <div v-for="(porsi, index) in order.porsis" :key="index">
          <select v-model="porsi.nama" @change="updateHarga">
            <option v-for="menu in menus" :key="menu.id" :value="menu.nama">{{ menu.nama }}</option>
          </select>
          <select v-model="porsi.kuah">
            <option value="">Pilih Kuah</option>
            <option value="pedas">Kuah Pedas</option>
            <option value="campur">Kuah Campur</option>
            <option value="biasa">Kuah Biasa</option>
          </select>
          <div>
            <label>Detail:</label>
            <div v-for="detail in detailOptions" :key="detail.value">
              <input type="checkbox" :value="detail.value" v-model="porsi.details" />
              <label>{{ detail.text }}</label>
            </div>
          </div>
          <button type="button" @click="removePorsi(index)">Hapus Porsi</button>
        </div>
        <button type="button" @click="addPorsi">Tambah Porsi</button>
      </div>
      <div>
        <label>Harga Total:</label>
        <input type="number" v-model="order.harga" readonly />
      </div>
      <div>
        <label>Pilihan:</label>
        <select v-model="order.pilihan">
          <option value="makan_sini">Makan Sini</option>
          <option value="bawa_pulang">Bawa Pulang</option>
        </select>
      </div>
      <button type="submit">Kirim Pesanan</button>
    </form>
    <p v-else>Pesanan Anda telah diterima. Lihat <router-link to="/order-list">Daftar Pesanan</router-link></p>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      order: {
        nama: '',
        meja: '',
        porsis: [],
        harga: 0,
        pilihan: '',
      },
      orderSubmitted: false,
      menus: [],
      detailOptions: [
        { text: 'Normal', value: 'normal' },
        { text: 'Tanpa Tahu', value: 'tanpa tahu' },
        { text: 'Mie Bihun/Putih Saja', value: 'mie bihun' },
        { text: 'Mie Kuning Saja', value: 'mie kuning' },
        { text: 'Pentol Kecil Saja (Tanpa Tahu dan Tanpa Pentol Besar)', value: 'pentol kecil' },
        { text: 'Cilok (Tanpa Tahu, Tanpa Pentol Besar, Tanpa Kuah)', value: 'cilok' },
        { text: 'Lainnya (Tulis Sendiri)', value: 'lainnya' },
      ],
    };
  },
  created() {
    this.fetchMenus();
    this.orderSubmitted = localStorage.getItem('orderSubmitted') === 'true';
  },
  methods: {
    async fetchMenus() {
      try {
        const response = await axios.get('http://127.0.0.1:8000/api/menubakso/');
        this.menus = response.data;
      } catch (error) {
        console.error('Failed to fetch menu:', error);
      }
    },
    addPorsi() {
      this.order.porsis.push({ nama: '', kuah: '', details: [] });
    },
    removePorsi(index) {
      this.order.porsis.splice(index, 1);
      this.updateHarga();
    },
    updateHarga() {
      this.order.harga = this.order.porsis.reduce((total, porsi) => {
        const menu = this.menus.find(menu => menu.nama === porsi.nama);
        return total + (menu ? parseFloat(menu.harga) : 0);
      }, 0);
    },
    async submitOrder() {
      try {
        const response = await axios.post('http://127.0.0.1:8000/api/orderlist/', this.order);
        console.log(response.data);
        this.orderSubmitted = true;
        localStorage.setItem('orderSubmitted', 'true');
      } catch (error) {
        console.error(error);
      }
    }
  }
};
</script>

<style scoped>
/* Tambahkan gaya khusus di sini */
form {
  max-width: 500px;
  margin: auto;
  padding: 1em;
  border: 1px solid #ccc;
  border-radius: 1em;
}

div {
  margin-bottom: 1em;
}

label {
  margin-bottom: .5em;
  color: #333333;
  display: block;
}

input, select {
  border: 1px solid #CCCCCC;
  padding: .5em;
  font-size: 1em;
  width: 100%;
  box-sizing: border-box;
}

button {
  padding: 0.7em;
  color: #fff;
  background-color: #007BFF;
  border: none;
  border-radius: 0.3em;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}
</style>
