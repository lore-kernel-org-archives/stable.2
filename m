Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2569350A05;
	Mon, 24 Aug 2026 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609765; cv=fail; b=fOPfEEXe20QGkmCaydSO+ZJuOiCPrlyWytLvbv03RUbcrUz9qqTt2YDjjuootl1shzUfk++1VLvJ4eFS+PTjg+UoFiDbZZbHr+b0y03lHIYvyvYNWf1AWTM7yqEIZmlYRcUySx5/GoIi7wVQU/R9y28oEaDKNG9Guz7ddLvMxX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609765; c=relaxed/simple;
	bh=Kltz1RMAKH12h/Flm5O4EgihpKGltQwkzbsYcbqYh0s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AzgYlCIxjTGVJEAQabdrhWcXfvtqNShJlHr5UCnJZZfbSvu4clSWKTdcNeEeiWnrfEg8aALuorlRSxkQIcP9suop08AsWHIhHWz+bSNPas2mhuJYLH+ACu3eG7nszENYjTAJ0eUHf36/qOsdY6v2vRZl4YjThVp0OoIl6SwcqJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kg9VcEps; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kg9VcEps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787609763; x=1819145763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kltz1RMAKH12h/Flm5O4EgihpKGltQwkzbsYcbqYh0s=;
  b=kg9VcEpsm6I00IxID4BIYiyeyeogf36aqZc+6nBhBooI9q3ys6HK8dyc
   utAsiwZe4alJjt1cs9a5HOZEbsaqSkORd5bTgOhmjn8EOwo6CV+DRnlg+
   jHzpsuVrCEsmBLim4dn8lbtDQ0Jc0T1o9s1L4yeo9d4PRbJNhgUshFrj7
   AO2NoNyK1B482i7rqdQ7v2/aTVY45cACqiUYAAfYt5oFMF5Gud1kwRsj6
   qH+4/WHSZNveRjzlJn/GJG4lvklZNyA1yNS+K61OHS2iRKgNTSkHDtRj1
   gAJpjZ4ZL433lGEOxSQj/EAXTmPTDO/jlAKV6vCDryqaDnXo3XUr2Okr7
   w==;
X-CSE-ConnectionGUID: 5b0b+cGpRiSD+JK1GhsIIQ==
X-CSE-MsgGUID: Zv2YOUGoRoK8r83FYjKzyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87946355"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="87946355"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 15:16:02 -0700
X-CSE-ConnectionGUID: 3CI9N47+Ri27CMqvf2lnpA==
X-CSE-MsgGUID: /wCAxjyNSJG4LZdQEJVCLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="264494614"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 15:16:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 15:16:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 15:16:01 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 15:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzv6paHqnulpzhe9y5xXl9tDMDO62FwEFhv0x2fLGXdSHWkOiAjnlMEE6w5tNs9GJb2LDOTak8wMqrrExNoFsIKLgNEI+uQ8eZl6mMMeeHNJ+M1QzVxugVwZPgE1G5lUGqwOmkeLLz+1FkUvS/GN9a2V7ez3JS/9El/7OW3aJy0tNpUOdFSchyLssANaRN9N/GsuVOSrtESW3fEFcDsW9KEFXu6QxyPYykeftvCNZNWuf5pJtgPL+HPU7u0eAp/XuFIZzRAkliXHHd79OXMPTJuEViRPIWYEHE/lONOC+G6be7YESTo9K7kOXhmsAPaq49MA+Ud/2+kaVSu74Z5n9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kltz1RMAKH12h/Flm5O4EgihpKGltQwkzbsYcbqYh0s=;
 b=IheUXZs9e9ubPeXaZlnWdqah2UcRivs2QxG9/I89uNoXtloq2y/1gIvf3NS0RWWaFfuHfxX8RtRbByE0B66M2A6cINXzS+2ItCjKoCRwz4I7FN9kY/POhj73tH4TL+JMuO4aR2bJp0QOqOEK/o3Sgn9dLJPxbGhxsIkcQI6QA/Gk11ij//CiGYgivoZnvRF1WlShI4457ieVaXTjk7vT58k0NSYjULRIIPVd6W66Vbg2IRLXuttiKYczldXtr+GaGalnenPfdGC10vmI2/4YdnV7hV17Q57yCQTLZp2E5g+0sMPwOUZ1HqV2qrZJdmLEgJ7k3vi/r7TxmqWVk0Cm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18)
 by DS0PR11MB8184.namprd11.prod.outlook.com (2603:10b6:8:160::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:15:58 +0000
Received: from CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c]) by CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 22:15:58 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "nicoyip.dev@gmail.com"
	<nicoyip.dev@gmail.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86/mmu: Protect noncoherent DMA zaps with SRCU
