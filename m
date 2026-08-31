Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC30F4457DA
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185639; cv=fail; b=VvsFQxIrtuq/F7rK72MlJk26Pn/rXW6fxeBLJvMGXESdOUs5x5shEN5DOn4ghBxuh3aklaLK4Wj3VvwoBRFy628UQXQqCp3Q/s/SljFHufeNfk86Yob3M1FV6rdsKKW/buyrnbnLOtClcijN97aAmGto6c9NmD0FpdDVGY4qABo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185639; c=relaxed/simple;
	bh=R47e0627nVYApr+76jL0lHTA3wUew4jzg9hBRQI75N4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sYFBl6GPYLhpghPPfaeqNL2CLy7w0TxQkP6u77R6SJcPJ1gIrSWoVb8KutTuE0AgKt5cpp3OQDuFKEkFOaE4czaXJOVfz+4VeXjQPhRfbhnsCFT7wL8OjPBiNn/hPyKZX1IEdPvA4evZmvcRzn3pOZgjXtWX8wVPFzbHLW1eu+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hZXI7OLc; arc=fail smtp.client-ip=40.93.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hZXI7OLc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcT9D5p5nlGHHkjODjypm0bsChMEzQ4RKsaNYxJmT4OcbHpbMsOM+4oFi1jWBs12tr3ed/GKsW0Z3XLa3A3Y7Cb/45i9O0ou2MP1Yo2SeWsxFGOb1mok73EGe+5UbpJHKnekZSFQz3cUcVcfRZCmvzwBpxH+DR7G/cJ4puKZwIw9NSi/kNn/NVK6BFDtka2yZnSC88sE1m7O9UtZ+6kJOH0RcROnHHPpC+I44fBO/s2tt4GhcDFrU5D6KxEqch3NVqfEr0actUo122kPktg1sCiStSQ/cKPy8ZqyXz/2rd3kiNW77V0SxEJ8D6iWvpQkKi/YMzZ6P4G8LxBk69eb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q17pgDNy4w/zpASzXkAUrjiH5MOzj0lH18Gi/lXw/cY=;
 b=unlZZRmjuJw31FxAEEepcTcpDcxm76BxJSDO1B15hRWHQSUHJepVt4H5vSqE6vr4eV/zVoFFLcN+j7GIUC15WHvPIvEMqJjMK7cnqJBNL0mUDC01VtK3OiHGz8kYS1e2HCeeS/i7PN3iymxv4xlfDaqgMvf89viGlVu8w6+DEv8haUk1YMT20DkSjcYfAjmbRjyRxMMpSK7CGbyt4xb1sAp5iuSsHOEmfbjqvwcUcpc68i1S5LnamjlUdp5QmMV0+0mha4vX7Vn4otxcawR6G7/w2elLJ8K6huSD0rdZv0fVIiKQNx2hr1qNdHnCc5zkykRCCanpHZJBM1MsfFrkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q17pgDNy4w/zpASzXkAUrjiH5MOzj0lH18Gi/lXw/cY=;
 b=hZXI7OLc5JSgUbKBUN++dMKyHZyt/OKuAHBbn5sLMyVQCExNK3xJfSQ228dzrZXPnktXIOhl2rsMzxdUFNAwnmJ4dh9Uuewct6KYGc90tJJnvMuxFQNIpl9+4bl29Gfn4yQAf0QAhINnE8iB25vtZ78wDtCyUhQYsPWThyuokDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:13:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 31 Aug 2026
 14:13:54 +0000
