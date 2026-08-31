Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F93F3281
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178436; cv=fail; b=IJ5pV1+8mSsJfsWlKKCRtLk9+UR7+5BzDLilk33USxT1sgT7H+DDWu7sp/tI7nBD/qTlJvCHF1pOGjHT3+VDilofNKvYGSzoISNqoYr/CrEF+K6zfOu6U37Mj4sTh1XRd4glznhMbNSoeu+qKoqhpUwQXgglxljk5Uhf0cuZiao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178436; c=relaxed/simple;
	bh=dYJnEXc59iF+H5H4VMeIyRy4hPiffpCZuXINvD/o9Ls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sL1W1xKm/miwRPucW5i5ziLXJs7CuE4c5QtykNRKo/XrnrQMNdpk5igZY/3XadcmNFgLiZlEPmnLWrH8scP1ik7HyxMy6l0geazY31+lh+wT6O0XLkpDBtwx+DNH2sS85E6hoxTMm83L4QZAjJEIoWHE/yM9WJWBuInq/IXgEMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TF+tY/MW; arc=fail smtp.client-ip=52.101.85.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TF+tY/MW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNVhLHT1ScMv2fU5mk/u1I3HMsY7c4inak7bM8Q9RHZX3jgGekNP/l1Gf9QYy8qpvytPkqMDNQUg20Xi+Yo0rTW/ofCzg70XsBGhj4Gn7KPITlCZfrOqXFhQChayw3ChSWehVRoAixifd2GE1pycBwQOCbhGc4EOFS4wSlh7H9WqCAfwS16VbS4FdN3NsjJcJg39Swe1q1lpmhvBh3pXxJSeJYqzLnga/Zzel7CYuHhTWlT0juWn8XBf2GCLiTvP1TJ46Ku9s5319RQaN5W17d33dcWSDS0gQ7Fayi9pZEgo2stm8/YkJfZRpuO1lmQ9Z88Gk4+Bl8gyBuBvzpZnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq9sZaN/m0xUHg/P0x6sITCkpAqlmV2UiarkxlasIqQ=;
 b=cq66nEdFxovRSU1z3p6rmSDiVTR39GOFo5Nuxivc+aM8X+W2/9Ec0IzoCnSouUMkIuvUAcVEcFLBL0o2AYirXW/JMaEiyexJYyFfQtzHWDLeE29fGjufReceYM666bUSItn4AAXoi7PQ+aLZqgmmVU0634uI1v4Puz97UA3T91V9FigPZvO6Z5Bc+ndmpSQp2CEfmgwAM0an9IsYlb5d2rNblhPDic6wEQSh75PA2+GLeB2cM2uSaycAP3NliIR0UieEKMH1tByGL1/xhoQq3PMrZxQZfKZi8FYYItAtlFUgAcc+z9njd9cOtPiHgir+N/mq1GS2ldvC8eoReQu3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq9sZaN/m0xUHg/P0x6sITCkpAqlmV2UiarkxlasIqQ=;
 b=TF+tY/MW/OkfsAxdWzb29hdvw3Y6vfXCzGn+kyomLUdknd1Qa95Tx+T6Zm8rk+usfj3icGo4ECGTSf+hL5RK/Wd1KRZN63Oo27SCGjjspUSVI3+jqc/fPtoMftM734yu+LShXwFIDVLWMQHCnUCBQ+UfyLcajrZIFCFTrtO8m00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 12:13:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 31 Aug 2026
 12:13:50 +0000
