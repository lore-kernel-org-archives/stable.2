Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF64E3BB69D
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083086; cv=fail; b=GA1r11KHs3z2jRMYN1Z5Jq8I3a2VjSS2AjT1K4TTpVfIL7/AoytoRxh7zyjgJIGmfvsjmd24d2DtxewWGxLsyrcnKJ8vWSp/5GQRVKlDibRgfg3D0BvatK/Qdj7gcZVDR25AXk77lIRnc7K3U6FACTua9RdOa+3/E8vLsAdIelI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083086; c=relaxed/simple;
	bh=VGDElkZojrOH9EHTRRkvzb2H1HBxPU2V2pIVAaoyV5A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CzUqrYSpZnZu6FucqFUopCxUezYQEO++eXFpWQsI1YhHcJfkd+mIf6Fb2mxXZrJqp3VNeFfRcVd/vcKSI785x/mF2LRJrQhWcq7vuG5e0vIMiA7es9z/Dh5/+9lY7Zi9t3iV2rFLzk2npXvgBbCIITlf0lvlefAQyFdiVCjS0hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nj8qchAR; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nj8qchAR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYGRFnoF6XjhaYQ1Eq4Rg/D2xhQ0QuRUiWIwjl3neJalw9eAXdyyrmOdq6i9cm57xvv0x0QHlSVSP1+gtkqwEJjfh2qCsixigAjZofS2oL70oj/MPkPP/f67HejWkKGnKFDJarh8/rJfwjkQyKuYNFEr6ICpBJUtpKQpVsK5bEqY0Dvah369Dkz5Ot0otu57+FpoaU6aw91/p3cyTvpkGjZB/AgKCrFLGcZXxd+RVLPAbRr+sDI+pG9HmDAnHUDqZHBEO56a78ve6W4qP8jIDN0Jf7liPW7UlHMutV+yqY6kDjeZmfDwPj/p+mOjp+cENN2fU/h6oyb80N8Q0vRycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgkdG2Y1AD8lhv2cL6ir2jbko+oZPva2+Y+/SnSyYw8=;
 b=T7qAlIXNiPXRUp0Gf4a+o7mjyFJkAoHdziJs4RFbe7I+R7KB5kXZXxc0BBjBG2BUofYx9URcTCrb9MwuZY8Q0Tv40twSwS7vVrAvwQNyM2Aud7bMkUVBVCMJWZdzDRGSRZqJyApFZGpZvY70sYHxjbuJlNO56EH8UM7fdT0B/jwYVL5Ye8SJxBtGCzDaIsvcS/kTaQDKH7wVMlCkicjT3l4ILKkPryBgThKystwPxySAx1MC6DCr7oaAqeOLJs5XfVltMEwVvNfUtJfpFRD6VxvqIo74APIIMndN+tGEnIIhxs5Na7sCzo9/sgibpj5s6eu6OzxdL8L3Ia861kUArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgkdG2Y1AD8lhv2cL6ir2jbko+oZPva2+Y+/SnSyYw8=;
 b=nj8qchARuVUITFAsl5Gx0Tblbmnua8idFfGl/LYjstZiLLZMPu8FsXoU6n2B8HKx9AYH5g2BIG5oPmJ7VSJKY8n5lRva+v76JBsWy+e/Bb39s3Ojw0e6fX6Frjzgu0xTUhuDAEEVxxiFcryRl+VrHOk0jULOo8DnuwsXILd2tpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:18:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Wed, 10 Jun 2026
 09:18:00 +0000
