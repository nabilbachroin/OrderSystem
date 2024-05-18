import { createRouter, createWebHistory } from 'vue-router';
import MenuBakso from '@/components/MenuBakso.vue';
import OrderForm from '@/components/OrderForm.vue';
import OrderList from '@/components/OrderList.vue';
import Login from '@/components/Login.vue';

const routes = [
  {
    path: '/menu-bakso',
    name: 'MenuBakso',
    component: MenuBakso
  },
  {
    path: '/order-form',
    name: 'OrderForm',
    component: OrderForm
  },
  {
    path: '/order-list',
    name: 'OrderList',
    component: OrderList
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
