import 'package:flutter/material.dart';
import 'package:flutterdemo/common/LogUtil.dart';

const _tag = "ShareRoute";

enum Event {
  first,
  second,
  third,
}

class InheritedProvider<T> extends InheritedWidget {
  final T data;

  InheritedProvider({required this.data, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedProvider<T> oldWidget) {
    logI(_tag, "InheritedProvider updateShouldNotify");
    return true;
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final T data;
  final Widget child;

  ChangeNotifierProvider({Key? key, required this.data, required this.child});

  @override
  State<StatefulWidget> createState() {
    return _ChangeNotifierProviderState<T>();
  }

  static T of<T>(BuildContext context, {bool listener = true}) {
    InheritedProvider<T>? provider = listener
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
            ?.widget as InheritedProvider<T>?;
    return provider!.data;
  }
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void onUpdate() {
    logI(_tag, "_ChangeNotifierProviderState onUpdate");
    setState(() {});
  }

  @override
  void initState() {
    logI(_tag, "_ChangeNotifierProviderState initState");
    widget.data.addListener(onUpdate);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    logI(_tag, "_ChangeNotifierProviderState didUpdateWidget");
    if (oldWidget.data != widget.data) {
      oldWidget.data.removeListener(onUpdate);
      widget.data.addListener(onUpdate);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    logI(_tag, "_ChangeNotifierProviderState dispose");
    widget.data.removeListener(onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logI(_tag, "_ChangeNotifierProviderState build");
    return InheritedProvider<T>(data: widget.data, child: widget.child);
  }
}

class Book {
  double price = 0;
  int count = 0;

  Book(this.price, this.count);

  @override
  String toString() {
    return "Book{price: $price, count: $count}";
  }
}

class BooksModel extends ChangeNotifier {
  final List<Book> _books = [];

  double getTotalPrice() =>
      _books.fold(0, (value, item) => value + item.price * item.count);

  void addBook(Book book) {
    logI(_tag, "addBook  $book");
    _books.add(book);
    notifyListeners();
  }
}

class ShareTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShareTestState();
  }
}

class _ShareTestState extends State<ShareTestRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ShareTestRoute"),
      ),
      body: Center(
        child: ChangeNotifierProvider<BooksModel>(
          data: BooksModel(),
          child: Builder(
            builder: (context) {
              logI(_tag, "_ShareTestState build");
              return Column(
                children: [
                  StatefulBuilder(builder: (context,_state) {
                    logI(_tag, "price build");
                    var bookModel =
                        ChangeNotifierProvider.of<BooksModel>(context);
                    return Text("总价: ${bookModel.getTotalPrice()}");
                  }),
                  Builder(builder: (context) {
                    logI(_tag, "ElevatedButton build");
                    return ElevatedButton(
                        onPressed: () {
                          ChangeNotifierProvider.of<BooksModel>(context,listener: false)
                              .addBook(Book(10, 2));
                        },
                        child: Text("添加商品"));
                  })
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
