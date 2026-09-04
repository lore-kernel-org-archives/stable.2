Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A93932E1;
	Fri,  4 Sep 2026 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510058; cv=fail; b=ksDCUyt7nbbFtfQNSPDDU5ZFq3w8WMNmM6VTm0sS82tem0Zge0lg2VNEQ7LbITgeM4on/5X4xhfAMMaQ0mqAD7V2fGIfBBiiQSXL4ntxctTSUmVTsh0FzhgyVOJCVZK6tMJwpmQFo41fn34sc+6rXR1exZjuUtjpUIA4R/8u0Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510058; c=relaxed/simple;
	bh=jx4jePbXfzxOK/1sDOd0MwXDpwpdOPvJmDBXknvV74E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WxoJN3YgDX/4TRBH6KHpQhW/oVIwdGOgFi7Pvb80GV44MA9PtgMwmrMtjQy/BfFv7hSU1FAdFz7o4gKq7+DRadoqoLSIUOtlHja0BehjQz4Z2RmFMLj/ZG0s+3Y1J6HQXU5yrb34e5WEyVh1BbdeJrFu5+xSpcL0pFsjBJ2G9g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nIVJwXQZ; arc=fail smtp.client-ip=40.93.194.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nIVJwXQZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSl0aHzR9JayiooM6uqxcedcINs6TUogv7fngKq2Ami6BhcaW4asHn7gcjHq2/Oqkxk8KauEWTDm3LwuGA1heJmwAgy41NhoBUZkeLnVI4V4verq7G9ZeE957VbFibdtj6CE0DkaENITZqR/6n7idqLJlNleLAPKBv3JvFvOw0OKhtV/booDoc87II4KtHvH/d+5qgnFmQOfeeCIZ4xD5L+wX6lfNv/xBZZjyblBiUv8mbrJ82SY7EMRYWtUK/EAqivvUQBzcHpVNRufwVKhT5AfMnM9pgFt5WlVEtytLRm5gRNNUb+28uwzYB27Ev2CzRnhs+wpm2+judJL3ar1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lvvl1HU4meaE6TwAgoK5YWR8Kz3b0P5u/2hVZDarKUw=;
 b=bqNy2BuV1kfs6/N4j0NFmwVpkhmVAHZ4zA6Bhki+ovUUwOpBVP00MYsqDphJow7cBWO3uaWwrw6TSIkeP/AYaN2rcuRskNVCntMv/E837xd0jZpQnzQlZ+/bsfllqwAsBYjVsPmQNgTGJegxpfKRjqhKOdmoYCmdUQMGG6hcA5GhPC+vhrp9WTr8iiTPwIcgTh94h7HCi/REmI6uCMTh5+6NAayZSzqzxk9tjZLoaTCmOS27CC7TWHElFO93l9CqbHlpsGV28XxJmJ9n++t0GkxBORv72ABFUWWFaw3ZY5EWR7973ReEt8rOfWkAbKLjrmR8Q9gzcR5A+3TbpLpS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lvvl1HU4meaE6TwAgoK5YWR8Kz3b0P5u/2hVZDarKUw=;
 b=nIVJwXQZtPPMmTnFGCiPRyZ8Kobmy8iZ0hFzN7bKS21pKx2rrW43lRn5MMSayfy3dvQBszo5Vn4AU0+uGHeOS206vUm1bnnncuoNvbuPxGczxspxuS98XM69Le4OprvFi3Eir/t3+mAmRHtEtWjqXIARiKbz0E7g8OtqanMzge8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:20:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 4 Sep 2026
 08:20:46 +0000
