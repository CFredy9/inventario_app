# Generated by Django 2.2.13 on 2022-01-14 05:39

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0012_auto_20220113_2338'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='detalleproducto',
            name='almacen',
        ),
    ]
