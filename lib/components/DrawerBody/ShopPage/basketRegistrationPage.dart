import 'package:flutter/material.dart';
import 'package:flutter_coursework_fitness_club/HTTP_Connections/http_model.dart';
import 'package:sizing/sizing.dart';
import '../../../Animation/anim.dart';
import '../../../Models/ShopClasses.dart';
import '../../RadioButton/myRadioListTitle.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BasketRegistrationPage extends StatefulWidget {
  const BasketRegistrationPage(
      {super.key,
      required this.listBasket,
      required this.setStateBasket,
      required this.listShopOrders});
  final List<BasketFullInfo?> listBasket;
  final ValueGetter<List<ShopOrderFullInfo>?>? listShopOrders;
  final void Function(int idOrder) setStateBasket;
  @override
  State<BasketRegistrationPage> createState() => _BasketRegistrationPageState();
}

class _BasketRegistrationPageState extends State<BasketRegistrationPage> {
  int _valueRadio = 1;
  double priceSelectedItem = 0;
  int cntItem = 0;

  @override
  void initState() {
    for (var i in widget.listBasket) {
      priceSelectedItem += i!.shopItemCount! * i.item_Price!;
      cntItem += i.shopItemCount!;
    }
    asyncInitState();
    super.initState();
  }

  Future<void> asyncInitState() async {
    await ApiService.GetNewConnectionOrderStatus();
    initSession();
  }

