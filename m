Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35556346E72
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384367; cv=fail; b=kzTWlUeJ7fvg0sXYmIH/+VWC3IX4XYcOISFr2HnrDkAUrn6vv+50t4sZgMUwf9T6DK+JDRBH9e/78xnWzZfAx4gy44pDTfU9z5XxgQxwLlU1KStWORP+Mxe51TtM0ItdBYdLf67RmpaFtnLJ5fqykkxarO2Sic638ZJ5pt8Zpgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384367; c=relaxed/simple;
	bh=lzo1mFIMxBvk+FqGVlAfR9Z8j0t8NrKUZ12hgn+IRys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FV3LpD0pnO5CUWjywlpmINC07IFJzS/GDZnujdL9F3rpi1W8kFzmYqP2WsmHkSTJzTqRFiuBVCBSEwuQY6bgajsxzOU5IRN7EEBu7IpaSsr7OHyhc/SBlRg5k2LXARUUIcV1I074pjWhbkXXhxrQlHPQPgMUBZy51227AakuvpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yUIWmUpu; arc=fail smtp.client-ip=40.93.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yUIWmUpu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdTgx1UhxNNFz5nGzCIjVUvdlE1mxTrDFWQE2hRqrWfjEB0pUNbJISVE24xtcpj6h0K7JP88B9RH5Eq5rMtJsaCHJvPGX2FTsqaLIBfUmCvNgViWZTz2jBaACScrxonadtt/Kw+zQRfa2ZGj9vsbnKjceNs5QwgoW383WDdOjFowG2DC07pOMKneL68IF0RlgxdB6uz9eN53qgEC3c6sN8V7Hv0hLL9RMWjnYKXs82RJz9vJ2ivbUPVMETX7yJXWX86FfYMeRjSkn3CxeLbn/6Y/nd9GjY7oT7eUoC0HwpO8kWUSBpqNrYC1lro7U+qIwifNyoZqzHvlalA6741mDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTtwzarqbIHk1WwlVUJLueiFhZtQ4dGBDmYSrplGhws=;
 b=kLoAGWtawuzHkVEMa7omLEPepYd1iqNOkeOqqkCpwAvGH3GWRcAdnXdgCLsGKu+J616KRZJpWWEFSPAkNuSwPM5gnnKdA0tQnh3ef/fE+kMzYurgCF6HQ75GF6IpprogaZt2tVF2yU9IcqcvsBPj4DT+QtPJrSFkJCuaf+t7F81a7H0pp6N4J0+6wfpZ7vjq1HkPJ+t+HpANB7MGmkpQLc2EDE9rNQQWu8Mf+QT1XTcFI6RN35ZxWB/5hc4wK/V83wttC16ikcy1aUO6qRseyq0Uye3NuaU/hNt6m+i0sVtJO5LskaupI9KpEZEzRHiciQcRCB3luqd3Q9eDhFTxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTtwzarqbIHk1WwlVUJLueiFhZtQ4dGBDmYSrplGhws=;
 b=yUIWmUpu8jCVWQufHf4keu1Lio07SZv4u34bMvJmHZ3jb4Ey6/lNn7gCEUwgaAWgeVZ8JCI9LxvnzP1tAyDkqd5JqFv0Tyk0OW0lUu97OVhkOe2pLOAi7B7LfOR3D9B9mY93JipnbLpBXL+KzKr1oYHL9WGqPblu5MLGyL4s9IA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 10:46:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 10:46:03 +0000
