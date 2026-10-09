Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D164D0CFD
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545736; cv=fail; b=AXxTw6aZ/DLVj9nG/Pa4CZ3clHeXuqMIA6ddMAEN+S9obdjKxRwLq7NpMslsmsQ4+qre9/T8RFDg+5NuyyFRoDKGX3i1gg/65EPo7YGjzsvzKUjyD2T8TR0+r1lVMSKjzeE3nw8RVq8uzXss2wVaMC9a6UjFgCt/cG1FMrxqYTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545736; c=relaxed/simple;
	bh=vuSlKE0vm0EV9+14y5Ii+ZUFtiQ66/kKvZSxs9fFOBM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gyOSqfzxmlYYTYvalVnKtI0uAHAfi9sRS83+9SZvAEYZO77XAVL8Q8nEbU4h7AXsVMi7K9U6ERjp7XBBCW3mHwaLNneOgQA0rhC+lAc7C4Yw/vt/ddUyXFNrN4VAZYlfaj4KI0kX2hBtWdXmS99q9CwpIVToMkTs5/X+QyeTO9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BMU5e2h9; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BMU5e2h9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEixSCg9WVosYuTGdzqwpQ89bxHxctP7YFC+L5n/MnnuZkUgREB2qEouIBDh9XbpxrgZ1TtkL3WkLaGQ5GKiFsKUfWSsH6xQCfoLn3n4TwIYuBib3J2rr2CxNsCMGlo3Jzn+qrGpdN+OXg1v+34dICcQpDN/B1oKUEf0uiVg0DarlZF4fPLeznbtHa44i3fD0LiadysN/0KvdsiXR//I+L+JEb/EKo04WwKsS8/5N5ZrJ9VFR6iPbPoNzs1/j6YvYdJn9f2/ebm2PstKlpLqnjwfW2wLQDiVpVt7mMs8kh0Ih2aTV2NtcGo2oudwIjWRVr6oQWHgzctHMsKMFEptPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYfwrcoViiR/gnFoyNIAHCBYZreGcrKXTWBTATdQzQQ=;
 b=AXdMInN49SHs83Js/0XGsjT0RtVIcOloYCYtMz6x1NdBSx51BkEmMkzZv6YrnkjaenLELUY1W7mgrdfj24coyXA1p7349PFAYFMkqS9M0JVdmS8iNtn+u0QWcqyOdK9ki19Cj4ReQ6kl5IIXjYCET5HH6bwEwylw9kTrkuiS74rJx7G14z0f4Entpd7z7UNdct1gyVY8QiwIQ5HvgGl0LdM+fFDa3UAjKwmTJ6kSrNiEDoJn0LzrLAzgSMEODjPv2t4e8pYEa8VfOMW4JvDafw3hoxi1eoHGEpHkvdkSglFOc5gq6Y14U4cIuAO2tlfTKA+7KkjN3wo+2+3pb0DawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYfwrcoViiR/gnFoyNIAHCBYZreGcrKXTWBTATdQzQQ=;
 b=BMU5e2h9JVKbODBoKp5Syk8J3+Y8IGh79grdBvISLxK9dj1DVOe+AIvTENEP5TsD7t4OVCWHNXpNJMgTVivT/oZIXH6XMUvy4ErOUXEF0cY5X4UtfzUPhcbFbS3NiObSXmYM8wLGU3eP7YQwAn/ZGYmdoFPrDnqxAMFjh76bcRk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 11:35:21 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 11:35:21 +0000
Message-ID: <caa4405c-eb97-48a2-a088-c22242179018@amd.com>
Date: Fri, 9 Oct 2026 17:05:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ttm: return an error when kmapping a BO without
 pages
To: Jesse Zhang <Jesse.Zhang@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, natalie.vock@gmx.de,
 stable@vger.kernel.org
