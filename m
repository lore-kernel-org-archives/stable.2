Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A93FC5D0
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633058; cv=fail; b=OMkP19w41+nzKD5qBw9lIOfoqpgQengg/DWIssHrtfbT7xu6O+r3GIjMFVqnk8X/t4umkN4aXzfb+Qjlw6tVYH5Syt30IIhtt40hUajvwXJDCqJznr6CQscZtKt5pQflXwOcI4eMUVrgHjGbb7S2MfkU+f00qUOdDNkmR5fu9ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633058; c=relaxed/simple;
	bh=NjjDm6gOzzfE/T2ytAhFF0LORC0QSOYoo1jdFbOsMLk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nhncmhB7V0I+8l00D6cSbhcobzVlTuOKrPN5XW+E3EQMNo2p6mYkpsZgBJwhSc5rEWPXMMl8oFMUDvQikw1LlB+/actS81aWt2hNflqrTPMj2QNFBB5WBcVOqU13jnztvBxHnQOkZwDDDnd+8tfbM3obja71G85yqK6edjq32cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fwG+LKEC; arc=fail smtp.client-ip=40.93.194.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fwG+LKEC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTbDpX6ToFHeUdLP38UAf6u2+dOXpNfiS54BEj7dcj0B3Bu4l3kySBwAJiHVczXkf569Z8a/V6hQnt1A00hdco3vdAKMmXkXRiO5jvgXvv7b9XmhzjmcNsvdPh1nqxcShQg91FOd5+hyo8LSjOriu2/7k8EEWCNT+MT9H+osDEFCsMOzPWCAwIvXDjEEFVtW5nK8yNbnRHJru/+oJESnj0U87Wm4INdJwvc9KAO4NXoDxGvUnDJx3IkpuQeI+Jdhhoya5Cy5naormhVko5xru6EIGNkhP2KnWLHDQxF7flFMV57v/VYN9D6GYRSGWQyNETQsuKKVLYylF6rdni+v1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ThekFcYX8kC1eHRd7h7V+Kr+dsYWeV9D3v6cXknA0U=;
 b=WJpeq5sqRARAD6v4neqx7CfW1THJaS0f0Z8W7t3hfVhvlfzikzGyxaiJ8/2tXBS3Dwyf5Hm8wwJ6DR5XpuYXOBKdwL867OvMvAiCZVxUqOYMbp4QK7GF8kLNMtgiwrA0+Tc70Os+ZBKfYPAWYQF+GnUZDx9g6eAbbSyL/Q9Y8rd9D0B7mRnZbpWEt0+1uhMGwhs8FMK4rXSJ1Ay622UehqX14VCcRsHAEpW+7CCDnOkR/Or5Cq/Y6Be0uCxFP2zuQVidKE5WNQXFjH5V4UsP3CUCOYWtRAnEqBJw6FhWA23QfyBwd1HptOHgPUWWkByg+/IOhGy7+8D+HrAn3n/cTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ThekFcYX8kC1eHRd7h7V+Kr+dsYWeV9D3v6cXknA0U=;
 b=fwG+LKEC+gW1IESIqyZjhEgSWTTe1yjuAxONuxdnM9dXpKLesO/0ONxwmTQo0mp1wWoka45QBd/5Gqg6x8G0DE0ynLcPvUjvgkanAfsJITrGjoOT5mtTOVYlFCrCDI+VtowCEB33fwaC0pNjkP5ePoFf0vRM6jS0QZfOOE1jK8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN7PPF7F4CD71A4.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 08:17:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 08:17:24 +0000
Message-ID: <9112dc00-73b4-43b8-879c-bb2eaf677b0f@amd.com>
Date: Thu, 17 Sep 2026 10:17:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18.y 2/3] drm/amdgpu: rename amdgpu_fill_buffer as
 amdgpu_ttm_clear_buffer
To: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 Sasha Levin <sashal@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <2026091636-creole-glorified-e7b6@gregkh>
 <20260916183641.1771014-1-sashal@kernel.org>
 <20260916183641.1771014-2-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260916183641.1771014-2-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:208:52d::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN7PPF7F4CD71A4:EE_
