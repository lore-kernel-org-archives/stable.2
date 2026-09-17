Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CB4CEE52;
	Thu, 17 Sep 2026 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643179; cv=fail; b=cj2f12KD/br8Yl9la0slhNzVnAQr0Efgbgfg02J+PK6xtGWcSJKAI2/Egt3vEzGkIwFva1eSGgymlPUoFq7FdZgf+bQre2mYjuQ1qvDGGafyc7aGoTIW1xeDnrZQzLh8EYHRy9Y/iHQ1EjeF4YtkYDAN7X9Xc4xKyYmENl/MQjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643179; c=relaxed/simple;
	bh=vX7Rn2Kgx1257Hxj3EG2LRp0kdUnBGPHe49qvOxKrRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hiwOT042iH4HfBwjz//umWDwGSo0aecI6D8XhjTIfgeDCLmOIKb4SbywS1M/DRJ0XRN47P5qQVMgpng0/9FOWe9FHVIvHtV4STroioH6cEnLJPOtEKcQq0IHwtWGHHc9CFb5FhGH3HUhiAvA5erVU+OE6kPdGb8Zo27kgsbPrMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NKyDT6lW; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NKyDT6lW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebSgyQHYdYsVNV/39NjRxKjpUcCulNN6og5kqbJSs1LM31GNVYXPM0OCgRUdrfjH6ZxN8h0FQieW+WFLW6Aupoki6u2ccWJwTRnZxhxBlkefsaf7Z5tapTgbwpJxBoxFrfIL1hQzhmOTXMoVtqi2kYghBAjjXipl/E+/y8uK1s1hqa8bjiKA/mxB3CcCfAtamSA/uYZCieWZJNk0P/tNhAD/lDozshMqo+hQ2j1K+5aRpqzG/xjnWoidGN9tLvpAll93x/ryWkTZRMDPZfZUtXO7irxsBuv+u15HpBrZlkcFnIwes1yROOwNZ+bw8Ghfipfg/cqSEBfyhQ2Qdv6Q8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX7Rn2Kgx1257Hxj3EG2LRp0kdUnBGPHe49qvOxKrRM=;
 b=T9NRgHlQh6AXhyG/7GqHZL5cMwZPznQSmIg6LzTsqL1ROSi5coGZXAy213d8GzN/ffqKH7tsjHURu04RmepC5pCycGIYR0uGjkspNr3ZifU3qKhbxx5i8ExlfgMO0VzU8Ny2QGJh4TScn8Bucy5WyfjrGeerw8RVX//Rgd8Hp9cvQJU98qCQFID3rhNjBbaTEtqFJWtMEeLbe4c1YtnK+eSp9RonT20myLGsracYeObttK8dXKsiXxX6upgWhn56XzzK8PfBmdeBtxauPJCsZkQnnEoi3ecxbY3/hE2f+tx6IhHJ0kNMpYt4JhMomBpYVFUag2X/msgiJ/WyhzCg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX7Rn2Kgx1257Hxj3EG2LRp0kdUnBGPHe49qvOxKrRM=;
 b=NKyDT6lWIve/yrAp9Bp2HD/4cHd70NDV2xV4HFllc0I1fE8xYIJw3LeQKlMFmRLfLG8pHTG7kZ3f1iSTuTMfNg2GEVMt4+CAhCuWoMt0eMvDCB/csQsOfpNa2135TaeTKVWU+4dz6hX4AihcIe9h9zfvJZ51F1gKVXCDb/q+vjIUYqKugw85LssoqWkf9qNWtwzD4vyzz6r2UE6Ip5Pp5yEbi+DuQ5ZHEnV8JWRKl7bIYQl2Yu6g16fostWzaHjRmyZbaMg68neSOIS96txg1YAtaVzADBwsNjfWC3a3H1WWuLImnZdQ9vBbrIjpHJ2dUC9xZMI//Tn8Xy1cGY27HA==
