# Generated by Django 2.2.13 on 2022-01-14 05:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0013_remove_detalleproducto_almacen'),
    ]

    operations = [
        migrations.AddField(
            model_name='detalleproducto',
            name='existenciasB',
            field=models.IntegerField(default=0),
        ),
        migrations.AddField(
            model_name='detalleproducto',
            name='existenciasT',
            field=models.IntegerField(default=0),
        ),
    ]