X-MS-Office365-Filtering-Correlation-Id: 3347b6b9-c289-4061-e2b9-08df14941a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6jLjyCrL5gaUnLix9Eh1yxyUo8LfJqe6nGXq6PyUSEUeVnfIYohzD/+Z41Lm62GmjOp0L6atGcisT4zdYUhL+I6x85ot6nFvCPEHxBzK36QQTn4fAFQxL1E8qVVhn1tZ+FRD0J1UzeUnRCMYQ7Jgc67BRVsRIsIsrIYN4UTPkCKe7WiJGnqAon7tfKehcykFYFldmZD1YSyTaSgIbDbPtQuejBEYz0zq3v/twYHYOg1OBpaAA17uBQ7M7bKHw6KhMZktVhBio02EBlpDOuhYowph4Vw2BiPCBNQTbpC/OrDfCClbFmDc/q55E4+onKw1ptDk0HHChvp3mPKOml17Ea/p3MT/wiJPcddGUzeH7F1ro+VUrnZNsJLvsVRSE0v0AxeLH99tiktXbJKvn5iJGUpPulTA23/b+4Z6ndkrO4uEAP/WU+9Byo5xbxAcVPCM1PI4B6JVKGJSwBttk30f2gVfoPfWe/WDD5HldchVJE4mFyuJ4q21SBNiFGZct27mDx4Xk/MYJd+oB18Q+wZpWuWKf+9YjVtI+wUbKF8bZ2/rFpCLwACiawb8tn8ick2M4Cj5/iFB1V1a5pdUBk68N0W/QpYXbNWjGGXNs98p+4d5xDY6aLbj+fnpdB1fPpgv8LevfcPefMu6ViHec8nbqlmsmszCI/jqGOSdRNhaZeg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEsvWlUyNFdJcFMzT3ZNaVVPVGs3d2pES1plbVEyczlIOEZrOEdWcTJlTEgz?=
 =?utf-8?B?dnQ0enFMWkdxVmJxUEx1Z0YwbXpVZUpWT1B6MnJZaEhLeWk2MFd3NC9STTlG?=
 =?utf-8?B?bitvMHBZLzRrVG55QmEyYXVmQkVzQ3R1RGFNNmp2b1BlQW9wZFRnOGhWLzB5?=
 =?utf-8?B?bEMzeVQxOUNxWXAzNDc3NVlEVEx5UXJyOWY4MWhmYXZDdkxESTJ2ZERVL0J5?=
 =?utf-8?B?TitnSzAyU09ldDYrYjJPNCtFbUlGYzAwZ0FuNmlIOW1WOWJuejBnNlZySnoy?=
 =?utf-8?B?ZXpveEtweFBYUUFGMVQzbFVvNllIZEZ0SjBEcUs5dXd5VnN3OENET3pVdklm?=
 =?utf-8?B?RTQwa0JTem1KVUo0MHdSc0pCbDl1UExhTkJ4NXhKVW1iSGxIZzdJcHhtbC9L?=
 =?utf-8?B?T0sxeWlQTEVuN1pWL2pOUEYyZy9tNEljT1JmTWNodGo4NU5TbHpZYWQ4aXlY?=
 =?utf-8?B?LzJaOUllNmZRRitXQ1pGV01NSjhoUElYL0ppbUpZRjV6MHNSRVBBZktLQVFT?=
 =?utf-8?B?K0E0OXJ2d2JjRWpESW5IOHA1UGVtUUdSRmhYT2trRXpnTlJrbHU5amdmenJV?=
 =?utf-8?B?bmFqRElwV3V1NTFrY3lRcHFBM2hMMkdvLzF2UnlYNkpPU3NocGpzcDgxeHFL?=
 =?utf-8?B?dWRIdnE5ODcxV0g4SlkzdTM1NVNYWk1YK1dEYzRjc1FOSjFsbnRaOGNVQnZr?=
 =?utf-8?B?N25nTXhQQjdUa3NHcFF0OHNjOTdvQ00rOUFObEhqTHpJVDN0TVBwRjdPaHJi?=
 =?utf-8?B?R1NIUFVCN3BVWDB3TnpuY1NaSkpWOVJ5ZTZmOTF2QStIc1J3MnVhbzNNU3p3?=
 =?utf-8?B?d05rN1doTFZucUFkZWliTkJqOGdQR2xSSW1Lb3JRaXlBSHVoNG1DeDZIcGV2?=
 =?utf-8?B?Y0dLcGJIalBTRWYwTEdaTERHVkIrMEdod2dBMzlMUzg5VlQ0U2pMK0V3TTg2?=
 =?utf-8?B?b1NsWEl0R09sTkpjM0dGMEtsalZuRXpPMzFBczZ3Ymk3bVpDTkgyRXJrZ2Vp?=
 =?utf-8?B?UGFxVWNTbFQyWmZuNjdNTWxXaUVkaGhZbGFwajlBZjUrcEhvR2dENk9UaHdw?=
 =?utf-8?B?R0VWazBEdnphUUtjWWRhWjlHZ0tDSnB1elhVWFpIWHJ3cWY4RnM2KzNDbCty?=
 =?utf-8?B?MklsQVRVc3k0clh6aDRMS3NmZnFVem9nWFkvZmJXRVhkWEtROHZNdmg0Tlk4?=
 =?utf-8?B?dzluR3NUSkNsOGRXWllCZUFVc0VWVW1JZ2cwSXRJc1pXSzVvL3AvRnhmeUox?=
 =?utf-8?B?eVd4Zkd0aXhvU1haOUNxNndSMmlFby90UHNXcVlseFF5Uk90VmhVdzY3WDZ2?=
 =?utf-8?B?My84aDY0Vy9rTUVkYkRRRkU5aDJFejdrOGZzbVVOU0loVzBqQW5WWW5CSmNv?=
 =?utf-8?B?VmNyamd1cVFtZUtkR20wZDNiRkVhVnZVM3pzM1U5YTJiS09WM1RYSGV2L2E1?=
 =?utf-8?B?ZVhMTG5DbWRmQzZha3lnM3pUVkRDVDdGV1hUYWJaZlJxRUhnWHhRVWdZWDhP?=
 =?utf-8?B?b1B6d09MWkJuUXVwb2J4S3FCbTFsUFZmRGdFVXJBV2RxQUpIWkF2S1NraGpm?=
 =?utf-8?B?aUI3WUJrOVJoV0syQlhUOXB3VWFMM1dnMUZYVnMxL1VPSmI3a0lsS2g1S1U4?=
 =?utf-8?B?ckhQWVlvUHpkRVpURU5UYmNYZmx6cTROMFQ1dTB5bmNoTER5bUhtNDRTNXJX?=
 =?utf-8?B?eXhzb2hTMkJiUWZhRTMxaGZXUzBXYXYxSVJVQ3Z4eXpFM3VpejA1YmsrTDA3?=
 =?utf-8?B?MFc3RkpMaXJXWXNySEJVYkpHWHVDWVUrYU1YZkJ5b0ZWSGdMc3dpRzhBRGxH?=
 =?utf-8?B?V3ROVEZhaytFVEwzV1JmMk93bEl3aG50SUN2b3Irb0xrdk1KQXdOSW50ZXhv?=
 =?utf-8?B?TjZBMWs5V1MyV0l0M1ZZZVk0US85YTRaT0hjS3ZPUFFGM2hvVVdjVzVJaVl1?=
 =?utf-8?B?SVh5N2NPMWp5OEtCNnAzbWR3cjhjcFQyMUh1cEc5VnArd1NpcmxQKzc0bkdP?=
 =?utf-8?B?ZUJIbE95OHFVWUNCQks0U2JlQVNIdXBvTEFqQ2k3UGNnTkhiSHJ5M0VlTllO?=
 =?utf-8?B?dHJ0VStLdjZUVnQ0K2R2SzNWT3MrZHY5VTVNeGQyT1RhWVJwMVp2N2hXZXpm?=
 =?utf-8?B?cXNZOXNwSUVTTks4dUV0UmVkVklsSlpCRERBUGpVenVTUm5QenlnRFd0VU1R?=
 =?utf-8?B?YS9QMGlzUjhDd2U4MnNuUUUyS1Q0bS9IaC9mRGVsY3h5N0wzbXVuV2JHWVhp?=
 =?utf-8?B?eWVLckwweVkyUGc3clNta1NCK0J1a2ZOa3hWM1RJbnpia2JmT1ZrU25ycmpL?=
 =?utf-8?Q?dIVhfIHMV/+dH62G+a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3347b6b9-c289-4061-e2b9-08df14941a93
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:17:24.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3ch1LjEua1Y9YYkYGSB319AznP53DBcGE56Gu1ZdKhQ6/35At4xe3B0KKOxxYBX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7F4CD71A4

