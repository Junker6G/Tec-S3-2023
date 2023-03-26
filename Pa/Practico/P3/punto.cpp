//
// Created by jsell on 23/3/2023.
//
#include "iostream"
#include "math.h"
using namespace std;

class punto{
private:
    int x;
    int y;

public:
    punto();
    punto(int x, int y);
    ~punto();
    void setX(int foo);
    void setY(int foo);
    int getX();
    int getY();
};

punto::punto() {
    this->x = 0;
    this->y = 0;
}

punto::~punto() {
    cout << "Adeus" << endl;
}

punto::punto(int x, int y) {
    this->x = x;
    this->y = y;
}

void punto::setX(int foo) {
    this->x = foo;
}

void punto::setY(int foo) {
    this->y = foo;
}

int punto::getX() {
    return this->x;
}

int punto::getY() {
    return this->y;
}

class segmento{
private:
    punto * p1;
    punto * p2;

public:
    segmento(punto * pts1, punto * pts2);
    ~segmento();
    int getLong(punto * p1, punto * p2);
    void imprimir();
};

segmento::segmento(punto *pts1, punto *pts2) {
    this->p1 = pts1;
    this->p2 = pts2;
}

segmento::~segmento() {
    cout << "adeus segment" << endl;
}

int segmento::getLong(punto *p1, punto *p2) {
    int catA = p1->getX() - p2->getX();
    int catO = p1->getY() - p2->getY();

    int res = sqrt((catA * catA) + (catO * catO));
    return res;
}

void segmento::imprimir() {
    cout << "La longitud del segmento es de -> " << this->getLong(p1, p2) << endl;
}

int main (){

    punto * pi = new punto(5, 15);
    punto * pf = new punto(15, 14);

    segmento * seg = new segmento(pi, pf);

    seg->imprimir();

    return 0;
}