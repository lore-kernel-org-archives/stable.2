Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464B4B5CDB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638901; cv=fail; b=OdkA2rIUwIyAGaB2U2khHxLxwQlezrd+9kjr/587jh2L/TeErkOhDBA7deWRkPcFGx8JtggcEQiEhoa5W9b3qlL90OJB++FKiV+ARHQm69NJC6mqWKlp51v/Uy91jG5gNKm9CQuITfA7PofQ7/31Eo3v79HVrEI6S9JTWob6s/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638901; c=relaxed/simple;
	bh=H/0q2Xi4FOJju+LSL1i5os6sLi33VDaxg673Od0WSpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R3wSOAj3CtcrqN0mDFAhDZHDCn4/Zyp1xzZBWk3cDIhq7KXBopNKbJCM/HEKciEaMCqo/tYT5Gts9JlVjgPpQOLQpbpVc3uM1/4Thxhcg+sccpdLng4mNNUYE4sVNbWR0UoBE0+ARW6muyzwIDKfX/vPcskz1l4Y4Rkfzbxchkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jp+AV6gT; arc=fail smtp.client-ip=52.101.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jp+AV6gT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMghXM3qPfW7HEnW0KGy6XGIC9QW/oO2v3HR6F3iaQjBJ/OSaGdYOJEn4a+Qs2Sg7jxGIRGTObPTezfSBZhPRx8JaN7lRWe8LXvwDjrXpirjXdwv3GzF/4wrQlZfQQ0xjx4CUir8bXj6e2jMmxDM4R3pVvkoUHIbOkDq8lAKoB4DGuVO2n3cH0Ad9zwctfeXufpw4fyxa9Z8mlJJ05kWQu7/+uD4WrayAnu89hZzuJMUgsw0SJhmyWrJ65opKPNZyY5YfQxfxh4BS6yl4kwum3lfGF3exN3Hvb6WJycxOtD4kcl1x6sFn9+HFRX1hGA4tbylLziThOK0WVKYT1e5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZIJwswCGE6Hkup8l2PQ5ZQilRKUSE+fuKiMX6hRhmA=;
 b=clxmsR3nTQF+Mbm910kI136l22oYLHihx8UecljC5soUsjYkIKIow8Y+GMrTX7PdGc9t4iWmW0HiJtBUml4hJD75meL9PWFcIF2AFHKrODy0URM9fPFZ8a/Rr8xovlnqsrDp3SwdVOPvBI9HpCXdfZFSkMD+9UWbTVqNC6pQNovRaj0e/su1Yhbpwu+tCWTCp4WsMWLWCorVe/KLU0g9rxbigqPa9ug/fCYWem7wPKYFyHS5Mg+5vJNjcTZTMFbQ3HeDI3AAZO8Z0S60PbrpixjKFEB8d+SfnWNH5XSh5r1ZBHh5IAZv1pRr9haU5vMrw+bJblut0BWjYYcayhRtsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZIJwswCGE6Hkup8l2PQ5ZQilRKUSE+fuKiMX6hRhmA=;
 b=jp+AV6gTkdrScNCulm6uUpt0s4Y1XoMTbNbHG1uBeENk2NghwZKQOhqZ3E5NNXuWYS8/mVCk4ThuZsM7L+IThex+z4/pZzouGPONX7+vtcw8rIa/y3vd0d7fn31Y3t7y83TorlsTTHgh3+UPcX2J0v+eRmmfk5ZFmGHjXyMdGEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Thu, 17 Sep
 2026 09:54:37 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 09:54:37 +0000
