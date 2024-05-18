from django.db import models

# Create your models here.
class MenuBakso(models.Model):
    nama = models.CharField(max_length=100)
    isi_porsi = models.TextField()
    detail = models.TextField(blank=True, null=True)
    harga = models.DecimalField(max_digits=6, decimal_places=2)

    def __str__(self):
        return self.nama

class MinumanPojokJoyo(models.Model):
    nama = models.CharField(max_length=100)
    detail = models.CharField(max_length=100, blank=True, null=True)
    harga = models.DecimalField(max_digits=6, decimal_places=2)

    def __str__(self):
        return self.nama
    
class OrderList(models.Model):
    STATUS_CHOICES = [
        ('Sedang Diproses', 'Sedang Diproses'),
        ('Diantar Ke Meja', 'Diantar Ke Meja'),
        ('Proses Bungkus Selesai', 'Proses Bungkus Selesai'),
        ('Bersihkan Meja!', 'Bersihkan Meja!'),
        ('Done', 'Done'),
    ]

    nama = models.CharField(max_length=100)
    meja = models.CharField(max_length=100)  # Bisa jadi CharField untuk Meja atau Bungkus
    pesanan = models.CharField(max_length=100)
    detail = models.TextField(blank=True, null=True)
    harga = models.DecimalField(max_digits=6, decimal_places=2)
    status = models.CharField(max_length=25, choices=STATUS_CHOICES, default='Sedang Diproses')

    def __str__(self):
        return f"{self.nama} - {self.pesanan} ({self.status})"