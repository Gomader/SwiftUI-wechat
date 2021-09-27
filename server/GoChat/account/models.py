from django.db import models
from time import time

# Create your models here.
def getIconPath(instance, filename):
    return "UserInfo/{}/{}.png".format(instance.id,int(time()))

class Account(models.Model):
    id = models.CharField(max_length=20,primary_key=True)
    sex = models.BooleanField(null=True)
    username = models.CharField(max_length=32)
    email = models.EmailField(max_length=254)
    password = models.CharField(max_length=64)
    icon = models.ImageField(upload_to=getIconPath,null=True)

    def __str__(self):
        return self.username

class Friends(models.Model):
    user = models.ForeignKey("account.Account", on_delete=models.CASCADE,related_name="user")
    friend = models.ForeignKey("account.Account", on_delete=models.CASCADE,related_name="friend")
    remark = models.CharField(max_length=32,null=True)
    showMoments = models.BooleanField(default=True)
    watchMoments = models.BooleanField(default=True)
    blacklist = models.BooleanField(default=False)