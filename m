Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D701949B446;
	Wed, 16 Sep 2026 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589131; cv=fail; b=NrGi+agGh+jJ0e3F3wPSQh8HLmkCMHboQpxle6CEK3y2Z4v8tR87Crj9XBExI6Mdvri1FZcyhdJfdLUypwxh2gaonX1naoRrMUszCfUtK5jwQrmVg77pZCDE3s8PRwW3l0yO1U6eUx9icZumFrTvYdfiaXFMyWcSX/0ld6OhDQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589131; c=relaxed/simple;
	bh=dMOF8i+u8x2LvrWJolJTeu8/Gw3eKFueEDRBq6jLw2c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BF/1Eck1nMAAH61XMS9vpLNtZmwGYGIxtrFmoetvTBlypUs7escuRwuJFGXiV9/0vrXfVh4b9mJv9PM6xjOziOV5P+j6YJIe4X8vs2psxM95+kQO2y/399xgbcYRwn17pqU3C5brKyuILRwg2dKN3SmPy3NaVn4LfxBVtzBkHsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=c0mI8MNQ; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="c0mI8MNQ"
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFbtag1832888;
	Wed, 16 Sep 2026 20:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=dMOF8i+u8x2LvrWJolJTeu8/
	Gw3eKFueEDRBq6jLw2c=; b=c0mI8MNQ7eO7Vk/bl/ESGhGrKZ/C+NlS5ed+2eim
	8EPoHhIVE/xwUEAxJNA+eE59JOQorOoz55Ku9qKZB4PiPXfriZUtweLXvNNoXpko
	QYsPPNUEfgwmUVK2AgOekrNza/IyASSTX6y0X4xL73wcJk0bufn/YKNq/HrQ37hP
	rM7S/jSmqkQ5TYQfVmXdACkm8yYMVMvyq2dP3yOdSXhs1i/0Dg8hFx34uDwlsuxe
	3vKLoyF2MdXaMBP4nzuFBSUrl4YoRvK+DK3odY3bjgYb9qrbptCfUH1pEbWG9J3H
	zRQi0qBao4jfEeInPX+TBEkx5qEAPH7G9hkSy64eHMD6SQ==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4gqvpbw7ja-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 20:04:08 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 16C0014796;
	Wed, 16 Sep 2026 20:04:07 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 16 Sep 2026 08:04:05 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 16 Sep 2026 08:04:05 -1200
Received: from BL2PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 08:04:05 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbnsKgCUougsAuhicDNZs8BldZQa2NpuIDawns1V3T4TxYHSZlobv0QoWSFHEpj1f6Nua3ZarHpPlmpg9TQfIuo817mhUYuQVgC1pqVDewbiOb5EpghpmQkR0FzsZLwLbdkUZfiiYXGnaXSYLnp7493rdog6+W0nw2r86ChGCwYaVQwy55logMa4HwHBacKk1XHfoVDyH26LZWPw6kvGZ4I9zu2RjgVgkw/WN4JEIymRT1DABv6GydWKi17udSXgvdwqg+wNrXAq+Mf/94WVMoiDFsrJAv7WRYHXbEDIyAXBJB6U4+o5Qi2eHIMxcB/RvuST769u6O0xRuF5vbYc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMOF8i+u8x2LvrWJolJTeu8/Gw3eKFueEDRBq6jLw2c=;
 b=nJiKxjlGQHGS2mNjWt75tAEBmL0uHktzPTkMEvqQjNFe0rXlZnffrnYPkhtk3Tg0EATS3Hfix3MpD3Zpnon5gjKQTFXRT0GxPsUVBA/LaCr0obKHi4qkbfELHsMxF9Ao6OYAaUj+Tacz9GxUKR1wyNBFVMN3bPAtTrJP9c1BNfI+vF/abMm1MJFk8zRl2LxxOsEZX89hBBmeZzbDUUt0dh+oOUFx1Tt3yi2O3CufA6pqQdXuVBEnyi5ILT7ZUjW9WDu4UH8U9/prg1jBHfZPMMB772VlLgN2/CMtleen6xsWmbhRY6/CODXKWcrrRbk8nDTn2iXOvPyEmw73IcWuBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by PH7PR84MB3763.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 20:04:02 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 20:04:02 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>