Message-ID: <03347904-e0ee-42ef-a40a-478309a2ba33@amd.com>
Date: Mon, 31 Aug 2026 14:13:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: skip the VMID 0 flush for VRAM
 clear-on-release
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 stable@vger.kernel.org
References: <20260828044734.135460-1-Arunpravin.PaneerSelvam@amd.com>
 <voa7PnOgTa6oSIPH4Hu9jQ@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <voa7PnOgTa6oSIPH4Hu9jQ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: e64a0fbb-787d-4871-1620-08df07595133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MsHqaDcT5eGgY1aQgw/2ZtHfWYJo1lgVwSQbMcb4BmnPU4Gu7pzd/X4ohhy7Pf8vd0f6P8NRAX5f6MLjiYqw6f4Ps1wPggu3L0MDmnnsFYJ3DkMmzCRl5GPrQQV+IhRtky7GpHoZKxHeXM5AM86/KcO27dE4UrjK2JarTWgz0dUb8dfg7XZ3E6xGyjV0sWgIDKpU+OFq3ISPLaVc8PlBkFkYqmLc4c2kTFz6/xwlcjR/GEBEuT+hpEsOZ8vbYI5m+Lm/S9mpD1QTF+txo3QC9ZxnyV4bDHX95xckWPt2tpxzDk+RQ3H0QnLfMwme3V0cisrSjX0ci4xp+ZsVXt+jkFSGz7Zgz+V4oEpwvLjCNUVfwDtXYVm8VuCJk7bA7KxiK5LYp+coUVfqqpBJ5LMar9cS7V6gOnyFtd2bJ0x3d72IUyUgbtKb2IcfTo69sso+RRMoSxHViL59S69Cp6WfKO1r+LairFGTXc76G325l4nAaxR5ws1t+0wxmr42FuGOt5On5/2fOYR7w3HeOrBrYhrBbBbI+OkHlkfxpq/d5gNmuSkblVdix4PUeuNFVuTSs4r4Dt5annbxo471MvRwFLhllg1z3q9QCZCH9xSY3JDkK6eexvQccro1Kd/abvIkyXadYmX+uEGPmeCWu5JyUjAckCYu5jgMIivRW3nT0mI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1I5ektGNkRWYWEwTzRubUQ2WW5QcmxxR0tJY2lRaVdHVGlpNkFxMHNLcXdE?=
 =?utf-8?B?VC9QZ1hLQmpHY21wZHZQaWdLQ2RwejByWjIvclF0amdpRHMzSDZmbWNVdXE3?=
 =?utf-8?B?T1F3aWVrUEZqS1ZEZlZsTHREVWxaVy9iVi91eHpKV0hhSml4aWR1aUpmTnJE?=
 =?utf-8?B?Mi92SVlpWHg3RFZKWUlyQzg5L2J4R04zVC90Q0t1RmloODBVbjBhbjE3KzNS?=
 =?utf-8?B?MHNQWjhzaThQeUNXN0RZTWFHbkpaT1Zoa1FsSVVNNnBQdHNTalphSW9oejl5?=
 =?utf-8?B?V3hZS0lxS2lCb3Y2Yk1NRFlONTJxL3hsek1DZWVxWW1YZmJQaHg1MTY4QVJT?=
 =?utf-8?B?SDQ3Q3hSQ2dzQzVUTDZhc1RYSExBTjIrdkttN1NTZEo2VWNCd0xwUVE0b2t5?=
 =?utf-8?B?VUpPeHpsL0UvRUZMTzNFQk5La2dlNFZQUzhGU0NSdFkxOCtBcUFyZUp2NWRB?=
 =?utf-8?B?KzZhM3Zqa0t0T3RtSzdKaWdISEptQURUT1dlRHhkNlpkbE9yZDJTQnZtYll3?=
 =?utf-8?B?L21kL1U3TncvcFpoRFBCWXUwbkpQcHlEcURCeGtxcSsreVh6R1F5c2IzSnRr?=
 =?utf-8?B?K2dPMkxCNkFPRTRhR0xYTW5IKzh6NWpVeVBVbTJCOWljTExUN1ZhRVppcnhz?=
 =?utf-8?B?TE5ZajU2bnUwZlRWQ1habEZnc2U0T1B2a3VIY0RnSU9Ia1I4WXZOQzgrNkV3?=
 =?utf-8?B?ck9JMUJOemNYMU9NeFdOdnByV296TnJKRlpJcUExanFPaUh4c2VrM1VneFkw?=
 =?utf-8?B?dUJSMUdnK05IUTdLNXFrV3VsWldOWFlZdmxnSHQwMFE1eU1qTXBtbFRKZVJl?=
 =?utf-8?B?RlUreGVUb2NPbFp4R3FMeVBMNmxjWUVlSFNMYlUxZnE4Z3E5Wk1UQ1o5U0xF?=
 =?utf-8?B?Tm50U1BGa2xuQWxaZGxuZk52b0ljejJDdlh6cElwUXNnK3VmTmhZemVYbUhK?=
 =?utf-8?B?eFUveDU2bHZlam84Rlh3QmYrbTRUVmNCQ1krS1UzeERheXdUdEdQOGhTbUdq?=
 =?utf-8?B?UHQ2aVBzakh2RFVaRWFCQVBDVmQrZThCWTdzWUFjdEpUcEg0QjRkVjVXdXBw?=
 =?utf-8?B?YkZTbUpvSTBtU1NYUG5wQlk4Nm90bjZCcmRhUlRlbUdkNGxMdDZwYmJBVXFu?=
 =?utf-8?B?Q3RnQVlQQm5abmxpbWRicnBPK1ArZmxLNmJMRGZKZUhhVWh6bGJOamsxdVQ1?=
 =?utf-8?B?NjFQYWlSWEVOdFdadHVxV1hVcVk2WnBISlFMZlhsZGJoakxrNWhLY0NDd2ww?=
 =?utf-8?B?NzdsVThUV2cwQnRHVUV5R0VtS3JIeWJGNStKOCs3WTZsVEJ0NERaWStJOXdk?=
 =?utf-8?B?Y00zZzdqVmhZVGVTWDhLMXdCTkk4VDlKL2pDNHdxOERsQ0RWVHZPVUFMdkNV?=
 =?utf-8?B?d24wd1EyRFpyU1diNHUrZzViK2VsOHZIcHUybzg4RWh6YlJwYnJ0OGx5TTlt?=
 =?utf-8?B?aUlteWU0QlhGYjBNMnZCOHRIV3hIb0hvMUdQR0ZqTjlhVDB2WnJMcFB4NzQr?=
 =?utf-8?B?Z2lQRXZOV1FzTmlGTURtd3BEQ0tQeU0wVERWSFJhbWNUSG9RL29DbXlaOVRG?=
 =?utf-8?B?RFgzUFBabFNqNEtqZVA2Umt3SU9kREJRQm96U0VlaS9ITzNjeWs1Y25CcEJw?=
 =?utf-8?B?RXJGSjkwYXRSQ20rR2s3aXZ2aW8yU3MwMWxJQWRhWGVLS2NMVjJZa0pkUHNJ?=
 =?utf-8?B?T2pZVmRMRHh4MlRRZ29naGU4NFVINmdlMUw2MHZpRklHQVRqSndOVHdpTFBh?=
 =?utf-8?B?SXUyZHRxRDU1Q2orenFReThSL3ZvMjdoaVgxWHE0KzdwUThkMTVKZ0Mya2hu?=
 =?utf-8?B?QThKSExSbzFrYWJTVURUamFmZjRzb0hQcUMxV3MvaHJMUkp0VHM4UzFmK09B?=
 =?utf-8?B?RWFPL0JGajU5UjZua1llai9UVHN3a2QyVDRra2NCTFMvMXFaMUNwWTFwdlF3?=
 =?utf-8?B?VkJqS1hwZStES3V2U1lLWThPZ2tOM0dMQk4xd2FjN2h0THZuUm4wYkF2VFla?=
 =?utf-8?B?bUIrLzJXdEw4dnUzZFpHWWVnS055cjNLQU94Wnd4SWRNZTdqcXVkc0V4REVR?=
 =?utf-8?B?VDI1WWhHcHZhaEJPYWJGQitCWjhzK21uY3BzMkRKYlRreks0cXlpcE9lWHJh?=
 =?utf-8?B?WnZnSzI1NzVOaFVlVE9sVjlHbk03ZXI5UmIrRkd1ZnIzYS9NWjExaUxrQ2Iv?=
 =?utf-8?B?THNQeURlN3VEM2g5K2QyMUJrajFLVGllMlBzMy9Va1BYN3ZoTllrRS9aU1lL?=
 =?utf-8?B?ZXkydmk4ZGRTMGlhdzc3d3hFZk9rUFM3ZEwzRzRIRlRobnF0a2Z0elNiYTN3?=
 =?utf-8?Q?WV3t7Rop8V8U0QnZL8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64a0fbb-787d-4871-1620-08df07595133
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 12:13:50.7205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EP61L2JWJCFvSkq6gw4qmI0jM8vUGDQsJZx9/6qMrN2+LVgtp++cGAh9BM+UWJHh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984

