Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814BA37CD4E;
	Thu, 17 Sep 2026 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684557; cv=fail; b=pvsvVVgt8i5N+ndh5rdcfYDoy3cd5S+qHnRx0HRL7uP7YP78xhEuN99PminJ9tmfG06pjwmZfs/5JLYa6sd3IgfpcxRyVnkPJtOpbxK3oVyOEQYjl6f1RqUxP2ZTcVt175CBY0UMTJ1hxJ0bQieTieX4wfzBDXZoNGbEQfo8plk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684557; c=relaxed/simple;
	bh=y1uo6Y4mdCNwb2ZB9nuebf5JqwFhu+mMcEJuktaz9zA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mi7q7bpn4a09Jydgv6C57aaG9kU6cvAus2aT2TsDDYrm9Sf/JkI+xJ/2d54OvgtRXBjERHsSfLiQKxZIcLUBYDpupcH9GJcTPpPDjEut9A+/hhM27xLnf0uE+r4oF7Bes0804FY0xxiP0uuDa2FP0fiWtG2sih7XfO6M5BYDBXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l9eay9Zn; arc=fail smtp.client-ip=52.101.61.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l9eay9Zn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bchjeb1gn7feN2cISDXOg0LWqPZeEXKLOuK6NJ+1NHRNgAou8Fbv6LpcH2+9JUEySWjxEr2E8xZEBkkrfrllQmKcu0c7SzAFFb4ekWVBxLW4KNdE5yT8YgRN/enJ2ysbbs+Gixv8iUMF1ANKDPLMQOr+0iyFxtpsv2QuhUwEoYJcnMeVkF4rGizLYukvNti1CAD8gAuEUiGdQCWdZ6QF1QBaPITSzF9w10Qr9EHiBTYZtXqgifN6PJPva0uZEavEnTlQgFOxo1comX6AjaQCNSDpx2Wv6Oh8AURVN0WMLbH1wB25SL86n4a9/VpWTchmPcjFpRfb1XGOb6ELcWxRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUuDd1Uq7wTXslaQONm8+3KsXM1FHCWerXFV24Tvz7Y=;
 b=w2cppRO7k8VoGX22Fsdeeea7PXVrCNcRfQBuTEt6817RfYYrCGS/JDnzc3DXcZfHSaiI+MV8ng3HZ0bkL+TMVJfAw6q35R3JRr48Y0tPDvu9wbOyPkhwoJgtjqNwf+6ZFUwGe837N5DXhQHF3wDlaiwwVCW91QCRmSSLVBWlVrz+fHc1eYlqSa3ymZQDDJUQfJem6ftb9V75ngTm9rMVmiv7qzXoOfafBgpTiyeXC9TkdLtpbWjYdBuDIkTvmgbT3m1DXqUruptTArgRgEtSrRqsQ/hFo0jLvNXIXEYLBmuubSjCZdsxnPcI3h6I5bvLkfcjb6XdYcOttTywsdMbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUuDd1Uq7wTXslaQONm8+3KsXM1FHCWerXFV24Tvz7Y=;
 b=l9eay9ZnXq+2eAXZcMTAdlHJZVZ0C3AsVjKY1SSVYToUnC1jTIxiVih0mR3FmfSKTWRLhqTlNjitSGwfNcJHHwjVZRJKUXru8ZdAVOdMzMN5LN1j4NK6fZGZjFx0oEJyXaGekL8V1u7FgUHCYxAWxKT8Riyi7+pgKcD7C7lBFjSj1laqQRUVN88CFiCgN4gwd/0RP4fAnmUlFj0sgvkfjn0qe56xrdiEFxMAouZ/vdUDLYyDVBcgorMfYvO0RZxXQepocklCJkklR5hByaNfN2hf3HAMmIwDPeZCFXUgAm29ezuCLxfb2Er38hiVp/4EiE7JkIl8iGlb6Q7Q5vMK8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.12; Thu, 17 Sep 2026 22:35:43 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 22:35:42 +0000
Message-ID: <42ddd54a-078f-4085-bfc8-31120998de94@nvidia.com>
Date: Fri, 18 Sep 2026 08:35:35 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/nouveau/dmem: pin VRAM for the whole registered
 range
To: moonafterrain@outlook.com, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrew Morton <akpm@linux-foundation.org>, Mary Guillemard <mary@mary.zone>,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
 James Jones <jajones@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
