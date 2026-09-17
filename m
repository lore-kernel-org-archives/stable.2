Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0897640759B
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641345; cv=fail; b=pRym64vPvJlH69RIpz3nxXghu65AFyLmDUDbaq1CBDXX0vYNzDIoiofEUY/y1//Y+LZKHRvUQtWiOmnQHptv3mb0E+Ei6UOPvOWmUKuXPuDnf5tlQUVwELlbl1cmfgXBiTQFmR7Z7Vgzvpr+qfuN0oQUmLlEQ2Yd6QlTXge1TnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641345; c=relaxed/simple;
	bh=47gL2qIO1CL5+SepfVg7W+86mTgeuSO9dCWPSQOt+B0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p4rml0SRbl3p14rH6Zn9tkFrT+0ZfEfeLU6iOjMCpYwOrwtu62Zph0bR8ztR4jbKNubClnetFYXeHxUqn/yl9E8rLj7tY7wrmcgHxKvpEM67/BBngaHsSOP+anLWievh+4q2nx6McIE/zZ8G0aIya4KUPrqHp2m38RgJndArFUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YXWPqjl8; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YXWPqjl8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5+Dw0GUeDD5PlYYOI8SWNED8HU06PM9e3aAFO1ltLg+T5yDOStqP01Rfdz7T2mdzpsh7O0IY7pezhvxZ3K2l1dSENlRNnCbY1lpBfytj9SQExCG8cXBqYIgV8ll+AdVbV7OZORWrDioo68IEK7VxD4bgiKPXQZjdGl+c6UF6B5ya0/DzC4ECGyCvlRsaENlFZAxPDgDcLctXCGlA1Ng4A+Jtw6IEojEVFQiZ37qsGtat+fA69gVEQ7qUF798SN+4j+usVsaohrLd+OQbVVVhPN0wvZ95RHCrZf/88lAew5b6Y3m3KIsO4J0jsdFKc2IHmarM4S7CkJHXjGAI7S33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQ/zEyn1IQAzYHdPbU10A1/gJHl3s2X6FTOn7rqMYIg=;
 b=IZbb549tuBvCQkTOav7OJgOjNMV7cd5+dG0ONdluN9kbgsaIxdisndIzY8cqBRu5OB/jqngo4NiJcOcVqowdvr8TrTqhfTmHev9E+QSz+sPNSbiI7Ba6YIJU59cKet0DU+wmsnrhmotjXgoCOOsLPxY977YTltY/1mmMei+BhEWHD/3aIyCfrqAWSS4tjgZam3S7gI0KoTdWon10TG2ee36p+kYLZidjusUwYgTLZEa90wRCm9A3szNcpvkbpUlYxE9xCoudkTVUATk4qKWAeLtKQnAsCNU1fhPDQY1vX9d6R/8MGdya6qjqV+BhRFu5gRGWX9+bMJzgPdHmdHrcpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQ/zEyn1IQAzYHdPbU10A1/gJHl3s2X6FTOn7rqMYIg=;
 b=YXWPqjl8xzdRrM0t+xp2AQVhMrq/LXKA2YMHrFZPYuXMB0z8oy323mdnB+p0k00D1obw8GKLVULUAn2JazWbWkeuejf+KmBbIqntjyJmHyfZKcGjNwKTCusBCfU3E8ZiT/+h9/E9INcBFupaw+2YumuyQVtX8eeEdpO/Wfps3cA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 10:35:34 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 10:35:34 +0000
