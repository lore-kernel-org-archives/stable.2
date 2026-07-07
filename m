Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C43FA5D5;
	Tue,  7 Jul 2026 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424038; cv=fail; b=E/0/Y0nrQ6HG0Qga19U9VVgztpfq11lQJLUqPLg1ouyk540Ukvr4GHSewdSuZkiYz+N8Q8H6kfxcgyREqcBOPKBW7DF8RT4kEA7SDgziOsnLv+a+GiAuIKrTNBMecs59KqPuRHGJoJlXgguGTMl6ySuFv/m/votr0QFWaPMJx9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424038; c=relaxed/simple;
	bh=pMqEy99InPGCfbbnxUVQNU0mxdGQQB3b3hxrKpSGeUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tkH2MrLbwWuYtg1nKgAXMi7ZVGxRVg+scV1y9g+C+6EO06rOsvZRrdwPiOH7XhOJIC/fNrpmZu7TpII9wdDdu0CUmQFn4QH1ybjoPtBgLfPNBvdO8tDyJj7XwapeDUL3x/EdEnllHLC2MNs5h+t6FpCUYDDHh44b0transoZIC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAHnOQQm; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAHnOQQm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783424036; x=1814960036;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pMqEy99InPGCfbbnxUVQNU0mxdGQQB3b3hxrKpSGeUo=;
  b=eAHnOQQmv15Iur9qoFrU8lxF5I3VlYXjRpmRGcUN/2cXbIQIkq7bzEDQ
   B0df353/3RcOwsK8LtKgTsmyqtcAGFgvKjOCMlCGMqRiv0vJBxpP0zAig
   K83eTfibItKv29CplSKyiNyUVgPIC/v2zLTgngZcwQqdSVMCm7GBfQL6y
   GoB824xdKhDmLQBmgFrOBvkslT3kPZD1orDHYsjdYjmCCipQUEcbCmSbT
   jDh+QLsJtfs61nvliF4LNxXJkFY+vCf5Xrp8HCeKsdLisKRDprN4CVf21
   WGpn75u46r+0c8JeXybm4bQvPmVV689BuXRHupvojcTRh8E8SUufjUgF2
   A==;