On 9/16/26 20:36, Sasha Levin wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> [ Upstream commit 5bd8aab55bc18a744577bff79a8c58b031e3c05d ]
> 
> This is the only use case for this function.
> 
> ---
> v2: amdgpu_ttm_clear_buffer instead of amdgpu_clear_buffer
> ---
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Stable adaptation for 6.18:
> 
> The preceding stable dependency already specialized amdgpu_fill_buffer
> for zeroing and removed its src_data argument. Retain that adaptation
> and limit this dependency to renaming the existing helper, its declaration,
> its kernel-doc heading, and all three callers.
> 
> Keep the existing drm_sched_entity type, high_pr/low_pr selection, shared
> GART-window locking, reservation dependencies, and no-job return handling.
> The upstream amdgpu_ttm_buffer_entity infrastructure and next-clear-entity
> helper are absent from this stable tree and are not needed for the rename.
> No functions are added. The VMID-flush changes remain in the target commit,
> whose unchanged patch applies cleanly after this dependency.

Oh, that patch was never meant to be back ported but I see why it is necessary.

> Stable-dep-of: 87ceb8cba73d ("drm/amdgpu: skip the VMID 0 flush for VRAM")

@Arun can you guys take a closer look if that is a good idea or not or?

Could be that "drm/amdgpu: skip the VMID 0 flush for VRAM" doesn't even needs to be back ported to kernel 6.18.

