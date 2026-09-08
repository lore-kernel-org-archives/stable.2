Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022135.outbound.protection.outlook.com [52.101.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70A3A0EB8;
	Tue,  8 Sep 2026 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851624; cv=fail; b=Vs6Wn6kNiGt7tZndhl1ZSUPGP7ZsWLx5kmmllP53l9fWl3F8z0X39Nj5oLKjgTCcz7I3Su/Ko23Q46cAvvOFuYCiw/Gm5awZlLhALYzHmiHv6pTA8Va44We8G3GXjvfCA7xZU/6w97Ftiocf4t9Q94FoYxHpO+EkRbLec+vjHOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851624; c=relaxed/simple;
	bh=+E2s89+spVrZ+ncGWW7fMCWHsVUiAzqIG/jRql5ZGjc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X2984R5mPOczbYBv9GR+OCahXCexxSc5GfA08i8yhEyvbTwgfO/R80PLQmm2JcDQwPQCMwwI34lPsutVBqaAVXcauoZBSFip2ekyn5m1nX1SgrmBBGsxMqIzSNzeA6UF4mCHjQJ7/+Z5VVoSIK/c2rTAw6Z7+WGoJtTWzPZAXIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=RqwsNOsS; arc=fail smtp.client-ip=52.101.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="RqwsNOsS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCFiRWH45pLeTWiAKJw6Xk1RDx9NnKWFwtuUGmyEKtYI4j2tC0J552JwJrdnweSYGDZ2Hg7dIRbvix6ntElmr6hUhSp+p6LUzd97HFy/wvoO+/6IeWTVZo2tR37q6gopgHY1+fbNF030d0cL+HJjsl2fhVAEl+4Ybm+D80pjml36tNQ8WoofWxau/6z1RlxCwpVFufm8oMXorPWLdX/BsPkh+ECMckQt3ALCAtyt4zSkPvaufq9TqRQ9rR/Gy9qLWnHkF4UrToy6YkThL+gE4ZouyRFDqiWneUSv9PArpS9z5YirIno6cKIpcPFep8MQKxxvTjTZNIwl24QS2vmstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E2s89+spVrZ+ncGWW7fMCWHsVUiAzqIG/jRql5ZGjc=;
 b=jKrQ593gm0T5+SjG1gtM+s/ey88vpLAS7WHVTzzwiDYPBxNpc4g3DFm00z6nT52aVRySKFL5vEzfwB7sRUie4wPGxpe7sJ9UqPChqw87V1OJz/3VWSihyEkp8Tk3c3q5XEw/OWA/lwZxOxWO+tS0bEIPxgNmIEQgYDUi2oRx9t4ix0M+vPcvq1owX8Z9JMdz3uLSC1W1CFtvwkMcKhIHN2VX9zWAa5F9CZ3BwrgaDyNwAryQxv/flp+FgjkR3guYkgeOh0HMJqrYSSOfMIXnVum6rg+GH8+thXxga9PncW/em7xqcNgs5tym72+STOsBwdnLwqBoy0H8nFTWbistxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E2s89+spVrZ+ncGWW7fMCWHsVUiAzqIG/jRql5ZGjc=;
 b=RqwsNOsSk8xGTKWE9dOUi4baId11/KEjNcNrsVm9NEPDkTUMqAjfco6k55xjhmfVSWwfl0bnV7UlO8C5dtMC5HJpPM67WYaE0hGI9gGGPWVUAEcvdVE2hNOhv1cKSP3LO+7GDYopbN3mo/Fl7/G4HGghfcZJ5B/ukUoZ5zuulLhJbfm+2XMf4WtSat9oPlghYK+35PyJ35HvgYL7T6fauT7ZKgWNXB2CHC7Xvl7DOwcrQz6Eg1mIAyy6okKBgnqFCBVGDBN2tkCFZbWOGgia9Z68/1wn1ZdBdFVG43DmfewHqcB/F/zSKOcf1U938MrKvHH6nvtHcIhPCk9o5yt1iA==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYSPR06MB6970.apcprd06.prod.outlook.com (2603:1096:405:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 07:13:37 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e%4]) with mapi id 15.21.0382.012; Tue, 8 Sep 2026
 07:13:37 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Borislav Petkov <bp@alien8.de>
