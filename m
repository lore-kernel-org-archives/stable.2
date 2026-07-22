Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4FF154425
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761272; cv=fail; b=AAL9v6tQHceUkA0un8PeIQt3+/cHhTxFoO3lsU92QXHH9JZoThajy+Qg77BfXE6NaTbNTsl2AoD0fc8U6dZqlK2GbrLE1LQ8XHCQ8a9Ga2pizeEZwNXsiOblbOdzd4/dQ2in4FFqWSoMzYRkmKvqJPZsRSVlg+aBa1pSKj3EIFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761272; c=relaxed/simple;
	bh=AVx3uvmOZ0JfQ7jWa7kQbJIYLA01hMld5sQMSTXuj5k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WWvLdxTQPeFMCKWvikbdUgqZgRrpPBVZbFH6bkH+hbAfX8z4GtAAkxccSI707107mlJTI2qnm5RM0K8//qwJ0rkP2u5RTDjdVcmTIAENrzQDvQyplZSb9zsJ80cJ+ZRGYDnvm3P/jU0yqbxX9rkyxg/lwzP1nFxiI2oVf1HYXE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sz4acudC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sz4acudC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784761270; x=1816297270;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AVx3uvmOZ0JfQ7jWa7kQbJIYLA01hMld5sQMSTXuj5k=;
  b=Sz4acudChlVmqalJ0b2mfu6kiT7/EjVQev8s7endd1UMW3JtifH95z41
   Y7u8E2AMN6Qpx3MguRgNcBoUk52vaBZRTSq83FEyZCBApvGF8Sfsg1ifI
   irRtXKlt7cQavMTWXSDInW1GMZNHlIFKj7Z4kvj17RmISrUO3V2+0MSMq
   5/8Jfjto2ljgxFYUvQXhCoEkpWVYPCE6ls/tlLMeSeBY1cn2WXBFHk7tO
   BuOf/t6wy2f5P4kXeVpTiGrhkLzqFvwPJ3ORCSPPxOSZGUSmIfX67Vdb7
   zdI6SdMWdnG8zHAkMzBrTcVL6LFwMDMpwMtlgp67WCIImV+CS/dY4E3lX
   w==;