Message-ID: <a52c7428-0d2b-4314-bcfa-a1e939b74591@amd.com>
Date: Mon, 31 Aug 2026 16:13:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: skip the VMID 0 flush for VRAM
 clear-on-release
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, timur.kristof@gmail.com, stable@vger.kernel.org
References: <20260831122841.42160-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260831122841.42160-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 719bd7ab-6d5d-4eae-d8f9-08df076a16f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	U06iyQBJgL5NhyMVroOBi1/6sx4PESaorP10klINyId03RqFI08WmAdCci2yVXzMECWyw4PvpQcouB96fwvH75Pq6CG+0e0PLN8UQtg6lke4jyTcxSo3hK5SI+0cNlAkLOdIJwFJ3lB1KJKgLKjebtlgS9ipH14D+kaCX5Ff5cGi4qgGpyM2Vncx4zoTZl26He1Xe2Esxs0W0+g5V1h/0mvWm6fEyP3l/ajM1w0KjOXl3KSrjY7Bn/lF3+pWK4vMT8/TrR/RoznbaX42DmxWNsW+DeuJNFOa50cgwnkCj+aOzhkYqEibHZNZXGOYYnKoczENvDFf8pUtk+YJhOmRrCkGwp/7rgzQYf9ImFU8V6lGboeZKXYW7cnwCYj0ETWm/WIh3/Utcv8vCLUyCxe9/JYmLIz7SQtT1V/h0TLKOjv/GAyOjeTREMjaLnBPMI7HAw7A4PCssOoe6/X+7+AdYwSBnBlfUUSO5U6a5yZDaJLo0G9zgQv1/Qo5XEOUVxnK3yHyA5P9wXD6xhI+Ez4QFdFxH+O8YkldYZXS1TWyyZM7Wq0nOq0faSo4xPdrDAcAEt0NqzahH/52LlugnFt1mJLdgSaWYYArHC04nEZmVqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ri9JckkyUkh3RWl3TlhMQmNoMDhCRlA4Z2hsS2NEOWs1bGxQbTRUSlBicEF1?=
 =?utf-8?B?UmFMajFiMUpaMC90UjdpalRlTXVOMXJJY3orZTM2UndDeXpRcGpJd01aamEw?=
 =?utf-8?B?Y0ZkN25hQklOOUZOdjlvR2xlenZrSFlJK0Jqd3JlaEFUSjZ5T3Y5QWwyTE1s?=
 =?utf-8?B?RmgwRkRqL0xNdW1LV0dVbFcrK3U0dzgyWVkzQzhQeko1RUNpcm5WWXhTZ0RR?=
 =?utf-8?B?WVRXbkRrVjE3cVNCQWVoR0szQjBqT0tPbm9CTkFGWFU0cW1ZUzRna0tCZm8r?=
 =?utf-8?B?QlJlbGJHdmtyajZnS1F6Z3pNaG1LeURpb0RtRUJnWSsxNklLeFp0QXNzVDZy?=
 =?utf-8?B?WmZLQUNXZlBCcWVDZlowN0ZuWm9QS1BSbThIN2ptcDdSS0ZheldsVzQ2ZXBx?=
 =?utf-8?B?aWRRSDRSZStkblBFZnRoSHBpS1N5ZVNjUWRWMXFULzd3U3Y2VjNiUGljODlh?=
 =?utf-8?B?aWhLUC9GRnJ3RFcrL1pxS0l6N1hMcWZ5dHc4T0hLaDhWTVhrV0xJeUsrUEdF?=
 =?utf-8?B?TUxiS1ZDS3kyQnk4azUvRFZLeVpVdGg2dnEyVktLMXFRbEhrWXRpdXl3WlNT?=
 =?utf-8?B?cWp1cnhnNDlwRW5sdHZtZzEwY0dxWitvVkROeFJHU1JWVUVscnJKaEFOdEhH?=
 =?utf-8?B?RzJ2dDVrS1R3Vk1qL2I1WFltV3RWRWhTN0R0S3d4d09nYjlUVFBNZGlVZ1A5?=
 =?utf-8?B?UTlHVXRScnVjM1dtM0E2dXArUmo2Q0FUaUhmMVRadmNFVmdvb0tmdmpHWmhQ?=
 =?utf-8?B?cUg4RDU0Ni8vSjdrUTdRbVVFU2ZsdFFPMXpHUWhoRUFqbG5DVkhXZ0hyTWgw?=
 =?utf-8?B?ZG1UVjBJYUtLcS93d3VHa2RocGYzem91VVZZamZBSG1uZ2EzUXByUEllRkxy?=
 =?utf-8?B?VmcxNUQ0ZnNod2N0bm9mQUxGZFArQkxwRWhDSldnd25yRTQ0cXhsZzJkdXlh?=
 =?utf-8?B?RlU3alVGRW9uRlMybmVOcVZ5Um0xYTJ2ZjdsQmc4VjV1SjR1eHU2b1dNUFYz?=
 =?utf-8?B?OTVQMzlpL0E4WUR1NjBXVzFjQzIrMm9UeDJ0RHQ4RVJFTk5WSzZuSUVEY0tL?=
 =?utf-8?B?MWszWTFBd1ArU1FnLy9KS0NNeWlwcGp0d2tYWEw5Ujk1azNZd3oydVh1eE1G?=
 =?utf-8?B?S05tem9Td3hIbGlLcUhFa2JESDh6STcvV0hEeXkrNmFFWnBtMExiSTdGdloy?=
 =?utf-8?B?RzRtVk9BakdTd0hmZ0ZvMitJaTE3S0JSYTA4YjN0aXROelg2dFI2MWR6MDF6?=
 =?utf-8?B?L0twd2pwVGRaZVAzUWdvTDF2Q0ROemFyTThURHFGUnQzd3VNdHFndnFpaWZw?=
 =?utf-8?B?OGRQNW5DaU9jMUFRVzhhSGMray83cFNqMHQ2UkkyRjlYSXdneFdaZzd1TnZ4?=
 =?utf-8?B?ckFNQkxwMitnLzZneWtnaklmUVI2M0pxbGpzM0FtMDBKS0tuT2pobXBNUmhR?=
 =?utf-8?B?NWZmU2RUN0lRTnFzNHpvMHQ2ajVvRktPN3kzbk8rWWFSRG81TGNySVlMakdu?=
 =?utf-8?B?V2hwYUpXNHdxaG5od0lEVlZVWTArQzhqTUtCWDRpMG5QU3dmY3NFc0x2RDJQ?=
 =?utf-8?B?aTNwQnlSQnhwcFpjWStHOSt1dHVxelpOaHF3WU95WFpHeS9CUlVid2U1a21L?=
 =?utf-8?B?aFpWRU1YZ2VaNWxHbDBUMUpJMG5Fc2F3c3lxc1FUaVdURjVPaWM5aHBNR1Q3?=
 =?utf-8?B?SGZTZFZlNlArZ2tXWWI3b2lNU0N6MG8xQitBeXl2RmpnU09BUEFkNlJXeHow?=
 =?utf-8?B?TENVTWpoc05GWkJHWkxFSVRnZk04K1BiQkxZY3NROWFLZzZ1dkFOZm90UENJ?=
 =?utf-8?B?eFROMEtKcXFUSDJhcFA4NFc5U0ZGS01jRUd5Qi8xcXdYRDRRMDVHY3A4OTRy?=
 =?utf-8?B?RzlrS2IyaGdxSjFkN1o5V0J1dURrRHBPVWs1cFRyYUt4TGtIV0Q2YitlRzF6?=
 =?utf-8?B?Vm03cjNyK0FHSnoyS1hFNDRyU3FvMXE3K0JJcjJGM1NiUy9QQ3d6cnlscHQz?=
 =?utf-8?B?d0dVUzdicDYwbjJ0UjZWWEk2OHhBWGNXZmtPREduVFhjeGdFSDhQMUcyMWNT?=
 =?utf-8?B?bUNYVTR6VlJSRDZKbXBWWUdjQ2xOa3V1Qkw1SWlHd01WQ01QWmo5c1kxNk9K?=
 =?utf-8?B?WDExQ1U2d3pFMk8zYnBRNlIvSm1yMEpxLzNKMVRScmlvZW1nMGYrZTFFcFpO?=
 =?utf-8?B?U282Yk5xUGp6OEd0WWNFSXpYNkZ4STF6cHhueThuVFpGMytnQkM0VXArcGIv?=
 =?utf-8?B?V2hBQzZnRjg2YkM2MHdETDhQV3lYdlQ4TVNDRXErLy8yb0FkMWpCNUJValNH?=
 =?utf-8?Q?w6wNK9ldOmd4pSEN8g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719bd7ab-6d5d-4eae-d8f9-08df076a16f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:13:54.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naWrXR15fV/W8NYmJmUK+n1KsssdSWHwlxGwwbqGrTwE/t7fpsJaOHuiCaZ1J45j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347

