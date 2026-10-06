Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CF32F60CC;
	Tue,  6 Oct 2026 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323104; cv=fail; b=J8ivyrTtVqWdG6qaeK1aeNKqNmMqnFk8icTE1P/FPO9ZIAUAodlnHQd1wjD9naoD3fsCSt1xGtQ8U7ONTeu7W8OOCSpQTE9sNDdfBFnkfBbWO0iGVXZuLsfS3HBIh1cAfabUE7p9xlFANG6AxqwS678W6VqFza9wHX/ncTfJBJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323104; c=relaxed/simple;
	bh=SAhqGAOJKHiJNizcFuh1BdyL9AWf2LmXNAiL+fUB3y4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sd9/MY1MLJXe/0lTNlqKDuFgPCtLqiHUMwlwqN5T2vgNZ0HGVz5uF22kCYnmSb/DNXrWsUBoXEr4F3nXO0nmSYp/7nKHIqTDS3R39PYYGn5DYiA7moghv+YB9+W3BZHWdSR2MuznLfT+aUAvFLBHuUiRqQk0XQM9w4uDcUEjxsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFn1VXNi; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFn1VXNi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791323102; x=1822859102;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SAhqGAOJKHiJNizcFuh1BdyL9AWf2LmXNAiL+fUB3y4=;
  b=aFn1VXNiY5uwlcbvVKNKSEW3zSaRdahB3MPHm+0fSmIyg3Ab7ZZ1GFvB
   0mRmY+I/kauknxRuy9YEOmcQDhkUs1N0+P23Cf0OtX+edND7eaQr5jROv
   l40teahqRaGOCm2dH6mvrvy7LPKfb2FHH7ZX6Qa1SV8CBaZ6ZAz/ADWPv
   c1IQaT22vay5IFdQMC+xXMiCZCTSYausVy+E9IROJRq0khVGDdY6K/CW0
   hbT5KmgYCX7XJh6XDh/HG4VKm4edu63jmCAugrcsC3I69LGVibYTzvvVR
   4+mGgVqAe94BFYzcr6NkqEPNi7ZKLP4RTS7b01jEJj7lmcVUdMyHjeaCe
   g==;
