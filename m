Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C143381AE4
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 03:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701897; cv=fail; b=Jx2LbChxT4mTNJ4lLbYR51nygiuEmjU+QPYifPrYWz1rsRHGh/itsDpOT1wJNvL56VZ1lLMX7/gB8lWmWivT2MsUUTIHv2Ds9FAi5ECwN8Y3qs+I1kV9AaHZ4XWj8VgcLxoeVf6sivZ40tWpGn9AcCZxWCdRf20PpmKulHqhH0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701897; c=relaxed/simple;
	bh=hVcO96LSJ4usi0/daReTCyF+TLWHYfIWrHVuL+t1xIk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pUQ1anZQSRCoTMJ9mXu7iR4yI4K/rMmi2q44Hg5abXOBVO43BaU5p8oV3ir0v3IcyDE3UtoHmV/A5gWb5rnjGye5ZSTCJ7Z+I/yJ4DTygrO7oCv/6R1l0Vp4IAPS/IFE1cEvnBA5j20zTd9ftmw31FTy17icSVDHaQxSIDgD4ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htwqgCT9; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htwqgCT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789701895; x=1821237895;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hVcO96LSJ4usi0/daReTCyF+TLWHYfIWrHVuL+t1xIk=;
  b=htwqgCT9cSaBEG3tLrmvvqUqZBEtHzTFji5ZuFPncBqTMOJETcJ9LlvV
   bNi9ZQLJagj+QgtNhlM5FbgucMEIq0+AKLEWC0AQHHM91s9XokHDhNKV2
   e9aLOnyvrfia2XN6J2sQcJRD1IuurvASlqc6ZD329bJ+OuzReEqbmzwPp
   HBUbbjPFcD8d5+S/jxrK6ohLawtRx1mjyUnLdsog1EJgm9iu6pCbezyf6
   Hfcd+qCl9nO7gPWTEtrUH5ECuejZ/2xTyp6ayfBiEDU88Oz1D5Rv/lQIe
   1avIOA62NgZWhhqLRHQpc3HUJeoe9ga4aSUBF3E/yd9wICAXk4iBj8pog
   w==;
