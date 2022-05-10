import 'package:easy_localization/easy_localization.dart';
import 'package:first_project/model/Product.dart';
import 'package:first_project/views/generated/locale_keys.g.dart';
import 'package:first_project/views/overview/data_overview.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/BarData.dart';
import '../../model/Company.dart';
import 'data_overview.dart';
import 'data_overview.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage({Key? key}) : super(key: key);

  static String id = '/OverviewPage';

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage>
    with TickerProviderStateMixin {
  final overviewData = OverviewData();


  @override
  void initState() {
    super.initState();
    overviewData._tabControllerRevenue = TabController(length: 3, vsync: this);
    overviewData._tabControllerBestSeller =
        TabController(length: 2, vsync: this);
    overviewData._infoOverviews = DataOverview().getInfoOverview();
    // _tabControllerRevenue = TabController(length: 3, vsync: this);
    // _tabControllerBestSeller = TabController(length: 2, vsync: this);
    // _infoOverviews = DataOverview().getInfoOverview();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<OverviewData>(
              create: (context) => OverviewData()),
          ChangeNotifierProvider<RevenueProvider>(
              create: (context) => RevenueProvider()),
          ChangeNotifierProvider<BottomSheetProvider>(
              create: (context) => BottomSheetProvider())
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            title: const Text('Công ty'),
          ),
          body: Stack(
            children: [
              buildBackground(),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InfoOverView(),
                      RevenueChart(),
                      DebtCollection(),
                      DebtMustPay(),
                      BestSeller(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildBackground() {
    return Column(
      children: [
        Container(
            height: 50, decoration: const BoxDecoration(color: Colors.green)),
        Expanded(
            child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(color: Colors.black12)))
      ],
    );
  }
}

class InfoOverView extends StatelessWidget {
  const InfoOverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6.0, left: 10.0, bottom: 6.0),
                child: Text(
                  'ĐVT: triệu',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
              Consumer<BottomSheetProvider>(builder: (context, bottomSheetProvider, child) {
                return
                  TextButton(
                    onPressed: () {
                      _showModalBottomSheet(context, bottomSheetProvider);
                    },
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            'Tháng này',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black38,
                          )
                        ],
                      ),
                    ));
              }),
            ],
          ),
          Consumer<OverviewData>(
            builder: (context, overviewData, child) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: overviewData._infoOverviews.length,
                itemBuilder: (context, index) {
                  return InfoOverviewItem(
                    infoOverview: overviewData._infoOverviews[index],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class RevenueChart extends StatelessWidget {
  const RevenueChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          padding: const EdgeInsets.all(16),
          child: Consumer<RevenueProvider>(
            builder: (context, revenueProvider, child) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Doanh thu',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '  (triệu)',
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () {},
                          child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Consumer<BottomSheetProvider>(
                                builder: (context, bottomSheetProvider, child) {
                                  return TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                    ),
                                    onPressed: () {
                                      _showModalBottomSheet(
                                          context, bottomSheetProvider);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          revenueProvider.optionRevenue.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black38,
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    child: DefaultTabController(
                      initialIndex: 1,
                      length: 3,
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Colors.black12,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            padding: const EdgeInsets.all(2),
                            child: TabBar(
                              onTap: (index) {
                                revenueProvider.changeIndexRevenueChart(index);
                              },
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              tabs: <Widget>[
                                Tab(
                                  child: Text(
                                    'Doanh thu',
                                    style: TextStyle(
                                        color:
                                        revenueProvider.indexRevenueChart == 0
                                                ? Colors.black
                                                : Colors.black54,
                                        fontSize: 12),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Chi phí',
                                    style: TextStyle(
                                        color:
                                        revenueProvider.indexRevenueChart == 1
                                                ? Colors.black
                                                : Colors.black54,
                                        fontSize: 12),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Lợi nhuận',
                                    style: TextStyle(
                                        color:
                                        revenueProvider.indexRevenueChart == 2
                                                ? Colors.black
                                                : Colors.black54,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SLBarChart(
                                index: revenueProvider.indexRevenueChart),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}

class DebtCollection extends StatelessWidget {
  const DebtCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Card(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text('Nợ phải thu',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('  (triệu)'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '6',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('TỔNG', style: TextStyle(color: Colors.black54))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('6',
                      style: TextStyle(color: Colors.orange, fontSize: 20)),
                  Text('0', style: TextStyle(color: Colors.black, fontSize: 20))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('QUÁ HẠN', style: TextStyle(color: Colors.black54)),
                  Text('TRONG HẠN', style: TextStyle(color: Colors.black54))
                ],
              ),
              Container(
                height: 20,
                decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DebtMustPay extends StatelessWidget {
  const DebtMustPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Card(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text('Nợ phải trả',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('  (triệu)'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '10',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child:
                        Text('TỔNG', style: TextStyle(color: Colors.black54)),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('10',
                      style: TextStyle(color: Colors.orange, fontSize: 20)),
                  Text('0', style: TextStyle(color: Colors.black, fontSize: 20))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('QUÁ HẠN', style: TextStyle(color: Colors.black54)),
                  Text('TRONG HẠN', style: TextStyle(color: Colors.black54))
                ],
              ),
              Container(
                height: 20,
                decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SLBarChart extends StatelessWidget {
  const SLBarChart({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.3,
        child: Consumer<RevenueProvider>(
          builder: (context, revenueProvider, child) {
            return BarChart(
              BarChartData(
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    drawBehindEverything: true,
                    sideTitles: SideTitles(
                      showTitles: false,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Color(0xFF606060),
                          ),
                          textAlign: TextAlign.left,
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    drawBehindEverything: true,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Color(0xFF606060),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(),
                  topTitles: AxisTitles(),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.black12,
                    dashArray: null,
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                  border: const Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                alignment: BarChartAlignment.spaceAround,
                backgroundColor: Colors.white,
                maxY: 20,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.orange,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        rod.toY.toString(),
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      );
                    },
                  ),
                  allowTouchBarBackDraw: true,
                  touchCallback: (event, response) {
                    print('touch');
                    if (event.isInterestedForInteractions &&
                        response != null &&
                        response.spot != null) {
                      revenueProvider.updateTouchedGroupIndex(
                          response.spot!.touchedBarGroupIndex);
                      print(revenueProvider.touchedGroupIndex);
                    }
                  },
                ),
                barGroups: DataOverview()
                    .getBarChartData(index)
                    .asMap()
                    .entries
                    .map((e) {
                  final index = e.key;
                  final data = e.value;
                  return generateBarGroup(index, data.value, revenueProvider);
                }).toList(),
              ),
            );
          },
        ));
  }
}

class BestSeller extends StatelessWidget {
  const BestSeller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8, bottom: 20),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          child: Consumer<OverviewData>(
            builder: (context, overviewData, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Mặt hàng bán chạy',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        ' (triệu)',
                      ),
                      Consumer<BottomSheetProvider>(
                          builder: (context, bottomSheetProvider, child) {
                        return TextButton(
                            onPressed: () {
                              _showModalBottomSheet(
                                  context, bottomSheetProvider);
                            },
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Tháng này',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black38,
                                  )
                                ],
                              ),
                            ));
                      }),
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    child: DefaultTabController(
                      initialIndex: 1,
                      length: 2,
                      child: Column(
                        children: [
                          Container(
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Colors.black12,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            padding: const EdgeInsets.all(2),
                            child: TabBar(
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              tabs: const <Widget>[
                                Tab(
                                  child: Text(
                                    'Doanh thu',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Số lượng',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: <Widget>[
                                SizedBox(
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: overviewData
                                        ._bestRevenueProducts.length,
                                    itemBuilder: (context, index) {
                                      return BestSellerItem(
                                          product: overviewData
                                              ._bestRevenueProducts[index]);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: overviewData
                                        ._bestRevenueProducts.length,
                                    itemBuilder: (context, index) {
                                      return BestSellerItem(
                                          product: overviewData
                                              ._bestRevenueProducts[index]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

void _showModalBottomSheet(
    BuildContext context, BottomSheetProvider bottomSheetProvider) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        width: double.infinity,
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: bottomSheetProvider._optionTimes.length,
          itemBuilder: (context, index) {
            return OptionTimeItem(
              optionTime: bottomSheetProvider._optionTimes[index],
              buildContext: context,
            );
          },
        ),
      );
    },
  );
}

BarChartGroupData generateBarGroup(
    int x, double value, RevenueProvider revenueProvider) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        borderSide: BorderSide(
            width: 2,
            color: x == revenueProvider.touchedGroupIndex
                ? Colors.orange
                : Colors.black26),
        toY: value,
        color: Colors.green,
        width: 15,
      ),
    ],
    showingTooltipIndicators: revenueProvider.touchedGroupIndex == x ? [0] : [1],
  );
}

class BestSellerItem extends StatelessWidget {
  const BestSellerItem({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              product.stt.toString(),
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        child: Text(product.name),
                        margin: const EdgeInsets.only(left: 8))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(product.amount.toString()),
                    Text(product.description)
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black12,
            height: 1,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

class InfoOverviewItem extends StatelessWidget {
  const InfoOverviewItem({Key? key, required this.infoOverview})
      : super(key: key);
  final InfoOverview infoOverview;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(infoOverview.title),
                Text(
                  infoOverview.value.toString(),
                  style: TextStyle(
                      color: infoOverview.type == 4 || infoOverview.type == 3
                          ? Colors.blue
                          : Colors.black),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Visibility(
              visible: infoOverview.type == 3 ? false : true,
              child: Container(
                color: Colors.black12,
                height: 1,
                width: double.infinity,
              )),
        )
      ],
    );
  }
}

class OptionTimeItem extends StatelessWidget {
  const OptionTimeItem(
      {Key? key, required this.optionTime, required this.buildContext})
      : super(key: key);
  final OptionTime optionTime;
  final BuildContext buildContext;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(buildContext).pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            optionTime.name,
            style: const TextStyle(color: Colors.black),
          ),
        ));
  }
}

class OverviewData with ChangeNotifier {
  late TabController _tabControllerRevenue;
  late TabController _tabControllerBestSeller;
  late List<InfoOverview> _infoOverviews = DataOverview().getInfoOverview();
  late final List<Product> _bestRevenueProducts = DataOverview().getListBestSellerProduct();
}

class RevenueProvider with ChangeNotifier {
  var indexRevenueChart = -1;
  var touchedGroupIndex = -1;
  var optionRevenue = OptionTime(
    name: 'Tháng này',
  );

  void changeIndexRevenueChart(int index) {
    indexRevenueChart = index;
    notifyListeners();
  }

  void updateTouchedGroupIndex(int index) {
    touchedGroupIndex = index;
    notifyListeners();
  }
}

class BestSellerProvider with ChangeNotifier {
  late final List<Product> _bestRevenueProducts =
      DataOverview().getListBestSellerProduct();
}

class BottomSheetProvider with ChangeNotifier {
  late final List<OptionTime> _optionTimes = DataOverview().getOptionTimes();
}
