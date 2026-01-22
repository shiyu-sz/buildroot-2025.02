
#include "mainwindow.h"

#include <QDebug>
#include <QApplication>
#include <QtWidgets>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    QLabel *label = new QLabel("test");
}

MainWindow::~MainWindow()
{

}