X-CSE-ConnectionGUID: kuGWcEFfSFWI5zIY4wGBJg==
X-CSE-MsgGUID: hwH2O/wBTFmAs2lC3jIIyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="697211"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="697211"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 20:24:55 -0700
X-CSE-ConnectionGUID: sukylHBMS3elxdxw9misWg==
X-CSE-MsgGUID: ITHUJfZ4RoWZVLDhDf5L5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270855959"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 20:24:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:24:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 20:24:54 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:24:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQSerLXlonZ3U0EpwjX0flE75Uahu59xUoC90ooskXM8QPz7QsDmGs/Ampa/AQiE2rVvt9X8rNlC5biVtzc4Q5803lwa/MnBeC+tkyi5mohAGht0Nx4Ub/mLe/4KFprnjd0wyQGiXvqoYukDCMKkK9pg68ZycAoWChymTgF0YwePF48DFodNmI8IxrZ8ZtkhnlZtmWL9KsxdyvQ4aDb0tskkXXp8pXgUj+Y3c6v80giAZtzwNlO+u3Qul1KjmN0EPcx7Vtjl8wsV9rjChoOdboUxCTjUsWscHbBntTNRU/jO/+9DKMYxjuDC+jnNjdgaQmx9yrD1GP44j7quS9cjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nQr2WvjKZAc8UJlHwmk2WyEpBgHUj1XY1SUHvW/O3g=;
 b=imrdx/zKKcXq5M57dZxCBvssSAjHmMkEbVZ3SKEGIrftvdLH/kyq9qZ35h1A/aYVY6D9bmLiWo2uuVRPauP0HDK41Ch0KTSP4DL9HDlNXw/qoaeS4yDRkzbN+8NSfqnc+9bIZvZUt6wCtA8b6RA1Us7nHPnhbJcnRa/Pzr2xZ+iK851zLICT75hBk4XhXv4VI+yOGzsPSokwzr5zVfBrTPdzy5dBTfasS3nMf5ifElmCr8i8Ca3Co+SKg3V5MaN5rMnJv2cxCEsf9iK8XU1JxsO9rzWHxPml9/dVMvHesDcOPBCTvI6W7Db6VD+5s9VoMj7pcRN46ueoYyFzmIjpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a) by PH0PR11MB5096.namprd11.prod.outlook.com
 (2603:10b6:510:3c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:24:49 +0000
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::5a5c:9c7a:cd1d:d687]) by DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::5a5c:9c7a:cd1d:d687%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:24:45 +0000
Message-ID: <3e296c16-1535-4187-8ca2-52ec6390db59@intel.com>
Date: Fri, 18 Sep 2026 08:54:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe: Keep walking on SVM eviction failure
To: Matthew Brost <matthew.brost@intel.com>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
References: <20260917203158.292823-1-matthew.brost@intel.com>
Content-Language: en-US
From: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
In-Reply-To: <20260917203158.292823-1-matthew.brost@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::15) To DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF691668CDD:EE_|PH0PR11MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a961676-9e00-498f-ac65-08df153462ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4D/eaKUvJqZmsnP7CAi2PPe37fr7Yl8PHggWKK38gK6v5Gqwpun3U2Omb1LwLlmJ5hEVAVOtaNuYBsPHIKicPDx2VSIDlYUSbTflhHqvhKpGc7W+s77RoPYNLGlqbgBUyDIeBm6vib/WHWkgS4v1GHB3Z2aZoM71+EjVlnfF7X/f9BQ0Y28O468VJVKugqeWzljwFMD2pH4HRqDWuKmJeB3KarnB38HMxfozqqCITWI7e/QSZrNpfIIHhHt2A9mVF0i2WODa71CDVE3bC6NTAYm1YIkrLfbyVxWs8hKJaqGQcHZ0RIBWGj5LT3z62mzGnxzASae5GFHJeTCCPB+r7YKTBNuTTM81hkYr7UJKDvB9LQ+/li8Mf+RK5fCH5ghDZ8d9ELu1FHqo5sfGYWzoEeTFp1uIj/7uztgoN0zyQlQdhVbp+SK3mKip/kGAbjCSSzPEQfBlItsidK2DIWNhOJM5c4XSOIlKDwQqswIvvwlCacBhR/9cL5DrxjZjfytUxbo+FImk0ECfltCh5rSTEfLHXkG5a411/5eZX2otCNcH++lmizpJvbK3Pk/uXB2aBf34IVlfbKFf4fDQoe/809XqsASYWuO/IYc+PVCh736LIiBFf5wqA8Krw1b8pZmT8vda+3C26St/+9vcP6CGwubJWP6XJG0jW+2P4XpHQWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF691668CDD.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajkyTUY4ZlVVL2grTFJTb2lNNUZIQmYxNVExNG5oVCtQdm1pZXdwdWpCbmg5?=
 =?utf-8?B?UE1RYXk2OUMySEZIbnRsaDhIVkU3c2FvSUk4ZVRUbS8xSFEvWFpGZ2FLcHFa?=
 =?utf-8?B?TFpRN0cwUzAxdWs0NzcvbDdDcUp1QjdSV1lvb2JPbVVVWGhyT2dyMzZSdmI3?=
 =?utf-8?B?MmxqbFFXU1ZoWDg1SG4weFZIcEhsVzVCVjZkdjhRaDV0Q1FkY3JRc095RkJH?=
 =?utf-8?B?aGppRzhlK3l6UFUxM3dNSGR4OGp2amNjUXBlM0FTemV5ZGVZMTFDckNGdkND?=
 =?utf-8?B?WXlyTlo3UnNia2VIWW1CbkF6WTZLY0VWTkJsWDVsbGVBSkVNZXBnUVllNVNi?=
 =?utf-8?B?eWhuQXEzRHh2SUhjR3hqUk1SMVFwSXpKRXhhYUxFZGpnZ3VrdDU2RTBhRm8z?=
 =?utf-8?B?N0RoWVFUUHBnOHdwajVvVkxLd0xnYWhhdkpnSTRYMzJmN3J2aWJVNjBPNURu?=
 =?utf-8?B?S1F2TDcwNzdGaFNZdHc4Lzg4ZmYyNytOdzNrclhLbG1NTEZpRFc2aEZodUUr?=
 =?utf-8?B?M3pySHJwVVdkdlg2VVliUVNRZk82SWhOSVpZeVlPMjNiVGFnSm8xWEZwMUJk?=
 =?utf-8?B?QUJrRjI3ZGl1WjNLUHpzK3NrSS9ucjBxSnYzQUM2NWJzMHpSQ3ltMjhRdkJV?=
 =?utf-8?B?Y05hK2drQy9XRno0RHNXUFA0dkJHTGxkT08rZnREQVQxN2FJelF5dFZtS0VF?=
 =?utf-8?B?UnV6QmJ1NmhWMW8wM3gwK2tyVUxNeEVRMno4bERvM3NBYXdoNFkzU2lUME55?=
 =?utf-8?B?a094Q3lyZ2tjSG5ndm1sL3NqbEdDem80RUVPRUVCWVhPVElaNzNFQlVicXRK?=
 =?utf-8?B?TjNVOHV2SXZ2V1Z2WGMrYVRJcTN6TURzN3gwbkJRdnl1eFRhQ2VoM1pUc3hp?=
 =?utf-8?B?Nm1xNGN6dUZkeS9nYTdYNnQrVnFHS2JJZ243ZHl6QzVlakJpNW5QUUdyVUhD?=
 =?utf-8?B?aWFhS0xsOFYydHZ2SEpncGF0OHlCYU5jMDB0Y05vQVRRT0d0WjV4T3hVZzNS?=
 =?utf-8?B?MEFENldvU0hRaGdWT0p6WGVLOGkwdmt2Z3Brd3JBN0R4OHA0dWdtbGJqeTdY?=
 =?utf-8?B?NmVtc2NyQVhxcnczajFzUVgwNjFqNCtkbi81ZXNKUmRaZHdPYmltUmZOc1Ns?=
 =?utf-8?B?ak1nekxaM3NUL01SbkdiWm1lMi9NVVc1ZW5ucDRPYXlTZjJlK0JPN3loU1RM?=
 =?utf-8?B?Zk9BNXVKVkpRSm9OdWhDNWoxMnJuOTZqa3p1RFliNzIvd1VDd0hObk9sTWFR?=
 =?utf-8?B?NnJwVHFuQ3ZEdmZjOUF6cW9zMDBsRCs5L2dFT0tSS0w3Um16ZnRaRUUxaVJT?=
 =?utf-8?B?aWpIcGhnaExuZHVLTFVMZU0yYlVkVzk2c1dMcWNITGpYTzkzUjZpNjJleHFN?=
 =?utf-8?B?QXhEVFJTenN3ZGljSkpoczMvK2tKRHcyMnlTN3hYSkh4QmdueUQ0RDYrV2Vx?=
 =?utf-8?B?SGVBY1Z6U0hZNVRRSWF3bDJWUi8wckxrVmJEYkUxUjFUbmhhL1IwT3E1Y2Ix?=
 =?utf-8?B?NGl6YlE3WFBLaytIMUlNa3Y3TVUyUlp3eVRpWWpSa1pSaWxweDFyWWJJT3lT?=
 =?utf-8?B?cHhNd0gzMTFjNzZibUoyRTlCUlRQRXpzOGRGTGxYdmVlOFFhM3NuMjJuTm85?=
 =?utf-8?B?K09tQ3Bta2dpM3VFbmZSMTF4L0JTU0xiQmoyeVIxQUdxRG1xT3FEa1V3ZWI1?=
 =?utf-8?B?QlNVNUpWMkZ6SGRXbFUyOHordms0R2xnQjdxbkhtcDZybGR6cGM3dnRVRXo0?=
 =?utf-8?B?QXJNSmlKNkFCdHNkRzNaS0ZVdzRuRXFHd3dZVEFjZG9yY2xzNTdDYlZwRUoz?=
 =?utf-8?B?RjdLWCswSmc4dEdhZU56VWlobTZJVnZMV2ExS3BWVnUvci9GNXYzWXZTQWE0?=
 =?utf-8?B?d2ZHQlp4NXhSenJEUHR1N2daYkUwVWVoSW9SYyt6d1NJWlorU3c5R3pYamhm?=
 =?utf-8?B?NCtybDgwbW51QU1UTWlOZHR1VHhmZXNBMzdRV3FrTk5ldXIrMEN3YmN5Mkto?=
 =?utf-8?B?NWlkNkhseE9HMUtGdkNDZlRBRm9SWFl2ZEJyZzdOa3JNSDdjR0phOGRST2Z0?=
 =?utf-8?B?NTM0aHVFVzRSLzg1WXlXMGF5emVHV1kvOTJNV1ptMWkyTndNSE9KWGdYaklx?=
 =?utf-8?B?SUdZRkNiL3Vza3Y2aHJpMUJUZW1peGdVQ2dRN0kyblM0amM5YnNYcHhzOFZx?=
 =?utf-8?B?R1Frc3FEOXVJSWxTZWZFVmZRSDVBYXFaYUdzS1QyWlNQR29qS3o2OWl2bFVm?=
 =?utf-8?B?TTFKOXBIdnF1YkxaUmhwNndIblhzU3BJWVZVTFBmSVprZ2hUNjFZemlHUFgy?=
 =?utf-8?B?aDltNm9lQW53VlFZT2VQQVRDK21uclBZUXZiS2tad0ZNM0EzangvUUxpUzRP?=
 =?utf-8?Q?+jgQ6rFbRuI1PAFE=3D?=
