Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D79390C85;
	Mon, 22 Jun 2026 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143585; cv=fail; b=fleRY8D/FOF8QvfU9G08SJHp2FYOdw3y2HdUv97PdAm3+XRgVIj/z5Y2orEB1talSFzlQQNvnXuPZckmMG/Kui4kv0k3NZIA0WBd0oNqxgg1d7Cagnoe9ySaPJaFVRp/RknUpurkgkpetyxkQMaSYCBTbJq4McL4Y3fgdtrZy2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143585; c=relaxed/simple;
	bh=qQYrqgFd4xyOEkZHOuTIjokT49sMzM2M+oY5d/l2wvo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ftg6fEmcwjP349cntUWXdF6M7KK1LtPY2MomViZOp+DvYf5OB1ijiA4m20oXoWDP1Xq7rRviT6dBzJUrdqx4qnazAQFGInDYSD/ubBHCT1xTrAveLVLYlBsw56WnTG13men6fXQu7KXzdVYaORzohAE+rkf8JffP5fieVjnGkvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QQZClPxl; arc=fail smtp.client-ip=40.93.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QQZClPxl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ju2OW66Mj5JfxuzCvAatamIAgCAs2Xka61OFfkegQyfCmiZjZ9M8JRDdScnxxvKVIxCBvgxOnmGwQWKE4W0c38ViMSZjbuHw71hm73qFwDk/p5ZQzgkUsNPc2DftrI2ppg46IcI+RGE89ZgzGSbES4m7cxyoaU3t3RS1bMSeHnXmEDdVe88GVFDJadHipvpkrKMreL3ANtPodpWHd5VsOVXwwX4PcUSsGIghiWo1hRPaCE7PvwoeJ+7Ni6jmwuZUo1kGzDMyxw9R1tLoLw0zZOMwhUBzs21dmGlRCf/Uy6ATZwhxqwZHrHVLc+2pgl/jJWOgsVfNC82Bs0bbf7pkSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYyd6LNBvMVam5JGVgGX8SjDlsz5LB4Fjfu1tdogpv4=;
 b=HVfA32/zXcOfGVDCNOxZxAW5K/V4ZshfWkeC9D2nevHuIEAfoa/6sfNnwFtrVVrhf5rbb2Igzsw9L1kNP+JFh3xvpdccy30iPuZ0yKlSV9zzPHyJCXDYbuhImPJgwRNK0W7h7IiXywaD7eCNPpgOQxwXi6HeaYLi23cxXn6Po465pAjgl9b2fXh1OV8nobxUKcMe5tbLYa0vzIaNLex4QJqA+NvNad731ZQcDWbsxj2HGvwvGk9Y4M2I6u8kE636FISMIsXBqMLKCZRYJy5JpBKaSp3JSz+/GRLDQJTUphOuGD+I/qPsRBoQyEPshbu6P3iQ/7pkOmd99i/jbrzYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYyd6LNBvMVam5JGVgGX8SjDlsz5LB4Fjfu1tdogpv4=;
 b=QQZClPxlGmZX+lg6t3Hw+rIv2ynn8tjDK5swjSLBYl2ez2QhVW/lkkBU72HkGM4YpsrfjxQQIxFfgM9QPFqese60Plc3GOAFbIwpnYCzikuuHTQ8iGMirqMe3FwqjmaRN7weVvvUY6aOMC59qR35XqMgvwMXEyse4fz8+/Qvb7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 15:53:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 15:53:01 +0000
Message-ID: <ae4a5845-b46b-475b-9f7c-06a6798c9407@amd.com>
Date: Mon, 22 Jun 2026 17:52:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: fix scheduler entity leak in cleaner
 shader job
