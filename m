Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F97389106
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256370; cv=fail; b=DAkk+PeHf6ZOYNEUVc+JuFLqtbugGAiGiVEwgZp0Z+pMFt+cUKgqNibVVj5+eFDOuY3yCfWzokMbSA55KuSs5v0QsoEj1SnnAza0mICeipt1KN2R2/H6+6rwGTohW6x7RNmhmwCtpdatYIB0T8GaFKLeQFgIafZJJDJL/2cIGwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256370; c=relaxed/simple;
	bh=8pEGKl4PKF/q5jzZ7j/vj9zGbkXKX47CRYSeOPEeY9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ckoqkrzm+6I1T/lE1jz2jT5tV8uEZ4U7Ki3ZN5+GCAcrNmG4w0xbvwEYa5vM+njQMLJMPEUbG9ek4IgOp7lxypifQ8IKVay/Od1u6c3IWOGFTMKBZOMLO9DpVFR508+QxcPQ8szEG0crD7UTvjDfaM7dz2MLfCTPe8waaVE+V3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ViOsdw9I; arc=fail smtp.client-ip=52.101.48.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ViOsdw9I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSlLTEeZm+KppYGC855BTb+SW/UReW5Y2KqwOfiOeCN61eiaPt8ohdnwvXJWbZ08y1huMlHff8fQYhPBnIZ8728h9kAdrSUvFyuffgGwzGJBq9POgRQ1cDbUpzy0vi4E682NpbU+0H5C9kh2+1RgsXts5A8iG11Ue/nskFv5n9mbWNyBaa6jVk7i+slWoQ95hndZbQXhkZPbl/+I72Gsw1MUD3Puga0FE6uZApAZwQX3+w3LRbvT8oRhljuJmP7CaY/ETR/iezQ2/ID/GgajF0WtPM3FFneYtwJ41aTx5/HiU6/lnuRqGUCMrjgXFkPrksjQk5rb+xn7tFmro/aKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HHQk5DIEtxPMsSNCKBbECKqDSod3G/Oi5EB5hmNDR0=;
 b=GM3qGMECVH097KPEjtBKuL0uGmP0hHXvIHofaAginJH0PnztW9lnPC0ntxgIb6+1NybVhAAKAumi12rZyOPRGGpZfYQgnCnnuAT3ZDlbUajCApbah7GSuq7frLxKdUXeZ/ipkrWdw0LemnMLTSIEDkpFlAuXaZ/WZU0yKkAuZEiIJ9FqREYqE8GCVlUGRz55vXnc8jSRsXCMi+ByDqSoQw/N0ApOt70lCRrayER7KOUkIWHlasa9JkFNF9Ck0fGdAtQfen5vEbzws1+DsQwAOspkUDRopElFfI08bugAyO+W4Fnj0xm+Ut3ReJll73SntkUB2w+a42AG6cpjheS6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HHQk5DIEtxPMsSNCKBbECKqDSod3G/Oi5EB5hmNDR0=;
 b=ViOsdw9ImBg2gniVSDGrG5PwROLzxfkCJksnpjeTcjLe3bezje6PQK0I4VFGubyVSN+aVLRJ7gOHy5SKxK7t+arpnY5IROuptucfPd1cc1JzAsfIFtNWg3FepbgGPwQ82qQZ4LnMLNxIGqAsLQBNoD1+jSWybUZjqJ8tyYlr2T8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:52:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Tue, 1 Sep 2026
 09:52:44 +0000
