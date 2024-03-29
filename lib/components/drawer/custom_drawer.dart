import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';
import 'bottom_user_info.dart';
import 'custom_list_tile.dart';
import 'header.dart';

class CustomDrawer extends StatefulWidget {
  final void Function(int, int) callback;
  const CustomDrawer({Key? key, required this.callback}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 500),
        width: _isCollapsed ? 300 : 70,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Color.fromRGBO(20, 20, 20, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDrawerHeader(isColapsed: _isCollapsed),
              const Divider(
                color: Colors.grey,
              ),
              InkWell(
                child: CustomListTile(
                  isCollapsed: _isCollapsed,
                  icon: Icons.home_outlined,
                  title: 'Главная',
                  infoCount: 0,
                ),
                onTap: () {
                  widget.callback(0, 0);
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.grey),
              InkWell(
                child: CustomListTile(
                  isCollapsed: _isCollapsed,
                  icon: Icons.calendar_today,
                  title: 'Расписание',
                  infoCount: 0,
                ),
                onTap: () {
                  widget.callback(1, 1);
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.grey),
              InkWell(
                child: CustomListTile(
                  isCollapsed: _isCollapsed,
                  icon: Icons.assignment_turned_in_outlined,
                  title: 'Мои занятия',
                  infoCount: 0,
                ),
                onTap: () {
                  widget.callback(2, 2);
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.grey),
              InkWell(
                child: CustomListTile(
                  isCollapsed: _isCollapsed,
                  icon: Icons.people_alt_outlined,
                  title: 'Тренера',
                  infoCount: 0,
                ),
                onTap: () {
                  widget.callback(3, 3);
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.grey),
              InkWell(
                child: CustomListTile(
                  isCollapsed: _isCollapsed,
                  icon: Icons.shopping_basket_outlined,
                  title: 'Магазин',
                  infoCount: 0,
                ),
                onTap: () {
                  widget.callback(4, 4);
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              //-------------------------------bottom
              const SizedBox(height: 10),
              BottomUserInfo(isCollapsed: _isCollapsed),
              Align(
                alignment: _isCollapsed
                    ? Alignment.bottomRight
                    : Alignment.bottomCenter,
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    _isCollapsed
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18.ss,
                  ),
                  onPressed: () {
                    setState(() {
                      _isCollapsed = !_isCollapsed;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
