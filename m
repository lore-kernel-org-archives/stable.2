Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795033013;
	b=zLj5CGt8TitkRP+sUei0Re295quLedhwIJcoyPuASJ7IApr8J7DOS9lajNdD2BjGMqGs
	 qekHWFWM7ZReUJAX5qXDkK/DMXQs+EGekPTHLklHdjGO8K+qEZ/BRR2bx1cbLCkwQsaJN
	 //Oh9OuZTq1gszU31GRTDsy7TI2CVrwQg3ADgh4rzN89rQCrKKLOrotdHRqcvYWJQ0WBX
	 URQHWAuVnHbRjSN7tLzhdneZkWPfyGZeGsp+Yhm4U8MerdFIZofKwu27b1eny8zJ6pplh
	 SnXPuCee0DXVict9WRYCHPLD1hi9BrwWiI/gbctfVTdibRZkXDUppHo8bLNpPnUlmsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033013;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 From:Subject:To:CC:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=0LxSgbG4ETACwDY8AvaichSvCbx+cuIrJwRPtwJDHSE=;
	b=mkripbeAFPPRjpjLJmccguf730s0e+emwxWm+njg1Drh87smLAvjXs4wSpRQhCr1iZlE
	 AmEgSaQaSUoLvvipkXQFFBjQAN18pws/pvNlSwXG6DaR1r0gx3uGF+yBx+nREagwLuo5f
	 wJ+n1IR6+E9HnGKXyJ3Tt6lZLrioq35EAfzz5+AENodZumga+up+bL05a7oLML0UkKP/0
	 fvMWt7V9NLX1KIj8J49oXDorsDdIoN3tm8gPDHWc07QQ9YCG7e/YPhKqM/vRoNM+X2tOd
	 sDeQzboLuDhOgsI9+DQhs42O3PoN/qDSWC/4h6KUrLlZAMV42aN7Kz769h027tybJ7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S3AYuOjA;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gNz5pNS1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827CE606A335
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 20:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 827CE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S3AYuOjA;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gNz5pNS1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795033012; x=1826569012;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N6KoAMTc9xZkS+L80KCgELx5a0L3jGBX0E2NfB2xJO8=;
  b=S3AYuOjA5Twlv3F29yvjXI4lLz/dXWcA0+8M6jxYSo6vr224ZgryyBiw
   ufGsdMqrmStnFkVqPLSO0fbhoipxdudDl9LDIx19nzgoPpQALlUdZCVKP
   ViuIpkDh7uRw9wfec5R9hKUxN0jAhsXMbHeYxTBCSfimUBgrR/S8xbBzX
   o2gdgMRApFS0uUti9IHm0hgiI5SUMmBwdSvIcqa16330D3cro5yS9+ZeN
   Vi+c0xcP9UybSdk7of+aTS27dc69kVoYjA7FVBBFtql2k4IvrwyLXwdGL
   1K1CyrHdIG0CDtVfWWp3HseiOtyH1jSw7QT7amvaW1ItKRZKMC0MLXZRy
   w==;
