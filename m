Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748633F4136
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895731; cv=fail; b=d78qGo4L5nmwXAv2cjDRgxITPz2IJlfBUCa3tGUiGOwiGoaI4+/Vz5aAgDt8aXd+bLujPgfaa8RTk46WbX+Ec+y3X17G3FYyMyD/Gdlo2muR0B7a+4Qktemee4c9Nd3GyjPGIP8vp1ES1/j99UPEeIBW8QPnv3Sqz/CVa0GOPOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895731; c=relaxed/simple;
	bh=XFdHG8yvWMD4WX+UyuiS57uqdBjIsh3OzMgGmgr5F08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DVzthWNQl+IE9K7YihbmyxL78YY8UbL7XO1AKI05QN4DzbgDFp1Rc7aaA81fH7VHA2NIOvDr4nYN3t52OAI/5bhLwp7fVEVhv+Vq4cg0SujnoemlveEG8hNa4tHyA4ZWjaM8x816B4RfdXaa5rH8sPXXVD0Cey0i1+JoS0pH2Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FK06B3Nf; arc=fail smtp.client-ip=40.107.208.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FK06B3Nf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGZlbUj10krBm+sHZCO7s2wWi6netGw0COXHe0lHe103OhO7LYnrZist8zG5gHlM6nisbAH4leuckTlc4apxn7GHGOgUpEW0leG+CsUR3cSRTy0ShBDTXfTCvSVkrEnVU8ZifudvhL4aCQLwVDlqbXlA+I2YD/svP6Xz+NcS+0s7KyJ9Iw1I4SQzeChlZDdukScEX2UenwH/TY/FUXTPLb4Q5NAvnhHs6YkwKYpKKqQUwQEFOTuhKYNSHzJ2SIuxikGODS2vdHWS+GgWmRtfkJopF+kY/47z+qvqYcr0y1zq58trBVSabWaJCaZnmaFkhA95Xy6oAy978zNKgj4pyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehGhnYYEJa4TsJw99QGCnjEPsDZGie2nMXk+kYWCR9A=;
 b=PukAhh7MlvpOa0O9tsLK8rgWgIPDjwkXWTpkWhvlKq4CooQdwec9hXdQYdVtL1qo7eLYTHhgnj0SrzKrRQLNprYpg6y6Apd8++PkHnDTufQVeXA2ZCvOg0iKj6FoS+yMtQdxC4EwLF1kHQHWn7rcKbNz99CxJcQfc6OjTb07vOfi/AM3Tq891oKXyUCSxgJgmqXnsZyofU+gGK+0SprBducFoG0SyAP3BTyQvQn4tMiVo728OtisUyG/ofix8V/aHuj4UW3wY5ZNVyqrqEGc8tkCwZnNpZNsyC3lCpNy3TGakLjwI2KQgudGcq1NJfhz8kFQMmdMvmjq0C21uBci/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehGhnYYEJa4TsJw99QGCnjEPsDZGie2nMXk+kYWCR9A=;
 b=FK06B3NfhYvjLl0Br5DHEiFjPmPrY7LiCNBBvom1Nvvzxuknh/Z8Dj1JYgEal5Ok5VFluU+FCxKLsN04Q3i/AS8XaJ/Ke5/w51TV978AwJzuVL1fz/KIVo3y18K3ueAJe1qbGm+fmON+BIVO5dhQim/SokkuROJafqwCoL5PTHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Wed, 1 Jul
 2026 08:48:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 08:48:45 +0000