Message-ID: <4f84ef00-6769-437c-8cbf-00fc82f55a1c@amd.com>
Date: Thu, 17 Sep 2026 16:05:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18.y 2/3] drm/amdgpu: rename amdgpu_fill_buffer as
 amdgpu_ttm_clear_buffer
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sasha Levin <sashal@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <2026091636-creole-glorified-e7b6@gregkh>
 <20260916183641.1771014-1-sashal@kernel.org>
 <20260916183641.1771014-2-sashal@kernel.org>
 <9112dc00-73b4-43b8-879c-bb2eaf677b0f@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <9112dc00-73b4-43b8-879c-bb2eaf677b0f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::17) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2d528d-4bef-4e6e-a8d0-08df14a76793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|6133799003|22082099003|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	1DZDGKn9PJIgpUZ+fR+VQHIWM71Cy7C9pdsrRzlmvGRIDxpEl8GDPP38U0wWHg91tYc3eMOl0/3djLuzikHOFM73A2KYleCg9RhhjyiLtxaz8uNdN3Wygs09oUVgqBdm4H8UpKGplWfiKmuM2ru90Jpk/Mz0N3HUtKPrvHFtiXNXXBcH/VyRsagemI6AjSemwMby5NJdse7j2KLi1F+73NgmrbYHvHJU1UDJDRa8nEbH/r5/uAA/xNLZCyiWw4vLf+2ISr2r4SUE/gPeUwmLtH29JO8IpE37F+aDKJeTxo06KpGggHJLkLfKEYt1MlpobU80L3+IxQ4RnSl6Wf4NOBgEAGH66CKDfAW36w20vnvqdzNLvwKl8QgaH5FInD/5fS6imA5dYHBOPkAqGxDxf8Nhf+ftnOtevr+A/Oe4N9qAapOwft4t78UW6RBaFqPJ5Ei37zFQA6YiXbggCNayoCkuPR7C0KU8fsvc4x8WcUVwapFx8eECZENHZSXvqXdopxD8YfP8ppuOXDmVKXTnXGG8u/iZ1WammheB1oqN6IGfi6Sud3KLKt5cwNGclehIjgLVQ0RXUHdeK6xHs6HhqeHaZAH7ltp8kbFcV+bEaE6b869BmHyMuP/LeL/yD+mWbPNxLOmSMHpT7W/MRB46/gHlox60YP525tKdtVyzQbw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5039.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(6133799003)(22082099003)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amErQTh2RkYwejh0ZEplMXNqZ214UGpDWVYvd1J6dzIxQVorOHNmaDlITDZ6?=
 =?utf-8?B?UTEydWk4cHFaUmxxckxsRkJuVWZYcWRBNWJaRjZaTFh4S25yUWlORDRmOEJp?=
 =?utf-8?B?aXgxN1FTWnFFejR3b01lSkQra1B1cVp0Sk1GWUxKdWtubnc4Yzl2SzJPTk0r?=
 =?utf-8?B?QnpaQVQ1cW1FYXpvYzRwcTlzbEsyc2dpTThyNlU2ZXZBTzBLVllpb25PaDg3?=
 =?utf-8?B?eVpJMWJoY0NpMmowQ0pSdk9ZTUpZZE9TSWl2MTN0MG5JVE83MlcwQkZ0UWw0?=
 =?utf-8?B?TzEwSjl5L0RvWUxZZjlNY0U4Q2hHV0t3NGdkUitVRGgvUmZYR0hPQjFLUkx3?=
 =?utf-8?B?Qkl4bHVPQ1c4dG9WMnVRSGVBRWRYSnZvVm5uWTNwOUNMNjFIcFVNdFpKRVUz?=
 =?utf-8?B?aUg5R2Y3a2FHS0hZUXdIa1pRdFdid1B5UmdVTURTdU5ERUtGQkdsZjNpYVdi?=
 =?utf-8?B?NnNzeUNKcmI5TDhOMlMvQStVMFRGZ2NRMXRTVTNrZXdQdU5sVVd3bmZJdEFT?=
 =?utf-8?B?VFZNa3Q2SkV0andBaEJqNmpuSndpNDlJZWliTU5QbFNEVmkyTWl0ay80NnA3?=
 =?utf-8?B?R25XeWFhYWFaU1BzV095SFdZWVQrYVNRUnhEbzZKaFNQOXRMYkVoUElCUUg3?=
 =?utf-8?B?dk1PZ3phZkFDbXZoWUU3MURBL2FNcU83dmIwdU1PY0ZsZDJJTmU4RjY0bThk?=
 =?utf-8?B?azIzVzJabzhwTkRwbFhpaUkySzc4RjJLYnBMVHMzaDhUc1JxWmlxZ0U0OUhV?=
 =?utf-8?B?eUh3ZXFTUVdrVGpEZlMxVTRBSFBseDZhUGZuNVlHOWoxaXMrS3FtVWdZRUl3?=
 =?utf-8?B?bFdDTnROS3pwT2pCSGsvZzNMRnd3Slh0QmxyYkxTeFJ6WWVVMEdneFNObVZQ?=
 =?utf-8?B?SlduUGNaSVd1eW1vMHErMmVmSUlOUFQ3eUtVWXBMS1JubXhzVFBqU0llbTlM?=
 =?utf-8?B?NTNzTmtmUkRidGQzZFVaYTRmSkhxOUpnRXpLMElhaTlmb29DbWZ0K1UvUndX?=
 =?utf-8?B?SGRFd3gxNnA3N3hHVkpHNVRhRTNVOGZ5T2d4QWxqN3dTSmxUY1FHczhYNUlv?=
 =?utf-8?B?Vkxzd1EwRkU4akpCNnF5RFQrR3JwMXpFc1FGbXcydHNvVkQ0MFpFUCtlMVph?=
 =?utf-8?B?YUx2aUZDTkhFOFlyaWVCNGFMcU1VclRIY2xhTW1vN3U4S0wxT0JnTkttYzAz?=
 =?utf-8?B?YVB6ZXMyL1FIYUtiQXplZ2d3dkNUTHgva3R1a0w1bjBQVE9NbnR3aXNvZy8w?=
 =?utf-8?B?TGVvNFh2UzdWRjdtZXl4SkdoYjdQelZsMWM1cHpjQ3BNeGs5SzB6WDBsYlkr?=
 =?utf-8?B?a2NJeUdzbWRrU3Z5RnIxWTd4bVd1c09PNVdJbjIzQkNsUk85VmtnTHAxK29D?=
 =?utf-8?B?QnZ4KzI1WlpzRkNNeDRmOHAwbFZQRWJTSmZqWmkva2ZWNXdNcWFmd0RMOTNH?=
 =?utf-8?B?dERTSkcwK05BMDZmb2RFWjRqT1ZYN2JGSEpPNytZTlBIT2lNNmtrbk1DcjZw?=
 =?utf-8?B?TlF1S2JsQ2IvSDlxazBZN2E3cTdmL2w1OUR4YkZrOTAxbnlyS1dCZzBOTU5P?=
 =?utf-8?B?Q2p4R0JRN2EzR2JmenZxSEcrUFNzcEtxZXJ2OE1VYkhrRURMTDVyaVFuRmEz?=
 =?utf-8?B?VVMzUVlMUG5Bb2xoNEQ2MksrZFJVMFBLR2RGTkJzTnBYRXVPODZTTU1YT3lR?=
 =?utf-8?B?WlJiQ1ByS2U5aXQ5ZzBWZHJwTXp5MFp5bTdtRy9VNkYwaDdDUVBkOVdCUzd5?=
 =?utf-8?B?a1duZGZlYXVHNTJ2amlPUjV1Nm5UWUJMaU91aThBQ0xsYUVQd3dzT3k5Ym8z?=
 =?utf-8?B?R08rVm9VdFpXUmh6dk1LTU83ejMzbklhb3psK0dBeXlUUXE1bDB4cW9ESzNX?=
 =?utf-8?B?ZFlLTGhua1duM0JuQlJiQm1jMWtXTVNXS3pKZzg4MzRQWVkyNkcxWjF1RHcv?=
 =?utf-8?B?SWFlSk1FdnF4TFdtQmtYR2NTNlhzNmRYSGFxS1lWazZRdHNKdWhQUE1qSG8x?=
 =?utf-8?B?a2N4NitTanhPamw4bWFValdVb1NrRGxubU1aZTFqRWpyekIybVF2eWxkQ3hj?=
 =?utf-8?B?bnNLUkdjQU9aSGZuU2VqbXNISm1tUDJJdGk1NlRaVGtFNC9sQWVEVUdjMHda?=
 =?utf-8?B?aUlGL1Y4YmtiNDV2OVg1aDY0VzI2eHpDajcrYTh5ak1zZis0NnZEU1VUOFJQ?=
 =?utf-8?B?NjhpNjNkb3ZwRWZtUUZsZnB4ZHhuOUkvOGhjMks3UXU3enZXQkJNcFQvTEx4?=
 =?utf-8?B?Ym9pS3d3b3VoNEd5VjByZFhkRDVEcHNMenhjbDR3TUJ4bHJ4ZUVmUmxGYzJJ?=
 =?utf-8?B?dDlSZUFlcWV3M1ZxNWZabCtBamVHMjB5ajUxVER3Ty9RS3FZSTRTUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2d528d-4bef-4e6e-a8d0-08df14a76793
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:35:34.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ylL7ENcBBfVq+fLFSiqpIRTHQvn29emRqFCrF0gQdyMqJMt5GIfQY/BNXXH4OfVJQvyytDfhoLmgT8bjuwB9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953



