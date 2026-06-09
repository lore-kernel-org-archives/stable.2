Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146240BCC0;
	Tue,  9 Jun 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017246; cv=fail; b=S/jrgUyIGZBgkQHRvtCnXZk21+WbF8QEWq36KC2Y5Vc9lXAj+ViAIRinlvb7K9FrAC7OdGcrCyw0DoG+rKZNZog5ZL9KLwXqpj5eScB5lG1ki7nTtTOsr4X6zHboi+YUpqFvCopAA9VEZbO+Lyw7jiDSP5V0inkXmeOvjqnZI6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017246; c=relaxed/simple;
	bh=hMjTCayCofmYIPyH46Okc9v6tXg635m4YF8eJvpFMpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jgwHgu9zXEiBmPfdhWBSAkQEG8NmC+3zvF1fmuHWDKtAoyMt4XjV4YRpsqSDJ+oC2/TcnOGM7lvulgKJA19IAiC9zX5hphVuqZVFgGC55FpwegE8IvenPGPWV4STUfgC38sECP9YGcSdGw4HcbGYT6N4L5uwPwdTeTfhyQh98GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kmn3xDAT; arc=fail smtp.client-ip=52.101.53.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kmn3xDAT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKHUTSi28xJ+D+/1obAuZLhQIPjVz2Nz230Yb87ud6qbJ3tPhSOlRNLhsBNmrkYyPJhSRSSMewUu9oX2Khh156YtRDTMVe7yBCFv3VrnQtpvNiFZG6klrmh7GSzOOsO6a0z3k+vSvwL8v4imVebl4F7pKZSguPjHHoY6kGs1cMlhXMYouKAtOU5irggXbiOErzRPtdE2OUckbYq3IEOvZV4Kpgqcn3quTMFc8v/XG1hBVrhF/RUxFZ7cZvks6BcuBFdtkNrnjLnxQUnR9sKpRDgNZ9zFUqMSFoJ6R9srhqQfizMtf4tS5HSwvb0tF4HbVklgvDC0I5FzDjrbDivdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMjTCayCofmYIPyH46Okc9v6tXg635m4YF8eJvpFMpc=;
 b=MTvi1vVvkmEJ1rVAEa/Rf1P1oatCuziTGOuT2C2eORqpUXmqdXd2ewdAzVCrNy1VkcWVG/QH2YkVPMEl0ZPH7I+T3ajMkC6h6myqq/8E+Me8xCTbZ8XIJnc/kr8wx6VzP4omuPMwy1ea0CLHfaVLY4KZDur7cDyCByL3iHOvpZBLkIJuLElf2s0N7sgI8Mn0OzbIlaRvsiXkAG/R2VQ8iSr5i8EHzUdSWRPR5socqYIMo11zsk/qN2XkleozsHJDYqQEgttS8VX5I8VNcDXJD0ATiYGJgS2tPFEsZmwx+Pq42I1bzTScGXjnR5GfIOtPZh+9o32WrY/nCqUCoeZ0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMjTCayCofmYIPyH46Okc9v6tXg635m4YF8eJvpFMpc=;
 b=Kmn3xDATDMEiIDG/q2lL3HJeJfFfnBKLMlSZnEBfME7Mmyr2Z2c47Ls4wfxMSjRtFbgVMcbDx8v4AUx1gVFrCXj38ZHYmQz0m+y7DygdP8RQxj8+C7wFy06I3t0MLDByAFSNUVRpsOPWchNH0XChdR7fx9l5Gr6dXbImD12Dol0oduY2G2X6a0nw6Qf4G8YYkfhm9ZllHBRayQkPwEEAh74t1kewpZGloS/GgF2lEnSR3TFxSpP5BCqq0DUrNvlkRnfiQjOtrIQzTUt6GG6NE6U1Lw7tPqq4odJv+LVQ8hzMkYr/ZvFi2v3WTOOmEp4aCx5zWDInVjOoYWAb7PkdeQ==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Tue, 9 Jun 2026 15:00:27 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 15:00:27 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "dawei.feng@seu.edu.cn" <dawei.feng@seu.edu.cn>
