Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616644;
	b=do3iXg8ySiBY73Cvkxu906YQ6GIQiqEa21lChEIgKXo9E0R3bZso9QK1N2tHfPzAehCH
	 zhJYZVm8IJWS6J4dLQ4AQXoOkh91qWBlv5NkmfbJBrlqu5+MhNshy/Du3VkK2M+MVc0nA
	 WpIDF/knkX8YXsWPG5bIimPGc/C0RMRSlB/TdtVPbpPNnbFP3aH92HxdHzXk2fx4vwmjI
	 hf9IGXWVSo5HBm8B5otZhF6y2ajZTNqP28wXpBhjfGutd86H3zMRQsaLUSkZUE4mxAx3z
	 XxPQuMw+c39EyQvJdv370BuaXjvIV7gGGYsdQHZc4r5hwP5V6k9HIwhe38FtcAmYMOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616644;
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
	bh=Y8mXd/siqLj0OqyAVYxnjqQJ5eiqetgZugEaA1tvUSI=;
	b=KJURQj3PkV1xUx+aRjcPXw9g9eKbryfoPUjgV1WQGMe0ZTZMsmrj//oPcFt83bi5IpxY
	 AQZFa0D4bW8Hc678A2GUoXzIPNpxRkf/qKhYQtkvU2W//pUfzpXraxdrHOkhlg+qJAvHB
	 ArM/010dwAzsk5UJT2ukfUEGSpAmbpkHHC/uYRYAbzWI/WqvWcomRRYn17MLHJ97bxMyQ
	 hZsEnR/PP0ASjD+FIHSct9KEdJxlkOcG6MvnMeuZ181r+fVdyN200Kyy+vz0tSLs0ISt/
	 PlsRZz7MKlrLhYdn+i/p9xvjBlXbknJRYFpfLQu3BAsGLySxvch+oYqmV3t5+JJSiEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OGrJCoVf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91940606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91940606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OGrJCoVf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616644; x=1825152644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y8mXd/siqLj0OqyAVYxnjqQJ5eiqetgZugEaA1tvUSI=;
  b=OGrJCoVfsMuar18FTbgJehSYa26QfgtQugFZ1qR34YqKgcwf54y0lKhE
   3SMEDeWIn1pP3n+3oM9XkTL9PTQFQC/4KvTCkwRUxWHtiinO6FIyXCwLZ
   5a62Ye8EklIbFRT27kOu/4C1FTaENBvcf1Nu2/22SkinYOrZhbyluN10I
   ENNKeBtrcDsnCrMkMDQ+OMCoUtntEdalX7JPwjpk8duj7G4Lmb63xGVMv
   a4s0zwkFDtfGzlA5YWCrQU+vhtqZgmMLHfDOspHOQqYeWwFl9AnGFn8eE
   5dECPQHepdgiLT1SNUz2eF3h2X7hbba2JN6AVbfKRxmHRm9/rAT7l3Qcx
   w==;
