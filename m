Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795299105;
	b=5bn9ZRZQiR62c9iUnnUScqtdOrzWeC26+R06mrQUtad8b4MOxyOLkv/UjUSgdMpx+0nY
	 FlFQ7p+jt3varzNKq8p+Zvydn+vRhF/VXC8bJS0/TDwbCzfraMQgSAE5RrQn7Yz9vT4HH
	 Y7B166XmUR2e2WEya7nWKU6VndJuAL2SOl8FUgSXEdODeMqAaKXD4KniAMTdRFGfssLIo
	 jXbw/kBM9tqgZv2rn2aIYbmALngElyFHLdbFDqoHZRE1Uo/Gn1wjMq4IMZKntuakxMIj0
	 huErOIiC2l6dWthullBQYLx30JgUK0T11zabbPHK6q4Nx93IQ7KXNul14FrqiTx9NAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299105;
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
	bh=rzDJJDMBnKFEoo8esIuRH0ah5gR6fCGt3HpHnytgdFQ=;
	b=eSJpoJvqyFn+rRTke136CE/3jUJCF09M5Gojsz5uSgLOvnyaTIfjPxeZcvBfu3TotK71
	 jizmFrTrvhYJJFrmJwmUlw2BayRM41LSpdhTNsRGvfGSaohSLep7g0lirGdyW0YjARaA0
	 jEACp5D8FSQG6TIySKSr2Uhh5obh8cDA+B7HaCpfZnjgiwhFXw3yPC9INbOYKIWP0dVvh
	 AmtGWBuQ7F/El7voEIyFg8BzlVHF3rDVIIi7SEJ4mIgwYmliCA+tDWFnlWACYhS1RsOC/
	 ROhPFuyLqL1oaIYfTu+yv5QiNGpAktv/mUKpn7qff0nwDESai1D7JXxsLVweKbQs/uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=boZfNwis;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=PIoodL5o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562A606A320;
	Sat, 21 Nov 2026 22:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B562A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=boZfNwis;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=PIoodL5o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795299105; x=1826835105;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XnSqxxFVuHZqV7C3HTWnhtaH3DiN8802R9N5ZqCGBQs=;
  b=boZfNwisXZexzKQM6P+hnjxHJ1t9Joy1AGyaU1xipd0LeFIBoLH3wjLA
   fq65myqQ0ahW4dE6Z1eCGMfCfZGYUQiiWfRDy3hAQZP1LchlgkbgeOWxx
   lJSWobHckhh/TDYOBiewc4GQuSQNfLJX9Rm0Cs71eR9pJCRu+bTTgfVBm
   93jlPnC0wMobFTpOYVRFFJbJ2MlOrMOoxQYgwe5rUO2Qh7fxacvVP8xB6
   wqaFiU9J4f+7Y98cx5UXwT+r5MspDR0029vwzHyxxS0ad5JCl5JYSa+Ek
   0T7D+l+L2suDgK6mDJ/dslq78/IM9SM/d+IWjCVc/vQ6Go+7oAribpOnl
   A==;
X-CSE-ConnectionGUID: 4CuU6BZdQpmSv9+qeTg8SA==
X-CSE-MsgGUID: EKQYa6J2S5CQsa71//g46g==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4249935"
X-IronPort-AV: E=Sophos;i="6.27,225,1787036400"; 
   d="scan'208";a="4249935"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2026 14:11:44 -0800
