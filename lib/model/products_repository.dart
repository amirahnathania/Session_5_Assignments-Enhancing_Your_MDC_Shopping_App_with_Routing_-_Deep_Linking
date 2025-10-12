// Copyright 2018-present the Flutter authors. All Rights Reserved.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'product.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    const allProducts = <Product>[
      Product(
        category: Category.NCT,
        id: 0,
        isFeatured: true,
        name: 'Lee Jeno',
        price: 15000,
        assetName: 'assets/Kpop/Jeno.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 1,
        isFeatured: true,
        name: 'Mark Lee',
        price: 15000,
        assetName: 'assets/Kpop/Mark.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 2,
        isFeatured: false,
        name: 'Na Jaemin',
        price: 15000,
        assetName: 'assets/Kpop/Jaemin.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 3,
        isFeatured: true,
        name: 'Huang Renjun',
        price: 15000,
        assetName: 'assets/Kpop/Renjun.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 4,
        isFeatured: false,
        name: 'Zhong Chenle',
        price: 15000,
        assetName: 'assets/Kpop/Chenle.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 5,
        isFeatured: false,
        name: 'Lee Jisung',
        price: 15000,
        assetName: 'assets/Kpop/Jisung.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 6,
        isFeatured: false,
        name: 'Lee Haechan',
        price: 15000,
        assetName: 'assets/Kpop/Haechan.jpg',
      ),
      Product(
        category: Category.BTS,
        id: 7,
        isFeatured: true,
        name: 'Grup BTS',
        price: 25000,
        assetName: 'assets/Kpop/GrupBTS.jpg',
      ),
      Product(
        category: Category.BTS,
        id: 8,
        isFeatured: true,
        name: 'RM BTS',
        price: 15000,
        assetName: 'assets/Kpop/RM.jpg',
      ),
      Product(
        category: Category.BTS,
        id: 9,
        isFeatured: true,
        name: 'J-Hope BTS',
        price: 15000,
        assetName: 'assets/Kpop/J-Hope.jpg',
      ),
      Product(
        category: Category.BTS,
        id: 10,
        isFeatured: false,
        name: 'Suga BTS',
        price: 15000,
        assetName: 'assets/Kpop/Suga.jpg',
      ),
      Product(
        category: Category.BTS,
        id: 11,
        isFeatured: false,
        name: 'Jin BTS',
        price: 15000,
        assetName: 'assets/Kpop/Jin.jpg',
      ),
      Product(
        category: Category.BTS,
        id: 12,
        isFeatured: false,
        name: 'Taehyung BTS',
        price: 15000,
        assetName: 'assets/Kpop/Taehyung.jpg',
      ),
      Product(
        category: Category.BTS,
        id: 13,
        isFeatured: true,
        name: 'Jungkook BTS',
        price: 15000,
        assetName: 'assets/Kpop/Jungkook.jpg',
      ),
      Product(
        category: Category.BTS,
        id: 14,
        isFeatured: true,
        name: 'Jimin BTS',
        price: 15000,
        assetName: 'assets/Kpop/Jimin.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 15,
        isFeatured: true,
        name: 'NCT Dream',
        price: 25000,
        assetName: 'assets/Kpop/NCTDream.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 16,
        isFeatured: true,
        name: 'NCT 127',
        price: 25000,
        assetName: 'assets/Kpop/NCT127.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 17,
        isFeatured: false,
        name: 'Moon Tae-il',
        price: 15000,
        assetName: 'assets/Kpop/Taeil.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 18,
        isFeatured: true,
        name: 'Kim Dong-young',
        price: 15000,
        assetName: 'assets/Kpop/Doyoung.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 19,
        isFeatured: false,
        name: 'Lee Tae-yong',
        price: 15000,
        assetName: 'assets/Kpop/Taeyong.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 20,
        isFeatured: false,
        name: 'Yuta Nakamoto',
        price: 15000,
        assetName: 'assets/Kpop/Yuta.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 21,
        isFeatured: false,
        name: 'Jeong Yun-o,',
        price: 15000,
        assetName: 'assets/Kpop/Jaehyun.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 22,
        isFeatured: false,
        name: 'Kim Jungwoo',
        price: 15000,
        assetName: 'assets/Kpop/Jungwoo.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 23,
        isFeatured: false,
        name: 'Winwin',
        price: 15000,
        assetName: 'assets/Kpop/Winwin.jpg',
      ),
      Product(
        category: Category.NCT,
        id: 24,
        isFeatured: true,
        name: 'Seo Young-ho',
        price: 15000,
        assetName: 'assets/Kpop/Johnny.jpg',
      ),
      Product(
        category: Category.Wayv,
        id: 25,
        isFeatured: false,
        name: 'GrupWayV',
        price: 25000,
        assetName: 'assets/Kpop/Wayv.jpg',
      ),
      Product(
        category: Category.Wayv,
        id: 26,
        isFeatured: false,
        name: 'Ten',
        price: 15000,
        assetName: 'assets/Kpop/Ten.jpg',
      ),
      Product(
        category: Category.Wayv,
        id: 27,
        isFeatured: true,
        name: 'Xiao Dejun',
        price: 15000,
        assetName: 'assets/Kpop/Xiaojun.jpg',
      ),
      Product(
        category: Category.Wayv,
        id: 28,
        isFeatured: true,
        name: 'Huang Guanheng/Hendery',
        price: 15000,
        assetName: 'assets/Kpop/Hendery.jpg',
      ),
      Product(
        category: Category.Wayv,
        id: 29,
        isFeatured: true,
        name: 'Yangyang',
        price: 15000,
        assetName: 'assets/Kpop/Yangyang.jpg',
      ),
      Product(
        category: Category.Wayv,
        id: 30,
        isFeatured: true,
        name: 'Qian Kun',
        price: 15000,
        assetName: 'assets/Kpop/Kun.jpg',
      ),
      Product(
        category: Category.Wayv,
        id: 31,
        isFeatured: false,
        name: 'Lucas Wong',
        price: 15000,
        assetName: 'assets/Kpop/Lucas.jpg',
      ),
      Product(
        category: Category.TXT,
        id: 32,
        isFeatured: false,
        name: 'TXT',
        price: 25000,
        assetName: 'assets/Kpop/TXT.jpg',
      ),
      Product(
        category: Category.TXT,
        id: 33,
        isFeatured: true,
        name: 'Choi Yeon-jun ',
        price: 15000,
        assetName: 'assets/Kpop/Yeonjun.jpg',
      ),
      Product(
        category: Category.TXT,
        id: 34,
        isFeatured: false,
        name: 'Choi Soobin',
        price: 15000,
        assetName: 'assets/Kpop/Soobin.jpg',
      ),
      Product(
        category: Category.TXT,
        id: 35,
        isFeatured: false,
        name: 'Choi Beomgyu',
        price: 15000,
        assetName: 'assets/Kpop/Beomgyu.jpg',
      ),
      Product(
        category: Category.TXT,
        id: 36,
        isFeatured: false,
        name: 'Hueningkai',
        price: 15000,
        assetName: 'assets/Kpop/Heuningkai.jpg',
      ),
      Product(
        category: Category.TXT,
        id: 37,
        isFeatured: true,
        name: 'Kang Tae-hyun',
        price: 15000,
        assetName: 'assets/Kpop/Taehyun.jpg',
      ),
    ];
    if (category == Category.all) {
      return allProducts;
    } else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }
}