X-CSE-ConnectionGUID: rE9KeCb/TX+nSI/WYYdNXQ==
X-CSE-MsgGUID: beW+5pZ4RNawftMGV+I8+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3756213"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3756213"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 12:16:52 -0800
X-CSE-ConnectionGUID: zcUceh/zRFK0/KK7VxWO7A==
X-CSE-MsgGUID: UUn52PoMQhqgW8hMZ59/Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10279409"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 12:16:52 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 12:16:51 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 12:16:51 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.64)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 12:16:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGVgXAhg8dfMbSwc4hcIDjKQMeQLVDeaAoGNfcyF1rpj8ngvjgxXlgPtCIQdlr+thgYt51MpHvbaiFSQYG1BX6XSMzV/0xq9h0ThHO8iZDmUbPKLMkshirYSJkUlKBdx6Qed+u4EcDtsI5o3ACjyP82ifN9urBmo3E+slyNtF/WAYmkAU7hKP/hF1nOlwdyBSb+Gy9v5sp6k7vi0jXH4zexDfF41sBh4Lk0gGSPbvIb+xZgj8CsUS9zezEz+W3pWsCfGJEuTZgheJN5JX66Z0KOyAhdPoEGlLINwcIo1+2SiG2ggnKw5Gk7yqTGOzEjikAoTWpV/5s9qw7+sZKBZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LxSgbG4ETACwDY8AvaichSvCbx+cuIrJwRPtwJDHSE=;
 b=XVYaUSyV0GFYcFBmQMSIIuJV+Bre6smjIJ0g2V1IXiA55TF9dAWwceoa/HkZoVKQQoqE3jIzsNwU+DYiNJzCiF+qRiromufd+oS+hjFnxKX/y7LG066C1TgbJqJTZsHSPdC/50l//oi1p461J+iUjNkL6dSg4jU80qv+BSLxVYnrTZUs+5o1p4jOnRsconRkJ2EH9rMRFdD3Shc6rXN2Ylmatlv+iz0qHkd1oOuax18KtYhegxBdRT0v2AEw9wgbI8PKkVuye7MoEn51hWqQZj22sLtTQ8SUTHd3vx0ppAhIBrJiTPh3RUHwaojHfqGcYL/nQkTwKw5IYTBB03uAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LxSgbG4ETACwDY8AvaichSvCbx+cuIrJwRPtwJDHSE=;
 b=gNz5pNS1qi62nZThecbyoBdDcJaoD0w48eQFlzJrgXD/TGKg287VaFesvSqlRWPRIZV+ea8FNuB+yixHpmXRVBV1VYc+pK3Z2K8Gi51TWqFPkYSYaFIqXZ63vBILILR+X71b6O/2DY/hkyrUqJxpxBxz+KPcYl2ZwsNBZZEPoi4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB819107.namprd11.prod.outlook.com
 (2603:10b6:806:518::11) by DS0PR11MB7357.namprd11.prod.outlook.com
 (2603:10b6:8:136::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 20:16:43 +0000
Received: from SA3PR11MB819107.namprd11.prod.outlook.com
 ([fe80::e8cf:3b9e:d98:ee2]) by SA3PR11MB819107.namprd11.prod.outlook.com
 ([fe80::e8cf:3b9e:d98:ee2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 20:16:43 +0000
Message-ID: <f913184a-0386-417e-84a2-7bdc72629eee@intel.com>
Date: Wed, 18 Nov 2026 12:16:40 -0800
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v4 1/2] x86/fpu: Fix memory leak with dynamic fpstate and
 exec()
To: Guixiong Wei <weiguixiong@bytedance.com>, <x86@kernel.org>
CC: <stable@vger.kernel.org>
References: <cover.1793604327.git.weiguixiong@bytedance.com>
 <728ed963f43b44c97f4807a2060f77c0b362521e.1793604327.git.weiguixiong@bytedance.com>
Content-Language: en-US
In-Reply-To: <728ed963f43b44c97f4807a2060f77c0b362521e.1793604327.git.weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:a03:331::11) To SA3PR11MB819107.namprd11.prod.outlook.com
 (2603:10b6:806:518::11)
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
X-MS-TrafficTypeDiagnostic: SA3PR11MB819107:EE_|DS0PR11MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec42bf7-bee7-475b-acdc-08df45b0dcf2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|4143699003|5023799004|11063799006|261028144727099003|56012099006|261021121427099003|261022105027099003|261102123227099003|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: Zm0bzbGEWwvsc309Tao+J8r1PT/683wK3ywPm7BeqUt5pXU4icbQhGN0wcjWuJ6S37s5W5IwHSP3KIRNQSavFhG4YXs1/gy3tZqLiv/0hHCFeoN8d5Kv7yjVACGf/ICqw924zttXdHmWScLcHqZ4jU6EsF0nxk+w0Co6Zb7RNGeidUMB3wWvcALbdB9+hYondnfR5TsM+qbCBoCqXRR6sBBqT8B2QNz3GVEWKYKQgskiooAKahfctDNUCVTjLHPEaSITxfoOUFuGEyDbF/Ipqj2TidCgJz8oAOTelRUnN8w3zohR3mqqiedJQ2qSZiv5iCkiN22Gaqfi9QQb2Xny25VnpGAaTPEvoADu0CrG1/kljDf8JUUrhNJfKJqxk3/4z+KMVL1AgIGtwTU3AZTuoF56PTxLhSEHTy/buA/CeHvCedZgjcOhxIFdG0nVSBekt5xaWV9j0dOAY9/WeShGw+dHf9SZ7OH1FfmgAhQW347W6W6zabJp+hcnrjMTURZES1v1zzlR1rJwfj+9RkRAYeKCrrbwg2GD7z9pc9M/B/OMpI13k1ybq4Sirl/CBPOmw0gyQOPrP3X92fQ9t0HfATAEnrqYcybT/9Qun/LWYHwKoSVGPX4CmhGI2scn++39QkCEB9M0AyR3/66UjXqVZEsDVdeaq+zG+HZmAiQ/vfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB819107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(261028144727099003)(56012099006)(261021121427099003)(261022105027099003)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHZ0ZVl5akt5amVDSVhRWkZpcS8zQ2svL1FMbjRHMWtIS0RES2NQRVBaMEFZ?=
 =?utf-8?B?VDhsUVFrVEdwN0dnKzhUa3BOQUdEeDg3MTE3ZTZXcWJ2bHg3R3hSUUN4Kzdj?=
 =?utf-8?B?SVR6RUM2Um11anY4YW5BQ2tWNklXLy94VUYzQ1NUWjB2OXJhMHVCc0lWRi94?=
 =?utf-8?B?MlJiNjV1SGdicHpDaGlMTGtObTF0L001OVJreG4wMFgybUNuMXJTWkxPdGdC?=
 =?utf-8?B?NDRTMUVXSHlocDdCbVBsM2dhNVFKdmJmTHRVblo0WDFKYnF0RXVLTGFCNlNw?=
 =?utf-8?B?NjFNUng1NWVPdi9CZ01Oa0ZQUk9MREdncXY4a1ZGU3ZBTm8xOGw3OVhwWmp0?=
 =?utf-8?B?enhyZ0VWUTJvWUd5THE4Q2JRbTVqQitveFJaY1BEdW50RWhvZWRabk5CN1BC?=
 =?utf-8?B?dDUvY2Y4azhqQlRrU2orMEYvSDFrRE00U1hBNThNLzhHZHdJL2s1cFZHOGpX?=
 =?utf-8?B?STdESlZtVkV4NkFaRlNkUHBFQUJRY3YxVnRwSXhZUHZ3WU1RTDZTZEhUN0l4?=
 =?utf-8?B?UDhvck9NWVFrMkQzRjMrVU83MmtwcXBteFhBM1Y2amFTQmllUTMzNEs4OWNL?=
 =?utf-8?B?VUJza0dOVHlmK2RuSHJDNm1QSnYyMjRiUUlRakJTTWVzaFpDNEl2QTBEeTlm?=
 =?utf-8?B?a2c5aGZOYzU3LzJuQUFyY3NZVUxnekVZOHk2RmtXczJGRitEakFYNUh4ZHRC?=
 =?utf-8?B?eURJTWw5YlorajRpeDNDeTVGN09IaStFNlAwVEUrb2gwQjdvVE9FdWlqQ1lN?=
 =?utf-8?B?QmN1K2hWWU1iLzIzcmVoWC9TYlFjZkVzVzN3S29jemZTOENEcG9qdXJJOGRw?=
 =?utf-8?B?a3NHRU1sRHlVNTJIQXVqYXZIZmN4dHZDQnEyMlhSOUtFb1ZhY1kwUTlLb0FD?=
 =?utf-8?B?ZFZtZU5Hek1iOXA5L3hOT3gzUmExM1dlbFYzTVg4TG16V3BEZ043NWZmblhs?=
 =?utf-8?B?WXdlMUlTeHNuNkJqZ2tVcC8zaytWZEhZTDd0V2VzdlpQc05kTEhYSmVNUmZw?=
 =?utf-8?B?QWFVNnluZ1pDalk5RC91dmZadngrcHFVdHo1cGJDclBSZjNUSXNrOUhLMklm?=
 =?utf-8?B?ckZDRXA0LzF4amVkWEVnMG1DYW9nYVozNWtsQ0ladDVmb2hwRFNEcmxhaUxw?=
 =?utf-8?B?dTRranBOMDdwMjBlQTNycmFNczVvb1gwWE9pdkJxREZVUnEzQWdyd3FIVEIw?=
 =?utf-8?B?UWZVN1MwVGUveHhLSlNDbnl1QTJ5WUVHS2FWUnQrQzNBYTg5T2ljaUh2ZUU5?=
 =?utf-8?B?blZTZ3lOd1EwV0ExK2xoUGxFbFNJaFE3MWoreDQvY1pNQjJNeHlGZXBRSnZn?=
 =?utf-8?B?c3JuUGg2dDQ5ZlI4NzJ3KzVkeWM3aWQ0M3FVS2crdCtuRGFQWWJaUlRsVzFH?=
 =?utf-8?B?Zk1aSUI2U3E2YXJRZGVpY2pNc1VxUWV5cGVSUU9lYzFSaVJNbjN6Vzk0VEJj?=
 =?utf-8?B?VkFxTkRLSnljVlFnZWhkcXpRYjUyb2lLZTNyUUQ5Q0dDS0FQUmptbE13bGw2?=
 =?utf-8?B?OGo4R3gyM3dObFZ5b0doRWljTVNLaXg5ZkpCbi9DczBlMFlGNy9lbEdra05S?=
 =?utf-8?B?WDRqSU0xODhDZytRMFR0cnpEeE5QNE5EQ2w3Nks3TkdvNVA2VnpqQXFOb1ZD?=
 =?utf-8?B?b2pHTnNzN1ZjaERXNlN6UjVCN0kvblV5RmdEN3lnay9nZi9QRTZKVEYyL0h0?=
 =?utf-8?B?eVVYeGhTWDZINTVzdWE2eGYzbkF6eFpYU05MUkc0eG1wYnQyZE1YeldWYmxq?=
 =?utf-8?B?dlRaeHkzaHp1aWQ2dE9KWVhMMHE2UEhrMUNLeTJBdzExRU1lS2tpWTZ1cWIr?=
 =?utf-8?B?YkhNQjJrSkp0ZS9OaGo3Rk9DajhNSWdnV01MV28ybk1FMG15U3ZhNWZxQjZY?=
 =?utf-8?B?OSs3WFMrZnNnOURaMmhFRnRKamFWNXo2VHBDZUtWb1ZTYk5YWktYVnFMTzZ4?=
 =?utf-8?B?TW5EZlZIRDBEUkUwQ0JSSnRXem9GdmpPTWp4bFE0bUdJWUtBN3l2TllweXhM?=
 =?utf-8?B?MnQyelBTN0JLSFd1dUhTemJoWlQzdGVaVUpNZ2t2MDR4MHIvbmRsUnJVcFVG?=
 =?utf-8?B?T2JSUVd0YTNWL09nVEh1TDZ6S1hDMytwSW5uRklBQmdlSCtjV3RISlNJWG8r?=
 =?utf-8?B?bUdRQnIwZTkzekpQbDRYNXZNdWkxcDdUNDdoU3Q3dEdFUlNObGJSNnNOOElD?=
 =?utf-8?B?OEs0VkxYQUVudzhiZDg0TGRmS1ljc2FZSGU1MTgydExMZWs5YjJJQ0xSeXlZ?=
 =?utf-8?B?b2VtblczRXhzRFQ1dVR1ZU5YUkJSMTlQOUc1YXowMlM5VFZTWU01WDZBbm42?=
 =?utf-8?B?TU9xVmNrRERrd2Mvd1lYRW9KZlIvb3pVWUQxSUJqSVBqUjN5K0RBdz09?=
X-Exchange-RoutingPolicyChecked: SMN/1cy/cpVr3K6WKRBplG7cterXmp6oe1Gv7MISwGobEST+OYzNFZzZJ9ogxBZRsYGWiXOlADALiT3BkSdLo0+f2pT8xnZTN7QVTant1wRJU7MGm4VhcIfCuXvjomBgyhP9dwupoRJ8zFTRXLaDRaCpxa98BdOgD/FHfwrSlYinEh6ul4UONR7rINNge/AprEQBg9siu14/KyMT1JfJmHW4D40bEvxftkcE9UpeYZqLg8UaDjaTjv/aQK3XlfoyqaOT7HsQ9/XZL0eqGtKtjTKfZ7t4TXMf1OPWb59Urdr8pIJlHx//tO785pDWhSmtCEcuhZSg1+6Q8IQJsCTjqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec42bf7-bee7-475b-acdc-08df45b0dcf2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB819107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 20:16:43.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLzDYCe4HcMrHreQbYWPvcO2eEXqG+z7zRKrZKMdtu4qMeygEqiYxg8SOV80KV4/2OLhfOqgK6e1CQVLR3HlKxWXotEih/tTRxEGm0gUg7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7357
X-OriginatorOrg: intel.com

On 11/2/2026 2:10 AM, Guixiong Wei wrote:
> Using an XFD-controlled xfeature can allocate a larger fpstate. On
> exec(), fpstate_reset() replaces fpu->fpstate with the embedded buffer
> without freeing the dynamic allocation. Once the pointer is overwritten,
> the allocation cannot be freed on task exit.
> 
> Free dynamic state at the start of fpstate_reset(). In fpu_clone(),
> clear the new task's fpstate pointer before resetting its state, so the
> parent's allocation is not freed.
> 
> fpstate_reset() may now free the current task's buffer. fpu_flush_thread()
> calls it before fpu_reset_fpstate_regs() sets TIF_NEED_FPU_LOAD. If a
> context switch or a kernel FPU user happens in that window, the register
> state still looks live and gets saved into the freed buffer. Set
> TIF_NEED_FPU_LOAD before the reset so that nothing saves the hardware
> state until it is reloaded from the reset in-memory state.

Nit: this paragraph reads wordy, could be trimmed a bit.

> 
> Fixes: 500afbf645a0 ("x86/fpu/xstate: Add fpstate_realloc()/free()")
> Suggested-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>

Looks like here you missed maintainers the whole and oh, even LKML... 
Please include them all.

Other than that,
Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
