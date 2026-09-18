Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED673D646E;
	Fri, 18 Sep 2026 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719845; cv=fail; b=fyp+RZpPBASN+CnGyXUqfQ9wCZJa3jH5K3Q2q/5l6Uush80n0GKnvpttGmre1GZOMt4BBzGYeT9erxgv23bLyztD+jc2BBq7JHhCv9RNnV2F+zX5SfTDElxJWbAuXPMHuTN/ZgcLivPpv8aHJQGrZK1Jta9voih31DqXR6lWX5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719845; c=relaxed/simple;
	bh=VOuAPrvhe0nI+JWWHyxYyDnmm1I8g9SuAlZpuHBHKNw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DjEVIfG1edR+UU0xuBRbhsCh3oGzLnzNdrl/kuNmBFZg0XnTlIWkPI1fWi2tEyXij6thVBRknW3wfVHaU1/VWfXmDaASbM1ZcMO3i9EcfujZve7xpEoFlprz1POk+XT54+BxR+JT3nbFR4Q3Hn0mVHgjLFPPmoSsfQpl9qNl0zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQh/9RD1; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQh/9RD1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789719843; x=1821255843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VOuAPrvhe0nI+JWWHyxYyDnmm1I8g9SuAlZpuHBHKNw=;
  b=EQh/9RD1zAHlcMmsCInl/INDITPYzpL4sXFqGMpG8/on5PLkB0i5PjTi
   uy7FX19B7Niq2bR915df96YCEIZC0xCNcJeFgeHKvGA0ezaAd8+VZrnM5
   E9MoNWCh3YF4d+F5e/xqRXTO3OyUc/9ksmV+VgRBbsQCB6rkYjUoKApjg
   Ja8z5A2zlJM21Samb310STcPSBnYprE4gyd/x26Bl6nK230jTMsd0CcKA
   yAHuBPDsG5gYFMAghPLhDxL9nMGN7kzK29DGUMAYKMJXp3DPeKcN57fNE
   zZmd7ntC3TA9bBhsoPJ/Bi9Sx2dECL2rCEFIBplr2Xt+0lKgyPTXKfX3m
   Q==;
X-CSE-ConnectionGUID: REj/s2jLTYCBPP7AAy4q3w==
X-CSE-MsgGUID: 2fLe4l75Rb6Yp6QSO9JPBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101558924"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101558924"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 01:24:00 -0700
X-CSE-ConnectionGUID: 1MO3DucGRZup5aZeARPyIg==
X-CSE-MsgGUID: nKFrvkTZT5m5lT8k+z3d3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="299382120"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 01:24:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 01:23:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 01:23:59 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 01:23:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqZS7ZXk3oyqZlaTIfAjILD8mNYsxPZnJl66v0HeBHVBPIsOa6YMa+UhZNEsDca1vFJPWqtT7O8tgEGFbrvBstvG7AQ/soDOw6pQE9JD9finDnTrVMo9PVFL7dKzQC1Sg3+QUcjGXEUEYTFaAGB2P/akk7L2DMhpNHMGx/mvSQJOracscuBbgTAcDXm7xQ3vDuezKYhXHoXgWCfENhFm8Blxv1S7bDBzX/ib6toIiFhMiuI09ki8h3VXHtJk20nID8ZsOISfM15kG4dyYFd28hEMa9mG7S4Gnnr5TTATMli0hdHubUCSNuu1KAimZFYnK4nJWxpzXNwGMuPtE026+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xa/bjTzVx4EZA84A9/4L1S9CJXe+1zf65dHHNZ5O+Y0=;
 b=V0wD9LiJpoBACIOpFa4Jvw3NStGj2wcs2+sSMugUyZCDS/1y89SRV1zIUDfI4Y++jNCnAX/NBcYC6Efega5vq4UNgGBD2bZRfQXMsANyCXpJeoPVwFRz03wx2zvS11bCXif0LpYFT07tlZ/7Pl0+rVRHIwoHP/hdzh7LFU3eD5WEEhoFyxd4GPK5fxAK8wBgrhH5AG4kPDJCwCxUxH4bahKVWjfdYL9mYcPntYA5uVOSf+gE7yN6D2PSHKhDoqXMRA1nvwn/1G2b/02ddERdlU7Iw/0SMTWvLP2J1ixcRgUjQpfCIB+JfOnwK4fE4tPzQXq8HVoom9uc/Emwpss5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13)
 by CY8PR11MB7848.namprd11.prod.outlook.com (2603:10b6:930:6c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 08:23:55 +0000
Received: from PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd]) by PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 08:23:55 +0000
Message-ID: <c4491e5b-c89d-4fe5-a4cb-554a07c980b9@intel.com>
Date: Fri, 18 Sep 2026 10:23:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Fix use-after-free in
 snd_byt_rt5640_mc_probe()
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <hansg@kernel.org>, <kai.vehmanen@linux.intel.com>,
	<liam.r.girdwood@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <perex@perex.cz>,
	<peter.ujfalusi@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<stable@vger.kernel.org>, Mark Brown <broonie@kernel.org>