Message-ID: <f0041fae-2703-480b-be9a-51a1df964a01@amd.com>
Date: Wed, 10 Jun 2026 11:17:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: fix r100_copy_blit for large BOs
To: =?UTF-8?Q?Pavel_Ondra=C4=8Dka?= <pavel.ondracka@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 stable@vger.kernel.org
References: <20260610083245.1057241-1-pavel.ondracka@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260610083245.1057241-1-pavel.ondracka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2ffeaa-7aa2-40d6-001b-08dec6d12a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vX+f30jWrkDzJgctKm/UClhefaJxq2wLnWndq5kaNlt50kUxwgARL0VwuhFZU+y79Jz7xs8qPzoUDO5RJ0QxGJhnLsCfYGd57oTiYp4B67Ui6EWAZD9JdpWNjIWZdZolQkfgFEEDgQqa87vn89GuNLfl1IBjHBu/LMvfqtussqj6zzV1m1MntDu4jVH6Fe/1QVMdWf2wFLYXtNGR350WQ8QxLs6tlDdo9ROkUMnSnn/9UgQBt7IckXvAy8nn2zPJDJ3m6Rh1fitKXJOVnnSuJ45hh+Zcm9mEDcnDlLQMo2G/4LaRbExKfh9jemICqijy8jkAl48WKvxYOhQ3EvqMCYvmmhegU3v0orAGM6CmKAIsPzvtP1wyTjt4K6zrZnuRBgqdzbiH+7SSvDRJWdUofbFuG1Iry1P09QqcGOchDN6ivZwVStUuSIBZpNvfgUZ9NYwX6BOuJPn+Bkkf64WthDnE3H6vsuP7EXAwiGt/KMLD3lOYSfriM4SBNxQff/ADeSu2X2JCjtBF6QBGdcj9gEFh6Vh7ix9BokFQO5kFhAak7wzBxEQaijsPyihXtHZ77DJ/iZoEZl88jTp+AWFX/d8ScxOsMUb44FUn6PWrnuIpniQbR0BTOKCz1vCRy/kTDlCbzAWx4x9pS8WD0H2AlZlOFVAL50WiCIlwxAJf3J67t8Gid44jTT8mOVQBJNe5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG5oV2NiZExRYUtxN3JxRk9nR1ZGS2VQbW1MYjY2eWhVMTVCOVh4Vk1jVGhn?=
 =?utf-8?B?RkxSdXl2bnl6em1Da3M3T3lXQXFZWE1aSDlnVkg3OXJzNndUQUZQd0pJSzAw?=
 =?utf-8?B?RENJeUo4WVpZU1ZHYlVWYWxKdFc2K0VrWUs3TW5qd3lBNHRKUTlVM1B3NWJG?=
 =?utf-8?B?SGdEMnZkRUpSTkxRM1JTN2hIRTYzYUtOM2dkQmhjSVVzV3BnSXR6RHRneEJQ?=
 =?utf-8?B?UWdNaGRQVVZMY0ZtZHhFUGk1WFoxZXA5ZGJpQkpKRDk5cjlJRkppNldqclk1?=
 =?utf-8?B?VlpZbnRmZXRjZzlOQzRGWnNqd0FMZWxlSEg3MkZlWFAvdFlyT2kwZDk2dVJv?=
 =?utf-8?B?MlczbFhLenA0U1haVkV3eHNiYTJsSEIrUzJHMnUxbTN5NThmUHRlUmZZdGR3?=
 =?utf-8?B?cW9wdWY0M1JwMTM2ZzNYWlRuQ216MUlRS3pWK3hIMFVTeGRwcXJpT3YxUzB0?=
 =?utf-8?B?WUUzc1BucHo1MnAvQnBvUXN2L2tmK1NWK25CTW5ISE5pWDVBallvNFpDSTg1?=
 =?utf-8?B?bE9wY0QvNy9FQjBmeURjcmZqZThBRVVUSTRFeFVnSXBDMWljNXZuZXZ1VE5E?=
 =?utf-8?B?ekZITklFSTR5Y1RNc2Z0aHY1dkxMM2NjSHhMZVhzL0hUc1k2dERML1VRM2Zi?=
 =?utf-8?B?ZzNwc1BTdzUzSS9ibGI5bzRPTEZYd05NOURjZ0pMTnBGL2Q4REFrbmN1UFhT?=
 =?utf-8?B?MktmTFF5Y1RINlUrd2dkV1A1SEZqMVhVVUtmMUxObVg4bFRrS0UvR1dZa3h4?=
 =?utf-8?B?Zld6Y1kydW9QdUpCYUgvNGdtTVE0WlNPTjJwM1V2bTU2bEZFaWRWMnlaT1U5?=
 =?utf-8?B?WGN1NTFpVlJDcVViekxzTi9xR1hVdDhKaTBUZzlVVkViMmY3VzB1L0NqR0pv?=
 =?utf-8?B?dElmeDNBbWxPS2svZVdwazBBSEhBWXc4SVpydXVmV0FRQ1VKWkp1S05yUURJ?=
 =?utf-8?B?SUd6VUw3TmQyclQ0UTRybUZ3cE1admhIaDEvQTZqMmdIMnFIY2xVaUxJOFRn?=
 =?utf-8?B?RFFTRHNHS1pHNUpaUVd0WE5HMU0wZXJPTVFRVHRzRHJ6RWhrRHVrbU1HYWlL?=
 =?utf-8?B?RFZ3SENwRVhFM012ZkRhOU1NYlNKemdUeWlaNlVaL2tpUTJCZUJ4QWIxTnZQ?=
 =?utf-8?B?ZndCd0pXMnh6WFNKcmxvTDhBNklUSlA4RzFJZGM5LzlrdjdUNFFDTUM0YzBE?=
 =?utf-8?B?ZnE0MjVHNHA1ZWhaU3RXR0dkdHBpNzFLM3hCWlUrcGxLMThZQm5rak56YURy?=
 =?utf-8?B?OTZoOTQzMlQ1QW1NYWN2VndqbHJ2SDR6YTdSSURUOEhzN2FJWWI3RDNYWEQ3?=
 =?utf-8?B?RExIR0FIa01nNEZ0b1QyNC9oeWpmL0gzRVZqQUp5LzJZOWgxaFFaOHZ1N0cv?=
 =?utf-8?B?MWMyWGxKMGZhSzBueXRyT2ZEOFFQRjdldVpGVnlSb0EwNkRNeHMvWXUwbDIy?=
 =?utf-8?B?Y3ovbC9yVnZqaVpHT0E1WTlOTE5qWEszd2VVdTIvUk82aklRVC9CdVpjQnVV?=
 =?utf-8?B?UjVCWDQ4cFFQb2VMZ3k3YktORFVOVkswZ1ZyUlhFUGlSazBWcDFCTE5xdVZ6?=
 =?utf-8?B?Q0dDeEFjNVVzNGRObTRmcld0NGNMK0dGdThhRkpWYjJNbG9YSEVIT1hNQmtm?=
 =?utf-8?B?R01sbUxQUXZyak1nSHlycnFoZmZEZXUrWnJ1TlFucVEvK0wyRzBLVjdteVRn?=
 =?utf-8?B?MFNnbzZrT1lsMTFhVTcweEN5UHpYaEkvL3JsM3laOVAvVTlsbUhSS0FMOHN0?=
 =?utf-8?B?UjF5R0FISUxYUnhYOUdUb3krajlRY1cvY1JRanlkWVdtY2hFbDJ2R1k4Szdy?=
 =?utf-8?B?WXhGamlvNmMyZ00zNEFOSFhtWHAxYzQ0bUJHT1RYSEVNaFFnU1RURy9LZG5L?=
 =?utf-8?B?d1dSY0ZLV29LN0xDNS91OSs3WnYwb1ZZVlUyWVZDUHR4WEltWkVHWmhWcUp5?=
 =?utf-8?B?aldRbENJeU9IREdMclA5eFhUYWRuU1pyb09DcVU0b2lzc0tIaStSSVlBdXpU?=
 =?utf-8?B?NHdqR08xWm1xMEVWN2cyT21tbi8yV2I4NG1aRDVMQVJkdlZLR3FFSUhDTTR0?=
 =?utf-8?B?bTdhbWRxRjBITWFsamcwUis2eC93YzQ5MHllTWs3M0s3S0YzenExL0UvUzFG?=
 =?utf-8?B?cTZFZmtmbEJUV0N3SHhoQUJTS3JQN0FZS3h4TjNNZ0pueUF4T2JGS2l3cGRw?=
 =?utf-8?B?WnRscWFhblA4R0lTOEUrQU5YOGEvdTd2ckllYmcvN1hNc1d3eVFYeEtuUTNw?=
 =?utf-8?B?bDVpUnpreWNlWVYvYkxFTG1sazRueStLNG1Hc3pJMFFXVW5KTU9LaTJxYWN2?=
 =?utf-8?Q?W3sdLgdRvyNGqqRrWN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2ffeaa-7aa2-40d6-001b-08dec6d12a91
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:17:59.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOX6ANJSvSoxYqy6tnPv5bXXo+ii9TKpZA0809MtRtCiHy2+hP1av6AbdstOvjmM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241