References: <20261009103419.4122940-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20261009103419.4122940-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::17) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dda7cf5-282f-4a11-76cc-08df25f96669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|10067099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	pySBPY7lLSkEO7Y0gFvPg4SaGIC5Oa/1Bp1Pt3Svn4lYOjQlfnVjQHbI0wfL6/wCvZNl13Vy1sJ+e+V7p0OMeRO0Jd2T8F0Wzei9NQZwQxsG5mU8Lu4eYaHq714FRIj6QMVWnRogRwR+q+9z9q5Wx+QLgo+PSi4Cct2NCZL4xZTdT/69X5e/CVAV9e0lvj3NgRMz9Mp5g68uqW+1/Lrtrx8PPgqT2irULQraCaCKGqWsR3UYI2DV7XkvE5i59M4LYVKSSMxq1UCTDTdYNLbK2BPGqTuPI8JxPeE2QbE0VsZ4eRkdFK3mHxqfNCZ0v7OviDvl0ZNTwdbXtCQo2Cn9NBNs0K87NGXO4StGDQ/wn+6uFook6vzc+KvL4CGpmQpfPE9MY3jcNi+CyVsH6+aA8+mkzkxJDl0DNV3SMnlYmtEV8r/IJKq6sjegCe0NDPKjJTDnsHBqPXuN5egShaviyq4dP8PmwpIgmBds01VPAowGSevzA2Bti8mRaisQOT7rPSX1FC8J21FWWTcrCZzCH1e3pe/Sw/3VY52zVDq95q8zwPYSOnT51n8bo7KK3nKL9SVfzznCYvvA6AOTixjj7d5w28ZOC3ZyInLhvJE09Cl7hSj8JkA/afqtOI+ehdDI8ynGKRMyaHhTdW40xFKM2EIp/YkqXm+P29O3/O7XKDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5039.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(10067099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHNEcU5nU0g3ZG5qRVFUWC9NeGtaZDJMdU4zWURaMWpsMExVQVVBM3VyTmZt?=
 =?utf-8?B?ZjZLV0pLUGtla2tZR21uc3ZHcFF6NHAvODdEbk5BNkdiNHpjaXBtVTVib1pX?=
 =?utf-8?B?RDJEZ1RqWVlkd0FKRWhKYW5sWnpQQ3c2RXBvZlF4T2NLUVJyU1RDV3h2ZWV5?=
 =?utf-8?B?MHRhVUVZZEVJb21sREhKbjhNNnhmTDZXSmRCaHkyYUkybXJWRE9UcTRBNks0?=
 =?utf-8?B?am9RUnYrYlA0cXRhNklLaDcrNlVNUzZNWkpodWRQdnZtRk9LZDc4ZWQyRFNH?=
 =?utf-8?B?NmZPSW1IenhoMk1ZR041em1QNVNnTjVDMmlkYnk4TnVCNXl5cER3K0tsaU10?=
 =?utf-8?B?T09obUNNREE4dmVtQUkwZHlaMytlRi9jc0c3NFY3T3BDNFlNQjdnOTFCV3gy?=
 =?utf-8?B?S2pzN2NiYVZXb2ZKR2U4RDRpcUpUSGlnK3dDYk5RYXVieE5rSVE1SE5OcGxl?=
 =?utf-8?B?UjZzdFBvcW5Xb0FwSHZaMFlmczdGT1RhWmszUWNkQ2pyWVZtaW9VQUZZeE5N?=
 =?utf-8?B?amJwdkxjVG5nanRtUEpuNjBCRXhrcXU5ZUdlOVhkUUh4NUp3OGJiN2x5d0dT?=
 =?utf-8?B?K2NIRDgxa1dvQkpwbXB0UjF1bzBKdGdpaHRlcE1CSXVnMXpQd1pyR0tGUVBH?=
 =?utf-8?B?VTFIcjBLcEhjNFNKUjIrMUVGVTNPbSs3LzZBdXZBRVFhOXlUcnVxOGlHcXVQ?=
 =?utf-8?B?M1hrbVZmUzduaWpFQi96Y1hXR2ZCaGcrSjBZYjE4Z3JwRmVqeFBFYjhLNkF6?=
 =?utf-8?B?SHN0dTNkeHBGYXBnSFBoaC9Db3NqNWFIbW5uSHV4a2lzU3M1OW1odUREMFlI?=
 =?utf-8?B?cW1BeWd4NzMrNXFwazI3TUk1ZjJKZkdCYmQrY3FVSGphczA4aytHVURZRmRR?=
 =?utf-8?B?WEZTZXVTTFNNZFIycVc3akRlZ3c5MDdvMklrRjluMFJEKzRESzVHaFJwZ0lv?=
 =?utf-8?B?dE5DR3dWQVJjdktYQTY5RDVLZ2Z6VGJGZW85M3FnRlNQK0Y3QWZjakpDUlUw?=
 =?utf-8?B?c1FzZlhVaEZGREJjUWNVWC9QcUJ2dEpIZUp3RWNFWFEwc0M1OU1iT3ZZMmFV?=
 =?utf-8?B?di9BN3N0WDQ4MC92K2ZCeDRPdGJGTDRvVXZzR0Q3OEtPclY5Vi9rb013ZHFB?=
 =?utf-8?B?b3pydHNLVU5IajZzOG1QdFdrdS9xTUVDMHFtQkJTSXJES0EyRVdqQ0FjdDB4?=
 =?utf-8?B?c0J6MEpDdlo3aXVKa0RKQlFHY0ZSaEFzd09RVGM0UFhob2pJYmIyUlFYM0xa?=
 =?utf-8?B?WU13YTNpRnNuQ3V2REt6Y0pnWHl1M0UyUWVxUjNJRjRaajNmSUhwQ1Q5ZTFQ?=
 =?utf-8?B?V0pYTDR3TXVzandFbVBFRW1ZbUhFTk5XOGU0MGtjd3BIdEtVME9mYk1mWEF6?=
 =?utf-8?B?aDFXOGMwZElXb2kzMEFkQWlIY0c2MmFmQVFVRmRaTHY5UDd6RVA5cVROV1RL?=
 =?utf-8?B?NmNMQ3g2V2gxMzBiVG84c0NmcTY5ZXBCbWtBaGZ2akhiNWFRVnAzeklOdGlq?=
 =?utf-8?B?MUxtL0hKRjFZZ3ZZL3dxT1ZuWlpHMWRxUk9hSzQ0K2lXSVFoVUFvM21uYUNR?=
 =?utf-8?B?Y1NGaWtvYVFEWjM1UUcyTTZSZmUxczBuUXZ5VzVFejQ3UXFpelhKbkk5amFW?=
 =?utf-8?B?SEdnSytrdGp5Wi9Xb0piZ1AzUmpieEFJQ254V2lyUkY0a0NzbjNVT21oQ3hw?=
 =?utf-8?B?djdCNUxpTGJ6VGVTMUJ0WGh5L0NncGlIZndwSzgrSXRVMEtBbEQ1NGNTbTd6?=
 =?utf-8?B?cDVSMW0vUVNVeUpEemRRc0xBNDd6bEljS2NXanFaUWtpQ2I1OXR5YnZHdkpZ?=
 =?utf-8?B?TGdsVWFWcDYvbFRZSnNHdVdVL2NGRklGdHpQZE5BRDcvd05kVjlIcmhVSytx?=
 =?utf-8?B?WlN3bGdETDFqM2d2S0VHdFRWRjBQMDNMblVLNEJnK0Y3cHNrWk1KSC95TDdP?=
 =?utf-8?B?U0QzaHFVbXQ3M3NjOXFIY1gyVW1uWG42Y1pWTW1tZXlkMmREM0hWb3hDVFF1?=
 =?utf-8?B?clVuekFUTVRGeTdtQmpieVBWTFdoWGd2TlFkc1FudjVmNHFqZC81djFIcnR1?=
 =?utf-8?B?OGFOY1JqZTRrWlNwbWovWjFRQVVrRnp0T1VSeW96VlRaRHdmWlk3K0NrMXVa?=
 =?utf-8?B?WGtZWVRKTVBPajV5UGsvdThrVmk3V3R2MkwvejRBWkczWUkwS1h3QVhyTlJy?=
 =?utf-8?B?NXpnUlZSY0I3Vm1oUzJTWjVFUDFMMjNoTDNOYlFDYklTeUNKT1JxeWcxU1ov?=
 =?utf-8?B?V1FkV29KSDVqS2ZuTFJyN2hZT2ZSM1ZZWmMyQUF0di9Td3Y3OWtTMStaRWo5?=
 =?utf-8?B?eWdCcnhQbENVd2RHY0NRQlBzVnVEeGZYQTdWRXZMRmpPUjhhVmF4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dda7cf5-282f-4a11-76cc-08df25f96669
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:35:20.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZwDF9a++pn2xDDZnCY/UUID84IsmT5inlvckep7Xv82fwNH//N1IDQ2qr5aYojnlWONiRycBPQcmHGFcUOkFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064



On 10/9/2026 4:03 PM, Jesse Zhang wrote:
> ttm_tt objects for imported sg tables (ttm_bo_type_sg, set up by
> ttm_sg_tt_init() with TTM_TT_FLAG_EXTERNAL) only have DMA addresses and
> no pages array. ttm_bo_kmap() and ttm_bo_vmap() still dereference
> ttm->pages for them, so a driver that tries to CPU map such a BO oopses
> instead of getting an error:
>
>    BUG: kernel NULL pointer dereference, address: 0000000000000000
>    RIP: 0010:ttm_bo_kmap+0x26c/0x300 [ttm]
>    Call Trace:
>     amdgpu_bo_kmap+0x89/0xb0 [amdgpu]
>     amdgpu_userq_fence_read_wptr+0x116/0x170 [amdgpu]
>     amdgpu_userq_signal_ioctl+0x3fe/0xbb0 [amdgpu]
>
> Return -EINVAL in that case, like ttm_bo_kmap_try_from_panic() already
> checks for a missing pages array.
>
> Fixes: 75a57669cbc8 ("drm/ttm: add ttm_sg_tt_init")
> Cc: stable@vger.kernel.org
> Suggested-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
I have upstreamed this patch.

Regards,
Arun.
> ---
>   drivers/gpu/drm/ttm/ttm_bo_util.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index 3e3c201a0222..83142bfa3bc1 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -356,6 +356,10 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
>   	if (ret)
>   		return ret;
>   
> +	/* Imported sg tables only come with DMA addresses, no pages to map. */
> +	if (!ttm->pages)
> +		return -EINVAL;
> +
>   	if (num_pages == 1 && ttm->caching == ttm_cached &&
>   	    !(man->use_tt && (ttm->page_flags & TTM_TT_FLAG_DECRYPTED))) {
>   		/*
> @@ -419,7 +423,7 @@ EXPORT_SYMBOL(ttm_bo_kmap_try_from_panic);
>    *
>    * Returns
>    * -ENOMEM: Out of memory.
> - * -EINVAL: Invalid range.
> + * -EINVAL: Invalid range or the BO has no pages to map.
>    */
>   int ttm_bo_kmap(struct ttm_buffer_object *bo,
>   		unsigned long start_page, unsigned long num_pages,
> @@ -493,7 +497,7 @@ EXPORT_SYMBOL(ttm_bo_kunmap);
>    *
>    * Returns
>    * -ENOMEM: Out of memory.
> - * -EINVAL: Invalid range.
> + * -EINVAL: Invalid range or the BO has no pages to map.
>    */
>   int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map)
>   {
> @@ -537,6 +541,9 @@ int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map)
>   		if (ret)
>   			return ret;
>   
> +		if (!ttm->pages)
> +			return -EINVAL;
> +
>   		/*
>   		 * We need to use vmap to get the desired page protection
>   		 * or to make the buffer object look contiguous.