Subject: [PATCH 0/2] hwmon: (pmbus/tps53679) Select page 0 for single-page
 parts
Thread-Topic: [PATCH 0/2] hwmon: (pmbus/tps53679) Select page 0 for
 single-page parts
Thread-Index: AQHdRhaEiU1ZC82S10KOkq1c433AAw==
Date: Wed, 16 Sep 2026 20:04:02 +0000
Message-ID: <20260916200331.664795-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|PH7PR84MB3763:EE_
x-ms-office365-filtering-correlation-id: 527ce4e6-03b4-47d8-6dff-08df142da748
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|18002099003|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: MkEVr63pHiQh8g/e+nhRkn/hjiL3E/qqIpVeypz3Zrj6W6QMplVED+5k45bQ2TYZpPmn9jhbs7XMaSV/AIVhdSZK8LiU3vRvXSyQ+WnRbNIkEM6Btp81HcizbMXgSPGllwoA+zA8KMqyFWS0b5FQ4gtd2EoyDWGD+u8OMMNCjJ/Vyc0/4Ikctp4vSEfwue5yB/uRaAhBHoZbdkjw4Jd7gqAuUTSUYbm9jsbpOO2IDI5WHrZHeKaR1qivjt7Q5xBzGd9zYGZRyYvC3ObL8/C8WGfEBLLXNDHRXifoFu+FhGqlouax6HHRkSB2WnoHKOX88DpTHRZBF7sjPidkQVMXXgvb2GbJwPmAlI02YGqVzZ3s8pdn+5kvqlCtNQx/R4n1aLdlGGI6d/z36DxW5xXI7Th448XB44e/hipIfOhLid0y65eubIEbSKaOWOAEMSx6MlZG/0KCnASQC8khnWk7mKt8MA3SW4PW/u1yco+6p61uA5pxkEM+aYDlSY2hPFweYy/KVX06FhGIVC2aC7QObpqmOz6SrfJLS4bd+G2+Y5j840AKhczcFoMAuTv+b0RDp3Wy7eTM6xDY/YOleneCd11j2WFehlMVVDavvtc20ZFPlClySSbsMEVWlYgYRlA8ZGTYlufu0PVQvH0uQnhz/8qH3xSto/fZZKtPHeorSMI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(38070700021)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHI3T1R4ZmdUVlNWSXhjN09pMEhVaXc5UGEzWXpKdE9YZlBEZXBHb2ZOdEhm?=
 =?utf-8?B?dTcyQS82ZVNkWVBlOVdMS0N4YXQ4SmU4NDJSLzdWSHl4UE9Vbk1JcXVQM1ZS?=
 =?utf-8?B?SEhFWUhheXJOS2NwQWs4NU9hakluaUVSb2hvWW1jSm5kampXaE9XalRrSVpx?=
 =?utf-8?B?M2cyUkxreENVYVBFZlNLcHZhNGJsUWx4QXNIOFdQUkV4VndpUWtHNVRHOENn?=
 =?utf-8?B?aE04ekV3VGFuKythQ2p3UjVDVWVqdlpzZlB5NGViVFRTSnpEQmtCbFM4QURK?=
 =?utf-8?B?MkcxblRHWDVGL1RFdUhjY1BNcWxJcys0SUtpaXVrTnNCaThpOXNpakdtT1Jx?=
 =?utf-8?B?b05BNitqaVlWaFhwcHQxWWtLT0VZNWxxeUljUmJ1dTNrZE5yOUdIU3VqdFdG?=
 =?utf-8?B?MFcvaVQzSFNzZ1MwU1gzWEFwL3RMcGxUZ1FqcFRoQ3ZFQzJ1RGxoNkx5N2JD?=
 =?utf-8?B?N2N0NHJDREJxZFRaclJNemtNMjYvSXh5RTh5c0hhbHVCUncrcGppRXZkNDZG?=
 =?utf-8?B?SFhQYUp3V3FuSElKWGpPeTkyMlJrUHdQclpmUFVRd2ZjM2x3dk13STY4bU5K?=
 =?utf-8?B?OExsejE3WjI5OFBNTFBLeDkyN0pVR0EzRllHZUI0SmVEMXErNXVEWm9TT25T?=
 =?utf-8?B?UTJvQVY4RFFDb3ZHdU54Q3p6RllrcnkyZE1hM2FtdmxhTjd5UjBFems3SHR5?=
 =?utf-8?B?aEYvK2pSejgrZmNSZjFqT2JjSzlSbGRmSFpPQk1WSUlJK0NNVVd1ZnhZS2VI?=
 =?utf-8?B?R3dCdnRNc1VKNUdjUEphQkpuOUo5VWRpWDcySmx2Mkc3MWR1NWpMNVNsQ2di?=
 =?utf-8?B?SzRIQVZ0Y3JtdUF2RXlsOTh4Y3ZENks2czZmY3BFQWtGb0RLV2N2RWVtMEdY?=
 =?utf-8?B?TzlnODg3d04rUFE1ZzVwUDJFVHVrS0wxOWdFQUxrMEQ1ZXM1Mm5GaFRUV2dO?=
 =?utf-8?B?QVYrRnlwd04zRXl3a2xTWEFNYWFjVlp4SWhKL1FBSUVtcDJOMGxJV1Zobmhn?=
 =?utf-8?B?WmhTSVJoZmpaM3VYV0pTYjhYYTlXVnVzZ0dpdXRaN2toUFVBQzI3bmp5NG54?=
 =?utf-8?B?NC9oR091Rzc5cTdiWTRqMURETnhjWUozRDhzbWc5alFKY215WndTRzNWUGY3?=
 =?utf-8?B?Uk1YZW5IZjhSckRURW5oblRhNjJ1ajVoWEprUllxVi9LUHp5ak9CMzVBNURi?=
 =?utf-8?B?ZzFzSkNnMkY4VjJEeFJrb3NjZ09VeE1WVzdXUjBiYXhjbGxjZUhxZzVXV1lx?=
 =?utf-8?B?SFROQlN2RG5la0Z1djFtU0pTRnQ2Q3FJbmU1Zklrci8zR0tSWWxRRi8rRU5t?=
 =?utf-8?B?TktETVRhWTRzRjNBYTc3aGowakJsOEsvMGFhcEw0Y0ZOMG54cVZwNDM1eU9v?=
 =?utf-8?B?dE9xbW8wZ1NyWmN3NkZraGtOMUIzWmhQeFRyYXFSMmhUR0VreVd3aThtSUhI?=
 =?utf-8?B?OXl1ci9pcTl1Ti9FQW9sYklWZEFPZFJSdGdpQkt2dWREM2pTTHhUMjhkMHNE?=
 =?utf-8?B?Mk1ib2Zra2VYaFJ1V3U0VlVwQzdYYzRUYzN0R0IwYUxTM2ZFa1hQQ2J1c0Zw?=
 =?utf-8?B?K2YzNUt2WFgwWXVjc1grVCtuUzFaSjlmTnRBUXhlSytpMXR5WjdjaFNzSDdq?=
 =?utf-8?B?ZjFKTkk0Qk9Gem03cDk2VUFLakZSbndhTFlSWEt2VzYvREI3c1Z4WGVBcEhQ?=
 =?utf-8?B?VnRuSkY4SHFlMFJCdVVqbDVKcE5YM1ZVTmJ6Vk90NTVPbnpqMmlhQmJwckZS?=
 =?utf-8?B?TTNmRkVaMWJjZkpDS0xheE5zZnVBcy9vSlF5UmVleEJWOGh3OWZmTURaSHh3?=
 =?utf-8?B?aTE2QkZEWVlodUVqVnZOM1plRUJ2WDE0UFFaVWJHOGtxMm5KWGFIbUI0STFx?=
 =?utf-8?B?ZjBocFRWYnB5SS9Ha09QaFpSbTIyQlp3K05tWlRoWDQ0Y1N5TzZoK1RkVmdJ?=
 =?utf-8?B?VHNxb29kNmhEK05LMTJlWkZUWEo1S1dQR3d2TW9NZU9yMDB1SmxlWGJEZjZi?=
 =?utf-8?B?Q0RYSTYrOEtlT1dqdlBVN3ZmMmY0TU5ab3dBR1Y1SHVLTE5xU0dDVDFSQStk?=
 =?utf-8?B?TTN1ZWJpK0FsczU5NHJkTU9PcFJTL2w5LzhWWWkzR3ZUblBmTjdqNE1vaXhW?=
 =?utf-8?B?clgzQ1QvTlk2WVRmYzdsdHNrQmVtVkNuRFNuZjdHS1RVdVczRE9ZaE9udWRN?=
 =?utf-8?B?aUZxTU9nOFNhRHJFODdaaS82cmRhZGNxMlVuOWZGcHNnSUllTXZhWEhLTUJQ?=
 =?utf-8?B?aEw1RWpFak44MGFiRnBOWHZ1aEVyeVRBbGppdWNrOFVhWUJXS25hZ0dpMmg1?=
 =?utf-8?B?VkJKVGNmZW5WRzhBWVlRb1p3TkxaZm15elpBK0VyRDJRMjFBSTVTZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U2ojn0iAUBU9zpm8g9bEOudLBmya1RHCuCMheEbqNkLGdtDpGJtWxUO15BuDOOnnkKKYQpP1xdz7y0Y/a/f/5RA7Bp8rFgi5j1yo8/fQ0ZecNYQ/j/jGBpKJAZyTLwqEmmZ6Im2r25j4Wr5TtwJ9eRm783Upe0x3HW226g0M9Oi6do3tqXco76R3N7wwkb77EMp9N6JZ07bmflfBA31fz7TmP7NjHYAT8kSMIX5Bx141GXmwf/WyOXV5XrXX7NSDL38EmOx3CbZtgPBsUNuvWBXI3YiGFq7w035T5D6rwaKgR2OiC1OhGsIJShQmFsg/p1RcNYOYYRJBv/6wt8GLMA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 527ce4e6-03b4-47d8-6dff-08df142da748
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 20:04:02.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUDyGgCAtMXlxPOP+EPB873oIJYgfzZpAxchVctegvf9w+R7bN6VtzUMWdrbusX6H5QEW0FYgl/06//YJ+Fx3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB3763
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI3NyBTYWx0ZWRfXwLIbWfJzpxN/
 jN8vbc6S9Bh/aDSGnIDN9bK3bNrNLwzElgivi3CIN6zWSMjhC/XNFh0MrQ1fRv4knvvH8SVT2U3
 uIyE9tCJMOngI+gIPHipRBT4kj87znM=
