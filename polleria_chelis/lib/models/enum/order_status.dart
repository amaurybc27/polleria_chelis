import 'package:flutter/material.dart';

import '../../app/commons/app_theme.dart';

enum OrderStatus { PENDING, ATTENDED, SENT, DELIVERED, CANCELLED }

extension OrderStatusExtension on OrderStatus {

  String get status {
    switch (this) {
      case OrderStatus.PENDING:
        return 'Pendiente';
      case OrderStatus.ATTENDED:
        return 'Atendido';
      case OrderStatus.SENT:
        return 'Enviado';
      case OrderStatus.DELIVERED:
        return 'Entregado';
      case OrderStatus.CANCELLED:
        return 'Cancelado';
      default:
        return 'NA';
    }
  }

  static OrderStatus fromString(String value){
    switch (value) {
      case 'Pendiente':
        return OrderStatus.PENDING;
      case 'Atendido':
        return OrderStatus.ATTENDED;
      case 'Enviado':
        return OrderStatus.SENT;
      case 'Entregado':
        return OrderStatus.DELIVERED;
      case 'Cancelado':
        return OrderStatus.CANCELLED;
      default:
        return OrderStatus.PENDING;
    }
  }

  static Icon getIconFromOrderStatus(String value){
    switch (value) {
      case 'Pendiente':
        return Icon(Icons.access_time_filled, color: AppTheme.warningColor);
      case 'Atendido':
        return Icon(Icons.access_time_filled, color: AppTheme.successColor);
      case 'Enviado':
        return Icon(Icons.access_time_filled, color: AppTheme.facebookColor);
      case 'Entregado':
        return Icon(Icons.access_time_filled, color: AppTheme.successColor);
      case 'Cancelado':
        return Icon(Icons.access_time_filled, color: AppTheme.errorColor);
      default:
        return Icon(Icons.access_time_filled, color: AppTheme.warningColor);
    }
  }

  static Color getOrderStatusColor(OrderStatus value){
    switch (value) {
      case OrderStatus.PENDING:
        return AppTheme.warningColor;
      case OrderStatus.ATTENDED:
        return AppTheme.successColor;
      case OrderStatus.SENT:
        return AppTheme.facebookColor;
      case OrderStatus.DELIVERED:
        return AppTheme.successColor;
      case OrderStatus.CANCELLED:
        return AppTheme.errorColor;
      default:
        return AppTheme.warningColor;
    }
  }
}