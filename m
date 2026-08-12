Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC083BE16C;
	Wed, 12 Aug 2026 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524621; cv=fail; b=V5hYJFqqcyYg3J6Tab3PDdLXTw1Wm3cjyC62jiTscGZ7Ght/+NeJtCEpa6jPNYNSFPpOdcDQE0bZm12zsGVpzj7ay1njhWIm18J7LlbjRxoe+zeGTSSqcMwKSoBpL0yzTsqnFsBAhBp8pBpsfnqIISRTMK4zXJLHdUbSq+u3gpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524621; c=relaxed/simple;
	bh=CyWba98v0/Z7jT8gnIAjJiZQNDnH4ikrh1M4F6O0Ldc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tCeSH9wrX11AEgacZUXCmR2ZoF11nztYaKmT2tDpjNSW24ObtOh0n81xICAPtdHN+SkqxcgvA0DyBhFulYO/4O/lrih21eKGM4zGlvVEbC5UOWY2Z6NomhflPXXE94klbtKiBBLPMbiezK1yCq8Zm4S6ER6vepvyGlNqoPhlfAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w9wO4M6l; arc=fail smtp.client-ip=52.101.85.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w9wO4M6l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5ytTSHGOjw0JCEHGQRLgeorJKHqlODAO4pwQgL2gugdl1I0hE+/8gbgn1T/JTyJK7yYEQyRiDMfXQUqHhMYUwzTI/pKnKCPMS18xFJWvK/VBUVsErWod9wJiZYJslAs7/DPNsgivsV4Fmi+EOricTJXyjdnMXD8SQkIgcAEqtolGS+giCskvnDyNhe9bmoda+ZZ+sruDmKOtoAUp4NHEdZJ76O+BUVqCCgJbqlQZLiZvjk4HaPNE8U1950wA00iWZ0g3Dyfcygi+RqpYBshpXtVHY8kNrW2LcM45VpFoVbdF9Fu/9cLiUsStEP1MRCdIMNyDMfdELhi5USe017Siw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9ljOyvcPXp4i5tUa6yrPaKfUcRY6eZKUCH4Am4Bles=;
 b=G5Fi4AI2RzSx0ofpWsQ2fJF+CQy1EzM3PYJzofeN71wyxtky1StJa5p7kn9srfuDCWVGONjpFx3WtisVZsdWlAGUOvg4nmvm4EA5fGzP90J2FZumt/Zm6yP8hw/wOzGkoBPVeVEZMLgKza/9jV8VFCz+3ATk54t1ilMTj+oUSvk2Y7DBAVCwj77DhyjWrvaEg98fForuJESnR9O3bKRW3i2pvtd5Qk9YPBfv3dGSFDXLaL6I3C5u1dkiNK58cNm0M4oq540JEQTe4htuhkfjHGmhGdAoStC9DIQqyDRm5GkGmb2M48iTCm3QL0aVkVRN+NTvqRHuZL9o98gsTP/H0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9ljOyvcPXp4i5tUa6yrPaKfUcRY6eZKUCH4Am4Bles=;
 b=w9wO4M6l7mrHHgCVLxoahQnQtbGz4hEtOUDH7rwp9q44ivoFna00xL/rDcO+j2OwJ8DH/Yf54Rh83Fp2CQJ6iMiNqrvrc5KEPxN/aY8a8s5qsgjoLan5ow0Rkjz/UCRjUQRtHT8f+qqHEZNxh6KRocXMamJF5bc6AX91Pqfnn90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 08:50:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 08:50:12 +0000
Message-ID: <18ac1350-c96f-4cba-8910-c7beca237eaa@amd.com>
Date: Wed, 12 Aug 2026 10:50:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] Memory leak error in qxl unbind
To: =?UTF-8?B?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>,
 Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org
