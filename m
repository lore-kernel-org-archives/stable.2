Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023118.outbound.protection.outlook.com [52.101.127.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073F42E8E5
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320407; cv=fail; b=kgR6ERw/pCWPDpNIX5c9e8qa5vpHXBq1OlMHgHkKBSOEg0/AdWA/akh+GBET3EEZB5C/VH/vMyZCN2+TfRAPzX4OcjzNc8OZ8tndQDT/8sazlwxSZDp+5uO/MT3Yxstdm6filIuMT62Cze8jXkusxqkQlU21vwJgDPhvbRorzq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320407; c=relaxed/simple;
	bh=GAwG2h0I98yaqgUetDjWBdJXF8tPBIlpXRVnzw+gDno=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IHretAkVPcWnVoxsgB3vDwYd5HxIBwqf7qPCbaWe/2s8O44n2ZmVO/V9lR5POq6LG2aN6R6CyTaXrUO6S02l51ytELg/lo8d8fyOuHwpLuJbxdcjRT3xX2r2LklBlnp5SjVCQhoNXNW4bfGyLgaFXupH6V8OPoYFo4cbcsAnRSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=ZJh6LAne; arc=fail smtp.client-ip=52.101.127.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="ZJh6LAne"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjaW5aJ/5nS8XnXIiksyT3HhZ/p1lpI4whCexkP3lfNJBvWkla6MWksThwXxB8eG+yVgk6aJJEgwRmgv4Kd0rU32pLpsU/8Q/VfaT1w/o1mfTAji/PYI00m8ZTRE9f9WFh55j3iJg7Xo4RwgPvYM/jeZsfxRyD9XHY5zlKPfZ9eIsfYpDWE0tlOJZeUhdr0xCadOTNCYimaLmckI3mLpYtQoesNUt6qdYgtbudSfeAtSLrE9M3kkNQkO0NGi7jrohKAkNntmxQ/B5IZ/FNavsk7kVhqmFLsUR2Fmlt8F/PSCrLPYYn9lW323uuGxwAdpAGTBGzkJ0yq+DhXUapI0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAwG2h0I98yaqgUetDjWBdJXF8tPBIlpXRVnzw+gDno=;
 b=K2tw/lqURBQrAyaxg2Uwn28fyt0mJmIfgAuQ3fBhcM5WJlMolgVlHXiGJx3bYOj+p3djiHtajVn8yb0VBK3kYlR6ejsChisJMwmfp7x0oJCVZsf/vvPkYKJbZVvrR6dHgK35IkGr6HiqwcurB514WzlZa+mQujP6kYQS4Lo/geaNnA4m5Un2TwLcQZYSytLAmW/0k3r0ukcdIX4NbKREKwh8ERAj0D1TjifSCR2zl9DtghmOaoyf63+WkUVpiqc81bRMo4pmbxYtzhtWyGnYn5257Mg+aAY4hsr/Bw5cmuDfEqvcQ3EFdHMRJFkBDWyzmfRPb2C0opDckKRkUcL+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAwG2h0I98yaqgUetDjWBdJXF8tPBIlpXRVnzw+gDno=;
 b=ZJh6LAneOk/aRDRxUo/XNn1vktBTtaBmRZrhg40dVN5c5nmXZUtuIlZPIvxbVCiHr1Ml3LPvHh47N4QU8PBxi8gnj+DHiHOo7uEez5R5lrgGWcMZi+/8bfY0JTVvrkdFyoq5A2BrW+QLFHQ29s7HkQuuTCozqpTCPNwzr+//aRo=
Received: from SE3PR04MB8921.apcprd04.prod.outlook.com (2603:1096:101:2e8::6)
 by SEYPR04MB7231.apcprd04.prod.outlook.com (2603:1096:101:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 06:46:32 +0000
Received: from SE3PR04MB8921.apcprd04.prod.outlook.com
 ([fe80::ebed:1dee:3932:9ba2]) by SE3PR04MB8921.apcprd04.prod.outlook.com
 ([fe80::ebed:1dee:3932:9ba2%3]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 06:46:31 +0000
From: Ao Sun <ao.sun@transsion.com>
To: Jiazi Li <jiazi.li@transsion.com>, Hongyan Xia <hongyan.xia@transsion.com>
CC: Ao Sun <ao.sun@transsion.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Avri Altman <avri.altman@sandisk.com>
Subject: [Linux-eng PATCH v2] mmc: block: fix RPMB device unregister ordering
Thread-Topic: [Linux-eng PATCH v2] mmc: block: fix RPMB device unregister
 ordering
Thread-Index: AQHdDRMtSMbvAgWYL0yaxj7pdNDGLA==
Date: Mon, 6 Jul 2026 06:46:31 +0000
Message-ID: <20260706064530.271-1-ao.sun@transsion.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR04MB8921:EE_|SEYPR04MB7231:EE_
x-ms-office365-filtering-correlation-id: 21ce98a4-0c6c-41e7-47b0-08dedb2a507a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|42112799006|23010399003|366016|38070700021|56012099006|18002099003|5023799004|11063799006|6133799003;
x-microsoft-antispam-message-info:
 PcKB7CFnQWAeG6ro0jV5WJvfO5DwgtaLBQlBt5ayruzh2avOwUJHXZ2M09vVRu1Usbg6ORNLYIgtsOvhXYTyZkljhHxD88QRC/ItQqmU04+wCBrW/ZiU3SLgO+SAX+R6rTBx6GoVPZLfRpZCEsncE4E2mx/iY9ddD0j6Vt0UOlZv5uwYY88iGOFMzetCqAjCKrAJoxTsD6jFdJ0rNlFbcXvhDP+UuyGkQxsDKAJ8DtCN9GO64AmX/uxQpUBui1jtcATUjoINavXWpYrqu7pnRezGUfo0I7gd2W1wMLn4MgMjozpvX3u659LpyXJ2mJua8QtYip3b8oKZV56DIJNn3S7mtnPIXUyH0ICk+5rxA2Vimxd+ei6ohdVyp7GR8iB2QuXs+UeDKQ9VNG/tPHW8oHaiBMaXZJfRLNRbO+faEGy9spTw9XYIEBMBlNHx+9k54RsOxYPLKFoVuovdP487KzhMcX5ZSf9LfKmMZQB7imJDkPVBdysSiblu3yqwlwcBQ/wBbx5OBV7HnTZSL8bxSKqbGFf+K0E/Q+O67NCiNxgd1f+gJzK1hEyc/OFHUoi6OR8L4dw5BBrwIEVwMB6JO0GGeeYkv62HJN8oGK97EqUyw+HEu8Kbk4wXhAmTrYADeMzWklJ7MB0qGh2LO5FFG19YTa1AX9/F2hvhdwRiq5QzyYaEKvnhddBspq4EGoenpnYf51hzGdacgv6TUjYK/mIYjCUIzXd1gGqK1McHKKc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR04MB8921.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(42112799006)(23010399003)(366016)(38070700021)(56012099006)(18002099003)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHhUQXRpczlpWUdGdXh6VTVmVURxaXBnOE5ySGgra1FUL2NxcHhqUmZZL1NY?=
 =?utf-8?B?TTdEYUhnb051ZS9nNS9sbmFxcExhYzhpTENkNlpSWlRSdEFOK3JWZzg4Wmtr?=
 =?utf-8?B?NWd2ODI0UEhaSU85b1BqU0UvN1dSL2VBMjI0YnJqZnVJVFd0bFg4eUFvbmtE?=
 =?utf-8?B?VDZvbE1XYWkzNzU1MkpuVWJHZ2NIc1VrdjFsNTB2NjFKZ1ltRURBKytoUlNJ?=
 =?utf-8?B?d21lVU1UQi9kL3hLUzFIOTBvSEVxeDQxQWZEMy9hQXZQQjZQdGlpWmozbWV2?=
 =?utf-8?B?ZGYyMjUvWWI5TWJjc3N1VlJ1K09NT0VIL1R3VzIwOHhxNmd5NXZNcjI0QzF4?=
 =?utf-8?B?NGI0V2lzRWhkV2RzdnBLRGJKOHp3U3plUnVseWhjM2pUVzRRN3hKZlJaZkRK?=
 =?utf-8?B?Y2JoWDZUWEZtT1ZhYThaaVArOWxrY1pZVDZ0Vk9QMllvMTk1eEhVeDZ4ZjZy?=
 =?utf-8?B?RkpFNmNHSXE3TGh0dFIwL0ZFdjhDRFZTVHp6a1h6dldqMmFDdVpna2lLYk9a?=
 =?utf-8?B?WVMyS0IvVEVOeUxqeU1QK2xTNG5ocDFUNW55eS8zSEVtOUdXbHJWcFZ5RFRa?=
 =?utf-8?B?Uk1FWVFLQkFjNTRpeWdVbStJampwTnJlR2x2SEo0UTg5Snp0c3JEWkxyQlBI?=
 =?utf-8?B?cTRXSTFwN25LY2NncDJKMm1hYUFQYmdqMWQ3c2pQNGFybTduYUFwcGtpWklC?=
 =?utf-8?B?V1hKeXNQQ2pjeHVHcmRmZ2pMeXZQaXBTMGFWNXZ4ajF1MldqNlhud1cvWDMx?=
 =?utf-8?B?ejZGcUZIYng1eVBkemJSR3VJUlAzb1FoMlVnZkt4djdLUm9CcFNINkVVZ2Ex?=
 =?utf-8?B?R2VPSDB3R3RteUg5U05kRDQyc2MrWHdSeXppZDFhSnFPbVZUT3J3dzU5dHVC?=
 =?utf-8?B?VEh6a2YzUXZkNSttcmZlcGMrTktaT2NGd0FOZXZVaG9WajhIMGtaZkp5RmhN?=
 =?utf-8?B?eWhWOGt0aDhwd1o1bFM3K3E0SGJyZVdpUW5qSzl1M0hkVE14dUtTbDNodDBM?=
 =?utf-8?B?QnRNcEZtY0sxeGJsK29Rd201UVRIZHNBYXpZZytHR1NoZG5KaUROL29Bc0ZI?=
 =?utf-8?B?QWZWTDV5bmhhTjhwcXpjOWFYRFVranJGR1lMMUNwSk53VXN2bllVY0Y4RTZB?=
 =?utf-8?B?UFB3ZlJwcUVMNFhsQzVHNVVkbmNLOTVNZVVNd3NjalRhUmVTQjM4MUFUblVF?=
 =?utf-8?B?YVArck1aS2x0aTNoMzgwZFZWMktEMVJ1c0RjS3VvRk1SU1NiYWVMTVdZTWtL?=
 =?utf-8?B?Wlc5dFlZVmtCTy9zcUpOWHQxZXhLSGhWdTN1UzhZeEVGWEVYaDJGL0R3SlNX?=
 =?utf-8?B?TUk1eGNPYVgya3d0V2xQU29BbDhsanJtVkdnTW5yeHczVzJucE9xWEFQaU13?=
 =?utf-8?B?ejU4c1BFUSt5V0xIY2laSWo3L21rTkgzUy9CdjBYNnF4Yk9YbE5oM0x3NWJz?=
 =?utf-8?B?c2owSlZhTTNweVFLaGFsWmRmdUxncDlhRmpWQzB0emNSY3ZyWjZyTHltaUdF?=
 =?utf-8?B?NmliV0sraW9xalZLaGQrUTR5ZTRnREFkWno4RUd6MHlpSWFISGZHbjk4VDh4?=
 =?utf-8?B?M1pEMzFTT09XT2k2c0hYdEIza1VqdEU4VGxHTjQxNEh0RDgxQjUzMnl5eVZy?=
 =?utf-8?B?V28rWEJEeERqelBEL2RhMWIveG9wWk1Ra1lDZjFYOWhzTnJuaS9aZDRtMlp2?=
 =?utf-8?B?end1RjJuZTBlcnhBaHlJWkF4VmdLOEp1SUVtQ2oram9BRlBZVlYrbzNvdmor?=
 =?utf-8?B?MnQ4M0o5N1d6U1liT0c2Qmxac3Z0bEJuVklMb1NWSmZPQ01SYVhDRE0wRVdJ?=
 =?utf-8?B?d2FEWElWSkpmN2IwWFkzQWxzdkw4bnJIZDQ1cnMzbVZrU2ZZOEJUZU5wZXdQ?=
 =?utf-8?B?eDZ5eDNrVDJKZmZQUWw3aERNblpFUmY1OURSVWFhdmpkNW0wbHVxK3RqdUtV?=
 =?utf-8?B?VmNYQ096cngxR3BZRUppMmczWVFyNEF6QjZLQ1MvSzk0WCtsMW43V1NybTRh?=
 =?utf-8?B?L2RLWU4wWVhqSlFGNE9JaldFSE5MQzdwUE8wV080Q3lyV1g5MjdSanR2eTJW?=
 =?utf-8?B?dU5aNk9CUnB1eFV5N2QwejhRQWl3Wkc2bExTRmJXcjVRYlArM2hNWHpqbjlH?=
 =?utf-8?B?eEV4ZG5zTFV4TDJESUwySVlqK011czdIZ0thM1lkTHRFQUFBSXBtZmpBWXpZ?=
 =?utf-8?B?TkVVcXp5K210eHZKbFhXdU9OZGhOc3hQMDNCTFZjVkJlcmg2cnE5WUtncWZU?=
 =?utf-8?B?OUZlSi9hMnZDbTRHbDd1aXBCdkVJMmtxclBrRk1URnFKdFVINmRNWGRjc1Qr?=
 =?utf-8?B?NThwd21SQ0xWQ2pqNUkvS0k2SUhXcHN0Rm5mRS8xOHFNMXpQbVVVdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8921.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ce98a4-0c6c-41e7-47b0-08dedb2a507a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 06:46:31.7987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ophFUOijopn8XRGh7pxmuypPjB8Cf4OAZZC6uJcIwowKVMI0AJWKbC1wrizTCxCUnZc7GaK4R5wtKqYB1nvKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7231

RnJvbTogQW8gU3VuIDxhby5zdW5AdHJhbnNzaW9uLmNvbT4KClRoZSBjaGlsZCBSUE1CIGRldmlj
ZSBob2xkcyBhIHJlZmVyZW5jZSB0byBpdHMgcGFyZW50LCBzbyB0aGUKcGFyZW50J3MgcmVsZWFz
ZSBjYWxsYmFjayBjYW5ub3QgYmUgaW52b2tlZCBpZiB0aGUgY2hpbGQgZGV2aWNlCmlzIHN0aWxs
IHJlZ2lzdGVyZWQuCgpSZW1vdmUgcnBtYl9kZXZfdW5yZWdpc3RlcigpIGZyb20gdGhlIHBhcmVu
dCByZWxlYXNlIGhhbmRsZXIgYW5kCnVucmVnaXN0ZXIgdGhlIGNoaWxkIFJQTUIgZGV2aWNlIGlu
IHRoZSByZW1vdmUgcGF0aCBiZWZvcmUgdGVhcmluZwpkb3duIHRoZSBwYXJlbnQgZGV2aWNlLgoK
QWxzbyBkZWxldGUgdGhlIGV4dHJhIGJsYW5rIGxpbmUgYmV0d2VlbiBtbWNfYmxrX3JlbW92ZV9y
cG1iX3BhcnQoKQphbmQgey4KCkZpeGVzOiA3ODUyMDI4YTM1ZjAgKCJtbWM6IGJsb2NrOiByZWdp
c3RlciBSUE1CIHBhcnRpdGlvbiB3aXRoIHRoZSBSUE1CIHN1YnN5c3RlbSIpCkNjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEppYXppIExpIDxqaWF6aS5saUB0cmFuc3Np
b24uY29tPgpTaWduZWQtb2ZmLWJ5OiBBbyBTdW4gPGFvLnN1bkB0cmFuc3Npb24uY29tPgpSZXZp
ZXdlZC1ieTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHNhbmRpc2suY29tPgotLS0KQ2hhbmdl
cyBpbiB2MjoKICAtIGFkZCBGaXhlcyBhbmQgQ2MKICAtIGNvbGxlY3QgUmV2aWV3ZWQtYnkKLS0t
CiBkcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUv
YmxvY2suYyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYwppbmRleCAwMjc0ZThkMDc2NjAuLjU0
YTkyM2JhNGYxZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jCisrKyBiL2Ry
aXZlcnMvbW1jL2NvcmUvYmxvY2suYwpAQCAtMjcxNSw3ICsyNzE1LDYgQEAgc3RhdGljIHZvaWQg
bW1jX2Jsa19ycG1iX2RldmljZV9yZWxlYXNlKHN0cnVjdCBkZXZpY2UgKmRldikKIHsKIAlzdHJ1
Y3QgbW1jX3JwbWJfZGF0YSAqcnBtYiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwogCi0JcnBtYl9k
ZXZfdW5yZWdpc3RlcihycG1iLT5yZGV2KTsKIAltbWNfYmxrX3B1dChycG1iLT5tZCk7CiAJaWRh
X2ZyZWUoJm1tY19ycG1iX2lkYSwgcnBtYi0+aWQpOwogCWtmcmVlKHJwbWIpOwpAQCAtMjkzMCw4
ICsyOTI5LDggQEAgc3RhdGljIGludCBtbWNfYmxrX2FsbG9jX3JwbWJfcGFydChzdHJ1Y3QgbW1j
X2NhcmQgKmNhcmQsCiB9CiAKIHN0YXRpYyB2b2lkIG1tY19ibGtfcmVtb3ZlX3JwbWJfcGFydChz
dHJ1Y3QgbW1jX3JwbWJfZGF0YSAqcnBtYikKLQogeworCXJwbWJfZGV2X3VucmVnaXN0ZXIocnBt
Yi0+cmRldik7CiAJY2Rldl9kZXZpY2VfZGVsKCZycG1iLT5jaHJkZXYsICZycG1iLT5kZXYpOwog
CXB1dF9kZXZpY2UoJnJwbWItPmRldik7CiB9Ci0tIAoyLjM0LjEKCg==