Message-ID: <331d68c6-aa51-48d7-8c15-69d5dbbe35b2@amd.com>
Date: Thu, 25 Jun 2026 12:45:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
To: Nitin Gote <nitin.r.gote@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>
References: <20260625055734.2831607-2-nitin.r.gote@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260625055734.2831607-2-nitin.r.gote@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3fb5d5-d7b8-4090-c48c-08ded2a6f423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	wfM1gfxSj7YgzfqSJiulEVdKhFbvNbhvvvCc9GzVee9WvgCZQmBR/70xe2UjyDy+L83gHpZTZDFyWHNhuLOcoGSojJJnyZGFWWqU87cEEMxaqUOlXgSmM99cFYyUCSNBZspnYeSGH2B0MsOZ5zuYl8Fdr2YCP6c7NiRCRzFoyI0YvATt39yGYwIFuIZc6Z7IpfJQ4BJ5i5o44bAxoKUGbf2+KoaqCznTjq7vm6+B6j8rd0R4RqQmY2KJpsjyWwu7I5ZWrO6HR0U2tHmgReEmBitH1KZ8GKm/1f5af82Gb9vURUrBMUo34+mhGiyk25xr1yn1IevfLkHl+5nB0yaHizJUtWNn9zlRGDhXzDqmgV+TsML3TG1ZmBuZBSBrJUO3+ANLBqoXbiWKblyHbj/OEySKe8/tx9vYqDG/bbvljWTZxll+5Zeihh/OKkTw/4tE6D0UcAVlY5EL3BsgJtF3ODsKKSCkyh166UIsrtV4y/usDSZXS9hZ/M3pUWbxwToAkBmLZ3KPwFMmCppYGh2Z4QvAra25q+kHlqnCs+iOOJpZ1xD5hThRyMDuYmdiE8VokiZQRHm2LFYv9qnIsHtRHd88yOPKdlTn+rZupV6vp3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzZkNFcrN2FrL05ZTFE2eUJIaUtadmVidGxGOXlubWdkUHB3QSsvclM0RHgw?=
 =?utf-8?B?RlF6VXowOHVQRFBvb2RrU3V3bHcveGRtajdRMXZFclZYS1JUTmpzNEJsWDM1?=
 =?utf-8?B?SytLY2p4c284ZXppVTlqQ29ET0dDSUgwdzlIc3FNRHF3ZEw3YkNvODNSNkZX?=
 =?utf-8?B?cUFJaEpBTGpnMlhpeDlKZC9jdGpyRDRNN3lFWjdQYXZvQ1VBUTVqRjErb1lp?=
 =?utf-8?B?czVmWm02bFNEWGl6N0RhemVJWDB0eTdSWks3dHE1VkxvaEFMd09OKzhrTVlz?=
 =?utf-8?B?NmwxUStwY3RkUHBsM1dwckVnaXEyc2xEOWd2ZEJ6aUwrU0EvMnk5Zlg2K1F2?=
 =?utf-8?B?aFBXazZyVk1ubys1Q0ZmUWVlTU5rQTArMkVscGRib0RDWmpnaDR3a3JFaGVG?=
 =?utf-8?B?amVjMXB4dEtqZ1JuOFdtWmtqRGJYZVhISjhjaFh6Z1o5SHRhM1Y3VlhvK3pz?=
 =?utf-8?B?NlFlYUZYSlFyUmpFaFBBdnFQT1dsYnpqSXVadkhxT1UyODFSOWtpYnNlRGNQ?=
 =?utf-8?B?SFQxZXI2L1VLZHBPNHFGL3lMemFvTG9CbWh0NDdhVGFYcmFHVjl3Ny9KdmJx?=
 =?utf-8?B?d1lHTm14L3BPWEV0UHFYUzI0S2NGL2xuVlpkWnE2WGwrMVoyTmlya0hQMVMx?=
 =?utf-8?B?VExnQjFSRXp6N0xqc09vU3YzNEN4RG5oTzI4RFBTT3hPbW1iT3pyS2k2UjRI?=
 =?utf-8?B?MWlXaFdoS1E1c0xmK00wSTA4SFlPcy9UaDdvVzZTRDFsSjM0MHJUTzB6azRU?=
 =?utf-8?B?V1NJQThzRmNnTGVCcnpKRnZ3d3BJdmljMkk3Sk5qeE5iOTR2RnlzTXE3bDA4?=
 =?utf-8?B?ajdhZkdoMHpPenFQVFZkeks0d1VnTkdZTmZGUVdzTjBZR24xTnBJTVhRUzRz?=
 =?utf-8?B?YXdFKzhQNk1MRDgxZ3ZNQjYyTnZoamZQTzJEVGJBdG1aeCtsMlRYdzRsNFV4?=
 =?utf-8?B?RG8yWXdPMVVONVNTRUdEcEJXWVRTa2xydjJabHY2RHhha2JHSlYvVUQ1djZp?=
 =?utf-8?B?ZWo1b29BU0ZQV2JnM1h3anMrdk00WlZqVks1SlpqMjlZQ08yQlBlelVPZzU3?=
 =?utf-8?B?enJBT21DT0hKZHNnZ2ZkaXordndvYWlkNjhmS3RQVk9JYlZPUTNFbWg3K2d5?=
 =?utf-8?B?MzgyZGJ4d20venFoQ1dZbXhqWEtCcjI3dGZiT3dCdGF3Zk11WFIwMDJhZ1RR?=
 =?utf-8?B?QjFQUUMyUTF1bnlZUzZKS3FLQ3RIalBMQmNqdmF2YmhuMW5kWlpHamtJQnUy?=
 =?utf-8?B?RklTcmYwelpxaFRHNVphV2JZb2I4RHNVa3pveElVdWNRMWVid2lPMzZQZkt1?=
 =?utf-8?B?b3c3WGI2RWZHZ2lyaW02NExJZFhFUHlsbVFjdE9yd0QzbElsYTFWLzFMMHp5?=
 =?utf-8?B?bm94cVJrUkNYemlpL1U5NUsyR2ZVeWE0aFJPVjRPdWQzSU1IcGhNYWxmbFB3?=
 =?utf-8?B?TTQ3dmhYajE3ZHowZDBWaFJyRlA3dkZmMjgxdGR4QTRidmVFTVRPNW5KLzdn?=
 =?utf-8?B?b01hV2ErSFBEZDYzamdaZ0o5aGtZWS9mWGJIRHQ0d1VCbHJMQnBycUh3a041?=
 =?utf-8?B?TllpSldqOWFUSWdLM2t0WFZWcmZmK2JNWEtXenZ2ME5TZFFLWWJONWxNYXU5?=
 =?utf-8?B?aFFyMVZFSCtSdDJjZzd4RFcrTnpwWVRjeUN0aUlVWXpHRjN0bWFNU3Z4Yloz?=
 =?utf-8?B?NHhmd0dEQStVN2ZNVzc3bEhuZkY4ZnJUL3dNaERIaUV5cWlJTzUwY2ZQdDVI?=
 =?utf-8?B?S1duZTNKT3BUdUhQcHl6YU1JYmZiNFN1alk4S294ZVRIeFp6ZTZaWUt5SUpa?=
 =?utf-8?B?N2tqandMY0grRFRFQkYydEJHZ25vNm1NRUszUy9zWEZHYk9DcnBzZlJKWStY?=
 =?utf-8?B?VzA0ODBsVWFnNnJ5T1hKVzNpNzEyNXNObHJZZmxHL0tFUmFodk94bDBiZnZ1?=
 =?utf-8?B?MmhVQWJ6YjZoT0MwV2kraXZpeXNvaWlHK1IvdEtsZUVDUmVvejZLSGlFNW9K?=
 =?utf-8?B?bDdPa0JaUWh1RFJiTEZxbDk2UTVqb25kamlXazVaa29vVzV4VldjZG8zMGhz?=
 =?utf-8?B?bDJ2ZHFPMEN4VVhDV0dCQ25uUmlKTzhaYnlGaGxLMnpZQW95MnYvVmtGNytz?=
 =?utf-8?B?WjVaL2RzZUx2V1BhUzR3Rkg5aVRyS2k4QkZMRmhBN1VEN010NjBNcFE0REJJ?=
 =?utf-8?B?K0xoZGVRK0tSUHI0eTNVSGRNM1JpMUloNUlWejhLa1NodzMwNE13dlNhb2xi?=
 =?utf-8?B?Q3RaV0JFRERidi9zSmRNVlU3N3V2N0UzL21RRnNSRTJYUTJKNFZyYW5mbXRE?=
 =?utf-8?Q?xGvDGqG2zpFkQiZD4b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3fb5d5-d7b8-4090-c48c-08ded2a6f423
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:46:03.6678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OypEQjT1m702gZbfVOIi68qCp6b9QGccbmJbAkCtkpxKlk4g67XEV4yGogvA5ea5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9707