References: <20260811194224.121597-1-megia.oscar@gmail.com>
 <20260811194224.121597-2-megia.oscar@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260811194224.121597-2-megia.oscar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0038.namprd20.prod.outlook.com
 (2603:10b6:208:235::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: a45cc3a2-4663-4127-ef75-08def84eb886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8AYZ/Ug2FPcakPyTmcJyTUTmouel5fNOhkrzkuqtd/sYI5ZEyT3oevHBmZsHNsI3p8/E7oFIMjSF/c993swDKQiRHxpnRWsKx9tznCgUrISeSF0yo79kTNmC2YeUoYiPJujy3UbYqd14g9jof4KqWHRhtAaeu/yW58Clu5ns0EXLdKNkChXne1Xw+8rzYfGCOjM6/d3qDJVW7npu3gx3L6oBg/TLZsmvtulOGq71Aqn0JQrBwER0XRJIgNJR+T1Y6IQNYN+eKB2H/twwvJOnebvHTau3qP/E/ZXGjPUKvmkgqvf5F0/WlL28hyJ+USnqkkcZuYsT2fSt17Bbe6SBSdwpuu3ahYvpomPX4plElZDJKg+t6sYSnFa18OZC293n5gPftOK+oWofkjFFZmHZ443CCor5D4Vxx9dr49BaZtzSa6xYT1ySbXJN8f5F0F9l9uCL0F2iH+9W8e81v3mcRIfwdalbzkE5QgUuj0kclZC9fGuW19i7whMUoA6HWm77DIAFtRsELJD1fhwmt1Q+HrfEWkmAVaBSmMWop7RDioHFpPYGqu9yODQBz/AHTE+TUPg51usmTRmbW4B/ct1I6CC/tmvNiPlV1RWE6b5KhpGe3P9oyuR5D/s65T5uMBxQZFMoj1HUuLRstpyk+zGcW4U+vkV7r1xkHH5V2BRXnYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0ViYlU2TEhjQm96a29ucDQrNmVVVkx2UFdNU29HTktaUHNRQmNnK2pmbnBL?=
 =?utf-8?B?c3ZXR2YraDZUM01qbFpCbDdhbWdFUVBETStoQjJjRjZFb0w4bXZXWVVQbWV0?=
 =?utf-8?B?M3h5dmRvbjViUG1HOE8yM0E1bEtqOXdZcEZKeno2cXE5bW5Md1p5NmhDNmp1?=
 =?utf-8?B?WDUyTkJBT1BmYWlnSHFtenowZ01KQ0NyT2U0d3FFUmY3Q0lMM21semF4RmtS?=
 =?utf-8?B?dmQzbWswMHYzRHFyMjJTQ1E4dkk1b1hidG1CL1lUbStRWi9IZFhld0NKT2x3?=
 =?utf-8?B?ekxqZGRvY0ZSTjVKUkYvVFZLVitvUzc0alg2aTk2WW9NVzh6WC8rUUpXendO?=
 =?utf-8?B?Vmt2VExZZnZwQ1VRYXN4ZUduaGlQYWNheU9tQnFPeHJiSHVHVVE3SGtqQm9Q?=
 =?utf-8?B?c2kxRjNReS9DOEl3K2tJZFRMd2JjdWhLSitXNm1mNjl0RkUwc0Y5SmNXVENX?=
 =?utf-8?B?YmNwUzZBVElWOHZmS0RIbnhJbk1oaGNuTko2bG9FcEk1WlJleEMySVU2YmNB?=
 =?utf-8?B?eVdPUHNHVGcrYi9GY0ZYQ3c4L21XRm9zR3NOcUh4VXZ5STFOb3RydDkvdEx1?=
 =?utf-8?B?SlZjUVJ6TW10WCtzb2cyMFVjU0VpRlE3aTJ0NlI2bnQ3djBiNDJBMm9Kb1o0?=
 =?utf-8?B?ZDAvZnNlRFM1UVNMVzB2bVlnMXErMHhrdzVOd2swSlF1YWpSTWx3QXJoT092?=
 =?utf-8?B?ZkxmSFJlZ0Z5L2xHMW1rNFRaeEdZR3hoWm85Z3hyQVh6cVBGbDlsSS9pODJs?=
 =?utf-8?B?bTJYZU1TbGRmZjZSSnBEYjBzeEFIYlFTdU9lZllzWU0veExrYTZhRmVwT0hI?=
 =?utf-8?B?WVJxUThNVmt3ZE56VVdaeEtwMkloUE5ZbFg1eGZJTHk0M2VSamg4OFFpRHRT?=
 =?utf-8?B?V0s4cnVlQVRHN3JZaVp3UGVQbk5nQjhYRlNVMGlIbEdnUkxlUk5vSjh0KzZn?=
 =?utf-8?B?TlRpZmNsbTM2RmZKU3ppM295ZDhRUEFVRDRENks5UUZ6ZXJPbkhlaTJqRFdq?=
 =?utf-8?B?QkJLMlFXWTNmQUlYTThXSzVVRE8rSE1qb1puOUY1eWU0YUI1M21mcUxtSkJD?=
 =?utf-8?B?UmFSeCsyS3JVMTBCUVl6OVkvUyt1VnU0UzhsenZpNzBtc0J4bDZLaHJlai9L?=
 =?utf-8?B?ZlVBQS9uYk5BSjNMQXlkQzVlTXpvTUlOaEdFTWlHR0Q0S1JVS3dYN2hRam5M?=
 =?utf-8?B?eldPR2tpaUZFYkVTcWNBVjMxSW5HRGNpaGpQcldTTndWTThrVnduRDNwaE5Y?=
 =?utf-8?B?MUZESFAyZnZqVXlSNDZoMkpnY2cxMDlwUlYyY0xlYytFdkkwc0t0YnZzK21m?=
 =?utf-8?B?ZW1FUjRSYlJlL2RIMGtFT2VobkVOSkdFZ2pDVGZaVy92Z0xycFV2a0FDNWxQ?=
 =?utf-8?B?WGxoN3p3Z0RSbnRvQ0JTYStsQVRkWlhsNXQwYW1rczF1VE9EU2tuSzIvVU15?=
 =?utf-8?B?UklVZkdlbk9yTlcwUUFDaDRJeWVJb2JMeVdNVnR1T1ROMU45VXg1OUxoYkZo?=
 =?utf-8?B?Q3RUazNhazJRd1BjM3poQ2xsa3Bsb0tFcVY3cm1MWU5aZ0p3K1R0YmxCM0Nh?=
 =?utf-8?B?WGR6TXhIVWt4Ty9MdGZLcGcyUTZQMHVCYllpeFA4MVhmelpieTJOamIrbFNw?=
 =?utf-8?B?NzFzSHRmLzBKOStGK3JoS1pGSTg2dFZMTFBXelFCWnM1QVlRZ3IxaDROTS9E?=
 =?utf-8?B?dkUzeWhpZTNjWVR2R0FkOVRJWEdFcW1XYUlhcjA4elhRRXptb1pzZ09TOEJE?=
 =?utf-8?B?Wkpqa0dPdC9mSjJ5cWFiNzV0V2FOSExpeGNBYUtBMWJHQmN5NUdoOCtzakow?=
 =?utf-8?B?eW9vZnNSUDRub25ka0t6Q2NGeFBKZDQzazFmbUN2L2Yzb3YyZW5hSUxFTFdl?=
 =?utf-8?B?NlVHMjhnZzAzczg5UWZvK0Q3UGh0SFVOemV4T3ZGMU80NFJmTTA0c0FSWXhp?=
 =?utf-8?B?MXU4NEhPNGNIYUpiVTk0OXhZZzYrZWthQVdvMzNLZHNhNnJxaVZleC9pTnpP?=
 =?utf-8?B?WXR1dUhsbVZLcENhQTlvaTdWTWxqZ3M5UW5xVWFSMjFTRGpLTWp6RUprelpR?=
 =?utf-8?B?aWtnbWNHckxrWWJIdEVQNEgxZVFnLytFRkN2dXhWRVI3dUhEV0Q1cDNBTmMx?=
 =?utf-8?B?YzJBUHd5dFZITHovZ2I2Y2J6UFM3NXY0bjlwc3RQSkRpa0RkRlZ6aFV2MTZi?=
 =?utf-8?B?WU1TODlzWFJoWnFnUzhYcVE5OERTZ1VsZFYvKzduMGp4MFlQUW1DSTFNUm1Q?=
 =?utf-8?B?aTZyMG5TMmhpMmgySVhqUDF3Y2c3LzhXdFhXVGJ0M0RMTE9kVnBSYVEvM0ZB?=
 =?utf-8?Q?bHv01aZbkPUTAVCuEf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45cc3a2-4663-4127-ef75-08def84eb886
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:50:12.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ao6Ku6FS/Qx3mPo2vZHwuNyQ9WCJzH78er2pdfAyFErOfOHjuautsmODrP7RF1Fe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942

First of all those patches doesn't have meaningful subject lines so I previously ignored them.

The subject should be something like "drm/ttm: fix memory leaks in ttm_pool".

On 8/11/26 21:42, Óscar Megía López wrote:
> I discovered an OOM after run the script below
> (I updated it and added a sleep to allow enough time for the cache to
> recover):
> 
> while [ 1 -eq 1 ]; do\
>     i=$((i+1)); echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/unbind;\
>     if (($i%1000==0)); then\
>         echo i=$i; free;\
>         grep nr_free_pages /proc/vmstat;\
>         grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
>         sync; echo 3 > /proc/sys/vm/drop_caches;\
>         echo 1 > /proc/sys/vm/compact_memory;\
>         sleep 10s;\
>         free;\
>         grep nr_free_pages /proc/vmstat;\
>         grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
>         uptime;\
>     fi;\
>     echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/bind;\
> done
> 
> The OOM isn't just a simple leak; it's a refcount corruption which renders
> the list_lru fix dead code after the first mid-init failure.
> 
> Fixed check if shrinker_list is empty holding shrinker_lock.
> Fixed check return value from ttm_pool_type_init and run
> ttm_pool_type_fini and list_lru_destroy for every pt initialized.
> Fixed change return value from ttm_pool_init to int.
> 
> This patch depends on patch ("[PATCH v3] drm/qxl: fix use-after-free in
> qxl_irq_handler on PCI"), link [1] below.
> 
> Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
> Assisted-by: claude.ai:Sonnet 5
> Link: https://lore.kernel.org/lkml/
> 20260727110212.64913-1-megia.oscar@gmail.com/ [1]
> Link: https://lore.kernel.org/dri-devel/
> 20260731053047.24503-1-megia.oscar@gmail.com/ [2]
> Cc: <stable@vger.kernel.org> # 7.1.0
> Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
> Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
> ---
> Changes in v2:
>  - Bug 1: ttm_global_init ignores ttm_pool_mgr_init() return.
>    If shrinker_alloc() fails under memory pressure, ttm_pool_mgr_init
>    returns -ENOMEM with pool types already initialized (64 list_lru_init
>    calls done). ttm_global_init ignored this and returned 0, leaving orphaned
>    pool types with a NULL mm_shrinker.
> 
>    Fix: Check ret from ttm_pool_mgr_init; if non-zero, goto out cleans up
>    refcount + debugfs.
> 
>  - Bug 2: ttm_pool_mgr_init leaks pool types on shrinker_alloc failure
>    If shrinker_alloc fails after all 64 pool types were list_lru_init'd,
>    the function returned -ENOMEM without undoing them. With Bug 1 now
>    triggering proper error handling, this undo is necessary.
> 
>    Fix: err_shrinker: label that finalizes + destroys all 64 pool types
>    before returning.
> 
> Changes in v3:
>  - Fix: "Unchecked list_lru_init() return value in ttm_pool_type_init()
>    causes a deterministic NULL pointer dereference in the newly added
>    error path."
>    Now check list_lru_init return value in ttm_pool_type_init() and
>    returns error if any.
> 
>  - Solved pre-existing issues reported by kernel test robot:
>    - [High] `ttm_pool_type_init()` ignores the return value of
>      `list_lru_init()`, leading to a NULL pointer dereference
>      if allocation fails.
> 
>      Fix: get return value from list_lru_init and return error if any.
> 
>    - [High] `ttm_pool_shrink()` assumes `shrinker_list` is never empty,
>      causing memory corruption and crashes during module unload
>      if triggered.
> 
>      Fix: Check if shrinker_list is empty and return 0 if it is empty.
> 
> Changes in v4:
>  - removed check return value in ttm_pool_mgr_init, now in new patch
>  ("[PATCH] ttm: Add error handling for ttm_pool_mgr_init()")
>  link [2] above.
>  - Fixed check empty shrinker_list.
>  - Check return value from ttm_pool_type_init.
>  - Move up shrinker_alloc.
>  - Deleted dput(backup_fault_inject.dname);
>  - Fixed issue [High] The patch introduces a use-after-free race condition
>    between `ttm_pool_type_fini()` and the active memory shrinker
>    `ttm_pool_shrink()` by calling `list_lru_destroy()` prematurely as
>    reported by kernel test robot.
> 
>    Fix: separate ttm_pool_type_fini and list_lru_destroy. Then, add
>    ttm_pool_synchronize_shrinkers between them.
> ---
>  drivers/gpu/drm/ttm/ttm_pool.c | 62 ++++++++++++++++++++++++----------
>  include/drm/ttm/ttm_pool.h     |  2 +-
>  2 files changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 278bbe7a11ad..88c0d33eed1a 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -437,13 +437,21 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
>  	LIST_HEAD(dispose);
>  	struct ttm_pool_type *pt;
>  	unsigned int num_pages;
> +	int empty = 0;

That should probably be a bool.

>  
>  	down_read(&pool_shrink_rwsem);
>  	spin_lock(&shrinker_lock);
> -	pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
> -	list_move_tail(&pt->shrinker_list, &shrinker_list);
> +	if ((shrinker_list.prev == &shrinker_list) && (shrinker_list.next == &shrinker_list)) {

Clear NAK to such list hacks. Usually list_first_entry_or_null() is used for that.

> +		empty = 1;
> +	} else {
> +		pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
> +		list_move_tail(&pt->shrinker_list, &shrinker_list);
> +	}
>  	spin_unlock(&shrinker_lock);
>  
> +	if (empty)
> +		return 0;
> +
>  	num_pages = list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_list, &dispose, &num_to_free);
>  	num_pages *= 1 << pt->order;
>  
> @@ -1122,6 +1130,18 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
>  	return shrunken ? shrunken : ret;
>  }
>  
> +/**
> + * ttm_pool_synchronize_shrinkers - Wait for all running shrinkers to complete.
> + *
> + * This is useful to guarantee that all shrinker invocations have seen an
> + * update, before freeing memory, similar to rcu.
> + */
> +static void ttm_pool_synchronize_shrinkers(void)
> +{
> +	down_write(&pool_shrink_rwsem);
> +	up_write(&pool_shrink_rwsem);
> +}
> +
>  /**
>   * ttm_pool_init - Initialize a pool
>   *
> @@ -1132,10 +1152,13 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
>   *
>   * Initialize the pool and its pool types.
>   */
> -void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
> +int ttm_pool_init(struct ttm_pool *pool, struct device *dev,
>  		   int nid, unsigned int alloc_flags)
>  {
> -	unsigned int i, j;
> +	unsigned int i, j, k;
> +	int ret;
> +	struct ttm_pool_type *initialized[TTM_NUM_CACHING_TYPES * NR_PAGE_ORDERS];
> +	unsigned int n_initialized = 0;
>  
>  	WARN_ON(!dev && ttm_pool_uses_dma_alloc(pool));
>  
> @@ -1152,23 +1175,28 @@ void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
>  			if (pt != &pool->caching[i].orders[j])
>  				continue;
>  
> -			ttm_pool_type_init(pt, pool, i, j);
> +			ret = ttm_pool_type_init(pt, pool, i, j);
> +			if (ret)
> +				goto error;
> +
> +			initialized[n_initialized++] = pt;

That is just a horrible mess.

First of all the change to ttm_pool_type_init() must come first in the patch set or otherwise that stuff here won't even compile.

Then don't use a local array, that is *way* to big for the kernel stack.

That patch set here is not even remotely sufficient for inclusion in the upstream kernel.

Regards,
Christian.

>  		}
>  	}
> -}
> -EXPORT_SYMBOL(ttm_pool_init);
>  
> -/**
> - * ttm_pool_synchronize_shrinkers - Wait for all running shrinkers to complete.
> - *
> - * This is useful to guarantee that all shrinker invocations have seen an
> - * update, before freeing memory, similar to rcu.
> - */
> -static void ttm_pool_synchronize_shrinkers(void)
> -{
> -	down_write(&pool_shrink_rwsem);
> -	up_write(&pool_shrink_rwsem);
> +	return 0;
> +
> +error:
> +	for (k = 0; k < n_initialized; ++k)
> +		ttm_pool_type_fini(initialized[k]);
> +
> +	ttm_pool_synchronize_shrinkers();
> +
> +	for (k = 0; k < n_initialized; ++k)
> +		list_lru_destroy(&initialized[k]->pages);
> +
> +	return ret;
>  }
> +EXPORT_SYMBOL(ttm_pool_init);
>  
>  /**
>   * ttm_pool_fini - Cleanup a pool
> diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
> index 26ee592e1994..66248323c2c1 100644
> --- a/include/drm/ttm/ttm_pool.h
> +++ b/include/drm/ttm/ttm_pool.h
> @@ -81,7 +81,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  		   struct ttm_operation_ctx *ctx);
>  void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
>  
> -void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
> +int ttm_pool_init(struct ttm_pool *pool, struct device *dev,
>  		   int nid, unsigned int alloc_flags);
>  void ttm_pool_fini(struct ttm_pool *pool);
>  

