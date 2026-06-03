Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0EF1A9B58
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526251; cv=fail; b=YiHH2oNjY3GPRwbZH/KASbeiIv9a11/y5QCgVylIjeEOOxNOjQxTccbXkvCUTKVTtOwASah3LLqw8Sals4UFer3SlmLno1NG/EtxDiy3TTgAu67CkQvqsOUJU2yg4mkIsjocoy11X1b7hcLMTz/s+6z2anzzsifYo+gp95xMfLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526251; c=relaxed/simple;
	bh=h07e/8jvnYW0pN92FT1EztgpHqR9Mxv0WVzDA6djcrE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UmVXgoFudMxBuSICCENeN56jPIzdEdHzV6kk0uJJWavnewlbGDzpj7hG1riAJLyDms/pNEJ4WXD3lalDl/AQvir7JNg+bFHcs9DAlSTUbmxdN0OxzxwBqLhmAYyQCKoc53T45PAxTNqzPAa6S0YvFp1YHS3MLjqluaSVtkQLCjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CB1hnAKt; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CB1hnAKt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780526249; x=1812062249;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h07e/8jvnYW0pN92FT1EztgpHqR9Mxv0WVzDA6djcrE=;
  b=CB1hnAKtS5KFgAj/s2Ppws7LVEis1amzEc87eTxIy5c/p1JpZon4ERn8
   vPvcDYIapJnuYKyTOAxKKMVYpiUPa6KPYsRT8h6MsRyK8NKzX1gwY+N2J
   WXvPrUblxM3pZQainhEnFp8S5EvDjd+frQ44HTBy/B/HjnEKZDrMUfgkF
   Yn+RBggZH8n3Jb0+fFW5FqAg5fdIzBksS1n8WZ7GeWKQzOrlm09eS3XFr
   u/TJpK9E/9fpMoTUxO9pFyy+ooFisgNYG1o2BOj79VihZX02vr3NP7pj9
   CcihizQcw2rWdAHSxgyJqh0KLW0Wt10kAGxmVR9qTiuHxvkl+yz7B+Fex
   w==;
