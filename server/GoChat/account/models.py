from django.db import models

# Create your models here.
def getIconPath(instance, filename):
    return "UserInfo/{}/icon.png".format(instance.id)

class Account(models.Model):
    id = models.CharField(max_length=20,primary_key=True)
    sex = models.NullBooleanField(null=True)
    username = models.CharField(max_length=32)
    email = models.EmailField(max_length=254)
    password = models.CharField(max_length=64)
    icon = models.ImageField(upload_to=getIconPath,null=True)

    def __str__(self):
        return self.username

class FriendApplication(models.Model):
    applicant = models.ForeignKey("account.Account", related_name="applicant",on_delete=models.CASCADE)
    receiver = models.ForeignKey("account.Account", related_name="receiver",on_delete=models.CASCADE)
    create_time = models.DateTimeField(auto_now=False, auto_now_add=True)
    expire_date = models.DateTimeField(auto_now=False, auto_now_add=False)