X-CSE-ConnectionGUID: CwcgB60hRQGWXeUINFMLwQ==
X-CSE-MsgGUID: Gmwq+tArSQShYDx5V/HsXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2336144"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2336144"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:50:43 -0800
X-CSE-ConnectionGUID: 3l2ERpp2TbSxVWx1U1wcQw==
X-CSE-MsgGUID: yxkOc63bQlOHNQJfSqHJuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="5944469"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:50:43 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:50:42 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:50:42 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:50:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgEO+Ies2zafY3xc5gVAKSX9U6x3dCe1MFFDgPz0QdNLnCnH13kx0/YpTsQUDYlNLXNkbqFG9JYj0WyJOGm8RNZYiDztOZ83/dLwTQmY9SaNbiBXHHQD+gh4ASDO6EVd8TZfx1Kj2i/1UYEhYpM+isCNt5H1pJkVgrAbV3yJqpQWXEUomrcKbqKjl+qpfxx5HAGnQPmTm1cXWyEi2mEf6TtBYL6e8MtWMD9PhDIel4qHaxXTebD6CUhpRUWWy5PU26cwpYMCKXMGoF+SKwZxUX9OgmEnlOy9phoDK8RxC9l1YwyYCq8sFLsjryu0+GC4RGBWrUxRG740z++ilVdlSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8mXd/siqLj0OqyAVYxnjqQJ5eiqetgZugEaA1tvUSI=;
 b=Nfue9xVev1yEtkF0+2jkpisvH4Fpodr9LiUYewDzOEOt1+wqoc9BvmEKjSOcjO4CnocIyjTGdApNF1sLOqLc+7MhgJJ+m4gjNKqalwjcNUKYrRSTXqOL8idHNr0O4w9YWNtfALnQ8BiOH1CHv+/tMB6zx1CaOUaaiC+xo/eymox1DSpNaIeSNBn1r5vRTxMPb1CJnt1A7D5vse9wwlPymxTxIEmuN2bq1lY1Qjru7SgTV70auh6u/JhYR2b6sVLhw84vWonpJeyYJnkjgon1vd+wafgpVKE9wPvEjz9VV1QiHXmkFcgOKRc7GI7hZFhESDTJs43HiNuwsW5xm9iiEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::28) by CO1PR11MB5106.namprd11.prod.outlook.com
 (2603:10b6:303:93::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:50:38 +0000
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9]) by DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:50:38 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Deak, Imre" <imre.deak@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 3/6] drm/i915/pps: Reset PPS state after TypeC port init
 on resume
Thread-Topic: [PATCH 3/6] drm/i915/pps: Reset PPS state after TypeC port init
 on resume
Thread-Index: AQHdZ5kGAlSI8Al1K0m6BUp3K4VUubcaoLUg
Date: Mon, 2 Nov 2026 10:50:38 +0000
Message-ID: <DS4PPF69154114FE648853CDC9169E1B744EF6A2@DS4PPF69154114F.namprd11.prod.outlook.com>
References: <20261029113017.618286-1-imre.deak@intel.com>
 <20261029113017.618286-4-imre.deak@intel.com>