Essentially it shouldn't be necessary and is just a workaround for buggy HW which surfaced because of clear tracking.

Regards,
Christian.

> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 12 ++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 18 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    | 12 ++++++------
>  3 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index e29bcb090f06d..4def8b6640891 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -728,9 +728,9 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>  	    bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>  		struct dma_fence *fence;
>  
> -		r = amdgpu_fill_buffer(&adev->mman.low_pr, bo,
> -				       bo->tbo.base.resv, &fence, true,
> -				       AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
> +		r = amdgpu_ttm_clear_buffer(&adev->mman.low_pr, bo,
> +					    bo->tbo.base.resv, &fence, true,
> +					    AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
>  		if (unlikely(r))
>  			goto fail_unreserve;
>  
> @@ -1328,9 +1328,9 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>  	if (r)
>  		goto out;
>  
> -	r = amdgpu_fill_buffer(&adev->mman.low_pr, abo,
> -			       &bo->base._resv, &fence, false,
> -			       AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
> +	r = amdgpu_ttm_clear_buffer(&adev->mman.low_pr, abo,
> +				    &bo->base._resv, &fence, false,
> +				    AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>  	if (WARN_ON(r))
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index dbaba8aacec27..8a433a0920e74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -412,8 +412,8 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
>  	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
>  		struct dma_fence *wipe_fence = NULL;
>  
> -		r = amdgpu_fill_buffer(&adev->mman.high_pr, abo, NULL, &wipe_fence,
> -				       false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
> +		r = amdgpu_ttm_clear_buffer(&adev->mman.high_pr, abo, NULL, &wipe_fence,
> +					    false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
>  		if (r) {
>  			goto error;
>  		} else if (wipe_fence) {
> @@ -2394,7 +2394,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
>  }
>  
>  /**
> - * amdgpu_fill_buffer - fill a buffer with 0
> + * amdgpu_ttm_clear_buffer - fill a buffer with 0
>   * @entity: scheduler entity to use
>   * @bo: the bo to fill
>   * @resv: fences contained in this reservation will be used as dependencies.
> @@ -2404,12 +2404,12 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
>   *                         after allocation.
>   * @k_job_id: trace id
>   */
> -int amdgpu_fill_buffer(struct drm_sched_entity *entity,
> -		       struct amdgpu_bo *bo,
> -		       struct dma_resv *resv,
> -		       struct dma_fence **out_fence,
> -		       bool consider_clear_status,
> -		       u64 k_job_id)
> +int amdgpu_ttm_clear_buffer(struct drm_sched_entity *entity,
> +			    struct amdgpu_bo *bo,
> +			    struct dma_resv *resv,
> +			    struct dma_fence **out_fence,
> +			    bool consider_clear_status,
> +			    u64 k_job_id)
>  {
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct dma_fence *fence = NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index fc5133af30485..c5f7efd78409a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -178,12 +178,12 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>  			       uint64_t size, bool tmz,
>  			       struct dma_resv *resv,
>  			       struct dma_fence **f);
> -int amdgpu_fill_buffer(struct drm_sched_entity *entity,
> -		       struct amdgpu_bo *bo,
> -		       struct dma_resv *resv,
> -		       struct dma_fence **out_fence,
> -		       bool consider_clear_status,
> -		       u64 k_job_id);
> +int amdgpu_ttm_clear_buffer(struct drm_sched_entity *entity,
> +			    struct amdgpu_bo *bo,
> +			    struct dma_resv *resv,
> +			    struct dma_fence **out_fence,
> +			    bool consider_clear_status,
> +			    u64 k_job_id);
>  
>  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);

