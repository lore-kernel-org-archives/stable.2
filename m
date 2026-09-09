Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023084.outbound.protection.outlook.com [40.107.44.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9CD377023;
	Wed,  9 Sep 2026 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933559; cv=fail; b=G5O0CtCwmIW6C6bQT/9eZ9mJn3QyLS/leZHD+j05e2TdcDcdWaTLC6pP8yMlBHqmYDuor/d/ymkiOHvA1mYuAMbXv23LADkV4ysBtrMruwAnJReK648su3VdIssMfWgLvd3dPnIx0kRDJiuJ0agaVoF5eZHsMQ1cKkydwSDTX5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933559; c=relaxed/simple;
	bh=Prk7Q6+IZODIKzq29DZ8mk+Y47FFqL4CU7RnX+OkQSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CFYBPBgV/4p3RBVW8GjSJZaxFGNivR3wZDWUpHStofQ1xJf919mb2xBcpYGnwPSucBCPhdCK09WhanVOBlcTOei0/l1rFaC1W8XTep9zhIaehuaEpsKqslQUmLXdAJu6GzITnFxp/n3WuHFydZmUpXV1Bdhuo2FcXeBlXNsNRe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=AQWGPgyJ; arc=fail smtp.client-ip=40.107.44.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="AQWGPgyJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+CJLJmyIa4IgWSnBu1YvKfb9Bn4DG0lkyeYnZf0VrmSLBMGEBT5+SiF1tqb1A1qfTQO2NaLizyGPv/MYZBuk/l7KBQ6Ms4gXdWpNviDYDTE3ZmBu4UNVCiSPexCp+Oi5ThswTXlt+srOq9Q2jsee6k2KS+/tqh6hxfCrcKRIKBdpyF7Wam4MJk/2xXUTKcCHvwWmvfnn6PgE2U3rBHFYVZ36VM598Q8bOJx933rnrFWwijwlhur/7j16igZQBSxfQHR8hKBQwWOIDWtMl3/TCMnnfMRUFOBuHoUgE3KeK+sQhE5cRLuvRlQqJ2GWVgcTGuU0RQGqhWqy2SR2ZeSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Prk7Q6+IZODIKzq29DZ8mk+Y47FFqL4CU7RnX+OkQSI=;
 b=Jp9DOsGJ86cSPKUrrPckymS01eBqadm77rmxY1nmcHFRW5CD4HkdwZqpfElNbDs9Xp2lyTx4Bz9m1g/uDow3iPBH8M7cS4v1TWl4Ib9n4Qp2/y6QsksSKhpHdp5TA06qf5vcz8CVyqgX+Dsq4+3Wd5RA0oFOg17ikKgqCoRPMHZ+bkn11L/UyxEy910f2WYQkZZ59NmZ1L9FITU8lzjisWOX5OMm+f+MAD6v8rUB7D8CFIttJUoHA0rjA4dw48AEVZBNheuTnJmDstJJ0eaADTnA4npQY2cY9ORPgkgsKX17L6krM3A7/SaJeCnBTcxZ+PAQUTRm84LO4VD5rXO+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Prk7Q6+IZODIKzq29DZ8mk+Y47FFqL4CU7RnX+OkQSI=;
 b=AQWGPgyJ7wo8pz6wnriuJ5U5hSArRDmLbg/bUGD0N+ps/GoTCKXmBbrfgb0jNtnjcMXa1TinXq75lJaNh/ZeKkbtHsHpHqYka5ag/2Pry1xQ4AlD8AJjC8c2f9V8ECAe59fjhbO+Kk8yiVjrE7bOzxOoLsSN0URFFnIoqoS/UvYylWjymR+sE8hpZu96DlHTP3SMXZVRFStsXqPQApLT0NCZRdxazwO1p5QUYCQJxt/x+6Q5EUugd2xzpUSPdcwjv23gvDt8zzyBWb2UcL71CekpJUve7NxFUIpTWFI3w8chixdx1pD4lgJKB0mApb6k1X+2+bFn+LN5lDvjhB9vjg==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TY0PR06MB5257.apcprd06.prod.outlook.com (2603:1096:400:204::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 05:59:10 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e%4]) with mapi id 15.21.0382.012; Wed, 9 Sep 2026
 05:59:10 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Borislav Petkov
	<bp@alien8.de>
