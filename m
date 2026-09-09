Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E042E229F;
	Wed,  9 Sep 2026 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919180; cv=fail; b=PChiqzjFKrHmFB1CQNNPJ7u4LWH+bzGyvLeUiAMRctx45hEd+FitV5Uj4bfoN89etJtpWLyFc2aU7Xq6X1ZdMvoAvNnVAWewBXy/8aDQZV5x1F7sCwefITjQDuklPY8Ouk6K4mGT0a7fgiZM/NuuBONvVrI7TPDM2PBtdNy4kwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919180; c=relaxed/simple;
	bh=6g59slaf6c2HrKLkM+8Z3Pdr6x9xHrXlzCV4lpAZDIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cof0q/zF2rb8MFcf581sgHTre/pOPnQi9SUuKhITtzPHasLp8/ZsHSaONdyvHO7gFKOCCLShyXUV22PnHstY94YSCchN7r8bAX3IZRB4zf3kC/ztSH9RseGZyvzkVbLLiw7weS3K7rRyTY1re0OMmelZrgE8CN1bGw/DGkz0vS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l29snmSE; arc=fail smtp.client-ip=40.107.130.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l29snmSE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xns7s5p17sDV/WNyeCos7BjQzyLjyxs5Iw8XBXT0AjEKBq/MjUOPh6ZseD0Dgoy/8J3/414SknbwumWg5pH5y6oeB1Z6inpj8KEG7bwoNHrb6pRE9vjsVAbVYBDxFs4AtZyy/0kua7bAUGXTS3QXE0F5K9wZT3a85i34rFdxvOloRe/AgM3dy49fnfAORRH5WGIGi6XwKeWA3pavMKiiz4XFTMWw5LGHxTMMk5c9QX01Eyb+KJgWqsZaZ/+QIDBJ8L8IfpQn3mZ5/O848lpimr/y//DTSH9vVCwfD3+oSJQinOCfvCvHgHWwC+s0Rxv3iFvAJY8hvzS/f1Pzhr0nhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g59slaf6c2HrKLkM+8Z3Pdr6x9xHrXlzCV4lpAZDIw=;
 b=hdwUL6J84qw9KXSxYXEfIGQ2JqRW08j3TduTXRwwuMvkxGSrkNih+SEmesAhhM+TUvJyo68ENOn5T5OyL/jsxhAKAqbg6YcTWy78G1CoQaOxHakWrcMO8Nvv7MQpv5/SvNQKoulBf/+vJ82TAXD+Y4uBIAP77g106l7OXAuY7b5yM96cwK8xovzi496v5W+lm0Gz/w8GcwBe5GNOrwHLlevE8Z98iUfLazBI89vYgGN8gqfjx6erb/OjpH6U5X4Amo1/v+0XAtn7/ALgE/aiJqfuEsjfxLPqfeb0foI8TZiDDlUH93CbELoSXkp2NWYgv91JlgxtR+/0PXeUAyo19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g59slaf6c2HrKLkM+8Z3Pdr6x9xHrXlzCV4lpAZDIw=;
 b=l29snmSEQ5PxJw9GNbtJfi698uJj2Y01dQhZEVaUplekNV0kq65mYpKykTpzH4KiX2T/1t2XT3lUSuC7k1IHieXi2sI5b9MEvIAM1K1P/Vbu+/tbxP2BGRK7hub/JbgpOoBtWAcGN+hI32ZnjLGHH/dY/ekh3o+hsEe4EtmknkjZuDUJwIUnBbfh3HoHO1KtYNn8rh6qg6SbO+eJYuhuwXww3BBZtlV348RgifLADhsvjimInlgTgyGeOq1Pfzgc9vchMBVczcM4i66UnCs7L4IAvGcmqGi4eDcR6qSYBSH37RJZoHL2h6n8VKfnL8pY+YblsxPT/CIrUukgZ0G2lQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PA4PR04MB9437.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 01:59:32 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 01:59:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shengzhuo Wei <me@cherr.cc>
CC: Simon Horman <horms@kernel.org>, Phuc <phucduc.bui@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Troy Kisky <troy.kisky@boundarydevices.com>,
	Fugang Duan <fugang.duan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