CC: "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>, "zilin@seu.edu.cn"
	<zilin@seu.edu.cn>, "namcao@linutronix.de" <namcao@linutronix.de>,
	"lyude@redhat.com" <lyude@redhat.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	"dakr@kernel.org" <dakr@kernel.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH] nouveau/firmware: fix memory leak on BL load failure
Thread-Topic: [PATCH] nouveau/firmware: fix memory leak on BL load failure
Thread-Index: AQHc9QhQDYV/oMN/d02/Uz0YAF01qbYwRoUAgARrdACAAENQgIAA/KaAgABlaAA=
Date: Tue, 9 Jun 2026 15:00:27 +0000
Message-ID: <23b088e0b3d594c5a4d70b63fc70a63c3ee5337d.camel@nvidia.com>
References: <0045b3583272df0b82f146fd96dee13d03377b4a.camel@nvidia.com>
	 <20260609085729.3786763-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260609085729.3786763-1-dawei.feng@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|DM4PR12MB9072:EE_
x-ms-office365-filtering-correlation-id: 8b49e804-3596-4bc9-859c-08dec637d75d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|22082099003|18002099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 EUSJF852JcZUjpFqHJWnHSKYby/eeVfUf7ANGU3222NbiNN6wpP9xoiYUSkBiJ11/qDAUW2bBsxcYp3e4k0BKAdKcGPV4NjAKyoa6m+hFk62du+HSFSxaKEfRl9Q4r773GuBcKaYFcIbIjHKchnwLmFP7nQqKPOzqvjshmosGDTpFaUV3+vd2567ywzypKY8biWJOzB3RCph1hu8ngIJ6y9n61O9zZaHB3qHNL/R06d6zrXhISf3CDHuFhMc+LXhBGbzhEmJGrIdL0a+YML0SuwQDHefSbuhtVCwB3HyfNV31vjfHvN1w9EUC1OoSnDKDNSPfeEWRHyJXW8gXaSTob9IAGra3H+XJDOGuGJZb8Lj3dCqfBP6Rj4FOoTPNMjlK1x0pnfLaOuDkp8YCT4qUVA1eM8Ed6tU3alRAdlwYLOlAHmC1dS71Lh+X8yd95cjiLhynawIkRundk8jfO3aobxoMtie7Fo0pU385v2ThbGnDOLbvpSUVzBzcPLVUqmpq7xlecxytS+JHoUjRbOwDfsIpkdIAiPV8+4WTG/2b8PY0t19FhPCOzxV+Wz7guwtCQtx8nbCbOYyw5UgzEUclP4JAVfj8t3pPAQf/HN1d6J64f6gwALWBuWBFTZdPs5NWgLMSUCcnJgyE250dzEhvlXJ0iAvNWAsfJR1Uxo3+lN7rnCKgOxl2+/Rf8d3XLmczPCQKaOTZCbE7QZEqz54azvvJ9SLxODwUP5UFcCQvMEOeQVC8/Rw5xFum5q5WNs9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8412.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVZUL1JRT0oyQi9YOGxGQlpua1hGUzBpZlhaSm1CMG0vV1MvMU9XS3ZodjU5?=
 =?utf-8?B?NndlSlFHQjRPS3lCWjBzczM5UkFuNWwraDJLa3A5VFgya2c1OGs5QkZHR005?=
 =?utf-8?B?Tld5dVRGUHJqbG5LaEs4cWp2SzVpOFA0S0hmUENxTithdUExOHRSNFRyUXp0?=
 =?utf-8?B?SXJDekNLcU1DbTJxVVJFMkdmR2RUREVkdysvUjF1cDAwNjRJZXNTQzBwdDF5?=
 =?utf-8?B?UlpDVEdVWU1PNEhvUlJ3T3ZJZk1yTndGTXA3d3dMYk5aUmJ1dE8xdmpmZVRn?=
 =?utf-8?B?NUo2c3crRGpOUlVOSDVsc2o1R211c1NQRnBmczhYeUF3d1NvTUtVZnpTWmlp?=
 =?utf-8?B?aHA0QXFkS3dYVm1rTGNhWkFPZ1RMcWZPSzNIbGdJc2lVanFrNE9Jbk1HTXZH?=
 =?utf-8?B?alBZbW5iaGlRN1Z1cHNhRituZGtiTCtUbVRmZkV6RHkvbVdBbjd2M3VxREJI?=
 =?utf-8?B?aVRQdTZZK2pqWFhKT2lFTjRMdHI1WFRlcGdFdkh3bTUwSGluUnVHMW5LNVZP?=
 =?utf-8?B?Mk1VV0swdHZobDM2L3BJQ2RIOWM4bTFVUjRsK2RwSVpsSHRkU3RZWW5VZzV6?=
 =?utf-8?B?NmptVDlIUTNwL3ppRnVYVVpZdlBraS9IT2pKWm5jRGh5clZWNTdLK1hTYTBF?=
 =?utf-8?B?MmJzaS9BOUlBTE05RHlQVkJROWZYMzJpZktZUlVWRjFleEFMdXZyOFdtb25w?=
 =?utf-8?B?akx4TERrN3BtMXJkNENIRThEbU5WZ0NiSWFkRWNHRU9pNHhSZWJJT2dwU3dt?=
 =?utf-8?B?MWh1L1ZRUzBBUUJHM3FMU0hTWXcvNGF1YTlFT1c5MXliUE5GdzNNTjc0bTJx?=
 =?utf-8?B?b3hJYXVwcGRMT04zbENjOE1QeXhHcCs4WEtNY0hSczYxdGxHNytSL3FYU3c1?=
 =?utf-8?B?QkVmeklLblUvRXZlSmhRUUhhWkpwMGxZOC8vVjB1L3hGbE5vYlI1ZXRQZ1dY?=
 =?utf-8?B?T3B4NjFybDQ3bitMU0lsVkRacE4vQXFha0JSK0RwVVhVRHM1M0hYZG42bHVH?=
 =?utf-8?B?QjhUU0JOSGJPKzVBWFB1RHAyUXR0LzgvVDgyZ042TUJZaTMzV0l1SXEwblRr?=
 =?utf-8?B?bXhGZ3lVa0NuaFdvbnNyOVhuREs2Q0VMMS9hNTVNMHJnTW1jYjFaSDVZUjZR?=
 =?utf-8?B?Mmh4MURrdlU4cGpBa1g1clE5YXAyL0FEcVdGWWt4R3RNWTNKK2FQZ2UxZDBJ?=
 =?utf-8?B?L08zbW1wSTZtTVY1Tjdkc3dPTVpla0U2YllOTmpiTm1VVmtGTVVuWVR4L25F?=
 =?utf-8?B?SnZvM1p6aTlyU3gxc2hianlkTERvbkRyWG01TUJjQnhzUnRZaktWMDZhdkZx?=
 =?utf-8?B?bFdMdldLQ3VheWNXbTFBOGNzNWZpQXVXOXBuMkZIZlZGM3hUMzl0Y3I2UE5i?=
 =?utf-8?B?UG1GNVZmVW91ZjhJSjJ4T0MrVkdEVVRmV0lod0pZSGM2d082V0MzaFFmMXVC?=
 =?utf-8?B?WGhJSjV2a1FLTHRkSU43QnlZcXlPekZnTVNTZkdQWnQ1UzgvYVdNRXZNNFo5?=
 =?utf-8?B?YUFlUW1BMElyMlpnRHRZWU9VeWlOenV0RzlIcGpkaTRGd1QxUWtNY0Y3TlF0?=
 =?utf-8?B?MzJISWJ4L0NxbURQczAxaVBsTDRURHFaalUxczFCTjJsb1M0eEJTME93NlFF?=
 =?utf-8?B?a0xDc3JDYSs2NTNYRkgyZnUrSml0Sm0xSVVoazJLUXhidDNTS3hFZGp5NFky?=
 =?utf-8?B?cjdLclJBUFZDZmZjN1lMNHJKa1RwVFVJcTFiVWpVWTJIb1RkMXNiQ0JIY01O?=
 =?utf-8?B?dWd6cjg3ekJKSncydnJPOXF4SWt1bUxQUnRBYzFKK3JqWnNjeWl4aXdFUjFK?=
 =?utf-8?B?TnlVNHJjQjVrT05DTkovNnFVSGlWdnJDcGxSaU5teXlra253NFBhbUlBWWtI?=
 =?utf-8?B?Y0QwTmcrSDQ1TmQ2SDZsL1lsUnBoODg4VjFNMU5UdUZyY3Y1T0w5UXg2Zzd5?=
 =?utf-8?B?eTZQWnBOSjFqYWtMMVlpendpY2ZMbHh3bEhXdG80TTBjQy9hR2p5ZGNSZ0l3?=
 =?utf-8?B?QVFyOXdJbDFMYjk1Wjgva0hNMWw3QnRDb2lQNWxrdVlyNXZqSmRqOXhTTTV4?=
 =?utf-8?B?K01MY2ZDN3dsb0RaZlREenozV01teVA4MHJaQTRXdkJoaFoxdXNDRFdyZUpL?=
 =?utf-8?B?N0JFTkFzN0VhQW5qeFVDdzFmQS9QckVzMGVIallHZkR3OFd0N2RkLzRWcEtK?=
 =?utf-8?B?RjZVUFZtUFB4ZVJ3OTNUWTZsQVhPREZCcU9jditua3p5VzdLa0k5Wmlrd0l2?=
 =?utf-8?B?M1pqb3p3WWxpYzhsWEs0RUx4UjZLSFhENkZiNWc4dTE0cElTbUdvMUlqOEdZ?=
 =?utf-8?B?eHpxUW81S0xXNnphaEVHRnFtSlZlcUNtUzVyVlF1YVFxdHJpTlJOTEV0ZGEz?=
 =?utf-8?Q?i3FDrFprcnkNZJ47/9CIbSl6kRqoJCM9NulBeo4EHwPGW?=