Message-ID: <613e356a-a88c-4116-b191-455ae3cd6b15@amd.com>
Date: Wed, 1 Jul 2026 10:48:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
To: Nitin Gote <nitin.r.gote@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>
References: <20260701062559.3731993-2-nitin.r.gote@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701062559.3731993-2-nitin.r.gote@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:208:23d::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: d5fe9104-3197-4b3e-9f2d-08ded74d8f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	VUBpI2pDUFfDghFWeEEc3tWwiO1vEMihQ0qs/vZbyVdjCx2UqXK6+w9jEbB+jL/kRFQTquMBPUGsgbhxQBAfsLjzxXmERxm9Z0U+o6H//Ub0YY5d+gYUTx8qK41AbjRsew/PPjgtHj0NOjHMUegwhxMDa4IfISBdbD04FP+MkxYi6WH3QEGduyYvfhDK1QUpEm9WsAfiDCcDgUDGV0Fnx+ASzI1ddV9YDE5PKa7myTFcQEpnmgf82Ytref56GY1bSGuGgEFiJpOh0OFVfGEX2XLTUDi2rqk3ivckO0IQI5huDHI59x+wkJUJHyzUMju0o7cHjwcQ4WchZDvCBANC6gfuz2qL8+R3Upd0SBK6v3srmiqfTBAFwUf1Ik7mipkxiCNCEkAzOPFjwHjKShFfytsUS5SGuz9mNLIr8sEDU6NK9yukL0bw2Hz3C1EQ1rSkTJvpd7QPtdZRROvgI3zyEq9miWR/4VoEq+FWkPmHPWTWnz6RSKKnb42YXEAgo4KRpBOowckI8diuhq3ksfbJ5Og9jznAT7G1iNfYO+6LQgLqMB9WsYw7K7PgDbfscqdBubrx20kWZubwnFvZWQHMISsazUvVMFTnQSNsTkpW6kI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGRnNTlPT2VVcVlJV0N3ZFNQdDI2QjNHWGRpS045QmdReWxpb2ZEWlZ1RkdZ?=
 =?utf-8?B?NjFRbFo0VHhNV1BqWVVGTkpCa1pkcGlWMllDQ3hyL0hYTHZhRzFFRyszWFlY?=
 =?utf-8?B?bEZlb0ZhRmZTaFVsaWtGYzlCRG5tL1BWeW0rTEx6SUJQV29xUFlCaitKSzlo?=
 =?utf-8?B?K1o2ZlhHckVweUpkQi9NTy9ZbHhkbUs1a0FNbWhPT3lWWnR1a21JZXlNVEhn?=
 =?utf-8?B?dGVWQ3dlV3E2T2ltRC9RVkFzUDNMeXpqZEpUbG82V29iTCtQZnNwVjVOSjhK?=
 =?utf-8?B?cll4QThZWG1aWXlNa2VsUzZ4WlpJQ3hVbVo4NWxTYStRb1hpMjRjcjQ1QkNW?=
 =?utf-8?B?b01CU2N6RUUwRVFHclR4WmVkTzR1M3VacTVmSkllUVZkNzJKVnBWNUdDT3JC?=
 =?utf-8?B?Qkc0Q2VvWHprNzRpc0tHTlFsTWdXYVAwejR6a2xRL25LYTgyR0JkZGc0Wndq?=
 =?utf-8?B?eUhjNHFuWUJ0UkpaZ1MyZlFHT2NGSG5tT2dmN1BydFZPVzRVdUIyT2I0ekNv?=
 =?utf-8?B?alFCUjVoL0UwelVteUpGOExXb0JMSDRTc0M1dkwyenZ3TGxQZE8yM1RLT2ly?=
 =?utf-8?B?MnZ6bzZCRTVSd2NhNXVOYXZMWnQxK1l3V3ZLTnUyV3FWWGdCTm9kVGpZTXls?=
 =?utf-8?B?NmJtRG5tUk5oKzRCb2VDTmJaRlhEQzVMOEwxOXluaWhvaDE2dW8vRkdvc2dU?=
 =?utf-8?B?UUtmemdRd25EUnhHdzAzMENpNEhaMVpjTVdrNTJGSUhLZEJsSVRGOFhZc0Jj?=
 =?utf-8?B?cWIzNW9EYVdUMHNkazJnVE9wNXFETlhReWI3dUhQaVUwb1pFQTFuU25rWFZz?=
 =?utf-8?B?T0t0T2cvRjAzaDlrQWt0b1NTNXJMM0VxOHA4ZE02d08xZDhGVzJ1UWVqaTNR?=
 =?utf-8?B?QWtXYi8xNUxBc3Zmd0lHRVJNSE5Pc285aFhLYzNQQzZTQUI3MDZwdndhUzBF?=
 =?utf-8?B?eHQ4SXdjSjdiTSt1Q0xuNWVHVllGSVZCL2w3bXNPTHQyb2tYVFMydWZQNDRQ?=
 =?utf-8?B?Rm9VNkVlY2RYM29CdHRQR3c2U1RpYXJiV2V5dXRYQjFLZEdHYU9PMTJkaWxQ?=
 =?utf-8?B?b092YjE2WU1kZlJPYkVUeW5IRnhMSzczY1lHbXB0OTVNVVZTS01iYzI0MFI5?=
 =?utf-8?B?RGVBSUdDWS9ZODF1RFdJNzZnQjJWV2VVOGZxTWNET3FJQnBkWEMwbkdKRi90?=
 =?utf-8?B?ZUd4clZrQW5aQVk0bGo2cjBqUmY1VXhydUJYUDErM1ZqVUIrZWNsNGxYQVBB?=
 =?utf-8?B?NlRxVnVrcWRBNHQraFg0WUduSTZ6czVFd1RxeE40eGlpdTZ1YjhLTStSQU1p?=
 =?utf-8?B?MTJYYjBMWE5NTDhzdnBURjRuQXVWWi9zNllpTWYycXBtckw4QVFaL3QzcGI3?=
 =?utf-8?B?UjFlbVlqbkxlQWRSdzVRREVOTGczaS9TRjU4MXlVTE9ZMEhvVHgyRHBPOWtS?=
 =?utf-8?B?YUNxR0x0V2RTTm93aExtRlZBT2ZLVmJLMHJ4NHl3c2hnQ040MjRRZUhSM3Fj?=
 =?utf-8?B?c3hkU2F5bzJ6ZHR1WER0RXBVaFlUMXNNUXh2UzVpaG9LR25QcHlERjYyUzBF?=
 =?utf-8?B?VlQvS3V6VUhzcXFyRDZMUVl3dXp4V294U3B5MGhuR3pxNUVnbDhiaVpEVnpx?=
 =?utf-8?B?SGpzM3QrS0ZlSUVJaVVrVTZqOENabE5kRFB1WWhUSUdINWtvcDFldWJMZUNt?=
 =?utf-8?B?bitPU2JEV0UwQ0VBeEREZTNjczZXT2R4eDJXNWJyS0U1RGFneGo4QXgra2xz?=
 =?utf-8?B?ZnZqbngxWGxaZWpWaCtiWnNsb0daRmgxM1RDbHFCa0I3dTREWElsVndXVGQ1?=
 =?utf-8?B?UXV3MW5NdTNLTXFaVWF6eG8xSkY3MmRpbDd3QVR5OE5uK0hJenN2c2lBMWtz?=
 =?utf-8?B?d2IzREdBZHFlalhWTTBhbGlnRWZtQ2crTkRIb2dLZGhwOEJOMXYxN3ppSHFB?=
 =?utf-8?B?cklOZ0hlQlVRcXNrK1IyK1NacTdXNEVTR3ZQcXI1RXpiTW1Ta0FSWkZZUnJj?=
 =?utf-8?B?bE5VQ1pCem9lMDVMYU4xYVZRQ0d1a1FHc3pSbDJnMmNGbFhpK0lGUVR0UmFU?=
 =?utf-8?B?Q3NYczBMSFFWR1RwRmF4V09NVzZyV3UxRmROZnpwc3dvQW1JQ01qREp6NFl2?=
 =?utf-8?B?U2xpa2thT0tOYi95YjRFYWNOWjlhbTBhYmM2eElLVDVGV1VWUTBEWUNtT0E5?=
 =?utf-8?B?NVlIVVZsdnFrWG5heExqN1pzc2U0MXRONDN1bWRENlVFRkpqbyt1RENnc0FG?=
 =?utf-8?B?cndDYVliVEpIUjFLaVNuZlFjMy9MemFiN1M1d3pEaUtFcE9idXVLNUpWWEtF?=
 =?utf-8?Q?5m+LkztsSXs5DwE3Xs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fe9104-3197-4b3e-9f2d-08ded74d8f5e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 08:48:45.2738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7eE7wFn0m3gvPN1Zmx2OdNh6mOCuFFoLSqHz5I/hvBy35FXK7Q2sguHDgZPff9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417

