Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56D2541453
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080457; cv=fail; b=mgSl+ECFcHhXqov3sZuXa4Waxr+F1DG1CUy82tGQJjH41oO6f9ywyTeM494VpybuiY+pxRN0tf+llMWmcy76RNDtfTao8r2SG1Z91DR706Zfy5hEy1+NfVqzQcsitxMSo2wEgn9OZFFYFwzZTTrSXedfm2128Lwf/YKHkA3MZWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080457; c=relaxed/simple;
	bh=c5gQrebTXEBevifiyuJR+hf/KMDnwG/q32/DNrxe4xU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eBo1TojmpWGG98oF2MF0O4Bi9pKNZ2h9rL2cZuXl4O44U5sf9exYjBlaYP34IIMoT9jfN2voZ87UWI1++lTYe2PQ9/L36keHzS1awL0xACPCsufgTo6pjkvlHDk6OnDrVTaq/LSURsA7OIIm3ps3arNjB8yLLoH8bZZk6ulf9Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBS2KvZx; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBS2KvZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790080455; x=1821616455;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c5gQrebTXEBevifiyuJR+hf/KMDnwG/q32/DNrxe4xU=;
  b=nBS2KvZxVuSLbUmPHoLJpo0SlTlceUk0xdpibDiW+CUqt53ySGtWHuW5
   VkP66e8h8nuJpK8iUpRZsaQeL5LxIay5GtkWtGG/WNNKTq18WP1BqYv/J
   HI0GCYgni6fNCqrosVgaGyKE2Rnh/Bv4Xu9hpsZVhr5azpxVsquHeGLH8
   2jeFqTg+JQmVPAdAUKM72p+4mqCNbL5SZgwgHiRe6Oz2s72U8wUTsVN6j
   kKKEhLJszoz6xTVW2J7PE4S5AezxzbZvd11ZLvYfjdP5Ql9+hYLg6szLf
   YKmYT2FOdNWRdmKkRINnZyXAmFq+L79lQLRpIXLz5XXMRfcnLuf+fX+gt
   w==;
