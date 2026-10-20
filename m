Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792520470;
	b=kNCP5v6bZInokTseiEPmHfyw280ARwK2x0RIb+H9F82BkClFtalY2zx5iwS0kpMUqG3X
	 GtcqKIhah/UkOUA3ZJZyaKqIb4/2S5ffaA0nsQ3BnPEk6hOs2/xvm/i6JkW/HaFufDTyO
	 3XYIP9uAkr0kY6KAJsWzYPFz15d1dHQSwiR9LJrf141QZJscCkzNffJpIJbefko54trb2
	 CGzJ2HAn4Yav70FZqk45mq+CR93kJNMKPb8bJN+HDZ3/X8aD3FICcNqxrVF4T/xAuTGhg
	 tPJZaNdqowv1XZYQhyER7eMj+C2O7w5JaVl8uuc18YLoeEunMwj5HUKbZ6uYMGwS4Cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520470;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:From:Subject:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=Y7G05QtYCoSWsph2hoGEtGFGl4RNrtVuEwXmOeJwSPY=;
	b=RUFDDILoJ9HG3Yg1wJbvhpyn7ehVdIR4cw4fJaPrHMpwy3FHzJx1bFaCM2rMPXNC6bYS
	 AbnB16lqhJONPtxtMl2SavyH3MVvPjDvT2hCFBBU7cQcsZ4VTekYVAk4Dn5cfOOLdkFU8
	 wy9vFyFPa7+rdXewEvAH2D7n4lLrn4O6H+qMi/ib5YOTIgdCFn3XmhZPAaZNLH9skmU+4
	 MUPluJG3FBOamHeyTbBjafCY5tbMUnJv+suHnmFP8UIXUY38V4HLAcVsFddcnYq123YgD
	 Sm7x1+qmdNWP2kmEzQnwfG/BTydiJecFDoFpKBDR3zd7cXEhe70ypEUN75VSyjLVVSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rs0ythED;
	arc=fail smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D7606A319;
	Tue, 20 Oct 2026 18:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 250D7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rs0ythED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792520469; x=1824056469;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ewKBUFNMMWLueFo9jGw0Uv/NjXtrIYdLEw6QItCeNvQ=;
  b=Rs0ythEDMdEFGabmufsTdq5XJOjFbIrfsJDzqG869MWTcIxfwIu+eIdv
   cbrsEQanmViBDPmAhD/YsrxWja/WPOdlwitAgvYiqfLOGa/QuQ4fb8z3K
   JLzd7Mk+vScjF9isBrIJ8G/TYgH5K6Ag8qNsgu61uAgoA8jx9sRQ5sgDu
   CIeRR2DcgXQPrF5Up5AEDbQGcbA4E36LQC975e1OAFUY65QcsBoaWf7Ub
   +EtcMMvWWbgno7WlsQgb4NNC6PtXoKH2zmmidgNr6VYchWstbm5LyIw6c
   ww/JVFiWlRdCFxMWZpdI1Pd99UfkD+sPtAV9LdHC4G6XPUWBxRJdxEhLL
   Q==;