On 8/31/26 14:28, Arunpravin Paneer Selvam wrote:
> Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reaches
> via its direct MC address without programming a GART window, yet the wipe
> still forces a VMID 0 flush. On GFX11 (e.g. Navi33) that spurious SDMA
> flush can wedge the engine; only flush when a GART window is actually used.
> 
> v2: Let amdgpu_ttm_map_buffer() return whether the VMID 0 flush is needed,
>     and drive the clear and copy paths from that. (Christian)
> 
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5413
> Cc: stable@vger.kernel.org
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6c07cee8e8777..e0bdd95c64de8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -190,6 +190,8 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, struct amdgpu_ttm_buffer_entit
>   * @tmz: if we should setup a TMZ enabled mapping
>   * @size: in number of bytes to map, out number of bytes mapped
>   * @addr: resulting address inside the MC address space
> + * @vm_needs_flush: out, set true if a GART window was programmed (VMID 0 flush
> + *		    needed) or false for a direct address; may be NULL

Does that really needs to be NULL for any use case? I would just make it mandatory for simplicity.

Apart from that looks good to me,
Christian.

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
> @@ -220,9 +223,14 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  	if (!tmz && mem->start != AMDGPU_BO_INVALID_OFFSET) {
>  		*addr = amdgpu_ttm_domain_start(adev, mem->mem_type) +
>  			mm_cur->start;
> +		if (vm_needs_flush)
> +			*vm_needs_flush = false;
>  		return 0;
>  	}
>  
> +	/* A GART window is programmed below, so its VMID 0 TLB needs a flush */
> +	if (vm_needs_flush)
> +		*vm_needs_flush = true;
>  
>  	/*
>  	 * If start begins at an offset inside the page, then adjust the size
> @@ -322,6 +330,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>  	while (src_mm.remaining) {
>  		uint64_t from, to, cur_size, tiling_flags;
>  		uint32_t num_type, data_format, max_com, write_compress_disable;
> +		bool src_vm_flush, dst_vm_flush;
>  		struct dma_fence *next;
>  
>  		/* Never copy more than 256MiB at once to avoid a timeout */
> @@ -329,12 +338,12 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
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
> @@ -362,7 +371,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>  		}
>  
>  		r = amdgpu_copy_buffer(adev, entity, from, to, cur_size, resv,
> -				       &next, true, copy_flags);
> +				       &next, src_vm_flush || dst_vm_flush, copy_flags);
>  		if (r)
>  			goto error;
>  
> @@ -2578,6 +2587,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct dma_fence *fence = NULL;
>  	struct amdgpu_res_cursor dst;
> +	bool vm_needs_flush = false;
>  	int r;
>  
>  	if (!entity)
> @@ -2599,13 +2609,13 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
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

