import { createRouter, createWebHistory } from 'vue-router';
import MenuBakso from '@/components/MenuBakso.vue';
import OrderForm from '@/components/OrderForm.vue';
import OrderList from '@/components/OrderList.vue';

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
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
