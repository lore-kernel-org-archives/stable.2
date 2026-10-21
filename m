Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792588380;
	b=Al4dzm+xBia9q6B0Hro7KWBBF8ZmroGvcvRE0WeFuXNG3MKawvHcrNuo6A1qbOhJZwvL
	 ATrl+Zvtd9nEl9EQAgoMayetgiqfmsMF0AKIndG32Ct5BT/52cCuNNfxmKmfdjVq/yVgK
	 TR6+ofv1bee1ej/hr+yJk2WvYsysft0hmC0O14AuJPWQPhRk030sTD5CBi5DglHS4utCf
	 B3V6hrJqpwQ5mgYQUcsjA9lLwPiAkeNUEF4zoKh7LiBr6A+uXJEkpYTxsDkGkI3c2WJV9
	 9veEc9AokPow+9vH01hrjjg7aejyR/x9saoLkfHbMSaSsgfghLPUnZUqY3o9B2l6mhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588380;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=eAYTLT1x4zH7Ol7tWA9Zp/A6XIDe+x91QR7V5rizqC8=;
	b=21kng7J54ZEZb/bC5rzZ+BG6PXN1nwR8wezvikudSKFU2pOUGbuXKJ6Q39yRA8N2Uv0x
	 R8XHRSjK5utBnrIbJ/9JCN8Spl/zqakKnd5rv42QSf/d37ZtwYyfzzbpSwToiJGSDrMQf
	 UrX6NPV2R5LCFOK8GW8tTZWvBZDw+HybyULB556fy4Z0ysrTVvkqW6j6Yo+Lufs+wSK72
	 xNJg3Mo5HeTe7UPBicclgpSYqGrSFVZm6wUCA15advpL7czbi/Ge0obf/sMAkwFvI1ha9
	 7IyAcRdO7K+pyHgb8EfuKVsFdVhCdQw/t37U37PAEAFg5TOlYiaAGMdmywTePfzib7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QShUyeMM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9849A606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 13:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9849A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QShUyeMM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792588379; x=1824124379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eAYTLT1x4zH7Ol7tWA9Zp/A6XIDe+x91QR7V5rizqC8=;
  b=QShUyeMM9zKrGwmoWGK7N1sHQRS58DGaU18ddz/Ij1sThGjUaUQ/73Iv
   tHYG/2a+R2rEyqlTXMYisG1/F3jsi3H4oLtulbzlCwBRSyUp939NWTWlG
   oamYUc5Y84o3srATkCzwDzIbjLllypcEbGIvEwvS6FlErwINfCT0wZoQa
   woH3y5oEZ7iCOcu22/WG/wVLT/7IZxWe/+HDrwu5wGQx3Fi5zhNZXZYfc
   T8NpOoHQ+2d67CV9m+/fTxmwzN7F/Qa4OjHgA1z7QPatuPS/eNukU5toG
   SSt7thkMSZBcRpB7V64uni1kh6GglSLWGilenuK6+CQU2mLwOSp2wsxWi
   A==;
