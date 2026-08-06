Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DBD43802B;
	Thu,  6 Aug 2026 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017602; cv=fail; b=ajerN3WjKtUecZdW9coykyqcyvXWVM+jOT23Qzt61n8B2MIN5MvZhqZuvUZ5TzD67LpFYMej0m4XNnlWh79VBR45/orWSIqTBh9TRazByZGihQV5uEARyb0KAG7I1lujuTT1QPSfi4RyAo4+yTnKsAfbiF+JsEy4nVSDU8MCvQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017602; c=relaxed/simple;
	bh=9n5Iq5AlFE9MB9G8U0N06AIKZ7gKKVgUsHq4RfbviRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tNXx5GYgGYlvVpdBQhlEGvpSjZ1vTUXUkvVSHasMR/5qd3ULVDzcp8LY1mkX/Cxvfe1cAwWvwzaJikz4yOGi+O2jFGgg/6HWEUz3Z4/CT+yLfX5qrVl6KmTcmDX61pG6CszFzJgqFSoe+hKebzSp3uue5wG41Yx5WjFS9MJhZQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I7N6EZ0g; arc=fail smtp.client-ip=52.101.46.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I7N6EZ0g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUvRChGLznzjC7Ur/IdD91P+yvD/FoG1ES8WGGfeTaozYZ6Jv4mF4PiJROzd31v1PD91Bqzn8krgYtfKVhPFJBU6IJBrloA1FaVwBW5kvboEb7qQip4qkn/FWuoaF3LaDprt10+gdWiI2naJWHsOeVxYZIP7YGS+LWuQA3aDEofa39Y5i7LwadZPjoYh9WEieeJfj6hiW24qUDbpsarNWwpvSA01AyaHmxZ0dt/usPHlTZL9afI0a3gAsOiNpARkl0dXe8Llr6YDY5ljH5/wXe4IjVOOkdKIEEcZEklyT+B5QkZaqny9kyp2Cxmznadhc0l05sgGjJpV3oOcqthwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu8ePXPjV78UxtXuzLmp2emTxxMTkCKjfLD8xlc7YZA=;
 b=vuh1Vfp3dsz8ZB0RvG5bgsYg8bTeQz+4kZH0mD9cHUNvFYEjoErm+IZlMSok3PNtxtpXezTzrf0j8wsLd0i+beeyvWohx/tmuWoZKec6zBe92kws/jDRZ6DLe0bSSK+od2KEEcyF5YzE7Afnbnj6U4otXh31BgHEbEoexQUmj0yS0lCQwbw2+igVKdrhO2SEW4aMAkceAoHgiWYk8D5dd6F+q6lJNxSeQ6a+X90OS/XgRbbe+ZTSPbAxRA/JaPTkr/9NUXmgFDB26wsSa37YULL93e89wDj0ZbIX2pDWSipZIvIxcqHTgMG7lQzLreTeJ7UfopkyRRemvpNquf2aSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu8ePXPjV78UxtXuzLmp2emTxxMTkCKjfLD8xlc7YZA=;
 b=I7N6EZ0gIajQrtFKlBaBOE51+WjskDRiLRwIpKq0VH0zDMYqoz5wRLWlFsDUxE45hhBeOAa3eVIqdiswI8uBZk1hayIORUNANkjaCqtliqCxe17yMPO2GIDAQljM6bOICAHfBcN5ZDcIIvaIQedP+EbKhYAncvHbShht8wMiTNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6752.namprd12.prod.outlook.com (2603:10b6:806:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 11:59:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.021; Thu, 6 Aug 2026
 11:59:58 +0000
Message-ID: <88f614f4-5001-4cf1-ad2a-00802508a4f6@amd.com>
Date: Thu, 6 Aug 2026 13:59:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: fix VM update overrun on non-4K page
 kernels
To: moonafterrain@outlook.com, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jammy Zhou <Jammy.Zhou@amd.com>, Madhav Chauhan <madhav.chauhan@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
References: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
 <20260806-amdgpu-fixes-v1-2-ce247012d4da@outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260806-amdgpu-fixes-v1-2-ce247012d4da@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0371.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f49b6e9-bba0-4dfa-bff6-08def3b23cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|5023799004|11063799006|56012099006|10067099003|6133799003|3023799007|22082099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ppxt3Tf3duHr/TDcHDVMD3RCDy4iihmUkAKI49z2rvqdUB5Fh92d/R6/qsfxi9gt6cY3B5Ec5lvdkpV30Bdgh225Ibsf0bIAm7OlaxLAJ/pLW/iSB6fPOiAMiAbjVYo80eqfWDG+/MbOtbqhxPoHVOSqaHc9J2udteDQ0O5Q+Y6n4f+j6nPMPWy5ofNR+MHtkJ0j2wi4Kvcb3z2hPH+zUOCLvOLYNoA2YrGLVtb8IoIWaymbxD/C8MDLV8977S1subjcJXVH7JG8YXIxzffIEv/N1CunJsuaJAdlkqWfgLXxM0jD++0IosktcfN3P1byO1I9/Z1yC32iTAzjYnEWTRR9icDp0wGOxvyfAKYGnQ1VeY1nwYKnHJ6VMogTQale7cQ+8tSuVspVLVqR/LCVnM4FXW+anDGnDZuyioVzrjCA6p7F9nc0F5jHWVubzjGx5DEqrfnyejFwyomU7HTwU/flw23ldXUYvR3MlAXzSNyQqWvibF60yhRjKgApYPJ2PMNyuCjgLrYCw3v2dG7YIO1EhdO/W9VIqX/xh3XsfviotXfFZSc4vq7W6f4FPXZGlM0uiel/d44m6JpCc1Os9NP2y4d8LdYgzKx8ARuVhUG8nF9cId78ZE4jjw3EvpBT41O3y2DA13WjeTAK2CzXOmEKoWf+zKAIpFWTXVkjsr4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WU9veFBDd0xVUlNaQzBjVUl0VitoMXk4K3RLRVdMK1VRTmhJRmFWUFhYUWJ3?=
 =?utf-8?B?T3VDbTBSWkljNW9BRnl5Nmx6bFVDNTMvNnd0V0NyTTVXRUdaZkIyaEhWZEVj?=
 =?utf-8?B?ZCtnZ2IvZVNEaDlYWEpUTms1RCtXNzRiTVdYaEZIMi9sTFlid2czKys1OUZ5?=
 =?utf-8?B?Qzd3a2RFOUFmcDlvN3NhL1NCMGlBUUlGWDZpOXU1eGoxS2hHTnhZemlOa2VG?=
 =?utf-8?B?V0xQa2k3SmFpMHJjNjVZa3I4OG5tM0d3MW4vNWNLRFJqVlVTait2c0JleHdw?=
 =?utf-8?B?OVFYWUZVRUV4cnZXQytOWDZFN1dmMzFITEhIV3gxb1AyYmRGdXZ0K1I2YmxR?=
 =?utf-8?B?WHhtM0d3amV0dkhFTXYvRFNNeklvdXQwZExYbTZxc3dXc1g1ZHVYWG91RnQ3?=
 =?utf-8?B?WktOTEhFTlc3TzBiNDZiTDJ6WGhVYkwxT1dCQnlLQ29SQlNTaTFBcTR4enRU?=
 =?utf-8?B?b3NUd2NQTTArTHJJVVJNU0d1R1NnbDF5bFV2SE1DMG5zQ0ZOd3BHbVZNOThK?=
 =?utf-8?B?NmtMMW16Wk1yT1owRFpHdmZwNmZGVWZCUG1pV29ZTWFhY1RpMHIvVzJGbjRL?=
 =?utf-8?B?NGpSSjByVURrR0E0alNnOTVKcFIrQk1Bczd2akRET1pvSmZNN3JDbitSZmdh?=
 =?utf-8?B?MGhnVHJ1Uk41RHJMWGswMnphTTJaWU1nSUpIRDBiVlZxZFJyOWJKQ1JCcGh2?=
 =?utf-8?B?OGtkTnM5K2xtSkpxdTFOVnVmQWVBY2tMVVJ2bE1BTWFtSVA0SnAzeE8zMm10?=
 =?utf-8?B?S3BGMGRFZkN0WkN6MDZKUUYxdEh4Y2s0eEl2Zjk3MFdrSUJnRTZkalVxWUE3?=
 =?utf-8?B?ZEc1YmNaaTFxOUZjM0N4K2dacHA2cnhwUkEyZjRMczVsZmdlTm1xN2tiU2dY?=
 =?utf-8?B?RXdsOFdJYS9hSWpJZGMvdWp5Nkk0VC90eEV4Q0xJYlpCZWE0RWd0VWxNaXN0?=
 =?utf-8?B?d01GTGZ5eFc3Y2dnUGVZb21JTWxEWTRjaWNERXFMalQzYnY2YnY5c1NzYU0z?=
 =?utf-8?B?QUNiMWl6VGZhZFVrWGRmbERqWmdPY0VmU3Y1aEVLQzNTTzNBbjV3ZU5ZOE5v?=
 =?utf-8?B?QjF3amg2Yk5SN3YzSXMyNXhrSm84dWs4RElJb0kweERMak85QkRKM2tKcDJK?=
 =?utf-8?B?QjFOQS9vMW1iR0dqYndxOER6SE5OMDJQSEptSXZwMnNTM2Zod2FEUXRhNmM0?=
 =?utf-8?B?bFpQWjhTRThPN1R0MnlSVHZmSUJmL3JOMWp5WkV3VjR2NlVSVWtDMnRDZXhW?=
 =?utf-8?B?SFgvbVlKajk4L2k0OWk5SVRsTzRWR29DSkpNWjNHZXJqY05XNCtvUHdtdUFZ?=
 =?utf-8?B?M3Fob08rZDVydzRSNnZVNDMrWU41NGh1MzFSaFkxQ2E5R2EybkcwWlRKMURr?=
 =?utf-8?B?ZkdxUGtVQ0MrZytyWk9sRVFlNnlLLzZ5cTVKR0Fnb3ZKTzZERk40d2pTU1p2?=
 =?utf-8?B?RzBUTFIwbDNGYjVXMjBZenB2L2lDemdsbUd4V1VDamRIeGNSS0VQeE5RMEhx?=
 =?utf-8?B?Z0tvWlVaODhET3N2OG5oNG5JZmVuRmVBSHZ0WG5udng3SUFrV1J3NTd4M1lu?=
 =?utf-8?B?ZGs5b3dRUk9uVW9IVHd3VjF5QWZmZXFaM2VBbXc2OTFlSHF1OFJhV0h5ajk1?=
 =?utf-8?B?VHlmYktzRnRjNEl2dndvWFBuTEFDWkFQNEl6NUZOWG5WblR6YVVkYjhKeURa?=
 =?utf-8?B?bmlwV3QzODNwelpRRzhRMForU3kvaW9rcFdwak9HWVJJRUZPbjRLZTNHdG9x?=
 =?utf-8?B?T3RzYVNHc1p2RzUyOWN5NjMybVE3RC9ZMklHbnhmWFdiR1FNK1Jnc05iNUNj?=
 =?utf-8?B?eXhjMVJCeEhsd1VkR2NXNmVWRzV5RHdhNll5RTRrU0xhZ1ZDMWJuR0M4bDFO?=
 =?utf-8?B?MEZRc21ndDZvclZlYmJKZm83YktnL1d2eEM1bTNqaVBXbHo5VjZ2MUhzTGoz?=
 =?utf-8?B?S0RmeCtNOFBIVFlpcnlkMEdsaTRNNzJ5YUVPUk9yV3lVK0JWUWpGeWl6WVZX?=
 =?utf-8?B?Zm1wd1VyQ2kvb3ZPZG1mNzFrNFdTbmU4eURHazh0S1BaMVptbDZBZmY3Qy9W?=
 =?utf-8?B?U3htWWJPVGw3OWNOeFJxNjZNWGE4eUt1M011VEFKdEV2bzZQNThQN1oxUUIr?=
 =?utf-8?B?WUNnM2YwZTJoOXFFRXhhZktxT3o5R2YrUlZPdUhGUmN2VFA2d1RjWEJ1N2Jh?=
 =?utf-8?B?WHhSdFdXendBcFVJci83WldGai9yS0pBQnM3bDJVdVFLODRlY1ZORnlXa3FN?=
 =?utf-8?B?bUF4TS9WK0R4bmVZK2VnS2t5MzYxQnhyRUFKT1lKcG5jZDljV2diVEs5Tlpm?=
 =?utf-8?Q?3Rm5YO7olncT8ksFTE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f49b6e9-bba0-4dfa-bff6-08def3b23cb3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 11:59:58.3143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Tlaw+9vVYTxANcgmfcBmeCVwBX7eFaFcQhZgfLDhat1c/jCjqB5uX0MFjS8Kjqi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752



On 8/6/26 06:45, Junrui Luo via B4 Relay wrote:
> [Some people who received this message don't often get email from devnull+moonafterrain.outlook.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> The contiguity scan in amdgpu_vm_update_range() rounds num_entries up to
> count * AMDGPU_GPU_PAGES_IN_CPU_PAGE, but count is only constrained by
> the loop bound when the loop body executes. The guard
> num_entries > AMDGPU_GPU_PAGES_IN_CPU_PAGE proves that
> tmp = num_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE is at least 1, while
> the initial count of 2 needs tmp >= 2.
> 
> Each iteration consumes a multiple of AMDGPU_GPU_PAGES_IN_CPU_PAGE, so a
> mapping whose GPU page count is not a multiple of it eventually reaches
> an iteration where num_entries is above AMDGPU_GPU_PAGES_IN_CPU_PAGE but
> below twice that. tmp is then 1, the loop body never runs, count keeps
> its initial value, and num_entries is rounded up past what the cursor
> holds, tripping BUG_ON(size > cur->remaining) in amdgpu_res_next().
> AMDGPU_GEM_VA is DRM_RENDER_ALLOW and amdgpu_vm_verify_parameters() only
> requires map_size to be a multiple of AMDGPU_GPU_PAGE_SIZE, so an
> unprivileged caller can reach this. On 4K page hosts
> AMDGPU_GPU_PAGES_IN_CPU_PAGE is 1, tmp >= 2 always holds, and the bug is
> unreachable.
> 
> Clamp the rounded-up value against num_entries, mirroring the min() that
> amdgpu_res_first() already applies to cur->size. A contiguous short tail
> is then mapped in full, and a non-contiguous one falls back to a single
> CPU page so the loop still makes forward progress.
> 
> Fixes: a39f2a8d7066 ("drm/amdgpu: nuke amdgpu_vm_bo_split_mapping v2")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
> Found by code inspection; not tested on hardware. I have no access to a
> 64K-page host with an AMD GPU, so the BUG_ON() path was not exercised at
> runtime.

That check is clearly not correct. The pages_addr must be fully consumed, otherwise we run into major problems later on.

We could do something like this instead:

if (pages_addr) {
...
	if (WARN_ON(num_entries % AMDGPU_GPU_PAGES_IN_CPU_PAGE))
		return -EINVAL;
...

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index dc6a9d7dd0b2..365a1c4a4527 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1193,8 +1193,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>                                 }
>                                 if (!contiguous)
>                                         count--;
> -                               num_entries = count *
> -                                       AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +                               num_entries = min(count *
> +                                                 AMDGPU_GPU_PAGES_IN_CPU_PAGE,
> +                                                 num_entries);
>                         }
> 
>                         if (!contiguous) {
> 
> --
> 2.51.2
> 
> 

