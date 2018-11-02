# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2018-11-02 00:13
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('gameplay', '0003_auto_20181101_1730'),
    ]

    operations = [
        migrations.AlterField(
            model_name='move',
            name='by_first_player',
            field=models.BooleanField(editable=False),
        ),
        migrations.AlterField(
            model_name='move',
            name='game',
            field=models.ForeignKey(editable=False, on_delete=django.db.models.deletion.CASCADE, to='gameplay.Game'),
        ),
    ]