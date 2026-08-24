Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D02138F630;
	Mon, 24 Aug 2026 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607378; cv=fail; b=VhSgsC5VMHx/7DPZOnIdGJgcAIeo7Fv/5R8KzQUOzIz+E4ZaESqb0QRCSJQ6RWBjTjTnTzVjsozXeikfKRws/njs6pL3suZeOnn042Vgf2lCoX/TUVPQw5lroyEAXBUFGDhC010m5GoeCGr/oThhTLE/rY6TkrURMDU959qYS98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607378; c=relaxed/simple;
	bh=7Vjnd85tL9uxUFxV76upzVpeHhKP3fSRAlCn9UfzyL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tUgJt6fG7XmKgFIJodgzIzl7P008K1YFhV0qBQHWWFXOmVPPYIeSEVT2i6wHv/n0KuCB1GWtXrpQ55PZpGMC68mCqgdUuBsJMioKIGuihOpgb3g6pp71MyW7LwpZ7Mzh8/tG+vgSfwcR+J0+ZBEETri7Oeu+nWfKNIGdbwR4Ki4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOCnw1Zp; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOCnw1Zp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787607377; x=1819143377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7Vjnd85tL9uxUFxV76upzVpeHhKP3fSRAlCn9UfzyL8=;
  b=UOCnw1Zp6oGaAxIIkzchpbB4H+J9nvBQMXv3G5TYyf901Emxn0A3Qa6p
   YqLAiFdqaT3ze7zVRgMotdck7h8kf3GWcHBC32ycLNXluvi0Fa3P55k4x
   L6AirvFUrSYmKrUkahUeWAeErlPgY17h4KRtt0lYsSXI4C/Y7WpxZ4in1
   IVEA8KKZHio1TYuihgH6K52EaD/bCrk1HAJa2Nm4QPZX4AvNEWLDeatu9
   yCW8acc75dqVjPrek8MKvaQfdT2OhJDF+zVzKDylOKVvK2BHCCVA1iUI7
   apKwooMOeRwgEnBdeRlmMyWCS9XMa44m5FPBczd64oToogEs2YLU6WYVm
   Q==;
X-CSE-ConnectionGUID: UIl77+/OQ8+3Ex8jBRbW2g==
X-CSE-MsgGUID: SJnzkV7lRj2C72g1CU3NMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87019284"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="87019284"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:36:16 -0700
X-CSE-ConnectionGUID: vEMqqHFLRW6Q6hfwC14ILQ==
X-CSE-MsgGUID: HuUubKqRSEyKJMsIqbFBeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="263831235"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:36:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 14:36:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 14:36:15 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 14:36:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIJq3EeyR4IzQ885iFrqQmmblBHnkBAtKuZUFI+vXS5szfvzuKbbMkCJsd6BEbaAFlRPJw37mM1/BqWymqDRdn05o3Fmr/D+y8Fp9Q6CAMjcz5zjA7uKR0MoPNthtUXd750IsfEp+pHybDfUs5rlpNhf9cjjgqxo4iEnGycrkV9huQcDI1LZ8MfYjqpW2RvxuPQ4PHIafBej6PFQEyXmCt+WVYnPFkfkAyBZDINxkaG8RXZj/oWCFbGhs/5zseD0UEqGbO7+xyL1+Um7W4MDqA7xLBSLkjsYqKjHfK+tM/Br3aTxQhZpybnBnYAr1Pk2+3yeOmtBUjD+jdqU4xhNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Vjnd85tL9uxUFxV76upzVpeHhKP3fSRAlCn9UfzyL8=;
 b=YKOGvE2Gft1JJjUcVYZOAc3HrKDaK4I+TwYvHNg+7ngHUxE1PuW7H7/z8Y7SLnfJmQ1o2tcHlC2XUckYLS8LcJZSCdXlwdChqFiTJKNToWtW6Xr6FqrdXA5SC37FDcLgYegS3f3s4hmb5dOxfB4vMTBYFO5aQWTuJBawJwA2NQ28TQ5RB7U19re/UogTuSL0hEiIrQPfj6X9Vk1q1woHqCyIoCVodtCs12MkPxmv4NHokfgrV60UKhWoufUBqJK+l6h6KHRq5ymBGlqLXp2RIcpmnflaTFg0GLlyFOe+4C9zwVNnUSMYGaSJR/iJ6bW6DqgxnEJi3j9QA8hHRtd4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18)
 by IA1PR11MB6242.namprd11.prod.outlook.com (2603:10b6:208:3e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 21:36:13 +0000
Received: from CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c]) by CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 21:36:13 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "nicoyip.dev@gmail.com"
	<nicoyip.dev@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86/mmu: Protect noncoherent DMA zaps with SRCU