X-CSE-ConnectionGUID: SP6jjT6mSmCy6esU6A/YHw==
X-CSE-MsgGUID: CqtwES6/RTemEzGR4OB0Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="108401977"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="108401977"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:45:01 -0700
X-CSE-ConnectionGUID: klQWyEVIToKSjj/kkdX43w==
X-CSE-MsgGUID: vDt9Cf6kR/eSG7Y1ahsAKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="306733619"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:45:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:45:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 14:45:00 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.51)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:45:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPIFGgJMLXpsQ7zUYk9UKGqQVMDgkBgvglNPB5+voLolP5xi8RE0yv9kCNV6BbCQvMFDtKwlDGqkdYnoeCTeP9USQVSEyW9zGk+jVD9CTPrqEK7QW1ByUEKMBCpFKPptaJ/Nl1GJCP3BjD5EJUWNsdtsbgtVJN7VR/LvqigywpXGraqHu4ehQOuGQbf9+Zz4puyCxHKxLWBxG7IqXOOIRCW01Ae+d+EBtXm7tz6MAsHJfN/v1A8GXAhowgazegCltgALvRTYhHOmVqk5ch0CIGbZN9jIDo6KaaTmJULIAWn85VCf18bTT9ETPWYqScFhty1a6UfBg18PabF5ElKbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTyRRvHG2wM4oR2NJlbr5N6y8P2R8lEsR91OTH6ajxU=;
 b=MxHJXyYQY30kdLieasOcyYRUILB54OFfEuiuslzAf+1JrXOy6jf+BF25z5pybQtg2Ww77xcsUa48Fj8s+D1HCRaxU7aUYFuPtG1TO+Pv5NC+HDEkf4hOjtK1nrO9n20mpeSjiAlsOLYC29Hr9mWZUszvhv+TB4MgYdsJa4XZuQV5GMTdL3b3lBGNZJwV32l9UxA7P7UnaN2qHQy7eGv8cmvzTUgpegHvloVDF13t5pavtVyKNPnRSdJIuFii+t6NKZ60RVxQYPDhSbgCoTJueVSBxgQukPYmbeJtfcrfs4zIuQYoS38Ig0ecn729i6yFuwWNk2VxtFaDbqug3gwWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CH3PR11MB7675.namprd11.prod.outlook.com (2603:10b6:610:122::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 21:44:58 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 21:44:58 +0000
Message-ID: <818a214a-b4bc-4e85-b4c0-2270c736d03b@intel.com>
Date: Tue, 6 Oct 2026 14:44:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: i825xx: Fix dma_alloc_coherent() size
To: Thomas Fourier <fourier.thomas@gmail.com>
CC: <stable@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jeff Garzik
	<jeff@garzik.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20261006143247.54724-2-fourier.thomas@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20261006143247.54724-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:303:8e::35) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CH3PR11MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 20093376-b00e-4ce8-2099-08df23f31100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qZbWSkGt+fyxmo3/QFo6YEO7RYDeaUw7oPNRhSC0gBSVnwj48mZZTRtJKntaIjRFFEpf7UlPph+6lBEHIJU57NE5otGJ4+WLWj+xYVBJnK4Ir+CRS4cUkdBSkv/EjPrL2ZkDlDLMg0mLkpN6ZzfnTcHA45XEuO1UWUi/fNnfEMKTviiy7anaywvEw6VVJb7DX2OysBuC/hHtCic47F3yOPvh6r0sCnKE9hMzadJxjrjXJ4M7JAV+O9EoEuT6tmWbOMpNKMfbkJ98WqlAp4nevOCV8Z8lnrybLSlDH+U22pJYQAiqjRb17NxE3gCHbzf2xMb7s0jYSS/HthY2zXjMmarwx81cyozBLvgsTSyItPydTN5ChpfVOVV99X6eSVJ19Bsldhji69qVlYaK4GkixO95fN9Nqza4oTo6BWuVCcx2mImTtNiOLosXTbkgLzfcowLlE9dQWNrvjMuy7WaLwWICqVvCBL2ABtfl0zqxR6RskmgsieUWpPIQwxoCQHVnh8h03qRjU9fNoiU1+ZulyXut6RkKzBe9kgwL63+VpK3IV0c20R3R6ttOzJnWPQDLOHGsQXAn5sAHteiMNPmaSYHEMU6XPzgx6YvNBAieO5HLa11VuRMy08rmEJW22s9dRMZXTTNXc87J2vPIABmVmPAvO987o96vfvaLvqu28hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2Y1VXI4L1RUWUNRVDYyNHhkeVRpVm8rUWcxSFpKOWtwTkxMS1hJUkhrbG9w?=
 =?utf-8?B?aGRrTXVpaGxVSStLMHJTTUwveFk4a00zVEc5Rms2UnVmU1AxU0tjbmdzME5y?=
 =?utf-8?B?dzBONWJSd0ZmVHZyWlNjSnFiVk1YR2lMb3JxN21ieEdoQVVNTy9jMVk0WStY?=
 =?utf-8?B?TzdhWG90RFZxTHYyZmNzTk1PbEtReWZBQnJuRFdTSkJCTUV4Ry9yaXNwWng1?=
 =?utf-8?B?RStmVUFheTNhYlFtTHNXSG5ZNWNCNWpqMFlrMCs2bkxOand1SHY5NFlYVzEr?=
 =?utf-8?B?TDFqRTU5V0JJTFJHRXdjTWNka2NGSVdXRjdmdTByZnVsL0JOelhSd0t6b3lJ?=
 =?utf-8?B?d0lBVEVvZS9pOUxhWnRaQUdiRDhIRlZrRlMyMXpIaVhjTXQ5cEhzMkFjQlRB?=
 =?utf-8?B?OFV5OTUxeGR2TG9IQlA2Mkp5YlFJam1Rb3YveEt4aTBkR25Lb2JpTi9RYkRL?=
 =?utf-8?B?NWt2UlhIMmNJeVlPZEpHVUpCeDZscXJGOG8zc1VhNy8xUW82Mzhub3VvQVcx?=
 =?utf-8?B?R2htdTBSaTZaR1lPZzFRb2wzU1MxcUxRdkRtaEc0dGVCMkhKenFWaVBFUDhO?=
 =?utf-8?B?TUVRVGJBNDk3aXBhSVVZMklGYWFrYnNZdzZUMktweXZNSTF1aHVZUUxpRlBa?=
 =?utf-8?B?UHEwMWFkZWlaZnU3bHdqdFBhRXFodWRFTXBEU3M2cnQrTzMyMVJ0QVo3SUNJ?=
 =?utf-8?B?SCt6UzRPdGpkUS9WVVg5R1JXcEVKd3pvMUMxMXVsZWRPejZ1MXZTUGhBVVZt?=
 =?utf-8?B?TVZhbUlJY3RuNkltYkVnM3E3QytNekd5Mk5VZm5uQm1Nd1lzM3d4NVpHWkRM?=
 =?utf-8?B?TzZMODUrdHZNUDFwODYvTXRLazd2WGpYQ1FOcVhYN0NLWG5nMlF1aVI1V3U3?=
 =?utf-8?B?R2Uxenh0Ymp5aHNMMVFQQysxdHdWYy9LS1hob1pGcWlucStmdmRvWGt5emJp?=
 =?utf-8?B?U1J5VmxLQXdRUkpEeDBVUUhkWGxLZUpBMXBmcDd2UW81cTdkY0pHZTk4V2Yr?=
 =?utf-8?B?Ky9zVjNIT25JenVtejZwcDZFYXZNeWExc3VLbVJnVmFJQ2RiNHVOUENpWnFV?=
 =?utf-8?B?dnBDOTZSQ0VIYUI5aS9aUnJhR2tYd3VpclpUb3poU3Z0OEpVQk1QR1pGdnBs?=
 =?utf-8?B?Y04rbHRrLzQ4MlFGT3o4VVVzNDNXYXU5QURUclR2N0FOR20yUWo3bnNXV3N3?=
 =?utf-8?B?bGZ0bW5NbXZyTndpT2UzWnFPZVhCMWdwRmhvelJJNjAxVm5DMlBwUGltUzdB?=
 =?utf-8?B?Q25pVXlxbFdvdS9INUdrUXlFWTBtYUFJSmI5SzFzS0ZRY0Y4RnpMWjZ3elpZ?=
 =?utf-8?B?S0RPV3ZteXNzWWQzSFdUSEJGS0hLa0owcC9vVUJWaVMxQ01TMXIyWFFReWMw?=
 =?utf-8?B?S3MxdnBTdE4xUEhPYmU5cTdzUzY1ODF0b28xQm1OQlcxY0VxZXJmL2NJdkJC?=
 =?utf-8?B?a25ERUlUaExEWXRZUWR2ZUtBZFFEVzlQZVBQYkRjQVVqSjF6ZFB1VXhpazVs?=
 =?utf-8?B?d1M0YWpjUHJBUnVTYXlNd0dlVUlRRGMybzhDb2hWa09yNktvcnY3RWJnbnRN?=
 =?utf-8?B?OTUvcW8xZi9zNHlQMW53WGgvWjBrOWFCWllNTFdVb1dHb2V1cHdjTWxtV0hB?=
 =?utf-8?B?aFNMZDFxNVNDYmRHcjZFTHlLQmdjWDAwcUZ6NXRiVTR3TXp4OGVxRWw1QzFu?=
 =?utf-8?B?cFpNeGFVbzdaMzN6NVNjWi8yZXJsYU1vNWNLbzVhWEJtR0k3aTdTb3M4UjY4?=
 =?utf-8?B?YndIanFrRzVpNGJqNDJrYkVVcWl3b1JKWmtmZWdoU1R5ZXBTU2xpQVJqSVJJ?=
 =?utf-8?B?UkltQ2pUeU5ZNTRoQWViUWRGdmFCTUxxeW1CN0d3SEpzeE5pd3htT2lhb2JG?=
 =?utf-8?B?enQvdldaa29laStFRkZnSkZTM3EzWUFUemJYbk16cjB4b0lxUldjZElrMTFI?=
 =?utf-8?B?RVlVT2wxMmRuNVB6c25FWEd4YXZScXlsTmM2REJZcG5ZNzNrRW9DTnRraDRD?=
 =?utf-8?B?WEtjYzZHbFB4SUtMaDBqRzJhcFA3OFJ0Q043Zkxua2JWOFhuSE9Qamw5dVpa?=
 =?utf-8?B?MXJoWG16ckFpK0J0Nk5iSVloYUYzK1dmN0pLWHUzZUdYMWR6MGs5VkhoaDIy?=
 =?utf-8?B?N0hNQlN4bXFQVkhNS0xGZmN2RTZXRDBYTGFXelFDL2krM3Z0ek4xOE5HUGxh?=
 =?utf-8?B?c0QxSHdjSm9vc0w5aGhpRnQ1eVVSK3ZVRzRIcVVoelpDY1pHUGxiYUVHL0Ju?=
 =?utf-8?B?dGY1SUF1bzdVZnkvVXRxRkgxVWRGbG5senF0cjl6dWI5WDNPSHFnU1RyVXAx?=
 =?utf-8?B?dlJ5dlB0Wkl5YkxSMEJXb0U0WTYrbDJHcEp1a0NVY2pZMDJVMHBMU2Z3M0Vk?=
 =?utf-8?Q?aS8aTNy9bpqpzJ+8=3D?=