Subject: RE: [PATCH net v3 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
Thread-Topic: [PATCH net v3 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
Thread-Index: AQHdP6/enOlQx+B/W0ig/sWgTmcombbFfiYA
Date: Wed, 9 Sep 2026 01:59:31 +0000
Message-ID:
 <GV2PR04MB117393EBD54866BE2737F693288B02@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909-fec-ptp-pps-event-uaf-v3-0-bead12c29a16@cherr.cc>
 <20260909-fec-ptp-pps-event-uaf-v3-2-bead12c29a16@cherr.cc>
In-Reply-To: <20260909-fec-ptp-pps-event-uaf-v3-2-bead12c29a16@cherr.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PA4PR04MB9437:EE_
x-ms-office365-filtering-correlation-id: a84c2bd5-0c71-40d6-6660-08df0e15fd81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|19092799006|38070700021|10067099003|11063799006|4143699003|18002099003|56012099006|22082099003;
x-microsoft-antispam-message-info:
 m+aIRhnkuaVPziJRIJ+6xGLLium0+ifCp9wVkgL1E1nIvAr4mK+Mgtbf3VqpbAR1txcv53Sib8B8UMwcPhqHYE0ZLFzHVxLge//+ntseQoinvsU7KYQoEf1nrumDGzCNWNAkifUQ5NI+miPXDdbbX7/OaR6Kx31IjM28JESQEBcYBPylRfwcJrX6u2oKf6EX+QCzzVWxlxfkQCrLpaC7us/1mhQAT0KYhDBF4iEliZ4LbJx1Lh4QhKZ9/HeJzJCJFQ745Tf3tX0DQo94DbadGVm5tr5mQI2TysWxNdKVcSzEU6E95e1AfhgByyzz+FAfaMpuJn/8L6ILoc7BkZb4n93mku/GCO7jj8gAABw1sMdp+ot8W1CX66WHRIE0QBquQ0ujHHe5l6enx52gkpOh0n4ijwi+CvUxq8cp0fh1y+cDgU7PjyjW/3xhDGXs+ajNVIwwVZMdCZZ5vhtfjN/5ghEH3Kubv5AedOvgDbGEBMMy5PP0nlDTNEjpbXJViXd7qzfIOKFhF/oBuXnpfQbpnlntHv+sgNw0NHUQJ97rxNEuunr4y3AU94emVgRwLYJlhGmt/1a7VFChVOCYQqEy2s2av4/iQjNdtzI9hNBCNfil8QQxhT5DPdA4jh+bn8dk2U/vNEdRtimuLFPs47B6Z1LtDaRrqEW6NiXDhCQ2kwSCQhsygdWW8+lehuMeRO3qBKkJd3omXJqKt/cHy06IIFBNUPcp4aF/8nvY2E3ShX0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(19092799006)(38070700021)(10067099003)(11063799006)(4143699003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K05QalovOUZ1UmtUanN0ZzJpYVQ2QU9ZZE13Vm1YTnd5azRYTFRRd2tQbzBu?=
 =?utf-8?B?S0k4NjlDbForU3NFbWpQbk41Q2lDYU0yUUxIeVZDZTMwNkJYK0xNOEsrSWhC?=
 =?utf-8?B?Wk1neXp0SWZrK1JmcGdlbkJmU0RRYTFyM3N5cjZOa01tRW82NWx0bGIrYW4r?=
 =?utf-8?B?SWRUQjBsV1UyRDJBbWZxMTVIK1JENDVuWTJPTDNUVjZwbHJMYnMxaXMzUFIv?=
 =?utf-8?B?QnZtOFNhWTE0ZHdVN1phM2NwZm50QnRVZSttUTBvYUk2WitRcnFGTmhRd2Z3?=
 =?utf-8?B?SkRoWXJiRHJWVjV0c3RmYVZRdjFPZEw5SzVlZTVmaFlWWVlGTW1hZlZVNkxE?=
 =?utf-8?B?bHMrbG9tOVhETkV2ckZOalJJcHZlWW5oTVRodzI3Z0JMeUxDSG1nZFZJVlBX?=
 =?utf-8?B?OWNwRDAyTlpSS21lVUNmUmdCUjBBZFBtdWRwTnBxbWF5emVWdERLTjlWbTZv?=
 =?utf-8?B?QWF1M0FPemszY3RLUXloNUk5WTV2RHI4Z0dqYW1VN3VOY0gzeWJqbjFDelJy?=
 =?utf-8?B?ekNIQkVONmx5Y0daL2JENytFYU5zSlFMWWlvRVRaY3NLWWMzMktMQjNZL0R2?=
 =?utf-8?B?Z2RXSXF3em1GQ1hZSHNTTGVoL1FFUTJGMVhNZDNjby9QNXZTNWhCZXJRckFB?=
 =?utf-8?B?c0h6Yk01YU5CTmJvU1JIM1UzTys3Q1FSUHUwYmZoWTIwOElBWW01UU56ZGFt?=
 =?utf-8?B?aDdvaENJbnVIVHhuU2lZdlFaRUk2TVdVTjhnVnpuUGJBTnJXb1ZzeVl4Z3hQ?=
 =?utf-8?B?dll3UWExbFNsTnAzbUN6OUFMOGg1TUVtNHlScm53dDRlLzViNVdzdFJsWXVn?=
 =?utf-8?B?eU9hcExnN1B4ejF6eGd1V1YrcDNPc2ZpNElKSUxic0lNUm1XWFpjTUNtTWFW?=
 =?utf-8?B?RjREc3MxeFgzQllXM3pOZDdCTEZtWXkrSTBzaG5mSEE4ZU9aczJESWtUN0ZW?=
 =?utf-8?B?WTJtamhURlpXTkhnNi9NaGh6am9nVkx1VnphbE8rRWFLaTBpZkdhVVVPVmhz?=
 =?utf-8?B?ZU15eUNMeFpuN2NlaitoZzVkZnVkVlJucjA2dWlpVkJWNTQ4QmVRVWVVQXIv?=
 =?utf-8?B?Qkd0Y0RQMEVsSjFISjhPOUJnVEZJWkI3ZVlvcGZyR0NaemJhUEo2cjlCMlFh?=
 =?utf-8?B?azVTT0RCOE5KanA2NmV3MGcydXJuNUpRSEJTRnhhQ2svZHBsZGRmZDNWYU1M?=
 =?utf-8?B?Y0NuYXN1cjFReU52Nm9jZi9Qc3V4d3ZtUmVsVUVHTHI2TkxVdTkyay9jemtJ?=
 =?utf-8?B?RDZBUldmckNOZUtMWExVb2hIWlloUmxQeXg1b2d4bEVMWjkvUDRxVDR4Qno0?=
 =?utf-8?B?dWtCcVcrSE9NMUh4K0R4Q0xzQWZCTXJTaFhVeHlBL2VlRFQ2a2dKOTR1dHhN?=
 =?utf-8?B?UVBEWDNJVXg0eTNrLzJwVnJFYkFSQklyU0I0REljbktJOFl3S2h1a2VvaFZH?=
 =?utf-8?B?V2hYNDFkUE9kWGQ5ckNMV3RSa1ppb1FDc2RLakJQSndCZTNPNzE2ckRBUVF4?=
 =?utf-8?B?UWZVUldQWmhSaTcxYVB5b2VESG1sZHZlNHJyb0piU0xkQ0hRUkF5NUV1UnVl?=
 =?utf-8?B?cmhpZ0k5cS85ZFE1c0tjUFlSMUNscmd6UXZUVFFpekFydWUrMHVhR2wveHJF?=
 =?utf-8?B?aXRPZDhmMUx4MVU4ejE1eERzUFcrOThQODRCU25NU0dZOVRSRGVvUUpSSkRC?=
 =?utf-8?B?V0VYQXluZTV3OUpSNDFYL2ZwRHlaWlA4ellJekkrdTlKUU1jN2QxanBPNXBH?=
 =?utf-8?B?czFmNjlFYnAxOUJPOUVrbHBWeEJIbFR4cGFMcVdqUnRQeDBpbDdjYXRiV3Rv?=
 =?utf-8?B?ZGxTdWMzL1JjUm5LZ2U4T2cycldmeU1wMG50TU9sek9Hc0hrV25iMEFaOXlM?=
 =?utf-8?B?SU8zdTJmUW02cU42dE9oWVlXazAvUi9DWWk0WllUT2t5NnFCMjZXbm15MVds?=
 =?utf-8?B?TWVKaUFvMytyMXNPV3NpUXd5THFSY09sbWR6R0tPVVZEaU1SM2J3WkZtQzdO?=
 =?utf-8?B?eG1TbXVxY0ZZRVhTQjlScldHQldTQWxJajhDRjRWSS82UE9PaWJCUGQvNEdw?=
 =?utf-8?B?RWVPSjd4NTVmT1V0aFlyK0w0UDJSQWUzMHVacUUxbTJHZ05VdittTjFtcUlE?=
 =?utf-8?B?akx6NE82TTQyNTRmUVNIdGVRTFl6U0d5dlRKZG5PNTBMTk5GY3phOVpMMkIv?=
 =?utf-8?B?dm5weWFjS2VRNS9JdFJ1NHIwQWR1TGNLcXNYN3Q3eXJhQUQ4djN4SkhwQmFR?=
 =?utf-8?B?TFBwQ2grUXFyNnU3ODVUWW5ES0hzbjJJS0lhK21ONFkwb2dWdndxaGl4ZUty?=
 =?utf-8?Q?EjjV+MZ3Je10nBuTvJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a84c2bd5-0c71-40d6-6660-08df0e15fd81
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 01:59:31.9795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pr9n2Nq7CUnE55SqhyBgUC6g6ntUIjgXXxxnEuxJq3w5c4CHVSd1C+R3nKSqEAjYgDpr570ZKOfaE0k93pquoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9437

PiBpbmRleCA3MTc2ODAzMTQ2ZjMuLjk2MGI5ZjAxYzUzMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlYy5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9mZWMuaA0KPiBAQCAtNjcwLDYgKzY3MCw3IEBAIHN0cnVjdCBmZWNfZW5l
dF9wcml2YXRlIHsNCj4gDQo+ICAJLyogcHBzICAqLw0KPiAgCWludCBwcHNfY2hhbm5lbDsNCj4g
KwlpbnQgcHBzX2lycTsNCj4gIAl1bnNpZ25lZCBpbnQgcmVsb2FkX3BlcmlvZDsNCj4gIAlpbnQg
cHBzX2VuYWJsZTsNCj4gIAl1bnNpZ25lZCBpbnQgbmV4dF9jb3VudGVyOw0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19wdHAuYw0KPiBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMNCj4gaW5kZXggNTY4MDFjMjAwOWQ1Li41
OThjZDgwMjQxMjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9mZWNfcHRwLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19w
dHAuYw0KPiBAQCAtNzc4LDYgKzc3OCw3IEBAIHZvaWQgZmVjX3B0cF9pbml0KHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYsIGludA0KPiBpcnFfaWR4KQ0KPiAgCWhydGltZXJfc2V0dXAoJmZl
cC0+cGVyb3V0X3RpbWVyLCBmZWNfcHRwX3Bwc19wZXJvdXRfaGFuZGxlciwNCj4gQ0xPQ0tfUkVB
TFRJTUUsDQo+ICAJCSAgICAgIEhSVElNRVJfTU9ERV9SRUwpOw0KPiANCj4gKwlmZXAtPnBwc19p
cnEgPSAtMTsNCj4gIAlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbChwZGV2
LCAicHBzIik7DQo+ICAJaWYgKGlycSA8IDApDQo+ICAJCWlycSA9IHBsYXRmb3JtX2dldF9pcnFf
b3B0aW9uYWwocGRldiwgaXJxX2lkeCk7DQo+IEBAIC03ODUsMTEgKzc4NiwxMiBAQCB2b2lkIGZl
Y19wdHBfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCBpbnQNCj4gaXJxX2lkeCkN
Cj4gIAkgKiBvbmx5IHRoZSBQVFBfQ0xPQ0tfUFBTIGNsb2NrIGV2ZW50cyBzaG91bGQgc3RvcA0K
PiAgCSAqLw0KPiAgCWlmIChpcnEgPj0gMCkgew0KPiAtCQlyZXQgPSBkZXZtX3JlcXVlc3RfaXJx
KCZwZGV2LT5kZXYsIGlycSwgZmVjX3Bwc19pbnRlcnJ1cHQsDQo+IC0JCQkJICAgICAgIDAsIHBk
ZXYtPm5hbWUsIG5kZXYpOw0KPiArCQlyZXQgPSByZXF1ZXN0X2lycShpcnEsIGZlY19wcHNfaW50
ZXJydXB0LCAwLCBwZGV2LT5uYW1lLCBuZGV2KTsNCj4gIAkJaWYgKHJldCA8IDApDQo+ICAJCQlk
ZXZfd2FybigmcGRldi0+ZGV2LCAicmVxdWVzdCBmb3IgcHBzIGlycSBmYWlsZWQoJWQpXG4iLA0K
PiAgCQkJCSByZXQpOw0KPiArCQllbHNlDQo+ICsJCQlmZXAtPnBwc19pcnEgPSBpcnE7DQo+ICAJ
fQ0KPiANCj4gIAlmZXAtPnB0cF9jbG9jayA9IHB0cF9jbG9ja19yZWdpc3RlcigmZmVwLT5wdHBf
Y2FwcywgJnBkZXYtPmRldik7DQo+IEBAIC04NjEsNiArODYzLDEyIEBAIHZvaWQgZmVjX3B0cF9z
dG9wKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IA0KPiAgCWNhbmNlbF9kZWxheWVk
X3dvcmtfc3luYygmZmVwLT50aW1lX2tlZXApOw0KPiAgCWhydGltZXJfY2FuY2VsKCZmZXAtPnBl
cm91dF90aW1lcik7DQo+ICsNCj4gKwlpZiAoZmVwLT5wcHNfaXJxID49IDApIHsNCj4gKwkJZnJl
ZV9pcnEoZmVwLT5wcHNfaXJxLCBuZGV2KTsNCj4gKwkJZmVwLT5wcHNfaXJxID0gLTE7DQo+ICsJ
fQ0KPiArDQo+ICAJaWYgKGZlcC0+cHRwX2Nsb2NrKQ0KPiAgCQlwdHBfY2xvY2tfdW5yZWdpc3Rl
cihmZXAtPnB0cF9jbG9jayk7DQo+ICB9DQo+IA0KPiAtLQ0KPiAyLjQ3LjMNCg0KUmV2aWV3ZWQt
Ynk6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KDQo=