Thread-Topic: [PATCH] KVM: x86/mmu: Protect noncoherent DMA zaps with SRCU
Thread-Index: AQHdMmjapMAXKduoRUK1jQB0aFBoqratfQkAgAA/TQCAAAOxgIAAB2qA
Date: Mon, 24 Aug 2026 22:15:58 +0000
Message-ID: <78e381a95f36b5a9325b1742b8f013e62709fcd5.camel@intel.com>
References: <20260822190224.3788887-1-nicoyip.dev@gmail.com>
	 <aoyEMBz-SYLigbGp@google.com>
	 <303eb59af516335e288647c19254928f89fa833a.camel@intel.com>
	 <aoy8Y19RV_Dgm7Te@google.com>
In-Reply-To: <aoy8Y19RV_Dgm7Te@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5300:EE_|DS0PR11MB8184:EE_
x-ms-office365-filtering-correlation-id: 19edba78-e750-4141-9b59-08df022d4655
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: QWEfUHskdldYUQ7qJcwseSMB/deOBq3GhxE/sOMV204uwEPJNE3+KaSV9XYFEN7cWnM8uElPZKeoo9swKP7X8LXu4JjyD3tOMnn9DcE+20fbqt/lh0aOJsnK5K98/AuXovt2ZFOxnBBcTDOL0ARRT1I/huuKA7jMwW8ySojKv+g/FdN6bFclOU3UD3NpSVSx5uwLYxSNJK+0t0qsavOgL1vdhy+ralGXYdNiYgPAlR43nbHj8/m8QrZ2RU2YSB1eTF9FBf2mT6ON4tCk2BxOgXXubBmGcAid1cTzmJDgGH6rd/n60BVf0ha6ELfg/Vfxpt/29rBQD7lAb5gRVJTKceMUbIaFqso7f2RSfKtB0Kf3sn8Okkn3LhEM4sEvxw40zSXo7B3cxGkqpLy5JjROQ2EusMDXbD52AGQge7BoRoaXVTXHa5nFFzVLcOlTrQT787VCYgetkHCGH3QqSmG6K9rJuzO4NxSgdXgePh4f1o/1qOuh6z/RpKcnWmvP+QmHIzd4jSB1uBVOGXqePxg61jjumiCEoo4pc8dVm3SpqFMu/HcEHIS6F2b39V788dDS1gZNA47MlZ88pL0CovJQoi5pcCXRURX/oYMrhT9BYTrVwn9obXF0Acqr/QdXFnPiVe0W03oaKvEUsxWMUkzHJAkLdiB4LpcV22QAlfxDjLnA4QnXcUro24SVU0GD7Mh7ctP/BYz/G9sbXvz6v/727kIk+Y+PxV00nOJQpTJiUVc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5300.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVdKVlo1cUlYdWFyTGd4WWxSbkgrMGkvQlpWcjNKeDN4YWNuM2NiUXk3dzNi?=
 =?utf-8?B?MXFqVzUwRURUZjRaZ1doWjBsTHJZdjlOZlNEQlJwOUVtWVIwejRBd2lGSFFa?=
 =?utf-8?B?R1FLZHFNejczcnN4T3JIWjN5TEF5SlZHSVBHUDF4UGxFdVM0Mm9qdXZ2dCtQ?=
 =?utf-8?B?Q0p6VVdiVWhDWWJUQ1M0N3J1RkR1bkpFSFdmOGlYOFA1L0xoc1lnUW5jUnpF?=
 =?utf-8?B?cloweHZGakhXbTF4TkNsK0Jib3RyZDh3U1UyYU5JOWNZMU4xeDlhMkQwWGFk?=
 =?utf-8?B?TzhtUEp2TE16RHRObEpHcWpBVkZLM21GSlgvWUFjRFRtRjc1RzVJYU9xdDBn?=
 =?utf-8?B?R0ZybW9yNkpuVncvM0xGYXM1RU9tWGYzMXU4dnZFMjFhVjJVQkNVUzhzQlNB?=
 =?utf-8?B?bWhKZ093RTNYclQzZFZsUkFJamRyL1UvZEErSUNpTE8vWTRKTWNjU3lYSGMz?=
 =?utf-8?B?UmZpT1R5OGQ4dG11bUg1aHByMTM4R2lldytWQWdjZzdNR0NEcVIwMy8wRGRH?=
 =?utf-8?B?eGsxRWRNMEppMUk2Z1lNbHhhdHorYlFBZDFBRlNzYndHL1JQMkdpanFNN0R0?=
 =?utf-8?B?YzFxNTZIMDdZZnloWFl2N0dFTTRnY2lWS1d1SUMwcStpeDBZNjF0c2Y2aEpJ?=
 =?utf-8?B?eTdxaTlJMTdYUUVpYWVhV0UvSklWNXJUTjg0R1Y5bTVjZVVEeWxVbWVnenBT?=
 =?utf-8?B?WUxtRlp6YkZjd2cyc2FPTm0ybDF1RzB2a2pjLzFzMXA3Lyt1QVYzUDBLdVpY?=
 =?utf-8?B?WW9MSFVpVmZqaWIyRmxDbnZpVTZsN002SFo4K1pmWTFnMFpKRFp5WFdJeVhK?=
 =?utf-8?B?eThKRVA1UE1nYlRmdUkva3EranpuTy83NmxVRTlNTmRzUk0vVUZvb2trcExo?=
 =?utf-8?B?T3VCaTdtWGN1SEZhbzNEanJYWGg5Z0l2UmRYbktyYmxjbGx4UHk2WGtRbUlt?=
 =?utf-8?B?UG1LbEN2emhpNE9STlF6elE1YXZxQ25MQnFpT2dvcXFoRExibmxlNGwrWXJN?=
 =?utf-8?B?a040NDN5K3UwWWhyUzg4UFZWQkRSb0g3MUdudE9aOVI3QlZEYU1nOGdnT1ZQ?=
 =?utf-8?B?NEE5cnU2WGNsU2JYa1I3Wkt6eldSS2tCYWdzeDkwNkQ0Z3hDNWlBbEtEazZL?=
 =?utf-8?B?SENzLytaZVIycFNvYzhpS1phbnVWSVBOMXBNcFRyRWJjQ0tVWFcwV1kxRlRu?=
 =?utf-8?B?bUVpL1djMVA0RXQvNGtrcWRYREo5bEJMV1duaFFZS09Ueks0T1l6eTZNTzIw?=
 =?utf-8?B?Mk9sVkhIVGJKd0ppM3cwN1h4ZTNtSkViQ2ZMOVYxS0E2S0lKNHlsQ2RvcW4w?=
 =?utf-8?B?MnJJaU5LdGh2SUk3UklMOTkwdmNkUG1kVHRyOVJjNEJobFdsQWJxbGEvYldu?=
 =?utf-8?B?THdQcmVUZDk2aFZ1Yk1VWitXTUhWbGhKZ3lCZCt3RDZHbkJPeTlQK244NHBs?=
 =?utf-8?B?T3ZNZWZCbVlDWjI1cmRXaTRuQVRSUUhhR2U2bC90Mk14dU0xZGo2L013SFFJ?=
 =?utf-8?B?L05YM1lTNjh5TVg2Q2oyVm1zZWp6VGV2VDFoOHJqcDRRcXhMWDNBbFdQS2Fz?=
 =?utf-8?B?cXNUZkcwdmZseGdvcG9hVEIrSStiR2FWcUVjQWE5ZzhoYStQVGNOTGE5bFN1?=
 =?utf-8?B?WXJhQU03SlpFWFM2WjVaUWoxYk9ISDZhcnBwYS9SUDBwT3hMQmNJektnOTZu?=
 =?utf-8?B?WDdpd2RFbjNkZS9yT2sxMWhkYm1SRWpEVWxOU3J6aGZ1TzRObHZEQVN0elhu?=
 =?utf-8?B?NHFuekRjK0hGSTF2ajdQdUFFeXprcHA2L1FuenRBQmJxbFVlSnBsQWhmWS9q?=
 =?utf-8?B?blY5Tm1kTFZLRzR5LzBCUy9MZFcvQndqVDg5Vm9aR1NzREZQQyt0Z2wxYUhz?=
 =?utf-8?B?RUZ0WUFqVlozMXVFQWJLaVkyb0ZMNTNNbnE2OEthMVdaTWhDcXFPdmFoYlVD?=
 =?utf-8?B?ODVKV1ZNK3NLZXN0SE1DbjF4WjZFWUdPR1JVT1phSjFBVE11M0dUNW9jQnJy?=
 =?utf-8?B?MlZ0aFJwRkVJSGNxNXUzTlp1MFcxMjBERzI1RWF5V3U1Mk9jSkUzVExLUVpw?=
 =?utf-8?B?R2JjVkV3dndKRThJS0pwdEVnYkY1SVJMM0tsbG1VbzBKOEN3RVpBZzltck56?=
 =?utf-8?B?alFuOVhPOTFWM1NETUxtdXU3dTMrSlhyWXJETzhPRmh1T0lnSC9ZYnZha0RW?=
 =?utf-8?B?V2I1b0FjbExNR21tRnpiZldwL0lIdE5BOVNrWjZEMmM5RHVlNmNzTkpYR2xR?=
 =?utf-8?B?Nkx0UXppa3ZWT0hFSlh5SDBWejRLckViNUk5NXVLL0dQYzgvQklxdURRODhW?=
 =?utf-8?B?R0dPTEgyOEtKOFJ5T0JHTVhVZXM3Z3hWNk5tK1BNNG9rVzFrVFprdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DECABDA58F8A1E4E8D8EB954DADE3F70@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5l84q9TDnSp1D0NjaMvYqdb9p7k39385CpN3VZvlFWiD66lRDq/u5ViwQHU0iFbb1Z8kXwIHY0YroXp6+zF0WnnPLmADGjig6gYVE+FflSWDL59afhGZ+HUC4T5MYbA607ppa26hdPj3WAHsMiQGN8htd4raCjYlmeikypad5aZILiVuGw268xyVXHNn264Txa004Ifj1dJ+9h7XMrNnjCLaoRBXcyexX3z4hZmu5bHIc4XKoT9ibCVdRP+FVBLhvsKCdyuLT/4KATc9+LvkzPuzDkwM/sQZFAVEUgFhQAapI8vCyxg71lfzN2ObU+FUa+cX1yIcer9Ngh2sKvAQPA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5300.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19edba78-e750-4141-9b59-08df022d4655
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 22:15:58.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNt4RTGX/x7XM9ZmY4/4n4H7X90ODwzMZuO2OvIFgvfJ1bLN72slOMze6/nH6A2YTEnlhFRxIT037aV+9YD6Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8184
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA4LTI0IGF0IDE0OjQ5IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBNb24sIEF1ZyAyNCwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIE1v
biwgMjAyNi0wOC0yNCBhdCAxMDo0OSAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiA+IEFsdGVybmF0aXZlbHksIHdoYXQgaWYgd2UgaGF2ZSBrdm1femFwX2dmbl9yYW5nZSgp
IGFjcXVpcmUgU1JDVT/CoCBOZXN0aW5nICJsb2NrcyINCj4gPiA+IGlzIGEtb2ssIGFuZCB0d28g
b2YgdGhlIHRocmVlIHVzZXJzIG9mIGt2bV96YXBfZ2ZuX3JhbmdlKCkgaGF2ZSBoYWQgdGhpcyBi
dWcgKHNlZQ0KPiA+ID4gY29tbWl0IDA3NGMwMDgwMDcxOSAoIktWTTogeDg2OiBVc2UgU1JDVSB0
byBwcm90ZWN0IHphcCBpbg0KPiA+ID4gX19rdm1fc2V0X29yX2NsZWFyX2FwaWN2X2luaGliaXQo
KSIpLg0KPiA+IA0KPiA+IGt2bV92Y3B1X3NyY3VfcmVhZF9sb2NrKCkgZG9lc24ndCBhbGxvdyBu
ZXN0aW5nIGxvY2sgb2YgS1ZNJ3MgU1JDVS4NCj4gDQo+IE5vLCBrdm1fdmNwdV9zcmN1X3JlYWRf
bG9jaygpIGRvZXNuJ3QgYWxsb3cgbmVzdGVkIHVzYWdlIG9mIGl0c2VsZi4gIENvbW1pdA0KPiAy
MDMxZjI4NzY4OTYgKCJLVk06IEFkZCBoZWxwZXJzIHRvIHdyYXAgdmNwdS0+c3JjdV9pZHggYW5k
IHllbGwgaWYgaXQncyBhYnVzZWQiKQ0KPiBhZGRlZCB0aGUgcHJvdGVjdGlvbiBiZWNhdXNlIHdl
IGhhZCBtdWx0aXBsZSBidWdzIHdoZXJlIEtWTSB3b3VsZCBjbG9iYmVyDQo+IHZjcHUtPnNyY3Vf
aWR4IGFuZCBjYXVzZSBhIGRlYWRsb2NrIGJ5IGxlYWtpbmcgYSBncmFjZSBwZXJpb2QgcmVmZXJl
bmNlLg0KPiANCj4gPiBEb2Vzbid0IHNlZW0gdG8gYmUgYSBwcm9ibGVtIGZvciB0aGlzIHBhcnRp
Y3VsYXIgY2FzZSwgdGhvdWdoLCBiZWNhdXNlDQo+ID4gc2V2X2hhbmRsZV9ybXBfZmF1bHQoKSBj
YWxscyBrdm1femFwX2dmbl9yYW5nZSgpIGFmdGVyDQo+ID4ga3ZtX3ZjcHVfc3JjdV9yZWFkX2xv
Y2soKSBpcyBjYWxsZWQuDQo+IA0KPiBrdm1fdmNwdV9zcmN1X3JlYWRfbG9jaygpIGNhbiBuZXN0
ZWQgaW5zaWRlIGFuIGV4aXN0aW5nIGt2bS0+c3JjdSBjcml0aWNhbCBzZWN0aW9uLA0KPiBqdXN0
IHNvIGxvbmcgYXMgdGhlIGV4aXN0aW5nIGNyaXRpY2FsIHNlY3Rpb24gaXNuJ3QgdHJhY2tpbmcg
aXRzIGdyYWNlIHBlcmlvZCB2aWENCj4gdmNwdS0+X19fX3NyY3VfaWR4Lg0KDQpIbW0gcmlnaHQs
IGRvZXNuJ3Qgc2VlbSBjYWxsaW5nIGt2bV92Y3B1X3NyY3VfcmVhZF9sb2NrKCkgaW5zaWRlIGV4
aXN0aW5nIGt2bS0NCj5zcmN1IGNvdWxkIGNsb2JiZXIgdmNwdS0+X19fX3NyY3VfaWR4LiAgU28g
YWdyZWUgaXQncyBzYWZlIHRvIGV4cGxpY2l0bHkgaG9sZA0KU1JDVSByZWFkIGxvY2sgaW5zaWRl
IGt2bV96YXBfZ2ZuX3JhbmdlKCkuDQo=
