from django.db import models
from time import time

# Create your models here.
def getIconPath(instance, filename):
    return "UserInfo/{}/{}.jpg".format(instance.id.code,int(time()))

class Account(models.Model):
    id = models.AutoField(primary_key=True)
    sex = models.BooleanField(null=True)
    username = models.CharField(max_length=32)
    email = models.EmailField(max_length=254)
    password = models.CharField(max_length=64)
    icon = models.ImageField(upload_to=getIconPath,null=True)

    def __str__(self):
        return self.username

    