X-CSE-ConnectionGUID: hi3B0E9zT8WcjZY/Snk8xw==
X-CSE-MsgGUID: fXezKyd3TCiCM03qAD+Edw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1107124"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1107124"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:21:08 -0700
X-CSE-ConnectionGUID: Jxl83btiRp+bweKtQDkc3g==
X-CSE-MsgGUID: 4lWUAuOwRueRd1qltnUtCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4680085"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:21:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 11:21:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 11:21:06 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 11:21:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NF1DxVyl/OL6YoWDHu9S0fDyT37sOVx0ZrpLXHsBJ+MOX5Uxa5Mm4H/Z9k4EYyTv75YDd9/uUTcoGgYhPOVYlhZDwRr16Wyh3w2in5xifZl+248PXZJ8AZdWuYNr+Sfx/4F9n2WuANGmu08VWy1kOB1ijhfRA4XfKKXMhG2BD5o53rBPpjTe1ip1ohKO7HDFcGBX7DrwwXNctjhVAxu8ZuLZKIORD9msLON0R3yoHa/fu/OnIYdfGVTIjLt7U1rCsCgm1/yQ4TaHuRFkmJlK6gly3OKWUc6qCnpuQ0V3ao4qNB09cfvDQEL44uZeaJk10OuUhhh8b+S4r0GZZGZTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7G05QtYCoSWsph2hoGEtGFGl4RNrtVuEwXmOeJwSPY=;
 b=h4zipaE6sEaZzb6O+d99E8v49v54g7bZOISD6DQlmZ9OPJr6rIhnkeogTOo9usdimz2dqu5dD9X+Yc+t3WIkQv9wEf0z9PiSO/fjmMAzUJGmFJKJ9lWjer/iTsuOd2ozkUlIjUR3NBMHIWshVctL110q6n1OVx3/2Ao/4xh23xCfyfdfGdEeO6yW1W9NjvRiF600uhk/iQxWX4hrWzu06fp1vN/+Cy2KzCyl0qSe4fmXEWmEf3WQt/YSmlWzyb4ChodDsiUgACJ2TTcRHiSa/v+7BkOClas6SUgkaqbqH4/rKSyrLqHX/XLYr41Ruq6UCSse6pNy5YIAkmURAcdaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SA3PR11MB831931.namprd11.prod.outlook.com (2603:10b6:806:589::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 18:21:04 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0496.015; Tue, 20 Oct 2026
 18:21:04 +0000
Message-ID: <bb50436d-8af6-4420-b626-97f262f6759d@intel.com>
Date: Tue, 20 Oct 2026 11:21:02 -0700
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v2 1/2] x86/fpu: Fix memory leak with dynamic fpstate and
 exec()
To: Guixiong Wei <weiguixiong@bytedance.com>
CC: <x86@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <cover.1791428412.git.weiguixiong@bytedance.com>
 <b9277cad5e1098d3e60d5c0f025c58061df10af0.1791428412.git.weiguixiong@bytedance.com>
 <d28dc497-a74b-4c52-bb6c-8b9010f9ee2d@intel.com>
 <89727492-b1d1-4f14-955a-0673ebaee753@intel.com>
 <451788d5e97cba38274e663d2b7952c593e959be.299fa9aa.210c.4b1f.9ab7.7acb67f42a19@bytedance.com>
