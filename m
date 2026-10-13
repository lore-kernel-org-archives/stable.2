Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25093395273;
	Tue, 13 Oct 2026 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913203; cv=fail; b=BykVBFIlgsy2Ehqzxf4yrBEBih0CBRy7I5a/h6rBEzphqjq+ziaYREm7Oh2ZuIkJlV8YeMm9QS73bah6jinhQnPbbrinRcSXXUN8SUGPzEkYKZ6i6L0vRRJ3xkHx/YaP+d1A06ds+LXW+yCy9kROXA7yZBLI91fODtCcRVZysac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913203; c=relaxed/simple;
	bh=rp7Q0HshPqololhaitCJMHHA7u5Z5p96bWRNlvdWBTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WUZUdhjhTF4umyemHUFf2+z8PYAEVszSpNqZwIsRk6tN1C/r5kZgxg2cmS4NBZdhMxyhnneoX443udT3IGKW3G1eW24OJSCpL+JVKyRx1h5Vc0PF8j5nMgEIBkD2ZiCNObN0RnJXfPxfZHYFJ98btKCIHazg/oyPe8K3YhzfloU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l45XppXp; arc=fail smtp.client-ip=52.101.57.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l45XppXp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfucchGE5yIFXhc1hR5ULRYoBt+CgHQJXaV3XN+RexjAukv/1oMorx86CXdmk2DqzRM125wa/LpNruFfO4sK2em+NW8kCcGwMaR3gsaEtiO4UQL5D+w/stJKALsrbLWLMG1YXcEdo7/+JXzemaMYFTLhlkHM+vrDavDj1UylS/ErFM677+8czySf3QNt9xtHH7+ZHg/j7OwiVUJCggdXHjQ/5PSqKxjNwm687zgfj7mpSM4x8+SYX7f7QoAkdMR9KI3Tk09e8yrCKSz8oVxlrYF6RkneTwpVEnOIh5I1Oe7j9x7X+Id6CR0YhSAXgfPWDMiGI4Zhr2M1wj0C+uPx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxX/OWG5qV+b3qb8VF54mpIKNbp0GWuHJzZ3J7YNev4=;
 b=TzD9uhqEQo3FXf8C5T37xmRGsZePmeqq4ffmQDXIDXnTBU5ofNdFoU7brYCHy4j5S2lsVGOr5TOuR2Y9LaOgCRc4n/luaQhSjrD3PH9P7JPPzfmMH1q3RoT8tZ8yPL+Wjr1n8vJEUKCwwgI5/SstagLqemt57BxLxQyL1xSw2Oc5R3i9Guea2zhGPRx1lQhRfZjPHfh4BevBo1TSyWcGm+oXKrYKMir38VcONQCqMzcpl/l0pck+xsYLN7xcvnEQzXtmMwgoWfiQBGlF9iDtR2x+vK49lHaMWXGO9wK8Yob8HscerU4yTqdkPRBg2/8jmGID/QVdw6E/kxGGf5BEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxX/OWG5qV+b3qb8VF54mpIKNbp0GWuHJzZ3J7YNev4=;
 b=l45XppXp8vq8Xyo8ZtmVyYkgHp2sLtNh2kXRSfG4UhGhNKMJMTWnb0vSQTtzZBQqaDh69LrOLmnFM7xhsTk+RlMRGIyR4rQgL9Wx7Ki+f+JsHDiVLBPIFd2TNk/uziBNxCQMaQFPtz7K0vwaTs51EAntuT+goyHQKHJeXBhe6mw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by PH7PR12MB8777.namprd12.prod.outlook.com
 (2603:10b6:510:26b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 17:39:56 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 17:39:55 +0000
Message-ID: <4df51e6e-b017-4057-96dc-32d4003f8705@amd.com>
Date: Tue, 13 Oct 2026 13:39:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] amdkfd: fix doorbell allocation race creating
 duplicate allocations