X-CSE-ConnectionGUID: fV0AJzOpR2OH9Y+AKBWttg==
X-CSE-MsgGUID: ueMMs8STTcq9GYDG5pa+aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1211820"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1211820"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 06:12:58 -0700
X-CSE-ConnectionGUID: Lwiw1c+oTEO9hLVqrgbttg==
X-CSE-MsgGUID: ExfqAPzVQsWNYarlx/36Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="4922679"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 06:12:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 06:12:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 06:12:57 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 06:12:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOoPlFyKgXNt4nNMhyIMEkLCCQ6qqS2KzutQFa8N8Z+8BpzQfdWn3+dmwgECvclkx1eYWIgvbo7eLFXqeXUSOQ0CL6+UHYfn29j4CCtWYyDR1yt24X6N545EdpHsKlH2lCX3GnJ6kPxzEsYxF9oHyTc7bZXFliLXLFwguwQ0DjQlUtxZijBDbVhVApvog6i5avHgfv2Wn2ECA5PovUMwCqPapNfAbP80B2SszK2G+J0kc//I/Nv6r3E1m72LmwJEOmU+nVKVuO7hMKwnW5d5chgvnAD/zvnv/FjvnjJNE6Czcmmk1uVcR+JrhMPJoNRMplBMw1ZWRZQdweIUuWxLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAYTLT1x4zH7Ol7tWA9Zp/A6XIDe+x91QR7V5rizqC8=;
 b=pQd2l99QcBUyMHDw355m7Gznqe+H5HUvDpH7ws+H02Q2L7YkeKQXRhFmz6BHhB+2xoe6F3QzK3K8gXBvmr5EA4qUy9h0alHyxlLMZ/P1MEpq1Gc44dK1vFnYUl3HK1chi5xL4jS8g8zYSbtAlsVzbB+nITq9BKLpzR+pPoYtN3f84QWKe46VmZpjA1a70CnG9kfrwR+OiX9aQZkfwze62edOrJmFZxAO07hNtpgPAO9sYruoEgI56FZOCx0CIrtzD7Bj/uNy8ucZH5SZn7J+pd9P5pH8W3LI8TgoaOFlSCCZbHzbvuhltvguDEm21oegpBeLC+79BLshTYY/EO/lUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::28) by LV2PR11MB719417.namprd11.prod.outlook.com
 (2603:10b6:408:413::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 13:12:54 +0000
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9]) by DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 13:12:54 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Hogander, Jouni" <jouni.hogander@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 8/8] drm/i915/psr: Don't clip plane state destination
 rectangle
Thread-Topic: [PATCH 8/8] drm/i915/psr: Don't clip plane state destination
 rectangle
Thread-Index: AQHdT/gjQktPEo81QUi91kL5e1EXJLcIG7mQ
Date: Wed, 21 Oct 2026 13:12:53 +0000
Message-ID: <DS4PPF69154114F80BF31B75710934CC43FEF662@DS4PPF69154114F.namprd11.prod.outlook.com>
References: <20260929094434.77129-1-jouni.hogander@intel.com>
 <20260929094434.77129-9-jouni.hogander@intel.com>
