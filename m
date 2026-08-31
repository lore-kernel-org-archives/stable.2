Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012027.outbound.protection.outlook.com [40.107.200.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866EC3D5643;
	Mon, 31 Aug 2026 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165053; cv=fail; b=PNhBNQEnynFmQ4DAaTlkDt2Hal0651FUV/X1MvwnwbMfGG5++jKMh2OJrLhdFRPwycZOejYEOi+QMEAyy3X6bgxVW6ZL29FAHFWgzoo13oRHOLgg6JqH4I2UeafNTWi/HcDQdcwSZdeXlyQ1VYqlLwdtRnrL0ujpN5HemltBK8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165053; c=relaxed/simple;
	bh=Dsnl3vw0M8i6Nk4SklchHQCVLQWrE8GdB6Al+Yy2eQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I1sIxGMoxEr+7DEdy9HZjQhFS7kwLqh+HWiNdOkjuGLAJuDfrd8eg0/d42k7nvEn+m/CRJVR0kzwn69O+h/LW9KtaZxorR9+LaqOLL4qzUu5so2I9g/vglhylSLOQpS1nHx9D/YNsxU3s7M8/XDvZATR0GmFTXxN25Nl1v7R0tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rQPCzv7w; arc=fail smtp.client-ip=40.107.200.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rQPCzv7w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6/zfESByh3aMOwBQ2cIA78XNWSpKEYyW4lKFF3oNVH5HPQ4IHKj/x32eSuprQ6YSdXvFT+4U5/OT8iT/PjkP1+Jk8tRu3WXQFHTOxffYm3n8X8sHJWUxLnNlw9HjvlJmMvb9StHSgCQ7jTEJUwqEVi9wcsU9KBIvBbX2oMwR9ZDSBL820O4LkXjjJCiFQes6UIyn/4sXV7QSdmujlHJ2k1m3euMLyrafR7nM5bt26bTa+y3lGZ03mLtbkkGtnj0ELy9wa7pLKEkxRKUNYZ0pEJe8G9u3lDQnYkO7wTaibKu45V1jILW1swK3gDheYZg3AgD6pgNBzeIhEE8QRzPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dsnl3vw0M8i6Nk4SklchHQCVLQWrE8GdB6Al+Yy2eQ4=;
 b=NfZ9klVqFvF+ZajsZOC7KS8wlnJ3geci7kmvveGh5SNJLmkZiPzsJFqU3K9EsUBevQ4+Zx04G2GqiSS3stEucc+tYIE0JDGqR+6vUgbPmvdmpT9BDVyT84rHeJ/j+/5cBbO4PoGEaeNPljtaMi1S9h14eus8dhWcJULVs49pVinFVC/r3uE9ykJBl9n/uG/JafauD+7vWPiRjz+OCq4/ZhW8TanZ6MwbvOo+rnFvLoUzI1cbuyEd+OeU8xMRQdIWbkmwwvqxTcVz+HRjlpFWNK0eOxWb1XRdkvUSp8aOZUeWCEYNCmU6ljhLcHnGulPpUDKAZ4v6yGrRjyjJFmknYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dsnl3vw0M8i6Nk4SklchHQCVLQWrE8GdB6Al+Yy2eQ4=;
 b=rQPCzv7w4WQAhTQ1l4AMhNQD+PNHp4KLb8OOAjoMzok58MUfPOEkUIZVXAm/SveGHZsK3O7kM9Mf6gDs3YoCCOQON7rdtRciiuo+l5UlCugmNlgEPDjzym0dx/H1DwxSU+4jLhmCOAVlBF2tEpxFxGtox3tRb71i1c5dArWz41o=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Mon, 31 Aug 2026 08:30:46 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:30:46 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "vkoul@kernel.org" <vkoul@kernel.org>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, "logang@deltatee.com" <logang@deltatee.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Frank.Li@nxp.com" <Frank.Li@nxp.com>, "sashiko-bot@kernel.org"
	<sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 0/4] dmaengine: fix kref underflow and UAF in
 dma_chan_put()
Thread-Topic: [PATCH v5 0/4] dmaengine: fix kref underflow and UAF in
 dma_chan_put()