X-Exchange-RoutingPolicyChecked: Z/37AGNkLcrDbOSet7vtTnGvMj3AnjPTeJevVzPSYLw+yws9VVGZVXDH77UAnJ9PDqb+VQ0izUR4glwYausRrMsc6yZHqBrOtWXHUKzO7ck/nBLZ6DEzjnQplfeacoIiogFMugyHAhNUR9ml0nm90aS2ANowQCoN9EdZViXOtyaUQ7haVs0Zv3bYg4cflklt8W1IrZhGbK06oU1+8LxQ/oGEzZO0QQbKH9ouu/jsgAet8jFOtqKuFGOBM89+pm8vdaKE9Z1hO8VyReMWA8XsGimub/97XUEJhy/RTXhemAfQmljAuaEAtxhJqWPKixauZvJ6HYMcsQG11esezupqoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 20093376-b00e-4ce8-2099-08df23f31100
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 21:44:58.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAM3c9QcXx7kCB0ZAkrfljglmmSZ3Sej5l+sNsARjLzZvCDkY9y5xQKrZjhS6d3z1Lnf11kf64xXPODBgD9LLKUKvNCQTncRPYJJKbaZIPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7675
X-OriginatorOrg: intel.com

On 10/6/2026 7:32 AM, Thomas Fourier wrote:
> In sni_82596_probe(), the lp->dma buffer is allocated with
> dma_alloc_coherent() and with size sizeof(struct i596_dma), and possibly
> freed in the error path with the same size. However, in
> sni_82596_driver_remove(), the same buffer is freed but with size
> sizeof(struct i596_private). This error may leave the freed buffers
> mapped, leaking a resource and allowing the device to access freed
> memory.
> 
> Change the length in sni_82596_driver_remove() to
> sizeof(struct i596_dma).
> 
> This patch was compile tested only, and found by hand.
> 
> Fixes: f2ec8030085a ("Ethernet driver for EISA only SNI RM200/RM400 machines")