On 8/31/26 13:39, Timur Kristóf wrote:
> On 2026. augusztus 28., péntek 6:47:34 közép-európai nyári idő Arunpravin 
> Paneer Selvam wrote:
>> Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reaches
>> via its direct MC address without programming a GART window, yet the wipe
>> still forces a VMID 0 flush.
> 
> Makes sense.
> We don't need the VM flush when we are not changing the page tables.
> 
> I agree with the patch, just would like to ask a few questions to better 
> understand the underlying problem:
> 
>> On GFX11 (e.g. Navi33) that spurious SDMA
>> flush can wedge the engine
> 
> What is happening when the SDMA engine is wedged?

As far as Arun has investigate the UTCL1 request queue (which is part of the memory interface of the SDMA) is in a deadlock, but we haven't quite figured out why yet.

> Can it be recovered by an 
> SDMA queue reset?

Most likely no. The UTCL1 is the translation and memory request queue between SDMA and the core memory hub. To reset that one you need to reset both ends and the core memory hub usually needs a full ASIC reset for that.

> Is it just a hang, or can it cause other issues such as page faults?

Good question we honestly don't know at this point. The HW guys need to find the root cause first.
>> only flush when a GART window is actually used.
> 
> Does that mean that there is still a risk of the wedge when the GART windows 
> are used?

