from django.db import models
from django.contrib.postgres.fields import ArrayField

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

class PorsiDetail(models.Model):
    order = models.ForeignKey('OrderList', related_name='porsi_details', on_delete=models.CASCADE)
    nama = models.CharField(max_length=100)
    kuah = models.CharField(max_length=50, blank=True, null=True)
    details = models.TextField(blank=True, default='[]')
    lainnya = models.CharField(max_length=100, blank=True, null=True)

    def save(self, *args, **kwargs):
        if isinstance(self.details, list):
            self.details = json.dumps(self.details)
        super(PorsiDetail, self).save(*args, **kwargs)

    def get_details(self):
        return json.loads(self.details)

class OrderList(models.Model):
    STATUS_CHOICES = [
        ('Sedang Diproses', 'Sedang Diproses'),
        ('Diantar Ke Meja', 'Diantar Ke Meja'),
        ('Proses Bungkus Selesai', 'Proses Bungkus Selesai'),
        ('Bersihkan Meja!', 'Bersihkan Meja!'),
        ('Done', 'Done'),
    ]

    nama = models.CharField(max_length=100)
    meja = models.CharField(max_length=100)
    harga = models.DecimalField(max_digits=6, decimal_places=2)
    pilihan = models.CharField(max_length=50, default='makan_sini')
    status = models.CharField(max_length=25, choices=STATUS_CHOICES, default='Sedang Diproses')
    ip_address = models.GenericIPAddressField(null=True, blank=True)

    def __str__(self):
        return f"{self.nama} - {self.meja} ({self.status})"