CC: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 0/8] Add Aspeed AST2700 SDRAM EDAC support
Thread-Topic: [PATCH v2 0/8] Add Aspeed AST2700 SDRAM EDAC support
Thread-Index: AQHdM3I3vrDNrqV/M0yCJj4RKsYkZba7g8KAgAjXaMA=
Date: Tue, 8 Sep 2026 07:13:36 +0000
Message-ID:
 <TY2PPF5CB9A1BE6E8F9A377C5FB805E6D9DF2B12@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260824-edac-v2-0-c8d8bb693586@aspeedtech.com>
 <20260902160843.GCaphKC-y8HpkiAIWh@fat_crate.local>
In-Reply-To: <20260902160843.GCaphKC-y8HpkiAIWh@fat_crate.local>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYSPR06MB6970:EE_
x-ms-office365-filtering-correlation-id: d22dcbf0-0538-4a58-8777-08df0d78b390
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|10067099003|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 xvNAC/AfMgEanlCR1ZaYT0lbUbqkaoHqWflUGfOpSGXfvuKeN2bRyjyUnRHl1ldDpf4UeWkt+llKl3Mc0fFyGyuYyqZ4hxfJ0WEFmzy67JZW6JP5Xr1kUo33QjYGreNNhOFhuNha1lBoDDu1HuEIkBnkOzy8ALgpIzrZ7bcBkv9zrqF5eajJP2uH3jd5l1jkKa4ui3E3DWDB0oo+TJngq+v2swu6ymjo1nm2v1lYz1kQ/7f4ZNfF+eL2x/EfMCHJIG3HxnYxEGmtSl6pr8yPns6X1elA9vYgAHbYVYx0Z0TQD6XsBfVVr/dugelxUGcV8m3Jbmv0nQUNk4/nO0zpCrtgMmpTn+uNSUhwjqGdib9Vhne4K6Rkl+uy9q+aTaOvSOY15GHvMt/QanknK/x203mbpnGARfXiWEWmDxBmBX1izXVR7FOcfXD5z99KXlA+YFVmCrDSLdmsceHBGJqL2YSx7ved6Tv+objruBmxmog9l06DVXc24lKIo5FcGH5eO1YAPAKmn/3gWuEBhJsWTI9cbkzyEHyGv6MMV76MtzWhAnUkC8Sm33j/9fmEsqNylHX54qDeoyHz7n2TEuQeIUOOKWLx+Qo4nW3ak8JOfJl0juDnFjFL8/pzU6oTcrHPZ7gfgBkpaI1gCMU/5dF472cmcYm6Ei5olaaZYWjy/vU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3YyVnpTcWtVblVhWlZiNUFqbU0xVHVtU1lOdzNUM0RINFJlZkhCbEN3RFFR?=
 =?utf-8?B?bzkwa1ZyNVZZN2ZKNWtYVzA0OHQzbit6ZHVTaUdPL1k4Ulg3NWtocHhLZ01r?=
 =?utf-8?B?REZ2M3Bjbng0bTJncC81bzJPaGFlcHhJeEdmOHN2aHJ1SzZmZFJGdUhZOE5m?=
 =?utf-8?B?cXhBTnlHelVHTmcyVC9OMUpNUWtqZTlOSXdEYWllTkYxTXdLb2VnSlA0S2pL?=
 =?utf-8?B?eE5RS2VVYXZOaXRWRGpsdjA3MVhRLzZlY2l0NUZHaTNEN05GM3ZhRUNMbytl?=
 =?utf-8?B?WXcvbGNNQWFKN0xNSmI0dDFRaTJCNmozSDMxL0NCa21LVncyVlduMXlwWGgz?=
 =?utf-8?B?Rk1zZTIyMHIvVXJoUVJMTTV1bWJ4Nk5UamhHWDZCS2lIL3ZkR1ZsRHZXSmZo?=
 =?utf-8?B?TlRxa0JMQnpsWERFeWNLTHlkUW1Kdm1reHA3UGh1VkJBOU9xREhTdDhXdkt5?=
 =?utf-8?B?VXBUTWlFMzMwSDdBTFkyT3Iyb3E2UXQzQkFOeUZ6VWdVNVY0dlRQRG5kWlZt?=
 =?utf-8?B?OGZhUFI3NHc2MEMwQzA5T0dBR1ArUzJhT3VNekorcGkrNEI3ZXppamFxQTQz?=
 =?utf-8?B?RVJJV0Q5bldFNHI5UXB6WWRjWklkdVlZMyt4QTNscXJyNzBDd2UzcE1HYjBO?=
 =?utf-8?B?aXU1My9iY0xXZ0dpWklENnlER0s5eURoblVDdFVtbEFhWndvY2EvVUIwUDFj?=
 =?utf-8?B?aytPRFZoNXZXR2RxKzF3ZXJuYTllVUZ3OXN5REFxSFZNTG5xZGU5bHB3Tm1p?=
 =?utf-8?B?Y0k3QVhrOTVLZWxmTDhhVHNMWVp1Y2RwS3VDSXlJNzlCelhDYWZmU2s5UjJw?=
 =?utf-8?B?UnJkcmVGMGkvdjBvOEl3WWk0OWlVMDRHbmFrbGRueGtqVDF6SWZ0b2tmenoy?=
 =?utf-8?B?bEg0b3AwMnl5b2IybU4vRkRldUIxcDhvODl2OUpZY0FzOTRFRkxraEQvT1U1?=
 =?utf-8?B?bmVnMHYrb1lXc2s1OWxVVXlUZTRSR3FRcFZqTXJndCtlbW4xNUlzTjFYWW5O?=
 =?utf-8?B?VDlPUEIzVHEvT3JDbHVBcE40NTBoWWpJbWRCTGRPVmwvWkVjdnlLM1FNR1VI?=
 =?utf-8?B?dlFxc3pFU3A0WUZPYmRYTk9wVkIvTmZXcmtsTTBKTzQyenNyaHFveFBBUytv?=
 =?utf-8?B?ZVdHUExFTWNiWFBjTXVualFLelArWG1qbWUxckNFc3F3Z1JDdjROZ1NpNE03?=
 =?utf-8?B?eU05ait4TkRURUZ2d3UrbHVKMFFqR2pXbVNYZTBOMFU3b3U1a1lPRkxJdXRI?=
 =?utf-8?B?M2h4NXJ3cTd4RnNad1Nha2J2enpRbUQ2MEtSNnZ2REM3MmQ4UUIyNnBlakJX?=
 =?utf-8?B?TnVvSlFpTEd6ZlZETlNleFJzQ09rU29GaS81UmFhTUxjRy9kQnh6ODhwMXB3?=
 =?utf-8?B?dU5NaHY5RVkrQnRPVFRqOXZ3YzFrc0lBL280b0pMVm94aFdQVzZ1aFhvdC95?=
 =?utf-8?B?aGdqZ1RxVmtDRlpTQmFSM3lySmJxYTRWUy9PU0RVVDg0Q0dEQ1lOenp2VG1P?=
 =?utf-8?B?K2NncmdtWC82a0dEQnVpZ21OdVpoZXpnS0xuLzJqbEExKyt2aTBPelpJNHRR?=
 =?utf-8?B?TEhFWjFDMmNwbG8wUUNpZUVYVi9vWUNZMmdMOUUwSVlNMUJMSXljM2FHTmND?=
 =?utf-8?B?dVZ5MWpFcTZwYkFDRmM0VGxhWk9kNWgrVnVhWVNUZDkvZnpWRTZKU2FTNHU5?=
 =?utf-8?B?a1BBYWdOb3VkWHlWclM1ZldOQjZmTmJPUUNqQmN4enJTVk1RZG94MUo3aHRx?=
 =?utf-8?B?ZGVxZWx6UGlGbUhOazlRVlJqUFkrcXROQUVVYTRlVUlHK0xiMTlISXVuNWd0?=
 =?utf-8?B?RzNFMmRDM3lQUy9WeU9LNEluZzVZbnlkeS81T0p4d0prSlRvS1dWSlVicTE2?=
 =?utf-8?B?Y3Q5bHpERWJpWmZNNXJrblFuYXpFQW5IY2dtT3phbEdTaGdEeHJkMnJtdlJx?=
 =?utf-8?B?OUppQjVUK3ZFYXpSTDBMc3lGOGc1LzFzVS9CdW9xeW8yVnZ5NnRKT0tWRi94?=
 =?utf-8?B?anlVaHU0QzJLYmhxTUVMQkorNklDS3F3TWFxNFdNWEt1QTM0SzNaaVMvTGFS?=
 =?utf-8?B?SlB6L2pmRjhtek1ndTB1c0NraldWTkd1cThjQXYrN2orYzQ5enc1bFBzQk1X?=
 =?utf-8?B?Q1J5UkpMa20weFhIVVFoM1BwQXR2Wll6Vm9ETFdJT1BFNThXRzIxQWJub3VF?=
 =?utf-8?B?cGlCV09ma0hkUFlQaC8zVk52dVFHNG1tYnBtYmxRQ1pKdXRiZ1VoVHByRnFQ?=
 =?utf-8?B?b2tCQ1hOcFpKbTdObDlzMXhPNFkrTXdBRHFNT2RoNy9hN0dyZXNRRHNwVmN4?=
 =?utf-8?B?anlaMVZYQnZmN3hHRmxUQlZKT0NjNmRzcDNTZFBLS2Y4MTByNFB5QT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d22dcbf0-0538-4a58-8777-08df0d78b390
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 07:13:36.9500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vimUe65I2U/apGL7X2R3MB3WYZrEmWb1SxFKU/CoJM8vNnPU0K5ECJmGLIenQfOduDFQH8vh/GHy9QaMchEa15WSl+Gla19Y4QHQsIas+40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6970

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC84XSBBZGQgQXNwZWVkIEFTVDI3MDAgU0RSQU0g
RURBQyBzdXBwb3J0DQo+IA0KPiBPbiBNb24sIEF1ZyAyNCwgMjAyNiBhdCAxMDo0MjoyN0FNICsw
ODAwLCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gQWRkIEVDQyBlcnJvciByZXBvcnRpbmcgZm9yIHRo
ZSBBc3BlZWQgQVNUMjcwMCBTb0MgdG8gdGhlIGV4aXN0aW5nDQo+ID4gYXNwZWVkX2VkYWMgZHJp
dmVyLg0KPiA+DQo+ID4gVGhlIEFTVDI3MDAgbWVtb3J5IGNvbnRyb2xsZXIga2VlcHMgdGhlIHNh
bWUgb3ZlcmFsbCBFREFDIHByb2dyYW1taW5nDQo+ID4gbW9kZWwgYXMgdGhlIGVhcmxpZXIgQXNw
ZWVkIEJNQyBTb0NzLCBidXQgdXNlcyBhIGRpZmZlcmVudCByZWdpc3Rlcg0KPiA+IGxheW91dCwg
YSBzcGxpdCBpbnRlcnJ1cHQgc3RhdHVzL2NsZWFyL21hc2sgc2NoZW1lIGFuZCBERFI0L0REUjUg
bWVtb3J5Lg0KPiA+IFJhdGhlciB0aGFuIGZvcmsgdGhlIGRyaXZlciwgdGhlIGV4aXN0aW5nIGNv
ZGUgaXMgZmlyc3QgdGlkaWVkIGFuZA0KPiA+IGdlbmVyYWxpc2VkLCB0aGVuIHRoZSBBU1QyNzAw
IGlzIGFkZGVkIGFzIG9uZSBtb3JlIHBlci1Tb0MgdmFyaWFudC4NCj4gPg0KPiA+IFBhdGNoZXMg
Mi01IGFyZSBidWcgZml4ZXMgYW5kIGNsZWFudXBzIHRvIHRoZSBleGlzdGluZyBkcml2ZXIuIFBh
dGNoZXMNCj4gPiA2IGFuZCA3IHJld29yayB0aGUgaW1wbGVtZW50YXRpb24gdG8gYWNjb21tb2Rh
dGUgdGhlIEFTVDI3MDAuIFBhdGNoIDgNCj4gPiBhZGRzIHRoZSBBU1QyNzAwIHN1cHBvcnQgaXRz
ZWxmLg0KPiANCj4gU2FzaGlrbyBoYXMgY29tbWVudHM6DQo+IA0KPiBodHRwczovL3Nhc2hpa28u
ZGV2LyMvcGF0Y2hzZXQvMjAyNjA4MjQtZWRhYy12Mi0wLWM4ZDhiYjY5MzU4NiU0MGFzcGVlZA0K
PiB0ZWNoLmNvbQ0KPiANCj4gUGxlYXNlIGFkZHJlc3MgdGhlbTogaWYgdmFsaWQsIGZpeCB0aGVt
LCBpZiBub3QsIGV4cGxhaW4gd2h5IHRoZXkgZG9uJ3QgbmVlZCB0bw0KPiBiZSBmaXhlZC4NCj4g
DQo+IEJ0dywgSSBkb24ndCBzZWUgU3RlZmFuIHJldmlld2luZyB0aGlzIGRyaXZlciBhbmQgaGlz
IGxhc3QgbWFpbCBvbiBMS01MIGlzIGZyb20NCj4gMjAyNSBzbyBpdCBsb29rcyBsaWtlIHdlJ2xs
IG9ycGhhbiB0aGlzIGRyaXZlciB0b28uDQo+IA0KPiBUaHguDQo+IA0KPiAtLQ0KPiBSZWdhcmRz
L0dydXNzLA0KPiAgICAgQm9yaXMuDQo+IA0KPiBodHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3Rn
bHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0KDQpIZWxsbyBCb3JpcywNCglUaGFua3MgeW91ciBy
ZXZpZXcuDQoNCkkndmUgYWxyZWFkeSByZXBsaWVkIHRvIGJvdGggb2YgU2FzaGlrbydzIGZpbmRp
bmdzIG9uIHRoZWlyIHJlc3BlY3RpdmUNCnRocmVhZHM6DQo2Lzg6IGh0dHBzOi8vc2FzaGlrby5k
ZXYvIy9tZXNzYWdlL1RZMlBQRjVDQjlBMUJFNjFFODJFRUU1NUYzRjcyNTM2MkNDRjJBRDIlNDBU
WTJQUEY1Q0I5QTFCRTYuYXBjcHJkMDYucHJvZC5vdXRsb29rLmNvbQ0KOC84OiBodHRwczovL3Nh
c2hpa28uZGV2LyMvbWVzc2FnZS9UWTJQUEY1Q0I5QTFCRTYyMTcyQkNDMzU4MzQ3QzQ4MzZDQ0Yy
QUQyJTQwVFkyUFBGNUNCOUExQkU2LmFwY3ByZDA2LnByb2Qub3V0bG9vay5jb20NCg0KU2hvcnQg
dmVyc2lvbjogbmVpdGhlciBuZWVkcyBhIGNvZGUgY2hhbmdlLiBPbiA4LzggdGhlIHByZW1pc2Ug
ZG9lc24ndA0KaG9sZCAtIHUtYm9vdCBtYXNrcyBldmVyeSBpbXBsZW1lbnRlZCBEUkFNQyBpbnRl
cnJ1cHQgc291cmNlDQooSU5UX01BU0sgcmVhZHMgR0VOTUFTSygxNiwgMCksIGJpdHMgMzE6MTcg
YXJlIG5vdCBpbXBsZW1lbnRlZCksIHNvIG5vDQpub24tRUNDIHNvdXJjZSBjYW4gcmFpc2UgdGhl
IGxpbmUgYW5kIHRoZSBzcHVyaW91cyBkZXRlY3RvciBjYW5ub3QNCmtpY2sgaW4uIE9uIDYvOCBu
byBnb3RvIGNyb3NzZXMgdGhlIHNjb3BlZF9ndWFyZCgpLCBzbyB0aGUgaGF6YXJkDQpjbGVhbnVw
LmggZGVzY3JpYmVzIGNhbm5vdCBvY2N1ci4gRGV0YWlscyBhcmUgaW4gdGhlIHJlcGxpZXMuDQoN
Ck9uIHRoZSBtYWludGFpbmVyc2hpcDogSSdkIGJlIGhhcHB5IHRvIHRha2UgRURBQy1BU1QyNTAw
IG92ZXIgaWYNClN0ZWZhbiBubyBsb25nZXIgaGFzIHRoZSB0aW1lLiBJIHdvcmsgb24gdGhlc2Ug
U29DcyBhdCBBU1BFRUQsIHNvIEkNCmhhdmUgdGhlIGhhcmR3YXJlIGFuZCBkb2N1bWVudGF0aW9u
IGZvciBhbGwgZm91ciB2YXJpYW50cyBhbmQgSSdtDQphY3RpdmVseSBleHRlbmRpbmcgdGhlIGRy
aXZlci4NCg==
