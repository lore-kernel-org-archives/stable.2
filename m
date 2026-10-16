Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7AF4772B5
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158961; cv=fail; b=jywbXwsWiBiJVZ+bzDc4sJt4CNibRBzNbtMonqGwaQ7RXMcgO88J/otoBFjx7VaI1eWCS/hqxf5TBFzmVUOO707UeNapvfvIjV/UiWfbISSAp2q/pYidMSR48TPviAh9wHYfFphY/O/JaFeISwyAnhamLIb+4g1I6nbM8BKcAuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158961; c=relaxed/simple;
	bh=KpS41h4Lde7SPRJ7TA3aEGhf3PN+s1QSR2fwrDzTPHY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q9SbLU+gCVV7fMjk51KmpMft3/nG9wNzjcCFZ15KIuYRFlIqshy4SuM8cNtSN5qSZwSMxOctWEFymxE7JEqH+XB5JXV5D79Gex6j7SeNaxR5Dk/uf4PBpr8lnfooQBScTp3GA7BMAkhrc4kIWRKAZLRrM/v0a1mUjTK6pp3sj8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUYlO7iH; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUYlO7iH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792158959; x=1823694959;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KpS41h4Lde7SPRJ7TA3aEGhf3PN+s1QSR2fwrDzTPHY=;
  b=RUYlO7iHypvWWmKDWGvNtpbFQbpADYW8Pjn6UJK6thGaxEAfr2DW81hh
   ZWY4xiV/OpHU4veo6n9DBCO598g6McfsDAHk1LrMZIC30z4xPug1kj7jE
   V38ciw+mWVSMOcOXlz/ltCF7YcpPEV9RtGWJIPGQxHkfW8a9oaab9LzGA
   DmFvG6BIvJYeBxs3O5JiOGqb0obo8Zn0w/y2yNdUTyEK3+GJaKOym7hKi
   +nUz9W8w3aR2Z5ihmkXoxz71AUwkK559YoZWFJhK4+BRhque6elieu95W
   oy2tgJXQspZSqcd8fddVerP+dEDWSXnimvci4NyJguy3GLtI8QqzuhtnY
   Q==;
X-CSE-ConnectionGUID: aDDXfHOeRWqEQwhQ7gJLWQ==
X-CSE-MsgGUID: B7AS/vW6QE+gFUNmq3zilA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="820924"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="820924"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:55:58 -0700
X-CSE-ConnectionGUID: i/kig+FQTfKi67XxcCbknw==
X-CSE-MsgGUID: aSCYN1mjSdO3cn1pRmLDQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2308010"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:55:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 06:55:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 06:55:57 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 06:55:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cd7VkDOVuGmm4W3Yk0Br6toKCrDIoy+OwCiu68tXACuGv5DRwutwEGVqsc+xrQiAZ4YquRNOq5jWye0/GeCBZbnOWM/ks9GSy/8tvZvhWfALdq6/8hWgjXt61lG/xSRCHHbkHkqrPIM6AZyBXMiAveUPNHqScE1+bcnc5igLc1B4zwqhwqMRKe4kEX4sTHmXr8a9dXaGEC5332bExahTb6/2eYvdPrPLgrOofNkoKFvO6KPSB8rxsAJtmNI19LOHiCdSBGRX9QD3cEBmIggLYkjSGuK/MOkeVS8s3jGcfBuJ6QPi55rRT9VKLznc9wPp2HG+s4C74Mn+z67RCd4gpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeaYfcqger3UyMnwOlqg2me0ebY+3w8L+aXMvaegmVw=;
 b=YQJUL9ExtOT7/ebKviOuCedHG9t5O3pS3i0/VgfruomePmzTV9e92Wjmcr77NIUU1wHtsLhKg/sntaHLvYQJhZtk5LKr8Bjf573lb974ymutcLcoytr6lZBwozRcShPF74YlhQEdJ+5KBQBKW5v1r5Teatsrudww21E8LbFZJV4fg3GkMW8VE28hwc/R+fZ/RYvzHiUh918BxC9X7Rd8XtccYqn1QCkSF5vlDtpzeZ9XLb+pcWZG6lJWHQO1PjGTFbS7U5c1PKMi19aWU3pWJaTCr3zSFEGDEC9YDjR8aXhJzyLJtEhFGNHQRaOdlIyX1Em/Rv6kzTNCF0QHDxucpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH3PPFE26A71A1E.namprd11.prod.outlook.com (2603:10b6:518:1::d58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 16 Oct
 2026 13:55:55 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 13:55:54 +0000
Date: Fri, 16 Oct 2026 06:55:53 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Christian =?iso-8859-1?Q?K=F6nig?=
	<christian.koenig@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	<stable@vger.kernel.org>, Matthew Auld <matthew.auld@intel.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v4 1/4] drm/xe: Don't abort the shrinker walk on -EBUSY
