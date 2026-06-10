Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BFF34676D;
	Wed, 10 Jun 2026 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112160; cv=fail; b=kzYWczLGFrU1IAHaKCbbIHCy7Wj8xopuhZgmqSTfiwdINf7gE9lxECzrOBcyQoz75+/JOtFNEx3OVzr6tsBVzZt8Z5R0fMsInd8lggRwbIDmzXqpjSp6pKq25VFvG/c5g8snLf57Y85DO4wvbG64Esvdaj5yqP6ZbcOctG9XUAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112160; c=relaxed/simple;
	bh=mB30kZtvRMh5cMh0rwllvISoPeAJQhmkpPvkvpTFNk4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W0NjWBnCgQIKLKjiTnyeKSHmmFcNMrrJukjoYdBdYhPUFERqiegx2Hp9v3guGaroQGloqeFVQldd1E6Aalh58vp5yJbHI4ukfrKKOjUlPPPGreqnu7n6cy21ofj3z78HsCu38Vn+w//J29/dC9wLfgtSDjhp5wf/2qct6OQhgJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XypniIay; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XypniIay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781112158; x=1812648158;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=mB30kZtvRMh5cMh0rwllvISoPeAJQhmkpPvkvpTFNk4=;
  b=XypniIay6yIc2MPTFGbHNJb2RGdxV/8rgjkR5RuQUc+jqipJWKT/AkLh
   1fEekDGB0MEjfebAlKBwBk1JsdtYR9gKliGjfFyNMAa7aER0LpPCM7Aw8
   yeqfWsFADU0FpEbHHmcAEaWp8ZNjDp5/7xByg06JNKpxp7/6dDuxqX3CO
   +X4CD067FtKZ1k3Iq3fkVSK3TUKcSWlff+zvNKWN6cBUES3UEWiQ1Ymmc
   pXrbJOZnnSnu0OteI1i1pXwQY7YMISbXglAhDL8kkgKk4SKEvYoGzjua7
   ieb+RGDNYxs/k/kAapWSoi5WiWJFfMDunDvTYsUNz7WyNeTUvqXnmeqpv
   g==;