References: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
 <20260817-nouveau-fixes-v1-1-f518d0c735f3@outlook.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260817-nouveau-fixes-v1-1-f518d0c735f3@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::7) To CH3PR12MB9730.namprd12.prod.outlook.com
 (2603:10b6:610:253::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0e4e98-f4df-4662-c5df-08df150c01ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	K3kU5irm+6KMWZ3psGyAs1gXH+9J0QgDa7uq8lpVjzUvJHpmnZP8EdRnYop9jtI9vytd2PyR5oHhk1TmvRI9Y8592cJd89DExavRzTFmwvor7P1vAwCKqZM+svL02O5eUzcDDYp3xVuY4aivJSN01n+i2aZaNSH/rjZqtgfEh6Pg8Uls6jwSTkjdaMkSmu0Z6jhGrncMPSCm3xCRz8Ea9qg6KPG8DeRR3ERBWVdIBsQwiQugidWkEgP7StHTXLHd06cddcfTVVad4d+8bontntEVoCXjnHQkhKM7OwEHERnFzW6o2HF0415jHrDHaMw5yKKyvYGsNyrFSkqEqwz6viKErzCaN5NEZcESauBk5q5WQmiwLN3ZHwm189gt0Ao4jJ0V2MlItTA5D2WStYIj5jxdrbc1fOT4N3DwRegGVU42mIyYoCUGdkTgqi+SE5y3OG4seH/r7GEXd6ZSCNBUu3qSE4qcVfOzgudEJLANoKFqCZg0WB6bDnjo11zOZ/qfie/uZvylaum+evJfajVYkp7VRY8m5C8//0c2/EEnjsktX1KcwwQizP08vf6aM4EqVWUE2nYqEOS8xWDxVkZbqdDAJw5EFac1ajwKIylmt/p+F9OaTT8cfF1I89YIlnanwVbliQYnyCIfCqLMG5gRq/p1xcSUep8PrVIBVeLetxXtYwSHDPOyUxXKb+mP9xujpnQNXek2dexgbSQRj0JLkA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk1zb0lUazFXTk1UV1U0MlpoQ1p1WTdLV2pEUWZNUVNBckZPRlBrWUxodVdO?=
 =?utf-8?B?dGtqNVdRUm84Q1JRZGltRVZ1ZUp3dzNvcGVJWkFNNlJHS1VEd3BnZGVkSmF4?=
 =?utf-8?B?WGJWZWlxT2d2ejcybVV4RGwxYkhKT2o3N3J0dnE3Rm1zT2pRbDhqOVlUZHBa?=
 =?utf-8?B?VUYvMEp2WW5NTEFRVVNaR05sRUJxcEZEd1haa2dhNlN5aFhSQ3pXbEdHOVZv?=
 =?utf-8?B?alhFUXQvZjFGeVhJN244UFRRNDh4RCt0bldGMldHZmZiR3BhWi96cHZ3UVhl?=
 =?utf-8?B?eGZFR3ZGTjdlQ2lmdkVBQXgxcmtNMGtwQkZlWC9nMDkyRkhkRUZKZXBneVRj?=
 =?utf-8?B?RVlmVlY4S3RVU0U3OHlhQ3pURS9UOStURGZyb2tvaGdiSTZrR3Z3OEdYbGsv?=
 =?utf-8?B?VkZnRHBrdU9FbjJPU2g0Zk5TQURwR1RtOS9nbEZGdU1pNHB5VThQY3FDMTY5?=
 =?utf-8?B?eHlRbjBPN1EyT0gybnBpK3FmdVlyM0JtcG1vazYwdTFpNjV6Vk05c0JuRkRO?=
 =?utf-8?B?N3FyamJZRFZ6dHV2ZWo2L0lhYWVzT05tTDc0SUNWWHc2TGthMnZNVlBpNTJr?=
 =?utf-8?B?aWpRVTE2K0MySVlUQUNKZ2hyeVNpbjlFWUJ3aTBGZ1YvYW1RNEcxVEdVZmRp?=
 =?utf-8?B?ZlQxNE95dGJLUXFpbzJRVDRUdWYyWXlyL3B3N0xyQkJWRC9uaEFxczRxTGNz?=
 =?utf-8?B?YWF6dnNKdWxOa2RxZStxU3Q3Vlk3ZWJDaDdIckwxZDJ3ZWx1RnY3QzBUenRh?=
 =?utf-8?B?dlBWK241Wnh5Zm5TOU8zTk0rQXFVOTJKc2R6UStDaWFPMWl6bHZxR0x4eHFl?=
 =?utf-8?B?QVZVZzJYVTZUaS9ReC9IMWF5Y1AvVTFDWmYyZ1prdFo3K001RXBpRVdNbVhE?=
 =?utf-8?B?cFIxMFNRcG1CeE03dFpSQStzZG92aDMxb1BaWFYyV1ZySjlhZ2FnUFBuZm9B?=
 =?utf-8?B?cG5wMm1uNlh4Y1M1SjVxeUlaVjhlVmNJZEV4eVRoMktON3N5SWFGeGVTRysz?=
 =?utf-8?B?bUNaQlhacS84dkc5UERidlBZd2o1R3VHamFTZXFUSWN2ZGNJTU8zdkJ0R002?=
 =?utf-8?B?STRFUHY1bHE2V1dnM2FocXNDUEdsemFWZ3Y4SEdvekkvazkxUUtXc3FiaEJl?=
 =?utf-8?B?UUpoVDcrcmluMEU2WWhqWEQ5VjRWd01JOGt3Z3JNR2RoV2YvMDVnTzNJN2lr?=
 =?utf-8?B?Yy9BMGpHNXR4ZzlYamlOQzZQWG5nZUVPNHo1YlVrZzZjQ0M2ZjZSQUVXMTMr?=
 =?utf-8?B?WEVpN0Z4a3BkUFlueU50TUtFc0tTYnBsd1hneFVEK2xYdURsUitHS0ppMHIv?=
 =?utf-8?B?SXNUWGNxTHU3cGRmbDhaYjUxVXM0YkVocklsUGN4S21HZHNQbWJxZTNVM2Iz?=
 =?utf-8?B?NjJBSGk0RVhJaHd0dGY2ZFM0Qk8yQ3FYMDBRUDY2WlJ3TlFCdC85cVdTWGRn?=
 =?utf-8?B?WVZtV3V0b1hXUVpPR29Wb0NXaDVKamdJM05CazFjQzgwblRBWW5hQ0hrNUxm?=
 =?utf-8?B?MzF2UThCcVhzcEl6alJpWWFGMFBTL2FwMVFiQk51Um44SGdIRDFScCtiUFBP?=
 =?utf-8?B?RDNPU0J4bTg5aGkvWWM5TzkrV0RRQVhaY1o5NTUwWjAvYUpZVk83aFNoT3la?=
 =?utf-8?B?dmVWelcwVHRlSnYxemdtZ1lmMzRwbGFBdHhGMWRrRkZkVWwwemF1ZHpoWXRu?=
 =?utf-8?B?ZDJMem5wS0xhc0tGRkc3a3RqcmFQcWs2OGRLUi9aM3A5OGZRYzZ6SW11ZEoz?=
 =?utf-8?B?dXQ5ZkFid01DNExMUjl3dDlEN3Z3b0JLT0plZ3prN0lvRDJ6TXY3Wi9kUzh2?=
 =?utf-8?B?a05KTkxkQitxUEsycnU5TDlQc2pZZ3B6WHdjM0M1ZEdveFBIQ0Q1c24zdC9Q?=
 =?utf-8?B?SXpKM0VaSm5scEp2RDh6ZmpnRVdUZnhlWFBKMm1RbkxwVkd4dFllaFp6Wk1B?=
 =?utf-8?B?TnhoeGZsMG4wUjhyb1NuREE5VlJ0eE9ZTVNPVy9wRDVzc1ZxaDdhNXRaenlD?=
 =?utf-8?B?czFvQVdSdFhUVkQ5MnF4dzl5TTRnQlhMaGl1bDN1LzhuOEY0RzU1QXBkdDZK?=
 =?utf-8?B?QmlxQnVzejkzSU9iaE16L2tsNC95VThnaWNvTk41cGp6MmN0Q01JR01adFNm?=
 =?utf-8?B?clREeUkxdGppWHhSbmluaUdDK1hSOUc5bFZGNG1TbXI4VkJvZDFhSE5ZSXE4?=
 =?utf-8?B?TGFGSy9TWTVib2NxdTRHNnZIWXROWTdsTU5XblVobHJKRVh1bEVpT2FjME1V?=
 =?utf-8?B?clRFaVhSbEd6d2JSZ2M2UDduc2JkOTVoS0tBSStjNE9GZXBwWkdLTW5kSDEy?=
 =?utf-8?B?ZVhCcWZpdVFkRFIxd1lEb24vTmZXUHBnTkJ2Z0tSQzJXYmJmRnR6UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0e4e98-f4df-4662-c5df-08df150c01ac
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 22:35:42.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2EiXQsWeO2wDVatcezAJocXs6t6dPnpAbyQp6IfP68UD6IOl08cUtpzXutbgFsNTQJLzeKX+PuCTUkMf4k+qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389

On 8/17/26 4:50 PM, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> Commit c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory
> migration") grew the device-private region that
> nouveau_dmem_chunk_alloc() registers from DMEM_CHUNK_SIZE to
> DMEM_CHUNK_SIZE * NR_CHUNKS, but left the VRAM buffer object backing that
> region at DMEM_CHUNK_SIZE.
> 
> nouveau_dmem_page_addr() returns chunk->bo->offset plus the page's offset
> within the registered region, so every page past the first chunk resolves
> to VRAM outside the buffer object.
> 
> Size the buffer object to the region it backs.
> 
> Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory migration")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 9442ec6e1f6c..356ff8f3c1b8 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -325,8 +325,8 @@ nouveau_dmem_chunk_alloc(struct nouveau_drm *drm, struct page **ppage,
>  	chunk->pagemap.ops = &nouveau_dmem_pagemap_ops;
>  	chunk->pagemap.owner = drm->dev;
>  
> -	ret = nouveau_bo_new_pin(&drm->client, NOUVEAU_GEM_DOMAIN_VRAM, DMEM_CHUNK_SIZE,
> -				 &chunk->bo);
> +	ret = nouveau_bo_new_pin(&drm->client, NOUVEAU_GEM_DOMAIN_VRAM,
> +				 DMEM_CHUNK_SIZE * NR_CHUNKS, &chunk->bo);
>  	if (ret)
>  		goto out_release;
>  
> 

Thanks for catching this!

Acked-by: Balbir Singh <balbirs@nvidia.com>
