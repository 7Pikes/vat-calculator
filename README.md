# Vat::Calculator

__Рассчет всяческих штук__

В ролях:
- Производителя Цена
- Реализации Цена
- Штук Количество
- Николай Демидович Сусликов(aka НДС)

## Использование

Для использования в модели вызываем метод `has_vat_calculator` и пользуемся
```ruby
class InvoicePosition < ActiveRecord::Base
  has_vat_calculator
end
```
```ruby
ip = InvoicePositions.last
ip.sum_of_vat_for :supplier_price
ip.sum_of_vat_for :selling_price
# так же доступны методы sum_with_vat_for и sum_without_vat_for
```
Также если поля модели не соответствуют стандартным supplier_price, selling_price, vat и amount можно передать параметром какие поля использовать
```ruby
has_vat_calculator :selling_price => :price, :supplier_price => :manufacturer_price, :vat => :nds, :amount => :quantity
# параметры необязательны и можно указать только те, которые необходимы
```
По умолчанию все рассчеты выполняются с учетом количества, если необходимо обратное, то указываем это при подключении
```ruby
has_vat_calculator :with_amount => false
```
Также можно использовать параметр при вызове метода на экземпляре класса
```ruby
ip.sum_of_vat_for :supplier_price, :with_amount => false
```