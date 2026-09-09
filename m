Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E63B52E1
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941917; cv=fail; b=MWljmewWW5N3VCUQjUeAffPofpYmEIm0kRtVqyui1+HXITvzANtoDRAQ5W02SmGQTbunmtRBDTJ1SoEyHgJe4Ut4Z4qgW3aRcdQJTEY6qkXXAbU6f/uN2IFCHcp7O0+OYt5kl0W0BGtwECjv/zMEtDG7E/Zl4I7iPZM2UiDlkYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941917; c=relaxed/simple;
	bh=Y5b3YlwZQ08v2y6c7rKjU/uufRWYtt8+SmX5zldL6rU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Obo/s8grPs/pkygNJwPji9ukJIVq3jMjll1MZCChokewU/eaXc0+xhckJoN5xl9moaSlceLFoYhs2JFpv3AHT+YEscU3qQ4LB0Nz17pYuOpfoiCfkywTOni7bcj7iRAu/SkdVsKNBBpjr5Avk6ZYEprCfDsEipDlpbKK39xU828=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwcKaRFL; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwcKaRFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788941915; x=1820477915;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y5b3YlwZQ08v2y6c7rKjU/uufRWYtt8+SmX5zldL6rU=;
  b=kwcKaRFLbQuf+KDPYEmMAXPsCQaLRX3m0qRPlZEvcs/s/3EEbJ890qzl
   Dlk0W78ypLGl0UZbe1xDaeZvGOIR+M8JG9qr9mu7Aa+Dwnsuu+bCmE7/a
   Tc3GclK1cFluAHoeUYgoKoDl8VLjMn5eutKTRAjMKZ0AC4L/jsOeRdSIL
   fyrr+VxcNk/Ef8n2hMwfSt7MoQ6e9oylWCa8svffFrDRWghDfv0lVlpxK
   i6rsQPMpqFI2J2IB4Bm8LwyhK98SkAgiNxXZ7FTDwGW9USTkgvTnLXo59
   1HM4y/YWGUbJG/IHWUE1dqwOhazsoLOe+2LRk96F9njWBHa2TUEcA19X2
   A==;