X-CSE-ConnectionGUID: GlMxcsvnTr6L62w9nq7DBA==
X-CSE-MsgGUID: OHjNF7PeQEmOmm4BEEhvYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85456134"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="85456134"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 16:01:09 -0700
X-CSE-ConnectionGUID: pRU6Ud8eSJer0JCctmQgnQ==
X-CSE-MsgGUID: DIK6ljmYSjG9MkI4wx+e9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="251919138"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 16:01:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 16:01:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 16:01:08 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 16:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3m1TycuLt5MT8vjYUcPWTCZ53m+oPPSzAIJudAW3Jc0f76IaIpdMMFjgc/e7m2s4BEq081NedL8d2rmHzkJ7XcirwB9BwwQ/39znhK7uAG3wChP+5yTIgLqzF7bxiiZxHaEEcslB4mYioL6Z+v95pu3OAA+WmFq3vUU666NzsM5baNzj2zBPE7c8gtLShnG8ks0a2VEBIHBuTlskrr7uuWK7FoqqADzfvBxfl0tk8QcWzcYnfUl3Kgw4RB/N6tjSHveCWGo7uFe9wFHcWX+Tc+iQBdOPs0tNM/tkDeWrVA+ElEnKyQchkpQGR4vRssxEvp09wkANnGAIsnanMoDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JQKB7wHDdO13NwRnDF/I6O983AUmAExb9xgRMxnpmY=;
 b=k42CcvLEHsx0//HPimqwhwBp3wFQmP/GRipwHnEMKWf7S0b+UVxS8HVAPBSo2zrWvitJFQyWHb8lTbmfI9v5yfS6cRAOHCuGxsR05x4crsvVPSyEU3piY+1B2x69OjExQN2ebuoIHlTB8ZOjL19ARjcaflzM5Ex2k0iAn41RLKpNgdM1cOZr1DlcZWcX0ViJLpjljgOnHKZRP8Ztkz/KaWrPFfLvvu9y6X58Ca2uhEA2yaeC3ZVObkLsFOXKwMhmBnZEECxw2ZEndrnjwIhYDEAltjvCvjOHBcnP7HDGtx+qgzXmIgH7AOBLPwRWkXEN0AOzpIFBVe5PZYZ/7b/dMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7904.namprd11.prod.outlook.com (2603:10b6:8:f8::8) by
 IA0PR11MB8379.namprd11.prod.outlook.com (2603:10b6:208:488::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 23:01:05 +0000
Received: from DS0PR11MB7904.namprd11.prod.outlook.com
 ([fe80::6bec:e86c:e75d:5caa]) by DS0PR11MB7904.namprd11.prod.outlook.com
 ([fe80::6bec:e86c:e75d:5caa%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 23:01:00 +0000
Message-ID: <94a877cc-3d66-4814-85b9-31376944cbf6@intel.com>
Date: Wed, 22 Jul 2026 16:00:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] drm/xe/guc_ads: allocate UM queues in a separate
 UC BO
To: Jia Yao <jia.yao@intel.com>, <intel-xe@lists.freedesktop.org>
CC: Matthew Auld <matthew.auld@intel.com>, <stable@vger.kernel.org>
References: <20260722053410.2767369-1-jia.yao@intel.com>
 <20260722053410.2767369-2-jia.yao@intel.com>
Content-Language: en-US
From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
In-Reply-To: <20260722053410.2767369-2-jia.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::12) To DS0PR11MB7904.namprd11.prod.outlook.com
 (2603:10b6:8:f8::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7904:EE_|IA0PR11MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: 55811529-5545-4133-bd57-08dee845193e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|5023799004|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4ukJdGhPY2eA8EhLKZPKSIqqoDAuv0FFl223YPxDV51mhGdevjsoURIaErat5wcaS95cbeaEieVrSvPW62ghHGBb5TAhIOIg4qiPYF8D3hbmJ1cBClz2YSPWtypEDrQRv7VPCu6676aVZEAUVdvh9zW6S+CqXB+olN/i3/BY8NqXgOUibbtd/0DEPiRIRlqmX4S9CfGZ/fnoMk2udUcFXeMx8lAJ7G0baOQa1zJ0dzeUlvqLI/GcMX+gcHpPvj4/Vvtyof1B3p3nA3h8KOdLftB41BaeqhXqCzqJku/N417qDb/hyP4duBAwI0kWIQU08AjkRVYCbJ7PZ15X0c6eh93S/VxHEQ8Y85KCJnAizF8AjxYfmJ3MCM0gHkujkjyhM8JPcmtBmO9MoM1rkxT0jUfKJkd1s9HpBir8V4zw2t1mMdjBu61VcEdc3oAwaV+fsJsbApRHXQRjnQwG1UlXPfVxKTo80Af4K3wjRj+BtED0hx684KPya0u5yx20bGJMlCtvR93MqdrcTsjyp2p/CdHjY06tU2XFgU/EqHLa1oQA99TGIBsuuJwohXa3OpTLS2Z+amXV/mGYw8c/Xx+M32fYiDCq9Z5zRrpEntfMzDcmdUeil4mCnj3qKcfsAGYlAVRpQPNOvOfuiJGEPXmxjLfJauOC8LYhOF/znigoPWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1Z4Z092Vm41VTVGYmRINHEwM01HWllZWVBiTmFHdlB1WVVLWGE2aGc3c0Yr?=
 =?utf-8?B?Z0JxNENkNHdEOTJiME5kRWJUa1ppczNXcy90ZzBuQUFBWW9uam03OTNhVm5S?=
 =?utf-8?B?b3E4WEl2MUZFVk50MzdOUFROTVV4bnRHbDN0RFRybmJyVXNmWDY0TXNJSGFR?=
 =?utf-8?B?Ti9oUXVMcnc2bDlvaTllQ0lWemRZR1BNQ0hjSHAyV3hGdTBnNk0zTHJ2VWtr?=
 =?utf-8?B?R1ExVm1lV1NHdUV4UkZxTTJ3SzhXV2VHOHNhaDR0emsyQjVVWkNsM2pjcEVZ?=
 =?utf-8?B?RnpSbXpJaXFISWRxL01LZ0x3UjVpL1hMQlhtaHd0OUljZjZpUWNSWXAyVi9M?=
 =?utf-8?B?Wkd0MklCaGtKU2U3RzRxNmk3YjFrMlh2czF3KzFGbm9JUUFSRmpzQStPYmI4?=
 =?utf-8?B?Z1lJYVlRak5BNmRnSW4vdHhqbW5Ja25RMTlDVVV0UzROZlc1UXVjRGdmZlpz?=
 =?utf-8?B?bWRvT1lIY0FrWkNlTXRJemtnelVnemxBbTdJSU1KcVZtTUJzSzZvUkNvWVJu?=
 =?utf-8?B?cUJxUi9rdFRXK3ZpZHRpVUJFTng5WjBpOW9nWllTMVRXQ3BraXdRaVBrUnQx?=
 =?utf-8?B?b1J3SXRFNk0xcnQ1TlBXUXR5MUVWSnd4Y3hwOUJCYXE2R1M5Vm5qMzZSR25w?=
 =?utf-8?B?VUxGTGF2RFQrOGtXVXRQUFUxUWtyUVdKS1J5T1pROHFGWitHbS9mRHpJSXZZ?=
 =?utf-8?B?UEUvaGlrT3ZRZnpTY0ZpQWtEbjNNaVNOMzhwenlOc1RWdmpqZllBZDMzejBQ?=
 =?utf-8?B?K08wNmtvNU1WejVrWVVRSkthNmpsSjRCVllCZzEvTktYdTdLR3lXS3hiYjlR?=
 =?utf-8?B?YWthWDREbDZteE9kRnJmMmxzSDgyblhGTWkrQ0pzMTFuT0VBL3Y5SVZ0QTlE?=
 =?utf-8?B?VWFFNlJOenJlRmZhN0V1UXdPZ2FlYnpJNmhhQnorNWQvamhVRG5tSFJhUnBp?=
 =?utf-8?B?cDY5TEVsckRnVisvZThhSnZrUnRBMEMxWHd0SEpqQ3lPR015VVFDaHNNajQ3?=
 =?utf-8?B?Mlg5Vms4REhZRnFYZXNCN0w4NERwMm9xVFFaeGlONVVRY20ydVJKbHlhMXly?=
 =?utf-8?B?dTdXaURwamk1MUxkMjNpUUtsdTdrSnFrZnhBencwNmt0YXFUVUdSdHlCQTZs?=
 =?utf-8?B?N2MwUXdrV3N4TXl6ZXIxNG42enlleEVJLy9rYUdMR0NDdnJPdzRCRGJZY0ty?=
 =?utf-8?B?UnZ6ZEVZS3RYQ2dDdjljcTJTNG01UXdpYmROMnJoWDRrbUxsTkluczF6Tkl0?=
 =?utf-8?B?VUxDL2tldlZ4bStqbEp1VGkrUWVrYnhQK21BMjBZNE5OR3dPVW1zT2xiTUoy?=
 =?utf-8?B?UU1wOWxNUmc1NWNrQkFQMnphN2lUekhTUE04VHo2OWdSais0VVllNG5pRDVl?=
 =?utf-8?B?R040NW9pQXlUODNVSTYxeHgvQnRtRnJVdUV4NVNZQ1Y2dmtDL2NZaTNmSEdB?=
 =?utf-8?B?Mkl1c1N3WEh6dCtOYWlxbjNDS2lvam1kNk5SN0YwNlprWktScUoyUU42cG0y?=
 =?utf-8?B?NXNuRExHR2NNMFNpc3IwT3RIaEd0c0xPQlFmbzJIelV2UUd5dHl3UEplbjl4?=
 =?utf-8?B?a0VGWVlZMDQ1cUo3ZjgxMFJZVjdibUh3S3B2YzZ2bTNPMmVFYTNYampUd1ZL?=
 =?utf-8?B?QmlZK0M0S1BjYjFRT1c3MkZnRjRIV3NBbktXNWNSN1hjd1ZtcTZiZ1RERjZ0?=
 =?utf-8?B?cVdNdkZPamY5alk0VjVwekdMcXdmZ2NWUTJnSXJZaCszUlIzZENzQUR4OHZL?=
 =?utf-8?B?eVBkcTJZQzg0aG80RHppTTI0emY3TzJqOEo3RDBHandCc2thNkZ0K2lVQ2M5?=
 =?utf-8?B?TVBHd2t4dTBCSzFtSVdrR2ZGTml1UmpxTjUxeElwUFEvMFRGWkNKTHBEbWZo?=
 =?utf-8?B?TFBtVWFHdW9jbFJhaHo5dVVuWmN4enBqamp6VUQxdW9qRER1c0lmd3d4dGJp?=
 =?utf-8?B?NnRFSTNSejFkYlY0TWVwTDJudUNWdDFZcDl1ekNPWTdXTkJ2blF2MGZ6R3RD?=
 =?utf-8?B?RlBHMktoa29YN012ZkN2TzZaQVdJZ2k3R011dDQrWnpNbUpTMnNQaVo3UEpG?=
 =?utf-8?B?K1VQMWliUW9EMzYzbTNUL3o2YTVFV0E0dVRsZkI2UCtRZHU2a3huRGdyOE95?=
 =?utf-8?B?bHpxSUtoOGR2QXE0VHZVSDVxVFE1aFZldExlMlZhRUh6OEp6YUF4T0djbVdV?=
 =?utf-8?B?L2g2Zm43YlFUL09jNkhvMGtnWGxURE0vd2VPR25vOVBvMjVkaWZwcG96cDlt?=
 =?utf-8?B?ZUlxazFQREpUbTlrVXNnQUVpQ1V1ejlGTHhKTFZlbGxWNHpkeGxKVXAxZHFD?=
 =?utf-8?B?Wm1Zc2xwemtlUDRjT3lJakdNR2hBd0NrWnhpZEMyalMrU2NEM3p6dHhzV1lF?=
 =?utf-8?Q?NWmtDxWeS49WxP7A=3D?=
X-Exchange-RoutingPolicyChecked: rRkK/7QqUSqBDLpP4i8N6OvpcfDYvbdgtluNdKc43lDVasxrPamVPbdGolxAXgOPjlqw7Wefc4uRdePIwVnPlqppzGkJdk7m+s22y0iaElKSefEBfFvnbmz1yk+zlnPmtNpdzT4buN47Fi3YiytqZ6170PBlCYA8SBmxvx8ifbaCmzpcEHYAByiu7JWRZVmJcawm659LQ668c+39443auHi6DEXWiYhXWiRqWQ+wdCeOYLiYrAXlogS0T+IzJyZ3l/0JZNXUnA+xBwT5Zm3qE0g+EQMaV3iy83mNDy1WTJwoMT5WYe00ekgAqRL3UcFnwmzS2wXdcff9V4NDP79Q+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 55811529-5545-4133-bd57-08dee845193e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 23:01:00.8467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cRZgvj3QqX0Y8nmnNsaMLPq9V+3A8CS4rPoYYI2bA8kTrfVOzphhX05BmkkLKx9ZZda+yyVRTzNUUmoHwegZNOYKOjKGHVgiDwxdxt+M5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8379
X-OriginatorOrg: intel.com



On 7/21/26 10:34 PM, Jia Yao wrote:
> The HW unit that writes to the UM fault queue is not always coherent
> with the CPU cache. Ensure the UM queue memory is uncached on the CPU
> side so that GuC always reads descriptors from memory rather than a
> stale CPU cache line.
> 
> Allocate the UM queues in a dedicated UC BO (ads->um_queue_bo) instead
> of the main ADS blob. This also prevents xe_guc_ads_populate()'s
> memset from zeroing any fault descriptor written between GDRST and GuC
> restart. On dGFX, VRAM placement gives a well-defined DPA.
> 
> v3: simplify commit message and code comments per reviewer feedback;
>      add Fixes tag and stable Cc
> 
> v2: also fix dGFX (VRAM placement + UC flag); remove now-dead
>      guc_ads_um_queues_size/offset helpers
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_guc_ads.c       | 64 ++++++++++++++++-----------
>   drivers/gpu/drm/xe/xe_guc_ads_types.h |  8 +++-
>   2 files changed, 46 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> index c98454545a85..ec36a5db7fc8 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> @@ -155,16 +155,6 @@ static size_t guc_ads_capture_size(struct xe_guc_ads *ads)
>   	return PAGE_ALIGN(ads->capture_size);
>   }
>   
> -static size_t guc_ads_um_queues_size(struct xe_guc_ads *ads)
> -{
> -	struct xe_device *xe = ads_to_xe(ads);
> -
> -	if (!xe->info.has_usm)
> -		return 0;
> -
> -	return GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX;
> -}
> -
>   static size_t guc_ads_private_data_size(struct xe_guc_ads *ads)
>   {
>   	return PAGE_ALIGN(ads_to_guc(ads)->fw.private_data_size);
> @@ -205,22 +195,12 @@ static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
>   	return PAGE_ALIGN(offset);
>   }
>   
> -static size_t guc_ads_um_queues_offset(struct xe_guc_ads *ads)
> -{
> -	u32 offset;
> -
> -	offset = guc_ads_capture_offset(ads) +
> -		 guc_ads_capture_size(ads);
> -
> -	return PAGE_ALIGN(offset);
> -}
> -
>   static size_t guc_ads_private_data_offset(struct xe_guc_ads *ads)
>   {
>   	size_t offset;
>   
> -	offset = guc_ads_um_queues_offset(ads) +
> -		guc_ads_um_queues_size(ads);
> +	offset = guc_ads_capture_offset(ads) +
> +		 guc_ads_capture_size(ads);
>   
>   	return PAGE_ALIGN(offset);
>   }
> @@ -409,6 +389,30 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
>   
>   	ads->bo = bo;
>   
> +	/*
> +	 * The HW unit that writes to the UM fault queue is not coherent with
> +	 * the CPU cache.  Use a dedicated UC BO to ensure GuC always reads
> +	 * descriptors from memory rather than a stale CPU cache line.  A
> +	 * separate BO also prevents xe_guc_ads_populate()'s memset from
> +	 * zeroing descriptors written between GDRST and GuC restart.  On
> +	 * dGFX, VRAM gives a well-defined DPA.
> +	 */
> +	if (xe->info.has_usm) {
> +		u32 um_flags = XE_BO_FLAG_GGTT |
> +			       XE_BO_FLAG_GGTT_INVALIDATE |
> +			       XE_BO_FLAG_PINNED_NORESTORE |
> +			       XE_BO_FLAG_NEEDS_UC |
> +			       XE_BO_FLAG_VRAM_IF_DGFX(tile);
> +
> +		bo = xe_managed_bo_create_pin_map(xe, tile,
> +					  GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX,
> +					  um_flags);
> +		if (IS_ERR(bo))
> +			return PTR_ERR(bo);
> +
> +		ads->um_queue_bo = bo;
> +	}
> +
>   	return 0;
>   }
>   ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
> @@ -820,9 +824,9 @@ static void guc_mmio_reg_state_init(struct xe_guc_ads *ads)
>   
>   static void guc_um_init_params(struct xe_guc_ads *ads)
>   {
> -	u32 um_queue_offset = guc_ads_um_queues_offset(ads);
>   	struct xe_guc *guc = ads_to_guc(ads);
>   	struct xe_device *xe = ads_to_xe(ads);
> +	struct xe_bo *um_bo = ads->um_queue_bo;
>   	u64 base_dpa;
>   	u32 base_ggtt;
>   	bool with_dpa;
> @@ -830,8 +834,14 @@ static void guc_um_init_params(struct xe_guc_ads *ads)
>   
>   	with_dpa = !xe_guc_using_main_gamctrl_queues(guc);
>   
> -	base_ggtt = xe_bo_ggtt_addr(ads->bo) + um_queue_offset;
> -	base_dpa = xe_bo_main_addr(ads->bo, PAGE_SIZE) + um_queue_offset;
> +	if (um_bo) {
> +		/* All USM platforms: UM queues in dedicated um_queue_bo */
> +		base_ggtt = xe_bo_ggtt_addr(um_bo);
> +		base_dpa = xe_bo_main_addr(um_bo, PAGE_SIZE);
> +	} else {
> +		/* Platform does not support USM: no UM queues, nothing to do */
> +		return;
> +	}
>   
>   	for (i = 0; i < GUC_UM_HW_QUEUE_MAX; ++i) {
>   		/*
> @@ -912,6 +922,10 @@ void xe_guc_ads_populate(struct xe_guc_ads *ads)
>   	xe_gt_assert(gt, ads->bo);
>   
>   	xe_map_memset(ads_to_xe(ads), ads_to_map(ads), 0, 0, xe_bo_size(ads->bo));
> +	/*
> +	 * um_queue_bo is not zeroed here. GuC resets head/tail via MMIO on
> +	 * every restart so stale ring contents are never consumed.
> +	 */
>   	guc_policies_init(ads);
>   	fill_engine_enable_masks(gt, &info_map);
>   	guc_mmio_reg_state_init(ads);
> diff --git a/drivers/gpu/drm/xe/xe_guc_ads_types.h b/drivers/gpu/drm/xe/xe_guc_ads_types.h
> index 48a8e092023f..a63ef000dc8a 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ads_types.h
> +++ b/drivers/gpu/drm/xe/xe_guc_ads_types.h
> @@ -14,8 +14,14 @@ struct xe_bo;
>    * struct xe_guc_ads - GuC additional data structures (ADS)
>    */
>   struct xe_guc_ads {
> -	/** @bo: Xe BO for GuC ads blob */
> +	/** @bo: Xe BO for GuC ads blob (WB cached) */
>   	struct xe_bo *bo;
> +	/**
> +	 * @um_queue_bo: Dedicated UC BO for the HW fault ring (UM queues).
> +	 * The HW unit writing to this ring is not coherent with the CPU cache;
> +	 * UC ensures GuC reads descriptors from memory. NULL if no USM support.
> +	 */
> +	struct xe_bo *um_queue_bo;
>   	/** @golden_lrc_size: golden LRC size */
>   	size_t golden_lrc_size;
>   	/** @regset_size: size of register set passed to GuC for save/restore */

Hi Jia,

Regarding the issue mentioned in the cover letter that this patch aims 
to fix, wouldn't it be resolved by creating a separate um_queue_bo by 
adding XE_BO_FLAG_NEEDS_UC to the (XE_BO_FLAG_SYSTEM | XE_BO_FLAG_GGTT | 
XE_BO_FLAG_GGTT_INVALIDATE | XE_BO_FLAG_PINNED_NORESTORE) flags used in 
the existing code when generating ads->bo? If so, as Matthew Auld 
mentioned, wouldn't it be better to apply this patch as one that creates 
an Uncached buffer for um_queue_bo, and then split it into a separate 
patch that uses XE_BO_FLAG_VRAM_IF_DGFX(tile) instead of 
XE_BO_FLAG_SYSTEM if there is a performance improvement on the dGPU?

And please also update the description section titled "Layout of the ADS 
blob allocated for the GuC" in the [drivers/gpu/drm/xe/xe_guc_ads.c] file.

G.G.