To: Henry Martin <bsdhenrymartin@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com>
 <20261010030230.1764682-1-bsdhenrymartin@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261010030230.1764682-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0212.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::10) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|PH7PR12MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3241f5-7878-4228-e9b7-08df2950fe43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	17iCFOV76jd1Q5T14w2jlvnxwl2v0pz+uJgkDBcEUYIBDvV/7EzDnz97eMUdqqjXRMol7qoXuf5JVCAPjlh1hRYO4qVI0BLhAwZ1QscCUWe/xB9SCpIQGJIWKKmWMvVr+8EZ39nMo56fy0rHSXCJyS7k1l9hoCHNPxKAYMtEZcz6d87ptF4cJ/CtFbX9eF4NahwDv8P7jl4lDPhxH+ZxsOaDB4JeiH4RqohwRjm7d/EdhQvhbLFq+75Y0E7eD9R9Zsnc60efQTLPJUGOnOZh1Q0Ghd5HOUxY7XliOA/kT+XQR6zsKvhh9y2HUtVFt4AJ3IzATljlsTIBViPvwvnmfBpvPZGFgs4K5U7f/+ZVSCVNRq61ghHa1X3/SmRsHUvAk4GiEUCRcuHIrsP+k/7Z+mxxgojYk6hSlUQ7L1jKweCp55XjlDRL9GvgvsS00GSnK1Bf8Bf4SsShDqIHLkxOQ4HUEVg4j/CGx8bwM3T+OwBqqN6oWrZOkrqDF1JswdVHJuync3AmuBTe14vH2+fYNGIbZSwSBUSWhVfqPydYAmlmVaouxQtSJJ9a2aZh8yCSu0+0FZOYGkhEe2vuMvhy5OUJuKS2UpFpknlQWSkjo0G88cxCDlAqM3q9P2tFNh9ftg0GEuUYbIIQxu6R6vVLzKgil4p/MchRAXQjhYO9hfc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDV5dE5pTnRDWXloTElnb1kycjE2RCttYlp2c1I5VFNVK05FR1loc0MzM0lG?=
 =?utf-8?B?S0J3bzhYZ20wSGpZNXhLMUtCTTQ3VGRaeDRVR0pjSHdiMFZVSDl4TVpJcGRj?=
 =?utf-8?B?ZHFQZ2xrUm9sRjUxS1p5M2pJYXh6SmNsOFRXWWJ6R0hDQnZMWXQ2TnBvYWEw?=
 =?utf-8?B?ZERnMXBkeDRQM0loOFVhZGlxeUo4T1J6THpUdGlnNXBFcXhRRDVYajhYSkZi?=
 =?utf-8?B?V0dna0I5ZEJzdGkvYVRiODVPZTFpVFRGYTN3ZVVPdkc5cEJ0SlJvVTVpYS9S?=
 =?utf-8?B?WjhUK09kS1lGbkZ2eU1wNHFDNkdXNEhZNjMzOVRMZ1Q4a3JucGhhNGZadlF3?=
 =?utf-8?B?bnQ3bVNWcGZEbTB6cW84cHVUQ0N0ZUZoOGowQjdhc2NrbGJhd0czbittQjhB?=
 =?utf-8?B?Y3ZPQk5USUNwZDN6cEUzUlNFM3EwTE9lVFVld1R3bW5zQy9kYS9qcmdEYXVX?=
 =?utf-8?B?a21sc0JYdzZSRCtvNkFXSzRYeDMzMFUraVJmQnpnRzM2MFhyQmpqK3pWZ3Fk?=
 =?utf-8?B?UGdqWG1zYXFNZElIVWZCeW5pMlZpcXNQdjJNQmZwRXNFZTdMczNZSzFFdDlu?=
 =?utf-8?B?S3plajBBWlZibU0rbWxIcTRIS0hnUzQvTkViM3F0M3BGRXNJaGJnQXJUc3k0?=
 =?utf-8?B?Z3NHSTIxRXNjUnZ4RjVlbVJuMC9SZHpqS1E3RkFBcG13WXdKWjNDSUwzWkFm?=
 =?utf-8?B?eEtXOHU4Y2doVTZ1UGN3RzYxTGRLU3VFdHc3Qjl3TEpkcVhaU0hjYnJmNTVT?=
 =?utf-8?B?QktrRGxSN09BWUVlVHYvc2RnY29UbkdDZUZVQytvVy9LanFrOHU3aUVWaTln?=
 =?utf-8?B?bENDQ25lMTRma0tDVWVaV2FYYXZGNzQ4UkFTZlQ1eFVvSjgxSzEvbUN2Z1Vx?=
 =?utf-8?B?ZnVIMU9XSU5ValpGM3FoTTQ2YmJldHY2TGdnZFhjM2ZuVW5oK3Vxd29Hckdt?=
 =?utf-8?B?SlZhYjk0MG5IMU9GRDFKWTlnNWJWQU9qUWoxMVNqS1BvWmhsN2pqc3dCOVdx?=
 =?utf-8?B?eDdlUERMVDVhS2JoaXNsN2c0MGd3dGZXemo2WDNwZys0a3hGa21Rb3I2Ky96?=
 =?utf-8?B?eUNUSytoMUJ1YWthaDFmUFErSWFGSmgzaFVkUzdyckRqOTlXRnkyQUp1a0xD?=
 =?utf-8?B?akJ0cjBrQ3VTTVpxSkdrM0U0Smljc0VraTY4R1R4di9iMGVjbGdJNEkwRjhZ?=
 =?utf-8?B?djgyaFYyZW1JUWtyU2FGU2pSYTRza1dHcUN4KzU4MTRmbWlYVS8zWDRLNWdq?=
 =?utf-8?B?Q3BPVVJYdVZqZjhyTll3TElBcTBlb3lYaU04eHIzQWpRelBWZlptRm12R2J0?=
 =?utf-8?B?ZjNlOCtzZ2ZhYy9USFV6bThUNnFHMFdweDZJaUNHb0RLajQ1ODFwY0l4ekYv?=
 =?utf-8?B?R1MvZnRISHVmNWlFd2VJLzFZclZtMG9vRVJmQ2V6d0hXTmhRVFBpTXcvQVdt?=
 =?utf-8?B?WTVzeTNDMndoVzNyTUZldHpKQnZROWtRSklSVHBIZkJWS3JvOUlSSVNhQTVQ?=
 =?utf-8?B?aktTZXJpaEwrK3dKRTlZNjRCSXQ3MjVzTjZudVQ3TkI0b0p3aENibjZRK2Fu?=
 =?utf-8?B?WUxsbUpQNGVFNHlzZGNRMHlHbWpydGRPLzAwWTNVcUJMQVdsMUdENzhiK2dx?=
 =?utf-8?B?K2RSYzZrMXI5RzdpUmNENUlVempCWDBBTU5JL0FlUWJ5VnNIaTVSd2NaczhS?=
 =?utf-8?B?TzdPY2o0bzNCNHd2N0U0aWhoOE9mYUdHd2RwMjhPLyt5a01IZWxZdVZGVDln?=
 =?utf-8?B?N2twU01LTGJGNW5GdGFzTmVHeXE3cjQ3NUZ5YVNJSXdMZzBiSW0wQ25jdkdw?=
 =?utf-8?B?SXpOOUpXQmdTL1cxdVVtYlpmVkFPcU14YzlmdmJoQzVyV3V5WDlqYlNVT3Rh?=
 =?utf-8?B?ZEpLeU43S1pTalp4UkVNbTJ5NVpyUUZlcGVrdHZXb0ZyaGUzNnhHOEx1Mkhi?=
 =?utf-8?B?bFZDaXdQdmFzbmJLcmhHRCs2cG1INDE5a2xBYUdFZVJiNW95TTJjQ3JFVzg1?=
 =?utf-8?B?L1YwNzkrcXhnVWJ3eGxXRXI5UEs0a1A2QXZ0cUF1dHNxWDFJYUpQUDkxbUZS?=
 =?utf-8?B?cG5qdkxpbjRINVBXcTl0cHNGZ0NJdUFqalRqTzlkc0c1OWt6UGNoRzZZRU1L?=
 =?utf-8?B?U28xSVFIMnJrT3dycUVWMlZaY2VVSS9rQlZqYk80UXZyeGlRZzB2RGtSRGFk?=
 =?utf-8?B?OGxqMWpaRktwdmx5S0hVUWhyNzcwYzFabi85dlVCR3VjbmhyVlhYTVUxbDBF?=
 =?utf-8?B?TjdTNnZPUEhMTXVNQXRsUkJnUkdoY2N0eDdDK3gxZ3VERFp6aEFDbDRCTW1W?=
 =?utf-8?B?YWYrSndZdVdKRHZBUmlhTUFzSWhBZlkyNTAvM1lUdStGUU0rN0pkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3241f5-7878-4228-e9b7-08df2950fe43
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 17:39:55.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VnyCDokTS/KXQ6DC0PNpmiGhEpJtWVUDd3WidOi9aj0+7omJ0b+y3ApYOXbAQa6NodzPs58kWb0u24vCmZ4hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8777

