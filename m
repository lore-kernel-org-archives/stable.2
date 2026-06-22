Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F93309F1D;
	Mon, 22 Jun 2026 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139740; cv=fail; b=VbnPieYLNuBYgLby51bMfrLSWw1p0qB353AHoPzrxr3/eY4kT4RQuu/HCo2m/XwjrepqRLJ9lDajlCzZuwvvWzFEBWfk/NU1bNNFnr6BQPzbkb1kuIeMSFFPVwo11znQtt3rNV+HCdkWVGEB9fmZ+rZqACtNME17+wWUEApfwYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139740; c=relaxed/simple;
	bh=Y5XMNYWDn+BhNSlMWmssIX2n/BlybVBNTI+zMHyYkPc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u5IvWZCkPjT5WXJ7mtKM4XH+whw5quVcDNDisWcAIRpdKIsuOJLEpkBoY/bmF3tGlGoJw+t7bhNRgLa/YGpkDZ35JVHOnMtd3ggka0TllgmDe4IimLtoFWNdx8gSLKesCZmYJj58ekNvlv0OJWA4y7s3FRFFwZF/RP4Z9is99eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hdKyLMsF; arc=fail smtp.client-ip=40.107.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hdKyLMsF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJpxA+kYOlvq5Kvj2x4MK8dqtCy2nF/DVQOsvLKuhwp1ovSRBCELDkFHU/M3pAHE4Zgg+pjsQ8CE3uVFb0/z1U4m9c3FpL6CVLFARe7kVzTg7BEGLAuLoqqO/8TjS4kBYpOEvQ2H2/ARDKjRTJ8e0/8qDunSVIMD+BdStdyq7n1Lc554WivOtCUjQV9KlVEtpeZn8QePPJd0vI/pH0rTPQqXhadPbKsp8j+9gIEHJRt5VMj+ks+i2Eflp6w+J2Kr8nWrUvIWUztR2awzqwyZFTi8tEZ/D335mwFgjTQET02ykoLPZ+K0fQCIm6RkuhiLRv2l+usfWeA9MlUkMMAlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyyH93QaHxAOUoxGbqMKJm0xkoJL5t5WmSRguCowqN8=;
 b=ej24xFmDF+0anjsygUvsB+nQntkmDTjoPVaCKaAUOCWgJUq03RMpekMazZaVBDiPnZAb12C5jIK3x3aE1Tbc+Bh9qGJ4hiMRKmYF3n4j/sNB0v1xbZZgRKeYuPfesOcg75JfPIk0PMfJAzx6MowJ/OICmAO9iMGTcsFStM9j5pOVQLNNphZqiJSB5hVNZZkkETt0suvrswuocZ7warLfisZxsv4/btWmx5QEloxRWGx6L9o/Q2jOmUZEx0kI3Pw8H2+HCi1W+RdabzmmL6Td9RiIECh9otvsIHcE04pVOfhlJtkVSq860naE1mr0cVLwK/O4pt+VC9fEthM2jyF40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyyH93QaHxAOUoxGbqMKJm0xkoJL5t5WmSRguCowqN8=;
 b=hdKyLMsF4gOkAXkXWRWxuNwoabeOwErVyufrwGAcYOCR4wetHHb63DDZqNLGBvtlg4JTmrk+EFWvzaCgCcjI547BxsbDeZ3KhMQHAI32FJYpAHQ/yduYZc1KJ1WMrkuqabI7X+PdJeYWCg7nvJtsqisdYdT/JwR7hVA2dSkO72s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 14:48:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 14:48:52 +0000
Message-ID: <626ecd79-e1bb-4c83-94f6-dd9880e7ff26@amd.com>
Date: Mon, 22 Jun 2026 16:48:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix cleaner shader IB size and entity
 cleanup