On 6/25/26 07:57, Nitin Gote wrote:
> When a dma-buf importer creates a ttm_bo_type_sg BO with bo->base.resv
> pointing at the exporter's dma_buf->resv and dma_buf_dynamic_attach()
> fails, no dma_buf reference is held. The exporter can be freed before
> the delayed_delete worker calls dma_resv_lock(bo->base.resv), causing a
> use-after-free:
> 
>   Oops: general protection fault, probably for non-canonical address
>         0x6b6b6b6b6b6b6b9c
>   Workqueue: ttm ttm_bo_delayed_delete [ttm]
>   RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0
> 
> ttm_bo_individualize_resv() skips the resv swap for all sg BOs to keep
> the shared resv available for delayed_delete to release the dma-buf
> mapping. A BO whose attach never succeeded has no mapping to release,
> yet it keeps bo->base.resv pointing at the exporter resv that
> delayed_delete later locks once the exporter is gone.
> 
> Fix this by checking bo->base.import_attach, which is only set after
> successful dma_buf_dynamic_attach(). Failed imports now individualize
> normally, so delayed_delete operates on the BO's private _resv. The
> exporter remains alive during individualize as it runs synchronously
> in ttm_bo_release(), while the gem_prime_import caller still holds
> its dma_buf reference.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
> Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
> Cc: stable@vger.kernel.org # v6.8+
> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
> Cc: Christian Konig <christian.koenig@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
> ---
> v3:
> - Dropped the xe-side reordering approach since importer_priv must be
>   valid when dma_buf_dynamic_attach() publishes the attachment.
> - Per Christian's suggestion on the v1 thread, keyed the check on
>   import_attach rather than removing the sg guard entirely.
> - Exporter lifetime: individualize runs synchronously inside
>   ttm_bo_release(), called from drm_gem_object_put() in the
>   gem_prime_import error path while drm_gem_prime_fd_to_handle()
>   still holds its dma_buf reference.
> - Fixes both xe and amdgpu in a single TTM patch.
> 
>  drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index bcd76f6bb7f0..bf8eaec0e9ca 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -196,6 +196,14 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
>  	if (bo->base.resv == &bo->base._resv)
>  		return 0;
>  
> +	/*
> +	 * Successfully imported sg BOs need the shared resv for dma-buf
> +	 * cleanup. Failed imports have no attachment or mapping and can
> +	 * use the private _resv.
> +	 */
> +	if (bo->type == ttm_bo_type_sg && bo->base.import_attach)
> +		return 0;
> +