Thread-Topic: [PATCH] KVM: x86/mmu: Protect noncoherent DMA zaps with SRCU
Thread-Index: AQHdMmjapMAXKduoRUK1jQB0aFBoqratfQkAgAA/TQA=
Date: Mon, 24 Aug 2026 21:36:13 +0000
Message-ID: <303eb59af516335e288647c19254928f89fa833a.camel@intel.com>
References: <20260822190224.3788887-1-nicoyip.dev@gmail.com>
	 <aoyEMBz-SYLigbGp@google.com>
In-Reply-To: <aoyEMBz-SYLigbGp@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5300:EE_|IA1PR11MB6242:EE_
x-ms-office365-filtering-correlation-id: 59a6be2b-d85e-405d-7daf-08df0227b898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: K1u4Gn8Sn3hfupChkhyhMhcFEdcMWmxgtD+iV3EHcrbn7oTWb2sMf55tXZBRgPNfPGWUOOU2bkqY/CRECvdFlnV2C8AFHYurklWTFNYZLuBuR9lX28VkeS2QKaxv+ZDl930NVmmdg1bhH5s97ZdNnTa5fJ7qhlLr2+/aJ66pDrUJeiZrYlhLFpsZIWazA3RYd17q3GGbZVZBZLSoKVvgYwlmhsCJp7XtqioVM5diwtKySjIRgd5krGJ8TDV7fM0PVEf93GEXYHdF9uCVCaI8d+skQ7q2k84Abry4tEkIYPH/6inCvdjf0Y2PO5g2nP0YSsboneFoo2cq9z5Vu5mLCeA9tF+/Qe1awcQO5HVk52IgKsIS6Z8gv9WhDfd8E9OdYDCffBeBgCeXmNXyrNuHYgYs0VXC67OeIGzLNOsj2QGYktRFAkqHuwxjN8pW08vz5O0TIXsmojSD/GsOm+ESUpG7tZGYeTNkqaV4zEE+0jOEg9kdS2i5ow5DgVOyR9fblIzW2+fCv7aBYV/8GFxO/rGevss5lE42H5+LrLnPWMkaxpPSxDKob+23aFQfh8HJbaPsTeOWkJsQqL5s7t9qTKurvCeeoECEDrUejqRCfd7hcdR9T9fX4lM1kRwsgW7Z/1kaT9KyBh8XqYpgI1Hwx/TQMEFLWXH+hVJcQ5HcPRf2boEwgociHJonxf+8/m0pOj3J5ONXiHalOsc64B4QedKGRYrq4MceIAeZgOH1SJk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5300.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U25hQ3MwZGlRdHFFVEhpUnNTY3FnOXN2SlF0MWRUSGZmcjc5VE1RM3luaGdG?=
 =?utf-8?B?cFg2M3ZNSmZTa2xiUWl6ZkVTYnF5byt3NEdENllmUGNsTDhvUGk4TFhMcVJr?=
 =?utf-8?B?cVY3NzZIWmVjODIwaVhjbGV0TGwyR0IvYno4ZmROVjB3MkhHL0U0SkMza21S?=
 =?utf-8?B?ZGFlWks1SlROU3IxN2szRG1uVWZQWTVhWG1EVmJjby9aK2xYbWp5KytFclhS?=
 =?utf-8?B?b2JFMzlpSzY0dWxTaGFkcHVVMUJzemFGbGtnN3J5VlNMT0hDWStaWHd3S1FG?=
 =?utf-8?B?UU9qYkU5TUNMeHdjMWJzTzZhengyZG9GU2k5cHBkRDc1bnUwcmlMRWY4Um8z?=
 =?utf-8?B?cS9RSkwzKzVObzBYT2NzSmJxb3UrNm9SMFB3RStHU2pVU1JySzNTd2svVE4r?=
 =?utf-8?B?cHVSSG1ENi9XUWFTdk40M3pTUytxK0lEMmlHWTFEQUVydCszL25VaEhKUm4z?=
 =?utf-8?B?M2VDRythTitYbzhCdlZrWVgwakJ2UWM0NytvVmxUTElhVERJbldtSWpPZVY5?=
 =?utf-8?B?N3IzYmNlMGtpc0picFZac0loY0RpMndhaGpvS0lhTXdOaVEyTUl6N0V3NFNB?=
 =?utf-8?B?MWR0eEpXbVZ0QjhDZVludE9wUmY3VkJ2VTNBOTZrQXhDdyswSjBLaVpubzFv?=
 =?utf-8?B?ZkROOFBmSitkb0sxcVpjZ1hmMWkySjZ3SFBXeUJNajlzRERlVTI5ZzFjcWth?=
 =?utf-8?B?cVN5RXBzeFVlM204RG9LbmFPWEJnUzlPK0VvVlcvM2ZmVXlmNnJkTHBlMUhn?=
 =?utf-8?B?RHJsSFZPMzlKKzdHUldZTGFmUUUrV2NsWkRMTXpaanljL29WMnhXUFNVZURx?=
 =?utf-8?B?VmZaYkRSb3dvNUNwTGdsSHVxUzFBOFExcjVLd2Yvbkd6b3dNcHdzSC9qdmUx?=
 =?utf-8?B?MzZwb0kzeTVaZEJaOTFIQ3JTR0NNcURqS0N5VGw2U21yZE1NMk00MjNLcWVl?=
 =?utf-8?B?bDREY0pLQ2pKR3VTZk1tVUc4bXBRSWpZNHVoRVdqMjJPVlFZKzN6MHNNTkdo?=
 =?utf-8?B?eGZ6QUhkOVZnaEZJOE9vK3ZvL1lDN1c0Wlh5Y29lZDB5MFM2Y3JGMmZWUDBV?=
 =?utf-8?B?czNIcmpzdGJLcGR2NDZrY3N1Ym82ZGk2NzYwMFQ1WFphamY2V1BxOWdTbFoy?=
 =?utf-8?B?V3dBTS80L05keWorVFh6a0hLL3JMa0NwSWNLS1R3L0FWVFE2TERKV2JiUFpn?=
 =?utf-8?B?N3NwU2VqRW9jc0JIOEc1Q2V4c2djejJ1NURPTmM3M1ZIVWNWc21ORURLenov?=
 =?utf-8?B?SmtqWUxlMVltUHZQeHNhdndJRElpTVlnVTF0TEZuWm5ycGx6cFQ1ZkhBa1pZ?=
 =?utf-8?B?WjI5SW5IWGNXNlA1NzAxUGd2TWlOVUMybUx4dnpGRCtwb1dTcE5vV00xYkw3?=
 =?utf-8?B?TjhHRjBTVnBwamxCVlhhV3dTSHhSU1RDdUI2OFZCMmhQak1rbldhcDJ4SGJO?=
 =?utf-8?B?N2tvZDlnbHI3akN5VytkdUlEdHg2NUR3a1ZRL21lQ2dXeUdTM0NOb0g5Qnhh?=
 =?utf-8?B?UzcxeEVpTGcvOXNWWmtLOXRoL1ZaTGwyditlckxpT0t0cDNEc0dycTliWFZr?=
 =?utf-8?B?WjltUmdubGRMVE5aNFdSN2ZjM2FqV0wxc1NSN3hMSElFY0MrcUJreUV0Z1ZS?=
 =?utf-8?B?Sk1aNHJTTkdkRG5qRDBibmh6RGVyYkZkOXd6d3FacUdHOGROeGx0aTVrTHUv?=
 =?utf-8?B?K0hiaEsyVHl6aDEvbWFJaWpIU0pMSllMcUVjWjYyemFnV0x0eDhJR0lhcm5t?=
 =?utf-8?B?MDVaSVVOa3JuaTM0cmZSdGYvQVRZbThnVmZlakE3LzdxOFI2bEdzbTVGQmdv?=
 =?utf-8?B?UkhuZlZBZklXWHlQWFgxWWNMQ0IwUjNXaHVYM3ZkTzVycUNxSEF4NmN4R3VK?=
 =?utf-8?B?V2ZjWDhxMXFMRnptLzZEa3JhZFZ3NWZnYzYydFJCcjdjUk9TQlJ2d2gyRTRV?=
 =?utf-8?B?cGd5TWlFZXVNMEFSWDFSUlRyMmVMaTJlMWpGVUZsSlFTR0tRdWx6RHZmaUpI?=
 =?utf-8?B?Q0tmckprV0d3dmZwcngwYmpNWmJpQlJNSmZaaXVYaDMrTlp0cEhMUzdZTUd2?=
 =?utf-8?B?UGlGdjNJK0xlcFZyODJTRk12cWZPM05jQXZ2Z0xlTFBRc1kzM3E0aS9ybGs0?=
 =?utf-8?B?bWZKTVNVZFEzRWxLN0xsMVR5azhOUmJlck1Jam5PbWkyU2FMQjNublhqc2ZJ?=
 =?utf-8?B?MlJZNU92U3ZSWFhEVVJISTRUS2k1a2p6NEkwaWRDYUM1dEsyRzVpeE1DWXo4?=
 =?utf-8?B?M0ZKZ3RlQU9iaHFCUGxUckw0dStjSHV5UHpjRVBtRzI2K1FnaEt0WWVUMnp5?=
 =?utf-8?B?VlA0UkhFOVI4V1UyaGIwa0ZZMm9oZHJPazFaWko1YU1HZk81SE9kUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92B2E7312465BD4CA53154E789706F28@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aLO2DlloyqtGUcCpr7dBCXv3iTvOCUNpVy1YV0yN5MeDcoTyCR5t/PH5Q8qVqpQg+/vb7W8PJdwSO8fFcg3TTYiBqVb6m7vm2ifA+JG1VSg53nbYi7u4Zs4Ka9ys4SLTO3ppP+vVG6lMpxp/CJQxItDV7LbXq5FD/+XZl1xl7bp0P2meguXZASaVcE0qVaQMyoayoi/Ah/yL8WMgMUVHfU+ZIUu2k2wirJOztXk9BodkftuD/O+DsvgpQUsI4QzHOkChTVjsMppmEAjyTgq2S6e2CLyeDW2K7XLMuo7jgtoGVsSL8b9cmE5TCrsp6TuF6S+JVhaLWWcJxnmcwOkAvA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5300.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a6be2b-d85e-405d-7daf-08df0227b898
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 21:36:13.3378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+ASq+Sre1g8ti0H6muCFFJXwZzmGX8gECHGVUT9WgKg40thoW2sLPLA7W4Irgv05RxCCZdhN7eBE/S9xo041A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6242
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA4LTI0IGF0IDEwOjQ5IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBBbHRlcm5hdGl2ZWx5LCB3aGF0IGlmIHdlIGhhdmUga3ZtX3phcF9nZm5fcmFuZ2Uo
KSBhY3F1aXJlIFNSQ1U/wqAgTmVzdGluZyAibG9ja3MiDQo+IGlzIGEtb2ssIGFuZCB0d28gb2Yg
dGhlIHRocmVlIHVzZXJzIG9mIGt2bV96YXBfZ2ZuX3JhbmdlKCkgaGF2ZSBoYWQgdGhpcyBidWcg
KHNlZQ0KPiBjb21taXQgMDc0YzAwODAwNzE5ICgiS1ZNOiB4ODY6IFVzZSBTUkNVIHRvIHByb3Rl
Y3QgemFwIGluDQo+IF9fa3ZtX3NldF9vcl9jbGVhcl9hcGljdl9pbmhpYml0KCkiKS4NCg0Ka3Zt
X3ZjcHVfc3JjdV9yZWFkX2xvY2soKSBkb2Vzbid0IGFsbG93IG5lc3RpbmcgbG9jayBvZiBLVk0n
cyBTUkNVLiAgRG9lc24ndA0Kc2VlbSB0byBiZSBhIHByb2JsZW0gZm9yIHRoaXMgcGFydGljdWxh
ciBjYXNlLCB0aG91Z2gsIGJlY2F1c2UNCnNldl9oYW5kbGVfcm1wX2ZhdWx0KCkgY2FsbHMga3Zt
X3phcF9nZm5fcmFuZ2UoKSBhZnRlciBrdm1fdmNwdV9zcmN1X3JlYWRfbG9jaygpDQppcyBjYWxs
ZWQuDQo=