To: Wentao Liang <vulab@iscas.ac.cn>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260622153543.50169-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260622153543.50169-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3247c2-f6a9-4bda-dcad-08ded0765694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	8CkQOsaW+gUjKortDpJwHUvHfyvkGWBM7jXoia9Vv5kHcBaXTVEtcgSmpH0s9ZMp9a+xOAotzn2GK2Fv6919HPO3oeT4cx6sKOHhbISS0djkxZ0Ldhtxy/JzXggMYe13R/X/eo1Cu82rdN0kEx0Ov/QVvuUEViqCGI91EfMx32HIlOY70Pam8r63AkRha/inDl2M0VaRf/eSiW7itvYaDCZzbdw1vJg/KcvINTggun7x68wE2r4PabV1r5fnBKSufXbPALGEBwF2OTY8v5NWnfjXz2VrVoWEjHL0hLDwV2VZlG+wZoziCV1sviyu66j6PNMK6bYg0Ip+Pvz5NjiuvDM/fmer7lm0K9ARGWlh7G8eUVlUskYD/v41Vpu+ghEAWchepHqEFUOzlai0rN/csu/xzOaUCKaCzCfxSWI6k57lVB2iJIHLKhWGtWau810LmwanAhl/ZjL1yjEd0aiwy9Mmx2PF5mF8qUwsFy8sTbTTyGrdNKNmn3cA0CY0WqLCeuY7O9YX3/gDbqz86w/O2VMnkmSbOj5470UrGV8Wqs8Xy2DIEP7+3ucPtIVajSCuJk2CWhQgowbA3M8p24baGDuqPaisGJyzeJFOuS67eQ6eVMpgQd2QQA48/1YSHwaGjjsXY0+lHkmMxadz4gvMYMQ1xV6DIFjdJ65BSy54bQU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckhLMDNXcnhLdElVaW9sclVReVRvVDd3cVVUV2ZFUEdwTlJLVjZxK0ViZWlq?=
 =?utf-8?B?ZkwrVXZoYWhXR2ZDRCtLWnozenoxTWNHNEVxT2t5NVpmSENvSFZtdDNnNmYx?=
 =?utf-8?B?bXZCelVhLzZnSWs3SkJGVS9QNVhWWnBSZzE3R0p2eXRQOWlpdk50dWZLYjc3?=
 =?utf-8?B?dXBPSTYyZjZJKzRLaEZkcVdlcnU5MVBrdkpJVkZYRERXcXo2aysybTJDOFpV?=
 =?utf-8?B?TVNycEVCeXZPOVp0cnRpRjhEQjRhY092dHVTSTlhVHY2c1k1VlU1RXJVSHJv?=
 =?utf-8?B?Z2d4QmcxOUtKajRXWmFXelAyck5XWitsNEkvM21WSkJBU2xoYldHZHQ1UzB6?=
 =?utf-8?B?Y01Jb1dKSjJqZ1VtWVgwTnZrU1U2RlNaQ0dZVUdhMHVpdWlyQXZ0S2llcitP?=
 =?utf-8?B?MVFXWkIybllVRXdjcEhJaStZSGxqbUUyZW1DYnFFd0g2cnMwS0FLVCtzVjQw?=
 =?utf-8?B?NmNQQUQwOEEyK25rcFhpN1VwZTdoeStEbVdxODVhV2tLYkk3d0xEcEREMXZG?=
 =?utf-8?B?UzhpZ1VmVzVCcVJNSVhhSnRlc1RlSkZPVUtLK3lIenJKakk4akZ0OFdqVm02?=
 =?utf-8?B?dzJSMGxURjZXc1pvL3Fzb0pBS3VBUEdFNXVMM2JDUlVuemFhR2U0WE95eGFS?=
 =?utf-8?B?QzN0RGJvbjVsM1c2dW92RitRMGJlY095bXN2UmQxYnNISVdEZmZuMXhRSk5k?=
 =?utf-8?B?d0cwSlUvdXNWL05ScUQrOVFVU3JTTTl0MS9nOGI4eHcyR3R5RnFtYlpranFH?=
 =?utf-8?B?bGV5enRJakllRkMydWJpOUFwRGp3QWNNZ1YyTFpjYWdRYTc3eFA5a3JFTnZW?=
 =?utf-8?B?RGhDRVhPcndPRTFUY09aTlRKS1E0clg4UWgvais2bjJaT05mRERGYVM0VFM5?=
 =?utf-8?B?Q0dPTzRRbEFEamc1K2dnb1pVY25pMWEyaEc3Q0wxUGRZdHZFeVJCZUhZK0h3?=
 =?utf-8?B?SE9QeEVuRzRXa3FkeXlmckJIazRyWTRkQk5FTk9ZWDR4YXRpN2ppT21DejNK?=
 =?utf-8?B?M2VSeGNPL25ibFNSbERtVjQ5TFJMeEFMcE9uZ0NHTjZVdjcxckprQXN5dWhT?=
 =?utf-8?B?QUxUSUFsUEpmVmsvQXRoL0w4aEtacjhBUm12ZFRzUVJ3NHdYQmpKZmIyL054?=
 =?utf-8?B?aDZwUGpwdGJHTHRWbmhXR1R1RGtWZWI1NnpvdUxZR3hXRUxPUGdBWklRbDht?=
 =?utf-8?B?bXhIMytMbGN1VmtlM2FnU1grUy9acmd5TTRqNW1heGJaTTFPWXhNcUdVbTlT?=
 =?utf-8?B?ZDhaRDVwZVpJSWtrSmJtUHErbmxtTmEyL3BtQjRuc0RpRmRYWENUVnowTmNh?=
 =?utf-8?B?YzdNcUpVWTRnWElIdzNJS2lwYTlhZFRoU1FkdDkrekczNmRWeTdvOHhaODRh?=
 =?utf-8?B?KzJLNmoxc3pVVXBhTjh5cXJvV1NVWE41eEZaUGRoMXRUOTVCZktFNCs0R1BE?=
 =?utf-8?B?YktoU1dZY2JtSGNCbVhoOXovMDVEbExIeDJqeERkdE5wM1ZIN1MvRGFVcVNB?=
 =?utf-8?B?WGg4N0dNcW5nYURxL3dPTXVqa2lUZndyeWNwUkthM3ZEbnVYWm5tR1FmNjVS?=
 =?utf-8?B?S3NQakJsaWh4R0RLL1dLaEFFQXdmY3p0QnY0VSt4b1NLNzk5TnhXcW9UVUJn?=
 =?utf-8?B?VW9tZG5FeVF1cGNjYzZzbGxWUlA2VjJxQ0xIaHBNeUVpa2tLdVhzRDJpMW8r?=
 =?utf-8?B?YTlIT0ZtbFpBM2s5V1BWY3Jza05qY05UdXpZU3EwYUF2eXhDek9ydFJzS25K?=
 =?utf-8?B?TU56N2RzK3RSSm52Yy80U3FDaXY4bUdzd1RiWFNxM2Q3TlJ3REw3ekpmRGNG?=
 =?utf-8?B?bXpZUXJNZHYwYUVBWlBtSWJqcnlxUFJiQ3MraldzbkpVeWdiQVhTbzV1Vnd3?=
 =?utf-8?B?elJibEJpdWpEd0h6eEpud0ozVDZCM3ZNVlNlenZyQUVsaHYvYTZNL0lmU2RS?=
 =?utf-8?B?K1VGcHdBM21vSDczWk13SjdkZTh0N0czYVdGQlYzdmptTG1MTHBYdVpJcytp?=
 =?utf-8?B?NlJmam9IUzdNTzhWUzlRRnZHTVk3RnZ5YnpmWlBOTHNJTEY0Y1hTNlRoaGgz?=
 =?utf-8?B?VjRTOVR6a0Q2cFhDeEdML1dEOG0xdFU5ZHhQazRNcjhjU2ZvUXNFVGtZMlJu?=
 =?utf-8?B?TkRzd1VtbmhpNWFYTEN4Y2FjQkJLQ2dBOGJRODlkdTdyZVZyeDZ2TzlKYzdL?=
 =?utf-8?B?LzNmUGgxUnhHaUtacStMS2d6Mkl0a3AzbjEweTByVUIzVEYyUDVRQStueDRM?=
 =?utf-8?B?algxRG5CTUozQ0dzUWJoYkI5cFVFN21wSFV4dWowUzh5UlVLbUE2UGo3UTQx?=
 =?utf-8?Q?2d9T9OFV+MywepBuV6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3247c2-f6a9-4bda-dcad-08ded0765694
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 15:53:01.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMAEZ0nwsWKxBbcj3c9R4XnB3QNc2cMZoDQtK53mdTRHoUK7SwPg3b4kAgAkMkaj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901