Content-Language: en-US
In-Reply-To: <451788d5e97cba38274e663d2b7952c593e959be.299fa9aa.210c.4b1f.9ab7.7acb67f42a19@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::32) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SA3PR11MB831931:EE_
X-MS-Office365-Filtering-Correlation-Id: aa26f1c3-c90f-46b2-632e-08df2ed6e731
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MTAfsT2moqpzyV5lm61RBfksnUPoV2jnT1IQ4HH91Vv+raXGnobWByt2pD0RrLy60yrWFaG/eBtQi+sybZCsUkbMtMG9VmlZtUH9j6oN2YJEvoKhUh9stx/ZSj0KYrlnY2oejbO/Uwoa9CX+5p+W7eeYF4nzd0adWcooixtsRarOlMXWeXuceG8xsIDAnP4spFUwKcmLTcknkescSa7O91PxFpdsFQtzlpRAiSsi517wpEempuL9SKxDtab+J16uQxDSf0zRmwZOnYlDV1A16psccqUWZrFHakFqhLOO9yxqEN+M+2iWjD0aI65huCvAvnorcSiULl6G+EgtVv5G1B4ifSkpQZViO5fOgisdPMotQDhcVC8YgyQma3rZqj15c7UnllamVg3YqhiPujy0eeeJvX9nFss2xRLx5NW7pSh/VOY42dK80TUKqq5khZmrXQNvrkIJ/bwZejhA3CVsj+o/En8IeGoZV/qIDVBEn9B/sYCHD9y/M0hwyLfr08FwqjNDgyBbQZBc/fMlSX6BY7Sjnunpz50jNaJu9O0jGB4qWDcazyzgkiLULnElMHblWac72kw497g+/VrOAtOdzIfisRb01oB1fgmstmnYLz+Scj8hNFavbdt00KOH+l5vBydSzTAsePGmtJJeBQkoPh7pMAqu6uSp1DQQqfrjb1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUdYcnFPRDRydm43NWNCYkZlZmFSbUlhVERlZC9nMjBDS3VEcTdSallzQUV4?=
 =?utf-8?B?elgrdmhCZGZZaTZtcllTR0JMM0RaMVQ1eW5uSmk3ZXNuUCtFRTlCeGJlMHZx?=
 =?utf-8?B?dWdjVEF2clNQajBhWUNEQlAwVjU2emdlbzJQTXEvczU5S2lXMjA3UnF2SXJI?=
 =?utf-8?B?U2srejd5VDZ1SjI3dGZaSWthd2FoNkJBSGlTN1MxWEVYOEY3MlZ3QTd0NXVI?=
 =?utf-8?B?MlViUTBmM21CZGs1ME5qUmRoTk4rT2xJTExzWjQ5VCtOMWNheUFOd0JtSmwv?=
 =?utf-8?B?dDhtMUptaW1PTFZBNGpIRnRDaFVMdkRmYmprN0JKY0tOUGVJMFdVa2xrazkv?=
 =?utf-8?B?RzNORDVITko1Um00Q1Blb0NsejJNQ1RScXRQU1JzY3Roa3lYaGxLMG13UVNK?=
 =?utf-8?B?V0xOYzR4UDJudGNuTjY3YW9UNTdWWTVYbVJ1aHlJWFZUQldxS3VlRFM1YXVr?=
 =?utf-8?B?dUJ3Vk14NHhLZ2gzNWx2SXhpTjEvVng5UVhqY2FQajBCVm9melhwQnpiM2FE?=
 =?utf-8?B?ek01RzNyTWRHQUJQWDhoUUR5RW5qbW5oSENDUDk2blU4L2lrNzNDNUtYZzRU?=
 =?utf-8?B?dWEzRTcvYURnWnpZVEFjNWU5TUVacDd6d2ZHWFAvalRjbEdSTENJcTh0Rytr?=
 =?utf-8?B?QXdudjFDbGZFcUp1Q1JxSCs1c1RaRWY2OHE2R21zaVQ1cEJqVnluTUZxVU5y?=
 =?utf-8?B?SmFsc2g0dXFtSkFVOUp1NFhUZFV4cGo1VjVDdlRRZmtiVnA3ejlVcDBoSkI5?=
 =?utf-8?B?V0NXYzN5R3VKRVA5RlBSY25oVERjS2Qxa2Vyc0Q4RHZyUllKLzlKZ250eUsr?=
 =?utf-8?B?eXBZWmd5K2FlTEpDdnpobW5UL1BmS0VBNHJhdW9OS1BpS2M4WlRza3Zyb1Av?=
 =?utf-8?B?Sk9QMGd2UEdkQ05WaFE3cmFsN1MzUEUwdTRwaFdYaGpGZi9ueHF2Yk1hbWpI?=
 =?utf-8?B?czI0WTd0c3NtaDN1WnFGUHFVMUVmV1l0ZnJiVHg5VERxNWpzbjFRR2NWVW1y?=
 =?utf-8?B?YXo5QkNpZ0ttVkFrMHo5U05iZTBWWGFtc1djdDZuSzgwTWhkQlpnRmpranFK?=
 =?utf-8?B?dW5DaUtrMXNTSkV1UHBZR0NvWlo3UFBjVVNiV1VRNEE2NGtQUHorc1NkWVFk?=
 =?utf-8?B?aW9JcmVnSHB5cC9jcTNZbzJXMUlKSlMwOHNhQ1BBdmVxZjNoV1hVUUNNSjE4?=
 =?utf-8?B?SmZPN21Hdm03bmEyZC82bmdzNHhZclEzU2pKZjhvQnJ0b0xNYms3aldVTHlF?=
 =?utf-8?B?Zk9kSkZ0WUxDaXFzY1h0aEVDeHJPakNUVEZOTkg3Tm1NcHdPcnRSczl4bHlj?=
 =?utf-8?B?aVlXUkpjR0xlWjU2Q0k5OUNpb3d2dmdhL25IRWNPQ0hEa0c1bWkySVVleGQ3?=
 =?utf-8?B?Y2s3S2Q0ZksvN3c4ZGRQODJDd2JiTFBNSnJFZTU5bFhkK3lCS2N6ZWZGWFRY?=
 =?utf-8?B?V251bm9NSWF2UndvWjBFRDhkOERpcDlXNllkYStTcU9zaU5GeEp4VzRWanFL?=
 =?utf-8?B?aldveitEa1MwMWp0cXFGdGhJMUhUcWZxNDVrVFVPWnNXZVVXQm92MnFlMjIv?=
 =?utf-8?B?NVA4S1NGZzl5MW9mSnFFTUx1cm1xWDNIemV2WEF0WlcwM0luMzNKZ056WTVG?=
 =?utf-8?B?WDRwaExEWHhBVkpRL3hNeWowNzVHUVphZEZNLzlVMENSK2FqRkJYM2xVZmg5?=
 =?utf-8?B?eGpIbHY5ZFBGRzZjc0Z1U2VtcFVMQWVwWkhOdVk3MFRwZlpWdVgySjZwQjNz?=
 =?utf-8?B?MlNlSWREK0IvcE1LeFg1a0F2MVVsZmlmN20zS0FWV2JLYkZuRng4WUM5VlRv?=
 =?utf-8?B?VzJ6N1NWR2haQUp5MWJ0ZmQ0Yk5oTndxY0Rlb0RMTktpY21MNjB6UHZ0RzhL?=
 =?utf-8?B?VGJZOXhFUjhWVGpwK2p3cE9PalFKc1hGdUdqYm1NbHFTZ2wxV2FWZE5aTzZM?=
 =?utf-8?B?Vml2VHZMSjdFQWp5ZXMwdFpQQTZPOXBZWUtCTWNWdHFiYW9La1ArbTJNMjY4?=
 =?utf-8?B?MDU2eXBBQ1NCVlNoaXRWYnU5aEZuY1lLN0VhYlNXMldKbnVQanNXMnpuMUs4?=
 =?utf-8?B?bFQ5U3F1OXI1TmN1RFJEenFDQ05uY0EyYy85QlR2RGRsRHZTL0dYUjc2MGV5?=
 =?utf-8?B?WEZZRGtpdTlvSFhqR1pya051bllZWmhPVUR5ZGZqbWR5cGQyUFp0eXlrbjhz?=
 =?utf-8?B?NDB3SEdSWTJIUmtCY3l0bGtkK3JZbWFyNy9JS1JtakZ1ZU5sN0xPdzc3enJF?=
 =?utf-8?B?L2dDQmlGNWorN3AxR1dHaWVJc0xrS2U0ZmVhbzJRWUphd2twZVUrQ1pzYnZP?=
 =?utf-8?B?dEF1ZzJtbXU0aDArYVovZXRGWnlxYkxvRExQYUxyR1h1WEd0VExwdz09?=