Received: from DS6PR11MB523643.namprd11.prod.outlook.com (2603:10b6:8:468::12)
 by IA1PR11MB6537.namprd11.prod.outlook.com (2603:10b6:208:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 11:06:06 +0000
Received: from DS6PR11MB523643.namprd11.prod.outlook.com
 ([fe80::1cc0:e019:a70b:f954]) by DS6PR11MB523643.namprd11.prod.outlook.com
 ([fe80::1cc0:e019:a70b:f954%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 11:06:06 +0000
From: <Manikandan.M@microchip.com>
To: <vulab@iscas.ac.cn>, <Laurent.pinchart@ideasonboard.com>
CC: <airlied@gmail.com>, <andrzej.hajda@intel.com>, <dharma.b@microchip.com>,
	<dri-devel@lists.freedesktop.org>, <hari.prasathge@microchip.com>,
	<jernej.skrabec@gmail.com>, <jonas@kwiboo.se>,
	<linux-kernel@vger.kernel.org>, <lumag@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<neil.armstrong@linaro.org>, <rfoss@kernel.org>, <simona@ffwll.ch>,
	<tzimmermann@suse.de>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/bridge: microchip-lvds: Fix runtime PM leak in
 mchp_lvds_enable()
Thread-Topic: [PATCH] drm/bridge: microchip-lvds: Fix runtime PM leak in
 mchp_lvds_enable()
Thread-Index: AQHdRcTy9l2qmE19Dk6sSSDeQ4mXe7bSnYeA
Date: Thu, 17 Sep 2026 11:06:06 +0000
Message-ID: <97b1638e-2d9e-4301-bebb-c033e36da0e5@microchip.com>
References: <20260916101922.2018259-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916101922.2018259-1-vulab@iscas.ac.cn>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS6PR11MB523643:EE_|IA1PR11MB6537:EE_
x-ms-office365-filtering-correlation-id: 0284687b-5add-4613-c08a-08df14ababa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|38070700021|56012099006|11063799006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info:
 lvsxP0SMxWxCunCOuXJUc/N7GGKaiN/bIQkdMfbTLLcWVL4NGByUcXv8VRq9b8YOzoO7QpR2IckL9A2hO+BSZkyMisCySP98eUwKXzAN0TJVHG9df9WcFZDLu5LFSJWZdJtJRuLrEQbmDKK9vq3nyAL9Irafd+zohBBuR7CiBYJHx+VEMS3pAL8CIkmxyzuUyuzTFgdWotybc+f+C2eMiV7YO69YIg306hnRSbu89jUVL9Dxl1OmPv8F7Mudo+oG4Nr3DAJ8EMgf+VVCL+rpFkGDwlt8u+Xl9/QwfOZJoBB6vEDSKk0ne+6WkeSeg+Z/wcE1A6taIMS0lhHUonL8Hlwnt0i9ollIWDDqRMvhflhc8BeQuXa9RaL5Mut3lzcohMb5C47jGC8RbKnnumc0g/Bg6j9ogYUaEDZ1NEkxImnpLEyz7s3YBLkaDp5/f83kbZx0v1JUEEZAYzhhpnNzIvOIfKejIvxDZT0uvprOwXQW48cmFCqxIEHKEahR845230YOBJsSWCHJ2POgE6uJSzxPxyANmZ8YMZlP8ca2GLymuUk3Umar998+FJv/bcAIwhslbgqkcdWVTs/STklwI0cpm/tPBqq3tAX9UmeWRouwzhwFtiO6EyjliZnJISYKShwvZPR13vvnG6DJO1s374to1RuNgMMJOi9voh+rMn91Ko7quRv9Fc6S6ZBBvKFSj97flloCOt5NMl6UcOWqSFWXcn1cXLLZ3m46eCtb0aw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS6PR11MB523643.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUNldWgyMGxWYWNHbHQ3eGRXTkd6ZWdsQUZnT1A1d2lRZHJ4UTEzc1JkRHl5?=
 =?utf-8?B?OFZheFJlV1FvVmpJVXhNTGtrN05OeVBONFhObldLUnNqK3pPNEZrYkdwZnF5?=
 =?utf-8?B?dlZJN3gvVHFHSXlTRFhGOXJnd2R6c1E4V3ZGc3RvbHJYZGh6WnBTQmgzeU1h?=
 =?utf-8?B?ZkllY0Q2c2ViajQvNEVFei80d1FtOFYvVU9MVmxUSk84YjRraFlWZ3l6SXA5?=
 =?utf-8?B?ZTRwb0dGOC9aUzhNcVEzd3ZjMThGeHNpc1krODBTUFpaRUFXRWhGL3R2YjBa?=
 =?utf-8?B?eXZnMEt4TWpONThtUjF5aTlhNTlOSTA5NWFhL1RFREJsV2cra1VsN3k0QXZz?=
 =?utf-8?B?SDMrT3MreHNTbTlVQXdrdWJBVjlBN2J6Vk96Sy92b2NvR2k5RjMvUS9zd2I1?=
 =?utf-8?B?QVJUcndWT1pqbTA4S2VtRE4yWVViVGlBYmdoWTNRcUY2NXE5TVZvZ2lHT0Zy?=
 =?utf-8?B?anE4UjRaRlZGWUd1ZTlVTkpzZW1yV1pLVCtKWi9pUDRlMXFPVkNqc0p4d3My?=
 =?utf-8?B?ZDNqdGRNZGxBWlloRWRiRnl4azRVRVU3SXZFK1Q4TGg4NzVrY2tNMVdBdFZN?=
 =?utf-8?B?WmcxS0FUZW1WYzBiNE8vQnp1cE8xSDIrT3JmRDJTVHNRbmk0N2dGVWI1UXJU?=
 =?utf-8?B?WVhvV1UyVVRMd2txUC9ZbVY1a1JEUXFUQkhUVWlLRnRva3plemJMVUMzV0VV?=
 =?utf-8?B?VzEzSXFMdHBxdFFYeENLM0FycGs1eWFGWCtrUkFyNTN1WUd5ZFptdGUrQW85?=
 =?utf-8?B?NTNkT1gyRVdvQjJXQVRhM3VNd25ORHltL2Q5TWZENThzWEsyQjlOZTZPeHZB?=
 =?utf-8?B?Z3h0TVc4NVcxdTVYQmZoSk9VanhZWkMvNWNxSmRMVmkvLzNBTzhWTmMwN08y?=
 =?utf-8?B?dittZFhJaVNvdkVodVVRSkJSbGliY3Ewb1hmNks3c1NYR3h0ek1oSE93OXNU?=
 =?utf-8?B?RnMrVEVZS0V0OC9zNnBBQ1F2WHd0TG1qcTZGSnY0UUFhUS9zcDRaVDBqYkc1?=
 =?utf-8?B?S0s0T1ZYTUI5UnJQc1phVVMrN1EzbVdqOWZyMytxdUJ4WStKeFEzRk1DUEVV?=
 =?utf-8?B?emtYV3JieFlrU2RxMUwzaFkzR3BHYmc2RHdHVXZDNWNLbWtpbHp4YmlOQnR3?=
 =?utf-8?B?OHhhS2hQYTU2NzhWalFPdjRwVitrbDdPa2dDUEM1Q0NUREpKUTl2WUMzRkx4?=
 =?utf-8?B?WERKTE1tand4dTJsTkZUcVU4UkZHK0dDMEw3ZUJyU0VGa1lXSUYzM2FHaEhX?=
 =?utf-8?B?T1hBb2lXdmpNUnFRUmRHTzBZbHpQN0JkRGhnVDJBT2JmRmNKSVpNdTFmU3FO?=
 =?utf-8?B?WnJaWGkzNFpVUnNWblc3VjhEQXVpTlBFZmhLeTF3TVNlRGZ0dkxNR3dLZjh5?=
 =?utf-8?B?cHlzMk1QU0pYTGdMT0ZtUnJIWFVpZitwOVFKc3VNQVVZR1VNK0k4RlFxNkIx?=
 =?utf-8?B?MnJJdXQ1ZUtFbnVJcldHWWZvK1BNV0lLUVVuTndJQ2JLSURsUUJOWEtyWDRM?=
 =?utf-8?B?RmYwcld6aHpXMWMyTHdPMGtFWkFaWG1SdExPNlJKT1V2MUNJVGVORnV0dDZ6?=
 =?utf-8?B?OGExb3BZS29MYkEybHVaQVhja1dNaWtTbXNLODZhcStBZGtLdTN4dmt4bUlG?=
 =?utf-8?B?amwyRVIrMndtaDF1NEU3SW16MTFieFdGVWYrbXcxRWZtNXVTZUZZakFUYjA2?=
 =?utf-8?B?Qk14Z2hLdE5Tc3c3STBaNjUyOTN5WDZOUGk1bmtqMzNmNHVqdmU1clAwejRI?=
 =?utf-8?B?UE0zNUVmaWFyeHFnbnhjenFXSjdMaGgrL2FKS2ljQ2Vyd0NtOFhiZ1l1Nkda?=
 =?utf-8?B?MWc3c01LY0xrejA4UnFyYmhDWENTWTJlSGtDN0hnWTZjV3ExZ05nY3FjdVpM?=
 =?utf-8?B?WnJleDBTcnJKVVJ1bmVQaUNrbVNITTRQY1VYMFhUSDErb2ZIeGFBbGJockdU?=
 =?utf-8?B?VDRkMUhFRGFOallJdVdLSnhlQTUrZ3J2QjVGRHp2eXVHUVVWZWpGcjlqSXJz?=
 =?utf-8?B?Z284a1FwYklMZ0d5YnJ0TTdzQVRYazZJSXFNSTdCSXc3QzR0dmw2Nk5aR0hk?=
 =?utf-8?B?TzdpcGpSZkRNOG5zRlBmcE9XVFNSOEQ0TG95MTlaV2JrQXhhb0xXME5FeVZP?=
 =?utf-8?B?VHo0TXlZVzhSZjBCRmlOM0dKWlNjdU5qSmtoU0lBK3l1Y3lkWmgwcU9SdGI2?=
 =?utf-8?B?SitKWU1UTVkrWExnSy96ZnUxK1prZ1hPUUhhSDNUN2YrRnArY1NFUGlycjVo?=
 =?utf-8?B?eVo4aTF5MnpKS1dTN3pNZkJZaWlyTDhjOWdSQnVRZG5WaHRHUlYyblZrcDhr?=
 =?utf-8?B?enpjd2JxWkRtTjNtYUM5aU5WSVdTSjlqV0dSTVZpaXRNZEhQeEt1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <420E4DD73B5C66489955142A5E7F3776@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS6PR11MB523643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0284687b-5add-4613-c08a-08df14ababa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 11:06:06.1412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MvvQKqdGdbTLSKjsh81ohczhjorY1Bwllva/Z5BKOtiMEZrBQg1DFdNyzpVHbZn46mhgOXQdVXB7b8XJZNJH3dKRY8qfGEcFTKpv4ljdn30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6537

SGkgV2VudGFvIExpYW5nLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaCwgYW5kIFNhc2hpa28ncyBh
dXRvbWF0ZWQgcmV2aWV3IGlzIGNvcnJlY3QgaGVyZSDigJQgDQp0aGlzIG5lZWRzIHJld29yay4N
Cg0KcG1fcnVudGltZV9nZXRfc3luYygpIGJ1bXBzIHRoZSB1c2FnZSBjb3VudCBldmVuIG9uIGZh
aWx1cmUsIHNvIHRvZGF5IA0KdGhhdCBsZWFrZWQgcmVmZXJlbmNlIGlzIGNvbnN1bWVkIGJ5IHRo
ZSBwdXQgaW4gX2Rpc2FibGUoKS5BZGRpbmcgDQpwbV9ydW50aW1lX3B1dF9ub2lkbGUoKSBvbiB0
aGUgZXJyb3IgcGF0aCBtYWtlcyB0aGUgbGF0ZXIgdW5jb25kaXRpb25hbCANCnBtX3J1bnRpbWVf
cHV0KCkgdW5kZXJmbG93IHRoZSBjb3VudGVyLg0KDQpBbHNvLCBhcyBvZiB2Ny4yIHRoZSBmdW5j
dGlvbiBpcyBtY2hwX2x2ZHNfYXRvbWljX2VuYWJsZSgpLCBzbyBwbGVhc2UgDQpyZWJhc2UgaXQg
b24gdG8gdGhlIGxhdGVzdCBhbmQgdXBkYXRlIHRoZSBzdWJqZWN0L2NvbW1pdCBtZXNzYWdlLg0K
DQpPbiA5LzE2LzI2IDM6NDkgUE0sIFdlbnRhbyBMaWFuZyB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBtY2hwX2x2ZHNfZW5hYmxlKCkgcmVzdW1lcyB0
aGUgZGV2aWNlIHdpdGggcG1fcnVudGltZV9nZXRfc3luYygpIGFuZA0KPiByZXR1cm5zIGVhcmx5
IHdoZW4gdGhlIHJlc3VtZSBmYWlscy4gIHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBpbmNyZW1lbnRz
DQo+IHRoZSBydW50aW1lIFBNIHVzYWdlIGNvdW50IGV2ZW4gd2hlbiBpdCBmYWlscywgc28gcmV0
dXJuaW5nIHdpdGhvdXQNCj4gZHJvcHBpbmcgdGhlIHJlZmVyZW5jZSBsZWFrcyBpdCBhbmQgcHJl
dmVudHMgdGhlIGRldmljZSBmcm9tIGV2ZXINCj4gc3VzcGVuZGluZyBhZ2FpbiBvbmNlIHRoZSBl
cnJvciBoYXMgYmVlbiBoaXQuDQo+IA0KPiBEcm9wIHRoZSBydW50aW1lIFBNIHJlZmVyZW5jZSB3
aXRoIHBtX3J1bnRpbWVfcHV0X25vaWRsZSgpIG9uIHRoZQ0KPiByZXN1bWUgZmFpbHVyZSBwYXRo
IGJlZm9yZSByZXR1cm5pbmcuDQo+IA0KPiBGaXhlczogMTc5YjA3NjlmYzVmICgiZHJtL2JyaWRn
ZTogYWRkIGx2ZHMgY29udHJvbGxlciBzdXBwb3J0IGZvciBzYW05eDciKQ0KPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBXZW50YW8gTGlhbmcgPHZ1bGFiQGlz
Y2FzLmFjLmNuPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL21pY3JvY2hpcC1s
dmRzLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL21pY3JvY2hpcC1sdmRzLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYnJpZGdlL21pY3JvY2hpcC1sdmRzLmMNCj4gaW5kZXggOWY0ZmY4MmJjNmI0
Li5iNzdlYzZhZTBhOTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvbWlj
cm9jaGlwLWx2ZHMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL21pY3JvY2hpcC1s
dmRzLmMNCj4gQEAgLTEyNyw2ICsxMjcsNyBAQCBzdGF0aWMgdm9pZCBtY2hwX2x2ZHNfZW5hYmxl
KHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UpDQo+ICAgICAgICAgIHJldCA9IHBtX3J1bnRpbWVf
Z2V0X3N5bmMobHZkcy0+ZGV2KTsNCj4gICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gICAgICAg
ICAgICAgICAgICBkZXZfZXJyKGx2ZHMtPmRldiwgImZhaWxlZCB0byBnZXQgcG0gcnVudGltZTog
JWRcbiIsIHJldCk7DQo+ICsgICAgICAgICAgICAgICBwbV9ydW50aW1lX3B1dF9ub2lkbGUobHZk
cy0+ZGV2KTsNCj4gICAgICAgICAgICAgICAgICByZXR1cm47DQo+ICAgICAgICAgIH0NCj4gDQo+
IC0tDQo+IDIuMzQuMQ0KPiANCg0KDQotLSANClRoYW5rcyBhbmQgUmVnYXJkcywNCk1hbmlrYW5k
YW4gTS4NCg==