X-CSE-ConnectionGUID: xChT6IEwQxOYYKdpgu5A+g==
X-CSE-MsgGUID: SO1AMn9WTLqZ/tFy3NqBUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100714907"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="100714907"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:18:34 -0700
X-CSE-ConnectionGUID: OJH6py/SSZG2A/LQplqnJQ==
X-CSE-MsgGUID: i1Wrqc0lSHWl7dLXHHy/KQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:18:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 01:18:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 01:18:33 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 01:18:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+a6J00ci6aCI3xVbajdiJRC2hFHXvxEwK3samtK6Pp9Xx6fSL833eQqubHo8/gUo1FcsBPwAKgtZjx7nKI5+LcF8BCvlcgkRqy+BlrtSKSUt8YLvGPzXxQljIWpuYeGE4JG5LFUU94xv56UCR7keQSnVXQycAgnnPWtDbqNPe/phuv6FoK4WtXyuWUtyL8rNT0o9LYak9NQKXuSA7I4cmQPKWxUBHsU39csOQSCHz9c8YeQCqgOPtnm8S0O57ldf11ibCH6SK/H5PGs69bxFYozNA9sHHPabbYGDIf4amgd0N3X8AvjcCXooMaA5Qlir15fKW11QnBIlHgTtNVEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5b3YlwZQ08v2y6c7rKjU/uufRWYtt8+SmX5zldL6rU=;
 b=q1dF5UZfVJ1v5rWb/9MiQCt0MAUI4QCMVV9PJ2+Kez+m6nc2Gxo6BP4r0vADrna30sSNvmJvJy7jZtGASxUZ5HeCxJDPiWd3oSinQ1XsBJcGE/Wkghjv5Zpr1UuXRtPkveUDZUsSArDNIRzxZfGUsCIH/c1TDqXQgl441xDezHeGlajizzS1VfNK3fyzLeARzUdHEZxRey8iPfUGST6zUTT34QhyfWDqiUlbRRnCwXK+lYhspJHr3/4Gy4yWgjVxU+jAZ9ru8+O5FS1mokCso13Lju4jWAH/GSQaRXTYzVnq1MHGrUp/4z/1lsveDL01hg4fM3YiQwVBET2uS1apyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 DS4PR11MB616614.namprd11.prod.outlook.com (2603:10b6:8:53e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Wed, 9 Sep 2026 08:18:27 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 08:18:26 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Garg,
 Nemesa" <nemesa.garg@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] Revert "drm/i915/display: Clear SEL_FETCH_PLANE_CTL
 on plane disable"
Thread-Topic: [PATCH 1/2] Revert "drm/i915/display: Clear SEL_FETCH_PLANE_CTL
 on plane disable"
Thread-Index: AQHdQCRwjCFDA/CJa0Oq8Z9r3YVbMbbF50mA
Date: Wed, 9 Sep 2026 08:18:26 +0000
Message-ID: <74a8c3ef82ccd1d8c7c9463af9c84229e53205ec.camel@intel.com>
References: <20260909062523.3516962-1-nemesa.garg@intel.com>
	 <20260909062523.3516962-2-nemesa.garg@intel.com>
In-Reply-To: <20260909062523.3516962-2-nemesa.garg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|DS4PR11MB616614:EE_
x-ms-office365-filtering-correlation-id: 02bc7cac-328d-4ac3-cc1c-08df0e4aec74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|56012099006|11063799006|5023799004|38070700021|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: oLd7JM4Fck60lPkrdDvzJbmr0oTffgbpyw22/UEpZ0eQTSbUhTb2uXsY9i/or7MCWuGUu40U6EKCYN49wKGG20mvCdjA+0ZFjTL5SXH1UyTeGMWody9lDoQITnaH9fSCqnqWsffqZ7xynFlmC3HdTICdrITwk3XtsM8uTm6BQPOjhmDT+exq2HUQub31MudKI0YdIrUxD98tqT5m3lRmLwWNvpeDvZ5vQ7MrRVc+d9SA/rmbxWgIS8CwqEz9G7f+CetZvH28S8v41uvNLzMDBDe3boaCkhOgBXuwcGmZHZaOVQFVrxUijrmWkHssWrey58pfhowYfSJmlhDTndSid3xZzpCZRMfpRWK1uod4TWGuauk6A8kd3Ftxw5gd/tBGWG+toY/hqpXKpH1q32R3UanUg8ANeggy8KVRfAN1ovPvFy0H5bu7F5mQFrpKBGn5Urhysuoh5V7y98Bo8xa6RS1v1d4+C4+IAt9h4NzQkBjbqblJ18AuBHO6knEgaiIFol+mgkJ4h/yAtokUmqNhOyKSs74p+4bqCX64oOcHGA4KbqUU7/6yxd30kCjPN8lRVHtAzS3HqAgMLn8H0WucMz5DGk4hcv2KRDZGNgboTySNbHQNWQsAAmUlOP1+7YT2aeV+gAPSSGmI0Mx7Lr4fuYNPgcBEuraN1XhrLtQH36Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6019.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(5023799004)(38070700021)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1hMREgydDlhL3k2WEduaDlLSXpSQ1QwdmUxNU41dys5ZjJiWkhzcnFjWTNO?=
 =?utf-8?B?VE9MTFNFTE4xdGVJRXZFT2lRcWxRRUNPTjc1MkdpZCtpY09SRHhzUU95RDVj?=
 =?utf-8?B?YURHZmpuVTBmZW1EMXZqQ0g2VEl0dnNpV2JXM1VkZC9VSGlueXpWSGEvcjJo?=
 =?utf-8?B?ZVd6dVRUZG16aEtrSy95WVIrS0QvWnlKcTJUUGVMaWI3ejFpTWpxejNhbzli?=
 =?utf-8?B?TWdzZ1Y1YUZhK0JWK0ozRjZnWTZLbmtLTVM3VE9VcG9ZVjlpVVU4dStwdHE0?=
 =?utf-8?B?QWlmLytralZuYlZpNGsrbk1xVjcyV1hzZlNwbENXK0NyMm5sczBIRklJaWdF?=
 =?utf-8?B?Y28xd1cwQmgvMWoxbVd0NTAwQitobWRmLzBtSlRFSU1McjNCajlMRjJrZnox?=
 =?utf-8?B?czQrcURpS21Zbk9zUkZLWXNGakFpTEQ0MzMwNG45M2ZMckdBQXBiRGw3eTBq?=
 =?utf-8?B?UFZYeGt0aXoxT1YvenRTeG82ZWc4YWVTUGRERmRLdXFnQkVTVEFSeE04Qmdt?=
 =?utf-8?B?VkJybVdJU0F0N1ZIeEJoY24wQkp0STFUYjRtcjBvbnhFaG92NFdVN01vOGsy?=
 =?utf-8?B?T3gveitUS0RuZHRBY2VxcjlxRFRXM3VhUHVJVEpNQ3RHdXdqYi85U3l1dHZN?=
 =?utf-8?B?Z0c3bGJScDNiUlp3RFh5MEU1QkkxYm1BNXBxRUZGR1BJQlJxSVlBTmlCODBj?=
 =?utf-8?B?VUZKZ2tMY1VzaUhOVVNNT3p5TUxqS0NDUXZYNUdSOE9EcGlmWGNMNjQ1YUZ2?=
 =?utf-8?B?MmdHRTUvd2JLL0MzYWRkdDU5TlpjMFRQRXE0ckJ0UGRtWDYwWC84N0FxS0JK?=
 =?utf-8?B?a1IrbXRwUW1zM1MvTS80dmZpRG1nbTZISnRHNy9hUzJoSFdiemk2emVLTWov?=
 =?utf-8?B?VzZtUEIyUXNJcThFa3VFY1IrcGZ1ck0xZ2dqZU9hQytRV1djVkRRcVNvZmpn?=
 =?utf-8?B?VnFFdjh0d1ZZbGJneFZkck5SbWU1Vk03WHpHWVp2T1p1dzZzTEplRHU3S0l1?=
 =?utf-8?B?Nno1L0k4NjE5TnVqUW8zOWl2VXJyUUhFZzk1VURRZnlRdW5DTTl4RmZTcGxP?=
 =?utf-8?B?em5FcUxaRm0wWXFRL2JaWTZKZGZQUkplY3pvUDE3SmNBQVJpSWdVR3RxTGIy?=
 =?utf-8?B?aWpjaHdOeUd6MUU0ZUFQNUZpaDNRazZ1bjNZOVQ1NEV2TmZOMENGNnVGZStN?=
 =?utf-8?B?c2dvN2VFMkNzSm1sVGNWU0pVTW9ZZHV1Z092ZGlhbWdOaTBiV1hzdEZKN0c2?=
 =?utf-8?B?RjdtTkZHOHdzcndMMTk5UjdkVUJXdUZmWjJYSXJFamFGUzBEc0JBWTNvTUN1?=
 =?utf-8?B?UGtZbXo2NFVSMGlkRE42WXRvcnBkMUx2cHBwSk4yRUxwMVltMWtSWVg4Sm5Q?=
 =?utf-8?B?czhoazNIT3JTclZ2NmZ3Mm0xWkEvN3Vid2x3eElLdG1peFlzNkg2Mmo1azNh?=
 =?utf-8?B?VjZQRXNlOEtKdEp2djVjZFlqd2xYYU9kaGh1b01uTEFmakJOZ0RUSDFBTU5l?=
 =?utf-8?B?bmFOOXh2STdFTUZVTlU3Q2gwdmNmRzI2cngyUFovK21Bc2VsZ1l5Ri96RC9u?=
 =?utf-8?B?US9OZmJPalFQRkJCa2Q3QU91aFQ1VGJGYkgrbEI0WE5Gem9Fb2owc081M0lu?=
 =?utf-8?B?b3FMa25mWGIzMnRER3U0bmlvc05WWFJ3VzBhdE5EeTl4VTdDMnk1aGszMWc0?=
 =?utf-8?B?Uk5PbmcwcEdIMzNFVWR5eHU3K2dzMCtBcW1aTk43bmJBdTcwd25OOEFLZDZO?=
 =?utf-8?B?c0thVUVIRE5ScDRSSUw5NTZTZUpjeWN6K0RxL1BXcEt0Rk5JdXFWUzdJbWhG?=
 =?utf-8?B?K1hTUUdYK1E5cFM3Yk9TL0tYVFlCbDhIUW5VeWdlZmMzN2cxbUdQMkxqL0hu?=
 =?utf-8?B?VzdQQ2NQWDQ4TEtabng5YnJxa2dWTHZ0Y1NuaEpqODdWSlc2UG1wMHZlOEVK?=
 =?utf-8?B?cjYrbDZQT1FGTE0zWE01ZkdZUU9IQ2ZtMVVKS1JMM3dXdngxaDZjb0NHZDhM?=
 =?utf-8?B?djV1Sk5Jb1o2Yis5c0kxdEJmekNWQXJkTXpmeEZ4cWFMdkRtUml3ZFBUL1dJ?=
 =?utf-8?B?Y3lXRlM5WTc0TnRoVmpQYklMc1JaVXlBand4a2grSUdOMUlJSGpBTDBOSTJ3?=
 =?utf-8?B?U1NmbG9EMG44WE1wK3dKUFFpckEydERVdURhcUVNU3ZPdjZTR2ZlTnJ3OUlE?=
 =?utf-8?B?bEFqbm5sMzBMbit1cEFtZ2wrN2VweWNSVFBlNWg1bktaM2xoT0YxaDdkWTY1?=
 =?utf-8?B?ZmhJS2lXZXpGbmM0cXN5M3cvQnZqNS9XalBqSWpJUjFoMWZ4RmJobGF3TXFG?=
 =?utf-8?B?NnpCSWhEL1FCaFV3azU2S1EyanlteXdUREgxangyZXA3RXVpVVVHKzJyUHRM?=
 =?utf-8?Q?y6PsjEWgqIPUnHX8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD40CF8234FF61458B64DCECBBD89E22@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HLU7GQhBHCKkQgtkOZEIrrPmzswFdiEDCUbnYXdA74BWqd4V/ZePQQ+an6XxcDqbXh2t6SkyYUBeMxnsuklBS7dLO6rQ7RUvKSCtLo8Q81SUHab7tbxafACuUA+xHW/Eppg+uUHSbpgJMRuUQ7mVibfyxEqTGmplnQHAsGbMcRT9Uqh3+mkRazIJviT5foE49LckJBf3txyjXYfbUfPgnCkv1aLawIrbhTEUGXxulK+4j74SKd9M73IjaBbBsENRN51Gj4UZ7+jDwCFeIeXgQlLDKIdah3oQKYDhD+XqbUYm2UTn/yZQRqNWSPTCsNAfaRDJXOSLyKDT8bPAlL0FKg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bc7cac-328d-4ac3-cc1c-08df0e4aec74
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 08:18:26.6227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brHtpi5nU0VxoZIGiPLhUq0XlIw0N/vqGDPQa8GV3RFwUmE/sbMK6Oj5tSMeJV4V8JRgLGLGyelpeo9E0KTf6RiXndYx7HWwSWBvzKNrQKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB616614
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTA5IGF0IDExOjU1ICswNTMwLCBOZW1lc2EgR2FyZyB3cm90ZToNCj4g
VGhpcyByZXZlcnRzIGNvbW1pdCA3ZjExNzJhMmFjMGQ3ZTUwODUwNzg1ZTJlNjU3ODljOGFhYzg0
MTFhLg0KPiANCj4gVGhpcyBjb21taXQgcmVwbGFjZWQgdGhlIGNydGNfc3RhdGUtPmVuYWJsZV9w
c3IyX3NlbF9mZXRjaCBndWFyZCBpbg0KPiBpY2xfcGxhbmVfZGlzYWJsZV9zZWxfZmV0Y2hfYXJt
KCkgYW5kDQo+IGk5eHhfY3Vyc29yX2Rpc2FibGVfc2VsX2ZldGNoX2FybSgpDQo+IHdpdGggSEFT
X1BTUjJfU0VMX0ZFVENIKCkuIFRoaXMgaXMgYSBkaXNwbGF5IHZlcnNpb24gY2hlY2sgYW5kDQo+
IHNheXMgbm90aGluZyBhYm91dCB0aGUgcGlwZSwgc28gZXZlcnkgcGxhbmUgYW5kIGN1cnNvciBk
aXNhYmxlIG9uIGENCj4gZGlzcGxheSAxMisgcGxhdGZvcm0gc3RhcnRlZCB3cml0aW5nIFNFTF9G
RVRDSF9QTEFORV9DVEwoKSAvDQo+IFNFTF9GRVRDSF9DVVJfQ1RMKCksIGluY2x1ZGluZyBvbiBw
aXBlcyB0aGF0IGRvIG5vdCBpbXBsZW1lbnQgdGhlbS4NCj4gSXQgc2hvd3MgdXAgYXMgYW4gdW5j
bGFpbWVkIHJlZ2lzdGVyIGFjY2VzcyBvbiBwaXBlcyBkcml2aW5nIEhETUkNCj4gd2hlcmUNCj4g
c2VsZWN0aXZlIGZldGNoIHdhcyBuZXZlciBlbmFibGVkLg0KPiANCj4gVGhlIHN0YWxlIHNlbGVj
dGl2ZSBmZXRjaCBlbmFibGUgYml0IHRoYXQgY29tbWl0IGFkZHJlc3NlZCBpcyBoYW5kbGVkDQo+
IGluIHRoZSBuZXh0IHBhdGNoLg0KPiANCj4gRml4ZXM6IDdmMTE3MmEyYWMwZCAoImRybS9pOTE1
L2Rpc3BsYXk6IENsZWFyIFNFTF9GRVRDSF9QTEFORV9DVEwgb24NCj4gcGxhbmUgZGlzYWJsZSIp
DQo+IENsb3NlczoNCj4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9pOTE1L2tl
cm5lbC8tL3dvcmtfaXRlbXMvMTY4NzYNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U2lnbmVkLW9mZi1ieTogTmVtZXNhIEdhcmcgPG5lbWVzYS5nYXJnQGludGVsLmNvbT4NCg0KUmV2
aWV3ZWQtYnk6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KDQo+
IC0tLQ0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfY3Vyc29yLmPCoMKg
wqDCoMKgwqAgfCAxNSArKysrKy0tLS0tLS0tDQo+IC0tDQo+IMKgLi4uL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L3NrbF91bml2ZXJzYWxfcGxhbmUuY8KgwqDCoCB8IDE1ICsrKysrLS0tLS0tLS0NCj4g
LS0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxf
Y3Vyc29yLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2N1cnNvci5j
DQo+IGluZGV4IGNjZTA0MWUxZGE1MS4uOTAxNzMwNDBkODI1IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2N1cnNvci5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfY3Vyc29yLmMNCj4gQEAgLTUzMSwxOCArNTMxLDEz
IEBAIHN0YXRpYyBpbnQgaTl4eF9jaGVja19jdXJzb3Ioc3RydWN0DQo+IGludGVsX2NydGNfc3Rh
dGUgKmNydGNfc3RhdGUsDQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRpYyB2b2lkIGk5eHhfY3Vyc29y
X2Rpc2FibGVfc2VsX2ZldGNoX2FybShzdHJ1Y3QgaW50ZWxfZHNiICpkc2IsDQo+IC0JCQkJCcKg
wqDCoMKgwqAgc3RydWN0IGludGVsX3BsYW5lDQo+ICpwbGFuZSkNCj4gKwkJCQkJwqDCoMKgwqDC
oCBzdHJ1Y3QgaW50ZWxfcGxhbmUNCj4gKnBsYW5lLA0KPiArCQkJCQnCoMKgwqDCoMKgIGNvbnN0
IHN0cnVjdA0KPiBpbnRlbF9jcnRjX3N0YXRlICpjcnRjX3N0YXRlKQ0KPiDCoHsNCj4gwqAJc3Ry
dWN0IGludGVsX2Rpc3BsYXkgKmRpc3BsYXkgPSB0b19pbnRlbF9kaXNwbGF5KHBsYW5lKTsNCj4g
wqAJZW51bSBwaXBlIHBpcGUgPSBwbGFuZS0+cGlwZTsNCj4gwqANCj4gLQkvKg0KPiAtCSAqIENs
ZWFyIHRoaXMgd2hlbmV2ZXIgdGhlIGhhcmR3YXJlIGhhcyBzZWxlY3RpdmUgZmV0Y2gsIG5vdA0K
PiBqdXN0IHdoZW4NCj4gLQkgKiB0aGUgY3VycmVudCBzdGF0ZSB1c2VzIGl0LiBUaGUgY3Vyc29y
IG1heSBoYXZlIGJlZW4NCj4gZW5hYmxlZCB3aXRoDQo+IC0JICogc2VsZWN0aXZlIGZldGNoIGVh
cmxpZXIgYW5kIGhhZCBpdHMgZW5hYmxlIGJpdCBvcnBoYW5lZA0KPiB3aGVuIHRoZQ0KPiAtCSAq
IGZlYXR1cmUgd2FzIHN3aXRjaGVkIG9mZi4NCj4gLQkgKi8NCj4gLQlpZiAoIUhBU19QU1IyX1NF
TF9GRVRDSChkaXNwbGF5KSkNCj4gKwlpZiAoIWNydGNfc3RhdGUtPmVuYWJsZV9wc3IyX3NlbF9m
ZXRjaCkNCj4gwqAJCXJldHVybjsNCj4gwqANCj4gwqAJaW50ZWxfZGVfd3JpdGVfZHNiKGRpc3Bs
YXksIGRzYiwgU0VMX0ZFVENIX0NVUl9DVEwocGlwZSksDQo+IDApOw0KPiBAQCAtNTkyLDcgKzU4
Nyw3IEBAIHN0YXRpYyB2b2lkDQo+IGk5eHhfY3Vyc29yX3VwZGF0ZV9zZWxfZmV0Y2hfYXJtKHN0
cnVjdCBpbnRlbF9kc2IgKmRzYiwNCj4gwqAJCWlmIChjcnRjX3N0YXRlLT5lbmFibGVfcHNyMl9z
dV9yZWdpb25fZXQpDQo+IMKgCQkJd2FfMTYwMjE0NDA4NzMoZHNiLCBwbGFuZSwgY3J0Y19zdGF0
ZSwNCj4gcGxhbmVfc3RhdGUpOw0KPiDCoAkJZWxzZQ0KPiAtCQkJaTl4eF9jdXJzb3JfZGlzYWJs
ZV9zZWxfZmV0Y2hfYXJtKGRzYiwNCj4gcGxhbmUpOw0KPiArCQkJaTl4eF9jdXJzb3JfZGlzYWJs
ZV9zZWxfZmV0Y2hfYXJtKGRzYiwNCj4gcGxhbmUsIGNydGNfc3RhdGUpOw0KPiDCoAl9DQo+IMKg
fQ0KPiDCoA0KPiBAQCAtNzAxLDcgKzY5Niw3IEBAIHN0YXRpYyB2b2lkIGk5eHhfY3Vyc29yX3Vw
ZGF0ZV9hcm0oc3RydWN0DQo+IGludGVsX2RzYiAqZHNiLA0KPiDCoAlpZiAocGxhbmVfc3RhdGUp
DQo+IMKgCQlpOXh4X2N1cnNvcl91cGRhdGVfc2VsX2ZldGNoX2FybShkc2IsIHBsYW5lLA0KPiBj
cnRjX3N0YXRlLCBwbGFuZV9zdGF0ZSk7DQo+IMKgCWVsc2UNCj4gLQkJaTl4eF9jdXJzb3JfZGlz
YWJsZV9zZWxfZmV0Y2hfYXJtKGRzYiwgcGxhbmUpOw0KPiArCQlpOXh4X2N1cnNvcl9kaXNhYmxl
X3NlbF9mZXRjaF9hcm0oZHNiLCBwbGFuZSwNCj4gY3J0Y19zdGF0ZSk7DQo+IMKgDQo+IMKgCWlm
IChwbGFuZS0+Y3Vyc29yLmJhc2UgIT0gYmFzZSB8fA0KPiDCoAnCoMKgwqAgcGxhbmUtPmN1cnNv
ci5zaXplICE9IGZiY19jdGwgfHwNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvc2tsX3VuaXZlcnNhbF9wbGFuZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUv
ZGlzcGxheS9za2xfdW5pdmVyc2FsX3BsYW5lLmMNCj4gaW5kZXggNWNkYTFhYjkwZTQwLi4wN2E2
ODMyOTMzNTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvc2ts
X3VuaXZlcnNhbF9wbGFuZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
c2tsX3VuaXZlcnNhbF9wbGFuZS5jDQo+IEBAIC04NzksMTggKzg3OSwxMyBAQCBza2xfcGxhbmVf
ZGlzYWJsZV9hcm0oc3RydWN0IGludGVsX2RzYiAqZHNiLA0KPiDCoH0NCj4gwqANCj4gwqBzdGF0
aWMgdm9pZCBpY2xfcGxhbmVfZGlzYWJsZV9zZWxfZmV0Y2hfYXJtKHN0cnVjdCBpbnRlbF9kc2Ig
KmRzYiwNCj4gLQkJCQkJwqDCoMKgIHN0cnVjdCBpbnRlbF9wbGFuZQ0KPiAqcGxhbmUpDQo+ICsJ
CQkJCcKgwqDCoCBzdHJ1Y3QgaW50ZWxfcGxhbmUNCj4gKnBsYW5lLA0KPiArCQkJCQnCoMKgwqAg
Y29uc3Qgc3RydWN0DQo+IGludGVsX2NydGNfc3RhdGUgKmNydGNfc3RhdGUpDQo+IMKgew0KPiDC
oAlzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSA9IHRvX2ludGVsX2Rpc3BsYXkocGxhbmUp
Ow0KPiDCoAllbnVtIHBpcGUgcGlwZSA9IHBsYW5lLT5waXBlOw0KPiDCoA0KPiAtCS8qDQo+IC0J
ICogQ2xlYXIgdGhpcyB3aGVuZXZlciB0aGUgaGFyZHdhcmUgaGFzIHNlbGVjdGl2ZSBmZXRjaCwg
bm90DQo+IGp1c3Qgd2hlbg0KPiAtCSAqIHRoZSBjdXJyZW50IHN0YXRlIHVzZXMgaXQuIFRoZSBw
bGFuZSBtYXkgaGF2ZSBiZWVuDQo+IGVuYWJsZWQgd2l0aA0KPiAtCSAqIHNlbGVjdGl2ZSBmZXRj
aCBlYXJsaWVyIGFuZCBoYWQgaXRzIGVuYWJsZSBiaXQgb3JwaGFuZWQNCj4gd2hlbiB0aGUNCj4g
LQkgKiBmZWF0dXJlIHdhcyBzd2l0Y2hlZCBvZmYuDQo+IC0JICovDQo+IC0JaWYgKCFIQVNfUFNS
Ml9TRUxfRkVUQ0goZGlzcGxheSkpDQo+ICsJaWYgKCFjcnRjX3N0YXRlLT5lbmFibGVfcHNyMl9z
ZWxfZmV0Y2gpDQo+IMKgCQlyZXR1cm47DQo+IMKgDQo+IMKgCWludGVsX2RlX3dyaXRlX2RzYihk
aXNwbGF5LCBkc2IsIFNFTF9GRVRDSF9QTEFORV9DVEwocGlwZSwNCj4gcGxhbmUtPmlkKSwgMCk7
DQo+IEBAIC05MjYsNyArOTIxLDcgQEAgaWNsX3BsYW5lX2Rpc2FibGVfYXJtKHN0cnVjdCBpbnRl
bF9kc2IgKmRzYiwNCj4gwqANCj4gwqAJc2tsX3dyaXRlX3BsYW5lX3dtKGRzYiwgcGxhbmUsIGNy
dGNfc3RhdGUpOw0KPiDCoA0KPiAtCWljbF9wbGFuZV9kaXNhYmxlX3NlbF9mZXRjaF9hcm0oZHNi
LCBwbGFuZSk7DQo+ICsJaWNsX3BsYW5lX2Rpc2FibGVfc2VsX2ZldGNoX2FybShkc2IsIHBsYW5l
LCBjcnRjX3N0YXRlKTsNCj4gwqANCj4gwqAJaWYgKHBsYW5lX2hhc19ub3JtYWxpemVyKHBsYW5l
KSkNCj4gwqAJCWludGVsX2RlX3dyaXRlX2RzYihkaXNwbGF5LCBkc2IsDQo+IEBAIC0xNjQ2LDcg
KzE2NDEsNyBAQCBzdGF0aWMgdm9pZA0KPiBpY2xfcGxhbmVfdXBkYXRlX3NlbF9mZXRjaF9hcm0o
c3RydWN0IGludGVsX2RzYiAqZHNiLA0KPiDCoAkJaW50ZWxfZGVfd3JpdGVfZHNiKGRpc3BsYXks
IGRzYiwNCj4gU0VMX0ZFVENIX1BMQU5FX0NUTChwaXBlLCBwbGFuZS0+aWQpLA0KPiDCoAkJCQnC
oMKgIFNFTF9GRVRDSF9QTEFORV9DVExfRU5BQkxFKTsNCj4gwqAJZWxzZQ0KPiAtCQlpY2xfcGxh
bmVfZGlzYWJsZV9zZWxfZmV0Y2hfYXJtKGRzYiwgcGxhbmUpOw0KPiArCQlpY2xfcGxhbmVfZGlz
YWJsZV9zZWxfZmV0Y2hfYXJtKGRzYiwgcGxhbmUsDQo+IGNydGNfc3RhdGUpOw0KPiDCoH0NCj4g
wqANCj4gwqBzdGF0aWMgdm9pZA0KDQo=