References: <20260917170052.2163636-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260917170052.2163636-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0525.eurprd06.prod.outlook.com
 (2603:10a6:20b:49d::16) To PH7PR11MB6006.namprd11.prod.outlook.com
 (2603:10b6:510:1e1::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6006:EE_|CY8PR11MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebd4402-bb71-477f-07dc-08df155e2dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 12mJ6VJdWp3eBmyPdffAShnHna+zWJEHpzhpNNIoaY1QxZDIrvgfOGl52ds5ybvH6dBr6DZbXo76KhZYN0RkWWl2Hgpw8mcWIyEeL2NzeF++KDw8j35mwMxNFVUF3AEDPX2oOBbaZxzqj+0/TYHU2nG1+t6vwuAJLF78vu3S3FgmwpNT/XhTensckm2gaGUzPwYtz3E6Vlh4ud0Iv9hYFR3CsdNZhgdvB59vKHhw7V1ZhPxTXlsg0XXV1z0ovaLc9bvkxr2v+et46Tu58i83BssuDZvuvmSl7poDJ4+6Ph3qdwrI/EwSMNd9964hIGJy2V3HuqSaq2kfM3aZH10bTgrc+dZq+7u4fYXEbqxSUSyumoYGeDRde3WsaXQJtrjV3NBzpEeVpGsA7How2itrCtZ1sEM6k00WdEz2vpyaJzrsEsq0PnN2SP4wckPoFkuriQQev9NuONxgN0D/5ccUB/aFDSSToRUXGBCBaQ9fuPXuqQ7FTFGkZalm/mLXLeIXKfswgYFfTtyh5LuM+0HaqHZIwAmZwXX+uwYBxKw1wSt4EbktvUrxjRJHi4n27zJzmRTP/IVUMoagNl8vmjc8isHRL6CUQ9CrOQ2v4p/fHCJJDifDkQ+O75aLWy9k+0onvUfJtFzAy++dXOybGKckzYhxoKys+WIXSr5ElSOR/9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U29VWFFQTFlUc2pCME9FN0JuRDNrUUZwOVV1T1lSVzFzbWE4c3B0TkZ4bzRY?=
 =?utf-8?B?N1h5VGdnaU9mdm1uOWhBMlJ6NmhOYmppL2c1SjZRVm9NZWZ6R3JQbkhmZDVw?=
 =?utf-8?B?RzRzSzZOMGs1MzltRFF4OTZRRWhSNU9GUmQrY1B4bWxuR0JhT2lERXhjNWE5?=
 =?utf-8?B?UHovMWEya0dBb0o3ekhMTWovQXkvbXRNdEN2bkg4K1dFZ0ZXNC9ka3Q2WUVT?=
 =?utf-8?B?SjFOemJQWkk2THhGTVpOS2VaMitHVFhtTFFYNkJjc1FLVnNSUXlNaklKRTIr?=
 =?utf-8?B?aHF1UlZ0OGVpK0J5aWRvdVdrbVRGYncxY1ZIamVVaDZTYnRUTkcxaG40MVhI?=
 =?utf-8?B?dVgyWTlZZndOb3ZyODhFOFk2emltd3dLbzNDbCtGVUVKQzBnYmtsYUhkcmhr?=
 =?utf-8?B?U2lzMU8wOFBOMlZTQXN2Mlp3ZFFpMGRtbElKTUVNaEdzd1Z3WUZsNEg2a0FL?=
 =?utf-8?B?WEI1TXpGRFQ3czFRMlR0SC9xa3RrWDRzZnNSR21xUlRiR3gycHRtTzBOZnJ1?=
 =?utf-8?B?d2Y3ZVFLOWZjRVBrK21hcjJNOVpsY0ZlZHVlUVRhV1ZXeTNNRzJ4eStkYzRE?=
 =?utf-8?B?emJIVHFEdWlLYmdvOTZqRzVIQ2l3R1pUY25SNThmVXpTZ1F6QVI4cnRzK0RF?=
 =?utf-8?B?eU9Wd0J1em5uVE9VSTZETW9oMy82V3pXbHIzejhEL0NBbTdqdkQrOEZqcDVV?=
 =?utf-8?B?TEF2K2VONVZFRXBwdVIrN0Z5KzBSb2dCTkJPNVVQb3hoVFRiQURMS3FoK253?=
 =?utf-8?B?R2JsaHEza0NrUkNIY0pHZmNFcGd4OTJkMXBRSzRQczYxMjNhWHdmMmtKMnV4?=
 =?utf-8?B?Sm5lYzVjTk1TK0s2d3k3WklrNU1iK3pycGVXTVJIdldFQlFvUEQyQnE4N1Ay?=
 =?utf-8?B?M1hzdGVxc25GMU9ubkE2OUVFbkROQzVSWmljcjc4ai9qWE1SN1RCcGhybk5a?=
 =?utf-8?B?azl5TGtPZnlpOWJ0dWtBc01pNTJ0Q0JxSS9oSSszVENOYTZzdTh4Z1BBU1di?=
 =?utf-8?B?cDNmQlRleHBRd25vS2xlbFVNOC9sMHM2VVI4MWJvQ2txK3pBL2Z3RkozMy9T?=
 =?utf-8?B?WUU2NXB0Z1k4TDNtWmFGTUtvSDRXTU5wbXVTdUloL01aOFNZT0p2V3Y1QUZR?=
 =?utf-8?B?aWxpUWU1MGl3OUUvbE1lb21uc1BLaU9hSTRuV3ZKelJZcGJ6U0lBaGZPZW90?=
 =?utf-8?B?TTAxdUNGVUpsbVJUN2V5OXBHZGhwTzgvK2JINmg0dU5xRDNPNG9HWGtXNE80?=
 =?utf-8?B?Q3loeEtNS2hrazRiV1FOSWY2QUQxODc3U2Y1ejJjSFJJN3ZCRXZBUlI2MW1u?=
 =?utf-8?B?N2xNMUcydzY4RnpqN1BzOGs0bXFiWjBhMmpnZ1BPSGE0ajlabitCNU9ndmNC?=
 =?utf-8?B?ZzhEN05CMnhBT1BzSzEvazkwWUpaNWlCWXFZSk8yUTgrSXlNM2RVSW1KbXMr?=
 =?utf-8?B?VE4wZW1xRlN0bFFLb0gzZUhFM3YrMWl2Y3FhcHg4MTZjSytsVEM2M0llUjR1?=
 =?utf-8?B?QjBOaWY2dkhXT3JkMG1YWmpzU1dsNkE0UkxnSjMzM25yWWIvZ2hZaDVzTFNo?=
 =?utf-8?B?TnVkWFFLWmtWOGJhK2Y5RFRodWVGaEh6b3NhSy9IeTdyd0M5RG1lR2NTQXJI?=
 =?utf-8?B?K2ZZR3hDcExnZmVDUlZOL3Y5UkJVTnVkWEw4N1VUU1ozRlBmY0RVU0xDRDIr?=
 =?utf-8?B?dW1uaXR6Ky9TRkRKelZxTU4wdGtKc0JOaW16RE5kb1hURkJ4VU1WNTZzakhJ?=
 =?utf-8?B?RjVXL1A4UnIxc1cxNVZkU2FFUEIrcWpBcmFYbGpRSEtzYUhteDFsQll3R2dy?=
 =?utf-8?B?MnBFSGp6WkE1aXFsNmdOSHF6UUsxRWF0MzFTRzFvbUFnR3hoeGhTODVrSElI?=
 =?utf-8?B?YTd4a2J2bzBFelozN1FmVW1GQ1Y4eHprTnNtNmRJRU14clZyWnNGWFlXQXZI?=
 =?utf-8?B?MFhTVlVQakk5MnJaL2ZDWGJiWnlSUEFXbU9FcmozcW9BUy9rN2NuRGxYU2lW?=
 =?utf-8?B?dEsvaUVVWUVteTBUNi9XVHl3R0tJTDQva2dacU5RWjZyd1B6TTdsRUR3RVBq?=
 =?utf-8?B?RzlkQXpIOExnd2xLdVlnNkhreFNQaXpjcDU4Vkc4NXVILzJmVDVVbFFpUkdS?=
 =?utf-8?B?UVZPT1RDVTRoVWEwbG1wRHdLWWhGS3JYL3I2S2FteVFmYlNpY0t5M0RHVGY4?=
 =?utf-8?B?UkNQQ1NFcjZteUdxVk0wNnFhRW5kN3BqR1BqUmg2amxrZHVDMTluMWxnRHZk?=
 =?utf-8?B?UTU5NnNtRStFNVYxckg3cXQzZllrQ2xCdVRaRHpoNzM1cXVkU2E3TzdHK3pt?=
 =?utf-8?B?NkpNdDhiYjlVd2xmRldxdWNQcHVuSjZaV2J0ZXFQYzdTamRtVnBFcmNEcDlE?=
 =?utf-8?Q?5b8x6Dj+N/nIWwbA=3D?=
X-Exchange-RoutingPolicyChecked: J2UDm7oCTAeO9CTRQKcSsE6Y6jl57oBNOwsUGfEWU0ymJN0IiH/ZCGRH/zoEcyc0fw0KbjblshZnJPq2i9W+v7JalQJ1GM5LQFmDFzucaHIkqBqkSe0uSj9p/nrIRWmBgICEqvSx6HLp6bFnu17+Fnd3WJrd2qhtjPh8hR+FDvr1ar6BXzJoz5LVcexidbhKLBcMrwgCQCFYWNE7m/8NWknZAbiyYUDmLGGelEPT+nCh9aYxsgin97cY16C+sSgkG10ia4FDGsGIVyIdZNC8K4t8FWBEJYHni08N5ALhd/MHGBPwe7g8b26jkW+zji5pjdSQM8uOJPzr3GUD5qEJZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebd4402-bb71-477f-07dc-08df155e2dc2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:23:55.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PF2n/EGT099GpFqSCmXHuYQKNQC+aRd3yTyZgehp7iOzJ4r4SxE+bnXgaGp561fLTvc6cw5jUI2DPXmDGgkcfnPQ7c6HpsjOojWGXIm/yj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7848
X-OriginatorOrg: intel.com

On 9/17/2026 7:00 PM, Wentao Liang wrote:
> When the device found by name is not an i2c_client, the reference taken
> by bus_find_device_by_name() is dropped, but execution continues with
> the stale codec_dev pointer, which is stored in priv->codec_dev and
> dereferenced later in the probe.
> 
> The device is not usable as the codec, so return an error after dropping
> the reference.
> 
> Fixes: d48696b91552 ("ASoC: Intel: bytcr_rt5640: Add support for non ACPI instantiated codec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  sound/soc/intel/boards/bytcr_rt5640.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 40da3eea5fa7..557486c6f28d 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -1764,6 +1764,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
>  			dev_err(dev, "Error '%s' is not an i2c_client\n",
>  				BYT_RT5640_FALLBACK_CODEC_DEV_NAME);
>  			put_device(codec_dev);
> +			return -ENODEV;

I haven't found any 'return -ENODEV' after a failing i2c_verify_client()
check.  Most ignore, one (drivers/hwmon/hwmon.c) ends with -EINVAL.

Given the description of i2c_verify_client() I'd argue -EINVAL is a
better candidate.

A sidetopic, not strongly related to the error code - after analyzing
snd_byt_rt5640_mc_probe() its seems the check could be skipped entirely
if the portion of the function - dependent on codec_dev - is moved to
ASoC e.g.: card->late_probe().


Kind regards,
Czarek