Yes, and that is actually not limited to the GART windows. It looks like every time we map something into any VM it can happen that the SDMA crashes when there are concurrent operations ongoing. 

It's just that the GART flushes triggered by the SDMA made that scenario much more likely than anything else.

> Can you remind me when/why we need the GART windows exactly?

Basically every time we want to copy something from system memory to VRAM with the kernel.

Regards,
Christian.

> 
>> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
>> Cc: stable@vger.kernel.org
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> 
> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
> 
> Thanks and best regards,
> Timur
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c index
>> 6c07cee8e8777..2e6c98c2f1efa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -2578,6 +2578,7 @@ int amdgpu_ttm_clear_buffer(struct
>> amdgpu_ttm_buffer_entity *entity, struct amdgpu_device *adev =
>> amdgpu_ttm_adev(bo->tbo.bdev);
>>  	struct dma_fence *fence = NULL;
>>  	struct amdgpu_res_cursor dst;
>> +	bool vm_needs_flush;
>>  	int r;
>>
>>  	if (!entity)
>> @@ -2585,6 +2586,8 @@ int amdgpu_ttm_clear_buffer(struct
>> amdgpu_ttm_buffer_entity *entity,
>>
>>  	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &dst);
>>
>> +	vm_needs_flush = bo->tbo.resource->start == 
> AMDGPU_BO_INVALID_OFFSET;
>> +
>>  	mutex_lock(&entity->lock);
>>  	while (dst.remaining) {
>>  		struct dma_fence *next;
>> @@ -2605,7 +2608,7 @@ int amdgpu_ttm_clear_buffer(struct
>> amdgpu_ttm_buffer_entity *entity,
>>
>>  		r = amdgpu_ttm_fill_mem(adev, entity,
>>  					0, to, cur_size, resv,
>> -					&next, true, 
> k_job_id);
>> +					&next, vm_needs_flush, 
> k_job_id);
>>  		if (r)
>>  			goto error;
> 
> 
> 
> 