In-Reply-To: <20261029113017.618286-4-imre.deak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF69154114F:EE_|CO1PR11MB5106:EE_
x-ms-office365-filtering-correlation-id: eafa7923-ee58-46fb-db24-08df38cf218c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|11063799006|4143699003|56012099006|261009223027099003|261028144727099003|261021123027099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: bC5j1JU5QTXgU/100+NgVVbnwUGGvzJ+/7JJTgnXKtWFVbi5wn+Y/YqQ5eOGJjbYipB6TH5GfHpZznqw4pk5cGsqWW3HVT2+/QXcPVAxEdV49al2hEOHujBsxIAg7WqEeYNcUkTp99oXy7+0FH3QUiXLexKap6pU9MXpgZm7V+dV9BJE38ccy0ajEN1x9JH8ppaIv6zsOtKy5IrSljYFkvFjVf+aU3dPbmZqhCHncWqHMY6lROcC/szIoJR78s2NPeYlqp6BMUi4qic8UWFR/eackWxAX4n5VF2L7HAzRxWrO/fzKHd/HkmSj50LJPk/ahXBgePOgBRT2bx2Dk04YbasMIG1BvmXCag2stMymoJYOz4QM7AME19aO/pmEKbk4ZBhGhQQoncvE5ZcOCVNnWrt8GNBI4k4Oy3myAposWFZqwvDQahGcJeYTOFwA8iBPhHTqDNIErV10qEzBs3RGolxRVG+10NWpNdLV8woYUvQ1G4nIiZ8sbgk9eTfZDgXUplKg3YsWDxxtO8LU6ff0Cvb9hFHyyP1wofyVuBJUHv4e6fa/SzOvh4B+mO2m4jzT6R1RUOSUtA7k6IBoP1AJbu7nyrUl12OH7fXaG6cKdVvYYTxiHEaPG4VE8+Aj+sKEmu4uuHYGNrktKrb5TUPQ0LmfWel3NJx+o5ZMomEsMX0Pb0CVOgKw9KbP9rtdukKhTUuYEbGZMl/8f89DYO0I73Rg/TdIf4YE6zN4Ldh91A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF69154114F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUgzM3U0Ri9jd2RrbEZwTUpqYzl0djVxZEJtMnhyejJRcDNvaElURDJuSHEw?=
 =?utf-8?B?eHoyTjN1Q0pIRUdKNkI3cnY0UTN2MFB6YzkwUnJNNXhqNjZzVHhxVUdlV29r?=
 =?utf-8?B?V2EyejlsWTk5UWdzZzRhUGI5TXU2MldISDd6bWgyYmtZSEJMUzBEaDRXTmdI?=
 =?utf-8?B?KzRHM2M5UE95b1FlcVc5YzM1Ry9pRFZMWjB2bHVtemxoYUsxZVpqdTUwY2xW?=
 =?utf-8?B?VXVLdGtqcC9CNXlNTk5HWjhyQ3RHWlg2cEhBVzJnOTBPd243MVdGOWRTaDVP?=
 =?utf-8?B?UGpLSS9EUmNhaDF2QjNjSmRNeGFlT05LdzVOVzk4WmU3ZkdSdjBzVmdNNW82?=
 =?utf-8?B?U1NwQUNmeit0ODBLR0pORjlzY2IyQzNZL3R1TkRqVTV4cmduRDFabDIwWVBt?=
 =?utf-8?B?eHczdnpudkpycVZMeTNZSFUyampoZXZhTFBlNFpkZHpQNW9JVHhPak02R0JY?=
 =?utf-8?B?aE01MDNjZjNpOEUyQTErN0FBdHI2UUZkUjl3dmR2OE9wYWNkMXRTcUJTdGh0?=
 =?utf-8?B?Zll3MkZvNnZiaHg3MHU3U1l3eExPN0xTWlpWY09VdUVydW44YzZ0ejRUZk5Y?=
 =?utf-8?B?SERnc3NSUWEvMUN1K3ZZSE9CdFA2L3Njb2NZK0R5VENTb2tqd1FtcGdxUlhK?=
 =?utf-8?B?cTFwV1R3STAxWEI5WWh3U2hacmNxU2JUdk9mZUw3M0Vwd1ZTazZjd1VaZXcz?=
 =?utf-8?B?TnVCRHNETkJXNUhzOFdTSlhZZzMvUitzaDBGN2Y1RlBMcXFabWJscVBtc3J5?=
 =?utf-8?B?dzhrZ2tHTzF2aGFkaFRTT2NEcWdwL2NsK040dnZaMm9nZmg4dnY3NWVreE9Y?=
 =?utf-8?B?TGVBelA2clJhTTFyTWNzZ0dHcEJDSXFsVEQ1TzF0L0k5MndMWnV5dUIyMGgv?=
 =?utf-8?B?R2hMa3BvVm51WU8vSU1ST0V5MFpYUWpOeTMxS0Y1WDJMVlZ6bXFMdkluSkor?=
 =?utf-8?B?UW52MFZKaXd0Rm91UVRVK0hLaHB4ZURWR1VSUE9uVHlCZTJldjhqTVJHNDNO?=
 =?utf-8?B?NlFxMVdSS3lWQzZtOXRWSjdhRmpVK3pObS82WGZHdmpXbFhSN2hpb0wrV0Jz?=
 =?utf-8?B?RkxMUkJIK0lhc05HOXFTcXFYRUw3b3BEbXNqNVVoZkMrSDhkNmlGQWVxNFZ4?=
 =?utf-8?B?SFJBeEd2SkZOWXc0bXdacktGTU1FOW53dWFHdVpjSCtaZHE1ZmpsNWN3dmxD?=
 =?utf-8?B?YWpNUEg1ZXByS2JYZEtrZEUreVk0R1hEMGtVcDV1cXVlUDZNSC9WREF1dUQ4?=
 =?utf-8?B?QnhPYkgwMVdlQlRaZGRSVU5xOTg4Z3MvOUVrSDRzT1VUMml3ck5LajRaWCtT?=
 =?utf-8?B?STJIaGluc3BuYVovNHB4S2JBMzJ6dEdDNE9LK1JRbkJsQWdYam45M1h3d0dJ?=
 =?utf-8?B?WEVNMytwLytHZC9wRnJ2cVIvUEsyNWhwUWkwUXJ2THlnN0w1dDZvTU5vOGpv?=
 =?utf-8?B?cmxzZEJQZWpqeVlBbDN4anplZ1FZV1pRSFhrL0Q5S21oOEIrQXBYWitlZ3A5?=
 =?utf-8?B?bmJERE5XU2h1UnJ0aUdPbUFzOStPNU42dmUzdEllN2RQN1NJWDRPKzJ5amJo?=
 =?utf-8?B?N2NWMGJ0SGxXczUxRlh5MlVpUVlLR1BacWxuTVNhdjJQMVcxaWtqa2NNRkdp?=
 =?utf-8?B?V0k2NEhuSVJ4TnhOTGw1WDk1QS9yVU1ObjdIaERNdS9vNFpIeWxXbHQwZUFK?=
 =?utf-8?B?TG9nMW5USVR1NTFKR0NRNjlLbC81R3Rab2pYaGFzUEJRWGpzUmZDWjBEcWJy?=
 =?utf-8?B?Y2l6UXF6bXVIUDQ5Mnl3eDRmM1FtY1QvWWEwSFlIRCtBWDdnbmxxbU5rNkJX?=
 =?utf-8?B?cktkME8vQlF1RWhXZnBoa3lYMzU1eEQyd0Q3SlBWWWIzbEdIbG1VMjBoTlkr?=
 =?utf-8?B?eVp4THJwb0J2dSt5VGE3aEFmRFBaYUlvVjcyYjZET0h6RlBqeEJPdDl0aytR?=
 =?utf-8?B?S1RxdXR6U1FReEwyRm1Ma21KRXdqTVN6cW1ZTy9BeTlDVUZKMjRBQ3RQeEtB?=
 =?utf-8?B?WklXWWtBM29sbDU4L1VmNTZRNkZnOXI5eDRma2FTUHRDdTZiVGh3QmFuZUhZ?=
 =?utf-8?B?RzBabU1LblZJQjBYb2E0d3FySE5JUytNdUdFVSs4UDBBd1ZCYXdDbDNzckMr?=
 =?utf-8?B?aXRqczA5U0JuWTliS2FxZnhlYkJNTkZ3dkJkVnU0SXVnNVQ3S0VlcE8rWlNO?=
 =?utf-8?B?YU9qRWducUFiT0hQZS9aQlp4Nk82b1h1RUlJWExJV1pEcjRVZFdZc1ZHTnBw?=
 =?utf-8?B?VzFYdk1sNXJwWVZlQnArRi9ERmtXbmFxRHJVTDE2VkxBd2hxQVJoaktqcm9O?=
 =?utf-8?B?RDhzTjVhSmFTNU1rY2JONTZkSldvc0NQWkFvVFZrUEZ6dnZvV3lUdz09?=
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
X-Exchange-RoutingPolicyChecked: eAFYAfoRoryo0dSFLM6ZDMecOcgqwBN1EGvAw1Bmj+7uEhtgWaWRzgHHO7beSNP3JLnRjG8mk29w96dJYwCi48MN5sjXZjpbWEtMHio5zPTgprtUe695OdxcsAtsBm2/mujENVPS4MFy/16pqrh5s5UjWOev7AiYeGL4LOBUyOMfm2vscanIGAPt3St/Yx5T7Bqmccc9P/8D/vTP17sy1/gocV+bKIWbQrLm5oxYgRMM1l8heFguKSJwQAJCSIv3QkgWT89ZsLDULdnEKgk8wIXLNk9qkdUQ7nP7SNwOBWc7feXNYGzPSSNSi2n+7bWSn/RncGc+rgU5gW+7JzBn6A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69154114F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafa7923-ee58-46fb-db24-08df38cf218c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:50:38.1871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/mf8GlG2Qvtfmh5WMKPuPxurjT6LRc9CScJ5BrZSG1v9nzFMYt0UAj3moCuYYy8McmR7cgiCK/FI2BY3DU4IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC1nZnggPGludGVsLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEltcmUgRGVhaw0K
PiBTZW50OiBUaHVyc2RheSwgMjkgT2N0b2JlciAyMDI2IDEzLjMwDQo+IFRvOiBpbnRlbC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBpbnRlbC14ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIDMvNl0gZHJtL2k5
MTUvcHBzOiBSZXNldCBQUFMgc3RhdGUgYWZ0ZXIgVHlwZUMgcG9ydCBpbml0IG9uIHJlc3VtZQ0K
PiANCj4gUmVzZXR0aW5nIHRoZSBQUFMgc3RhdGUgaW52b2x2ZXMgYWNxdWlyaW5nIGFuIEFVWCBw
b3dlciBkb21haW4NCj4gcmVmZXJlbmNlLiBPbiBUeXBlQyBwb3J0cywgdGhlIEFVWCBwb3dlciBk
b21haW4gZGVwZW5kcyBvbiB0aGUgVHlwZUMNCj4gbW9kZSBvZiB0aGUgcG9ydCB1c2luZyB0aGUg
UFBTLg0KPiANCj4gQW4gdXBjb21pbmcgY2hhbmdlIHdpbGwgc2V0IHRoZSBwb3J0L1BIWSB0eXBl
IHRvIFR5cGVDIGZvciBlRFAgcG9ydHMgb24NCj4gUFRMKyBwbGF0Zm9ybXMgd2l0aCBhbiBlRFAg
RERJIG1hcHBlZCB0byBhIFR5cGVDIFBIWS4gUHJlcGFyZSBmb3IgdGhpcyBieQ0KPiByZXNldHRp
bmcgdGhlIFBQUyBzdGF0ZSBvbiByZXN1bWUgb25seSBhZnRlciBpbml0aWFsaXppbmcgdGhlIHBv
cnQncw0KPiBUeXBlQyBtb2RlLg0KPiANCj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA2
LjE0Kw0KPiBTaWduZWQtb2ZmLWJ5OiBJbXJlIERlYWsgPGltcmUuZGVha0BpbnRlbC5jb20+DQoN
ClJldmlld2VkLWJ5OiBNaWthIEthaG9sYSA8bWlrYS5rYWhvbGFAaW50ZWwuY29tPg0KDQo+IC0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kZGkuYyB8IDQgKystLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RkaS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kZGkuYw0KPiBpbmRleCBhNDZhYjVk
M2Q3MGZjLi5kZGE5NTcwOWM3YzczIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkx
NS9kaXNwbGF5L2ludGVsX2RkaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfZGRpLmMNCj4gQEAgLTQ3MjMsMTAgKzQ3MjMsMTAgQEAgc3RhdGljIHZvaWQgaW50
ZWxfZGRpX2VuY29kZXJfcmVzZXQoc3RydWN0IGRybV9lbmNvZGVyICplbmNvZGVyKQ0KPiAgCWlu
dGVsX2RwLT5yZXNldF9saW5rX3BhcmFtcyA9IHRydWU7DQo+ICAJaW50ZWxfZHBfaW52YWxpZGF0
ZV9zb3VyY2Vfb3VpKGludGVsX2RwKTsNCj4gDQo+IC0JaW50ZWxfcHBzX2VuY29kZXJfcmVzZXQo
aW50ZWxfZHApOw0KPiAtDQo+ICAJaWYgKGludGVsX2VuY29kZXJfaXNfdGMoJmRpZ19wb3J0LT5i
YXNlKSkNCj4gIAkJaW50ZWxfdGNfcG9ydF9pbml0X21vZGUoZGlnX3BvcnQpOw0KPiArDQo+ICsJ
aW50ZWxfcHBzX2VuY29kZXJfcmVzZXQoaW50ZWxfZHApOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBp
bnQgaW50ZWxfZGRpX2VuY29kZXJfbGF0ZV9yZWdpc3RlcihzdHJ1Y3QgZHJtX2VuY29kZXIgKl9l
bmNvZGVyKQ0KPiAtLQ0KPiAyLjQ5LjENCg0K
