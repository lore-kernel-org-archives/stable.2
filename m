Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795784280;
	b=2fuBVoTreGO2wAJrttXyliihJ5EsWxDKFliWjGcrB1w9beYyru24NmVF9Eajlf9OaAlb
	 7JYYCj/Hria8UlER+0+8Pd4PQdkDbl8umU3RIyAqaZcAynzzKv2iu0AFDUIwHozoIwa4q
	 NvpWfUs0ZDE0gECIEGGj1jgiYqOtIHhkHO3JRdPvXIwoEtin21A97rYqNqhe16k6zmILD
	 kT1gldmMQl2iye/Zs9DX269m/Wv+xBOi7IzNqsvseibXYHNqpjIS00hp81HEjPiM7b9BQ
	 UyuQz1sUFmSvmSgHyHLTpuo9X9REQYi3klOR3nTnVSuT40omK04hj6EFFC1fEDC1HUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784280;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=nehlZZaELc5vv3vXS94VpQNRqRrT6jcZKQScODm+KPg=;
	b=jIOrBb5msqIlABKK2HZw8dkgINP1y5a/M6vCV4KMl/E78jWIDT7RlOC4sxGGZO3jxMSR
	 Zv2DDPxcVXOiHf5SC/dRy0R6Vpzf77Y6FKugOk75bugKLa3r7K6FFSxZWk0mgc6SbyinE
	 HIk2+zMrH73ziQ8iU16YhDMrLBA/duGMmNUAPhqWUXOTMhXwRLWRLyK1O8iiJO1qZCO5e
	 cAfo2KFXo39VUUS+r3wGwigJ78vRn6y4I+xSW3R6dbHrHoclN1JfITMusth58UOXZYmIN
	 wt4Ww0FqJ4zH5QQ/PBE2fLzAi/2o0Hcrm1sXOupAHYrtRch6gdJ6pwfaK2zoc4XA4Mw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=kdkVrOmf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.16
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010016.outbound.protection.outlook.com [52.103.20.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA079606A31F;
	Fri, 27 Nov 2026 12:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA079606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=kdkVrOmf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXVCEY/t/mfyQe82fwNAexj0i2ewMgQvEkMkWh+faO/xSBQwT0bofMw8PUMP9YxdUEe2g8LHh+8z5/T2ssysbBi9ShDWZ92oCDepTg7lmqnyIRIddeY9ZsuRQlpT6+xhhmap18SeOe45IGj8roTdkzELBf+y/vFaKK1CsWzHT3FZLY84jc271lkHkQPTDdtUaqWAAa3Ik19yymEW2UTb/rAXhY9Ac8+HTg+oiP4w6vrMS8wNmmoUdWDEbRqhTn3eT3R/D2urXufXDrOO1CQYmjswB6DlhbtCB+d0+ylWEH1GNBd6O4hIsQQy8kB/x9epPKSlRa0OVViKi3d0+hBlSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=nehlZZaELc5vv3vXS94VpQNRqRrT6jcZKQScODm+KPg=;
 b=M2iIdYy+d14XPZHkaBSIdOnqvc4B1JnU0Q+HWvUgpvJ3+l3nk2Apr9588tmYOif8rHDQkgpynA2Urt+jgpNxRElzKaxUAifKgmfWRz9F6SFGwfftC13UP1mOMOccXIp1v2kw8GF0nokwPcaZz0MdnMaa8ahMFQTcJaqXy1TgGmVV7ES2Cs07w1/e60fVIA6W53SNlycmw7/s+ou/AUF3tEwvr1o4+5+E7mir10S1doOJ/gZjU1VfPieaZfCgFKJssQ4Wr7bNhhchYeV/ocS/5chdPHkmeE3Vfge/WiuH0uLGiTES6qNYmCCWZJBsqzaTcfBERCUZKBElOJLvSKPbzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nehlZZaELc5vv3vXS94VpQNRqRrT6jcZKQScODm+KPg=;
 b=kdkVrOmfABPhh46U3mefPUj0aEga/7DW7bXe8q98Ko4MSmPcrcbiEi9RoS2N2jPZv8R3Kib7XjQj7YCGXrr13gnUWOzI69C+8KbzPVR2ioJ/fqYmZEwjrqvyxqY+b/TXgCyfLyXpoVSi34EHuYDgQ6z5fZSaMegSHhxvlcxmHzOnvqB1L3tyUt1su5Iy5vtvp0FIXuzmVNXQTrokbytxodmNdD2Fry9HPv0IFbfEsitGiEzXxUY/uqvKCfYTab69GDUeB5r033SUeSc5wGScX/KLs9CDWCqvYOao4lUVJ7y/M8POwItByw6+GCa5o8HQlnVDUlsWhnXF/8zy8PNqoQ==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by SA0PR05MB7307.namprd05.prod.outlook.com (2603:10b6:806:bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Fri, 27 Nov
 2026 12:57:57 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 12:57:57 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 0/4] null_blk: validate configfs values before power-on
Thread-Topic: [PATCH v3 0/4] null_blk: validate configfs values before
 power-on
Thread-Index: AQHdfm7smB80//UFf0K1+l6bzvdlWg==
Date: Fri, 27 Nov 2026 12:57:57 +0000
Message-ID: <20261127125738.1654012-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|SA0PR05MB7307:EE_
x-ms-office365-filtering-correlation-id: abda41eb-3534-43fa-3507-08df4c860f26
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|8062599012|19110799012|31061999003|8060799015|25010399006|4140399003|38102599003|12121999013|15080799012|24121999003|5062599005|22091999003|10035399007|1602099012|40105399003|52005399003|26121999007|4302099013|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?EbMCZfi08MF13rgdEGR5wLI1vyI0/b/o2r+FoQuljImgwNzLRDpY/n0LFq?=
 =?iso-8859-1?Q?eWT+ARgONMxsipeHFc461v+qSK+fZhweFnn7mndcMSexEteM2YvGQl3NWj?=
 =?iso-8859-1?Q?M8bhRXCVDf/DCVEuU7HnogKUXmXJXwsKKabgv20hI7x14UqmRR0EEtk+cu?=
 =?iso-8859-1?Q?BZcIjF+k3VIaA2cK6xUAz7gRzoRVc6F6RZSdKhILVma9gCLQN/FhLuFw+4?=
 =?iso-8859-1?Q?1U0gi6O9OAHlqxCK19SOx7F6ShHYNLefKRNzhnuO9APvHePtnsM3+NWuz9?=
 =?iso-8859-1?Q?9bK70VpdCeojU0SHYGG5XwySnMod1Q3ZQtKr/GNbz4CdDJBDL2u9tawxmc?=
 =?iso-8859-1?Q?AWUpXHT6x6Pe6S++LN1hVlmQ0t3DUUGqVw5F0DijCYdBImGxmcfLtSluz6?=
 =?iso-8859-1?Q?7MYOu1d1Mhfoi7HSUa5ah4K8n2NeSM2BS9GOiyMm+Yk+85J0AY1k6VeF/f?=
 =?iso-8859-1?Q?JSpupyTpwvtXXlV1etM7uLfOsk0eP2R79shMrD5xQD/X6aeVnFbqqNjcIL?=
 =?iso-8859-1?Q?RVQIBMuzYjTYNGP6bRn3PDi1z7tFBD6Hn57J0nmQ8YyiKGUXFgfYaQ1eAF?=
 =?iso-8859-1?Q?XSue5Nn4UzYCZXrC1u/NT6c8l41IvXNKGWTpsf9GIB/tx1iAERYuH51kUd?=
 =?iso-8859-1?Q?5fBQdTzEyFeUe8YQMG4MyYV9QTGACoqoET3lPDuKAAf0aVmYwbVJR0/aKe?=
 =?iso-8859-1?Q?S9jac1BmUfRNIr+zac4hur9eVBQovbL38rEW/HGzPKdwnnC/7v+w2v5+18?=
 =?iso-8859-1?Q?wHkMi8qtoR/taaGzGAw1qLhomkt0fLSykMPd5GEgSO4yL6q4mUvH1/ohRr?=
 =?iso-8859-1?Q?ae23XwxbWO37onvvQ73H/zSa0WGyzYNI3gk55Kehnic4/Z3YK8JODJr/yK?=
 =?iso-8859-1?Q?g9axcyAg3bt3tiD/5aIcyl6DrVrvX+Py9YTsAfNqjHESqiPnFQXoLX8zR2?=
 =?iso-8859-1?Q?RSjhJ3FAg30wjON+Fi4/pr+BJgD/G6me+Jzjjg9UTjwwxi9WouHAyaFETE?=
 =?iso-8859-1?Q?GlG8w+6qVZZroSwpYgOhPTG+IudD5R3/QKRnXYEzmFPs0wAVvCumivzlCf?=
 =?iso-8859-1?Q?dmiGBNuG0FouUPAAEH15nsdHZiNUDozkVSImrCECLyRWfGgnx9zrLI3YBV?=
 =?iso-8859-1?Q?e9s0Ev54LQkJHZ5ny4pyrdHuHNq8Kv1/BxY/GMSXvxlJiQP3rvD1us3tBX?=
 =?iso-8859-1?Q?oUOpmcjHBTUy9rZBgcazZFun4hecXE1nqjc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FswfR0BQVTORZ8s0+QQT/B/P+NxCrZ9nXvInIdKoAl4lStBJ+fZ5TqGuwa?=
 =?iso-8859-1?Q?zoS9ta4fNzaXu+O8rBashPjDURoLTiHkf1I6LbJTcbtABCvA8BLj3gJRPH?=
 =?iso-8859-1?Q?LxTSVsU7aoJmKLwjaYgbIzU90+cFDrcTYQog4uu/yCpHxDd6UE4FombMNh?=
 =?iso-8859-1?Q?6YyNK1V3ABLrIFFyXdjBs9bGHTYy66XjsQETJkF2ElWXUhijV/tdoHmYzI?=
 =?iso-8859-1?Q?YdX6yyJNjs6K6XH6Io/2RWGn/ZcJHLGmTFQ7nFD7DGXiC3sCB7C5JjiEFn?=
 =?iso-8859-1?Q?1p+f31L/SxHf3KfO/VZS2CvZyB41h2QUeqyiqkDYiBUW3gfKicti26KrnS?=
 =?iso-8859-1?Q?9ocfu0BO3Moj5M8plo8IjPnkBOiAz3RgO04Vu99RHwnX1iAn6wAForKkPh?=
 =?iso-8859-1?Q?azDwieXuX7P/Ymn3hpOK2ugfna05JmjIL9Den9BlMv18uBstb+HwI0tONB?=
 =?iso-8859-1?Q?qdRR0nN8JGrQeYl88cQdKIupi8tn4oilr6xtolqIKB85jRL5dY7EI5VW9c?=
 =?iso-8859-1?Q?/2oa9lDu44DerVGC3qqmlp4l2o1U5q4TU7i93vyVruHmL3WHQKcMHFuyPT?=
 =?iso-8859-1?Q?4meCQGJre2kjEuJjowOn7fIZG5NA1SJ8AjS8rcobtBcGVflAW0JszHf1pV?=
 =?iso-8859-1?Q?8liwEksW0wScpHR3dgVp2Ckp/TaLn1nOSHy+rWdr+bvTJsnm0pqqgrp9/n?=
 =?iso-8859-1?Q?YxUOu2V9gjrdhMdcRPkF2KbVPD5QVgPn4PtmiqDvQrYPBrLr+Neg3b9TW0?=
 =?iso-8859-1?Q?/NqwiNb1jr131qBRw4RL3n7BXxbtigKSoRYZER07O0E88SFbCikM0SdLKW?=
 =?iso-8859-1?Q?rmL2HE5BgIns4MJJkaf9YxnJLpL9u/yuQ24uhmcGkfl781cZqegNo2sih6?=
 =?iso-8859-1?Q?39auKgzORa4csMnKFZZEgcy6um02omh2XWDQyBNmHFK+JZgMBx+RVsMHE2?=
 =?iso-8859-1?Q?uHCCsPstF6b79n+1kkHWjVVBXYyV6RovQ3dGFZAesU4OXhlYH4DA5i06U7?=
 =?iso-8859-1?Q?n4Yvo45odhXCPMTLvHdZ1y4tZD/X7Inb8DF0wWa8KNmm4JXk5WP2s3wpUm?=
 =?iso-8859-1?Q?yNSoWzgoQ9OTDxFZRn/Qg2UPUyATvpB7Qcv+iZKHXORZLBqPobG2Zsbu62?=
 =?iso-8859-1?Q?EE7p1M0QcYelnTTRMjWOGNWnF65OddnFO/FBSgFVFMpXkjchru9tjpo60R?=
 =?iso-8859-1?Q?Bropc0R4kVylX3e7YYBdr/yYB45xy2Hlf4pIf/SPYlJQwibLUNYyey+q06?=
 =?iso-8859-1?Q?3S8IDvinMUbfSkIXPBtNVyNAM8GX73YGim6sfcV0GkPYYZy1ljrHAQu/Cs?=
 =?iso-8859-1?Q?Ez411c87tyfXB92OApocP+hADnBauoQqRyvWke4bKVZh0K849GwqYR+qy0?=
 =?iso-8859-1?Q?I3lp95ylzr0aixbbbaI3P7O2h60hc2cIYQTjNeRhL5UDgYtZiuU6kKD9ZF?=
 =?iso-8859-1?Q?BQgPEH0j10k4BLlo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: abda41eb-3534-43fa-3507-08df4c860f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 12:57:57.2596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7307

This series fixes three bugs found while fuzzing null_blk's configfs=0A=
interface. Setting size or home_node to the values below and writing 1=0A=
to power triggers a crash:=0A=
=0A=
  2/4  size=3D2^44 MiB with zoned=3D1 wraps the byte capacity to zero.=0A=
       The resulting zero zone count causes zone_nr_conv to underflow.=0A=
  3/4  size=3D2^40 MiB with zoned=3D1 and the default 256 MiB zone size=0A=
       requires 2^32 zones. Storing this count in nr_zones truncates=0A=
       it to zero, leading to the same failure.=0A=
  4/4  home_node=3D2147483647 is passed to kzalloc_node() without=0A=
       validation, causing an out-of-bounds access in SLUB.=0A=
=0A=
Patch 1/4 moves BLK_DEV_MAX_SECTORS to <linux/blkdev.h> so that 2/4 can=0A=
check the configured size against it. The zone count overflow still=0A=
occurs with only patch 2/4 applied.=0A=
=0A=
Testing used x86_64 with KASAN, CONFIG_NUMA=3Dy, a two-node QEMU guest,=0A=
oops=3Dpanic panic_on_warn=3D1, and null_blk built as a module:=0A=
- The unpatched module crashes for all three cases above.=0A=
- With only the size check applied, the size=3D2^40 MiB zoned case still=0A=
  crashes.=0A=
- With the full series, writing 1 to power fails with EINVAL for all=0A=
  three cases and leaves power at 0. Correcting the value and retrying=0A=
  succeeds. Sizes of 2^43, 2^44 and 2^44 + 1 MiB and ULONG_MAX are=0A=
  rejected.=0A=
- Valid non-zoned devices were tested at 0, 1 and 2^43 - 1 MiB;=0A=
  valid zoned devices were tested at 256, 257 and 512 MiB. Tests also=0A=
  covered memory-backed read/write, zone reports and a conventional zone.=
=0A=
- home_node values NUMA_NO_NODE, 0 and 1 succeed. Values 2, 63, 64 and=0A=
  2147483647 are rejected on power-on.=0A=
- Each patch was build-tested with W=3D1 on i386 and x86_64, using GCC and=
=0A=
  clang 18.=0A=
=0A=
The v3 runtime test ran the v3 null_blk sources as an external module on=0A=
an unpatched kernel; for that, the test copy defined BLK_DEV_MAX_SECTORS=0A=
itself. Sparse NUMA node numbering and other architectures were not=0A=
tested. The reproducers are available on request.=0A=
=0A=
BLK_DEV_MAX_SECTORS was added in v6.14 by commit 3d9a9e9a77c5 ("block:=0A=
limit disk max sectors to (LLONG_MAX >> 9)"), so 1/4 and 2/4 will not=0A=
apply to older stable kernels as is. There, the same limit can be=0A=
written as LLONG_MAX >> SECTOR_SHIFT.=0A=
=0A=
---=0A=
Changes in v3:=0A=
- New patch 1/4: move BLK_DEV_MAX_SECTORS to <linux/blkdev.h>.=0A=
- 2/4: Compute the size in sectors with check_mul_overflow() and compare=0A=
  it against BLK_DEV_MAX_SECTORS instead of using LLONG_MAX directly=0A=
  (Damien). This also avoids the clang=0A=
  -Wtautological-constant-out-of-range-compare warning on 32-bit that=0A=
  the kernel test robot reported:=0A=
  https://lore.kernel.org/oe-kbuild-all/20261127004636.Zw6bu9Dk-lkp@intel.c=
om/=0A=
- 2/4: Explain in the commit message why checking only for the wrap is=0A=
  not enough.=0A=
- 3/4: Use unsigned long long instead of sector_t for the zone count=0A=
  (Damien).=0A=
- 4/4: No changes.=0A=
=0A=
v2: https://lore.kernel.org/linux-block/20261126074748.1076774-1-x-professo=
r@outlook.com/=0A=
=0A=
Changes in v2:=0A=
- Add the missing Signed-off-by tags.=0A=
- State in each commit message that the bug was found by a fuzzer.=0A=
- No code changes.=0A=
=0A=
v1: https://lore.kernel.org/linux-block/20261126063404.1051061-1-x-professo=
r@outlook.com/=0A=
=0A=
Yingjie Wang (4):=0A=
  block: move BLK_DEV_MAX_SECTORS to <linux/blkdev.h>=0A=
  null_blk: reject device size overflow=0A=
  null_blk: reject zone counts that overflow unsigned int=0A=
  null_blk: validate the configfs home_node attribute=0A=
=0A=
 block/blk.h                    |  1 -=0A=
 drivers/block/null_blk/main.c  | 15 +++++++++++++++=0A=
 drivers/block/null_blk/zoned.c |  8 +++++++-=0A=
 include/linux/blkdev.h         |  6 ++++++=0A=
 4 files changed, 28 insertions(+), 2 deletions(-)=0A=
=0A=
=0A=
base-commit: 5a29cfaf51105039d156dd8a61d2783e8b653667=0A=
-- =0A=
2.43.0=0A=
=0A=
