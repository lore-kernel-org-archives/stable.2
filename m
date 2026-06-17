Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5063C4545
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690268; cv=fail; b=IzhNLaL0ft3qmD38WEqspP5rC7ntKOuLBgyCk/d5iAq33FJGbxQziDPrG8WgnRU6arnG1gtl9tzy3zKVHxePyaBAx4BRa+6k87pRxZ86mMf/yyy2/4feaxab+Ut9s4kcR2Nx4bCaH/jNyPrfeZO/RZEhZU63gV3PHFK4XIvy+wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690268; c=relaxed/simple;
	bh=wbm6w1PbQ8gRxiG1L4uNO2rRcsTxY0pYtFI71lilk3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SVPun0//CQNC5ENWF85QfxFz1j5J6uisKH3xveNR9dGPWQLhPA3CsvCcu9doZnXduNuFM2wZckGAPvxOmDGei6gGbVU6PrQX8uGqqmw52x0+Dg5NgIGFnucp4tje3SJaVd1WGhh+B+2arwJzMnlyDkdbMjnWjRPijHjdiZg/ItY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rTL2xauT; arc=fail smtp.client-ip=52.101.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rTL2xauT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGumPoxAFpnS7GmZr6bBRx8TYWwCQSTHM2KS/nqVATaUdmOMCG0yF0VEGTuVgbwMb32IRE/HlXnKvTNLHk5kHmLWn/DEOjeTzf/wPDPNB0wnSCu3XIUdXdpcI0mYlADVwk5KBuBccuSt6tgtVLv2IDsULZSQCTVyTbyyo/Q/LHuJ8d8GO/av9hUbB/Vj+tPOuCMeHqBda/xkHAoBye4uyQe0CisTCpvpKO8NzuS0N2MKAuTqV/BBgJV1WgB1D+S2QKPLCrr2T6pR7vrvJnS434FXxxe8Rfy9MJzo14rBQR7D8ptsNRCMGPLCOmjClcjyj3qhuy56i3WpKfIkSl53jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqTxHy6IyUWWdRuyvS6OagEmJqvjH9vBZGXKpwviap0=;
 b=oyUUBkwYVvvfgTSotAof8pBFjVf/Klfk4ixohgrsZrg9b/YTL7MKFvBYgavxwm1mguvyThGcwpCCQtG8IQmq+LEczp7rRn6YHC0u05BABDc3FWNvUWujBdUb5+q7VDENQsqhnXXvmh94iC9r4h+/pl8waZ/qdCgNvClGgW/NEV9UVaoLgxfAo2vtralYPEQ0C0V2nXs+Z024aqRLhaz62unjpyyQ4awXYHPpIQamQ9rfg4pSdGmzec1AyBTJq+k+GtypKbM96wXV+pvvXCl+VQjn6CjlabDWoGvP+CmXTfnNrVMUpQAGkKW2xi0w0I70nSM8JJCI1UdmaYgMpfuOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqTxHy6IyUWWdRuyvS6OagEmJqvjH9vBZGXKpwviap0=;
 b=rTL2xauTdmQj74kF/vZsA6QJlZfUH0AvAwPEly1cldihN9WXcM25TkGXRPgtWS27gW+h/j4Nj0P9nAix81/AzVM4BvtJnddTa1pf5dwVaHWkk907B+mxuIdDEdw1vTzRrrx7fNaze0XIk+PovSDOWbpRudD3/F7+tFP0CQp6f50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 09:57:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 09:57:41 +0000