On 6/10/26 10:32, Pavel Ondračka wrote:
> 
> r100_copy_blit() copies BOs as 1024-pixel-wide ARGB8888 blits, so one
> GPU page becomes one blit row. Large copies are split into chunks of at
> most 8191 rows.
> 
> The kernel register header names the packet coordinate dwords SRC_Y_X
> and DST_Y_X. In the BITBLT_MULTI description in
> R5xx_Acceleration_v1.5.pdf docs, these correspond to [SRC_X1 | SRC_Y1]
> and [DST_X1 | DST_Y1], which are signed 13-bit coordinates in the
> -8192..8191 range. The old code kept SRC/DST_PITCH_OFFSET at the BO base
> and used SRC_Y_X/DST_Y_X as the chunk address, so large BO moves could
> exceed that coordinate range.
> 
> Compute per-chunk SRC/DST_PITCH_OFFSET bases and emit zero source and
> destination coordinates. r100_copy_blit() already packs
> SRC/DST_PITCH_OFFSET as pitch plus base offset, so large chunk addresses
> belong there rather than in the coordinate fields.
> 
> This fixes Prison Architect corruption with 4096x4096 mipped textures
> after they are evicted to GTT under memory pressure on RV530.

Wow, impressive piece of work. 

> Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/6716
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Ondračka <pavel.ondracka@gmail.com>