Hmm. At first this didn't seem like the right fixes tag. The offending
code was changed multiple times before being caught.

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/ethernet/i825xx/sni_82596.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/i825xx/sni_82596.c b/drivers/net/ethernet/i825xx/sni_82596.c
> index baa598988f47..73e1e153cb78 100644
> --- a/drivers/net/ethernet/i825xx/sni_82596.c
> +++ b/drivers/net/ethernet/i825xx/sni_82596.c
> @@ -159,7 +159,7 @@ static void sni_82596_driver_remove(struct platform_device *pdev)
>  	struct i596_private *lp = netdev_priv(dev);
>  
>  	unregister_netdev(dev);
> -	dma_free_coherent(&pdev->dev, sizeof(struct i596_private), lp->dma,
> +	dma_free_coherent(&pdev->dev, sizeof(struct i596_dma), lp->dma,
>  			  lp->dma_addr);

This dma_free_coherent call was added by commit 48d15814dd0f ("lib82596:
move DMA allocation into the callers of i82596_probe").

But I guess previous to this it was using dma_free_attrs inside of the
probe function and that also appears to have also mistakenly used a
different size.

Digging deeper, this was changed to dma_free_attrs as part of commit
7f683b920479 ("i825xx: switch to switch to dma_alloc_attrs"), previously
using DMA_FREE. But even prior to this it still had the incorrect size.

Strictly, a backport to that old version would have merge conflicts due
to the changes, but it is accurate that the bug exists all the way back
to 2.6.23... Hopefully no one is going to bother trying though and every
currently supported stable release has the current code and should apply
clean.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  	iounmap(lp->ca);
>  	iounmap(lp->mpu_port);

