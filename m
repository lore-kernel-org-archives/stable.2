Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793179697;
	b=w600mJo0v2gmdHpPbgEo6ToK9w1heVplATAwiK/0QAUIFFiVoj3BAZULkc3A4rruUJ9s
	 pa5ha0y9JHXmzw6yZFEOY0NTdD3q+R0aW9qKmM6oKXAOTHyJ0V3ZpGW9AsMktJliTU3op
	 M93FlSayFsfQappbgUo6jd9YKC6vm5Z+V9TyhETOmY4ubsLaytgxpRJgr9YQC6NxDdB0s
	 vkMwTFQCjXW424QwY7J3fa/qumxgDVNekfkU7cM3hMhSuuW2uz1v9MHOXziTFN60dbYXB
	 6+PC5BHPAJ0cyCtsJwD1M40D01fGvHaWK6trl/CmOohn+JXmFXcDZRL0Fv0nivw47qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179697;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=153gGV4yOr55Pe3ROGb+LmOqfpu0J0WJdJFVBjToX3g=;
	b=iyfXx932J/w/C+pq+o6TWxLd02l2bVQcTeTHH9cTRgRcpNiVctj7IPXPgZfnqvZZN+BB
	 vws8j0+mK2CGUQGQHesKsdm2d6mkq8KNx9SRhSFegyJ5xYQk62xbDWqEE9raTAgk5fp+L
	 PfqJuYqXTZGfTRGbzqB9fqMFrH7qykRmqx/6KLrYuOGHvuHXBDPzSX9dkE3kcryVT2bIg
	 1t57hHx1ODHlQCDxzwGjZxfu/9LN/VQXFTNbZ7wXjUlK/PVF6vU4JHjfRMym40n26fR3u
	 bq2oroN6HklSZHSGR/QCeN3gf68ln81cNiba/sGzd8hWjySE4ELPqPuIgZ5lTNXxhUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gji7aG5y;
	arc=fail smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC91606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BC91606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gji7aG5y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793179696; x=1824715696;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uvXnaB0+750JF6B5/HlPm+Evu55UKmeE9YvFYQXZ3bI=;
  b=gji7aG5ySCecg77xfHsE34ytb4m4khP9MB3FAReIAp9w78CR1eFS3YyU
   3AsZcG11USbJ+7RNhm70EGRX3rqGtmH1nnskmu0OG/BGOl1d05ctV/KAg
   a28F14GWM3BUtRyd1erll6Xa09BNwaDL80DCGUsfErSxltNQ7eMqYeNH8
   9QqD+VzjgeLgiHrCi9bUfZOXdyPW1sX+SMdnplmEW+G+BjZYiZ89Qu3bS
   QKQc49kdn4nFSt3HekJ7UL9m5Z+872sXIU8Vmu6uhnCjKif454guOFNiN
   kaGSThE44bMXZrvVd2jLogXUIv84K5V1mdvp5hkjv8lS0wlLnxtJbHkwc
   g==;