X-Proofpoint-GUID: RaBFZjcV42KMRU4Nw8jqlWSn1SuTmJVh
X-Authority-Analysis: v=2.4 cv=Vclir1p9 c=1 sm=1 tr=0 ts=6aaaf638 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=k7r4yCLl9DVLXMiQTbtC:22
 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=OUXY8nFuAAAA:8 a=tckjFT8JPpfR0NA8wX4A:9
 a=QEXdDO2ut3YA:10 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI3NyBTYWx0ZWRfX016c5CglNW46
 wnCjzzwika+JchrypK7ZnF9jhgLMKE1gS3WWctHy1KTiCrQ9MALli6GXftYgpha+eT1zgkpvrd6
 3dmOgNAF1gGwg6qY+OSJu382KLbkAPRb0dIeXV/8DTs4NzFqJCEDKLsAf3FTsTJd1Sm/+APo4A+
 N21BjTbCz7coUUnwPlUrQqirr8aaJrjaO+AfQoWrJTGMgnSJE8bTAmKQaf1RFr1aTCFiEhFGxRc
 c6gdMrh2VpmW1esmXUyuScwzKxGKhYZ4hWTfJc4L9qYzx7hP6l3VmLD9n3LkgV4BNuLSJ4cHT6V
 V+FZXje0j5J+mMqhhjM/WMoSgYPabysDF08xUJT/sTCAnwk6e1qek0qZU1dsBQ5+3xhxElfTKxN
 9XIYO/dHCSvzSllpP59FrDU29v1wfTgsT8UAYbFc6Fdik1Yc9/sCsctYdfmH6x9fOeSMW91Mw8B
 YxH9/yaDk3/txCcEgAQ==