On 9/17/2026 1:47 PM, Christian König wrote:
> On 9/16/26 20:36, Sasha Levin wrote:
>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>
>> [ Upstream commit 5bd8aab55bc18a744577bff79a8c58b031e3c05d ]
>>
>> This is the only use case for this function.
>>
>> ---
>> v2: amdgpu_ttm_clear_buffer instead of amdgpu_clear_buffer
>> ---
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> Stable adaptation for 6.18:
>>
>> The preceding stable dependency already specialized amdgpu_fill_buffer
>> for zeroing and removed its src_data argument. Retain that adaptation
>> and limit this dependency to renaming the existing helper, its declaration,
>> its kernel-doc heading, and all three callers.
>>
>> Keep the existing drm_sched_entity type, high_pr/low_pr selection, shared
>> GART-window locking, reservation dependencies, and no-job return handling.
>> The upstream amdgpu_ttm_buffer_entity infrastructure and next-clear-entity
>> helper are absent from this stable tree and are not needed for the rename.
>> No functions are added. The VMID-flush changes remain in the target commit,
>> whose unchanged patch applies cleanly after this dependency.
> Oh, that patch was never meant to be back ported but I see why it is necessary.
>
>> Stable-dep-of: 87ceb8cba73d ("drm/amdgpu: skip the VMID 0 flush for VRAM")
> @Arun can you guys take a closer look if that is a good idea or not or?
>
> Could be that "drm/amdgpu: skip the VMID 0 flush for VRAM" doesn't even needs to be back ported to kernel 6.18.
>
> Essentially it shouldn't be necessary and is just a workaround for buggy HW which surfaced because of clear tracking.
Hi Christian,