On 2026-10-09 23:02, Henry Martin wrote:
> The check-and-allocate sequence on pdd->qpd.proc_doorbells is
> lockless at every call site of kfd_alloc_process_doorbells():
> kfd_get_process_doorbells() (mmap of /dev/kfd),
> kfd_ioctl_create_queue() and the CRIU restore path each test the
> pointer under different locking (or none), so two racing threads can
> both observe NULL and each allocate a doorbell BO and bitmap,
> orphaning one allocation and handing the two mappings different
> backing pages.
>
> Move the serialization into kfd_alloc_process_doorbells() itself,
> using a new per-process-device mutex so all three call sites are
> covered regardless of their own locking.  The device-global
> kfd->doorbell_mutex is not suitable here: it is acquired under
> dqm->lock on the kernel-doorbell path (start_cpsch() -> pm_init() ->
> kq_initialize() -> kfd_get_kernel_doorbell()), so holding it across
> the sleeping allocations above would create a lock-ordering
> inversion with dqm->lock via TTM eviction, and it would also
> serialize doorbell setup of unrelated processes behind a
> device-wide lock for per-process state.
>
> This issue was discovered by Tencent CodeBuddy Security.
>
> Cc: stable@vger.kernel.org
> Fixes: 2105a15a2046 ("drm/amdgpu: use doorbell mgr for kfd process doorbells")