x-ms-exchange-antispam-messagedata-1: 1kfxjriTVm+u8Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC758DE8AB51EC41A85B07091986D86D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b49e804-3596-4bc9-859c-08dec637d75d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 15:00:27.1578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iirzE2v36T2X3n86ME09tHuGH9dGE5/0hYPMsmiSHE+U1wgT2PD5YEKSWrktjXUSjKRfZtwlVGQEOqfhEbwyCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072

T24gVHVlLCAyMDI2LTA2LTA5IGF0IDE2OjU3ICswODAwLCBEYXdlaSBGZW5nIHdyb3RlOgo+IMKg
wqDCoMKgwqDCoMKgIGlmIChibCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
b25zdCBzdHJ1Y3QgZmlybXdhcmUgKmJsb2JfYmw7Cj4gCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldCA9IG52a21fZmlybXdhcmVfbG9hZF9uYW1lKHN1YmRldiwgYmwsICIiLCB2
ZXIsICZibG9iX2JsKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZG9u
ZTsKPiAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLi4uCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG52a21fZmlybXdhcmVfcHV0KGJsb2JfYmwpOwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWZ3LT5ib290KQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gLUVOT01FTTsKPiDCoMKgwqDCoMKg
wqDCoCB9IGVsc2Ugewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmdy0+Ym9vdF9h
ZGRyID0gZnctPm5tZW1fYmFzZTsKPiDCoMKgwqDCoMKgwqDCoCB9Cj4gCj4gZG9uZToKPiDCoMKg
wqDCoMKgwqDCoCBpZiAocmV0KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudmtt
X2ZhbGNvbl9md19kdG9yKGZ3KTsKPiAKPiDCoMKgwqDCoMKgwqDCoCBudmttX2Zpcm13YXJlX3B1
dChibG9iKTsKPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0OwoKWWVzLCB0aGlzIGlzIGdvb2Qu
ICBUaGFua3MuCg==