I checked the 6.18 code and the clear-tracking path is present there, 
including the unconditional VMID 0 flush in the clear path.

Since this appears to be a workaround for the underlying HW issue that 
surfaced with clear tracking,
and we are already working on the actual fix, I think we can skip this 
workaround for 6.18 as you suggested.

Regards,
Arun
>
> Regards,
> Christian.
>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 12 ++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 18 +++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    | 12 ++++++------
>>   3 files changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index e29bcb090f06d..4def8b6640891 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -728,9 +728,9 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>>   	    bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>>   		struct dma_fence *fence;
>>   
>> -		r = amdgpu_fill_buffer(&adev->mman.low_pr, bo,
>> -				       bo->tbo.base.resv, &fence, true,
>> -				       AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
>> +		r = amdgpu_ttm_clear_buffer(&adev->mman.low_pr, bo,
>> +					    bo->tbo.base.resv, &fence, true,
>> +					    AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
>>   		if (unlikely(r))
>>   			goto fail_unreserve;
>>   
>> @@ -1328,9 +1328,9 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>>   	if (r)
>>   		goto out;
>>   
>> -	r = amdgpu_fill_buffer(&adev->mman.low_pr, abo,
>> -			       &bo->base._resv, &fence, false,
>> -			       AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>> +	r = amdgpu_ttm_clear_buffer(&adev->mman.low_pr, abo,
>> +				    &bo->base._resv, &fence, false,
>> +				    AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>>   	if (WARN_ON(r))
>>   		goto out;
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index dbaba8aacec27..8a433a0920e74 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -412,8 +412,8 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
>>   	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
>>   		struct dma_fence *wipe_fence = NULL;
>>   
>> -		r = amdgpu_fill_buffer(&adev->mman.high_pr, abo, NULL, &wipe_fence,
>> -				       false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
>> +		r = amdgpu_ttm_clear_buffer(&adev->mman.high_pr, abo, NULL, &wipe_fence,
>> +					    false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
>>   		if (r) {
>>   			goto error;
>>   		} else if (wipe_fence) {
>> @@ -2394,7 +2394,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
>>   }
>>   
>>   /**
>> - * amdgpu_fill_buffer - fill a buffer with 0
>> + * amdgpu_ttm_clear_buffer - fill a buffer with 0
>>    * @entity: scheduler entity to use
>>    * @bo: the bo to fill
>>    * @resv: fences contained in this reservation will be used as dependencies.
>> @@ -2404,12 +2404,12 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
>>    *                         after allocation.
>>    * @k_job_id: trace id
>>    */
>> -int amdgpu_fill_buffer(struct drm_sched_entity *entity,
>> -		       struct amdgpu_bo *bo,
>> -		       struct dma_resv *resv,
>> -		       struct dma_fence **out_fence,
>> -		       bool consider_clear_status,
>> -		       u64 k_job_id)
>> +int amdgpu_ttm_clear_buffer(struct drm_sched_entity *entity,
>> +			    struct amdgpu_bo *bo,
>> +			    struct dma_resv *resv,
>> +			    struct dma_fence **out_fence,
>> +			    bool consider_clear_status,
>> +			    u64 k_job_id)
>>   {
>>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>   	struct dma_fence *fence = NULL;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index fc5133af30485..c5f7efd78409a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -178,12 +178,12 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>>   			       uint64_t size, bool tmz,
>>   			       struct dma_resv *resv,
>>   			       struct dma_fence **f);
>> -int amdgpu_fill_buffer(struct drm_sched_entity *entity,
>> -		       struct amdgpu_bo *bo,
>> -		       struct dma_resv *resv,
>> -		       struct dma_fence **out_fence,
>> -		       bool consider_clear_status,
>> -		       u64 k_job_id);
>> +int amdgpu_ttm_clear_buffer(struct drm_sched_entity *entity,
>> +			    struct amdgpu_bo *bo,
>> +			    struct dma_resv *resv,
>> +			    struct dma_fence **out_fence,
>> +			    bool consider_clear_status,
>> +			    u64 k_job_id);
>>   
>>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);