X-CSE-ConnectionGUID: rrxitsIxQOKSBMfYmgsftQ==
X-CSE-MsgGUID: D+RJhrhWTSmxZzLQrmw0YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90795245"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90795245"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 05:34:14 -0700
X-CSE-ConnectionGUID: n81KunzKSRC5eZT3wAdxSA==
X-CSE-MsgGUID: HA9CxVhUToKcTmTPlfI0rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="301035810"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 05:34:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 05:34:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 05:34:13 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 05:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9XGKH8Pxu21AOjUJQwRWT18uKSKAZL+odoev4IMbywP2wE7Q00u5eIQkwEFuXuZTt1Z215NkPneMtlZ7J0VH2sDaGvb6uC+RVqUMi095ZMR3vpIyDnRZT/49xE2LbZEIsw/U3WBGJCTIdG1eA1CRSn/tIVKC+VZICTyQ7Oa6ImiIfXmCJSwmLeFqux4YIWOtAxdQjTxuXUT1wVlde+49/HBcC90LU3YoCoC3PtuT3C8lk/EeKXC6zH+0WRKBsLok2BP8viNHorGFmCtA0veoBkBLiofCs+F4MyxdGFsIRU7JhcWx/g2Y+YJTwQKlaUQg5PMQ3OQHFvp8un16aJOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+CLp1hZZvVp3/K5y+BkB9JCNyO3rC3+9SetuJD4kU4=;
 b=vsz+EY1MZIftqiuQ52gN7JYmJe7HWQMKf/4JtkcBmRoHB3Os3Y9BnPp5Aks2n07kOyK5RVmlCuJfv74gXZppFQMB1trOFgA2h1tdNR1pZW7InHt4DnpTgBBp6cEmrWyxBDAXJMedKXtSMYVUjCRP9WuTWrye+HUbHmZEpwe90D6vy0g6WrUxgshTpd8x3/uz0hsarFWn86qndMD6+eYA3f9MdD4cd8JKU59HhU9CxXv+eF6hHuc4bH/oJddxkAUAedHHimOFsVfRTmadtmPt4bufhUwx77WyPpkvv63N6WpnYykIslnCJ1iHQ5xk4MG6FV1vvQnflpznzRE++q2M7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB148960.namprd11.prod.outlook.com
 (2603:10b6:408:40f::21) by CO1PR11MB4851.namprd11.prod.outlook.com
 (2603:10b6:303:9b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 12:34:11 +0000
Received: from LV2PR11MB148960.namprd11.prod.outlook.com
 ([fe80::9761:b20d:6f27:5460]) by LV2PR11MB148960.namprd11.prod.outlook.com
 ([fe80::9761:b20d:6f27:5460%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 12:34:11 +0000
Message-ID: <853d6b79-6644-4e62-8bd6-585050f7fd48@intel.com>
Date: Tue, 22 Sep 2026 18:04:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/i915/vrr: Disable DC balance by default
To: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
	<intel-gfx@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, <jani.nikula@linux.intel.com>,
	<chaitanya.kumar.borah@intel.com>, <stable@vger.kernel.org>
References: <20260917074322.2606738-1-mitulkumar.ajitkumar.golani@intel.com>
Content-Language: en-US
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
In-Reply-To: <20260917074322.2606738-1-mitulkumar.ajitkumar.golani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To LV2PR11MB148960.namprd11.prod.outlook.com
 (2603:10b6:408:40f::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB148960:EE_|CO1PR11MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: 661dcd3c-f250-41df-7e57-08df18a5cdeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AwlFA4kW4YjEpD0nzH30YYZQQRKW0pHrFYg1IwKM056AoZbGb2ZOrZlOCYqjY2hYJADp6WKHqrAwEAn/n5VJ4L2UIS5Ary0rllOTckKrGPBW2y682g+M5MNb2jFNHsjjdztMtBcMhT9CTsrfxMzTKZOu8ImaUCRiRUliJ+EOWKBFRQMCMQ/eDGXbFFIY+Vwtcrs7qqV2/43UIRkPT2XOMrBoMqyJpY3mmveUCSOGdmnA3GbN6f5z4cZxvLgFDo+MOaI3hz3qpSiQnyJKdUz7IYE4VgjO1djtKk8y2Pwm09x/x3gONchDoh78ab/Vp+uWKjUiJwzjXclYdb38+H2SBIufKxbFp5xBZeWcYSx13PbaPvhUJpGp7l1x1LcMf1qD5M7WLDud0acDdN5d1SyRhyLrqzS9edZ6IKlVvnAh1JW4fwYdwwMly13ugh5uGZPS8ae+6keS7B0BzGlzF83pLAte6SU4443CwmYXA9S/zugyQpF/31kYiHh/ZnZIr6QWbIAbwmIp8jSKHFepB6so14QrRJQeL1Dqww+2INPW9knaSDNj1/wjckb+LLQdo1i8jie8Ya/ergzLFoNFxH5VgMN2lgdc3MA5PZKy3maiIMpTlFzWdfnQsxyU+uXGOZ+MiF+794ff0R58tLx6TJJEtB453VcwYbHCo/CbQ/b/PPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB148960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXcrTk9OK25zVGMzY25sVkxkbXJnNXNyZnlrODNMN1AxTENvL1l1b01SUXRa?=
 =?utf-8?B?S3c1SmJIUDNWQlJUUC9TUGJFa2gvWE01bTVqY1FneWhWdlREY1VOOG03RDdj?=
 =?utf-8?B?Z3U4RUpkVnQzT2wrUTBValJORVVZRnJ5Z1V3MHZPSnhacGNTTkxiTFAzMHpw?=
 =?utf-8?B?UHMzSEVRaVFaME5ER25IOEltN3Y2THlyZmFHSElVdWJjaWRlYld6ZGg2bEZw?=
 =?utf-8?B?eVo5N2VNZ09WWVUwNStqZ0dXdkl0UnBvU29wbUtoRUhFamV1VGx1M1FrNE8z?=
 =?utf-8?B?NTl0bjF2ZzJsU3JZTzNqRGhNRmI0Ymwyb3F2Uk5qZWxlbVNBcjlEVjhmaE9W?=
 =?utf-8?B?Q2dRcDEyWlZ6eUZuajJWWVVDRmhsMW4xREdwUlRtMU1SZmRzVkdtSEhUM3Jt?=
 =?utf-8?B?MmtEU3B0WlY3N2ZFYWhFN0N6aUFaQkZRT3NaZTVCaWljS1RGR2VhMW90LzI5?=
 =?utf-8?B?cUtncXZRVHg5N1NsTVI4bzJxcDJ3Q0htbTh5dmhDZEhlVWNrZlI4ZWZwVGQr?=
 =?utf-8?B?KzZObXlEUU84L3hnbnpabms4SDV4bm1BeGZjbHRhRU91eWRnaFY5dXN1dm1Z?=
 =?utf-8?B?OWV0dCtsMWpXZFNTa3hZb0VCZnhNL00yRmJzQzArWFpiaXRtaXJIckV5bDQz?=
 =?utf-8?B?MEprSUVsczQrS1pNeVpnTFE3QXJjVVJHUEg3Y1BwK29jSmh3aGI1MXRmam9M?=
 =?utf-8?B?U1llclY2SkkrRFZYRW14MWhUWTZQMDREOWFFejJManEwelFWanZLRDhaSHpO?=
 =?utf-8?B?WGFZNFUvTXJwREtDRDdJU2ViUUJhU2kzem82Ti9VdkRTMmRIZFYzOUlTdUQr?=
 =?utf-8?B?V2tCczd4RFlrYXRWVjZSSURzZ0NFTnpoZE5wOFlocWNCWjFpK0FjMDlCV1po?=
 =?utf-8?B?MUU3NjhVSFZJSTMyUnFRNnBKa1l5aC8xUHkwcXlPL25QUkloOXJ3TlhpZWpm?=
 =?utf-8?B?VmExbEQ0RXY3eHI1ZHBlRHBqWThCTHIvQ01LOGpsL2tPUnh6elhXQ0trMTls?=
 =?utf-8?B?cTh0L2dpdEJNTGg3VkJGUms2V3NJMnA2dE5GTklzZ3NlblpiMzdlTUh5VmpT?=
 =?utf-8?B?YVpjR3pvRG16QzQ5SklaMit3dEUwMHdGbE82Q1YxV1psbVB6VUtmSVpiVUc3?=
 =?utf-8?B?YXRUekdRK2p5YzFQSHh2YWdRT0JWWTJOTnkrK3I2ckl0TDZkUmNZc2tLYWlW?=
 =?utf-8?B?YmF6akRWcTYzZVpHNHVRZGJxWTBmK0ZyU3VMQzVKS1g0a3B2dzYwRjlkcEdj?=
 =?utf-8?B?Q1A4amdIV2d3ajBKM1Y1MUxITWpQVk1xWjVBK0YyMUhyVVVDRTNlaTl1WTlR?=
 =?utf-8?B?V0hpYjk4QkpxcUxMNDVtdkZjcUUwSy9aMGkvejdXemRXcFFXbjVlaWswelVr?=
 =?utf-8?B?RGRWMVFXaklUQXoxNHBzSElzeE91ZUZvUytWd2Q3OHkxM3ZjUW9qTEV6d1pl?=
 =?utf-8?B?VWlsUnBmb1RNWmNwNUNwU1pvTk5VUFh2MjF3S0Zadm9OT3VIZmxQY0F1ZzNk?=
 =?utf-8?B?bUd4TzdMQXVRRFpJSTNqa1lCV3M3TnREOE1TVlZhSDhQTzhRd3JNMWdtNi9n?=
 =?utf-8?B?ekVnRHRYQXo1ZUxvNVFoQm9OMmQyck9MTCtDTlpXdHl5WXZ4SkpWQVlRWStH?=
 =?utf-8?B?T2M4NTRETEdPcldvb0o5bHFmWUU1RzhzSmV1bDZVQ1gwTS9oRHNSMFliNnI3?=
 =?utf-8?B?dzBvZW1wTFZaN1JqNE02emZIdTlwVld5L2pxQi9JbVNwaHFYTERyM3B2QXp3?=
 =?utf-8?B?WEZQOUkzSDl0c3hYNWpLR3dTdG80am0rY0NhUTk3ZUFwdVNuRkVtSDZtMWZ0?=
 =?utf-8?B?Uk1vbHEvcnhobUxDOTViZmRTczdzcmdwMUJmcXJLaXB3SzBaMEtoOW44V3h2?=
 =?utf-8?B?Zmt4S0o2azVaYytlWkFwN2diWk5nd2hpbCtLQVAvNmVMTmdxNWxJcG50VStn?=
 =?utf-8?B?VkxKdzk5OTdmR0xDdmJaUnYyRXpFeUZmSW1XOGttTFhpbDdRTENzUG15REpY?=
 =?utf-8?B?Zk5SRUozaFRUUjBsWWIxQTBIbXZJOUZIcGs0OUZwVjBJTEcxWnJLUUN3V1RV?=
 =?utf-8?B?eDRKSFg4RTF2cDBCdkwxZFNtaWQwQy94cHF3SHRhYlNKdDErS1Q4WTkvSytL?=
 =?utf-8?B?akFpRTZzSjFiMFV5c25nNHR3VVNRT3lnNG5WZnVSYVhuQXViU24xNm9pZUpU?=
 =?utf-8?B?T05nRlBwcloyWW5MbkhzcmkyWFRWNlF4M1A5ODRLZ3RaSDd6TWM1bmRHZW1V?=
 =?utf-8?B?aUgybkFhamtXS0FVc1ViK3ozOTc3WEJUQm05aitpcjVsMzJKaXAyUktYdVJ0?=
 =?utf-8?B?UWxKZzBFOTA5UUV5U2J1ZXdCZUNadzkrbWRIZkZUSm9QYXh3a2U1TjJLc1hk?=
 =?utf-8?Q?xdoUSSj2a150PHJY=3D?=
X-Exchange-RoutingPolicyChecked: njLCRb+GSbZiA8gilKer4/oBsLFYLMhu5RziqLRhhNWexNg3T/jQNmxYA0Btaz+MMKWUwStLaEHkV9WTL7cMv3GTeJ+zcKJCQ7/etIbjvCrRdP5WeTfymn7bIFRwmOjGjPYcDk1m38PssNylj+qwH6w/cp3uHFnCjHAFPQvtxMnax4VdE08nXDs+8L2jnOOS2CV6crABePE9IbAq33LQF5yPBf/Zf4q1ySNi+KBslDQIPzdqMZ7FdE209MsF1qUd+oCMQVdkCcw+tu0n8XWaFQPbs/8a+atgy0qLBjtPX58p9jlz5gbCG+WVmmF0QfTlGGGaziKTXq1FuErnYaJ/qQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 661dcd3c-f250-41df-7e57-08df18a5cdeb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB148960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 12:34:11.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fxzWwLkkrn68IjNeUrzrHpo7DwcYbxfPjdCMfIbNEtEfSPNK1CMxWBBvIu/ke5E6qbc8h+Ye8NbLA7cWiElLBZWDrf4xOzkNr5+UmjuTvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4851
X-OriginatorOrg: intel.com


On 9/17/2026 1:13 PM, Mitul Golani wrote:
> Disable VRR DC balance by default due to timing issues observed on some
> panel/TCON combinations.
>
> Keep the module parameter to enable DC balance during debugging and to
> isolate DC balance effects from underlying VRR/display timing issues.
>
> --v2:
> - Make enable_dc_balance a bool and keep it disabled by default; fix the
>    parameter type/value mismatch and correct the description (Chaitanya
>    Kumar Borah, Jani Nikula)
> - Explain in the commit message why the feature is gated and why a
>    module parameter is used (Jani Nikula)
>
> --v3:
> - Commit message update (Jani Nikula)
>
> Fixes: 555819270707 ("drm/i915/vrr: Enable DC Balance")
> Cc: <stable@vger.kernel.org> # v7.0+
> Signed-off-by: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
> Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>   drivers/gpu/drm/i915/display/intel_display_params.c | 4 ++++
>   drivers/gpu/drm/i915/display/intel_display_params.h | 1 +
>   drivers/gpu/drm/i915/display/intel_vrr.c            | 4 +++-
>   3 files changed, 8 insertions(+), 1 deletion(-)


Thanks for the patch, pushed to drm-intel-next.


Regards,

Ankit

>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_params.c b/drivers/gpu/drm/i915/display/intel_display_params.c
> index 2aed110c5b090..ca0ef466bb103 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_params.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_params.c
> @@ -120,6 +120,10 @@ intel_display_param_named_unsafe(enable_psr, int, 0400,
>   	"(0=disabled, 1=enable up to PSR1, 2=enable up to PSR2) "
>   	"Default: -1 (use per-chip default)");
>   
> +intel_display_param_named_unsafe(enable_dc_balance, bool, 0400,
> +	"Enable VRR DC balance (0=disabled, 1=enabled). "
> +	"Default: 0 (disabled)");
> +
>   intel_display_param_named_unsafe(enable_panel_replay, int, 0400,
>   	"Enable Panel Replay (0=disabled, 1=enabled). Default: -1 (use per-chip default)");
>   
> diff --git a/drivers/gpu/drm/i915/display/intel_display_params.h b/drivers/gpu/drm/i915/display/intel_display_params.h
> index ba01aeaf89440..5c5a1a1358c32 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_params.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_params.h
> @@ -46,6 +46,7 @@ struct drm_printer;
>   	param(bool, enable_dp_mst, true, 0600) \
>   	param(int, enable_fbc, -1, 0600) \
>   	param(int, enable_psr, -1, 0600) \
> +	param(bool, enable_dc_balance, false, 0600) \
>   	param(int, enable_panel_replay, -1, 0600) \
>   	param(bool, psr_safest_params, false, 0400) \
>   	param(bool, enable_psr2_sel_fetch, true, 0400) \
> diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
> index e36db11744405..1698c54e258b4 100644
> --- a/drivers/gpu/drm/i915/display/intel_vrr.c
> +++ b/drivers/gpu/drm/i915/display/intel_vrr.c
> @@ -439,10 +439,12 @@ static bool intel_vrr_dc_balance_possible(const struct intel_crtc_state *crtc_st
>   static void
>   intel_vrr_dc_balance_compute_config(struct intel_crtc_state *crtc_state)
>   {
> +	struct intel_display *display = to_intel_display(crtc_state);
>   	int guardband_usec, adjustment_usec;
>   	struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
>   
> -	if (!intel_vrr_dc_balance_possible(crtc_state) || !crtc_state->vrr.enable)
> +	if (!intel_vrr_dc_balance_possible(crtc_state) ||
> +	    !crtc_state->vrr.enable || !display->params.enable_dc_balance)
>   		return;
>   
>   	crtc_state->vrr.dc_balance.vmax = crtc_state->vrr.vmax;