X-CSE-ConnectionGUID: qDI3fArTRWiKD4Byqb9EGQ==
X-CSE-MsgGUID: EI5mcAWtSkSEOdVf7vNOmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,225,1787036400"; 
   d="scan'208";a="12972658"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2026 14:11:44 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 21 Nov 2026 14:11:43 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sat, 21 Nov 2026 14:11:43 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 21 Nov 2026 14:11:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2x3zIIjY/3jRlUeHr0uSChLVRuCN1n10mR0kx3hWNcmim2QN0Fg4x5zPb/ZNo6ZdbkUdW1s3wpoX89Z1tCFslaqCrQ5qG/rf0dnLGNKAMBMJ6j1t/d81V8PlMQdDtQUkJGIDm5y5vvHlifebij0O69Oc5AykNmCyGE6rGe3Cd7YnvQ0wT0EfxFrToCY0NtmpMz2JAlTXS1ZFX3G5WfxVAvimwi0WsFxECysUwXXSNFIsmi4LyDheGH650toRxwejA2Zb0Qq3vbok56mwUCXVs577E5mTxOpZqf7NRzsA5M0n669mWjeVSVkIs9IW+p4+Xq6Ypg2PtsLV+sdET1YVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzDJJDMBnKFEoo8esIuRH0ah5gR6fCGt3HpHnytgdFQ=;
 b=DCrIwIgXbIQPDD7W7+XgWmHqaxOcM8sMi9xk1/cmJu0VqL0Cu+SBPDH+DykxPedrPc7Lomd40mFxQWsLXacAqZ1tT4/nNas3qlXN1uxbW6lIXmusB+NKxZZXaPwP9xUyKLybGqn2jEP2vJX9yVWsxgPj4huP1mV3a7NA2T6xqyXtOjG/xccFimA9usYo4eSXim2fUz5pv2o3hbhJ83ltNMj0ZesuImM1Elh1CG32f5PrFeCS+Nk6JXeBSj0FH3PvBjkxeHpGpArUm/rxnUcR0uqzEUIP9D6OOyzUkPgD/vWfJqs/f+ow8hTnY1M+m5x0VPDm1L8pdl0b+/JFHNhkJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzDJJDMBnKFEoo8esIuRH0ah5gR6fCGt3HpHnytgdFQ=;
 b=PIoodL5oCh5YsGRI15/cXC9y5Zx95xINuED+KyUhZH3z+JHWzpRFoGA46phktoPkHhmPYgtoBvjIhOjuZosz6bjsGFjQ3DV/t+kioSWwL4Yz5fMn7xHivaKDx22umvbXq9bvY2tpscHCQLZUi8xdB2RU3nxnuecXhl8EqDD4BbY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB819107.namprd11.prod.outlook.com
 (2603:10b6:806:518::11) by DS4PPF25B1C4D24.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sat, 21 Nov
 2026 22:11:32 +0000
