Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.1.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674858;
	b=at24Nv/Csgy1HJWDMlSwMQmARxi8UjLfNw5aPT+jLUFFojJYpnQwvB8h7lVaqq0Bmc9w
	 IJc9SLVhxPHQGN7d6NssxzvRdDAqn6aTHELH6ckiN9uVdDY+PybhP//YE0EVnbB0jBna4
	 oVcp3LpxOskbjcVWN2LXLJafIsPZe38X8UMt61cW8Sj/B3cLt0CuHROxbnFU6zkDP+y0D
	 J2DnuSOUDAQNcYjbkZ6uNTTo6e8ygk1No0aAm6y57HTzxnNhA92rhQglAMjMyFkqHFPuP
	 /qaxNq+KtO2DHoaBMgHqqw22sOhzWG/iho2OAnPEXjZZsofSQYiU5Fb3Gb4nNQdcMnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674858;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xqUtBSLqb2Pww7c+fQZDsrm8Y66MoDBwLzEoEzexPps=;
	b=f76hI1n2qtiHPSB8R9wYE6Jh/PNExBiVVcxaU3jM4f49uU2m1zquqIwZv+pzU/kAQQfp
	 em15jT6TfeNmrc3nvXslbshzVjMg8wbOiN0BOgoQIAJy6tq3kBpxdCIYzGvLgz8OWQmYO
	 Svj6TtmMJHyDWqlhq0u0X6R9wGwU+JRwqBgJHuvFDjQNj1KQesZlDttXCm6b1bSEFxhcV
	 xbHv2iBpoBal0h8ovrpz2Af5xJmH5SDCzwYA2oE5T9jmC4xfESeoAVxGU3vXhgTG3KAX1
	 YXcdjxIy7roPSK4WpDK0Uz47GGGaHc0HiBVO68P42Zd8DqEiA/hcZVBzbxQzKRieBxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=thyDUET0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.1.12
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011012.outbound.protection.outlook.com [52.103.1.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CFB606A32C;
	Thu, 26 Nov 2026 06:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8CFB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=thyDUET0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miFj9JDPAE/u59UmPQoaQPcOj+Ben3lONYIU3a5DqTBYzkGbngmHOeiD70aDp9zSleIHT3A2LnDj5OTYXtg0R8hphFF1+E/zC/5SFbqWIqcsFw6LkavaCDdLgTMGUXVuLK/b36oap02uRi/MGaEjRTrGqtaWVrwxFHO+yI94BhLrib4LEq9isoDkVb8stlkRNOSTtYpyeMt2+8CyBLUg52Ff7rfaE/aWTchnlqIQ5HUzBv7RqEcjyaMWmf/LWqw9g8hZKb8oMps8gfKdthNf5MFeectlXTiXn4GemNt5dsrFN36TN8QrKQoam2jBpq1yyhGjkvE7WTqf4fEdqCnyTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=xqUtBSLqb2Pww7c+fQZDsrm8Y66MoDBwLzEoEzexPps=;
 b=WUvzeXn59iNbdx/vxfb62a3gg9dAlKkoK489ny0GZwLyEMyLCFVc31CPO5Pp1IrSm8qJvqZTJ/wgrN4rVmBkEarCOkA6VXBVtZxH2XaiposcSpm4jFv+qLgK6kGXJZCYRkPdF60BJgzKUy9zGavj2Dk91D7mx7xdVr3wn7+5OLvhvBbiE2/nPzQ1vn5A5oXvMPEkZ5/UR8bgTQFnE/R2CqPFgFjx8AZz6omm3zIllkxnrTNXulFLJUqLFyPDgZ981ISjfeqmHJZuXI47tU+ymR+4v8i6Dq7QfoB/6ng3WhtuKrlEJ/pgFNG/SUP3x2GGc6LSY26LUsp8DDiHe9uGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqUtBSLqb2Pww7c+fQZDsrm8Y66MoDBwLzEoEzexPps=;
 b=thyDUET0FCddEHQZyKYpyZxqQHyGJl8uRECIlXkBa4m+be3bR6Z0H/f3ZZ0w5sxiMCUWvmCRSvtfVfmknwExydl0L2NBR7bHOnUK/ibJoVGXoB4uIkrAshzbh7g6KTl+9tUxIpSO5B8kq3hgcMmokv8ZBdgDyB7XLmHHLA4bOfsP5H6lSPiaopW9CTxX0VVbs6BdgjqwZZSnkfLcSFLNVuGaI5mmgDraf0PfgWgEh+ImyF/0MoWgqh9vruN43pGGrXADjidk+SqUL7b70tOOsMl1jOatkS5Pk14Duj0rWojsW5YosF03GPSvl5B1NC9s8fF2xdvqmH0ezG59nLGqig==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by BY3PR05MB8273.namprd05.prod.outlook.com (2603:10b6:a03:3b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 06:34:15 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 06:34:15 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH 2/3] null_blk: reject zone counts that overflow unsigned int
Thread-Topic: [PATCH 2/3] null_blk: reject zone counts that overflow unsigned
 int
Thread-Index: AQHdfXAne+doN/0Dc0SIIKJyW7HXgg==
Date: Thu, 26 Nov 2026 06:34:13 +0000
Message-ID: <20261126063404.1051061-3-x-professor@outlook.com>
References: <20261126063404.1051061-1-x-professor@outlook.com>
In-Reply-To: <20261126063404.1051061-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|BY3PR05MB8273:EE_
x-ms-office365-filtering-correlation-id: 0bb82e6f-e856-463a-db1f-08df4b874ac2
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|19110799012|31061999003|38102599003|25010399006|8060799015|8062599012|15080799012|24121999003|22091999003|8022599003|41001999006|26121999007|3071699003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?oUSMaGQt5/1nTzKHu7hCYaR4EhRxeBpSpr64uK+iWBzv+Cf8WgnVyWQz6z?=
 =?iso-8859-1?Q?OAO+TvyfOIQC1Q14Dk+7Ef1MyNoIS0ulGKbP6nmVVndO/9+wQ/qGddCJzH?=
 =?iso-8859-1?Q?j0vZ/1PyRYyxFV9ZNJJ82INkgrvddKdyKHE0K6v6XpmPCNaRk4dCFdTNvw?=
 =?iso-8859-1?Q?AHwq2eub/WLyv15fV2P9yvRfvFlku6mw5rYpJpzlj+/3BznRB+1rO1Ry4i?=
 =?iso-8859-1?Q?MWIVy+flT14JDNbgqRKAc8koFeu6XXfphp4ZeB0FHs5NL22C+OxveLhJ08?=
 =?iso-8859-1?Q?e2To1SdhdHNDmurY2gKBhwczab5tq8KoCnZ/Gb5jxqqvPoG0NqLJl/gIi+?=
 =?iso-8859-1?Q?pskvl/b1fB81HYnftfQBqyyyUBKopwH7GbYkLQcMJM0/O+kDVL+Skp4s7Q?=
 =?iso-8859-1?Q?DJZUAJnLVq3dc80m9CJiVGdnYEKy80RO/ucxFlj2NGiYrrd0CbRYa8Q17K?=
 =?iso-8859-1?Q?krjBxHJKeQk03s9nq3RD+LOPHMGC2AdwBj5I0nx5S85etNcN/SOJGvzDMv?=
 =?iso-8859-1?Q?k7ypmUUuobNWMnkBIrgxFkR7ZpZD+YXONRnFMtNUojnyOn7KBnrKkCPdel?=
 =?iso-8859-1?Q?2RNRaCO2i5I1x5AodGkv3N7a8jVDqcFYpXr3pO3W30v+h9jFP4jrNN2A0a?=
 =?iso-8859-1?Q?eHpoKKbEsxIonn+ZWec6j4Cd1RqR9V6UqUh+UdONzB5whX4rposN+xe+LD?=
 =?iso-8859-1?Q?ErApXgP6cEx5kxIZHJbx5zKshyvBR+h+4o2N12p+gNuD259ir1YDrxakuV?=
 =?iso-8859-1?Q?h4ajtT8NFWSErifhUkPJI6WCuF7e44bF7QO3EKYc94gI2hk5whJIIaU3aK?=
 =?iso-8859-1?Q?ar919zxZttsZu2RtDEnTV9zQxiqGMvNJiTcHR+O5G9VsTzUe1NTFtD4/SM?=
 =?iso-8859-1?Q?ukgmWo5gQAElwSid53VER6WxRbQv3kKG5i9N4PpiqJgag5x2PrJVyEdQp8?=
 =?iso-8859-1?Q?XT4kziWrDgj/CBX/YBDRCGxOnVQwpYHRHUOVO6jVCwckQTPEhr4W8CvnPB?=
 =?iso-8859-1?Q?DoxggJm6lvrRaTd8vxXTPbe1/GrAm+thN8cf6rm72OiDP7WGYIAtCvDwum?=
 =?iso-8859-1?Q?/bECYIS1Boa3J74nSqTkoXcr2yQV0x+00p2OQOqq+tzi55AXYwOL2krT5s?=
 =?iso-8859-1?Q?8zydLxmQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ntLweMKW4Z9PSVUnzqeeaJRRf9pAP9OdAt+11WDY9iUKR4inqd7BaVVWqy?=
 =?iso-8859-1?Q?WhrBdNDrFBEn58jKJKdOOHlEGHdOOCfWE+qVMANE+eaE41u94XEcjTRq54?=
 =?iso-8859-1?Q?9hS50KiS/nvrUFqfUBinnJ13izrHEh0O0ygkDujdQGHVaZcZPPLADJeNyn?=
 =?iso-8859-1?Q?WZK4YC9BdZ/313iPgl6MXQFfbxTfN+anA1fhBmzyxy8l3gsjY36AyN82D1?=
 =?iso-8859-1?Q?87SBLZtYRsCgAEXyJOTwh3GuN7tP0vccwQooOwXGvgsaWhNi1Pl7l6h0lU?=
 =?iso-8859-1?Q?TMscwkwh2rkk0A1jos8mChGPv1T8iw3ZIuKdsnb8YF3Le6l3SicKzWU7pw?=
 =?iso-8859-1?Q?mQvKEpfufHps0p5VqwF3jUJwqrU77q6+CdxofTJsxi2awlw3pLOqFu2gBn?=
 =?iso-8859-1?Q?elHCRvkAxkOzKL0sAfzxGDvygdjtyafB1y4VL79A5dCftd+DHAeHuXB5FV?=
 =?iso-8859-1?Q?mddsLdq8yloYPbwKWDABdwQwMNqV9KKS4iIVQ7QMcDyNJ7lcZk1f28K1J7?=
 =?iso-8859-1?Q?glwr6gj8BGZbC7BimdrjY6ORLncad17FTZvPonWkX4cFqe7CkAgEb6YLn3?=
 =?iso-8859-1?Q?8az3kdl/MA09qwb2Hi3oHhaDzv4dCCU/ZxkVRo/O3Frv9NKE7TVi2DYH48?=
 =?iso-8859-1?Q?Z6W4EIB2xOmPmU2V91vTrKG/dG3pTgzwbMkm6DqbUnPsij6R6fdJytXZ+h?=
 =?iso-8859-1?Q?LZDDrdNGuMcemc0rVVxXDxgOA23Dh6rXHt4YmxxU7WeY/0UrCdrrBpNC39?=
 =?iso-8859-1?Q?DHVjnFtj9JpnUnnz1TaZR+ZPdW8zjsjNLbEX9WxuCBoa6BBfqO/lXsqVry?=
 =?iso-8859-1?Q?R7Q5uKx74b3cqjfQAgzf4fYKexofA5BLk/0aPmHIPn7eMhs8k9EL3j6dyU?=
 =?iso-8859-1?Q?YD/4P/LbAUxF/YTbyAkWtfI7w2J13zOrY8Y6H0UDDMPM+xhJ87ZjgqrCoP?=
 =?iso-8859-1?Q?ofUP0DXt7GbAvzupYvXz9rU8UDny5Jf8hJTRF0EGPMGeMNzPQ2i6WHpE9O?=
 =?iso-8859-1?Q?u+flk1vWRzmw2TRbuRam8jUdxTxfDWjtCbQgWOMgywdugQTLb0yaBFl3po?=
 =?iso-8859-1?Q?BWIf3lMVBiQidXmEN1DlKcvB5y6jLGlCLUnf+ndJKl9Qzfrn1lS3uWQMwg?=
 =?iso-8859-1?Q?PSStHBsylQe/pGQOEnMqvg0J3yzvc2wEGekX4dE9CMvOkCN6yh736akmeF?=
 =?iso-8859-1?Q?aLeLk+/iWORcaTDYqkTYD8LAEn0kTDibjZPgNRdVQ4sRyJx1c6iNS9l2Ew?=
 =?iso-8859-1?Q?VghMBBMl4FpoGaJ2XX3dybZgm0u42hjZ2xtWv2R9bXcF8NX5Lj2Kg9xcno?=
 =?iso-8859-1?Q?/kyIrbXyi6rRiL4QmkD0ngtB5Bbn7QCpczRfsi8Ux5LMzHfvc4uWoWR4RL?=
 =?iso-8859-1?Q?7vaNFnPPtFUfjlEyG/apMFJgwW0CCAQ5UziY6diIh4LLHuNDw1sV8BMl2T?=
 =?iso-8859-1?Q?woEJUlnFf0yadcpY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR05MB3281.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb82e6f-e856-463a-db1f-08df4b874ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 06:34:13.7405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8273

null_init_zoned_dev() calculates the zone count from sector_t values but=0A=
stores it in the unsigned int nr_zones field without checking the range.=0A=
For example, a size of 2^40 MiB with the default 256 MiB zone size=0A=
requires 2^32 zones. This count is truncated to zero when stored in=0A=
nr_zones.=0A=
=0A=
The resulting zero-length allocation returns ZERO_SIZE_PTR. Adjusting the=
=0A=
number of conventional zones then underflows zone_nr_conv to UINT_MAX,=0A=
and initializing those zones accesses invalid memory. This happens even=0A=
when the device capacity itself fits in a signed 64-bit byte count.=0A=
=0A=
Keep the calculated zone count in a sector_t temporary and reject values=0A=
above UINT_MAX before assigning nr_zones or allocating the zone array.=0A=
=0A=
Fixes: ca4b2a011948 ("null_blk: add zone support")=0A=
Cc: stable@vger.kernel.org=0A=
---=0A=
 drivers/block/null_blk/zoned.c | 8 +++++++-=0A=
 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.=
c=0A=
index b271d0a88ff2..432a0a2f3893 100644=0A=
--- a/drivers/block/null_blk/zoned.c=0A=
+++ b/drivers/block/null_blk/zoned.c=0A=
@@ -54,6 +54,7 @@ int null_init_zoned_dev(struct nullb_device *dev,=0A=
 			struct queue_limits *lim)=0A=
 {=0A=
 	sector_t dev_capacity_sects, zone_capacity_sects;=0A=
+	sector_t nr_zones;=0A=
 	struct nullb_zone *zone;=0A=
 	sector_t sector =3D 0;=0A=
 	unsigned int i;=0A=
@@ -94,8 +95,13 @@ int null_init_zoned_dev(struct nullb_device *dev,=0A=
 		pr_err("zone_size too large or too small, leads to zero sectors\n");=0A=
 		return -EINVAL;=0A=
 	}=0A=
-	dev->nr_zones =3D round_up(dev_capacity_sects, dev->zone_size_sects)=0A=
+	nr_zones =3D round_up(dev_capacity_sects, dev->zone_size_sects)=0A=
 		>> ilog2(dev->zone_size_sects);=0A=
+	if (nr_zones > UINT_MAX) {=0A=
+		pr_err("Too many zones\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+	dev->nr_zones =3D nr_zones;=0A=
 =0A=
 	dev->zones =3D kvmalloc_objs(struct nullb_zone, dev->nr_zones,=0A=
 				   GFP_KERNEL | __GFP_ZERO);=0A=
-- =0A=
2.43.0=0A=
=0A=