X-CSE-ConnectionGUID: XIDBIgP9TeCHcBxyC9/w8g==
X-CSE-MsgGUID: LjRFhCmhRIWSHSGHKH0Ikw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="104010934"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="104010934"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:37:29 -0700
X-CSE-ConnectionGUID: UZl0YiMcSBSbGil2dvRKGg==
X-CSE-MsgGUID: dsQoPzO7So29te+Gx2pR/w==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:37:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 15:37:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 15:37:28 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 15:37:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZ28ubt6nlLXZntIGcRscB7wdOsM9paR80eOgNUmtPKW8f5yR+zMY6Jqftypb6MGjmF7JJwOvoYpciw/xz76UlOY2KJTu3Q3MaAzQ7hmI6+pV3+0DwOw1KNeRBgDxyQwPLDGIDC8zulK7v+U5fSyqKWz04wTxoH1WgQ2qska23pMo3Pmrd/WtspLskE8EzseLjKlPHtmQAq5rDpuLSl5O1JeCys8FRUfbVFPrauI19On5x5GGE2ny7PdMAuEdzgT9wN+BeREiIX3kmyldABxVAd4OGSJbPqUYAFx3Mxv9P1Pvb1S24oa6gv2CcFHvdqId+7jIoUGb/VnbpekKTp2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEdcw638TfEZ6Ee5GdyMt3NeQVYDrcN5WVEt6dk1GbM=;
 b=VtTSoeHZsgbS3r6TQTJNu/M35KySw7Q+LvKzgxzQ0EDgpueblQldqsvnYkUGUQqcAG7EBL6r5IqI+ehXG8MHDqzGSdbrpSCntmcVtkBmIG877EeG9XOUQIan07SPzLw6h+erwh0QuJ8McICX4AwGgr0iZPzPdYzY9jgNCEKmsWlX7iVtaGUWPsMzkZ1d0mGVV7gjORZIMUEbZT7mGdNfUTETbIs19Hr32Ky3KfDo8Q9OwlCfVxDTQC+x439cyIBcATuFdk0OBrmODVaugR3L6k9GSVxCP3G7IwTusJWBw7hy+yx3ibz6TwjceGRMh7n0Q9QjI43Z7qZQkuMO1vseZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF46B98A11D.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::23) by SA0PR11MB7157.namprd11.prod.outlook.com
 (2603:10b6:806:24b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 22:37:20 +0000
Received: from DS4PPF46B98A11D.namprd11.prod.outlook.com
 ([fe80::5a0d:e357:ce45:3963]) by DS4PPF46B98A11D.namprd11.prod.outlook.com
 ([fe80::5a0d:e357:ce45:3963%8]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 22:37:20 +0000
Message-ID: <aa3e85ec-58f1-433d-b2c6-29c25b8f0a2e@intel.com>
Date: Wed, 3 Jun 2026 15:37:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe: Add compact-PT and addr mask handling for page
 reclaim
To: Brian Nguyen <brian3.nguyen@intel.com>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>, Matthew Auld <matthew.auld@intel.com>
References: <20260601234136.1444344-2-brian3.nguyen@intel.com>
Content-Language: en-US
From: "Bai, Zongyao" <zongyao.bai@intel.com>
In-Reply-To: <20260601234136.1444344-2-brian3.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0160.namprd05.prod.outlook.com
 (2603:10b6:a03:339::15) To DS4PPF46B98A11D.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF46B98A11D:EE_|SA0PR11MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0e507c-0536-4fb3-5a23-08dec1c0ac59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: M386Nnx5Exoit+ZiyUKQ1c2BwW4iiE//cZpl8HyFlOju4Z2xNLA4eXW9rYNPXKQ42x5r6jEjdok4JjQpqvmxtqsCDpXPFQq22BNGI2Uxqjm389K+m8cSSv/UgiuLlnNlM4dYsWRtyb7GHOftJLooUzPoHVq0q1AALOPnbnQtPA1cd5Hp2gq7HDCv9dwQsmZX0CRsTj0MkUHQi8uKJlT1t6x94aboyEw3gzXq+rzIi+nugxH5xL12pe3g/D1kqpu4YHPhw1HgFUYbDBi7zksu8ON4nvAJ2Ty2+7L7vScCyk1OXM/GMhJYIqE/qSghHcI6lzuaffQvKb+cZc3nGwv/27MAKqJQ6Z1VFiaddnkXsuuA+A5o1AUQ+M1w8R+Oo+lrnEztY5Pn2zE5SGBLPvmX5yyNZrvX6fGqlDQbWDVNO5nBSkjeiEaz56bqLAs0nFEVhsvAGXqIYBAEN6bMocE6S2RCoddxLCMZ8xJ4Bad37lKG/IxeB7Po9iDkm+LiWwH0WaYqK2tfDLPL0L+C4ssiverD9EiC+8RK2Puq3UvWphMESrYU9iKeQ8kob/AGFVSz2TYRpOCb2BnzZ+Lp/4fk6K9G886tkdCCyPD58j84bpTJ58W3JCJa0RGDltOqsNCSYHUWHw/i1O4acVs61ZN2ehYVI0zlBETT0S9+Z1BpgEhKIgnqdCYm/I2pOoIySuk4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF46B98A11D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE0zZnZBbVVyL0dyT01RVUJ6WVlJVVFOb2Z4c3RsV1kwZktlREozdmZZNUho?=
 =?utf-8?B?NExONlhEU3d3cDY3c1E5SzIzT0s5aGlueE5vNFF4UTBqWk9mckVZYTVubitJ?=
 =?utf-8?B?Qi9sMzZFVit0RFkwRWVqT2FvQ2xBUDBoRHRpOStSRzhvc0gvNytPTzRTQ3ZG?=
 =?utf-8?B?REpDT0lFVHN1eVZHRWFHT2xYVkRzRW1HQzF5OFk4TjBZSFA3VEZld0VNRlov?=
 =?utf-8?B?RllPa2U5NFArUG00bkpOVnQ4MFNDYW9LUDFlOUliQkw0clVjWkV4WlNRVk00?=
 =?utf-8?B?K29KVFUxY1JPRFQ2cHVSMVErYVNLV0x6S2NjVVFONmZHbnRnYlBlQWVFMFIy?=
 =?utf-8?B?N0VKQStNY0V0Vy9xVU1TYVJ0OVdwbVRZMjFodlRvbEN5UkNsejIzY0dGekE2?=
 =?utf-8?B?bnFwTy9OUlluZzh5MU9CdDk1RUlkSE9MdUgzQjNnR2pwVDN3ZXJFTC82TUhD?=
 =?utf-8?B?UnA1dWl0MGx5SWtKcVBGbHF1Tm1UTS91c2J0UnRnaFNQTWx3bHVBYm83RkNn?=
 =?utf-8?B?Z01GZGdNdm5EanZxY1MyZHhwSmRFWkdUUVF5Tk0rSmZpMUdMTG84UjQyU0w4?=
 =?utf-8?B?T2NwM1M5Q1pQdTZoSzJnTXVjU1BjR3ZQNjk0ZCtRM21LcElRam5adjhqQ1JD?=
 =?utf-8?B?N0ZTOTFoMVI4elVVWFpETG5LSjh1VzE3WmtlNUlPTFZXUm9VaVdPL084ejhN?=
 =?utf-8?B?a0dhREdFZW5LUi9XMnFrY3R3L3lSTkwvSGdEc0xWZ0V6bUI5VzhSTHErV3pt?=
 =?utf-8?B?elQzaVpaYjJDYWVrS2FkS2ROQkovTzZhL1ZHL0lPcFFFSGNmQ1FjRUNvQXpP?=
 =?utf-8?B?Y3ZCdHh4RXN5WnRYS25XUFJhcXY3RklFQ2l0Y0lDRW5Mby9ZVEFXeHY3T0ll?=
 =?utf-8?B?SFd4Z1gvc09EQm1MRzZqNkpqbjFRVS9vRm5QSlpmVUErK1BVdUlDTWhlUnMx?=
 =?utf-8?B?b21hcE9LaGtIMnVhbTYzRXZ5Yy80ZnBzQ0JGV2c0MTlzYm5WWGNIaS9YdGtJ?=
 =?utf-8?B?MWwyWDJjeDFCaFZ5VjgvWG5LZk5aS1cwdWtmWU9Xbm1QTTc1MmNjQTNzVmVr?=
 =?utf-8?B?STZ4Y1FqdzNESWczOUhTM0xubHdqZXhFNFdkTmczTytpOWVlTnhFcGNxdkpN?=
 =?utf-8?B?dG50dDZkQnM0alZ4dFYvTk96c2R0LzFmUnIreXFBUGIvQVgzOXR0cFdrVE9J?=
 =?utf-8?B?R2VuaHNLbzB4TWZkclFBUlNmR21tR2FEUXNpTmN5T2RLN2ZRNjB1L01sNEky?=
 =?utf-8?B?MUo4SHh2YVhRVmpYU01KNVBWL3RHT2RCTkJiUWFOQStvY3AwMlhySG53K3ph?=
 =?utf-8?B?TWZTdHdLV3BONWdqcVZDU3c3aFRmKzdxVGJISXRueFQ3Vm1uREpuRHg5ZDlx?=
 =?utf-8?B?c0FaVDBjZG5OcFhLeEt6N05mQ2RMSWpFVDNOeUw5T25yZ1Q2N0hkMlRwSXFL?=
 =?utf-8?B?b2c3WGRrR0xoM1RaTHQ2VlY4RDhlbWRlMmdXenhBZVIzeHV0MWRmRHdPZ2Ju?=
 =?utf-8?B?eGZFQmkrc1Y3dGNGR2ZIeGtCV0xUM0lsTzQ4bC94V0lzTTlIdXpaejRlcVgy?=
 =?utf-8?B?ZVZ5OUZaaGNLek9mVHVWb2M0N3A4dGpzdmhNSTFyS2ZtSFJUQ25iQ0VQOWlG?=
 =?utf-8?B?enRvSys3bjRZRW1sdWVpM1BFNHE4YUdGVktncUZzeFB5T01CRUdUR2RrRDlC?=
 =?utf-8?B?VkxoRno3Q2JaeXdlT3llYnBFNm9iTE9GajFnZ3pLLzlNRFM2WGtHZmk3M1A3?=
 =?utf-8?B?Ujc2THpwNmlaa3Q0bWhlSGRXOXZoMjdIQ1QzRTVvbFd6OFpJaEhCRDBrNkRj?=
 =?utf-8?B?ak5UdjJleFJMbGMxZnozWGIzTW42UjRDSEg2OHRjSnFOK3Q1Y2svengwZVlF?=
 =?utf-8?B?Nmw3THQyUUlsbWZRVFBtOUdPUWZxWTBrbXpSKzJQRjRsN244WWZoWlZHTVVo?=
 =?utf-8?B?RStNbGFOQkIxRjVLcUJjek5PVkRNbmV6L3RycCtNaklKd3kxNEJmOExBMzJo?=
 =?utf-8?B?MzcyOHdiZjIrMDlsZGk4NGFxQnNZbDdCVTg0M3B0Ry82VlVtUU1nVHNiV3Q5?=
 =?utf-8?B?dVFHeHNFeWVpWDlPallWRjNGY25URUliMEgyM0pGZTkyVCtpOFdQS0x2SGRH?=
 =?utf-8?B?aDRyY1hOUllZV245Q1U4d0N5U1J5L0xpVnczSCtLcTNSbjlEdVdZQXlVcWR2?=
 =?utf-8?B?a1lpbVlIZ1ErcWMyZDBuTXdtNFk0bFgwZ3ZYa2I5UWZDUUo4RENGMHJWWXZS?=
 =?utf-8?B?RW1RRmU3MS80RHlGd2Rwcmcycnk4MUxjOERiamREOHBtZ0ZoR0hlaUUzcDRB?=
 =?utf-8?B?aWdReVRlWVVzQTFsKzE2NC81MHI2SndaWEt2RkhXbDJGeUYvSUFZZz09?=
X-Exchange-RoutingPolicyChecked: o0dmBUGQZU8minauRaKA+tmpmTOFaXpyNOxHfV67J0DDQ8LOGJKUr5tPkX6QCncY0XFuzs+R87TT7vileltOQ89XRK2UeWN6jRyDpOINsU+ozrGGu3VFxDMKqgDa7opEw5PahNvkYA9fHCP/9/oaWm9uHVPHAGib5VQ4zcoxPnnOEMj8qXwfh4m6C00zBkKYVBgwV/t5ZxP1PLOjIDAOhxyVOLEVV8sFgB1BzHgpD9naaRJ3msLpHqIUjIEIifP7M+4u965x530gwfs2MgJUk5RFnLIODqZFG5EgWDtMmZa8VtfZL9XS2ycnfPuUMGd+O4B27hSxdVc73Qp+tyrAOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0e507c-0536-4fb3-5a23-08dec1c0ac59
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF46B98A11D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 22:37:20.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9J46P8pkSsRLwkm3NJks1eU8FTmHrNR68MUTbVEYjG66PZyalO3fEJlGGlntZCMhdhdeWWhIoSPL9DNStk84pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7157
X-OriginatorOrg: intel.com


On 6/1/2026 4:41 PM, Brian Nguyen wrote:
> Current implementation of generate_reclaim_entry() overlooks some
> differences between the different page implementations: address masking
> and compact 64K page handling.
>
> Address masking of each leaf varies depending on the leaf entry size.
> generate_reclaim_entry() is using XE_PTE_ADDR_MASK [51:12] for all leaf
> entries. For 2MB PTEs, bit 12 (PAT) is part of the flags so the old mask
> corrupts the physical address extraction.
>
> 64K pages can be represented as PS64 and a compact PT, which the latter
> was not handled. Compact pages aren't walked by the unbind walker, so we
> separately walk through the compact PT to ensure none of the leaf 64K
> PTEs are dropped. Previously, compact pt were causing an abort since it
> was considered covered and not descended into.
>
> v2:
>   - Update 64K entry/unbind walker for 64K compact PT handling. (Matthew)
>   - Rework calculations of reclamation and address mask size.
>   - Add new func abstracting the error handling before generating the
>     reclaim entry.
>
> Fixes: b912138df299 ("drm/xe: Create page reclaim list on unbind")
> Cc: stable@vger.kernel.org
> Cc: Matthew Auld <matthew.auld@intel.com>
> Suggested-by: Zongyao Bai <zongyao.bai@intel.com>
> Signed-off-by: Brian Nguyen <brian3.nguyen@intel.com>
> ---
>   drivers/gpu/drm/xe/regs/xe_gtt_defs.h |   2 +-
>   drivers/gpu/drm/xe/xe_pt.c            | 129 +++++++++++++++-----------
>   2 files changed, 77 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/regs/xe_gtt_defs.h b/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
> index 4d83461e538b..5fa2d8ab7776 100644
> --- a/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
> +++ b/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
> @@ -9,7 +9,7 @@
>   #define XELPG_GGTT_PTE_PAT0	BIT_ULL(52)
>   #define XELPG_GGTT_PTE_PAT1	BIT_ULL(53)
>   
> -#define XE_PTE_ADDR_MASK	GENMASK_ULL(51, 12)
> +#define XE_PAGE_ADDR_MASK(shift)    GENMASK_ULL(51, (shift))

Zongyao:

XE_PAGE_ADDR_MASK(shift) is clever design, but hard to understand.

Would you mind add some comments here?

>   #define GGTT_PTE_VFID		GENMASK_ULL(11, 2)
>   
>   #define GUC_GGTT_TOP		0xFEE00000
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 2669ff5ee747..68a911ab9216 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -1602,23 +1602,21 @@ static bool xe_pt_check_kill(u64 addr, u64 next, unsigned int level,
>   	return false;
>   }
>   
> -/* page_size = 2^(reclamation_size + XE_PTE_SHIFT) */
> -#define COMPUTE_RECLAIM_ADDRESS_MASK(page_size)				\
> -({									\
> -	BUILD_BUG_ON(!__builtin_constant_p(page_size));			\
> -	ilog2(page_size) - XE_PTE_SHIFT;				\
> -})
> -
>   static int generate_reclaim_entry(struct xe_tile *tile,
>   				  struct xe_page_reclaim_list *prl,
>   				  u64 pte, struct xe_pt *xe_child)
>   {
>   	struct xe_gt *gt = tile->primary_gt;
>   	struct xe_guc_page_reclaim_entry *reclaim_entries = prl->entries;
> -	u64 phys_addr = pte & XE_PTE_ADDR_MASK;
> +	bool is_2m = xe_child->level == 1 && (pte & XE_PDE_PS_2M);
> +	bool is_64k = xe_child->level == 0 && ((pte & XE_PTE_PS64) || xe_child->is_compact);
> +	u32 page_shift = is_2m ? ilog2(SZ_2M) : is_64k ? ilog2(SZ_64K) : ilog2(SZ_4K);

  Zongyao:

About "is_64k", 4K align with "XE_PTE_PS64" ensured by "xe_pt_scan_64K" 
is also hit. Although it is right, but suggested an assert() here:

if(xe_child->level == 0&& (pte & XE_PTE_PS64))
xe_tile_assert(tile, !(pte &GENMASK_ULL(15, 12)));
> +	/* Physical address bits start at page shift: 2M->[51:21], 64K->[51:16], 4K->[51:12] */
> +	u64 phys_addr = pte & XE_PAGE_ADDR_MASK(page_shift);
> +	/* Page address is relative to 4K page regardless of entry level */
>   	u64 phys_page = phys_addr >> XE_PTE_SHIFT;
>   	int num_entries = prl->num_entries;
> -	u32 reclamation_size;
> +	u32 reclamation_size = page_shift - XE_PTE_SHIFT;
>   
>   	xe_tile_assert(tile, xe_child->level <= MAX_HUGEPTE_LEVEL);
>   	xe_tile_assert(tile, reclaim_entries);
> @@ -1633,18 +1631,15 @@ static int generate_reclaim_entry(struct xe_tile *tile,
>   	 * Page size is computed as 2^(reclamation_size + XE_PTE_SHIFT) bytes.
>   	 * Only 4K, 64K (level 0), and 2M pages are supported by hardware for page reclaim
>   	 */
> -	if (xe_child->level == 0 && !(pte & XE_PTE_PS64)) {
> -		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_4K_ENTRY_COUNT, 1);
> -		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_4K);  /* reclamation_size = 0 */
> -		xe_tile_assert(tile, phys_addr % SZ_4K == 0);
> -	} else if (xe_child->level == 0) {
> -		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_64K_ENTRY_COUNT, 1);
> -		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_64K); /* reclamation_size = 4 */
> -		xe_tile_assert(tile, phys_addr % SZ_64K == 0);
> -	} else if (xe_child->level == 1 && pte & XE_PDE_PS_2M) {
> +	if (is_2m) {
>   		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_2M_ENTRY_COUNT, 1);
> -		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_2M);  /* reclamation_size = 9 */
>   		xe_tile_assert(tile, phys_addr % SZ_2M == 0);
> +	} else if (is_64k) {
> +		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_64K_ENTRY_COUNT, 1);
> +		xe_tile_assert(tile, phys_addr % SZ_64K == 0);
> +	} else if (xe_child->level == 0) {
> +		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_4K_ENTRY_COUNT, 1);
> +		xe_tile_assert(tile, phys_addr % SZ_4K == 0);
>   	} else {
>   		xe_page_reclaim_list_abort(tile->primary_gt, prl,
>   					   "unsupported PTE level=%u pte=%#llx",
> @@ -1665,6 +1660,48 @@ static int generate_reclaim_entry(struct xe_tile *tile,
>   	return 0;
>   }
>   
> +static int add_pte_to_prl(struct xe_tile *tile, struct xe_page_reclaim_list *prl,
> +			  struct xe_pt *xe_child, u64 pte, u64 addr)
> +{
> +	/*
> +	 * In rare scenarios, pte may not be written yet due to racy conditions.
> +	 * In such cases, invalidate the PRL and fallback to full PPC invalidation.
> +	 */
> +	if (!pte) {
> +		xe_page_reclaim_list_abort(tile->primary_gt, prl,
> +					   "found zero pte at addr=%#llx", addr);
> +		return -EINVAL;
> +	}
> +
> +	/* Ensure it is a defined page */
> +	xe_tile_assert(tile, xe_child->level == 0 ||
> +		       (pte & (XE_PDE_PS_2M | XE_PDPE_PS_1G)));
> +
> +	/* Account for NULL terminated entry on end (-1) */
> +	if (prl->num_entries >= XE_PAGE_RECLAIM_MAX_ENTRIES - 1) {
> +		xe_page_reclaim_list_abort(tile->primary_gt, prl,
> +					   "overflow while adding pte=%#llx", pte);
> +		return -ENOSPC;
> +	}
> +
> +	return generate_reclaim_entry(tile, prl, pte, xe_child);
> +}
> +
> +static bool add_compact_pt_prl(struct xe_tile *tile, struct xe_page_reclaim_list *prl,
> +			       struct xe_device *xe, struct xe_pt *compact_pt, u64 addr)
> +{
> +	struct iosys_map *map = &compact_pt->bo->vmap;
> +
> +	for (pgoff_t i = 0; i < SZ_2M / SZ_64K && xe_page_reclaim_list_valid(prl); i++) {
> +		u64 pte = xe_map_rd(xe, map, i * sizeof(u64), u64);
> +
> +		if (add_pte_to_prl(tile, prl, compact_pt, pte, addr))

Zongyao: the addr is not increase during the for() loop,
                  then the debug print is not point the precise addr:

if(!pte) {
xe_page_reclaim_list_abort(tile->primary_gt, prl,
"found zero pte at addr=%#llx", addr);
return-EINVAL;
         }
Maybe the size_XX addr is the wanted value for debug. I am not sure here.
> +			break;
> +	}
> +
> +	return xe_page_reclaim_list_valid(prl);
> +}
> +
>   static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
>   				    unsigned int level, u64 addr, u64 next,
>   				    struct xe_ptw **child,
> @@ -1674,21 +1711,22 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
>   	struct xe_pt *xe_child = container_of(*child, typeof(*xe_child), base);
>   	struct xe_pt_stage_unbind_walk *xe_walk =
>   		container_of(walk, typeof(*xe_walk), base);
> -	struct xe_device *xe = tile_to_xe(xe_walk->tile);
> +	struct xe_page_reclaim_list *prl = xe_walk->prl;
> +	struct xe_tile *tile = xe_walk->tile;
> +	struct xe_device *xe = tile_to_xe(tile);
>   	pgoff_t first = xe_pt_offset(addr, xe_child->level, walk);
>   	bool killed;
>   
>   	XE_WARN_ON(!*child);
>   	XE_WARN_ON(!level);
>   	/* Check for leaf node */
> -	if (xe_walk->prl && xe_page_reclaim_list_valid(xe_walk->prl) &&
> +	if (prl && xe_page_reclaim_list_valid(prl) &&
>   	    xe_child->level <= MAX_HUGEPTE_LEVEL) {
>   		struct iosys_map *leaf_map = &xe_child->bo->vmap;
>   		pgoff_t count = xe_pt_num_entries(addr, next, xe_child->level, walk);
>   
>   		for (pgoff_t i = 0; i < count; i++) {
>   			u64 pte;
> -			int ret;
>   
>   			/*
>   			 * If not a leaf pt, skip unless non-leaf pt is interleaved between
> @@ -1698,10 +1736,20 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
>   				u64 pt_size = 1ULL << walk->shifts[xe_child->level];
>   				bool edge_pt = (i == 0 && !IS_ALIGNED(addr, pt_size)) ||
>   					       (i == count - 1 && !IS_ALIGNED(next, pt_size));
> +				struct xe_pt *child_pt =
> +					container_of(xe_child->base.children[first + i],
> +						     struct xe_pt, base);
>   
> -				if (!edge_pt) {
> -					xe_page_reclaim_list_abort(xe_walk->tile->primary_gt,
> -								   xe_walk->prl,
> +				if (edge_pt)
> +					continue;
> +
> +				/* Walker never descends into compact PTs, descend now */
> +				if (child_pt->is_compact) {
> +					if (!add_compact_pt_prl(tile, prl, xe, child_pt, addr))
> +						break;
> +				} else {
> +					xe_page_reclaim_list_abort(tile->primary_gt,
> +								   prl,
>   								   "PT is skipped by walk at level=%u offset=%lu",
>   								   xe_child->level, first + i);
>   					break;
> @@ -1711,37 +1759,12 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
>   
>   			pte = xe_map_rd(xe, leaf_map, (first + i) * sizeof(u64), u64);
>   
> -			/*
> -			 * In rare scenarios, pte may not be written yet due to racy conditions.
> -			 * In such cases, invalidate the PRL and fallback to full PPC invalidation.
> -			 */
> -			if (!pte) {
> -				xe_page_reclaim_list_abort(xe_walk->tile->primary_gt, xe_walk->prl,
> -							   "found zero pte at addr=%#llx", addr);
> +			if (add_pte_to_prl(tile, prl, xe_child, pte, addr))
>   				break;
> -			}
> -
> -			/* Ensure it is a defined page */
> -			xe_tile_assert(xe_walk->tile, xe_child->level == 0 ||
> -				       (pte & (XE_PDE_PS_2M | XE_PDPE_PS_1G)));
>   
>   			/* An entry should be added for 64KB but contigious 4K have XE_PTE_PS64 */
>   			if (pte & XE_PTE_PS64)
>   				i += 15; /* Skip other 15 consecutive 4K pages in the 64K page */
> -
> -			/* Account for NULL terminated entry on end (-1) */
> -			if (xe_walk->prl->num_entries < XE_PAGE_RECLAIM_MAX_ENTRIES - 1) {
> -				ret = generate_reclaim_entry(xe_walk->tile, xe_walk->prl,
> -							     pte, xe_child);
> -				if (ret)
> -					break;
> -			} else {
> -				/* overflow, mark as invalid */
> -				xe_page_reclaim_list_abort(xe_walk->tile->primary_gt, xe_walk->prl,
> -							   "overflow while adding pte=%#llx",
> -							   pte);
> -				break;
> -			}
>   		}
>   	}
>   
> @@ -1751,7 +1774,7 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
>   	 * Verify if any PTE are potentially dropped at non-leaf levels, either from being
>   	 * killed or the page walk covers the region.
>   	 */
> -	if (xe_walk->prl && xe_page_reclaim_list_valid(xe_walk->prl) &&
> +	if (prl && xe_page_reclaim_list_valid(prl) &&
>   	    xe_child->level > MAX_HUGEPTE_LEVEL && xe_child->num_live) {
>   		bool covered = xe_pt_covers(addr, next, xe_child->level, &xe_walk->base);
>   
> @@ -1760,7 +1783,7 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
>   		 * we need to invalidate the PRL.
>   		 */
>   		if (killed || covered)
> -			xe_page_reclaim_list_abort(xe_walk->tile->primary_gt, xe_walk->prl,
> +			xe_page_reclaim_list_abort(tile->primary_gt, prl,
>   						   "kill at level=%u addr=%#llx next=%#llx num_live=%u",
>   						   level, addr, next, xe_child->num_live);
>   	}