Yeah, that approach looks good to me.

I'm only wondering if some other code than the DMA-buf imports who uses ttm_bo_type_sg could potentially be problematic here. The KFD stuff comes to mind for example.

Maybe ask some AI tool who and how ttm_bo_type_sg is used and double check. I don't think there is a problem, but just to be sure.

Thanks,
Christian.

>  	BUG_ON(!dma_resv_trylock(&bo->base._resv));
>  
>  	r = dma_resv_copy_fences(&bo->base._resv, bo->base.resv);
> @@ -203,15 +211,13 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
>  	if (r)
>  		return r;
>  
> -	if (bo->type != ttm_bo_type_sg) {
> -		/* This works because the BO is about to be destroyed and nobody
> -		 * reference it any more. The only tricky case is the trylock on
> -		 * the resv object while holding the lru_lock.
> -		 */
> -		spin_lock(&bo->bdev->lru_lock);
> -		bo->base.resv = &bo->base._resv;
> -		spin_unlock(&bo->bdev->lru_lock);
> -	}
> +	/* This works because the BO is about to be destroyed and nobody
> +	 * references it any more. The only tricky case is the trylock on
> +	 * the resv object while holding the lru_lock.
> +	 */
> +	spin_lock(&bo->bdev->lru_lock);
> +	bo->base.resv = &bo->base._resv;
> +	spin_unlock(&bo->bdev->lru_lock);
>  
>  	return r;
>  }