X-Exchange-RoutingPolicyChecked: KXcjqbnG8cBHPv2rItNtS+5LHp/uVqEx3u5PTcUxQJGjXIZcpeXt/516KsYM/avSEf3lvMNyC/2ePqMnn1e+oL+f6jcKiN03hG4hecpnLk7EnYhZXtHEOq17mxlKNHDFAm42rCPjzmaX9S/2bzB6ULO96ZmH0yoHV1nj3o9NGR6qg51t1x+s0Y3T+whfjZAgdi0Kz99Ooh08QIS1RH3oVRDwkCf9J2QkyQ64jDzoUNZ2nmJe8Q8q0ck3FIKOXtL+E9dhhmg3/Iq+2H63evABjHjiRj1aFHidPh05xCZgEXv525fBs3Rv2dFFVA8jtPWHPmLPk/gWk3VML06zw/DSqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa26f1c3-c90f-46b2-632e-08df2ed6e731
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:21:04.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6d2H4OtXEw1UUh5Qvt/dJQF+NoI7zY4XutTCJCccJtqgTv7WPc6m8Fe6nfjAdkH5G99lqvBuCi75zqtprr9ssnzcwBEEDxGL17Rdh0TdLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB831931
X-OriginatorOrg: intel.com

On 10/19/2026 6:49 PM, Guixiong Wei wrote:
> 
>      void fpstate_free(struct fpu *fpu)
>      {
>              __fpstate_free(fpu->fpstate);
>      }

Hmm, just curious why the original check has to be removed. I thought 
this sanity check from the struct fpu context was reasonable, no?

   void fpstate_free(struct fpu *fpu)
   {
       if (fpu->fpstate && fpu->fpstate != &fpu->__fpstate)
            __fpstate_free(fpu->fpstate);
   }

Thanks,
Chang