I don't think the Fixes tag is correct, even though that's what Claude 
suggested. As far as I can see, the code had the same possible race 
condition before that change. I believe the problem goes back all the 
way to 16f0013157bf ("drm/amdkfd: Allocate doorbells only when needed"). 
If you don't mind, I'll update that in the commit description before I 
submit your patch. With that, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

Thanks,
   Felix


> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>
> v2: Use a per-process-device mutex instead of kfd->doorbell_mutex
>      (avoids the dqm->lock ordering inversion and the device-wide
>      serialization) and correct the Fixes tag.  Pointed out by Felix
>      Kuehling.
>
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 15 ++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  3 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  1 +
>   3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index fdcf7f2d1b5b4..55acadc986bee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -257,12 +257,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
>   	int r;
>   	struct qcm_process_device *qpd = &pdd->qpd;
>   
> +	mutex_lock(&pdd->doorbell_mutex);
> +
> +	/* Another thread may have won the check-and-allocate race */
> +	if (qpd->proc_doorbells) {
> +		mutex_unlock(&pdd->doorbell_mutex);
> +		return 0;
> +	}
> +
>   	/* Allocate bitmap for dynamic doorbell allocation */
>   	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
>   					     GFP_KERNEL);
>   	if (!qpd->doorbell_bitmap) {
>   		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
> -		return -ENOMEM;
> +		r = -ENOMEM;
> +		goto unlock;
>   	}
>   
>   	r = init_doorbell_bitmap(&pdd->qpd, kfd);
> @@ -284,11 +293,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
>   		DRM_ERROR("Failed to allocate process doorbells\n");
>   		goto err;
>   	}
> +
> +	mutex_unlock(&pdd->doorbell_mutex);
>   	return 0;
>   
>   err:
>   	bitmap_free(qpd->doorbell_bitmap);
>   	qpd->doorbell_bitmap = NULL;
> +unlock:
> +	mutex_unlock(&pdd->doorbell_mutex);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d8631847f0eb9..96e59133fee02 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -779,6 +779,9 @@ struct kfd_process_device {
>   	/* per-process-per device QCM data structure */
>   	struct qcm_process_device qpd;
>   
> +	/* Serializes process doorbell allocation for this device */
> +	struct mutex doorbell_mutex;
> +
>   	/*Apertures*/
>   	uint64_t lds_base;
>   	uint64_t lds_limit;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 0a7c1900da959..4efe4dae79c13 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1788,6 +1788,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
>   	pdd->dev = dev;
>   	INIT_LIST_HEAD(&pdd->qpd.queues_list);
>   	INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
> +	mutex_init(&pdd->doorbell_mutex);
>   	pdd->qpd.dqm = dev->dqm;
>   	pdd->qpd.pqm = &p->pqm;
>   	pdd->qpd.evicted = 0;