  void ShowToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)));
  }

  void initSession() async {
    await ApiService.hubConnectionOrderStatus
        .on("GetStatus", _handleAClientProvidedFunction);
  }

  void _handleAClientProvidedFunction(var parameters) {
    ShopOrderFullInfo basketStatus = ShopOrderFullInfo.fromJson(parameters[0]);

    if (ApiService.user.id_User == basketStatus.user_id) {
      widget.listShopOrders!
          .call()![widget.listShopOrders!.call()!.indexOf(widget.listShopOrders!
              .call()!
              .where((x) => x.id_Order == basketStatus.id_Order)
              .first)]
          .orderStatus_Name = basketStatus.orderStatus_Name;
      widget.listShopOrders!
          .call()![widget.listShopOrders!.call()!.indexOf(widget.listShopOrders!
              .call()!
              .where((x) => x.id_Order == basketStatus.id_Order)
              .first)]
          .orderStatus_id = basketStatus.orderStatus_id;
      if (basketStatus.orderStatus_id == 2 ||
          basketStatus.orderStatus_id == 1) {
        Navigator.pop(context);
        Navigator.pop(context);
        ShowToast("Заказ оплачен, ожидает подтверждения!");
      }
    }
  }

  getController(var url) {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('${url}')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('${url}'));
  }

  String? sUrl;

  @override
  bool isPlaced = false;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 28),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 55, 92),
          title: const Text("Оформление заказа")),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: OutlinedButton(
              onPressed: !isPlaced
                  ? () async {
                      var answer =
                          await ApiService().PostShopOrder(widget.listBasket);
                      widget.listShopOrders!.call()!.add(answer!);
                      widget.setStateBasket(answer.id_Order!);
                      sUrl = answer.paymentUri;
                      // ignore: use_build_context_synchronously
                      await Navigator.of(context)
                          .push(Animations().createRoute(Scaffold(
                        appBar: AppBar(
                          title: Text("Страница оплаты заказа"),
                          backgroundColor: Color.fromARGB(255, 28, 55, 92),
                        ),
                        body: WebViewWidget(
                            controller: getController(answer.paymentUri)),
                      )));
                      setState(() {
                        isPlaced = true;
                      });
                    }
                  : () {
                      Navigator.of(context)
                          .push(Animations().createRoute(Scaffold(
                        appBar: AppBar(
                          title: Text("Страница оплаты заказа"),
                          backgroundColor: Color.fromARGB(255, 28, 55, 92),
                        ),
                        body: WebViewWidget(controller: getController(sUrl)),
                      )));
                    },
              style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 28, 55, 92),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              child: Text(
                !isPlaced ? "Оформить заказ" : "Вернуться на страницу оплаты",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.fss,
                  color: const Color.fromARGB(255, 149, 178, 218),
                  fontFamily: 'MontserratBold',
                ),
              )),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Товары в заказе",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17.fss,
                  fontFamily: 'MontserratBold',
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ClipRRect(
              borderRadius: new BorderRadius.all(Radius.circular(25)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.155,
                decoration: new BoxDecoration(
                  color: Color.fromARGB(255, 54, 54, 54),
                  border: Border.all(
                      color: Color.fromARGB(255, 101, 101, 101), width: 2),
                  borderRadius: new BorderRadius.all(Radius.circular(25)),
                ),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: widget.listBasket.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(5),
                        child:
                            Stack(alignment: Alignment.bottomRight, children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(60),
                              child: Image.network(
                                  '${widget.listBasket[index]!.image_URL}',
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.14,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 41, 41, 41),
                              border: Border.all(
                                  color: Color.fromARGB(255, 101, 101, 101),
                                  width: 2),
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(25.0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                '${widget.listBasket[index]!.shopItemCount} шт.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.fss,
                                  fontFamily: 'MontserratBold',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      );
                    }),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Divider(
                  color: Color.fromARGB(255, 56, 124, 220),
                  thickness: 2,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Способ оплаты",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17.fss,
                  fontFamily: 'MontserratBold',
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              decoration: new BoxDecoration(
                color: Color.fromARGB(255, 54, 54, 54),
                border: Border.all(
                    color: Color.fromARGB(255, 101, 101, 101), width: 2),
                borderRadius: new BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Padding(
                padding: EdgeInsets.all(7),
                child: Column(
                  children: [
                    MyRadioListTile<int>(
                      value: 1,
                      groupValue: _valueRadio,
                      title: Text(
                        'Оплата при получении (Наличные)',
                        style: TextStyle(
                          fontSize: 16.fss,
                          fontFamily: 'MontserratLight',
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) =>
                          setState(() => _valueRadio = value!),
                    ),
                    MyRadioListTile<int>(
                      value: 2,
                      groupValue: _valueRadio,
                      title: Text(
                        'Оплата при получении (Картой)',
                        style: TextStyle(
                          fontSize: 16.fss,
                          fontFamily: 'MontserratLight',
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) =>
                          setState(() => _valueRadio = value!),
                    ),
                    MyRadioListTile<int>(
                      value: 3,
                      groupValue: _valueRadio,
                      title: Text(
                        'Оплата онлайн (ЮКаssa)',
                        style: TextStyle(
                          fontSize: 16.fss,
                          fontFamily: 'MontserratLight',
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) =>
                          setState(() => _valueRadio = value!),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "${cntItem} товара на сумму",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15.fss,
                  fontFamily: 'MontserratBold',
                  color: Color.fromARGB(255, 180, 180, 180),
                ),
              ),
              Text(
                ". . . . . . . . . . .",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18.fss,
                  fontFamily: 'MontserratBold',
                  color: Color.fromARGB(255, 180, 180, 180),
                ),
              ),
              Text(
                "${double.parse((priceSelectedItem).toStringAsFixed(2))}₽",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 15.fss,
                  fontFamily: 'MontserratBold',
                  color: Color.fromARGB(255, 180, 180, 180),
                ),
              ),
            ]),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Итог",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18.fss,
                  fontFamily: 'MontserratBold',
                  color: Colors.white,
                ),
              ),
              Text(
                ". . . . . . . . . . . . . . . . . . . . .",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18.fss,
                  fontFamily: 'MontserratBold',
                  color: Color.fromARGB(255, 180, 180, 180),
                ),
              ),
              Text(
                "${double.parse((priceSelectedItem).toStringAsFixed(2))}₽",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18.fss,
                  fontFamily: 'MontserratBold',
                  color: Colors.white,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
