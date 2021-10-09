from apscheduler.schedulers.background import BackgroundScheduler
from django_apscheduler.jobstores import DjangoJobStore, register_events, register_job
from account import models as account_models
from django.db.models import Q
from datetime import datetime

scheduler = BackgroundScheduler()
scheduler.add_jobstore(DjangoJobStore(), "modelsTask")
@register_job(scheduler,"interval", seconds=60)
def modelsTask():
    account_models.FriendApplication.objects.filter(Q(expire_date__lte=datetime.today())).delete()
register_events(scheduler)
scheduler.start()