X-Proofpoint-ORIG-GUID: Xj2X9fgNCHM3m5oz4aeEmvfbM9ETSxq5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160277

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpGb3Igc2luZ2xlLXBh
Z2UgVFBTNTM2NzYgYW5kIFRQUzUzNkM3IGNvbmZpZ3VyYXRpb25zIHRoZSBQQUdFIHJlZ2lzdGVy
IGlzCm5ldmVyIG5vcm1hbGlzZWQ6IHBtYnVzX3NldF9wYWdlKCkgb25seSB3cml0ZXMgUEFHRSB3
aGVuIGluZm8tPnBhZ2VzID4gMSwKc28gYSBwYWdlIGxlZnQgc2VsZWN0ZWQgYnkgdGhlIGJvb3Qg
ZmlybXdhcmUgcGVyc2lzdHMgYW5kIHRlbGVtZXRyeSBpcwpyZWFkIGZyb20gdGhlIHdyb25nIHBh
Z2UuIFNlbGVjdCBwYWdlIDAgZXhwbGljaXRseSAod2l0aCByZWFkYmFjaykgaW4gdGhlCnR3byBp
ZGVudGlmeSByb3V0aW5lcy4KClBhdGNoIDEgaXMgYSBwcmUtZXhpc3RpbmcgVFBTNTM2NzYgZml4
IChGaXhlcy9zdGFibGUpLiBQYXRjaCAyIGZpeGVzIHRoZQpUUFM1MzZDNyBzdXBwb3J0IGFuZCBh
cHBsaWVzIG9uIHRvcCBvZiB0aGUgVFBTNTM2MjIvVFBTNTM2NTkvVFBTNTM2QzcKc2VyaWVzIGFs
cmVhZHkgYXBwbGllZCB0byBod21vbi1uZXh0OyBpdCBpcyBub3QgeWV0IGluIGEgcmVsZWFzZWQg
a2VybmVsLApzbyBpdCBjYXJyaWVzIG5vIHN0YWJsZSB0YWcuCgpUaGVzZSB0d28gcGF0Y2hlcyBh
cHBseSBvbiB0b3Agb2YgdGhlIFRQUzUzNkM3IHNlcmllcyAoImh3bW9uOgoocG1idXMvdHBzNTM2
NzkpIEFkZCBzdXBwb3J0IGZvciBUUFM1MzZDNyIpIGFscmVhZHkgaW4gaHdtb24tbmV4dCwgc28K
dGhlcmUgaXMgbm8gc2VwYXJhdGUgYmFzZS1jb21taXQgbGluZS4KCkxpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LWh3bW9uLzIwMjYwOTE1MTY0ODIzLjE2MDk3Ny0xLXNhbm1hbi5w
cmFkaGFuQGhwZS5jb20vVC8jdAoKU2FubWFuIFByYWRoYW4gKDIpOgogIGh3bW9uOiAocG1idXMv
dHBzNTM2NzkpIFNlbGVjdCBwYWdlIDAgZm9yIHNpbmdsZS1wYWdlIFRQUzUzNjc2CiAgaHdtb246
IChwbWJ1cy90cHM1MzY3OSkgU2VsZWN0IHBhZ2UgMCBmb3Igc2luZ2xlLXBhZ2UgVFBTNTM2QzcK
CiBkcml2ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5LmMgfCA0OCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKQoKLS0gCjIu
MzQuMQoK