Message-ID: <6c5c3c43-7f42-41c9-9d59-7109b68831c7@amd.com>
Date: Wed, 17 Jun 2026 11:57:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Create imported sg BO only after dma-buf attach
To: Nitin Gote <nitin.r.gote@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>
References: <20260617101654.1989199-2-nitin.r.gote@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260617101654.1989199-2-nitin.r.gote@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0413.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e7fe4a-450c-4fa3-17f7-08decc56deeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YWKaB6du8bxm1zmRmG+XEINsd4hfiz6Z/dewkA8E6qSUKGBeII5Fh/0X6G1VyL2QQF8SxUvLtanswcM51UQvSfjoA7E2oAEhY3bEnIUwUWTR08tQActrLcu1e1/58/I72rkrW2tGEtpcaGdDnuzl73JzyVnuAw8Kxq3DRwD5BO7XYsY3Alr9KHLn/tZxeJAk/9FL7Yf3dnqA/itZja2GIrRg6dBztoZh8RUe2QHXQa7u2NVf7n5ryiYQb9jG/plE3UyDp8CH9eZfYPok4DdcB0Nr8eusqgWKlZX76ByrX6qTcpYipzhMz4jVWen+WADmOOBfxyOTc6No1dVNdt4Q5X/3mJQp9YFgWGOZiqbcHisb8YDw7LwiSnvWFjpD9AwFClDAPggf80qYMZzP6+pIP1NVCZTR8VCz8cfWMBZoMaA89d42HgSu+fA8uzSpFs107E/SBoAo5THBTTVWHeKxY4kOFncYPlqHhm1OkndqwOY729YqKbIvLtmDec/KZsVWd5qXMudsQpZ2Tef0H7RkdzqIienZPIwsKNV910GNUx6XkfB8cBYXBWZOUcHbIc0EL/W6MlaYZrqvkUgqSZPuv9nYwsJ+EvX8FjhUKsRKbHiU0rQec0gTw86F5OOHhTj6YYugdYLzzVzUou+nGpg6Nw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXJwd2N6bk5IcllOOGZWdEp0OUI5MTdGN2g0VHNoYlVqNFgwNHloYmlQVDdU?=
 =?utf-8?B?RmZ4N1hNd3BYU1dyQ1dpSG9BWWpLNWNGTDkvbFZIU25XU3lpZ04zZDhPejhu?=
 =?utf-8?B?My84QmdKY1htNmJSYkppdDM0Y3orRmJUNEZLNDlxeExtaml5b1RxSklqOUVP?=
 =?utf-8?B?Z2NLTDlWbVlhdVhFTmIvYUJQa0VDbmU4RTNhb2hEV2hkYkZ5ZG9YUTFmQWxv?=
 =?utf-8?B?ZjJ0eEQ2MUlscjkrenZwdnVXRkFCL2pvaVlzOVQ5U3BYQjRWOFMzQ01lTDBz?=
 =?utf-8?B?S0tjN3ptQ2JLT0hxUEYxMmtNTENRNHpiYk9NSkNYNUlQamhrTmZRWE1nSDBl?=
 =?utf-8?B?VlBnSFdIdllwQkZRTzAwQkJoV1V2N0FKRFhLaWtXQTNqbFp2Z1R1RjVDWGly?=
 =?utf-8?B?RHRDZjdhbFd3dld4aGlKa1FwVUhuYjYvY3U2b0xWYkhCZmNxNlYzR3FLTFZY?=
 =?utf-8?B?RVYxc05qdFlvbTJreStmVHgvRkNtYjg2NnkydU5ieUhCVG5lQ0p6N0RqWnZs?=
 =?utf-8?B?cW5KM2wvLyt2K2hRQ2xveFE5Z000b1lKNFZIQno0dWtSTDNpNU9TZmhaTkV3?=
 =?utf-8?B?RS96bForMUM1dm9ISlFoU1MvWGR1eVFIVjhIVkZNcms0bEdjSXF0MlhET2Jt?=
 =?utf-8?B?bFhPU2dBZjZCSTA0cDhianYvNFZNVGxQclRKNndaT2h5ME5qQlRsc2hQTG4w?=
 =?utf-8?B?MHBPblYyZVFOcUU0ZzJYcCtnazUrZCtpU2h5MXlUYTIyV25HMWNnT1NoQ2pk?=
 =?utf-8?B?OGZMYUU5RmRqaTZaSTBlQ0J4aGdEK1JkcFRteWkwWjJJM1daT0lIdmVoak9X?=
 =?utf-8?B?elVxemI2NHB6RzVTR0MvWEtaZ2dDUTR3M2ZpMkFYd3JXRnZuWG9NdnV4bWhu?=
 =?utf-8?B?ejJGUnFmejBhUEJHang2MjlkRVlMK2VFVkxscVg2Q2NJUlNjcTI5d2pKRGwy?=
 =?utf-8?B?aytWcHlvVWtxcCttdkI1cTQ1L2VRSldLWlBabHIvamM0WlBYNnJqQklkRWJs?=
 =?utf-8?B?WUN5U3lQOGpUdW1Hbk16NVA1WjJvNitXTHVLaWRLZk44NlBDamJiUWFPS1ha?=
 =?utf-8?B?Z3FTYlVVYit5dU8zWlBJVDFRbXlhZzhRUXNiaVlQREUxTkZ0cWlpUXQ3Ly91?=
 =?utf-8?B?REZZY0svd3Q5cnZUQ1Z0cC92aHZMc09WbzNpWkRDWU0rWHFlVkJXTERlY3hi?=
 =?utf-8?B?U1EvRGpDeEJNODJzdkdkNlpHVG8rN2krZFVIQ1ZXa2J5VG9PUU5SNlp1Z2hU?=
 =?utf-8?B?S2Q0K2RCNTFNa1UvZUN1YU9kY2tUNzhxQVI1UDVFMFUvYVdrcFQ0QUR5Wm1M?=
 =?utf-8?B?QVVQcG5yekpxaHNBZDJQV3NLU3VPK3d0Ry9VcmoyeDlEOHBTSU1MdHFGSFh1?=
 =?utf-8?B?SGpiMG14M3lLTmZXOUR1VlJlb2VtMG9FZ2xWd0VVSnhFY25ueEhqSWlFRmZR?=
 =?utf-8?B?aC9iWHNoM0Y3UmV3dkRlY0xqMVJLdU0vQ0JtT2lmNGhDYmh4Zlp5Zkpjd25I?=
 =?utf-8?B?NE1uTUpmcExrTWt2UjBNR0Ywc2poV2xmR1c1KzNTbzQyOE5YOVk4eVB6Ky9v?=
 =?utf-8?B?Q3U3VnpIZUN1MFlsa215b1pyQWUyb0NqQ3ZTaTE3RXFSeHY0K0srdHNMZmFG?=
 =?utf-8?B?Rlc3MlVQS1ptcGFqVTYyUStLUk12K1Y2dlBQOWJycHF4Ni9OZTI5OFgydjJs?=
 =?utf-8?B?WVpRdWcyL0ZSaXZWRk1XaG4zYUhUZG41d29xaDVvODdFeVFLMHFMRDlBbnZU?=
 =?utf-8?B?eHN3cEgrM2NwR1ZYcnhoSlpoWEhKbnh6UTVGMzZTMU03Ujg1Y29aZDFkTjdC?=
 =?utf-8?B?T2l6ZWxrMjdCMlg5QlNrNGFVdE1zZ3pIQlBLVC9wNS93dWJOVFJSWFN2K0RQ?=
 =?utf-8?B?QWpmZkdaV2xJRU9uUzBYOEFRMTVVNk5TMHdmUFI3aFdLQVNDM252SUwvTWI5?=
 =?utf-8?B?N1Y2OGV1ZlVLdnVWbllZNXFQR0hsV2ZuVTJ5VEFPb1JHeGc3d3c2T2dpalFO?=
 =?utf-8?B?cmRYa041SjlJcVU0U1FsREdNRFUxdk1GMkNHN1g4WlZCVkxiZG9TUmxxMGx0?=
 =?utf-8?B?ditFTnFSNjJKblRYR1g1Y1UrL0pFU1RUVXkxTURqYkVwUFdtS0djMlRKVkJs?=
 =?utf-8?B?UnlPMjVtZC95bWhUZnNEK1U1b3FUYlRMM28vOFE1ZWE2dUpDOHYyM3FJUjlV?=
 =?utf-8?B?a1krUEZQVDBSSE5jdEh2ZzVmeUticVVNRDhJS1QwS3RiNERITXZoWVdxUVFw?=
 =?utf-8?B?aFMySEY3OElldkxRNDYxMnN6ZU9wa21ORVI0Yy8wUUpGQlhtQ2k5ZVZOQ3d1?=
 =?utf-8?Q?rAVjgH5SgOB83u2gi4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e7fe4a-450c-4fa3-17f7-08decc56deeb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 09:57:41.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiJ421+bNCGd5nxWQmW9Q8E5RxQYaHKwSpwN2d/DShX1Tzpp+Eq6LfuDEckZ/xhf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A