X-CSE-ConnectionGUID: fwPh5lMhQKKRCnt/7jyCOw==
X-CSE-MsgGUID: t5cs9PUEQEGxj4oLU3CPUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93302222"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="93302222"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:22:38 -0700
X-CSE-ConnectionGUID: /sWXqxdgSYW3m3+3OZNvwQ==
X-CSE-MsgGUID: jBONHjidRS+EVv3Am3LaBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="241819167"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:22:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 10:22:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 10:22:36 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 10:22:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZSdWw30nEvtJpj/tomFP9eg41Klxi18e8etFwacF7tBov0kraJucKf4/5AiywqMDW0qrOf2ovRY6hVxvLyJw4SoqYr9ezWXmpAxlAqlCzMgDdVm8GjuPJwwNpiwB7HPR5Vsf5nyOaxQnotjIUynlW3hKyd1F0uE4WXLG335G93NvYhrMURtTDDhsYfjqGLt7zALRX/+ptAouZnDPx94IHlVzQW0Ew6qZagfwotIe6OKW1KBwonwWCyEzDAUrn5b/Tmp45vJw5YCbgp1QhAIvhj5qujzqKF5d7KU06q6ZN4EeNtZ9PT0fq/WTRhfO0+TuB75zk/D0C8j5n/cxSCDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IMSvyshK52mvT4lbXzdLZk+4F45yHTfR9aRTM+xNmk=;
 b=QIbDiqOOHaHkn9jPUv/B4YnJsUJIvIZx9C5VQT48MnE60/F7GHy7PamjVJO6Zgvy3JPTcfexUlhHb3oP3Gfwz1vIsdQhUbR74u30lNWTBP4BMz0NsKqtqfgLh6jNr7ku9CgfqdyTuN1eorfW0sNSkAw6v5BP46abIQOPvVvKwk40IP0ah1CzXalfNOGJ/Y+9+cR2BQLLnQDdeFBzbexdq7Mm/a1FkbZh7UAphqGtCI8Y1el04hFCl6v5B/Z3jA6ipG/q/27kntHREmrjqCqFPxz6moEQUWahTnZ4r0zsSzfZY/TDXNJ9JZSZ4Bzxr78nTXYFIrGlJM6EfYNsjn0zjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA1PR11MB7271.namprd11.prod.outlook.com (2603:10b6:208:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 17:22:34 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 17:22:33 +0000
Date: Wed, 10 Jun 2026 10:22:31 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: fix refcount leak in xe_range_fence_insert()
Message-ID: <aimdV7gLS6fFj2U8@gsse-cloud1.jf.intel.com>
References: <20260608061540.121355-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608061540.121355-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA1PR11MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: d60cfb1d-a535-4d08-2e74-08dec714dbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yWfDNSC1+eHK+ZT5D7PyrXyt5vfsZrxPZ7X1KzDNUa+/+1dQTGle1+V00d1U+spH9bcqvW2dWv/rgglm8bzHCByw9xH3+rYDTkWG79/5gxGypDqSIKHKgSm0UoItdTlED8hFxykGCS9YYqzol8sOVujfGvO8tCou3j3fSl7+0cUTnJ04r5AJx94AhZCsUamoHzSzRNKC9OwtWG+xkoYw10MGeasiD5qd/nRzem7oSZhbAL97xs2zSYZoUuRF2GT5ZXctjgVoVlsg+uvRt8P6uqseTCajVInMlk3VMqEe/AlGpNp/sriBdV3d131x1AbtD1KW4eo3arjaChpXtRuL35cFgSWYTm8PMZvwgLy8falTCEwwLxDDmkSw0BIVdAmBLcWqvlPvAkS6UlCQnEM029UXjCYg8/T0AurQqJrAWG2k9YDjZ9qpnozEfiKGZcU+XdOFazumS8+6N4lB1c1Ck3z5hafIBQWQ92r4F6d6zcSsTBVCK+MHnVg1VS+Ah/ovfuSB7HUBIdk+Rgb+X5sEO9GOS7OLfKENdFHgnGyIzTD8CYeAmzJ4b3xpzO/E03U0bSN1zQP0HyD6gvLqB+10LFR1fk925ufquqXV/uGWDpXNjZp0Y1pj4W0YSVqc0UpjcFXQC5ZEqIkS1LKqWq++leABgYOEU3Aohr5/qjNI2gdS/hq0hTaDqH22M0YJ3jay
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkdKMWR3dTcvbnJIcEdlRnprOEx2cStUdlQ2Y0IxYmtOTDI5L0Zac3hzcUFh?=
 =?utf-8?B?bGhNakdvQWFjSFcyMGNEMGNqdzBKeFUrWjU5dFZHMGwzTFVKNTJlQ1J4RHVy?=
 =?utf-8?B?b1RXNUJFc2I3WWg3ME8yQVU3ckkwY2g2RmliNjJpNEEyQjU2dmJWbDNrNDJM?=
 =?utf-8?B?cnEvQ0JNZm5NMzVjRXBZM2NZdktsOTNTaGwrZi9zOHpJZzlSaUFxbEhDS2RR?=
 =?utf-8?B?VXhraUN1YWJuS1RPOG9rRGdUa3orQlBidlFKY3JKMzdQR3JveGZHUUc3T0hY?=
 =?utf-8?B?NU5GUVlDUXZWUEI5SDBTcmNldUd0VituTUYzNThsOURQckRqcmN2V0kwVCtB?=
 =?utf-8?B?Q2JWdjJZc1hEYzFiS2RZUDltN3djKzFDZnlYOGZmUEphaTRDblNsenVaOUxn?=
 =?utf-8?B?TmY1bW5LL1VKTHNPOXRmREY5c1dwSjMxcTdQNkcrWExkNEhQYlExTEJSWC9h?=
 =?utf-8?B?U1NzSmxUMmdkK3FrS1ZsVGwwYmFyTTdtNnRzeWthUU1yY2FxWUdmZXZVN3Y1?=
 =?utf-8?B?VklZOUd0ZWNRWjBDQnQ3UEtSQXB1WmZMWVA5MEZuQkFoSXNldVhSRmxDYThr?=
 =?utf-8?B?b1d1RXdkK1FwV0piNTU4OUIvOWFBcmxoOXJ3TU9rL0JSTG0xTCtnM1AzVlM0?=
 =?utf-8?B?dUswWWkvVDF5cWtyd0NpVHNuSFUxQzR0ZHJCYmJFSk92MU5GdlpESWZ2a2RI?=
 =?utf-8?B?VUpoZzZGbHp1OVkzNTkrSEdLUTlINGlrRUJFYUJqaVVSNlN5aVIrT1pVaUh1?=
 =?utf-8?B?a0pINGNwVVJrc0cyWXBBT1M1cXlWa0dtemx2ZWJWOEJPM1JRVmZ2YXJDVVZ5?=
 =?utf-8?B?ZkNhS2I1OXZONnNOSW1lTE5od3dQdW00WW1SRGQ1TC95VEZlcVk2TFMreDhC?=
 =?utf-8?B?OGZHc1JMYlN6TXp5MWJjbzJURDdsK292MU04NCtBeDA5SGh2NHg4OUVjT3RJ?=
 =?utf-8?B?cXA0QkJmQUI3N20zOXpvOVNaV3ZsNGVwcUhvRjVKSVlNK3NoZEVTK2c4dnFV?=
 =?utf-8?B?aERqYkYrVkxkWCtmM1ZIQXhXdzErS0xNY24yVzF4VE13bUZ5Yjh4ZjBDK2U3?=
 =?utf-8?B?L3IzYzExeDZqR3FUMTBPUEVvME41ckFJUmJqMyt0eUJaU2YrV2hPV0xMVzZv?=
 =?utf-8?B?VHhybjZic2FON3NBVjhJS1J1MzZhcVJtQ3VLN2lPbjdtalJhclc5b0h0QzJ3?=
 =?utf-8?B?QllNc1ZaQW9iZEJCNFRRdytPNVdyS1BRcFp0aTBKaEd2U1pESjZ1TGNhZDI0?=
 =?utf-8?B?S3NSaTc4UXFlNlJmQ3hURml3OGYrVW9MS0xQNWQrVU5xaldWanc2b1ZKMjlQ?=
 =?utf-8?B?aGI1Z3pMaE05S2gwbDVvalNkazgzdk56UmUvLzBXSXo5MWJlTk9Ma2paN2JB?=
 =?utf-8?B?N0ZyZVhsQm9STnBYWHJyOHVXVzN0bFc1RTExa01kKzBNcXRucDFJeWdxZVJz?=
 =?utf-8?B?V3pwWHUzQ0FLV2tNMnR4OVJqbTNBZCtqdkpsRlU5Ni9QL2FPWU10eEdiYUVB?=
 =?utf-8?B?LzhMdTBPUXdRZTFBOFkzN0pLQ24vbWUrVnhLT2hsTGs4WEhRWFFOSXAzTHhJ?=
 =?utf-8?B?SlY2TTNWdEpPemhKK3FpdHptVlZEcERTTkVET3NYa2p4QmI1VEIrb2JjQzdG?=
 =?utf-8?B?b25WMkZUbVRvQ3IyV0FvMWh5bmVSRkdPWDlBdEVuZ2N6R2ozSHM1NUlFOGNk?=
 =?utf-8?B?OWg0U3JLbUFBcDQxamV1YkY0QWtkUTZLbk84UFowVm90WkgyN3VkTDFaY0FU?=
 =?utf-8?B?T0dIdnhyWVF0UFV6SzFaVG9reVNQdk5iVHcwVDBhZy8zekZlS0w4bTAxbDdn?=
 =?utf-8?B?amdkVFdObWhRekMyMkd0dmdIcWtYSENBc1I0WUtFUW9EMzE0VUdBTno2SVN0?=
 =?utf-8?B?cGk2cVNubFhqNkViMTgydVl4NkNqUlI0aUxzQjhwODBsRVJQaldROS81b0hD?=
 =?utf-8?B?L2s2T1ZqalBYU2t6Uy91SjltV1pWU0s1a3ZsTVVxL3hVNFcxRSt5c05qaHdi?=
 =?utf-8?B?eTU5ZC9WeTU0V1VVSUFlNTIwaS95NDBvNUJXS3hRVWw5cWd4d0xCRzZzaE0r?=
 =?utf-8?B?akZ2YU1rTVNCYVZRbEZEa0FkdFJ3ZjlMMlZkdEFZcmU0S0NFcU1PQVFhTG9R?=
 =?utf-8?B?UllETGJYMmQrcU1hR2RLYzliYTdvbXdVNTl2bFBCaXdheExUbUFudGpOQUxx?=
 =?utf-8?B?TFR0dGtJRXh4M005Tk5sRHVkRnQvM3dlZE5LTnJMdWtHSFoxT3drd3hkeWV6?=
 =?utf-8?B?V3J4M0NLenVocDhQWHV5ZEVrVTdBUW9UM0lKOGZxUFhjcnZJU1A4bTJmQWpB?=
 =?utf-8?B?NlZGd3RIeXdkcDlCRStxcUVnYUdpRTd4Wlk3RTZRQ21kdzhXVTRMY2pWbmp4?=
 =?utf-8?Q?P9sKaS8PNhwBIhxU=3D?=
X-Exchange-RoutingPolicyChecked: HnA2wIAg7bQNT6hzrGU6G6Q9HTtouRehWqTEODdvVKUbLoMHHUbL54SXawkIpggTIwKSgMmGjLKKfpjKfVh7goRqyBE3Ms+kzAttXoU7McuYMMJlLF7/uzAeZZHhoS4tLJx/UjwMLMnHxxOY9sAx6mAm1U7GMrxUc9OLRjXalCuGWrQ/B41bLmSzMSO1/X3GIllpKgnTbX4tDuFIFzpDNcNJOUmV0eDcdsQb6zRLyjoMNhMdCjdhMN5RbbS0w+7xvU2CCTitiJwiFKaUbMB6c7WlTwZcaFDExLRZsa+Vo5vc4B/SRMl0K0/1BDKYZGf/NoXKmvYUwUdf4+7PrF/XBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d60cfb1d-a535-4d08-2e74-08dec714dbd4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:22:33.6836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onkNT7YGsTw+k63bwA1mIjUhh82yiEzsfRjCm5czP3f69AmoqmF9RmQv1mFRWvulYBTmTxmxXQQKrWJHv5c+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7271
X-OriginatorOrg: intel.com

On Mon, Jun 08, 2026 at 06:15:40AM +0000, Wentao Liang wrote:
> xe_range_fence_insert() acquires a reference on fence via
> dma_fence_get() and stores it in rfence->fence.  It then calls
> dma_fence_add_callback() and handles two cases: when the callback
> is successfully registered (err == 0) the fence is transferred to
> the tree for later cleanup; when the fence is already signaled
> (err == -ENOENT) it manually drops the extra reference with
> dma_fence_put(fence).
> 
> However, dma_fence_add_callback() can fail with other errors
> (e.g. -EINVAL) and in that case the code falls through to the free:
> label without releasing the acquired reference, leaking it.
> 
> Fix the leak by adding an else branch that calls dma_fence_put()
> before jumping to free: for any error other than -ENOENT.
> 
> Cc: stable@vger.kernel.org

I’m going to drop the stable tag when I merge this, as in practice
dma_fence_add_callback can only return -ENOENT unless the arguments
passed are garbage. In this case, we are clearly passing valid input, or
our driver would already be exploding.

Anyway, this looks like a good change for completeness.

With that:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

Thanks for the patch.

Matt

> Fixes: 845f64bdbfc9 ("drm/xe: Introduce a range-fence utility")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/xe/xe_range_fence.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_range_fence.c b/drivers/gpu/drm/xe/xe_range_fence.c
> index 372378e89e98..3d8fa194a7b0 100644
> --- a/drivers/gpu/drm/xe/xe_range_fence.c
> +++ b/drivers/gpu/drm/xe/xe_range_fence.c
> @@ -77,6 +77,8 @@ int xe_range_fence_insert(struct xe_range_fence_tree *tree,
>  	} else if (err == 0) {
>  		xe_range_fence_tree_insert(rfence, &tree->root);
>  		return 0;
> +	} else {
> +		dma_fence_put(fence);
>  	}
>  
>  free:
> -- 
> 2.34.1
> 