In-Reply-To: <20260929094434.77129-9-jouni.hogander@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF69154114F:EE_|LV2PR11MB719417:EE_
x-ms-office365-filtering-correlation-id: ddbf4e39-8c2a-43de-1c82-08df2f75045a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|10070799003|366016|38070700021|56012099006|4143699003|11063799006|261009223027099003|18002099003|10067099003|22082099003;
x-microsoft-antispam-message-info: mHX7uQFDo8q6vcOqeNq7qYSvVv41FZgfllFApKOEHsn/YyUJbIJmxV8wIohQxQffAI1ZEYIBHIKDxSMBtV3D/nc+4MNMyRu5ahNLpekvnAE/oSTr/UyAiDzQDeKClTghDJM6gcYX7epsynyuf0FDO0EmMyiqEHCOEJzeZIQX/YPWHziQqXXdqqC8M+3ozKp0B/Gv6g0dypZO1FYq6VPukYWM42tU6Errv+qJUB2+ADXXYz7FSAVd3pjK0KXl017f0c7n+os4CxI75haWdwxzZBh64ye/ib/R4yTEMDD7U+qHGFY6+J/qe3A4tjvic0S0QpTLR19SVWtZmLrwyi4Vkubxha8yXpClYz7ciGH75Vo+FSPXV5sGvw6F9MqmWtwYKbeFNR9UkhRmAdHVDEtOLq1YLUMp5sQMgCbSo2Wj89zK5JV3QYUaOrmLsOnLTVz3PvUdOCuC7jDcAbonGZup4FZLzDh59mboBuKQr6VWtyHwkE1OyKPVB2WZ3U6QPgy/qOGHRuRLBGE60WAHBI8UIGm1nB/JWjQotb+DhgHgNqsmHxG3I+4GhX5sbax6r3OafEinmaMO/r8AaL9nhO+2H8Z5EPUiJK/DSfKLaUv1psIOFlhL5CokrFJWgu2yo4yAnz0nd44uwNLw4dxMBFYSZqVJDxbipAUDNxPwh+ow7JGWasopSHma669TdhRlJoFwHbKyz0cySzRtKekfddmkgBAOkxL2d9UjOCC25D/ysSI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF69154114F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(366016)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1I4RlRZc3c0QVMvaUpBTUZsMGJWaHJGRjB1OUJjN04wQWlRUmNwWUJucVlt?=
 =?utf-8?B?azFOTnBFQWorMWJwYnl1NklCSm14aUdKY25VSE1SQXBHRGh6cUpXSHRtdjly?=
 =?utf-8?B?Q3RESGIvQjBEU3JGOExLWENFc2RlN05XWGZraFFWbkZFUUhhaXo4QStPWG94?=
 =?utf-8?B?Tjl6eVRjblRvN0NUeE1LcFgzOElOM29rUTNmdXFFVDk4RzhuNlo0bWU2MkNS?=
 =?utf-8?B?VHhLZFBicG94bnFObFBBTVlITm1aZGlEWVRHRENldmdESU8wVWRVdlFHdEVB?=
 =?utf-8?B?RVZxbE9kWXV2UjlpWUJMM3RWN1ppRHJXNjI1bHUzdmRMWUM4WVRZTVJrUnZ0?=
 =?utf-8?B?V0I0dnRha2RkTCtZbTJ3SFl1Q3pITmw5d2VLdGhJUmtLeWk5bERhWjFrenpS?=
 =?utf-8?B?bnVjMVFKb1BvSmxxM1JoSWFGVFluenlmTVV6SlI1ZUlOQlNpQldEWmY3dUVF?=
 =?utf-8?B?V2hzZTVKV1BvaTBDL1hOR3dxYXZuSjluWTNqZlVCM0xoZkthS0ZTVHpYZHll?=
 =?utf-8?B?bmh1UWxzVkpRNVBvNU11V29tbnBoSkZnbjFlckNISGpiZXR1SHBvbi9zM2tx?=
 =?utf-8?B?QmY3bWE3K003Z0VyZjhWcG5VRVl0RjhsRlJZUll1ODRNTm1WaFBGL0Q0dmhx?=
 =?utf-8?B?ckFEeW5mS2dFNGdlY1JEM1IrU0tGU0MydzZGakNZcUZHb1R5TzJacHNvNW5N?=
 =?utf-8?B?bG51Z05NejVtRGFURXQzSEVHMnpHZWYxUDNZWFJvN0ZuVUhzK1BrcmhtUXBT?=
 =?utf-8?B?VDRqQUloTWZIYk5ZRFU3WHZWbmtGTmhNRlNhMDNINUJRUHNQTTBFeTBqZTBz?=
 =?utf-8?B?OC80RHhtUERUQ1FZZGVmM0dCWUJrajJ4MEtwQ3c4eTNQcFZHMS9WRDY5K3lH?=
 =?utf-8?B?ZWtndDJVaDBablVVdjZSalpDNmxXTTVNbG5XUGk4REgzUFoyRWdEb1FNUWpO?=
 =?utf-8?B?aEYwdDdwemZ1YThDOVVkYzlLV0ZkYWJsT2NZdEUwdzNOQXVIUjNYdFhsY2d3?=
 =?utf-8?B?YURNRnMzSFFKL0xnNzU1RndpREJ0TjBPb3ZoNWFDallUaVpGT1JIQ1JmclVj?=
 =?utf-8?B?V1lhWndzRFFIYk12aVh4TFFLK3UrWjFwWmFyVGhIUGVSMzgzN0NRaTduaTJp?=
 =?utf-8?B?M0I2MVNaR2c5YVpvcUVzY05nT0oyc1FOUHhKL3RDTU9zM2M1RElXQlNrQm94?=
 =?utf-8?B?RVNqZDhGSzRIZXNqZmhPd1Fpa0RmejVTbWMvYVdvVDFKeTdTNExlTEdtdnN6?=
 =?utf-8?B?TTl0bHRmdDJ2RXkwbUJ2Q2lBWU5TOG5BSi9jU3NHOUZ6QTR3SDZXN0YrNkNC?=
 =?utf-8?B?UEkrSE5FL2owbHRQOW5obmtsQWFpYlp2My9QcWJCQkcySXVFdEtFTXJsOHpk?=
 =?utf-8?B?d0NCaXdtc2lMYW0xZzZPM1lBVDh6SzFiSzh6Q3o4VERDMXFaa1V2T1R2U0hP?=
 =?utf-8?B?UzJPQWVUMWxUcGxOdjZvY3p2SkdVeU8xMy8xYVk3eEo4MEd0RFNoSk1GT0hL?=
 =?utf-8?B?aG5SeFVPU3k1Z0xjS3ptd1NSc2JXM09kQzRQZDZzeExqcEowUkVHdHVFMFEy?=
 =?utf-8?B?UktUSXdPcVpSeis4NFYybVZySmgvZzRtNisyb1VqMHBEN3YyNDBHYWxndmVP?=
 =?utf-8?B?WVg1akVHRkgvY2pvV1p6VmJSbHVlN3FJN0w2enJCTkswb3I3LzB2bFREL2ZV?=
 =?utf-8?B?dkI3SS9sV2JJQVMraEpFa2Vna1RVZHh5K1Q2WVZ2eFB2akE5ZklabE0vdUo2?=
 =?utf-8?B?cmtmM2ZtdDlVem5XTjZ0TWM0ZG51MjdMV05XNVcxcUpHTlN0Y2FRdzd1RTBF?=
 =?utf-8?B?ZFdXTE9EbXZHRW1aV3BmbzI2Z3FRMlBjVFdhdmpDclFKdmF0MGdFVlAwTGlh?=
 =?utf-8?B?N3kweXhEYzl0T3hxVE1YYXJZZ3FWZmFWcVBWTWFKVVV1UEZubHdVWWVYVjZO?=
 =?utf-8?B?alk4UUU0MUI2WGJWR256ZU1CQWp3SGJwSnlqQ0M1TFlTWE5wZ0lJeVlwNnBD?=
 =?utf-8?B?Y2lralhFM3Ezd2ZuUmpoSUo1U3ZScXlHb1hBUzRIanIwT0dxdkJmR2RuK3ly?=
 =?utf-8?B?M2phcFVJM2pvOXdGeDNnNmF2Y2VTeTBVa1ludGYrckRJZFduZG14d1lXNndL?=
 =?utf-8?B?TERlN2k0UW4vNzJDRkhGamZ1Rmo5clVXVmdoNWtURUIwRHZjMXpIa1hnejYw?=
 =?utf-8?B?Wmt5YndMMStxaUdEUGFBcFlYOFNCaWRHL2JLSG54ZHFoeWQwUDZ4SFRWSHdY?=
 =?utf-8?B?OGlibnRQUURkdWw0UVJVNExtcjc1aDVJcExEWE5jNzYwVUVHTlRUeHdzVHUv?=
 =?utf-8?B?cDNBU1VBMUJVRGxjTHVwa2MwL1BrbUJvd1pscHlBZW5FMkIxdGF0WnhVYmt0?=
 =?utf-8?Q?cTWDylzOmDj3oFfjy6+2Vx8yjOfEIS+nd+PAW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kdVPbuSdmULIUP+twMbEHQaUrk0eDbArmO5AypjljBzB17vWH/atd/TDZPyqfskfZvKYU55YAAFBBAyj0rmXex+GxFUrqch+/ySvMy/39EhF8aciHpzZXMNRNDw8y0kliYjMoEyLfzfSMjesaB/wh+5R8bBcxlk0Zc8drqSwUJn3Dxk8u6jgQtD9tvdEKTU/WByXftSj7Z8dl3ygI5kNmFPCRwQ6yMWp/+Jizrx/cAzX4ArgFnv4O3Ng0nBB8FmrGpHxySBO6yjNVaIW+t+j9cfMvvhiYmxMEtOFARQ+h7zmuoYPEydv1OIpjDKRU+PZv4qR4NmGGiRsv4/81pioqA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69154114F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbf4e39-8c2a-43de-1c82-08df2f75045a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 13:12:53.6232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UO+q447TE/7wtsUSPeaU2yBagZhk83D++c9Yz7l0ShdqIAXVQojAQHHwRXYwc01PTc4OmU6v1cgcvBxZwYtK9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB719417
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC1nZnggPGludGVsLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEpvdW5pIEjDtmdh
bmRlcg0KPiBTZW50OiBUdWVzZGF5LCAyOSBTZXB0ZW1iZXIgMjAyNiAxMi40NQ0KPiBUbzogaW50
ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IENjOiBIb2dhbmRlciwgSm91bmkgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT47IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIDgvOF0gZHJtL2k5MTUvcHNy
OiBEb24ndCBjbGlwIHBsYW5lIHN0YXRlIGRlc3RpbmF0aW9uIHJlY3RhbmdsZQ0KPiANCj4gY2xp
cF9hcmVhX3VwZGF0ZSgpIHVzZXMgZHJtX3JlY3RfaW50ZXJzZWN0IHdoaWNoIG1vZGlmaWVzIHBh
c3NlZCByMQ0KPiByZWN0YW5nbGUuIEVhcmx5IHRyYW5zcG9ydCBhbGlnbm1lbnQgcGFzc2VzIHRo
ZSBjdXJzb3IgdWFwaS5kc3QgcmVjdGFuZ2xlDQo+IHRvIGNsaXBfYXJlYV91cGRhdGUsIHNvIHRo
ZSBjdXJzb3IgdWFwaS5kc3QgaXMgdW5pbnRlbnRpb25hbGx5IG1vZGlmaWVkIGJ5DQo+IGRybV9y
ZWN0X2ludGVyc2VjdC4NCj4gDQo+IEZpeCB0aGlzIGJ5IHVzaW5nIGxvY2FsIGNvcHkgaW4gY2xp
cF9hcmVhX3VwZGF0ZSgpLiBBbHNvIG1ha2UgdGhlIGRhbWFnZQ0KPiBhbmQgdGhlIGRpc3BsYXkg
YXJlYSBjb25zdC4NCj4gDQo+IEZpeGVzOiAxYmZmOTNiOGJjMjcgKCJkcm0vaTkxNS9wc3I6IEV4
dGVuZCBTVSBhcmVhIHRvIGNvdmVyIGN1cnNvciBmdWxseSBpZiBuZWVkZWQiKQ0KPiBDYzogPHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjYuOSsNCj4gQXNzaXN0ZWQtYnk6IEdpdEh1Yi1Db3Bp
bG90OmNsYXVkZS1vcHVzLTUNCj4gU2lnbmVkLW9mZi1ieTogSm91bmkgSMO2Z2FuZGVyIDxqb3Vu
aS5ob2dhbmRlckBpbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBNaWthIEthaG9sYSA8bWlrYS5r
YWhvbGFAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxh
eS9pbnRlbF9wc3IuYyB8IDIwICsrKysrKysrKysrLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMTEgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzci5jIGIvZHJpdmVycy9ncHUvZHJt
L2k5MTUvZGlzcGxheS9pbnRlbF9wc3IuYw0KPiBpbmRleCBkOGZlZmIxM2MyNzkwLi45OTYwM2E0
ODZjMjc4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVs
X3Bzci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmMN
Cj4gQEAgLTI3MDksMjMgKzI3MDksMjUgQEAgc3RhdGljIHUzMiBwc3IyX3BpcGVfc3Jjc3pfZWFy
bHlfdHB0X2NhbGMoc3RydWN0IGludGVsX2NydGNfc3RhdGUgKmNydGNfc3RhdGUsDQo+ICB9DQo+
IA0KPiAgc3RhdGljIHZvaWQgY2xpcF9hcmVhX3VwZGF0ZShzdHJ1Y3QgZHJtX3JlY3QgKm92ZXJs
YXBfZGFtYWdlX2FyZWEsDQo+IC0JCQkgICAgIHN0cnVjdCBkcm1fcmVjdCAqZGFtYWdlX2FyZWEs
DQo+IC0JCQkgICAgIHN0cnVjdCBkcm1fcmVjdCAqZGlzcGxheV9hcmVhKQ0KPiArCQkJICAgICBj
b25zdCBzdHJ1Y3QgZHJtX3JlY3QgKmRhbWFnZV9hcmVhLA0KPiArCQkJICAgICBjb25zdCBzdHJ1
Y3QgZHJtX3JlY3QgKmRpc3BsYXlfYXJlYSkNCj4gIHsNCj4gLQlpZiAoIWRybV9yZWN0X2ludGVy
c2VjdChkYW1hZ2VfYXJlYSwgZGlzcGxheV9hcmVhKSkNCj4gKwlzdHJ1Y3QgZHJtX3JlY3QgaW50
ZXIgPSAqZGFtYWdlX2FyZWE7DQo+ICsNCj4gKwlpZiAoIWRybV9yZWN0X2ludGVyc2VjdCgmaW50
ZXIsIGRpc3BsYXlfYXJlYSkpDQo+ICAJCXJldHVybjsNCj4gDQo+ICAJaWYgKG92ZXJsYXBfZGFt
YWdlX2FyZWEtPnkxID09IC0xKSB7DQo+IC0JCW92ZXJsYXBfZGFtYWdlX2FyZWEtPnkxID0gZGFt
YWdlX2FyZWEtPnkxOw0KPiAtCQlvdmVybGFwX2RhbWFnZV9hcmVhLT55MiA9IGRhbWFnZV9hcmVh
LT55MjsNCj4gKwkJb3ZlcmxhcF9kYW1hZ2VfYXJlYS0+eTEgPSBpbnRlci55MTsNCj4gKwkJb3Zl
cmxhcF9kYW1hZ2VfYXJlYS0+eTIgPSBpbnRlci55MjsNCj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4g
DQo+IC0JaWYgKGRhbWFnZV9hcmVhLT55MSA8IG92ZXJsYXBfZGFtYWdlX2FyZWEtPnkxKQ0KPiAt
CQlvdmVybGFwX2RhbWFnZV9hcmVhLT55MSA9IGRhbWFnZV9hcmVhLT55MTsNCj4gKwlpZiAoaW50
ZXIueTEgPCBvdmVybGFwX2RhbWFnZV9hcmVhLT55MSkNCj4gKwkJb3ZlcmxhcF9kYW1hZ2VfYXJl
YS0+eTEgPSBpbnRlci55MTsNCj4gDQo+IC0JaWYgKGRhbWFnZV9hcmVhLT55MiA+IG92ZXJsYXBf
ZGFtYWdlX2FyZWEtPnkyKQ0KPiAtCQlvdmVybGFwX2RhbWFnZV9hcmVhLT55MiA9IGRhbWFnZV9h
cmVhLT55MjsNCj4gKwlpZiAoaW50ZXIueTIgPiBvdmVybGFwX2RhbWFnZV9hcmVhLT55MikNCj4g
KwkJb3ZlcmxhcF9kYW1hZ2VfYXJlYS0+eTIgPSBpbnRlci55MjsNCj4gIH0NCj4gDQo+ICBzdGF0
aWMgYm9vbCBpbnRlbF9wc3IyX3NlbF9mZXRjaF9waXBlX2FsaWdubWVudChzdHJ1Y3QgaW50ZWxf
Y3J0Y19zdGF0ZSAqY3J0Y19zdGF0ZSkNCj4gLS0NCj4gMi40My4wDQoNCg==