X-CSE-ConnectionGUID: 98jqoTjAS9++7DoDeg6xpQ==
X-CSE-MsgGUID: DGp9SLv4Tnmi6e5SJJb9DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84259035"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84259035"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 04:33:55 -0700
X-CSE-ConnectionGUID: cL2RuSxFS46JGyWO72ziOQ==
X-CSE-MsgGUID: gYPhUyPaQwK0QTqyYe4x8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="249537950"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 04:33:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 04:33:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 04:33:54 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 04:33:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTsTMTJgI0BCZDqZbXZZHF0Mrbif5t5mLZTzrOI+3/Me7erhKVV5GD/+Ve+q9tyWN4nZ830LTkTkh5heEt9SedzMoNMnDU0vhe9CiSoqIeOeKVnA+y2m2exotPbujsEuXwdOmuoMm8f9lyliCfVNjZp5vmxBzN0Fx43azMcw9THTPB2fV3wvD5GsdUQ1qv+x/v/Q0BXjRSgMPPDbVYFVVBZhsMsrZotQip5BCuAHq4n6FARnuH1nOeHj9J6s/k0UygcL6oeAyKNTQYE5q44KSTZ0kWugwvmCZQhHHh6zRofMYblY0Z3V4iez1jpdoQp+fkJIf+pLwq8dwgQzVMRIGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMqEy99InPGCfbbnxUVQNU0mxdGQQB3b3hxrKpSGeUo=;
 b=TEJi3nyqWXVWEtG/ec8jrpPEiekJ5XyWn1Jn5sD0xVUMklKr9OeCL6Rempjhcnvq/1tAmWs8/eYERam54BAMMP5FB/hEP73XGF9SKq1bvx7LzduBBk6TaoMoM0rLF+KaHxTaJufc3nrJawE2kpanwQz7sn/i/QvZYWUx3F10E+0MwfkkvyQ86YI2R/Dlff5tF960ycUUBHeoK8YgnA9/wzvgKnl/4cA/LIPEs1tAGQKE0ZNBvbiNLqk698+eIdezq/9ibqpMbSPwn7XkKhdXCfEpTJY3agvkvTvJwLs13eDrNVLn3oDrM/sJQKIX1BZetrTB65iSCjY/CyrJ+RvE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ0PR11MB8296.namprd11.prod.outlook.com (2603:10b6:a03:47a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 11:33:46 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 11:33:46 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Arnd Bergmann <arnd@arndb.de>, "Nilawar, Badal" <badal.nilawar@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Adin,
 Menachem" <menachem.adin@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, lkp <lkp@intel.com>
Subject: RE: [PATCH char-misc v2] mei: lb: fix incorrect type in assignment
Thread-Topic: [PATCH char-misc v2] mei: lb: fix incorrect type in assignment
Thread-Index: AQHdDUrmkAgWnA8ZpkaOjxvzrrmKn7ZgjgaAgAEN9YCAAAvzAIAAGAcAgAAEIACAACnKIA==
Date: Tue, 7 Jul 2026 11:33:46 +0000
Message-ID: <CY5PR11MB636655AF4DF3B425C2DD3480EDF02@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20260706-fix_type_le-v2-1-586826351454@intel.com>
 <2026070608-reformat-pungent-aeb4@gregkh>
 <CY5PR11MB63665C97B337ACAC21A8A626EDF02@CY5PR11MB6366.namprd11.prod.outlook.com>
 <akypBhzJdxGLJiYq@ashevche-desk.local> <2026070722-zips-outgrow-ee43@gregkh>
 <akzApAxptnbNwg_y@ashevche-desk.local>
In-Reply-To: <akzApAxptnbNwg_y@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SJ0PR11MB8296:EE_
x-ms-office365-filtering-correlation-id: a164694b-6857-452f-86b3-08dedc1b9b54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: uF9J5tB1Nx206CHrBjL8PEXVx1rAET1YAEYYA1xXL48y1QQMAuK3YARpuzPeudlWltvpVRlz/zCtIygMX2B5hZgMktArbSid/5xBzoe3uQZOD4ufuLgYbpNXA741lZiFlzmSdLv0S72FPDMfd8u5zlPMD+o4jR51USM95Sf+kxKpMs9rdpdvhvbEGrnfilgK3gmOHhYPKLuLaj1Ej/25R7++u39CNHzAIOxGkMuI32uTHUyiI6c9N186NbFcwr+if8szX/pAlS/uMyZSPbY94bSrjl898T4mzCv1Va3x6C1Ub9VQdRquw44HmVMDHD75rm1g5Ii42U6iyFH/Sa0Nuri+8NVxMHUFYMhKrx1oNDDdVMKhEGY+9k5BetrJ3QpPY76393RDeiZ0MkllGsAOx4ajMwQG9jUrFe9OFqxIGbtIQROFRYM2z9c2olleJlxZLcC6C933czJebtIeJqQw3+Oz/y5qPBipeQf5kA6WH9PNiE6b03iGy2Xr9+tV40eUoe85ykMxMTjZL25ojA/KvfRRhRYxvCG7WqxiHUMcJU57xltP+KZ01Zsg8cAM2lJidGqUT996XiunDwmbcDY62GzsCNPk7FvtihFy4dkT4FpJ38wW2/bB3pffySQ7s1xvQyGIn/gvkP9WYFZsCHPwa1brgwXmIbh34rga+lx+HvW6L31EmhIOgwor+WsXhXp/ViIr3QO61kQcz2In2xsbJbvTm2fv4E57bK8J/EQB/hk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVlzWHZTanhXMkdXZzZkY0xQMzNGcU9PRVNnTUorZ25CT0Q2SWc4RGIwWDRJ?=
 =?utf-8?B?bEFNUW5xRE1aUTl2SmE5U2thblpxSUdScmV4VHhIQ3hkVXR6YnQ3M3lTUXdz?=
 =?utf-8?B?QXE3dlhvTEhBbWVMK0JzaFNsdlRhL2F0dnhyY2dxMEkzYWoyZGlSMTI3cXdh?=
 =?utf-8?B?UG5KL1ZkZTJCYlZCSVZibGJYZWEyV1YrNkNBRFhSQjdnT2wzeCsxQitVUGc5?=
 =?utf-8?B?VTJSL1JYYmJvbzJwV1I0bitnNldyV3AyMnBVTDZLd0ZLK1M3L1IyeTFrVm02?=
 =?utf-8?B?alBHV3FrVTBnMzVVeEMva0VKeVBrMG1lZGhxTlNRWUJlUlc4K21RaURScWNO?=
 =?utf-8?B?VlVyNFJXZW4yOXUzVWJOaVRhV2V5QmtGd3l3OWJjeFFIcHc5Z1hRaUhUU2Jo?=
 =?utf-8?B?NmZNOUh0NFM4UGVVKzB6U0ZrVEY3WElycFpQQlRqS1NiNUZhZzRyVlFjTkht?=
 =?utf-8?B?Q0x0dHZ5R0tNdG4rQy9vdWxYeW5sUWdtNEpIRm40cnBFNXNPbkF6aDZYMThv?=
 =?utf-8?B?aU4xQzFiWHhVdlgzWVFIV283ODE3c2xialBlWDUvTVNlbFc1RlpsTVhQTGh1?=
 =?utf-8?B?VzlmbjY0Z2Y3Z1Vhemo3SXFSb2lVRUxobE5RZ3pBUy9xYVRTS0ZvRVVXZENX?=
 =?utf-8?B?VVdQZ045ckRTMS80WE1XNi9sSlVQaXl1UFVvdkJRQlBkNGZZV0M5V1FhWUR4?=
 =?utf-8?B?dENrQVVOS1M1M1R6UXNYQjhqSnFod2FkVzJrd3pQNFJGelRSYnZRNnZ5QXRv?=
 =?utf-8?B?Y2doaXpZbEw0Zm9WanJXT3h0NUR4T1I5TGhBdm9zdGVzUmNMMERxT1NkdXlQ?=
 =?utf-8?B?NC9LaXdqQUpQb0hSYUJOV1FoMkk5czlmUzlUWjhianVsYXk4bnplT012TkZ6?=
 =?utf-8?B?WktYMkRKb2xjY2tvRlVobko2RnN0LzZzbTBYR296SnpXUi9VNG5DUUJPeHVj?=
 =?utf-8?B?K2RKUndmVmw1VWEwOUhLMWFaZjB1UksvV01ONmdwblRmWXlaOHZVbXd0ZGRr?=
 =?utf-8?B?d2d3dlc0ZkovM1ZqbnJDQ1NXcExJd1hqWDFCOVYxMUtTVXJQbS9qeXB2bFVp?=
 =?utf-8?B?YmkzazlMeUJWMWlDOWZlaFo3MzV1UjQxMHhTU3JCa25EVVRzRTV0aG83SG9o?=
 =?utf-8?B?RWhUam1TMFM2ejZnczdNWUwvdFBVcjkrbUNKRWR2OVZYcEdvYnVTT1ZvSzIz?=
 =?utf-8?B?a3NtQS9jUEx0ZGxJSmN2Mm05TW5qZ0loNm5ieUpyRkYxekY0dm94eXpma3Vw?=
 =?utf-8?B?QlF2YUFGS2hpVkdpZG5UYStmbzFCUXNMMGd0YUd6UFREVGhxWldyNmZUY21y?=
 =?utf-8?B?aU5FZkd2STY1MS8vM2o1TnNCSjhLV2VMTmNLTHlDYWRNdUhFYzVSYndwQ21j?=
 =?utf-8?B?cGUvN1BwNmVSRXc1WVVvVWtBYVc2RmRYZEYyTTR5WS9CcWVYRkJUWVQ0U3Vs?=
 =?utf-8?B?U1JqZGVndWhDSUtOemlTRGpuU1k0d2t4Z29KQ2JmTGlRMFhYakJabmx4Wnhw?=
 =?utf-8?B?RDFjREluR05Ga210TVc5M08vcnN6VmlUZ3AzYmo5ZHpySE90NktiMG1reE1p?=
 =?utf-8?B?LzZ6UmxtU2tHalM0TXhGNThDYzVERmZrSW9Sd08vblVqOHRoSjc3QWhGMk9t?=
 =?utf-8?B?OW8vYVhwUDJyNGNWQjhNaVZ3US9JZFZqTHZYVXhuRVJadThUUXczQ0dWVmxZ?=
 =?utf-8?B?SjV0Mm4zajh5ZTcrZmtxSlFhaytsQXpyOW5sMElqUlZIOXAzZE5jNlJoUWFV?=
 =?utf-8?B?OS8zK21HOS9rdWI5K29OcExDb0xaRk93NEhCMFFReWl5ZnJjNW84Q3BJRU1G?=
 =?utf-8?B?SmRiWWtkaGNwQ1hxdWhDWXZBS2w0YjUwV3ArOTlWYnB5QkJsVWdHbzdZTDhM?=
 =?utf-8?B?OTMrdXgzQ0pIb2NDZm1zdjFEUHJIZ2xJVndZSHRMcHI4Z0lHM3N3ZVNCOThh?=
 =?utf-8?B?UGZtVWRKNnZjWm9vUlNSUjlRRFczWS95S2FkZHQwc3JQSjVNbjVMTUgxR25P?=
 =?utf-8?B?OXdjVEttY2d1SWFrU2lNaCtBZ3hWb0hHODgwQTc3eUxxazRFNDhoOUpzeHdQ?=
 =?utf-8?B?bE96Nno0MzE4VE5HL1F4ZzcrSFJ4VlUxN1ZXMHdDL3JzMEZLb0JQVXVUV3hO?=
 =?utf-8?B?eG03OWZwaEZtM0hnUC9NN1lTcHJyeVo4QjFpVVZCZzRLQ3hQWnpBT01XS0xL?=
 =?utf-8?B?cEJJNXYyWFcrQ0g2ejNLd2pnUkliVFBaVXNwcm54bmZVNWdoKzN5SEJDZ0Vs?=
 =?utf-8?B?bEtIREVvT25SOXEwMXNKTmoyNkpodnJ3SUZpeUxBSDM2UG5GSzROUmg5TFJy?=
 =?utf-8?B?QnEreDgyVUcyKzZ5VzR1WXloWUIxQ1laa1ZFTWh1SnVjbzhka1ozdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XL8M2jMrhkkP81OUIkm8GCkW9epOv+yDXnt6jZek2p4pcC/+xt+UTwjncH4mFvPylEjA1XoPzzhDaNY6Rs46Bv8nYUl4AZ+UyG0MBHnCXoooO12bUNupiqEBqiBSp8UEYbiiiYguMnibbtjMcadrgl6nomxx/6vNlnLClTiNt1ra322pv7T+I5fdUGv9zZEGQpkptBti4L9hDxEN0HtQQrZnDkqGGuD62GybTt1QlpkL7um8MoX7HQDVXaG3iIg+PGxUo+kazxfDExxa+Yq/r9QUARCWWePl/MHzl1ENd1Pd9PUtCHIaHHkrR6Cc3XzLo0dK5JZUD9UkbuWCEloLiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a164694b-6857-452f-86b3-08dedc1b9b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 11:33:46.0801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqPkcKHhj4c3mSWA7k1sysC5qZcB7Fl6++8qo/jjL60foq56EnYMiR+Uve/wInog4Rkl2PCqZQ7OkArx9ZJKbjVXK7IKqYFRcNe+w9PRPBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8296
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW1BBVENIIGNoYXItbWlzYyB2Ml0gbWVpOiBsYjogZml4IGluY29ycmVj
dCB0eXBlIGluIGFzc2lnbm1lbnQNCj4gDQo+IE9uIFR1ZSwgSnVsIDA3LCAyMDI2IGF0IDEwOjQ3
OjQyQU0gKzAyMDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gPiBPbiBUdWUsIEp1bCAw
NywgMjAyNiBhdCAxMDoyMTo0MkFNICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4g
PiBPbiBUdWUsIEp1bCAwNywgMjAyNiBhdCAwNjo0MzoyMEFNICswMDAwLCBVc3lza2luLCBBbGV4
YW5kZXIgd3JvdGU6DQo+ID4gPiA+ID4gT24gTW9uLCBKdWwgMDYsIDIwMjYgYXQgMDQ6MDE6MzBQ
TSArMDMwMCwgQWxleGFuZGVyIFVzeXNraW4gd3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+ID4gPiA+
ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2h5
IGNjOiBzdGFibGU/ICBJdCBkb2Vzbid0IGFjdHVhbGx5IGNhdXNlIGFueSBmdW5jdGlvbmFsIGNo
YW5nZSB0byB0aGUNCj4gPiA+ID4gPiBjb2RlIGF0IGFsbCwgcmlnaHQ/ICBUaGlzIGlzbid0IHJ1
bm5pbmcgb24gczM5MCwgb3IgYW0gSSBtaXN0YWtlbj8NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBk
cml2ZXIgaXMgZm9yIGRpc2NyZXRlIGdyYXBoaWNzIGNhcmQsIHNvIGl0IG1heSBydW4gb24gbm9u
LXg4NiBzeXN0ZW0sDQo+IHRodXMgYWxsIGNvbnZlcnNpb25zLg0KPiA+ID4gPg0KPiA+ID4gPiBJ
J3ZlIGJlZW4gdG9sZCB0aGF0IGlmIHRoZXJlIGlzIEZpeGVzOiBmb3IgY29tbWl0IHRoYXQgYWxy
ZWFkeSBpbiBzdGFibGUsIEkNCj4gc2hvdWxkIGNjOiBzdGFibGUuDQo+ID4gPiA+IElmIGl0IGlz
IG5vdCBoYXJkIHJ1bGUsIEknbGwgZHJvcCBjYzogZnJvbSB0aGUgbmV4dCBwYXRjaCByZXZpc2lv
bi4NCj4gPiA+DQo+ID4gPiBDYydpbmcgc3RhYmxlQCBpcyBhIHJ1bGUgd2hpY2ggaXMgZG9jdW1l
bnRlZCBpbi10cmVlLiBNYW55IGRldmVsb3BlcnMganVzdA0KPiBvbWl0DQo+ID4gPiBpdCBmb3Ig
dW5rbm93biByZWFzb25zLg0KPiA+DQo+ID4gTXkgcG9pbnQgaXMgdGhhdCB0aGlzIGlzIE5PVCBh
biBhY3R1YWwgYnVnZml4IHRoYXQgbmVlZHMgdG8gYmUgYXBwbGllZA0KPiA+IGFueXdoZXJlIGV4
Y2VwdCBkdXJpbmcgdGhlIG5leHQgbWVyZ2Ugd2luZG93LCBhcyBhbGwgaXQgZG9lcyBpcyBtYWtl
DQo+ID4gc3BhcnNlIHF1aWV0ICh3aGljaCBpcyBhIHZhbGlkIGNoYW5nZSkuICBJdCBkb2Vzbid0
IGRvIGFueXRoaW5nICJyZWFsIg0KPiA+IGFzIHRoaXMgaGFyZHdhcmUgaXMgbm90IG9uIGFueSBi
aWctZW5kaWFuIHN5c3RlbXMuDQo+IA0KPiBJIHdhcyBub3Qgb2JqZWN0aW5nIHRoYXQuIE15IGNv
bW1lbnQgd2FzIHJlZ2FyZGluZyB0byAiaWYgaXQncyBub3QgYSBoYXJkDQo+IHJ1bGUiLg0KPiAN
Cj4gPiBQbGVhc2UgZG9uJ3Qgc2VuZCBzdHVmZiB0byBzdGFibGUgdGhhdCBkb2VzIG5vdCBhY3R1
YWxseSBuZWVkIHRvIGJlIGluIGENCj4gPiBzdGFibGUga2VybmVsIHRyZWUuDQo+IA0KPiBGdWxs
eSBhZ3JlZS4NCj4gDQoNCkJvdHRvbSBsaW5lOiBpdCBpcyBoYXJkIHJ1bGUsIGJ1dCBub3QgZm9y
IHN1Y2ggdW5pbXBvcnRhbnQgcGF0Y2guDQpJJ2xsIGRyb3AgY2MgaW4gdjMuDQpTaG91bGQgSSBh
bHNvIGRyb3AgRml4ZXM6IGxpbmU/DQoNCi0gLSANClRoYW5rcywNClNhc2hhDQoNCg0K
