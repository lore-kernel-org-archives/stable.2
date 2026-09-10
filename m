Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0631B80E;
	Thu, 10 Sep 2026 01:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789004562; cv=fail; b=fBb+1kt8s5DpmDFxRKRHhtidFdPOu06YfXS0S7EztqyhCs37gZgyMuVQL9IlpyHfvk8r+UgUh4+I8BcEusZi5wr7fFp/209lTvr1OZgDqZ7X15olJaz2tAOYiTXVFxIPEAp/kkilXJjbthJaqoyj1NdFDAIq2efnfFW3pvJLH1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789004562; c=relaxed/simple;
	bh=TYFcTj16G6Uk57OcWjcc0GewOx+tgm8jByTt3UX+YaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GIulhabRZK+Iijyp9QWHs9vj6MCRNpl6zAb8KC7m3RDiTK/RUak7epNRIIX3+t7TSHkaEjyCG2PCepcPoLHMdeFURtZqt4GM7dvwep7MTf/uPzyfGz48GXvcblkk/zoS9vOQOhgCHndU8TyJoPzTQHvPU3TWqOTSV7gOq+aHH+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UQYIC3N0; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UQYIC3N0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XziJWb9UBiUJModNwf6rXugJamhXC4fNqvV7AjQsED/Y+OzhDRmOc6O5nOoKhID8X67VPboIdc5iS2S/AOCt+Yf+Os7W6Inp7+cztBqic/CG7caQu+Hc4t3pjP5k3hDOECLZyT2o9+hmsPtYDCwgYWY6BRiHII6KkTD+E3iHnhFnp/eaMMwfiyiZ8BV/wXB6H+/UM2t6hpfzmRUI0bHL3RcF+NpOWgAwj90r7Fhr/EKi3pKmdv79eOPa11X94mYBJ2S+7nH3OMtixMTG42lCdABWi+Tp1R/sS5Y64Uwr4lJ7HoouZcPz9vNO/LdRbVk7xwKoz9a+E2/QtAoK+GmZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYFcTj16G6Uk57OcWjcc0GewOx+tgm8jByTt3UX+YaM=;
 b=GV8RJkybn4K7KmA7BXfHcM8SxNxXtablBoYTtquvIIFndE0JpuNN91Gdw0e/EqgvXOdjtCIIYKU1VWJpSmGQevFWxzcJMZBGIeSFoN6nu2qZgPGwEtjb5eKvH5Jgn1YVqflyUCQRP8mPHcBm0zztEVY/k4PuNVEpRCwbv3TQFAKl5p/RFGxalw3eLn4VvTBKRZnmjdRNZlfPpTNm6PA/i1x2W+rNIJfxWudhsFW9PHJDGDGLaMq3zbxSHZ8A8+bp1dAym6qNrYfv6WjsJ0C88r05pu7PMZjfKkKSG/uzjYonhTdrza4I6XiKn7CMBIosgyZ7bkw+Eprqmb0vXuuayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYFcTj16G6Uk57OcWjcc0GewOx+tgm8jByTt3UX+YaM=;
 b=UQYIC3N0JVQnBLsy9IKs2BH0Biulsfai+ae72E5TDR4CsCnbnQnYGtPa/EqilPmRDT2BBZRd/eEW7gUAugCuhnEZnfddlEoK1s0xEWVPuu/FYFGxLExe06M1IK056bD2UZgA/spufrp7l3buXmM/uy99rY4L/jlVqJ9kGNjRlpKvWgqsSB38rZKcqzTCINDM740bUDQ3w4/S8ium0p8nN4LCbtnIA8xE42isLjtbQqBeNWH3Lq+GADBRUCom17QkgTL9dw8JVAv0YGV4cww8c2rPuHOCeJ/3A+0YK9q2Vsln4pyL6DpULCxgUP/nI1cOV56mAe6sXdNBS4FIUVF+mg==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by MI9PR04MB938484.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 01:42:37 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 01:42:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shengzhuo Wei <me@cherr.cc>, Bui Duc Phuc <phucduc.bui@gmail.com>
CC: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Troy Kisky
	<troy.kisky@boundarydevices.com>, Fugang Duan <fugang.duan@nxp.com>, Lucas
 Stach <l.stach@pengutronix.de>, Simon Horman <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net v3 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