Thread-Index: AQHdMmuMeGvr5pB+702rGT98JJI6Fra34TAA
Date: Mon, 31 Aug 2026 08:30:46 +0000
Message-ID: <a378e7aff74cf7f9b8552e051effd7908c6521f9.camel@amd.com>
References: <20260822-dmaengine-kref-fix-v5-0-d4a4ee47d927@amd.com>
In-Reply-To: <20260822-dmaengine-kref-fix-v5-0-d4a4ee47d927@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|DM4PR12MB6592:EE_
x-ms-office365-filtering-correlation-id: 48162f92-e00b-4452-8348-08df073a276c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 6RXXVO+e2Y0ePLPOs/9yAVZnUw1ihRxfKopcA0evLvJnjcEb74m6B9jUnvxFvVpO/6VtB+JCLsMOHfdJE5oIxk7oyDQhoyzeUOYhF6qS3x2LDjCLNeGK2YjrICwCXKaXbY0nu2FfJwMOOZliWcNKaXAhh7aUtSfuGyayBzDOQymWJ2ZNMTUTOd20w276NxUuk2z1xHJ4yfEplUhzSGkDeqnWgz4oexlTQK6AGdUrbBoJsch2PkgaHFGbghuDgcewf5+Ll8iIENfBvGAFZ1CBwXeIHv4D0fNOnWNZ5GZTl247sa9FjxCOs2h3aldez5I2QH5A9VkyK2BYwCZyIjWHvdTVXEz+on+ppsXZLqiMzM93LV/o9usSxX8dyVOVbolyIBJrnydUd3dKQLpu70Oj/P+TrlzMEr3pT0y5AgD8Gn4A3i5gJGYYP+gzkVE8gPr3vTybZzQVC2HNy/eHwKe8CfTfh24Ux+6IguMAOhy2GSsTVIl40QPWXNUInvjNWje8MI/e8h+/LB5o95TbsXzFTvcDg82z96ksn58PnDS1FqnfGaqEtKcQ8Pg5W8xx1G4fGpSaJYw2EVBUOK8XRyRGva9pRhhHmvesKEZRJ5OnRE7hoY2AqII/E28wMPQeV1GEsK8EZQRmTwcx+P6NyZKVK0RR+6Jc2ZomZqkjDTYq7sqEjiEIC4PDxALGm+AI2GMeNPDhRFTXGyEvyA7SBFd4E1GSE3EXgWz98W+xQQSrMH4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjREQ2tkTWk3Qlpja3MrL3J2RWw1Tm94MCthREROY3RlZU0yT3pRelQ1d1Vw?=
 =?utf-8?B?WUNMaS9SS0hPUU5SNFlIRVBUV29lOFZEN3FBTnI0KzMvM2NLSjA1ODRyYkVk?=
 =?utf-8?B?TTRWTXppcmY0YnE2K3RNRXFubTE5eVd4OXFGaDhTY3QxM2hBZTd4VVg0a1Vk?=
 =?utf-8?B?NXJZdWtyWEZUYlRjd1ZCUFpzcS9JMHVOVWNmeFd2RHZZNkRvcEsvcU8rVCtl?=
 =?utf-8?B?UDJidURXK3VPa2svUXl1a1hyUWJaL3ZIYWhXNVd4K0lpRUtQTUFvYk5CZWJ5?=
 =?utf-8?B?WjRmK044UnlqUmtMMlpaOVFLSEdSL0pBV2JqTGhlRmd1SFV5aTF4dUh4b21u?=
 =?utf-8?B?WTd6TzFBbzVkVys2L1MyYVpFbk5NcHVONjdLQWU3MkZNM3VIeHBBcGxQT3JO?=
 =?utf-8?B?dnpGS0VXWEU4bHQ5dERvVS9DSGp2ZllIWVZQeExkdzhiNU1aSEdxaW5iRXlw?=
 =?utf-8?B?NCtPN3h2SlZpZXU3R1JNYnk4MlZBdjdTOWJJK1RDUFJTS0tKdy9KZVAxMFgw?=
 =?utf-8?B?RTZpVmQ4akxtcE9JL3kvTzB6TmEvVTM1bklYMXd4Q3c3b0tMTUFHOVJFcllx?=
 =?utf-8?B?UVRaQ1JmWnYwOURmOENrbWFvMFVZaFh2Zndpdm9RUHAxM01zdkwyNC9ITGFH?=
 =?utf-8?B?V0J5STE4S1JoczVIeTJPVnkvcWd5aStDYXRQclZXNVNmODBpazUrNGthQmhE?=
 =?utf-8?B?NlhEQlpIL2E4UWFHa3loRmN3c2d0MTM2Rm4zazZPazhjdU1Dci9uL2NHd3ps?=
 =?utf-8?B?QkJLeGVmY3lFRTdEemIwTU5zc1FVWk5BZVNlQ2liYWY2TnVlY3BjSHpLOVBJ?=
 =?utf-8?B?L0xMSXJRSFRZV1AwS01VSUg2aWdSZHR5c0drRllHb2t2WlBURTIzSytYTENw?=
 =?utf-8?B?bDlTOW10V0Y0SG1CNmRaZFE3Z3NQSG95TldJTlIzeDgrQS9aekNtK0JDRnln?=
 =?utf-8?B?UUFuTzJnaVc0R1BzVGoxTWRXQ2lESVBCT3FLUmRiWk84bXdhR29TYjJqdFN6?=
 =?utf-8?B?UGpIUVArWGlnaHNNK2I4VXR3SFlUbEZPeCs5MStUVzloQkpqWXNzTWt4YXlv?=
 =?utf-8?B?Y0drWEx5T3VLRXhoL1FNMkZJRTVRQnpyMUk5RE9NT0w3dE04MnVMRFlYZDll?=
 =?utf-8?B?WmlYOEdGU29QZENPdmpwU0FaV2ViUVk5ZjJkaDlWMWJWTWtpR0dTZUFId1Rj?=
 =?utf-8?B?amdjQWpTT0xoeUNPRHQyYmw0SEVoRk1WYnBCUSt4bjJEd3MzY2dVQnJOZXNQ?=
 =?utf-8?B?cmxVZkxlVkQ5djVPcjdzMmlZdW9iQXdDcmpOVTV4bGVjcDJ2UU1vN3MzblZu?=
 =?utf-8?B?UlF3VVlPNkkwQTJCUjhqeWM0cUMvbkVnanRIemo2WGVzeW5YNjhQVU9WMk94?=
 =?utf-8?B?azFaWmxNV0dnRVQ3czBDVXd1Um9INjArbW9JTjVOWVJXNDJHTk94Y3BxVDlk?=
 =?utf-8?B?ZnFPSXJnVi83aytOTnpUS1UzaUJUMmlDQk00RkJDeDh0RnRxOFo4aFZzYzMy?=
 =?utf-8?B?Y1ZvOTJNdlNDN3NOcDkxbWRjUWtpa2hQYkYvVG4raHYwdzJKcTZSWEN5UGFu?=
 =?utf-8?B?UGZIK00ycVBPYWNKc1BvdWsvNG5rbHNrQVplWmpWSkpOUkxJUGZjMS94Mlhp?=
 =?utf-8?B?MHlSdE5ZcGpBdmk2dEt4TG0yVUY5YUtxdk9RbWRMUGtLR0RPcE5pSXFNZDZR?=
 =?utf-8?B?S2JURnA1Z29Ga0ptR2Fpc05nNW1iRW4xMGFOOWpnUk84LzV6QmRycGE5OE1y?=
 =?utf-8?B?REJWbk4zTFFiZTFXbWprYXFGSjJzNUZ2MFM3clFwQVV4YWVUbnY5TU9rQVZ5?=
 =?utf-8?B?cDg4STZLaG8yNWVzbUVYQWdJSGxjTklKQ2xwWGtjWmI2N1hZcUtlZFM4d0JU?=
 =?utf-8?B?WWE1L3B5RGljc2xSTTV2cDViM2NaT0RDdWtLcjU2ME5VN2xBclNFNlhGYVAw?=
 =?utf-8?B?N0JNNE0wN2RBR1BJSjcyUkdQVGJvemxFUVFsdFBjZ243SG90VFZaUFY4ZUhT?=
 =?utf-8?B?ZVdYYXgvTUQwV3hYRXdiSFdjSEVBQ0dsbkh5V2RJSjM5TDdBcE1PdUxFZzRM?=
 =?utf-8?B?bEZTUWxUWXdJQk9YOHd4ZWpSaWRUMnFXa3JHQWtJWlBoMUlKdmVKb2hZVWhE?=
 =?utf-8?B?NFhUcml6dG9mY3JhZ3hsMmxFWkhYWmp1bEMrVlh0d2VvYU1NQTl6RVR6ejhO?=
 =?utf-8?B?bm92U05iMzBsZDdHQUZmUVM4bU1qQXc3ODNaUkM0bFR3bDhLZUhxNjdVU21n?=
 =?utf-8?B?OTZmb1FWOXJoZG9tSThCNzYvTW9oVXFEK3h0d3RZcytIZzdoYUI3Sk96VGM5?=
 =?utf-8?B?VmlxRk53Q3BHMWtxSEkydEhFYjNoTy9wTUF5bkRWcmdXcDdhZHY1QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DC55A2D8CE6B2488DFDC1E4617A997B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48162f92-e00b-4452-8348-08df073a276c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 08:30:46.0360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wn9Fzr1W1zE3skvwzNeWwEF9imDBTTkQsYiubBnuBIWjxrgmhJcOpbB25sLyouRlaJc2yBx7R8ztIDjT7IdMkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592