Message-ID: <atIs6ZAvUQMnU/aJ@gsse-cloud1.jf.intel.com>
References: <20261016133523.3622-1-thomas.hellstrom@linux.intel.com>
 <20261016133523.3622-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261016133523.3622-2-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:303:dd::34) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH3PPFE26A71A1E:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7db6af-dcf3-405b-bdc6-08df2b8d326d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261009223027099003|10067099003|11063799006|4143699003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: IIX6Dz0OWOk95B+3n+KIfJPJERSwsE9akXOy9viRGiXmd3PnT3d8OhZWQFbUL2GTibfh9D+0mreucURaE4dG5C8ZX4qLDlsSZdd30C/W8t9KbGCfuvjZY5wuDfzBdPunFoxuLV54VQvlAcNd43v2eaQ60Ow+WHLTPWLw/b31ve44Cwgy/MFor7BoSXy9k+qGC+sEtZYnwkRnB5u3gRxPLS++U2jRXYZ6slWTIr89umd4IMrCrHwPm3IDJjv1Ph/QBj/Ii2832B6op1rnG/bEeGT049KVxZsKhDogqDrCJBfTmBA9Sn7wwwFwGGkI73g95WhDx3zaOVzrHSM3Egqhg9YfYCJd37TW3w8fd2ooUerRzc5w8uQ6Rl7AZyo/3xD6OkMPwRjHBkJS/xnfe0tWOydEyGUMNphZ1L/2JmaNM02SaeifznLQr1AnpIBqFMhKOcDRapqjo29UPdFOi/FBBhkqKwt6+Yp+fEhG4p2OQN6xmwCZs6WCT9bBicCsFicpcp9E99zF9DeeiMVMfMzCte3zwuu0Cgu6gYttvan0z1Y9PXRvIUbtUwRywNu0yGBPHzoXVBztAXDULfOJ0YQAsB/2YcjIyPgPZmqWyUoPVIIm7cHiekFT95jxCp9/HoZCvsS7oCXCns3TQmVg0kMCf7DxE7ieD/BrLwyjoHWouo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261009223027099003)(10067099003)(11063799006)(4143699003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RB3QC1ZOrqr4BbOPDhBa4UZCZ6AZxZpRDv+nP9WhoV6F3zty8HPf8lQ39x?=
 =?iso-8859-1?Q?u2jZMGFQZl5U163K77w9rB4MJ8VUVdRfIW7xVXw819CZTOTJr7pltRWRTP?=
 =?iso-8859-1?Q?9BQWoLcd8Tkmornb0VILug2I8c2C+SiJ/YVk84j83BuFursGN9EGWrV6Mx?=
 =?iso-8859-1?Q?hKkkcroQEBF4gQRndEfq4OchIgJBx7JhN5ZZZoO0cAQOlWb0Ki5P83t4QI?=
 =?iso-8859-1?Q?4tVLY+3vmfrJo5FUUFPEAzzvmn7/rT75JK4U+54evA0akiq6cQEtdZF8ra?=
 =?iso-8859-1?Q?YlD7cpMSAgfIyth7n7NSQytBLgrMjMaW4rrv9tFowwPL7n4Nfr69qXaF2f?=
 =?iso-8859-1?Q?0WN8m0GoeEd3Ig2VPfoKotXquNbktOlByuTuqAutv6HOL3OohjokkrzJHt?=
 =?iso-8859-1?Q?ZMSud339vkvCjKWDkv85eCSJwDcazyzEUq0ixXNIXVZluBw8VnCZxbdysK?=
 =?iso-8859-1?Q?1brA74d8Pp4LxKkKBiaardrpik9PZpg5M4EeyehyheEYzD/hKuCIQQnWkE?=
 =?iso-8859-1?Q?4W8LVLZDg5LLHHV6zf7rf0gyCcltRcDmqhXlXILcjEg/lgK8jx1y4eS97u?=
 =?iso-8859-1?Q?FK1tUFFSt4y5RyI8ER902c8E3k2MZHxhPZSJ7U42sBmvpj30hjgfp3XodT?=
 =?iso-8859-1?Q?9z8Y69syFxQ/IWqQhhNEmqQPuBm2fpB2lqFRs/wgYQqL559tWF68eCC9KL?=
 =?iso-8859-1?Q?3c/WaEJpqv5LvkoC7hXxiHLLltk99beez+AIYA4DqvH1DfAklUL4mzJGWf?=
 =?iso-8859-1?Q?Ho7OpqGs6wO3dvIxnMyeBWULVV6XcfzlqxmsZdsKgHdcl2XerI4MBIV3T0?=
 =?iso-8859-1?Q?q4gKEwcLXQ9rqmyBEWETS6jT9QmMKDQ7AvMsRbmJXcv2C83qGACSQEFxzH?=
 =?iso-8859-1?Q?s9n/kEdyMy6IH34mxv+0Pjzo0By3kKyhjudR8Tcsif7IztwtmGE+RCm7U7?=
 =?iso-8859-1?Q?oGxyhv1g4WTtUncptvWQifez1tiBGhENhrb2nmyWog+0+JjW0ZjvgzkbVM?=
 =?iso-8859-1?Q?OubZPdWfEkCsOPp9qvhfG/Ft8D/pcjOJp2VEk73YYaUcYQYZxz/qXlWPJK?=
 =?iso-8859-1?Q?5WxvJD/QqFZjy/7FseBA9+NFeB0hdjIyCoZxJzbMKBJ/HgKkdaqj5+vlxX?=
 =?iso-8859-1?Q?bd9xsDk+egRnu+pGDeOFiC5cNhjHYWnm6t1ZyOgAleXE6dLMGUsf1z3Tht?=
 =?iso-8859-1?Q?xFuHmFqOUG37fUruMyVnWouHD/Ad0FjvnChjryOJQyJYBEY2RiWbVF/PtV?=
 =?iso-8859-1?Q?Zoq/yKRMsAxudbr4ojfeVoSsbVK1lyh2duw87TcgISYD1u/JSKBYHhgq4E?=
 =?iso-8859-1?Q?tmYzBhJC4Kq+FSgf4RzHtBeKnokThjnQI0jPNF6JsRsIYZFlFfsgawtG1G?=
 =?iso-8859-1?Q?hmMiCn+jqTPj6LycdECZb87y3cnlyRzA5wHC1NfFeMX6OcF57esLcWIdIV?=
 =?iso-8859-1?Q?wKxOB6UAuRBwGMWuvm/rWjHidlZ6bXxFyPWQ3ryugi8kqrfz6CRfTkwz5+?=
 =?iso-8859-1?Q?CLHhKKrUxOC0mIhdAztI4LVGZKRTeh5w5JgpnxHlYuQ42W0zzJ0Kn9bykH?=
 =?iso-8859-1?Q?yZv7WwcH10zOpozON64N4QW4SyFiMlFRc2rn0RAL/WFOerBcjBKSRwWyWD?=
 =?iso-8859-1?Q?uHlsQr1WbW3fXPlL77yQI3FFHn+pNACstY7VKpNu60y4exjLBfN5IpVOHS?=
 =?iso-8859-1?Q?AG0iRjXMtJVUOmVgfUlgWY/7W7ZWqjxJIfT+iUZ4oid3fSdtZH2gjvW2L3?=
 =?iso-8859-1?Q?Z42gyJ1rCSjT4jm+WaxL7C14+pcSU1jD5G5bO1sBEh8Y/sVkW84aswnaD/?=
 =?iso-8859-1?Q?U/1r5ICJ9Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: N/XeUQKJcP17uLGzthJ7pJv3uW015EewEdyxfDQWUDiA0usXDEIXRMV/EnzFcJe4lRyRFh2n0atMLJazjwhyb11PLfvw4TBO37tvOv9K6CYUkA2dl8/jV+HlzaJpfe4vN0Jk0TcvYMtgBas8+b3TSKUNeFcoLcrrT/J/xKp3psgB9ltttxGHZLCktioiGzyI/+kAnewtgBDr1c4Svdoklxt+Uj9vcLV19rn7fdpp9kwVR85qtYELMLkCK9CwE3IOMaoR/t1cKUo2tBXn07GK13C3fUKaT+KO3smq7wpiuvfJvvzFnwMxpooD9mNgtrQSXwvjIo14iCi5a2TM0HuTqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7db6af-dcf3-405b-bdc6-08df2b8d326d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:55:54.8500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/YG2rZlOncGfOHhc8QS9uA6nnWTrM6GIobWP1wAaUBWWsN3+00SOxNlHEG/MPXVlIM0tlbwX42g5G5FSf3UUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE26A71A1E
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 03:35:20PM +0200, Thomas Hellström wrote:
> xe_bo_shrink() returns -EBUSY for bos that can't currently be shrunk,
> for example imported dma-bufs, bos whose vm is currently validating,
> bos that are still busy after the wait timeout, or bos whose backup
> fails. The shrinker LRU walk treats any negative return value as
> fatal and aborts, which also skips the remaining shrinker passes.
> 
> As a result, a single such bo, like an imported dma-buf on the
> XE_PL_TT LRU, prevents reclaim of all bos behind it on the LRU.
> 
> Skip bos for which xe_bo_shrink() returns -EBUSY and continue the
> walk, like the TTM LRU walk does.
> 
> v4:
> - Patch introduced.
> 
> Fixes: 00c8efc3180f ("drm/xe: Add a shrinker for xe bos")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

I noticed this on as well.

Reviewed-by: Matthew Brost <matthew.brost@intel.com>`

> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-xe@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.15+
> Assisted-by: LLM
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_shrinker.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
> index deb4378c1ec1..4e4da76936f4 100644
> --- a/drivers/gpu/drm/xe/xe_shrinker.c
> +++ b/drivers/gpu/drm/xe/xe_shrinker.c
> @@ -113,6 +113,9 @@ static int __xe_shrinker_walk(struct xe_shrinker *shrinker,
>  				continue;
>  
>  			lret = xe_bo_shrink(ctx, ttm_bo, flags, scanned);
> +			/* Like the TTM LRU walk, skip bos we can't shrink now. */
> +			if (lret == -EBUSY)
> +				continue;
>  			if (lret < 0) {
>  				ret = lret;
>  				goto out;
> -- 
> 2.56.0
> 
