Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875DF4EF145;
	Thu, 17 Sep 2026 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667591; cv=fail; b=dL6QAo8cecUx35C/CQxCRVkKMnd8XE/6Jp5vFYkzBH5M5ArY2wELPUV9wb2PuZahLIm/+NsLGCeisP3w3x72i53jhGRW0wEVmChvP9o7c7p5HTb9V0EZAJfe0cWdvX2wIpz1wxQK4HKzBO8lbS7ELFmJ/g9L3N9FECnBcgXBz3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667591; c=relaxed/simple;
	bh=XsaPJGpDrP/EkOqmi98HHy7UWL69wYHxIQ5qEQ0gP7Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nPgjkxkUgzIyHUJvr2WRkQ/8bTLmaFKmln2lQ2MSZ37Y1S+KqsWR1huIxsdMW8Bpq/nKPVYICsR9Up88znMzanjj1jgZ7GSDJVlNkzOfrnH8yggta7rcBX/N7T1/pSFYfDaqC2GLzjmtVypHRGyUGb+D+GERXGiTwxUFcKM4y/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghhGTbHX; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghhGTbHX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789667580; x=1821203580;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XsaPJGpDrP/EkOqmi98HHy7UWL69wYHxIQ5qEQ0gP7Y=;
  b=ghhGTbHXTAs5QaPSlLojGZVH/v5ZRRZDU3+LOmeCw49XSeSbgTe72l1i
   fyjfSgMSgQxWNMgmVjXIPIIpOARRL0w+FoLxELYG5eLeF/ysVb9y0Z9r2
   MQUMCfyIiobzdrrZEBnvvPZvQlbmtJ8lVo1aP0jfD1o7cwe0VpkScatJk
   dtBogrDiro4S03FSKM50bTzryRo1iXB5f0U9JfuqFSq8GSg9xHmnTQdU6
   j+jJfQlCQXF/7NazwEg81em16WY6u5n2YcPjqOIzqA9PX+zeRCbvpWuQt
   Sv6zeX0KUc/JILX9OvaQWmZSmM6SpEqp76qT3D2c9sRbXnl8JbLM7LZ4h
   w==;