X-CSE-ConnectionGUID: xNkPGCb8RmKhLZud4gyprg==
X-CSE-MsgGUID: QAxd/aqaRC2M991/drY4OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1787833"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1787833"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 02:28:15 -0700
X-CSE-ConnectionGUID: DxEhxnCWQUi4UozZAjj2uA==
X-CSE-MsgGUID: ibIO3g7+Sh2SmQuUhPF54g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5316080"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 02:28:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 02:28:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 02:28:13 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 02:28:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeoWk+BClWNF0O5hYaG1F/Qj+UfLaTPi67uss1/VspkZtGvb5Eezs5sqDAXEJ/QmVmNNMnUHrA0u3n39yWOPyPBEOQg4pmqDZ14GZIL+tfYRj8+jytr8lrpQUdGmcVRbP5fNvj8wQM3/YrVZfHQVI9e8NF9oW6M7ins698+DoBzu8eDSDGa5M4X4GAfKfwYPq34GghY0UscsgtgRl0pZR6jVBH2IVf9yvTy3We8MVmJqDDvOIpTlVhnLgAIdKiSVSXdj+tPRpiMqpkW6GAUP49P7CP8HLMvZXAKH/JQemhxDGpZUZC1m2kjPyz+J1UCwL+Nhg/8ynjEQ/2/PHkcNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=153gGV4yOr55Pe3ROGb+LmOqfpu0J0WJdJFVBjToX3g=;
 b=ZmLuYenFJAnLl30pzPl0gGW+pFP4RJ1aFmOIQ/psblpm1gYwDNsYxFoSJVdPYJQmiddt9ilzhccB/K3b5BPK6sVPSH863LuOPukLXzhU/irnvHEZPfI3EuaFKkLQo2zdGggrmghAXfxBYpGLifCVHlBjqhGVjgtCd9VIFJI73O91K0ed0LNI/1pL8u0nE1AZ1Cu6ypLYHj3X8TmMW+sRUYw11R6sMl1v1Hw3xdJg7knR3AJJZqjKUEZWHnau6j9KvzkDklRZ0aRm5E8cKxu5j8gfx7M//3L7AvsQppR8pDAU9Z2JorDQX5FReGEfs3cbSaD0ixU+QNX4Ek1NqM9kOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21)
 by PHXPR11MB9661.namprd11.prod.outlook.com (2603:10b6:510:3cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 09:28:12 +0000
Received: from SA2PR11MB5035.namprd11.prod.outlook.com
 ([fe80::9418:cd60:8ece:69c3]) by SA2PR11MB5035.namprd11.prod.outlook.com
 ([fe80::9418:cd60:8ece:69c3%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 09:28:11 +0000
Message-ID: <48da0157-6fb3-4e93-a43c-0443c5bcbbb2@intel.com>
Date: Wed, 28 Oct 2026 14:58:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
To: "Srinivas, Vidya" <vidya.srinivas@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Shankar, Uma"
	<uma.shankar@intel.com>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>, "Lin, Charlton" <charlton.lin@intel.com>
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-3-vidya.srinivas@intel.com>
 <94c3c16c-50ce-444c-985f-0fc0fb009242@intel.com>
 <PH7PR11MB82526C4A1D72F22D44331A7B896F2@PH7PR11MB8252.namprd11.prod.outlook.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <PH7PR11MB82526C4A1D72F22D44331A7B896F2@PH7PR11MB8252.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::13) To SA2PR11MB5035.namprd11.prod.outlook.com
 (2603:10b6:806:116::21)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB5035:EE_|PHXPR11MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: 9103a44f-f1ad-4e5f-6610-08df34d5c8e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|4143699003|56012099006|261009223027099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: r9JuyL3VrtR2BidQdvohtftzAOVbErBLVxY7txn0NCo88cDzCV1EODDFhMPFcK0sCJX3d3juG9coF4lQYHvtslz9m69FXTUPrPL1wHW8Ebyc5RnZR/tIXDrBOB3y1T/rVTJSzWX9XRjLCpIx4brIplEK0PquXvl7ZdERwx7ukOMcvLfomEMKEUtTXlu7o/pMKL9cPU5+3cTGgI9i9ae5ZxYks7LvOfv/lF2PpH78lH9yKXbWliiIEP92o0rkX7kVYzGwMJ17CFTSaR7iypvi2KK1rQZXWAiTePqW67Z9psSK4YBJ6OKJxdR2vrF1ma2gIqcOCgqkPzw7WukuW/YsXmrB3KeejQwZOzsOw/WMeltX3Inwb0TpXdaTH4EqxqN7R9E0WHVslC/50K/r0PctKeOhy5xxNYjm+7Vz3HvUHxupOJntwKk1oANRVNmwXo5EFQwW1PaB4k/GoCUgL+SrPBmiODfCE4B9JYAbnw3bkm991x0f0AAozsEaFtBYCHfinFvqinxmpHeloKaCEE5XS88MF3ajQLseUKYNUlFwwQuD3mYA+3U33Sn0H1htyBrDKkxU620Pej0YTS3lJn5JkOqiJ8LosxfK47c/nS+N0CtDZ6Pbk15PlOekDs0scuFfJS1D5LUXObpuRyMVXrzTDYdbj2LYOjd0LXjgiQfGWMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5035.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0pZTGt1MFBZc09RTFBxSzUzcEVWR1dCSy9rL21rdHdhcVRuUVNSOHNlUGRY?=
 =?utf-8?B?TitaeHhLdzhKQWJpY1lCTGFHOWJEU2FvWFVOd3BHamRuWFUxRW8rWjBZOUFL?=
 =?utf-8?B?RUhUYndYZnIxdVQvTHMxS3VFY1BKOXRuNXFiMStqUSs4WUtJV3Z0T3E5aVVI?=
 =?utf-8?B?OVgyTjVtWE15OWk0NHNBb2MvZkwwbnM2QUlQcFRMa1pGT1FBODU1N21aRk5y?=
 =?utf-8?B?NmtRL2tFb3E4cTFJS0xyL0U1SGVTelozeFU1MWlmTXZZbkxpdHIyMkpzM2ww?=
 =?utf-8?B?T2lJMDdsY0hTUXZ6L0NIKytnK1VXeG42bFZndVQ5ZjBna2RZSlR1Z3poYzZI?=
 =?utf-8?B?RS80ZURzQjhuT1pwVkZabXZZQjcwUWIzUzIvempyZzZieTN1ZE1yV3BCMU0y?=
 =?utf-8?B?WWVtWnZ5TGl2b3FGbGpZWXFVTkpzUjFtN0UwdUZ4Q1Zid0lVdnZjNS9NNnFN?=
 =?utf-8?B?OTgxTDVtMVlQbXlLazhLZTBVamF1UE5lUEswVUk3UkxjbXh4amNmTkJGYnNt?=
 =?utf-8?B?NkVNZDFaZjd3UWVkU2txTnJtUElMRkJTd1lTOUtlbVFUUjRuU3gxKzFZS0FL?=
 =?utf-8?B?YmwybS9iZEE2c2NxaWpqNWdvUlhkMjNDcTIzcGdNWDBOeDZRSDFLcUFwRGV3?=
 =?utf-8?B?UjhZc24rb3N0MEI3VnVvbkNLUUl2RG9Hb0NaWEEyb2x6Zzh1bVAzODUwSHlF?=
 =?utf-8?B?Y0tmVmtqbEVPVnpNRlJ5L1JZS1NUekNWUXkySEdIcXUvdHd2OVI2cGM2NEwr?=
 =?utf-8?B?RGlhSTJzVGs4VFF2WW5XZUlRQ2ZUeS9qZDdiUjFDZ3BjcElLUG90R2trYkhH?=
 =?utf-8?B?RkVBTFFCVmVOb2ZMSE0yU3pjT250TmRYcjVUd2t5WExkVXlPT1BvcU80WnFx?=
 =?utf-8?B?UFkyZWJRS2VIUUdmWVM2S2ZWZzFQWnYxbEZtMTZaQkVjekROMEVGZmQrbENN?=
 =?utf-8?B?SUVIYUlJME5XNnNrMkErTVdSME8xUTMxeW5zOEErZGlLdmZRKzVNN2lwUUp3?=
 =?utf-8?B?OTdpYnNabG9KaW52WEdXMzJjYXd2R3BPTkdaZE96eDBvNjdwcFpCVENHTUdP?=
 =?utf-8?B?cFV4Nis5bi9ZRjNxUUkzL2t5ZGxZWnJoeXZldmFyZlJLOXdSQytzNisrSjlM?=
 =?utf-8?B?bUt2ZGFtaFl3S2pTNVdJdUthMHFhNFhXZmpHbU9LTjJCcGZZNVRLQ3dkS1M1?=
 =?utf-8?B?cDV3Wk55YUt2RFUzbnF5Vkw5SzdvbnFDWTRlVEZtY1JaendaTTdtNVBhY3VM?=
 =?utf-8?B?WHJncE11WFpzS1h2ZGlzaFpvR0pYaHVRSnlXQjhhMDh4MnpvTDEyMWsvQWNo?=
 =?utf-8?B?TVJDZGF1NXNuZExoWm5keVVBbXZVakVNL1V0ei9RN2QzTmlYVlovblVwdTdC?=
 =?utf-8?B?SnA1eGNtMFd4VXhvbXVDVlZsVW9IVGtpcWgzd1hjVlNxaG5YRFJ3MzJiNUVW?=
 =?utf-8?B?OUFCL01sTmhVSjZsd2dWYzl2bStRV3UrRTB0TCtNT3JLdHM3c0tpWDFLTEwx?=
 =?utf-8?B?VnNpWUFCWFdra0dwbEFuQldEbXgvZkRGM0lObTRIdm4rdWIvN0hwUitRUDFh?=
 =?utf-8?B?aEs5RS8wcWhJTlN0NDNzbXdRQTJUL3M0RFZRMTVxSEYwSS8zZTZlMS96VkFG?=
 =?utf-8?B?R0V2UlRIVVRPbWF4N0s4LzBFalFSUUo5aDA1OTdtdDlwTVlMenZVSjZFMk8v?=
 =?utf-8?B?OVN2SXppVWtYUDg1SGhIUVR5eGFxaVd3OW5XN01OaDNHZUhqRlZ6cjkyalZS?=
 =?utf-8?B?bzZMY3F6TFlQcGo4blEyRTVJMVBSYUM5Z053d2cwSlRiblZ0aWtaVWRnUkJD?=
 =?utf-8?B?TGhNeG0wSS9QZGJJVVJJZ0RDSGJoTC95dzc3ekhOVlMzTkRPbWpXMm81VmRG?=
 =?utf-8?B?dUd0WDZnOXRyeUZyU2pVUFFGVURESnE1djFNMGpBd253WFRJS1EybXNWZUdV?=
 =?utf-8?B?cFN2clhFL2pMcUR0Q0h3R0V2dVlvTkRXUFlPUnVhSkNCUTFxZzFuK2pxUVps?=
 =?utf-8?B?WmZaUUtOZFpnUG84TVVUYzZmelZudHlZdUQyWnpmU2ovRWcwU3RpUE5hMVpE?=
 =?utf-8?B?TUpsVmsyUXN3TGEvSSs4Smt5K1pzSzV3Vis4bFN6N1UwWThWbHl5MURodkI4?=
 =?utf-8?B?cUNLNzJmT1BmQlUwSHRQRnFZRUZQbnF0a21xaGpTcmJsRVNXSWdObWxySysy?=
 =?utf-8?B?VDl5Q0tqR2tod0d0cDliM0FjU0tLZWhPV0dkWDl3bHMyLzlwRVRpaUVuT1J4?=
 =?utf-8?B?UUdETjZ1alF0YWR2dWIyV0lZcHIwVGFHRWpMSjF4ME1JdzVCUTEyekZ3UXlq?=
 =?utf-8?B?RmZGVzNuSlRLckpqa2JlSHBOeEN6M3UyOWZmdmRxelpjWktaM2Jrd0QrTFZh?=
 =?utf-8?Q?sGKmy1YXVe5m2gP4=3D?=
X-Exchange-RoutingPolicyChecked: y405Qg/jJh57QtjfjN/TuPwv5xMO/E+IYLJ0JczfQr1wyUF4YRP3tNGmP/wCstu764dZl8NfbDvZLX16fqdzYj1iRFks2ouh3nOI/Yrmgc3uBUGDqasznB4KHH6HewqWRmKafkaKK4BceRBHfzjbmpyJxZnGjdzKFsPW5K9jr9C5+Cu6Wwt6TM4N1osGsnCMKl5EV3fkFiUSrw562MTNmhdQk+a8xqyg4EfPc6D8puxp8IGIR1ViTxF2Q/FsUgKPVrIn045BnqPa+RrK7DHrc7CbwlDRfabvH/WXVZ86q1noL8yel6QOfKmR7gJxNHnbNNSTiYj691JEWeZYLpS7NQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9103a44f-f1ad-4e5f-6610-08df34d5c8e7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5035.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:28:11.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38tfI9pPZY2t7KGZc70hbkqUSM8LylrMI+f8nwVjm9pHXhD1L98AxSWntArXaQkhQpRNvrcHZd1QszyTBdiCwMzR/uTS1JLLywoX1SUsTaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9661
X-OriginatorOrg: intel.com



On 10/28/2026 2:27 PM, Srinivas, Vidya wrote:
> 
> 
>> -----Original Message-----
>> From: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
>> Sent: 28 October 2026 14:08
>> To: Srinivas, Vidya <vidya.srinivas@intel.com>; intel-gfx@lists.freedesktop.org
>> Cc: intel-xe@lists.freedesktop.org; stable@vger.kernel.org; Shankar, Uma
>> <uma.shankar@intel.com>; jani.nikula@linux.intel.com; Lin, Charlton
>> <charlton.lin@intel.com>
>> Subject: Re: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
>>
>>
>>
>> On 10/28/2026 12:34 PM, Vidya Srinivas wrote:
>>> Pipe joining is not supported in the WCL display configuration.
>>> Report no joiner support on WCL so that modes which would require
>>> joining are rejected, matching the 4k 60Hz maximum resolution
>>> documented for the platform.
>>>
>>> v2: Rebase onto latest upstream
>>> v3: Fix up the commit message
>>> v4: Split the scaler and joiner changes into separate patches (Jani)
>>>
>>> Bspec: 74286
>>> Cc: stable@vger.kernel.org
>>
>> Won't we need a Fixes tag to tell where this change need to go to?
> 
> Hello Chaitanya,
> 
> Thank you. Yes, I did check checkpatch gave the same warning but I couldn’t find the exact patch to call out the fixes
> There are patches like Extend the max dotclock limit to WCL, Restrict max source rate for WCL to HBR3,
> drm/i915/wcl: Add display device info, Add power well mapping for WCL etc.
> git log shows under merge tag the "Add support for Wildcat Lake (WCL) display, version 30.02"
> So, could not find the patch for which I could mention fixes.

Fixes: 632633d095b6 ("drm/i915/wcl: Add display device info")

Should be sufficient.

> 
> Regards
> Vidya
> 
>>
>>> Suggested-by: Charlton Lin <charlton.lin@intel.com>
>>> Reviewed-by: Uma Shankar <uma.shankar@intel.com>
>>> Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
>>> ---
>>>    drivers/gpu/drm/i915/display/intel_dp.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
>>> b/drivers/gpu/drm/i915/display/intel_dp.c
>>> index 00e02e019d25..ef164a797618 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
>>> @@ -485,9 +485,9 @@ bool intel_dp_has_joiner(struct intel_dp *intel_dp)
>>>    			return false;
>>>    	}
>>>
>>> -	return DISPLAY_VER(display) >= 12 ||
>>> +	return ((DISPLAY_VER(display) >= 12 && DISPLAY_VERx100(display) !=
>>> +3002) ||
>>>    		(DISPLAY_VER(display) == 11 &&
>>> -		 encoder->port != PORT_A);
>>> +		 encoder->port != PORT_A));
>>>    }
>>>
>>>    static int dg2_max_source_rate(struct intel_dp *intel_dp)
> 