On 7/1/26 08:26, Nitin Gote wrote:
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
> Fix this by checking bo->base.import_attach, which is set only after a
> successful attach. The check is placed after dma_resv_copy_fences() so
> successful imports still copy fences to _resv before returning, keeping
> the shared resv for delayed_delete. Failed imports fall through to swap
> resv to _resv, so delayed_delete never locks the stale exporter resv.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
> Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
> Cc: stable@vger.kernel.org # v6.8+
> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
> Cc: Christian Konig <christian.koenig@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> Hi Thomas/Christian,
> Thank you for the review. Addressed the v3 review comments in this 
> v4 version.
> 
> v4:
> - Moved import_attach check to after dma_resv_copy_fences() so fences
>   are copied before returning for successful imports (Thomas).
> - Removed exporter-alive claim from commit message (Thomas).
> 
> v3:
> - Dropped the xe-side reordering approach since importer_priv must be
>   valid when dma_buf_dynamic_attach() publishes the attachment.
> - Per Christian's suggestion on the v1 thread, keyed the check on
>   import_attach rather than removing the sg guard entirely.
> - Fixes both xe and amdgpu in a single TTM patch.
> 
>  drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index bcd76f6bb7f0..9b6341f69805 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -203,15 +203,21 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
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
> +	/*
> +	 * Successfully imported sg BOs need the shared resv for dma-buf
> +	 * cleanup. Failed imports have no attachment or mapping and can
> +	 * use the private _resv.
> +	 */
> +	if (bo->type == ttm_bo_type_sg && bo->base.import_attach)
> +		return 0;
> +
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