CC: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Tony Luck <tony.luck@intel.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 0/8] Add Aspeed AST2700 SDRAM EDAC support
Thread-Topic: [PATCH v2 0/8] Add Aspeed AST2700 SDRAM EDAC support
Thread-Index: AQHdM3I3vrDNrqV/M0yCJj4RKsYkZba7g8KAgAjXaMCAAXtbAIAAAmTA
Date: Wed, 9 Sep 2026 05:59:10 +0000
Message-ID:
 <TY2PPF5CB9A1BE6C20BCCCF70886F380111F2B02@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260824-edac-v2-0-c8d8bb693586@aspeedtech.com>
	 <20260902160843.GCaphKC-y8HpkiAIWh@fat_crate.local>
	 <TY2PPF5CB9A1BE6E8F9A377C5FB805E6D9DF2B12@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <f9d084200f79269c02e96cb165fcd3ba67be5271.camel@codeconstruct.com.au>
In-Reply-To:
 <f9d084200f79269c02e96cb165fcd3ba67be5271.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TY0PR06MB5257:EE_
x-ms-office365-filtering-correlation-id: 7cb5992e-31ae-4557-073e-08df0e3777db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|38070700021|4143699003|10067099003|56012099006|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 Hqf5l6Ywf8BwBdYDcRB0eBveVZmfW6pzi7Fo8HtxKdJyEQK0ZliiD+ioWlaOKokaQl3eySVE522u0wP4Fl800r6+E23p7pNAsnthhcoGOOWbSEd48WjURo9L4pcHocmoWOJf50nj3zNgjNzRHHEQhpO15CM+Z8R1fZNuV+jpTsfoSqfjomMZOTb6KRdQYEzqHv2wl6ZTPzVBeOyQ5JAXCGiuDlFK+d3qEkmxCV1zIraVbuXaVN4jJuaThl35zqaEYnIykSiyFH/VV09u2cwH0Q7C9STGSXRrvIXY+DU8gZpEvwnzpZf/8ijXx+vqztWg6lB1hQabbzyqewQ9ucdecDaY2bKsNOcdXF1rindq7MlGq4P+In7JCwU86DkgfE9sTDJ4E6TeF/lBCqeW0zdPtsjkDQmm3OwAqRiSYKLgKvjCJlR/NsG/Zp1U19dcz4txxuPPUnbmeWoa4NwXcLhJesSn6/W7xwl1NnjO8uxreOCEI7sPhEXizDxlBQau/cwiaod1SX9B6sFSEQ9xz6DVvNxByXK3ZsY1Y+PhrAbO2E6QYYJjE83nSObVOfDbz5Ff74h5wK8b+vF9Z2DNTyHJYcJXCPI1D5i5ecfeeLzK5ajpJ1TDj8c2AYwd4Ixx/iDpyiZYVDh0Q1XxOTu7EFz/f+9vNOUdyMxfB9T7f7kqhZI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(38070700021)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czc3Wi9OV0poM3IwOU9JVXhwODBUUCtWWU5hZE5zWExvTENVaExCR011eG9Q?=
 =?utf-8?B?WDM2RUZGbTJLeW5OT0RsRGdIaWhWNDM3OUMzdU1xME9HNXpWZTRaUGtQcDlF?=
 =?utf-8?B?WnRDRnNDTUxjYTZ6b3J3ZG9rVEJQWVM2MzJiUHVxSFBXTTY1WVRrNFhhRTZo?=
 =?utf-8?B?aDJ5eVdHdDBLRUl5RHNtMFVTYzl2cHlXZkdXUkx3THAwa2p2ZmxBRXcrSUpm?=
 =?utf-8?B?ZGNvdG80TmV6SDdMUXN5VWpOQ2dITWlGbkFpQ3hNMG9aOGdmdW81akZzOTAv?=
 =?utf-8?B?cHc3Zi9XK0xYYXNFVS9zYTdvVXJ4VEpIMzYxR3l3V2h3bllwR3FkOWJJWUQw?=
 =?utf-8?B?TDBEa20xRjdlQkFmcVhMTFZFdG1WcXVVckt1aklqV0duRzhmdnhORGxCY3Zn?=
 =?utf-8?B?cFhHVHRYS3FNWktxbTI2Tmc3N2Faa2tvaU9DZlVnVUN5dXBta2VvRlZYS3Uz?=
 =?utf-8?B?eldvZUN1eHBuSFYzcGdRaE9ocXV0MW5aYW5KT3dDd3NhbFdxdkJSYVVWQ2J6?=
 =?utf-8?B?NmhwaGdPQ3l2Y3h0WU5KeTJtYVpUWk1GMHBZTWpZcWJNa0VVUzgvQ1RyWUVG?=
 =?utf-8?B?UTAybFRaTG53SXBVNFFVdjZTK2cybXJ5dVJtOXNjQ0dNYkozN3RaVlFZdEdE?=
 =?utf-8?B?RWdsYS9LVEJpN2UrTHlxdEZ3aFpNTTFxL3ZMWjdzZGRHSFZhN1dya3RLenRx?=
 =?utf-8?B?NEMwNkFDVy9XblVTejgxRUVwa1M1S2FIZ1VQTEJ4dHh4ZW9mSE1VWjNqZkY1?=
 =?utf-8?B?UDRnVTc2WTNTek8xV1c4ZWZEWEFlRFVjZklraGtpWjhxY3hscEdoV1FoTkUw?=
 =?utf-8?B?U3VtRkxoZ0RMRmdiZTVSd0p0cURxM1VDY25UYmk3Y1ZnT2ZVRDJMWndLdkdh?=
 =?utf-8?B?VHZYcVRQT1JDN1NuSkNkU3JxTFFaR3pEYVQzU1dhWTRXekhER0RZMFBrbXM3?=
 =?utf-8?B?cXNzV1pLZ1psdFU1cWJiek01ejJxa1ZCTkkwSDhJM0xGRkJOblV0Q1kwQ3Yx?=
 =?utf-8?B?YmFyN1Nwd250bzE0Z2Y0d011YmVJbWl3ZXpHV3NCTDVOSjhvSFU2cXVRVHlW?=
 =?utf-8?B?VWJhZS93aHM2OUduaHJzWU9OZHN6MUdrb0dYREVGTVhmUEtaMlBUK2FHSXZo?=
 =?utf-8?B?QVVUODg0YnlXTGFlSXhNOWdmMjhaYUJDdGwzaUVSTkplblJpZnJ4Qk1XaUNY?=
 =?utf-8?B?Vk41bFRKTjhMYVFYbmYzaDREYWFKU1kxY3FmMGlyMkJGclUydmhmdTN2Zm81?=
 =?utf-8?B?U2dDbjBPRk9STjltODJRNVhmNmdwQzBoOXpFbk55WkRHMzlyWXdvTFFiS0hi?=
 =?utf-8?B?YXk2b3lxcE82VkZuV2ZHVVorSmhwczZScTJyRUZtUVVvc0k0QWI1Y1RYY2pl?=
 =?utf-8?B?SUhqV2JycDBmeEcvVXFwY0ZZOUQ4blI4aVVBU1lQK2RnaXh2T2M1YVZUNVhl?=
 =?utf-8?B?WEtsNlJ1QUc2U2cwTzJSMVl1SFBGK1J2NStBNVQwaWgra1NXK042ZWs4UDZB?=
 =?utf-8?B?Y21BZFM3c1RFWmE1c3RxU25TWC9EZ0JmanFlK2p2Rkh2V3Z0ckVBRGFDUnlZ?=
 =?utf-8?B?T3BqQ0ZHZlZwRkIydkp4SUFBNFpJM3lSblBSaUkySVhGWkpUVzgxZkNUUEd2?=
 =?utf-8?B?RXRjTkxtS095TEMrMEs3UlF6N2h0ZmxtYm5la0VJcjBmTUdNTHdCU3gwcjNH?=
 =?utf-8?B?dzVqbVcyL09CNWFTNFpRY1JJNG80VmRhM1JzTHMvTFdHRTV5UWt2ZW1Wd2J6?=
 =?utf-8?B?TDB6WFpoa1k2a0pYQkh3ZzlnR1RoTjFCNUtldjdEaEZ3SjBLN0hBMmRIcklm?=
 =?utf-8?B?b21IMGxoZC9yTTR1TDJUb0djdjZQUDkxUzgxVEttS3ltNHc3VmRaQnRTMTRh?=
 =?utf-8?B?LzNCeEVObTBWbHlVZzJiZ3VGTGZSYmFzOTVhTFJxRXkyNW5qQjZaczBCdkt1?=
 =?utf-8?B?MWx6MHAvRzJ0QTBtaU4xbVNWTHNBdXYrQ0hxWXlJcy9nOGRjTmYzR0g3NVZL?=
 =?utf-8?B?UG5RZnZqZFB6RHM2bnlvZDkxbkZmZHlGU1FxcS96OUNrMnZ4MkRwRXBUeU9a?=
 =?utf-8?B?WmpwREw4ekRkbThuWHY0MXJ1QkZlNmNHQ2tIYmNmdzZKWXZNN2M4Q0hOY2Z6?=
 =?utf-8?B?UXV4aXVNN3hvbTdxODV0OVZIMkNXU0I0UFFoUTAwT09uZ25qZml3dHR4YTdw?=
 =?utf-8?B?WVZoZUNDem1Ua1RKdDZjTFF5WHZLOGdRamJVaHYvRFN1TXFpK1dZTjZrWHBV?=
 =?utf-8?B?QVB2Vi91cDBPZ21JbE10MllVOThRWmc4RUtLOWRrNXhXaFBqTEFaYTViWm0y?=
 =?utf-8?B?UDc1Wit1V29POTFrU1ZZV2JKVElqQmNoZXZNOGtNeHdGb21vU0ZmZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb5992e-31ae-4557-073e-08df0e3777db
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 05:59:10.5971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2L7z2J1pClk0AhSIbGUaicAOnP2MySMmZmygIXuhXTYkJQpv1SyCCsWrfnehfpY+F2ODbmRCMrcSaXgiTO3v3XZ+Ub4xMPVdAq5wmXjxdN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5257

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAvOF0gQWRkIEFzcGVlZCBBU1QyNzAwIFNEUkFNIEVE
QUMgc3VwcG9ydA0KPiANCj4gT24gVHVlLCAyMDI2LTA5LTA4IGF0IDA3OjEzICswMDAwLCBSeWFu
IENoZW4gd3JvdGU6DQo+ID4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC84XSBBZGQg
QXNwZWVkIEFTVDI3MDAgU0RSQU0gRURBQyBzdXBwb3J0DQo+ID4gPg0KPiA+ID4gT24gTW9uLCBB
dWcgMjQsIDIwMjYgYXQgMTA6NDI6MjdBTSArMDgwMCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+ID4g
PiBBZGQgRUNDIGVycm9yIHJlcG9ydGluZyBmb3IgdGhlIEFzcGVlZCBBU1QyNzAwIFNvQyB0byB0
aGUgZXhpc3RpbmcNCj4gPiA+ID4gYXNwZWVkX2VkYWMgZHJpdmVyLg0KPiA+ID4gPg0KPiA+ID4g
PiBUaGUgQVNUMjcwMCBtZW1vcnkgY29udHJvbGxlciBrZWVwcyB0aGUgc2FtZSBvdmVyYWxsIEVE
QUMNCj4gPiA+ID4gcHJvZ3JhbW1pbmcgbW9kZWwgYXMgdGhlIGVhcmxpZXIgQXNwZWVkIEJNQyBT
b0NzLCBidXQgdXNlcyBhDQo+ID4gPiA+IGRpZmZlcmVudCByZWdpc3RlciBsYXlvdXQsIGEgc3Bs
aXQgaW50ZXJydXB0IHN0YXR1cy9jbGVhci9tYXNrIHNjaGVtZSBhbmQNCj4gRERSNC9ERFI1IG1l
bW9yeS4NCj4gPiA+ID4gUmF0aGVyIHRoYW4gZm9yayB0aGUgZHJpdmVyLCB0aGUgZXhpc3Rpbmcg
Y29kZSBpcyBmaXJzdCB0aWRpZWQgYW5kDQo+ID4gPiA+IGdlbmVyYWxpc2VkLCB0aGVuIHRoZSBB
U1QyNzAwIGlzIGFkZGVkIGFzIG9uZSBtb3JlIHBlci1Tb0MgdmFyaWFudC4NCj4gPiA+ID4NCj4g
PiA+ID4gUGF0Y2hlcyAyLTUgYXJlIGJ1ZyBmaXhlcyBhbmQgY2xlYW51cHMgdG8gdGhlIGV4aXN0
aW5nIGRyaXZlci4NCj4gPiA+ID4gUGF0Y2hlcw0KPiA+ID4gPiA2IGFuZCA3IHJld29yayB0aGUg
aW1wbGVtZW50YXRpb24gdG8gYWNjb21tb2RhdGUgdGhlIEFTVDI3MDAuDQo+ID4gPiA+IFBhdGNo
IDggYWRkcyB0aGUgQVNUMjcwMCBzdXBwb3J0IGl0c2VsZi4NCj4gPiA+DQo+ID4gPiBTYXNoaWtv
IGhhcyBjb21tZW50czoNCj4gPiA+DQo+ID4gPiBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hz
ZXQvMjAyNjA4MjQtZWRhYy12Mi0wLWM4ZDhiYjY5MzU4NiU0MGFzcA0KPiA+ID4gZWVkDQo+ID4g
PiB0ZWNoLmNvbQ0KPiA+ID4NCj4gPiA+IFBsZWFzZSBhZGRyZXNzIHRoZW06IGlmIHZhbGlkLCBm
aXggdGhlbSwgaWYgbm90LCBleHBsYWluIHdoeSB0aGV5DQo+ID4gPiBkb24ndCBuZWVkIHRvIGJl
IGZpeGVkLg0KPiA+ID4NCj4gPiA+IEJ0dywgSSBkb24ndCBzZWUgU3RlZmFuIHJldmlld2luZyB0
aGlzIGRyaXZlciBhbmQgaGlzIGxhc3QgbWFpbCBvbg0KPiA+ID4gTEtNTCBpcyBmcm9tDQo+ID4g
PiAyMDI1IHNvIGl0IGxvb2tzIGxpa2Ugd2UnbGwgb3JwaGFuIHRoaXMgZHJpdmVyIHRvby4NCj4g
PiA+DQo+ID4gPiBUaHguDQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+IFJlZ2FyZHMvR3J1c3MsDQo+
ID4gPiDCoMKgwqAgQm9yaXMuDQo+ID4gPg0KPiA+ID4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9y
Zy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCj4gPg0KPiA+IEhlbGxvIEJvcmlzLA0KPiA+
IAlUaGFua3MgeW91ciByZXZpZXcuDQo+ID4NCj4gPiBJJ3ZlIGFscmVhZHkgcmVwbGllZCB0byBi
b3RoIG9mIFNhc2hpa28ncyBmaW5kaW5ncyBvbiB0aGVpciByZXNwZWN0aXZlDQo+ID4gdGhyZWFk
czoNCj4gPiA2Lzg6DQo+ID4NCj4gaHR0cHM6Ly9zYXNoaWtvLmRldi8jL21lc3NhZ2UvVFkyUFBG
NUNCOUExQkU2MUU4MkVFRTU1RjNGNzI1MzYyQ0NGMkENCj4gRDINCj4gPiAlNDBUWTJQUEY1Q0I5
QTFCRTYuYXBjcHJkMDYucHJvZC5vdXRsb29rLmNvbQ0KPiA+IDgvODoNCj4gPg0KPiBodHRwczov
L3Nhc2hpa28uZGV2LyMvbWVzc2FnZS9UWTJQUEY1Q0I5QTFCRTYyMTcyQkNDMzU4MzQ3QzQ4MzZD
Q0YyDQo+IEFEMg0KPiA+ICU0MFRZMlBQRjVDQjlBMUJFNi5hcGNwcmQwNi5wcm9kLm91dGxvb2su
Y29tDQo+ID4NCj4gPiBTaG9ydCB2ZXJzaW9uOiBuZWl0aGVyIG5lZWRzIGEgY29kZSBjaGFuZ2Uu
IE9uIDgvOCB0aGUgcHJlbWlzZSBkb2Vzbid0DQo+ID4gaG9sZCAtIHUtYm9vdCBtYXNrcyBldmVy
eSBpbXBsZW1lbnRlZCBEUkFNQyBpbnRlcnJ1cHQgc291cmNlIChJTlRfTUFTSw0KPiA+IHJlYWRz
IEdFTk1BU0soMTYsIDApLCBiaXRzIDMxOjE3IGFyZSBub3QgaW1wbGVtZW50ZWQpLCBzbyBubyBu
b24tRUNDDQo+ID4gc291cmNlIGNhbiByYWlzZSB0aGUgbGluZSBhbmQgdGhlIHNwdXJpb3VzIGRl
dGVjdG9yIGNhbm5vdCBraWNrIGluLg0KPiANCj4gSSBmZWVsIHRoaXMgaXMgYSBmcmFnaWxlIGFu
YWx5c2lzIGdpdmVuIG11bHRpcGxlIGNvbXBvbmVudHMgaW52b2x2ZWQuIEkgdGhpbmsgaXQNCj4g
d291bGQgYmUgZWFzaWVyIGFuZCBzYWZlciAoYm90aCBpbiB0ZXJtcyBvZiBrZXJuZWwgYmVoYXZp
b3VyIGFuZCBndWFyZGluZw0KPiBhZ2FpbnN0IGNoYW5nZSBpbiB1LWJvb3QgYmVoYXZpb3VyKSBp
ZiB3ZSBoYXZlIHRoZSBrZXJuZWwgZHJpdmVyIHRha2UgY29tcGxldGUNCj4gb3duZXJzaGlwIG9m
IHRoZSBpbnRlcnJ1cHQgY29uZmlndXJhdGlvbi4NCj4gDQpIZWxsbyBBbmRyZXcuDQpUaGFua3Mg
eW91ciByZXZpZXcuIEkgd2lsbCBtb2RpZnkgd2l0aCBmb2xsb3dpbmcuDQoNCiNkZWZpbmUgICBB
U1QyNzAwX0lOVF9BTEwJCUdFTk1BU0soMTYsIDApDQoNCnN0YXRpYyB2b2lkIGFzdDI3MDBfc2V0
X2lycShzdHJ1Y3QgYXNwZWVkX2VkYWMgKnByaXYsIGJvb2wgZW5hYmxlKQ0Kew0KKwl1MzIgdmFs
ID0gQVNUMjcwMF9JTlRfQUxMOw0KDQoJZ3VhcmQocmF3X3NwaW5sb2NrX2lycXNhdmUpKCZwcml2
LT5sb2NrKTsNCglpZiAoZW5hYmxlKQ0KCQl2YWwgJj0gfkFTVDI3MDBfSU5UX0VDQzsNCg0KCXdy
aXRlbCh2YWwsIHByaXYtPnJlZ3MgKyBBU1QyNzAwX0lOVF9NQVNLKTsNCn0NCg0Kc3RhdGljIGlu
dCBjb25maWdfaXJxKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwgc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCnsNCi4uLg0KKwlwcml2LT5jaGlwLT5zZXRfaXJxKHByaXYsIGZhbHNlKTsN
Cg0KCXJjID0gZGV2bV9yZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBpcnEsIHByaXYtPmNoaXAtPmlz
ciwgSVJRRl9UUklHR0VSX0hJR0gsDQoJCQkgICAgICBEUlZfTkFNRSwgbWNpKTsNCglpZiAocmMp
DQoJCXJldHVybiByYzsNCg0KCXByaXYtPmlycSA9IGlycTsNCg0KCS8qIGVuYWJsZSBpbnRlcnJ1
cHRzICovDQoJcHJpdi0+Y2hpcC0+c2V0X2lycShwcml2LCB0cnVlKTsNCg0KCXJldHVybiAwOw0K
fQ0K