Received: from SA3PR11MB819107.namprd11.prod.outlook.com
 ([fe80::e8cf:3b9e:d98:ee2]) by SA3PR11MB819107.namprd11.prod.outlook.com
 ([fe80::e8cf:3b9e:d98:ee2%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 22:11:32 +0000
Message-ID: <89f322b7-89b0-47fc-a72d-e590c93137a8@intel.com>
Date: Sat, 21 Nov 2026 14:11:30 -0800
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v4 1/2] x86/fpu: Fix memory leak with dynamic fpstate and
 exec()
To: Guixiong Wei <weiguixiong@bytedance.com>, <x86@kernel.org>
CC: <stable@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1793604327.git.weiguixiong@bytedance.com>
 <728ed963f43b44c97f4807a2060f77c0b362521e.1793604327.git.weiguixiong@bytedance.com>
 <f913184a-0386-417e-84a2-7bdc72629eee@intel.com>
Content-Language: en-US
In-Reply-To: <f913184a-0386-417e-84a2-7bdc72629eee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To SA3PR11MB819107.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA3PR11MB819107:EE_|DS4PPF25B1C4D24:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d28d4c8-d799-44ab-ee18-08df481c6642
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|4143699003|11063799006|56012099006|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wouxEnm4S2yrYN803K3JduNoyj/qBP/Kz4fFMUTc9hgj+HuWNrVBElvQNpTO5Kh477V43i21JtwQ80yVxyHoyJJLQ2JHgdr1raldfOT8Mqj940BtcrQ+OLJe5kjeapISi68Ns1D+e6HSmzl4giTP3MGb4Z6kUkKvDHYbZ2Crrnfbc1mT29uED/jHHyJf34umEmvMU1WJOf2RgSsM5Il912VkRlKDgEHL4jzvPU3u0482rSrUpBw3K/QuOSpUKkp+FYz98fHpYSl1sNxjlEn1fzbMZddBXoduICbGoxvwTqCmZa2TzcXPnSM7scxlYTokq6eo5M5kqwgkeTqLytaeIrPbWmSHeqA/cmcAimY2+td8j65/ZTCotzhKFt8TvgPeUcbbaUGFE+wgTjhMo6GiTH/fZF6DzBnJqJGGXS2WU4yb57V6ew3OXiKPL37di168tvksbQlhgq7hZ1AMkM8VL4Ao6hQh/q7BsU1m+5dlsxzrvg0Lx+Loxi+0lSKHVSvd2GHoXyhm2ZIWsMIK45EkFMod2CaMPFAcQ4rcAU3MLyzmszLdck07iZXQG/hkkaXWqIRbpNYD8BbW1qEia5PMlBAjv/fp0EV795TTnP39UKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB819107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnFJT1dXRFFmeHhuV0VhcEQzZjZOcGlDaWZmZmV0ZVkzMmF0V2MwV0VtaWtu?=
 =?utf-8?B?MzZ5SGoyYmJPdy83UzZtWFRzNGdGRkNlVDhxK1ptME1saytlZjQ4SGhuSFEx?=
 =?utf-8?B?bHdiOEN5dmYzNC8rZHQyMkpQR0k3eDc3Wk93YTJ1UUVoUWltUzl3aFlobDFP?=
 =?utf-8?B?MThGamRKekRacHViUDZGd25qMTBZcUNGVjJqSVoxZ2pRcWJTU3YzMDBVZmZO?=
 =?utf-8?B?QU9lWTZ1eEZxajRnV3lQYkc1WTAwcUN6eXE0bmFhSCtEWmtzVWpUSmVrRTdt?=
 =?utf-8?B?QjdENGo1ZjZxTUptQmpzQTFoZ0lrYkY3T0x5azBjSEJDWWEvVTFUZHBNbWFE?=
 =?utf-8?B?V0VOTHk4bXRDMFE0YkkwKzFrV1lKMlA3bU1sdzMxdyswK0dWVnBFVm5mWTFr?=
 =?utf-8?B?cVVCdWNMeG9aY1UzRDZIZGVxay9tQWR4aVc1d3VkUVRDczhrMkpuV05pRTFa?=
 =?utf-8?B?VW5NS2lidnJ1Z21GZDJjS1Q0VXhmb3BjYmhreGtVM2o5dWlXeW1uY3BubGVj?=
 =?utf-8?B?d1FleVRpeFVxbzVlelMrTnRORzdSSXMySVFPM3BjS1BlTGIyRlBIOVpLTUFv?=
 =?utf-8?B?K1FFWDZVYnpzVW1hbGhndldoTVU2L1lKbzNZdklYcGtBMG85UW1GelR6VU05?=
 =?utf-8?B?d0M1MHZpNmhnTElveXNRVGwyd0RWc3FYdFVkbHhMQUVJRGZhc1dPdWhPQmla?=
 =?utf-8?B?dXBJUTVKa0tKcnQ2R096TmZCZC9CcjBIQW1vcWFoK0l4THZwVXgzTVh1Z1hv?=
 =?utf-8?B?dzQzdm4xMGcxellWbStrTnNIYXFXaHlzV1Znb3IwM2UzU0JMRVYxRkFkTkMw?=
 =?utf-8?B?Zm83OFVYWXVvRldWdnl1bFFIcG5nOEw3dko1Y0NCQ2tMbk96K0JZci9maENF?=
 =?utf-8?B?UktGcHM5WW9ZZ2NyZnJneGdDVmRzYVdWbllNMy9VQ3ptb2EvcHlkeTNZK09z?=
 =?utf-8?B?MC96dHNFSHNSQTZCZzJnQTFlSDBibWt1cFQ2NVc3TTFScEVsRklmK0ZKSDBV?=
 =?utf-8?B?SG5vcUV2Sk5HTlJjSFdZRkQzWjVzLzdtWlZQeUQ0bnlGQ3VmUHFDbGdRUi9z?=
 =?utf-8?B?TUEvQ2gzbGlOZFlTbzNIVzdkNGJqTmJiNTBSdHEwNy82Mk81QUQ0MXBxei9k?=
 =?utf-8?B?REp6YWNPbUo2M2g2UjRjdFh3UVRzSm9YZW1HdEVMUjdOK3JNTURiYmF1S2NX?=
 =?utf-8?B?VG9UUWhhZVk0UXgzTGUzYVhqalltcXlENGhwWmdkSVBiUXRQbkJURGN1TkRv?=
 =?utf-8?B?RmNpWk1LTjI3V3ZRNFV2R1N4TUVUWkFxbE42VmxsVEVscFlWZjZyazVOUWZE?=
 =?utf-8?B?N3gzWDU0WDZqa3JMcENkQWcydnc0NFVPYmVwS25OVFkzbnNVK3Q2bHgzNmlX?=
 =?utf-8?B?R0lWTUQ5Mnd1aEJlSDlLNlRDSFZKTFAwaGxiWW9ZVjh6bjBvZUJpMjE0UEt0?=
 =?utf-8?B?NVdqYmhJMlY4bHpsdEJrMXpONVAxcmJqaytwQnJBNGNLNzlUUTRlVDgzRi9a?=
 =?utf-8?B?RmVVMEo0TU43Qkc2a0NDZ0g5OHFpczdwR2xxd3pVV2MrZWdlckZUSTI4TWNw?=
 =?utf-8?B?NithTDRwaHBWd1JDeDR3SmN6QURmNnVnWGY3S2JOa08wTFQ5RWxkYTJid3dP?=
 =?utf-8?B?YVlFRFROVmFJd0p3cjN2MDZqOTU3Q0lsTVJRaDJ6bG1jWncreXp0R1ZOZTRj?=
 =?utf-8?B?aWVCK2lQZFIyRzlHWjlZc1RCdnR2NjFxdzNhMFJyaEdxSnp2eUNuZWM2VDBQ?=
 =?utf-8?B?MnpEaFVnNmdVSkhZSU9EaTUvMWZ2L2NEcTdSS1Q2KzIxaHFNbWV2bHl2MTA3?=
 =?utf-8?B?c09UOVVQRTBocWNyTWFBRXpKNSthNW1IMG5zTzlBb1JvbjRzbks5b2d4N0I2?=
 =?utf-8?B?QmxXRk1WWk9YYXVTTUNjUWFuaHNualQ1b1dOaTJCeTM4ZUdhcVF4UGN4emVC?=
 =?utf-8?B?V0grRWtmdStmckhsTjNqd2lZbDY3SDI3VjBVbmlSSkdmNm5SSVNNSC9hLzRw?=
 =?utf-8?B?VEc1eCtRUWFmT1d1d09ocFZESllzRWQrWlMrVk52T3pITlp3OHJPZDNzL2lo?=
 =?utf-8?B?UUtEWEhNblhOZGxGd0VucnVvc0RzOWRZQkRwMnEwMDd4WkUzQ1JEdk5ZK1Zy?=
 =?utf-8?B?dlYxRVI2YjlMMWRoZXlJbnBXbWNCUkdTTWVia1ZMaHZndkdmdXZzTUE2SmhU?=
 =?utf-8?B?UkdzT2ZYWEIvb09VbTNmUFI4M2plZUhBZ0dnMWRnNlo4TnJnUnJHeFU5VmM1?=
 =?utf-8?B?Mi9QdUI0QS9HRVU4UndrODFidWFtRVBmV3YzUDlrTGprTVU5RzZMTGlWbHU3?=
 =?utf-8?B?NVZvN2tFVlpQTUF4N3BLdjJjSDNxanlTbTRaOVA0NVNJYWh3YlJ4QT09?=
X-Exchange-RoutingPolicyChecked: eHkYH21o6exaWMFBtEju9ttHEuZT9on8Sot34ihSXmqCejy+zFvZNmQZqQt+/g8e30CIB23Z7t5oubmA9mbQuLRpZgYE38t0gZNmzIlH27YGy6UkID2U/Mji9NiPLEI+DTkc6xED2uxhNubxptJeg7DhsXhpxq9mHVfGnou6LtJGy/cvx57PQcmxdybkYYMkvxHTJ4wmmDm9XRd4q/9T7DLhDHeaWKtpwEcVh7Lf0BN9tIwP4+G437PbzGPbfx9ZGCQFDw0KIB09o/D2A8lmBBbC7xysEll4WGaM7ph7KgnNQ1emFHtXgYtIeu7MEc5rUOKkHMdO6xfoSI3l1FBYag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d28d4c8-d799-44ab-ee18-08df481c6642
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB819107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 22:11:32.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQHJFW0lzk8H3vHjkIvyauN7xNkqMcpoZSDsa97ZmKxIlOa8sadufLd/ADJpXTvSajZBrAC1p4C4jNOZaGLIeqxmqKgOTiT3rN4X2ck1K78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF25B1C4D24
X-OriginatorOrg: intel.com

On 11/18/2026 12:16 PM, Chang S. Bae wrote:
> On 11/2/2026 2:10 AM, Guixiong Wei wrote:
> 
>> Suggested-by: Chang S. Bae <chang.seok.bae@intel.com>
...
> Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>

Include LKML back.

Sorry, I just realized there is another issue:
https://lore.kernel.org/all/88456eb3-9c58-47b5-8dee-fc6ad79334e6@intel.com/

Let me retrace them and get back with more changes. Thanks for bringing 
this up. I'll include you in the follow-up.

Chang