On 6/17/26 12:16, Nitin Gote wrote:
> xe_dma_buf_create_obj() creates a ttm_bo_type_sg BO whose resv points
> at the exporter's dma_buf->resv, then dma_buf_dynamic_attach() is
> called. If the attach fails, no importer attachment exists and xe does
> not retain a dma-buf reference, yet the BO's resv still points at the
> exporter's dma_resv. Since sg BO cleanup is deferred,
> ttm_bo_delayed_delete() may later lock that stale resv and hit a
> use-after-free.
> 
> Fix this by reversing the order: attach first with a NULL importer_priv,
> then create the BO only after the attach succeeds. The
> invalidate_mappings callback treats NULL importer_priv as an incomplete
> import and returns early; at that point no importer BO has been created,
> so there is nothing to invalidate.
> 
> If BO creation fails after attach succeeds, detach and return the error.
> Since get_dma_buf() is only called after BO creation succeeds, the error
> paths leave no extra dma-buf reference behind.
> 
> Tested with igt@xe_live_ktest@xe_dma_buf_kunit on BMG
> 
> v2: (Thomas)
>   - Reworked the fix to avoid creating the imported sg BO before
>     dma_buf_dynamic_attach() succeeds.
>   - Attach with importer_priv == NULL and make invalidate_mappings ignore
>     incomplete imports.
>   - Keep get_dma_buf() after successful BO creation so error paths leave no
>     extra dma-buf reference behind.
> 
> Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
> Cc: stable@vger.kernel.org # v6.8+
> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
> Cc: Christian Konig <christian.koenig@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_dma_buf.c | 42 +++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index 8a920e58245c..9fc4c5484519 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -317,10 +317,19 @@ xe_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
>  
>  static void xe_dma_buf_move_notify(struct dma_buf_attachment *attach)
>  {
> -	struct drm_gem_object *obj = attach->importer_priv;
> -	struct xe_bo *bo = gem_to_xe_bo(obj);
> +	struct drm_gem_object *obj = READ_ONCE(attach->importer_priv);
> +	struct xe_bo *bo;
>  	struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
>  
> +	/*
> +	 * The attachment is visible before the imported BO is created.
> +	 * Until importer_priv is set, there is no importer object to
> +	 * invalidate.
> +	 */
> +	if (!obj)
> +		return;
> +
> +	bo = gem_to_xe_bo(obj);
>  	XE_WARN_ON(xe_bo_evict(bo, exec));
>  }
>  
> @@ -365,31 +374,34 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
>  		}
>  	}
>  
> -	/*
> -	 * This needs to happen before the attach, since it will create a new
> -	 * attachment for this, and add it to the list of attachments, at which
> -	 * point it is globally visible, and at any point the export side can
> -	 * call into on invalidate_mappings callback, which require a working
> -	 * object.
> -	 */
> -	obj = xe_dma_buf_create_obj(dev, dma_buf);
> -	if (IS_ERR(obj))
> -		return obj;
> -
>  	attach_ops = &xe_dma_buf_attach_ops;
>  #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
>  	if (test)
>  		attach_ops = test->attach_ops;
>  #endif
>  
> -	attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, obj);
> +	/*
> +	 * xe_dma_buf_create_obj() creates a ttm_bo_type_sg BO whose resv points
> +	 * at dma_buf->resv. Do not create that BO until attach succeeds;
> +	 * otherwise an attach failure can leave delayed_delete with a stale
> +	 * exporter resv. Attach with NULL importer_priv first; move_notify
> +	 * skips incomplete attachments.
> +	 */
> +	attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, NULL);
>  	if (IS_ERR(attach)) {
> -		xe_bo_put(gem_to_xe_bo(obj));
>  		return ERR_CAST(attach);
>  	}
>  
> +	obj = xe_dma_buf_create_obj(dev, dma_buf);
> +	if (IS_ERR(obj)) {
> +		dma_buf_detach(dma_buf, attach);
> +		return obj;
> +	}
> +
>  	get_dma_buf(dma_buf);
>  	obj->import_attach = attach;
> +	WRITE_ONCE(attach->importer_priv, obj);

The attachment *must* be fully initialized by dma_buf_dynamic_attach() before it becomes visible in the attachment list and the WRITE_ONCE() here is not even remotely the correct memory barrier to do this.

This is just asking for a race condition which giving the private data as parameter is intended to prevent.

So as DMA-buf maintainer I have to reject that as incorrect use of the API.

Regards,
Christian.

> +
>  	return obj;
>  }
>  