On 6/22/26 17:35, Wentao Liang wrote:
> In amdgpu_gfx_run_cleaner_shader_job(), if amdgpu_job_alloc_with_ib()
> fails, the function returns without destroying the scheduler entity,
> causing a resource leak.
> 
> Fix this by adding drm_sched_entity_destroy() to the error path.
> 
> Also remove the unnecessary error check for dma_fence_wait() since
> it never fails with intr=false and infinite timeout.
> 
> Cc: stable@vger.kernel.org
> Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with 'drm_sched_entity' in cleaner shader")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b8ca876694ff..523b681d0da9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1658,7 +1658,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  				  &sched, 1, NULL);
>  	if (r) {
>  		dev_err(adev->dev, "Failed setting up GFX kernel entity.\n");
> -		goto err;
> +		return r;
>  	}
>  
>  	/*
> @@ -1685,9 +1685,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  
>  	f = amdgpu_job_submit(job);
>  
> -	r = dma_fence_wait(f, false);
> -	if (r)
> -		goto err;
> +	dma_fence_wait(f, false);
>  
>  	dma_fence_put(f);
>  
> @@ -1696,6 +1694,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  	return 0;
>  
>  err:
> +	/* Clean up the scheduler entity */
> +	drm_sched_entity_destroy(&entity);

That is actually redundant. The err label should just be a few more lines up and the "return 0;" changed to "return r;".

Regards,
Christian.

>  	return r;
>  }
>  