X-CSE-ConnectionGUID: Cqj63II9QDGoMyH9NeOW4w==
X-CSE-MsgGUID: sV2KHcE0ROewhnhJjMUiYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90251555"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90251555"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 10:52:31 -0700
X-CSE-ConnectionGUID: f/e81xlcTVm4Grl9GB/EdA==
X-CSE-MsgGUID: 0FOC6QjoRL2rZNNWQOPGLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270250522"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 10:52:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 10:52:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 10:52:30 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 10:52:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/3GMGXIRh8rcAW76ubDmjq3oXuuWk6Sz1MMQIFWav2IVS0TNbKi3+d9CKvvJTVPG+jGHVcsGpjkXYEuOWtwye+4PNX3ef/DpRDfCiJk7GCuMmY7DCmNBjcgg2vAdHjkvmoVtXB7MMSUUQM4YA32MtlcrfR4H/9zOCclYlSZDoeqK92qid6BeUFzB40/hDqARuKsUOsgKCeJvy+yCHnu8EsVU69nKHCEZHIzhcahnaUj8NNxXsliSRbGw85duf3CN6bz8wzxWJkb25NsGFy/x2jQu1VLUeKlOuhRkWkuSr4nUcKer7q6OJ2SeTo0nTHm8OwpIa5PCt+8hmKuQQBEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWVquMi8VJkrJMLg2JwNbTL3gvZKNArts4jO2DsnS+g=;
 b=oZh0hjZzrmwNWsBRgMPX4MyCtF2UFmOyntVaOclB07A22kvlpjdpaFbzuOSGtBOwpdK7xqkh0o3ZW49UCthYEd4lTDjr+jD1rUh7Ju+KpPxcUJ+de+BT28VCdDLPNkEOvHhaUr2dxmR2PPF11DmVnqZQY1gVJuH8KgZZzkzJsKRHhCp+35IsnVksIlEekxpVKWxtpdNv8BRiJbjDPfULI1RvOtFl2KQgbqtBkHroNHM60KwIC1Q4A6IglKPgwrCPkkAlkTWbNB0/i9lxgOxCVAeJH3O1+hPKVJVNuzfLnea/pCRhPMReYfhAhYZprDJt3gfKinxuOUDQ8x1M172AHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5)
 by CH0PR11MB5282.namprd11.prod.outlook.com (2603:10b6:610:bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 17:52:18 +0000
Received: from PH7PR11MB6932.namprd11.prod.outlook.com
 ([fe80::cca2:8c49:b4b1:761e]) by PH7PR11MB6932.namprd11.prod.outlook.com
 ([fe80::cca2:8c49:b4b1:761e%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 17:52:18 +0000
Message-ID: <51f6a0e2-25bb-4ac3-9b3e-2883ef7e57e3@intel.com>
Date: Thu, 17 Sep 2026 10:52:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
To: "Chang S. Bae" <chang.seok.bae@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <andrew.cooper3@citrix.com>,
	<arjan.van.de.ven@intel.com>, <stable@vger.kernel.org>
References: <20260908223209.916758-1-chang.seok.bae@intel.com>
 <20260916225939.1144524-1-chang.seok.bae@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260916225939.1144524-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:332::11) To PH7PR11MB6932.namprd11.prod.outlook.com
 (2603:10b6:510:207::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6932:EE_|CH0PR11MB5282:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f67ae5-21c1-4751-ad65-08df14e46aaf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FgjL9uUyYvJoK9CNRsu9gmoRSPAEeoiIjiwFDG2zbx1hlmHNTxiaOptGjfU7XUfQtoRqK9MQWdF2TUN82iAKg8A2ngpWcy4RqeJdzrbxmGpwq30PAPHSSnEdm8spEaHc85oOwv1uxvIZYYCBTVvF8PzKPebbJFvZUuPFkzOQpyqZLdfmuEzPhxV7DeRhqQAKlkQS1zfB5FX042s2CWEprBTygMukF6yLcMeeMaKdCSJWSVFNFV09jHipU+7WO7xHUubk+1jZ5V1poAhaIQl7Zv7NU6QZJdMsJITezaP7LSBWK3Dqk2SBRE6+ayppCQvFYbDbupUc0bLeLvvh6A23QXaWgX/kr8DYHBZ447y9HxZJWZ7BYSEWn/EIegecWRZsW7Yy9DyhmgIx5BQVEvz39agH8u6HbUhra4KtGeZ+OKGzYBqBdSgkx4RKtQ3FQE5euUJNY2J/KWdiAmkt5V1iRnpHbqv+x8DQltWVNPEUb0l4DJh2gk2y5ZlGsR2mLMl4wQFzlFoaM13XkVVT2cDGjDJzQFQfMUJDw8m9NuWZwkJEqEJnMri3pYj2vWMbB53tEAHRZQRF+LlSfJBuKvyWgYIfydbH6H9riBHCPWxQW1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6932.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTVmc0RFbENjVjMvSDVWTDY0UEgzaVlpalc0c1hGTEZPUGFaRjQwMUpKVUZ0?=
 =?utf-8?B?QkFGNWMyNHBRWjNDYzRPc0d1U3hKK01sb2ZueHEwR29aRmxKV2JIS2xrN09P?=
 =?utf-8?B?cmJxZEF3SkR2WDNvckl2dmYrUkhYNTNDNytIRzIzNjFCSGY4d3JQbkFWRVlV?=
 =?utf-8?B?bmdZd01ZaUhLWHFEalNvV0MrSTRET2Jibm4ya21ESTh2TCtJKzYvUDNvbWpw?=
 =?utf-8?B?bFJBUzg3LzhtSk04TGJOSGZJZmlVTGJWaXJEeHM3OGVMbSsrUmgyTnY3Wkdk?=
 =?utf-8?B?dmxWWkcwNHE3dU00em0reEJSbW5YRGFzWVNUWDZhK3JrN0ZMeHNuK1gwR1c0?=
 =?utf-8?B?TGpReG50ak9yK3Jod1FjYkRWdXpDV3M0Z2laOEhaQmNBVlZDRzhJbEJyNzVB?=
 =?utf-8?B?S3hmd0ZtYXpEMHh6YXUzRTA3bkZmOExvNUJPK29ib2t0ZGlSZkZjK04xTFcr?=
 =?utf-8?B?Mi83L2psWXVRNVhFaEFqR3dTTkdnZ0lQYUFxZVJHeCt5S1ZTT1VLQ0szMk9Z?=
 =?utf-8?B?ZmsvSEJHK2cvUFAydWR0K0Q3ZWZiME94TXlvZzFzU2lBN2NidUVBU0E2ZDVs?=
 =?utf-8?B?NVVQQUl4d3lXTjE0UG5RRHNsY3ptTWR6N2JmeG9rOUl6Wkp3bTJhY3VjNUdT?=
 =?utf-8?B?ZTA5R0M0WFI0bHhoblg1VzJKc3RKc1ZGRU15Q2dzUGdWRnBLTkhYejZESERW?=
 =?utf-8?B?MVVDTjV6QW50NU5XaHBVemtySnI4ay9pVnBxK2gwODQwTDBFa1RJTm9UM0lw?=
 =?utf-8?B?OHE1WThiNFliY0d2dkp6QnlJdHdmNWQ2VGFzY2phMzQ5WkRJa09vREhqVFE1?=
 =?utf-8?B?dzlndXNSODJrd1BoS1VIbkRnNGJnK2lucTdHS0V6YkYyYzY2WXZramRoTjBW?=
 =?utf-8?B?NStjaDFrTndKdGJqVS9SeG5VeVNaSDVOakd0OFIzT2RmVDFBMW9zQWFIRWQ1?=
 =?utf-8?B?QmVpV0p3NlFSeGFpTjlPWkVUZ3FHejlCeW1xNllzaUExRGhhbURZeUhPc3Rz?=
 =?utf-8?B?ei9YQ2ZJWmQrZU1GOWt2YkZzUUUvbW1zL0VpS2paUnBhVWR0K3ZLcXhxWjF4?=
 =?utf-8?B?VVRUWmNlTUVpL2R3WWExSFoyR0w1UzZXemtnU3Joc0JYR0wzc1VFVmpuV3Rw?=
 =?utf-8?B?RkUxTjZUSDVnNmVETXU0S3dvbW1jejgwN1ptczh0TWoxMy9xb0xERWc1Zm1M?=
 =?utf-8?B?RHdxUng1dFJlSWxNZ1dZejRYcnBIREJZNzc3QzAySklQVWFrV2liSStYWGdl?=
 =?utf-8?B?ajhMUEk5MFAxbE5ncjM4VEdpQWdtWS95Skk3WU16cktCK1QrSVhnZEZXYmVx?=
 =?utf-8?B?V2E2UzlQN0ZRT3VqVUo0eUVPSXVGQjc4QzYrSlc5WE0vK3pRbUFEQml6RkxH?=
 =?utf-8?B?ZjBVM0xMZkU5K1h2OUwvazBYMWpodG9LZnd5Y0hCczBlc1lLRWwwOTNJK25N?=
 =?utf-8?B?L3ZlUDVaY0hCWlJwL0daY0pIamJmeWpFamkvY2dGdXBaUEVNQnBDQ0YyU1dD?=
 =?utf-8?B?OHRYUGhxVDU3N1AxNHBpL2E1dzZzTzFHb3FnNmRFVlFkZDMyMTIzRk8vV0Vi?=
 =?utf-8?B?a1pKSVJ2V3BiUnkyTys2Z3J0YmtxNkR1dGFGdVFJQkY5eHlIWE5GS1ZYakZw?=
 =?utf-8?B?RDhYMG1PcXZtZ0xHeXBmS0Z3Nm0wQnFBYXdTTm4vNzQvaHJLSkQ0SEprNngx?=
 =?utf-8?B?L3k3SmlCYkFJZGZXaGwySy9INmtaN1U1bDhrUnJuWC9mYkw3M2lqTFJkYnFk?=
 =?utf-8?B?Q1dXdTRFTUM0WUt2NUFxSkM5QWVxUDZWRHJCL1QwZWsvcllLVXVIQTJUUzNX?=
 =?utf-8?B?Z29jaDhxT1VMNmt1eGRvb05ZVSt5amhBSkRYQlZncUJoRXhHV2VqMW5zR1Fy?=
 =?utf-8?B?ZGR6Q2NDRjhRVjJjaWpXYTFka2tFdWhHMzBtM3VzSzRRY3hEUDd5ZXBMNlg1?=
 =?utf-8?B?OVpyQThqVkh5VXV4Wk5LVzltV1d1K3Z2ZytvRC9EcjYyRllWSmwwS2x1N3pw?=
 =?utf-8?B?a0JOOVVzTjUyKy8ydnJsQ2FmK0pIMjRuU0dWTGVQQ3pneW9zQ2FkajNqZWl2?=
 =?utf-8?B?b3c5a0hVUyttU0NpVjJKV2NSYm9KQW1ESXN6WmhhajlNaDROZkdaNXVOZkl3?=
 =?utf-8?B?aVNBdHhmQmdybnd2c2FWMHdrOVFMWFVqeG15RWlFTHArajJOSzBQaTh1Sncx?=
 =?utf-8?B?YTMzdDVvb09wcXdpdmNVS1huTXcweG5GbFpJd1RqNC9VRHJHS25QaEt2d0JH?=
 =?utf-8?B?dUlQb2RGSXdvWlk1Mzl1M2xVQnd6aW1yYk5sdWo1bE5OZWZ2UVN2OFY5OFkv?=
 =?utf-8?B?eXk2YjNaWHZSekV3ZkZTcTVKS0FDUnFSZWFpaGs3bElPeCtYM3daZz09?=
X-Exchange-RoutingPolicyChecked: w1tous3Lz9sElIM4YEiUKpnR2ow+V1zvVtlNkw+8RvYcDTgAXYpnr3D+X5UkM3Hj9rdYa5jOx8ky97SP6VF+mB32xzxThPVJzF4lYuiWHCdMiRzQfX6s4sNS6RRszDi9FBwnCBzEy/FI7GtPCJi+YnWPXeYX6r1iTKqKqyx+n1asE9ihhbPZ/Ph1CCzWCvztQZnJxLzBRxXgUEJnZW3gsIFfS0mgbvnpcQcWnkLWzJBylPpXo5/J5Z++5fi34hxrgaVxhzf5ZK6BGNrIebiomWEAm+0O12EMGr32vbmMZ/Itu+z9pHjop/eI6WlBkvVJSn48g7DEuotNsxMbaZi3tg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f67ae5-21c1-4751-ad65-08df14e46aaf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6932.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 17:52:18.6016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpD0MP9wg70s9B4s3W1ePMBKEZVMCtWQZI2LRN7dC4RLOfzlwwn3akZlgHngB7NtWv1+JDGYVjrJUUYIpWVltg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5282
X-OriginatorOrg: intel.com

>  /* Scan blob for microcode matching the boot CPUs family, model, stepping */
>  static __init struct microcode_intel *scan_microcode(void *data, size_t size,
>  						     struct ucode_cpu_info *uci,
> @@ -330,6 +350,9 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
>  		if (!intel_find_matching_signature(data, &uci->cpu_sig))
>  			continue;
>  
> +		if (!revision_is_safe(&uci->cpu_sig, mc_header->rev))
> +			continue;
> +
>  		/*
>  		 * For saving the early microcode, find the matching revision which
>  		 * was loaded on the BSP.
> @@ -878,6 +901,9 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
>  		if (!intel_find_matching_signature(mc, &uci->cpu_sig))
>  			continue;
>  
> +		if (!revision_is_safe(&uci->cpu_sig, mc_header.rev))
> +			continue;
> +
>  		is_safe = ucode_validate_minrev(&mc_header);
>  		if (force_minrev && !is_safe)
>  			continue;

TL;dr: Should there be a revision_is_safe() check during
__apply_microcode()?

The patch only adds the revision check during blob selection. Have we
evaluated the corner cases hinted by sashiko when this check might be
bypassed? It talks about suspend/resume and the CPU hotplug cases.

v1:
https://sashiko.dev/#/patchset/20260901231634.714144-1-chang.seok.bae%40intel.com?part=1

v3:
https://sashiko.dev/#/patchset/20260916225939.1144524-1-chang.seok.bae%40intel.com?part=1

The suspend/resume path probably doesn't matter for GNR servers and most
of the CPU hotplug flows also seem to be covered. But, what about ucode
update on cores that are not enabled at boot? If there are brought
online later, would the ucode update skip the above check?

For example, maxcpus=N prevents certain CPUs from showing up in
cpus_booted_once_mask. So the checks in setup_cpus() during late-loading
would not catch them. IIUC, the BIOS version can be < 0x1000405, early
load can bump the booted cpus to 0x1000405, and then late-loading can
load newer versions and only cache the latest ucode revision.

All this while, the non-booted cores would be stuck at a revision less
than 0x1000405. So, when they are brought online later, could they
directly jump to a revision greater than 0x1000405?

Would it be safer to add the revision_is_safe() check in
__apply_microcode() so that all of such cases are covered?

Maybe sashiko just made me paranoid. I only started looking at this
because it complained! :(