Message-ID: <57ebedce-6d86-4a7e-9617-22b19f01dda7@amd.com>
Date: Thu, 17 Sep 2026 15:24:32 +0530
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
X-ClientProxiedBy: PN2P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::9) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: d8545b21-ec9d-4716-c4a6-08df14a1af39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|4143699003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kmNwQ34izMnu3sKdSWOQ5IM2Q7Q9FRK1cc+Gs4EBCL9SIKC/TsK7NQ3s4wD5ZUyHmNf74n5SIb6PXDPd1/dnWuITN7MZI7JrDhkywZ910e2XS/13TUkplyohFy2uZNP8xs7X8gyjbgaNEByLYcABkuGFcZhMd61zRzr7GeWIZEURekVwy3xPGuAjAvZ8tGXrSbgnNOfpNGF0zzRwxiwJSFOwQU/SQPGMtnpFROnZxCS1ZxvDHIenpZkEL4Ve79P6CpavzsdMts1ifsNJJgJZI73qEqNvXP7T1ETm5LuWVOoQJr4Tqsw0PyT4U9EpwrMEdU5sk2YIYeUw6mIxfRgEykCoNO5Odu87ce2m3R2ffTd+beDV3winNn4EjOQoMXs8Ld7qrTLxoWYHGShxAGgWvfF/ZlCi/EbNJWqJieZjBIzDQEE2zC8Ep1Wdm1Sgva0PsmCXRzv1XJP7+unCTMtfYToGTG5fAzkW6XrB0t8Y/l5cViaGLEgdK8+XOaaGFj91kJWDVXvIHR/TTmhpaXvdWfeavboG6kzyoRtYKvw6xLJ8eiFMCVudKU9o0AeoI92T+Lqqgyw4gADSxCRZYr9/jtQYI7umTAybNUXBIn00FzWvbqc+7JC1MqFq5z2GIz8m8s28WL/f6OTCXbMZaqgBTRwdHUxWOhmRfUWs8R0lz5w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5039.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE14Z0h0b1E4Vzh4VjE3dWxUSTRWaklEQkR6K0s1ZHBMUHlUUE5wUXBOOXdE?=
 =?utf-8?B?QzNhOXZuc1ZQa1YxTksvWmtGb1hsWk0xWTVzc1huakVCWlRvWStJKzMyaGUw?=
 =?utf-8?B?czBxbzNuQUlkZDJpS1JvZm5JNVRCQTRZZ1lJUGVyMHNlR0oyN050MWNZT0pG?=
 =?utf-8?B?c0Y5QXM3LzNqTURNU0RiRFZueFRUZy9kUjRsbHZDTG9zTVBtSmlxczdUeGU4?=
 =?utf-8?B?d3RUbVRCcVFKclhKWW0wMW5tVERGZ3pDdm1nT21SeDU4VDVhTVhyNFhMOG01?=
 =?utf-8?B?d1FYWDZRSStLSTIyd0JIanJ0QlhHQXMrSnlqcUxxQVZDWmo4Ny9NRnQ4bUNz?=
 =?utf-8?B?UmhkU2c3aXdPSkU2SXRjcmNQd09VbHhmQ001ZUZDb0pwS0g4NGdnOHBuNCty?=
 =?utf-8?B?NTNBZi8rMU9QeXArcTRKckFJRFo0RXo5eUY0bjZ4MngrMHhBWktDR3RRTkpN?=
 =?utf-8?B?MFJoUXFZRUwxMzNLU0s3cHhTaUNKYmhhUFVuWFdGNlVJZGNjcmdpVitlckRQ?=
 =?utf-8?B?dmNCMHBtdDQzYWtKZ2dsNFhNM2RGc2g0VHlyZFBhdG4vdTJRT1J5Yk1rSnVD?=
 =?utf-8?B?T21rUjl4cTZTOUZzekNPa1pyczRGaUdXSzE2YkFidFI2MHcrUWV4R1NMeDZ3?=
 =?utf-8?B?c09VT3BmWUl4L1VkQVFwanh1cHI4NUh6VmlaaWE0dmI4dHF0bThnR0VQVUll?=
 =?utf-8?B?N0RYSkozcUJPUjYyTkM0OGV0UmlJWitJbmFNM3NDT0ErV1o3VW5CRzh4TXJi?=
 =?utf-8?B?b04vUm9TMVZRWkkra1RkVXpzWlpNQUdxazlQeFEvVnZ1NjQwTC9VUm1vVjBM?=
 =?utf-8?B?ZDRoOFY3L2pSL1JyNkgzMk5Lb3o4OVJ4eHNNa1Erb0hQajJvRnB1TXJoMG5s?=
 =?utf-8?B?ZC81SXZaMDRRUUEwUytRRGFYdVJualFSaHpJL0pCRmREaUFGaFgzd21yREcy?=
 =?utf-8?B?cW1rSzhxZVlQaDZ2QjMzQmNzYmwyMFZYYllNb2h0Y0FLSXQrNUxqUU55YSt2?=
 =?utf-8?B?bGQrY0JQSDJ2clRaTktaR1NXUjAvc0c3YkpaZXV4dzlzQUhHRHZiZGlndG96?=
 =?utf-8?B?OHdyUEpqTmFYUjZNeGZtRTlJRE8xb3hRYm1nbXUzSkt2U0tlUjI2UzdFaXQ5?=
 =?utf-8?B?bm5PVE5GNkQzWDBvUjZBZEgxR1BXVTJhU0NEbmgvcXBwVk5KRGhKSmdaMFM4?=
 =?utf-8?B?RU9wTjZhSUwvQnU1c0llekE2UHlHN0gvWTh3WmZmOUlQQVg5djk1b0pZSGxk?=
 =?utf-8?B?QWdNQjgxRDlJM0pjSkxqbnhwV1RZMm5yUkxNc0lVZmthUDFWbHZIWTRWUzEr?=
 =?utf-8?B?R0E0QkRYQzZqblN1VUhsbFFLM1NZRTZjb1pyVC91S1NzRGpVZHVtTm1PVTRs?=
 =?utf-8?B?OFgwUVdlbW5nYWtKU1EwZ0VrNVlpS1ZjZWVyeW54RHliczYvWGhNK2ZxTklu?=
 =?utf-8?B?bnpoTSszN29ybWp2aFhWSTFubklBRTE3Q3Y2ZXBIY3pJUE5HTkVoVmxrTnVn?=
 =?utf-8?B?ckM5eDlOd2ZQbzAwK0MyQXVwZ2hyMG93YzJMM0J3WHMrc2VYNFlpcXk5bjRT?=
 =?utf-8?B?bXd3N0xTK0Uwekx1RU9QbHpTOE1UaitoamxNTURiZU1NelBmbFUyVXJiRnJO?=
 =?utf-8?B?TWFHbzNMUU13UWdscmVMNDR5eVNCSnZ5RFFrV0ZXYU9YcENrQnVkQ1pGajFz?=
 =?utf-8?B?Q1BycGx3NmZrbGhpbW1FRktpdXB4UzVMdkxiT1VISzRqVGdwSlg2QTdSbjNx?=
 =?utf-8?B?UEM1TkNyTlkzZkhiOXlyK0d0VThmekJma2VtdXl1UkhVNXhRYWhBNkdNQ2xD?=
 =?utf-8?B?a2xmYkFUczRXeUMydW12S3dNN2NWcXFYRGR1SnhoS0Z1VFhudXBBVTlBTEV5?=
 =?utf-8?B?dm41RldJdndoUjZ6d1kzcVRHZXVOY3QxbEFRRG4wZWZOOGJFQ0ZlSXVmLzJ3?=
 =?utf-8?B?S05xb3FIc3pRbnQzTVpTTnlrTTkveWlSYmkzOTdLVytSL0pRYjNuRXBTdWtq?=
 =?utf-8?B?YXBWQ2p0Y29weUhFREhoL3hkRys5Z1kydVhYWTc5ZEE5dlJIOXN4dU4yb3U4?=
 =?utf-8?B?K3NxNVBZeXQzRkRscE5YaUEzYUplbitGZTZoSWZRYTk0bVZmY0YySGRsdzBO?=
 =?utf-8?B?bmxXRGR3dC9ueWRFOEJFWWZPOER1bnlCU2E4VUdUeVcrM1hRb3ZrSnZNbEhn?=
 =?utf-8?B?NTRuZDMzNm0yMmIxT3J6SUVXMTRkeThUMUo3cWlXTWpBZTZJOTJETEdkWXE2?=
 =?utf-8?B?d1ZyVVQzWFNQVHFadnd6N20xbDB1NlcxWE94Z25EMFRMQ0FDMDBDa3VhbWxY?=
 =?utf-8?B?TG1Sa0dVS2xTQUcyZE53Q3lPSWhrdkEyUkp2MjRMWGd6NVFaMTg1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8545b21-ec9d-4716-c4a6-08df14a1af39
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:54:37.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUQMOZOVnJeCLMKAAbRlkm5CGVwydwU2AZNmYevRKNsvINbRXZaKn+QWo8K/JI6VXiK6RE4X9BcV9JtICrQBsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642



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
>
> Regards,
> Christian.
Hi Christian,

I will verify whether the VMID 0 flush issue is reproducible on 6.18 and 
whether the workaround is actually needed in that stable branch.

Regards,
Arun
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