To: Wentao Liang <vulab@iscas.ac.cn>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260622142305.45791-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260622142305.45791-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: e202aa43-9517-4004-a1e1-08ded06d6054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	jk9j/7KNtPQuKDPRUj+CUvLtu7xohx+fVXZ4xmy15RMyj/eR92VstbK0gbTQu6ZxmbBZRV73E4oDHbD7Rklw57uV0bdMAbw9qcCwJD7HgP4tOj9hJKWba8ENipe8LbPBWMS2LtI8PpNeeCNfYe6m1QAAddQx2riWZt/EcNwU+kpLGNFCxlKDeq1nq4s5XHx0Amgarf/+iQiZaGKBAT8lEpiUKWwqVy9tRS4jui+JfkwQvdOwaXUaw2elATAwpgVKcvhDeK39eOPu1xy5PwmWs0HZUNt12zbS2afDDqmFacZEcb99mL0GHETR2BVXSDh2Of/aMCdJcebFQHgUpFXwr0Np7ulIBhSLeshYytvshFTHM+XOE0mCGkQj8VAOPtP4tkhhxndTR6D/QF6t02C+vCmHftsu/PTF/WnAY+YfaXNHuiBmgCqjcinXmMXbt6jD0M9aIreXQ0ugznLanbtqY0JYChb7XL4lUL9yE2/u6N1DFFfKoofVJnQ7I8p7dqFTdJtQY/9woyjAkUPTuM7H/T/IV7n5iDQCfR2l/A9D2ApVvdvlk7Xy3JAMpKQ3sBcKAwsMSjz43JOdNd69SSrBTFmSScJg5i52eGuHJ2GMpqle4MWNWH3/gOS4/2BIspqYm5ly3MZqACwFpiSV93oeSfJn8t0/4/F1JjUrC1hY8cg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1RBUU9NVnpyelNjSjh5NG9OYzAvK25nSHMyUmErNjRRbEdISXRwYm5NNHR2?=
 =?utf-8?B?dElkWXVONDdpRXNkd2dLRTRzTUNPVVFad1lKQXRSalZCKzMrYU85UmFlTFVp?=
 =?utf-8?B?aTdZbE5qZS9aZjJLMHlTaE1IeFFaY25NblRKVVYxSDRVMWFUd0VJaWhYRlNL?=
 =?utf-8?B?WDIxVnRRT204OERUQTZyVllFMFRnQS9LN2N2K0JhT2FaMy9JNFlIVnZqU2Ns?=
 =?utf-8?B?TUxaYTVBMTZXd3FTdm5ad3JLZlE3Q1o2RUYyaWFoVC93VlkrWGJMbDQ4cHUv?=
 =?utf-8?B?NzFmTEdGSTMzUTVVTkJjMS9pb2pxaUJlOCtZb0IwUk91NEovTUR1S0g3OWNK?=
 =?utf-8?B?aXJoWHNZd3BnN21qT0Y5T2p6OElmc2lyYmtsc2N3dklUL1BXVExReG1US3hU?=
 =?utf-8?B?bWxYcFFYTDA5eEVLSTZmYUJkOElMRlpZOW5uUkpvUWNMdkwrRzJmQ3V6a3dD?=
 =?utf-8?B?MDgwd2MyTHRrRjVQbUYxaUFWWUx2Rzc4dk5mQXFLTWhKalU2ZmJNYmg0S3Ny?=
 =?utf-8?B?dnRqUzRXbDhZdlJtelZRK1RTcG5lVmUxNWlXemZ4aTQ0b0lQbzJWaWxESFNN?=
 =?utf-8?B?YVFhTXViTk1kekFsUWhBSnVZaXBzenZXNHVWUFBYaGNGK3hQTmRHaU9ZS0Zh?=
 =?utf-8?B?RGtKTHBGU1hQRlNCVmhlbGpmTWpyeGR6U3Y0dFBUMzhLaHVrQWtRNnlCMzFm?=
 =?utf-8?B?eTc2Tjl3clMxNHJyTHpaQ2NMOHQxdzk2bEpVY0hrSm5yK1EwSnlnS2lUaTd1?=
 =?utf-8?B?S216SkUxbWlYZExDbTVoeENyQXpJYm00SDlyRzdDQkMwNFNwNXA3TUd0azUy?=
 =?utf-8?B?bnJxMzZFL2x1R3B2ZXZzU3laT3h6Q2VmdHoreGRGdzlsL21Fc1hNZU5oS2dk?=
 =?utf-8?B?ZFlaWFBBS3JRNVlwbE1ua3VMNkRhSHhZenQ0OEJvNC84WGZyczRGM3lSQksy?=
 =?utf-8?B?d2o0VVVkOEVmK1h1aytGU3g2UVlnM1hWemxxcjd1WDhiMUNCaElId0NWY2lX?=
 =?utf-8?B?TTNtd0wvMER1eFB4cGUzb3l1ZEVVWXVRc2k5WkVkNEJ3R3FnaHk3ZHJ4MW95?=
 =?utf-8?B?YUxwUUJGSkdabjRacFI0azd6Y0VyRUVVNTVINDN2SWlHS2g2a0tYa3Nicm9o?=
 =?utf-8?B?azAwdVFLakdHbkhOR2I1N1luRFg5M05xcldxbEQ3UFB5Tk1XWXcyc3N1MFVm?=
 =?utf-8?B?aG5OckwxUUdTVVgzdkl2dy83UjBBZ29IOGhhMTdjOXdoZmw2NHhodnlWMzh4?=
 =?utf-8?B?SDE1RVl0L0N4N2NmRm5NZW1wb29IZndxcVZiVHdjdDdTM1QwVStDQzMwcHBT?=
 =?utf-8?B?eTd6cGdUdjVJd1ZIa1pCM2R1Ri9aOEpQblZoMVdCbmI0SlphZjhMWE1iNG03?=
 =?utf-8?B?OUhyQ05KaDgvVHQ5SC9TRU1hVFdPMWdUcHA3Qk1RVmR4ZUlmTHVwNHZHT1Nv?=
 =?utf-8?B?NkwvcCs4K2lscUVHdnNVRnB3dEFKSVJvL25KVU5WMnBJWi9kZ2VLbGxUTjBK?=
 =?utf-8?B?RkJTUVMwcE1oVk8zRFFSNkNLUlR6UlMyYldkQ25qR3FTNTdOU3FDSVVaREZL?=
 =?utf-8?B?UDlvL0hJVjFKZVpwMGNIbHV2Y3hweEZiNVRZVWZNdHJqbFVCUHJhZHJFREZy?=
 =?utf-8?B?ZWlQRzdLa0hnamNQdFE0OEdlWWdjTysyOHdRbXZvek83VHExaDhRaWlNMXFE?=
 =?utf-8?B?L1dwN2d2akJ3K3o0Sndwb1ZxVG1iS2wwSTVEd3BteGNjOU1sQ0FMcEdpVHJ2?=
 =?utf-8?B?Y2hJbUFHVUR4NWQvK0lCUmVrMjA0c2FWcWJOU2paUzlNdWNMK3Ixa204Q0hD?=
 =?utf-8?B?QUpHUjZDNy81OWg1R3pFbGIzc3lDTzVwTVBjRC9yWHRtZ01iLzFCZjF2QXln?=
 =?utf-8?B?dzE4Z1IwZUFnZVc0RHNjZkhrNGRxaE1vc20vQzJ1U05jQStsb0psQWJiNzFI?=
 =?utf-8?B?Vmd0aERtRjh3V0lhQXMxUklsL1hEQmoxaUF1QkxKbjNrNTZDQkJBbjlzSWhJ?=
 =?utf-8?B?RTFZYjBzb0MrVWx1SHpiRnVkQlhQdXdINitqWmJlMkR4Zk54UDJPa29zR1RI?=
 =?utf-8?B?djNoSmt4bElrdklKTng4ZFEzRjVtOUpWbnJwVE9MdGJzSzMwaUpmcW91OVdU?=
 =?utf-8?B?TzJRcFhkdnBxSERxdHdNaEljcGdVNlhWbTJ2ZGRCSHpKOGt0bWxheE1rbEVM?=
 =?utf-8?B?NFg5U3laVzNrNnRSYmdSN3VYSGpYYmwvYnQ1Y3Z5cElvdHAwV0ExSWlJOFJz?=
 =?utf-8?B?L3dQanl1c1JReG5xQnQwNTNEMHphdnBJWVFFelZOVERCbVlNY2xWbW5KMm1i?=
 =?utf-8?Q?CcPq6dkJ04LvPebzZJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e202aa43-9517-4004-a1e1-08ded06d6054
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 14:48:52.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMgjuVj6eMF6/fUulvje+SDpcjGG8JBR06GC2tFJ0WbclguZtNE0L3HNjCDjdeBr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595