Thread-Topic: [PATCH net v3 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
Thread-Index: AQHdP6/enOlQx+B/W0ig/sWgTmcombbFx66AgADhPICAAGCVcA==
Date: Thu, 10 Sep 2026 01:42:37 +0000
Message-ID:
 <GV2PR04MB117390F268756325E9FDD5AEC88BF2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909-fec-ptp-pps-event-uaf-v3-0-bead12c29a16@cherr.cc>
 <20260909-fec-ptp-pps-event-uaf-v3-2-bead12c29a16@cherr.cc>
 <CAABR9nGshJE96aCZVriQeMd+7Zjua5n+EKpUTN=953sowUL0Tg@mail.gmail.com>
 <aqG3-ySw1AecQVkD@nobug>
In-Reply-To: <aqG3-ySw1AecQVkD@nobug>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|MI9PR04MB938484:EE_
x-ms-office365-filtering-correlation-id: fe4124f2-0dd9-48ba-0280-08df0edccb68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|19092799006|1800799024|38070700021|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 u6kSs4hqfTYfGFl3WaE9Fjy9QX7TQz3AaQHGcgXRHhX6fLithSMR9ZFsFOcZ6TicWC3avws6Sklv1PuX3RSJZsamAP9m8qkV4CwB3B4vZEydt/JMd6vn+lFaPJnqh5LFGlhORe4fryvKHMhRCV0TKdQyGjApM/0DliNUBS8aJwlMrfUL+x6f+oz1sCjkVKiOByMe0rnykDuwtiqAa3H2OoXHrILGCiXpKkRobg2eTGogTp7D1pKGOasTIXm3oK11gsdarZPJoLwomLW1zlt1X7/nQJ4q2xwncTaYqqeO23+542690IsWPPZgWrcgUIyaYSeRKHVOkS64vRisMhMk+IZdhxhYujkJiv3xqiqm8iltqci84abX+Td2VNsuW8IWGxVz5AykEASV+LelS7/uGnHbJJO9HQHWO3dtsNJZD/57YqVV7+9LitMVch/pil3259cC4bcMILWZGyZXEF/hmfxp1+ReRczkUVnwNd7A02F98ykjl9jO1gtoW1/LBZU/LybO/bI1iJlLKPt+kHwccQKI+DwuRq76KIl13og/3Evwv/YXC+k61t3OD+ub7hHdSeZ++KcUBAEhIasdALr+UGncI+h5NWPIb1xAdhyd5tUwQuC1ioDHd8YMDZZroTm12d3Y5Wb2BbwB6JJdoVdF5pCDm/lv2vOmQz3YUGU7c39uHioutnsFkGX+nxSOFl7cWz1vpJMip/K4E3iYI0DAlDw+lwy/Z75C/cEJGwCDKAg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(19092799006)(1800799024)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2hrZ0ZVL3F0ZGs4U0xNb0Fxd25xMjBOek9zQzQ1eU91bHBqTUxEM2E2MUJG?=
 =?utf-8?B?SVZxNXk5NXFoNEpxaFdMOXRaMDRUOE9RNHNidE1CWmhvRDdiQ01uampPc1Jk?=
 =?utf-8?B?L2NwZTZrQmUvQlI1cUVuMEc5VGNvZ3BZQXh2bGxvOTl5dHNSa2FlejR3S2Jl?=
 =?utf-8?B?S1k1VGlmTnhSWld0S3dGR2lQdUVZdEI0ZmpPNXF1WDZRdCthNnNPRlFaYWhw?=
 =?utf-8?B?ZWk0aXpDY2dJZ3Z5R1JQTUs4NUpBb3IyeG05M3BLb2Zva0kySTZKK1dONklN?=
 =?utf-8?B?cGJuNTJpMmZVdVhBd1lWVUM3L2dIZ3dtZngwQStWWEI3Vk4zeVFPZG4yRUhF?=
 =?utf-8?B?U2NrdElWSk03U3psZFhqbHdXelorWGdlMm9idkJEdno5VXR6RUtqOVYrTno1?=
 =?utf-8?B?eDMwdmJERTlxSGloT0daVzM2enpEMDVMM1lUcElyQkRpQTRIbnhKS3VYSzNJ?=
 =?utf-8?B?SDZTZWRERmQ1eGpVWnZ0QVpJL1VPZm8wZzM5VFg1a1lDcFIrQXlvemRobDZV?=
 =?utf-8?B?aG1MMGhXck03MGlobGFHZ05rYUMxM2I1YWpMQ0c3Wm5JWmIzc1hQWXd5U2Rx?=
 =?utf-8?B?NENwN2JZc01GeVNPRVZLVEN3VkVqVm5qNHllZDViRGJOemNiT0hDeWM3WDRY?=
 =?utf-8?B?ZnJ1SnFkM3FTeTlSV1k4djlRd09uVzdVNDNXaHhGNlhWMloyNlV4WVk5UHVa?=
 =?utf-8?B?WFdNQzhlY3VKMk9kYzY5MWRZMHFiMXpoWUFzM25DbTdaT29FY2RaVktQUlh4?=
 =?utf-8?B?VXJaUXp4QlVjUnoxaHFjekpjL0o4QW5tUUhOd0k2VkZuN2htVmJwTSt5MWxj?=
 =?utf-8?B?U3E0bmEvalhNU3RIVHRMSTVtQ2FsUnJpTDJIeEhHTmdVamFIeHpiU3hyTjF4?=
 =?utf-8?B?K0NQcmVLcXVYVjFxUkNHZUJMRHM1WEd3b0dsa2lGYmg3emUrYVd4QldtWGxG?=
 =?utf-8?B?alNuVkpSNno4UWlsUTRFc0UwYWFFZTlMM3JsVmYxVVNSaFpJZ210d0U3WE1l?=
 =?utf-8?B?MlgvN3lpL3d5Wmxua2NaQXlPME9hTUtrT2t5bzFNVk44dUZnRi9odVRWUEQr?=
 =?utf-8?B?NjFuY3ZnZ2dEdk1QTnVWRjVwdHp0WURJYTF1dkZOWlhHcmhnRWs1dHkxUVN1?=
 =?utf-8?B?NXVGU0lZWFpxR3Qya1BrMDBkWUJ0T0NwMDRGd3pqM0dwckNOOHZRSXlwY2NX?=
 =?utf-8?B?NFlIQzhzZTRKM05lU2Jod1V0MVE4YU94RVplY3NtbDcxUkJlT09yLzlXU2xn?=
 =?utf-8?B?QXFpZTEwUXRxYU9odE4yalhUcFkwdXhuYk5BcWQ3VEhOam84bS92VjF5Z2o5?=
 =?utf-8?B?dFFHbThsY0ZVaWErRWRWN3hjR0NsWUN6U1YwT3Q1V0REeXRXRWVUbFdNUm9Q?=
 =?utf-8?B?aG1HUVYwUlM3T0ZrWEZoeTlMaGZxdGhFd1NNMiszTW5ncCtRWEF2SGNrTGlN?=
 =?utf-8?B?cnNEbFJZbnZKcE5jSXVWaE92YnpUaUZyeUdHUlV4U2hDYUNzbFMvWUJGNTB4?=
 =?utf-8?B?SWk3d3UvREZvNXFUTWF3MzQxWlZMelI0UlhaV3hTRmo0ZmZSNSt4VWlnc2JM?=
 =?utf-8?B?Rkt3OXFHM1BhSUNFbkZhdk95NWRzeVNrNFlyaDFKUnJHQXN6VTkwUHY0eWZj?=
 =?utf-8?B?b1hHTXVnTE83YUpTQUV4anlVbWkzQ0VUaEJQbjVVdS9uQ3daa2pwelNITUlU?=
 =?utf-8?B?YTAyZzNJYmJCdUNBSEJCZUxqNWVONEJYenUzN0NSZjRUWWZ5clFqRWZQQXVE?=
 =?utf-8?B?SU9HcURjNmw0L2dMblNEMFUzZHUyNzY1SkRibUpiYlg0OEs0QU5yT0lCWVhQ?=
 =?utf-8?B?U01PWGNUSFpicWU0NGp5TUI0OXhKSWtPYzNlZjZseFk3Y0R5VU8za0llZmV2?=
 =?utf-8?B?Nng4VmtSdG1IYUtzWnV4OVNMVGNkZUZWMENsb1NVNU56V0xGdWM4WHRSb2t0?=
 =?utf-8?B?VjNFQW5iY0daQ2RIVWVjMHBzOUNDNFZyM1pTRWE0SzRoaEVlaWlMc1RVL0Z6?=
 =?utf-8?B?c1Z0TUtpajNvckp0OEN1MFJEd0JXL2hSZHRpbTVwdzlJVXluV1ZBcnA1dGVI?=
 =?utf-8?B?OVRsQTErZVlkSDZYVnU5NDRjd3lndTREdXlKdm01UnVrWU53RVBwWkx1b2xE?=
 =?utf-8?B?OGE5NklnaEZTUHZ1RitSaVlzdGdobjB1VG5Wb0R6RW1VUW05L3hEeWpvbnRT?=
 =?utf-8?B?YnAzbEZRNEZaT2d0SzBQSnFIalFQbytmM2FHaHM1RENzSkExK2prdDIyM0dF?=
 =?utf-8?B?ZU02d2RVMmlPZEVHa0RubThFa2FmdFVYMUlubEpQVGZUUlRwRHFPRTdxeGxj?=
 =?utf-8?Q?CyKVD7HP/Y02ctNEWl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4124f2-0dd9-48ba-0280-08df0edccb68
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 01:42:37.7521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARcmywIqIEFJ3p7A0P8B8qOC1juPoP3gY5hAfnnwREEF8cmocahOVvd5zwTbS6SnhNfPdfz5BZzt7izr2MicwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB938484

PiA+ID4gKw0KPiA+ID4gKyAgICAgICBpZiAoZmVwLT5wcHNfaXJxID49IDApIHsNCj4gPiA+ICsg
ICAgICAgICAgICAgICBmcmVlX2lycShmZXAtPnBwc19pcnEsIG5kZXYpOw0KPiA+ID4gKyAgICAg
ICAgICAgICAgIGZlcC0+cHBzX2lycSA9IC0xOw0KPiA+ID4gKyAgICAgICB9DQo+ID4gPiArDQo+
ID4NCj4gPiBJIHRoaW5rIGZlcC0+cHBzX2lycSA+IDAgd291bGQgYmUgbW9yZSBhcHByb3ByaWF0
ZSBoZXJlLA0KPiA+IHNpbmNlIHRoZSBJUlEgcmV0dXJuZWQgYnkgcGxhdGZvcm1fZ2V0X2lycV9i
eW5hbWVfb3B0aW9uYWwoKSBvcg0KPiA+IHBsYXRmb3JtX2dldF9pcnFfb3B0aW9uYWwoKSBjYW5u
b3QgYmUgMC4NCj4gDQo+IEhpIFBodWMsDQo+IA0KPiBZb3UncmUgcmlnaHQuIEkgaGFkbid0IGNo
ZWNrZWQgd2hldGhlciB0aGVzZSBoZWxwZXJzIGNvdWxkIHJldHVybg0KPiBJUlEgMC4NCj4gDQo+
IEkgc2F3IHRoZSBleGlzdGluZyBpcnEgPj0gMCBjaGVjayBpbiB0aGUgcmVxdWVzdCBwYXRoIGFu
ZCB3YW50ZWQNCj4gdGhlIHJlbGVhc2UgcGF0aCB0byBtYXRjaCBpdC4gSSB1c2VkIC0xIHRvIGRp
c3Rpbmd1aXNoICJubyBJUlENCj4gcmVxdWVzdGVkIiBmcm9tIGEgcG9zc2libGUgSVJRIDAsIHJl
Y29yZGluZyB0aGUgSVJRIG9ubHkgYWZ0ZXINCj4gcmVxdWVzdF9pcnEoKSBzdWNjZWVkZWQuDQo+
IA0KPiBTaW5jZSBib3RoIGhlbHBlcnMgcmVqZWN0IElSUSAwLCB0aGF0IGV4dHJhIGhhbmRsaW5n
IGlzIHVubmVjZXNzYXJ5Lg0KPiBLZWVwaW5nIHBwc19pcnEgYXQgaXRzIGluaXRpYWwgdmFsdWUg
b2YgMCBhbmQgY2hlY2tpbmcgPiAwIGJlZm9yZQ0KPiBmcmVlX2lycSgpIGlzIHN1ZmZpY2llbnQu
DQo+IA0KPiBXZWksIEkgcGxhbiB0byBkcm9wIHRoZSAtMSBpbml0aWFsaXphdGlvbiwgdXNlID4g
MCBmb3IgdGhlIHJlbGVhc2UNCj4gY2hlY2ssIGFuZCByZXNldCBwcHNfaXJxIHRvIDAgYWZ0ZXIg
ZnJlZWluZyBpdC4gRG8geW91IGhhdmUgYW55DQo+IGNvbmNlcm5zIHdpdGggdGhhdCBjaGFuZ2U/
DQo+IA0KDQpUaGUgb25seSBjb25jZXJuIGlzIHRoYXQgeW91ciBjdXJyZW50IHNlcmllcyBpcyBj
b25mbGljdGVkIHdpdGggUGh1Yy4NCllvdSdkIGJldHRlciB0byByZWJhc2UgeW91ciBwYXRjaGVz
IGFmdGVyIFBodWMncyBwYXRjaGVzIGFyZSBhcHBsaWVkDQp0byB0aGUgbmV0LW5leHQgdHJlZSwg
YW5kIHRoZW4gcG9zdCB0aGVtIGZvciByZXZpZXcuIDopDQoNCg==