Message-ID: <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
Date: Fri, 4 Sep 2026 10:20:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
To: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>, phasta@kernel.org,
 tursulin@ursulin.net, matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260904080618.2098450-2-malhyuk97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 106240e1-877e-4418-76db-08df0a5d6b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|56012099006|22082099003|11063799006|18002099003|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	EvBrok36riIV3RCM6ez20M9E7sCFzZDYoQl1qTqAvLEU5mySQyZvQYFCq+9Xw0wHEW4l1KUjYCl6epd3oLMHUpqyYv3MQMxnmqFB14f0vEO0N+pyO/TMfBaiPHQUl9DJ1dSYcFwF+i8UY9tz3BuOxeuEYgkxqib5fMlsh9d1G9F6B4rumPi2060oHpUGhhKkli3AfFoT1nBWFUAysbkN0JM/KTL9QCfMw7XKCAdE4DSzqJLsgPENgq7wIh9OaFvfUeJQXI8k8LOehL1IIggRNduBvcANR1wY7Vlq0a191/bSCl3xKv8QKFuKK2UBkvZz912IJwa10gwloEfrpCMjg3PJ7x6+EGGUJv5/jjagMJd1obeErpZl4qPBlWA2NRO56dHq3xcTuQ2oiFf9BQP0FUV+AdPExt/BnQiO+unS59dIfr1DhMuXz2/0JNIOXwo/efDxCZMtYPYZ/YArZ2e4XhlNOcbnGNp2QxRBJyuOwjghYztsVXpdODeaE5eaVYdzcexTzO++eZcUEvkNqpsnEPJMDERsVBe7ogA0PZqcfb/WBkIszUu1cdWtHizW9CUM7Z5zRwQses5seLIcuKR7MM3BUilMAkjcRthDclGu00IHlWFhtFD771PSkFcZoRu9RYE0qgb2aIIfthgSIqpTOrMif3Ra0DTT7pZPh3wDXUk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(56012099006)(22082099003)(11063799006)(18002099003)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG0wWURNQVlwRk1ydVV6aXd6MFJ1UHo1VjF4Y3pNVjlkeSt1eUxJREZkK1VK?=
 =?utf-8?B?MmdjUmZPckRWRUZlWmRXQm12ZHM5bW95YTdHSXZJR05xK2Q4MHFOaDU2Skh4?=
 =?utf-8?B?d050Q1JJbHRmMEhoOGN1bm1pTlZvZUMvbjROMllyRXFtaXZROVpMYlR0ektT?=
 =?utf-8?B?VmRyRUlZbUFtV0RsaDBST1JzMnd1dGZUZ1dLUGZVOWdGUzZwemhzc0FERHpv?=
 =?utf-8?B?MDExMTN5Y2xVQ2FLWUlnTTBhTHNRWkkzZUFiWnlic3hTOWxPZW85T1lKTUtB?=
 =?utf-8?B?bmROdWJpaUhiYkpxeXNKSy9DWFJ2Kyt5c2xNbG52UVNMeHloVHJwanQ0K2Vl?=
 =?utf-8?B?Yzl3azBncHZTL1VJd2h2bUtrcFdIYXFKcDBLdE1SVThJbjNIcWh3M1kzWG5V?=
 =?utf-8?B?dVpUazVYeXcrS3AxaTlOUTNVV0N0UU1CQ3Y3dGo0VkE2TDZXZUh0dXBWQ1Rl?=
 =?utf-8?B?YXpEVXEvSmRUSGo2VTBML1ZLKy9PenliNWdZVUlhQXZJbHZJcDBObTFrbExS?=
 =?utf-8?B?RWdQUURaQ2RKZnpGc1dvYmFYRmIrS0VSUFZyOTZGOUtrVXh6VjVjbnBCSHB0?=
 =?utf-8?B?NDc3YWt6QUxtR0J2Q0EyRXYwZU1rdkhlMTdKK2E3N0o2ZEV3dXk3NkFpZ2U3?=
 =?utf-8?B?OS9vb1VMK1BEZWI4Zks4eWhUTG1peWQyTEJIK1dGdEtqcURsSDc5VEJ1ZVJL?=
 =?utf-8?B?UTIrUGsxdC8rU3VQYStKdXRFdkdNRXpQVSt2Y1ZoSTlyMmJyWEVnVWdMMHVz?=
 =?utf-8?B?bXJnR3hRWDBqdDZnb0Y4c1Exd3A4ODZhNjJIK0ZVRjgxNG14Q2V1MENtLzRy?=
 =?utf-8?B?ODVvaXV4TTYwYlhKd01vTndBcW5NUzBHOXhRcXV0c2oxckcvYVF2TTdyVXJm?=
 =?utf-8?B?ZWNTcGVpd0VTaGczdW12V0dTRkwya0FFY0FvSUFKM2c0ajF3QjFtSGtENEkr?=
 =?utf-8?B?c21ya09ZaWdoZXIrUXp0QlRML0RvOEJjRmZmaFRhN2d6RWhjVWN0cFR0MUYr?=
 =?utf-8?B?UUxha21aVW4wRVdNY25LMkhaSzFuNks4eS9WRU9QN2ZRRy9tdmdRSms3Uytu?=
 =?utf-8?B?dGN4Ukx1TjVqbUtSWkhOaWt2L09iK1k2L1NmS2FlK3ZLeVBScWhZaFBjazl5?=
 =?utf-8?B?MDJ2TG5QL21nWTZXRGtFY0J4c01JcjRJTEZXOThYemFLN3h3bTFTMUNsQitP?=
 =?utf-8?B?N1d4cEpwQ1pVaVUwVFJXaWw3eVBJcUpMOWR2ZHFaQ1lDMlAzdlB0ZEIrMXhP?=
 =?utf-8?B?VEhCcU0wSis4bGx2emRqRVNrcktzQzF2ZmIwRWVVMXZ6cnQ2UnZuRzB2OVg3?=
 =?utf-8?B?K0ozMTFyOElKMEgxeXZtWi9sNHZYcHpWaUpNT2F5bzdPQm4rQlJMTWNqejVm?=
 =?utf-8?B?V3ZRbncvZEtmdGVkUHQrM09pSDdkVmxZdndZaDBEdzU4Q0FsWG5aU2JWWnN6?=
 =?utf-8?B?YmJjMnBwQ0dJRmVwdFpPN0Z0TC9vaHhNd3RqaHAwaGxSZm1FKzBXTGl0Tllz?=
 =?utf-8?B?RmhkSkxrei84a3pHZXNubVNFUmJLMjZSa25ZTVJwN1BFSnBSandQb0ZpMndS?=
 =?utf-8?B?SVIvUlFyV3BWT1VST29iK2RuWFNvNlZlUk16ZWJZdDZPQnppdVF5U1NQWjNM?=
 =?utf-8?B?T1krUFZlK1pwbWhWUU5KM09QNnZoNmJkTHZuR3JqbXA3QnpZVGlmN2E3Z1A1?=
 =?utf-8?B?U2pxM0JhNE5nK1NwWTM1NWZzRG1MZHd5WTg0T1dGOGNiRk9lWkJ3L1VadHhK?=
 =?utf-8?B?bVhsenAyMmRsbHRSYm1wQ1o2OWJBSDNpL2Mwc2MwTVFaaThwbzFud0N3WTVB?=
 =?utf-8?B?Zy83KzgzUlZFZVExWWFqVnhpME5EWFJIekNhNUxZMUdlOWdoTGk2c3lZNWdo?=
 =?utf-8?B?UXQ4SUQzbkljWE9xbFh6RkM3cmRTSjJwQ1lzOC9Bc1F3U1BLMWpOUGZVNGo1?=
 =?utf-8?B?L05xTUlRd1V4dE02Z3JjMjRqNE43RmtYb2plUjZmbmN4bUU5a08yMkNxSzFC?=
 =?utf-8?B?UGNrU3B5cWEwSkY2U1FmeFJUNGZBWFY3Tk15Vm9rREhET0duU3NtNkpRNGx0?=
 =?utf-8?B?VnZnT3dGU0t1R1BGSDgrbnJmTUY3TkJrcVVOSDF0WDlnR1VEMURzeDduQ056?=
 =?utf-8?B?SEUzbkx0M1c3RFhTT0FwVnA5QThVMElsdUlEVlhsMG5uelhONE5Ya3pPUGFI?=
 =?utf-8?B?ZDgwamZ3UWtVSXdHVXVxNjhzOWovc0t5S2NES0dqVnJxb2NtZUtvaElmTzgw?=
 =?utf-8?B?NGJRb0FFZWZYREpvMlhpZ1NVT1JIWVZvWTQ2d0p6aEhSK25BQ3RYMzZtWm96?=
 =?utf-8?Q?k6qzbD2zd7pCk78hLr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106240e1-877e-4418-76db-08df0a5d6b45
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:20:45.9192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAX0cIvjMiqKmWaeNgHmEXSem+p+IXz/JX9PwfgrexsOlksiF/QNp7AzaNeMyv/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054