T24gU2F0LCAyMDI2LTA4LTIyIGF0IDE5OjIyICswMDAwLCBTaGl2YW5rIEdhcmcgd3JvdGU6DQo+
IEZpeCBidWdzIHJlbGF0ZWQgdG8gZG1hX2NoYW5fcHV0KCksIGZvdW5kIHdoaWxlIHRlc3Rpbmcg
d2l0aCBTRFhJWzFdLg0KPiANCj4gWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9kbWFlbmdp
bmUvMjAyNjA2MDUtc2R4aS1iYXNlLXYzLTAtNGQzOGNhMmJkZmZlQGFtZC5jb20NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFNoaXZhbmsgR2FyZyA8c2hpdmFua2dAYW1kLmNvbT4NCj4gLS0tDQo+IENo
YW5nZXMgaW4gdjU6DQo+IC0gVXNlIGludCByZXR1cm4gdHlwZSBhbmQgYWRkIF9fbXVzdF9jaGVj
ayBmb3IgZG1hX2RldmljZV9nZXQoKSAoRnJhbmspDQo+IC0gRHJvcCB0aGUgY29tbWVudCBhYm92
ZSBzeW5jaHJvbml6ZV9yY3UoKSBhbmQgbm90ZSBpbiB0aGUgY29tbWl0IG1lc3NhZ2UNCj4gICB0
aGF0IHRoaXMgd2lsbCBkZWxheSBmb3IgZ3JhY2UgcGVyaW9kIGRtYV9saXN0X211dGV4IGhlbGQg
KExvZ2FuKQ0KPiAtIExpbmsgdG8gdjQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjA4
MTgtZG1hZW5naW5lLWtyZWYtZml4LXY0LTAtYzZlZjk5MTQ2MmEwQGFtZC5jb20NCj4gDQo+IENo
YW5nZXMgaW4gdjQ6DQo+IC0gQWRkIGRtYV9kZXZpY2VfZ2V0KCkgaGVscGVyIChGcmFuaykNCj4g
LSBEcm9wIGRtYV9jaGFuX3B1dCgpIG1vdmUgY2hhbmdlIChGcmFuaykNCj4gLSBMaW5rIHRvIHYz
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYwODE2LWRtYWVuZ2luZS1rcmVmLWZpeC12
My0wLTdlNzYxODcxNDVkZkBhbWQuY29tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEFkZCBw
YXRjaCAzOiBhZGQgc3luY2hyb25pemVfcmN1KCkgdG8gd2FpdCBmb3IgUkNVIHJlYWRlcnMgdG8g
cHJldmVudA0KPiAgIHVzZS1hZnRlci1mcmVlLiAoU2FzaGlrbykNCj4gLSBMaW5rIHRvIHYyOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYwNTI2LWRtYWVuZ2luZS1rcmVmLWZpeC12Mi0w
LTNkZjYwYWZhYzAxZEBhbWQuY29tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEFkZCBwYXRj
aCAyIGZpeGluZyB0aGUgZG1hX2NoYW5fcHV0KCkvZG1hX3JlbGVhc2VfY2hhbm5lbCgpIHVzZS1h
ZnRlci1mcmVlIChzYXNoaWtvKQ0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3IvMjAyNjA1MTgtZG1hZW5naW5lLWtyZWYtZml4LXYxLTEtNGQ2MTI1MDQ4ZmI3QGFtZC5j
b20NCj4gDQo+IC0tLQ0KPiBTaGl2YW5rIEdhcmcgKDQpOg0KPiAgICAgICBkbWFlbmdpbmU6IGFk
ZCBkbWFfZGV2aWNlX2dldCgpIGhlbHBlcg0KPiAgICAgICBkbWFlbmdpbmU6IEZpeCBkZXZpY2Ug
a3JlZiB1bmRlcmZsb3cgaW4gZG1hX2NoYW5fcHV0KCkNCj4gICAgICAgZG1hZW5naW5lOiBmaXgg
dXNlLWFmdGVyLWZyZWUgaW4gZG1hX2NoYW5fcHV0KCkgYW5kIGRtYV9yZWxlYXNlX2NoYW5uZWwo
KQ0KPiAgICAgICBkbWFlbmdpbmU6IHdhaXQgZm9yIFJDVSByZWFkZXJzIGJlZm9yZSByZWxlYXNp
bmcgZG1hX2RldmljZQ0KPiANCj4gIGRyaXZlcnMvZG1hL2RtYWVuZ2luZS5jIHwgMTkgKysrKysr
KysrKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogYTRmZjJiZTM0NWQwYWJjOTQzZGE4ZGQ4
ZGE5ODE1MTg0M2I3NTBkYw0KPiBjaGFuZ2UtaWQ6IDIwMjYwNTE4LWRtYWVuZ2luZS1rcmVmLWZp
eC03YjIxYWNiMDk0NTUNCj4gDQo+IEJlc3QgcmVnYXJkcywNCg0KDQpIaSBWaW5vZCwNCg0KV291
bGQgeW91IGNvbnNpZGVyIHRoaXMgc2VyaWVzIGZvciBuZXh0Pw0KSXQgYXBwbGllcyBjbGVhbmx5
IG9uICB2Ny4zLXJjMS4gDQoNClRoYW5rcywNClNoaXZhbmsNCg==