Acked-by: Christian König <christian.koenig@amd.com>

Thanks a lot for digging into this,
Christian.

> ---
>  drivers/gpu/drm/radeon/r100.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
> index 3ac1a79b6f13..533215d6e9cb 100644
> --- a/drivers/gpu/drm/radeon/r100.c
> +++ b/drivers/gpu/drm/radeon/r100.c
> @@ -906,6 +906,7 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
>  {
>         struct radeon_ring *ring = &rdev->ring[RADEON_RING_TYPE_GFX_INDEX];
>         struct radeon_fence *fence;
> +       uint64_t cur_src_offset, cur_dst_offset;
>         uint32_t cur_pages;
>         uint32_t stride_bytes = RADEON_GPU_PAGE_SIZE;
>         uint32_t pitch;
> @@ -934,6 +935,10 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
>                         cur_pages = 8191;
>                 }
>                 num_gpu_pages -= cur_pages;
> +               cur_src_offset = src_offset +
> +                       (uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
> +               cur_dst_offset = dst_offset +
> +                       (uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
> 
>                 /* pages are in Y direction - height
>                    page width in X direction - width */
> @@ -950,13 +955,13 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
>                                   RADEON_DP_SRC_SOURCE_MEMORY |
>                                   RADEON_GMC_CLR_CMP_CNTL_DIS |
>                                   RADEON_GMC_WR_MSK_DIS);
> -               radeon_ring_write(ring, (pitch << 22) | (src_offset >> 10));
> -               radeon_ring_write(ring, (pitch << 22) | (dst_offset >> 10));
> +               radeon_ring_write(ring, (pitch << 22) | (cur_src_offset >> 10));
> +               radeon_ring_write(ring, (pitch << 22) | (cur_dst_offset >> 10));
>                 radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
>                 radeon_ring_write(ring, 0);
>                 radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
> -               radeon_ring_write(ring, num_gpu_pages);
> -               radeon_ring_write(ring, num_gpu_pages);
> +               radeon_ring_write(ring, 0);
> +               radeon_ring_write(ring, 0);
>                 radeon_ring_write(ring, cur_pages | (stride_pixels << 16));
>         }
>         radeon_ring_write(ring, PACKET0(RADEON_DSTCACHE_CTLSTAT, 0));
> --
> 2.52.0
> 