On 6/22/26 16:23, Wentao Liang wrote:
> Fix two issues in amdgpu_gfx_run_cleaner_shader_job():
> 
> 1. IB buffer overflow: The indirect buffer is hardcoded to 64 bytes,
>    but the initialization loop writes up to (align_mask + 1) dwords.
>    On modern GFX rings with align_mask = 0xff, this writes 1024 bytes,
>    overflowing the 64-byte allocation and corrupting memory.
> 
> 2. Scheduler entity leak: The drm_sched_entity is not cleaned up on
>    the error path after amdgpu_job_alloc_with_ib() fails.
> 
> Fix by:
> - Dynamically calculating IB size based on ring->funcs->align_mask
> - Adding drm_sched_entity_destroy() to the error path
> 
> Cc: stable@vger.kernel.org
> Fixes: d361ad5d2fc0 ("drm/amdgpu: Add sysfs interface for running cleaner shader")
> Fixes: 256576ed6895 ("drm/amdgpu: give each kernel job a unique id")
> Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with 'drm_sched_entity' in cleaner shader")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b8ca876694ff..b50ec1a5c645 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1651,6 +1651,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  	struct amdgpu_job *job;
>  	struct amdgpu_ib *ib;
>  	void *owner;
> +	unsigned int ib_size;
>  	int i, r;
>  
>  	/* Initialize the scheduler entity */
> @@ -1658,7 +1659,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  				  &sched, 1, NULL);
>  	if (r) {
>  		dev_err(adev->dev, "Failed setting up GFX kernel entity.\n");
> -		goto err;
> +		return r;
>  	}
>  
>  	/*
> @@ -1668,8 +1669,15 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  	 */
>  	owner = (void *)(unsigned long)atomic_inc_return(&counter);
>  
> +	/*
> +	 * Allocate IB with enough space for align_mask + 1 dwords.
> +	 * The initialization loop below writes exactly this many dwords.
> +	 * Each dword is 4 bytes.
> +	 */
> +	ib_size = (ring->funcs->align_mask + 1) * sizeof(uint32_t);
> +

Please completely drop that.

The ring->funcs->align_mask is the ring alignment mask and has no technical relevance for the IB.

>  	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
> -				     64, 0, &job,
> +				     ib_size, 0, &job,
>  				     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
>  	if (r)
>  		goto err;
> @@ -1686,8 +1694,6 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  	f = amdgpu_job_submit(job);
>  
>  	r = dma_fence_wait(f, false);

Please drop assigning r as well.

Regards,
Christian.

> -	if (r)
> -		goto err;
>  
>  	dma_fence_put(f);
>  
> @@ -1696,6 +1702,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  	return 0;
>  
>  err:
> +	/* Clean up the scheduler entity */
> +	drm_sched_entity_destroy(&entity);
>  	return r;
>  }
>  