On 9/4/26 10:06, Jonghyuk Kim(MalHyuk) wrote:
> drm_sched_fence_get_timeline_name() returns fence->sched->name, and the
> drm_sched_fence ops keep a .release callback, so the fence is not
> ops-detached on signalling (dma_fence_signal_timestamp_locked() only
> clears ->ops for fences without .release/.wait). The callback therefore
> stays reachable on a long-signalled, userspace-held finished fence and
> unconditionally dereferences fence->sched.
> 
> A driver that allocates a drm_gpu_scheduler at per-context/per-queue/per-VM
> granularity and frees it on an unprivileged context/fd close, while
> exporting the resulting finished fence to userspace (drm_syncobj /
> sync_file / dma_resv), leaves fence->sched dangling after the free. A
> subsequent SYNC_IOC_FILE_INFO ioctl (which calls get_timeline_name()) then
> reads the freed scheduler:
> 
>   BUG: KASAN: slab-use-after-free in drm_sched_fence_get_timeline_name
> 
> This is the same class as CVE-2025-38703 (drm/xe) and CVE-2025-71302
> (drm/panthor), which were fixed per-driver. amdxdna, nouveau and msm
> (VM_BIND) are still affected in mainline, so fix it in the core to cover
> any per-context-scheduler driver at once.
> 
> Cache the scheduler's name pointer in the fence at init time, while the
> scheduler is guaranteed alive, and return the cached value from
> get_timeline_name() without dereferencing fence->sched. The timeline name
> is not guaranteed by the contract to outlive the scheduler, so document in
> struct drm_sched_init_args that the @name passed to drm_sched_init() must
> follow the dma-fence safe access rules and outlive any exported fence.
> Every in-tree driver passes a string literal, which satisfies this;
> commit 299bc6d50b1b ("drm/xe/guc: Keep scheduler timeline name alive")
> keeps drm/xe's dynamically-allocated name alive across the RCU grace and
> can be simplified on top of this.
> 
> Fixes: 506aa8b02a8d ("dma-fence: Add safe access helpers and document the rules")
> Cc: stable@vger.kernel.org # we don't know since when
> Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
> ---
>  drivers/gpu/drm/scheduler/sched_fence.c | 24 +++++++++++++++++++++++-
>  include/drm/gpu_scheduler.h             | 18 +++++++++++++++++-
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
> index 096fe28aa9c9..b2a842a1c9ba 100644
> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> @@ -92,7 +92,13 @@ static const char *drm_sched_fence_get_driver_name(struct dma_fence *fence)
>  static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
>  {
>  	struct drm_sched_fence *fence = to_drm_sched_fence(f);
> -	return (const char *)fence->sched->name;
> +
> +	/*
> +	 * Do not dereference fence->sched here: a userspace-held finished
> +	 * fence can outlive a per-context scheduler. Return the name cached
> +	 * in drm_sched_fence_init() instead.
> +	 */
> +	return fence->sched_name;

I don't think that this actually solves the problem, the sched_name still needs to be kept alive until all fences are destroyed and that is something drivers don't want/can do.

>  }
>  
>  static void drm_sched_fence_free_rcu(struct rcu_head *rcu)
> @@ -180,6 +186,14 @@ static void drm_sched_fence_set_deadline_finished(struct dma_fence *f,
>  		dma_fence_set_deadline(parent, deadline);
>  }
>  
> +/*
> + * TODO: Both fences implement .release, so dma_fence keeps their ops attached
> + * after signalling. Dropping the callbacks would let dma_fence detach the ops,
> + * after which neither get_timeline_name() nor get_driver_name() can run against
> + * a freed scheduler or an unloaded module - the complete fix. It first requires
> + * auditing every to_drm_sched_fence() caller, since ops-detach makes the helper
> + * return NULL for a signalled fence. See Documentation/gpu/todo.rst.
> + */

That sounds like a bad idea as well.

Dropping the fence->ops is to detach the fence from the module which originally issued it and not solve lifetime problems between the scheduler and the driver.

I think we should rather re-consider patch 035219a760edb35ae9a9e96beba7f122e26a997b ("dma-buf: dma-fence: Fix potential NULL pointer dereference"):

Here we changed the check in dma_fence_driver_name() and dma_fence_timeline_name():

@@ -1167,7 +1167,7 @@ const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
 
        /* RCU protection is required for safe access to returned string */
        ops = rcu_dereference(fence->ops);
-       if (!dma_fence_test_signaled_flag(fence))
+       if (ops)
                return (const char __rcu *)ops->get_driver_name(fence);
        else
                return (const char __rcu *)"detached-driver";

The problem is that we didn't considered that there a fence implementations which still have a release or wait callbacks but rely on not needing to return a string for a signaled fence.

Regards,
Christian.