Message-ID: <8c1e54fc-037a-4940-8243-b9912e675da9@amd.com>
Date: Tue, 1 Sep 2026 11:52:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: skip the VMID 0 flush for VRAM
 clear-on-release
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, timur.kristof@gmail.com, stable@vger.kernel.org
References: <20260901095100.79673-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260901095100.79673-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: a37c3163-22f9-4dcc-9be5-08df080ec560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mRhwyB+Dfjpv4mS9+FhhVBg2onPGTZ4wP++6y+AVOjxKTOqtE4RijbOHAqheSU0FCB1QgTQvOkOM4G3kiDd/lawr8N63hEiK+l/NSR8/qg7wGvBexFUCtokBOHJ+7LzvZ9/dX3MiS7S8/g08ZN1BE/r/Wyd48M5Py++6W7gDYQaOdvU+yEPySTyGwVFB/Dna1mebFV1a9rLcQlIZEVos+wOr/bXDwukS+BgEyYo0QJlbYm5DV8m0DUOAmF2QNHkA/sjm+gouyDz/bShu31DR2Jn8umnDdSBqiKjs+ztlEzScaleEOrxZeKaVcmni5cwlR3YbmUOWJUMadQcys7ni3QaEFl8UyQigNiB2WHbMycZTCc05crcbrqjK/O+Ku2/CPC/CfUauj3B60zcANhh4t2Y5sceO+ohYuzRLJbmearzXEgE+6WFvXMvRSXclamW6q7qJEsIcXN8JjYn5t6Pjy1IElRPz2R6Y9POGcdl7NqyTOhZgkjXIylKk1s6ZC8xLqgVrLY0sW8uHtICBJ/QkHpfusszWTHIi3Grb1Rj06vfyxbupa6rjSQW+ve5SeNTIjSqeDq6tpPvq3vlWFESrjpEyBgP3arUhqrtFcQ+wWPA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ri80cG9yM2NHWU93RnlBWnJ6QnhrbGw0czBDaFVvTXBGeE9IMklqZFRWR2dB?=
 =?utf-8?B?Z2hNenBOLzJxazUzekhZZ2diV2JEbHVMTlMxclM1RGlVUU5hcjFIbVZ5UmF5?=
 =?utf-8?B?ejRHbStVcTAwREZVcFFoUWFsQXhScU5zM3pHZ3JPcmZoVkhFanI4RWdzc0Q4?=
 =?utf-8?B?d2tIM2tVRUFxdnM4eWJKeWVlS3Q0NG45MTgrSGVNVnM3S2U0aUdBbWd3SE9y?=
 =?utf-8?B?QjlXc2FIMERIQWdsc3lIK0NmaEJPU1NCVjFsay9VN0ljK3Y3QjFia3RsN3Vm?=
 =?utf-8?B?eDF4a2NlWTBITndlL1kzOW1VM2E3bVZPRjE4T29XZVNxZVBrR2kwNndZSC9i?=
 =?utf-8?B?MGZxT0RFODFNVThvVzFrR0pJTE1JVDBVZjR3c2FoOXJsYmpjL1JXMVgrY2VH?=
 =?utf-8?B?ZzdudVhwUjNHMzBONUpDQ2QyZThObmtIRGNKK042RkdoTHpZelFjQmF3dHZj?=
 =?utf-8?B?aFBiU3E5WDNLclZQakxML2ZEUXllN3NZS0lCTURhZzZzYStlWm9rSmtPMTdI?=
 =?utf-8?B?QnNlYkJhc2lMdlZMalNjYy8wTWlMaENCOWFwWGE0VW95OVY1Z2ZKUXg0VEZT?=
 =?utf-8?B?RnFXMVgvRGRoRm5wczBSUDRYV3l6cFF2cFZFMWlwbHNLa09IWFppZjRWZDRE?=
 =?utf-8?B?QU5pZDN4ckRUWFhLcW1tZzMzZyswSmFXMVBnUDdZWm4reHBpVFJyNldERHFm?=
 =?utf-8?B?ckkwMjIrRVNPb1k5a1NTQ1dFMGZ5TmRZUUx5M1dmaGtRb05qOHBVbnlOV0ls?=
 =?utf-8?B?T3I4SjRwNnRuNElta1FRK1hQSEtZMEFxb2pvN3I5ajhYem55d2MxWWNMbEFD?=
 =?utf-8?B?MGJUOUN1WURIVnBUNnV3MG9taTVTekQ2MWZyMlo2Z3dQbkN3NHpoaFZ5YXhN?=
 =?utf-8?B?SzFzWVU4TUhRY2JRdGpYUE9acWt0aENScjFGSm5SaGZyWTJma3MvRGYwSDdj?=
 =?utf-8?B?bnRvZ3VLVU9aS0NvZFpRK3JuMGZLUncxdVBnZUNtaGlwUG5yTUpNdk1FdldJ?=
 =?utf-8?B?eUJIeTRGY3F2RWZtSzZMWFIvS0Q0VnZvNlQvTXA0MmJSbkFjc0ViMUQzQ2Zh?=
 =?utf-8?B?ZmdPMTdpbWpHanNiZ0pETGh4cGxsK254UG94RGZ1cG5Zb00wTkVsbk1yd2Jk?=
 =?utf-8?B?aisyMWVPSHJyUVdySWRvWjhCUDM2d0x4ZjUwTUpWNjZHOWZwRnc4NVBYNnVE?=
 =?utf-8?B?Znc0K3liTVVjRm5WamFIUXUxVXFRTHBqRVBvZVU5NUlJdVVIVE1CUXlVNmRQ?=
 =?utf-8?B?SjQ2K01lTlFxRGRvaER3WTRnZFB5YnNtMjhzV2xaT2ptNFJ2N1NoRDhkM083?=
 =?utf-8?B?L2hrS3JaMWpyUVJZUldKQTA2NitFVEsrVTlJakx2YzUwMVpiaG5yUGxMU1l6?=
 =?utf-8?B?N1FQU25CeWpHNlRmY3M3SUQxenpiVEdlUjN1V2ZHZVUyVmlhY3Bmb1NaSmxs?=
 =?utf-8?B?bzFVWmFCWWVTZ3FBVGttVHlFcjFSK1huS3BRYWtvMTJ2VUZLVTF0a2tScERN?=
 =?utf-8?B?cjlDWmJHZ0lvVWJQTUdtNkUxQ0oxazhGQjBUdTVRelBuQmhLclBZZXlpYmxX?=
 =?utf-8?B?OWtEQlV1clg4OFJjbW0zem1JRWdBdlg4WllQY3BhaTlwblVBMGJpNHZLcjNP?=
 =?utf-8?B?SzNQcno5VmtidEpmUGFSOHQyb0xlWDJjb0lWUFh1QkJJZ0hMNVZSUUovdHI2?=
 =?utf-8?B?KzN4TlVLUm1DRDhISk5mNmJCWjc4L0pzTHhjWjVRUFprWm5xV1FpN3lEd3F5?=
 =?utf-8?B?NHluS0Ztczh5UkFEYW5tNE1jWHlBd0EycG5Dd1BBL2FGVURpSldiZEhoRnJV?=
 =?utf-8?B?cE8wM21uQm9iWUdySWhPSE1tVE5mVWFqMTJKZ1FsMGh2SUJkN2lSTjVrMjg2?=
 =?utf-8?B?VzBvVlZYT1ZmakZacGFoZzQwd0trU0FjQ1BaY1U3R2EvdklzSlFSalVEZUQx?=
 =?utf-8?B?NURMeGJUaklLNDMrL2daNGVUaS92MGtqS2JvMjZTWjhmUm43RGw1YVpSZXJB?=
 =?utf-8?B?NjJVb1JUK0ROVkZwNVAwRlRJY3JlNTdCWjJNZ1BUQStwMFRBV0p6bEpaVFpK?=
 =?utf-8?B?K2s0SGlWUlBhWWRUQ3NrSXI5L0YzdURTcmFONEdEaVpQVFdsY0xwcHJYaHJU?=
 =?utf-8?B?ZG9QUkt3VmxoVkpESlMzL3F3Mkg5RGlxd0U3YVlIZHhJUExYdkNsc0FUVndI?=
 =?utf-8?B?NkQwVS9nSHdvMUdYODBjU0xHT1FMUzBNRnRwU05KbVZHY3BENzEzcTJNdm5s?=
 =?utf-8?B?N1JrbmNaeTJseGtObG93aDZwemt6Ym5ONGpncFpOYVBZTVZJbkg4MFlMSDJW?=
 =?utf-8?Q?9VMTjOXbnm5EZkVEYY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37c3163-22f9-4dcc-9be5-08df080ec560
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:52:44.5311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HL6/QkTMjkbIAUa34UJsJ9GymZJz6Xl7qab7fvcsWtRKKKRajvTKWl2obyyx86Og
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167