X-Exchange-RoutingPolicyChecked: etVDH3GDVp3BjjDmFLCEm33SafI1+RpG3zZA5T5ZDvTZUQdF5UXS/DzOfngrE92qCRKKjUwBN7/XhMYy3h9P0ai4rbTz2N5Cdkgg4MyKhMJ9fRJa05jYn+8vAPz98ZzOleFVikWeaDwqTXJ6jP8QFsPD8RyW3GEdrSSfdtJojxPoFQSR3lgFbwriiOJXXHyA/t42+EIAun9pRJVKpyHNasFw2YOu2A7473pFudeiSpDw4LCPvL+rAn0AzI9guVVAtaRLavSekf1KbYohnmxcPyvFj9+Lhjdqf+ceBNW+bELm71zjb9lqIebLstsvPO6BiyKzXUm59YM9gOHN3WmMJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a961676-9e00-498f-ac65-08df153462ba
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF691668CDD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:24:45.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1BmniSvBNanbGLuG+B3AdVJw7r6xVDMAXlgdRwUuC6TKWLnpYhHa0aqukKYirAFMNjw6GvmmG56CK7r/5m4d/xTDNDiOnVLb0aJf/0V8y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5096
X-OriginatorOrg: intel.com



On 18-09-2026 02:01, Matthew Brost wrote:
> The desired behavior for SVM eviction failures, which can occur due to
> various uncontrollable races, is for TTM to continue walking the LRU
> list and look for another eviction candidate. This is expressed by
> returning -ENOSPC from the ->move() callback.
> 
> Adjust the SVM eviction failure path because of races in ->move() to
> return -ENOSPC so that TTM continues searching for another buffer to
> evict.
> 
> Fixes: 3ca608dc7561 ("drm/xe: Basic SVM BO eviction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> 
> ---
> v2:
>   - Only convert -EBUSY (races) to -ENOSPC
> ---
>   drivers/gpu/drm/xe/xe_bo.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 9f3f0cb95afa..f2ab9bf43a86 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1044,6 +1044,13 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
>   		} else {
>   			drm_dbg(&xe->drm, "Evict system allocator BO failed=%pe\n",
>   				ERR_PTR(ret));
> +			/*
> +			 * The semantic we want upon SVM eviction failure
> +			 * because of racing access is keep walking for
> +			 * eviction, which is -ENOSPC.
> +			 */
> +			if (ret == -EBUSY)
> +				ret = -ENOSPC;

LGTM
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

>   		}
>   
>   		goto out;