On 9/1/26 11:51, Arunpravin Paneer Selvam wrote:
> Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reaches
> via its direct MC address without programming a GART window, yet the wipe
> still forces a VMID 0 flush. On GFX11 (e.g. Navi33) that spurious SDMA
> flush can wedge the engine; only flush when a GART window is actually used.
> 
> v2: Let amdgpu_ttm_map_buffer() return whether the VMID 0 flush is needed,
>     and drive the clear and copy paths from that. (Christian)
> v3: Make the vm_needs_flush output parameter mandatory instead of
>     allowing NULL. (Christian)
> 
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5413
> Cc: stable@vger.kernel.org
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Any news on the HW bug? If not please ping people again or we need to escalate this.

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6c07cee8e8777..bddecdd64f084 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -190,6 +190,8 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, struct amdgpu_ttm_buffer_entit
>   * @tmz: if we should setup a TMZ enabled mapping
>   * @size: in number of bytes to map, out number of bytes mapped
>   * @addr: resulting address inside the MC address space
> + * @vm_needs_flush: out, set true if a GART window was programmed (VMID 0 flush
> + *		    needed) or false for a direct address
>   *
>   * Setup one of the GART windows to access a specific piece of memory or return
>   * the physical address for local memory.
> @@ -199,7 +201,8 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  				 struct ttm_resource *mem,
>  				 struct amdgpu_res_cursor *mm_cur,
>  				 unsigned int window,
> -				 bool tmz, uint64_t *size, uint64_t *addr)
> +				 bool tmz, uint64_t *size, uint64_t *addr,
> +				 bool *vm_needs_flush)
>  {
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>  	unsigned int offset, num_pages, num_dw, num_bytes;
> @@ -220,9 +223,12 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  	if (!tmz && mem->start != AMDGPU_BO_INVALID_OFFSET) {
>  		*addr = amdgpu_ttm_domain_start(adev, mem->mem_type) +
>  			mm_cur->start;
> +		*vm_needs_flush = false;
>  		return 0;
>  	}
>  
> +	/* A GART window is programmed below, so its VMID 0 TLB needs a flush */
> +	*vm_needs_flush = true;
>  
>  	/*
>  	 * If start begins at an offset inside the page, then adjust the size
> @@ -322,6 +328,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>  	while (src_mm.remaining) {
>  		uint64_t from, to, cur_size, tiling_flags;
>  		uint32_t num_type, data_format, max_com, write_compress_disable;
> +		bool src_vm_flush, dst_vm_flush;
>  		struct dma_fence *next;
>  
>  		/* Never copy more than 256MiB at once to avoid a timeout */
> @@ -329,12 +336,12 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>  
>  		/* Map src to window 0 and dst to window 1. */
>  		r = amdgpu_ttm_map_buffer(entity, src->bo, src->mem, &src_mm,
> -					  0, tmz, &cur_size, &from);
> +					  0, tmz, &cur_size, &from, &src_vm_flush);
>  		if (r)
>  			goto error;
>  
>  		r = amdgpu_ttm_map_buffer(entity, dst->bo, dst->mem, &dst_mm,
> -					  1, tmz, &cur_size, &to);
> +					  1, tmz, &cur_size, &to, &dst_vm_flush);
>  		if (r)
>  			goto error;
>  
> @@ -362,7 +369,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>  		}
>  
>  		r = amdgpu_copy_buffer(adev, entity, from, to, cur_size, resv,
> -				       &next, true, copy_flags);
> +				       &next, src_vm_flush || dst_vm_flush, copy_flags);
>  		if (r)
>  			goto error;
>  
> @@ -2578,6 +2585,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct dma_fence *fence = NULL;
>  	struct amdgpu_res_cursor dst;
> +	bool vm_needs_flush = false;
>  	int r;
>  
>  	if (!entity)
> @@ -2599,13 +2607,13 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  		cur_size = min(dst.size, 256ULL << 20);
>  
>  		r = amdgpu_ttm_map_buffer(entity, &bo->tbo, bo->tbo.resource, &dst,
> -					  0, false, &cur_size, &to);
> +					  0, false, &cur_size, &to, &vm_needs_flush);
>  		if (r)
>  			goto error;
>  
>  		r = amdgpu_ttm_fill_mem(adev, entity,
>  					0, to, cur_size, resv,
> -					&next, true, k_job_id);
> +					&next, vm_needs_flush, k_job_id);
>  		if (r)
>  			goto error;
>  

