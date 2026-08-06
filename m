Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6DC47127E;
	Thu,  6 Aug 2026 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016361; cv=fail; b=dVVsaGJcMnd9EQ+YTumPycaUzfhYY0PBE3GbJft7w8IQMhjo7VKZCsQldlriGWLDt1yAr1fH3BEwS0DfR48bhEbTYqET0TRu7/Oy6vuFf3DE2IoYwJhv5iH2x39gkO9IH13MFeSDjiC+xXflXWS4oidgBWUFKGT7KgOdXbhpvDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016361; c=relaxed/simple;
	bh=icHwamyuR3a3FtnsqhJnzU/2+r3eWiqKwqUsddxPE+A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N4j0Mm7KUk5vNZie86Yprkv2ehkycLd/tFquLjv4adQeC5GwtdVKa5k4Y2WCiGoZ1umCZabj06I6rM/QJ2DxfMzzexiKVXxataA5d6DW2rS4MOh5tUZtoGBSZu0kscI4uA8dcPM1p/CEu8SrYkxsCqiPBco7sSpenIWOTGyrUao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LhIkyQa3; arc=fail smtp.client-ip=52.101.61.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LhIkyQa3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYlTB5fqGHSk6fyWSkmvUlKBFJ4wVXHwDLAiGPwb0YLIPNafkdbQIMgL2T4vwHn00ZTzypbREdrT5C3mHg1LtchSEo0Om+/I9MOPQ5PGMNnpMRbFXdAeuJB3oer72uBVswZyxV5Ve2pA7deSizW9OjqkYIn5v7JpHGXVxGM7Yy7H/VVzFGc26ZRy/ETMUKKvTKUK33o2nfGStuqq+DkGaSQHYxuepuD3TN5bhVEGRbtuhPiAo6mq1hk0XVA8A6ea1EVnR2nY9+vyHF7ZUdEfpdPKszEqFz4tvCwq/9oZPNWjpzmeKbcPrah2xKgk5VurSMEhMuJW6cRSEaaffA0Vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBMVizR8HWKhU4KUEWaQ3bnap7Dnh9iSOvsfUeDI95A=;
 b=wPuOYWx7ffFALq6TqaOfkYc+sF/Vz1DD46/UyCG1xM1KbJTiitEIBiwXhKZmmKrzY0TU1jAd+C2+xLK+Vzd8glsyYBu+6dGNCG0U8x5Bw+DXeygjc4TH5xbyrvjfiWFojO5WCar33pX2aY9PMakus2MZWDQqIs2Nxqs5fGjZRpRGvXrWEwIwzaq1BgUdl6bPswyfzm4qSzBh8oFokhfhTETDKKMvUxPGu0e17qf8ISb+Vl1UsTddUbYpHulOd9SUvV7QaRIskIy1B8Thv18SPhSJsXEjQFw821fUBlutk5x+PKOMmiNGHDLBLCZfZ2P8cqyIRGk0berTdVPToqBrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBMVizR8HWKhU4KUEWaQ3bnap7Dnh9iSOvsfUeDI95A=;
 b=LhIkyQa3pJ2NVWYeGES/pZbb21G2Igm5AfkvVFeAKyqCEburNgE7h5Kj/g2h9bbLAk7jGQ3yLtfaSFRteHBSleO4FGI/Fc3+ZoUDIynPMmmSUkwu80IMVAKt36BnaMWukk+4rKOky2/AABktt1NePGIV8IN1HuGoN7SYD5UDwss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 11:39:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.021; Thu, 6 Aug 2026
 11:39:03 +0000
Message-ID: <92b02f98-8b9e-4970-a1f7-f3b2c0fcd2d4@amd.com>
Date: Thu, 6 Aug 2026 13:38:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: clamp the prefault window to the buffer object
To: Baul Lee <baul.lee@xbow.com>, ray.huang@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: matthew.auld@intel.com, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 federico.kirschbaum@xbow.com, stable@vger.kernel.org
References: <20260806034356.43681-1-baul.lee@xbow.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260806034356.43681-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ac4028-efd8-4e95-1505-08def3af50e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Xv0pYJpNCA2fK4JsU/+K/knzZ1vIgbr66r90F7wsz69EuREZV4D7hw6Wf5YHTJp1MZLya2LtSbri1vlG7SK8v16CWgKC6ChF+GPFdQhBAAXM067rmIKGXw5fhdZIx9N8//bfQbpFd3KJ3cOxhHdlssSYDeSoQ93gxCFoZB14hn5O7QhW6rJagHUFUys44Q2YZw7s7Dt4ulLPXwRHqqRdq+iA4JVf0sBtWKypjBFdrRBzA/fUplgHPdZx9GSYrv9xBNzVvTmbJzTx7lYThW67HvAxCQjvVAdzCPBgu3zEBYIPfuPB5CcvNdstOOAVXqlYYczvfqtOGJsSqMOFMgtzS+bgvAunP94TOQYO3zAwVNHJmcbZnl7Sf1Lm6EAD1znQtlwBFP3gsl9XIDQQ9rz50sNNaSNfaesWCZyubUb3wivG/s5RQVpDP0N9J9Pk1R7D5Sij/uTy/gh9PcaWXLhe4Eb2FCXqhIyJVMp/00f0IyvCqdJ10SksnuvTAnMF+EI9mvxWuO5CjpJB6BN7v+3WFd9V/7gS4EUVgT0NWSI0Jztf6z3A/hMl843fRi8I783hTEdijPDIy/lj6nxmg69xNeWPzGUuWjrDxfzizzzabRGizFPkpJd1oeGYR2wToVEXSxwocvwMtODZ1FcWmFR8Wgjlz9tiigFfanKeiBzeCrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R28zdS9GZFk0NU5xekJ4b0gzQW9kUWxUZGxSUHFNL2xWMC85NmIzU05aSWh5?=
 =?utf-8?B?aVBiMG1sMDVNOEM3TC93YUlzWWNRcXFoUjNjZXMzTmo2V2ZSc2RVQ2tlUU5O?=
 =?utf-8?B?Ykg1ZHpvbE14V2dsL0ZUdmlzS2gzeGp2bmdZQU1RNjVkaVBsRGtwQys0S2ZY?=
 =?utf-8?B?b2ZGNTNYcFhWczJIMHZGbEZQQWxOMmpSNkxTZ0lnbG9xVGZhU05YbDMzUzRi?=
 =?utf-8?B?TmY5cGVRNW1RUmNoVGxjMDhRbXREZlVwWVJJZWdHcUE3QTdpTldFUEpKeHMy?=
 =?utf-8?B?NTdNblVoVmgzam8zL1NickZCUktUaXZNN0wwa1M3eUdrcnhVTnVTbnQxN0Zu?=
 =?utf-8?B?dGRKRDlmc2ZMVkRUTkFRbjl1WjdLcUk1NWxyc3d3VFg3b0xxK3BUVDZQM1pL?=
 =?utf-8?B?QkhJY3AwdWtlQ3ZyOVFIUUFLMG55MlFJYVdycE0wSCtHd2x0S3h1aFVJR2lE?=
 =?utf-8?B?MHlkRWxqTi9FWG9GRytodnNvTGJaQ1oweUp1V2ZmNFVnZFIzL3VaU3RmM0lZ?=
 =?utf-8?B?ZUpvVDdtVDFJNHdldjAwemdYQkdGVGxpclZNcEdFNFA0TG1CL2xvZkdGUE9E?=
 =?utf-8?B?aWlSNzZ0TW9sWlE4eXBQZTBmdHVBTUMxMkVMRUJXeDBVYnNaM2pIaTV0aGJT?=
 =?utf-8?B?WXNadlgrQVlLenNtWlVsOGZvTGtOSG4zQ2JDc1owZUM1ZW1hdzdPeGhCajRs?=
 =?utf-8?B?VVVuWGJkcG9VdjU2alpnNkhWSVNrVDhIbkQ3WXpHcGQra3lpc3BybGNramRE?=
 =?utf-8?B?NkkrK2lYT1pzMTZHYXI5ME5IZmpRWGsrejBKQVBIUGt4L0Q0dlB5RVR1UVZL?=
 =?utf-8?B?Y0pZYmVQSmdQb3ErdUptSjdpVklaU2VIcjhLR0hSdGJVSDZQejQ5NmU2bTNX?=
 =?utf-8?B?b1FYbVZMc0NvaTk2SWswa09Jb1ZYTEsvWFl2VUtpZHpIN1M5ZGlrc0YvUG8x?=
 =?utf-8?B?Qk5LeFZNTDVvQ1Zlall2ZkV2c0lNWHdYeVE1Z1RhcFFibUJyemRLbUpYbld6?=
 =?utf-8?B?QXIyTVlFYytDNnhEWWhpT1pKbk1nZld1YkthL05vVHBhQzllR3RuR29KdlJU?=
 =?utf-8?B?TVV6TytzT3JGNEtrdG5PSUdsREw2V0dKZEhMMzN4UWxmSlpRY3JHQUtucDFa?=
 =?utf-8?B?NEw0ZTR5VHNBckhqM2diM0pVRE5jNmxwb25rTVVyL25rNkZabmJwdHo0dUFG?=
 =?utf-8?B?TzNRTjF6RCs3Ykk1ZXJycEhRTU8vT0RtbGNKejNWSFNaRkNZQkZRNUhncUl0?=
 =?utf-8?B?c3dQYm1qQUFoRVE0a0dCZE5nUGdhVnd2S2N4MW43cG5FNDIza0w3ZFRFUHhq?=
 =?utf-8?B?dzdPVk5nV1pjRjRMK1hScDhaNzltL25sQnRzNEptWEJocUNabFk2bm56UUh2?=
 =?utf-8?B?Z2JZb1pJMU5Nb29hbW9xMStjVkV6WXZuVkhxV01YWUVnTTNTeHFFUThIRTZn?=
 =?utf-8?B?L3Jrc09LQ1lJWGIvNzBDamx3WFBydHZPUjNRRkJ3aXo3Z0NoNVBDQmVSbm92?=
 =?utf-8?B?Ui9FUnRONEs5NlRxNjJiTElkSnprRVFQdHJrUmR0dmlGdjB3Sm40YitBQldL?=
 =?utf-8?B?MEMxbzY1Yk5mbEw3YmZDbmdyMmE1SUNSdG9FRWtrOXRVRzBvbnQ4UEM0dUN6?=
 =?utf-8?B?MDhHT3FqNTluTDl0R0N3NzE3ZTZwWGVkQ1d6SjRLVW1yMkR3dWJ5KzE5NUYx?=
 =?utf-8?B?L1ZFYkkvRW9iYjQvVGpWNXVXVVNJWFQzaGR1anpyajd2b1VRS1FNTmZBWGRF?=
 =?utf-8?B?RytvVlhYTDlyblZHK2pmRVBFVWEwNW5STE1OR3F5bkx2ejNHL2NQL08xUjI5?=
 =?utf-8?B?NVpOUDNsNW0vREFDSmNRMmV1MmczaDJHWFM0a0VSeGVWclRYSWlIVzQzT2Zj?=
 =?utf-8?B?aXk0ci9sVjM1MkdyTWcvMjYvd2pHRXJLcTliK0lHR1BVend6cXN5MDQ1UjhJ?=
 =?utf-8?B?NnZSQWJGYW9UQkRkT1Q2MCt6eWtlM0ExL0FJMmxkSHBKWFcxcDk4d3d1M0J3?=
 =?utf-8?B?Z2JKYzcvdHZnbytINXNSWHpPS0QrQ0swMU9yWjZXU3h1MVpnU0ZZOXYzWkwz?=
 =?utf-8?B?TkY5UHdHV0NwUVRtUUhjb2xpby9rcTNKRzJ6c2JSd2tiTzhDQjd5MFZNSUFO?=
 =?utf-8?B?ZmFPZzNvbmFBdHE1dnhZdTIrSTlIRG9hNTMydnJDdkVsdDZFZDlzYWpPYnpJ?=
 =?utf-8?B?dXhNYy9DSWpNQXAvN3R2WEdHcTMvNFoxMkZtMGpKQzlPQmtjNWovQXpNUnQ4?=
 =?utf-8?B?OWhHaXFnZ0kwYXRYeVpvZS9MTXVLQmRDUHBNMFBCY0hHMkxIWXZ6U25DYmNa?=
 =?utf-8?Q?YOaDd2lR2PvkOm/XGY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ac4028-efd8-4e95-1505-08def3af50e7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 11:39:03.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Z/4g7heFFYLTkEHV+qzoyNreBnN3t8t8UY17aCf1walss+eWC3eHg1n8kX82Oj0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219

On 8/6/26 05:43, Baul Lee wrote:
> ttm_bo_vm_fault_reserved() derives two page indices from the caller's
> mmap(2) arguments and bounds only one of them:
> 
>         page_offset = ((address - vma->vm_start) >> PAGE_SHIFT) +
>                 vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node);
>         page_last = vma_pages(vma) + vma->vm_pgoff -
>                 drm_vma_node_start(&bo->base.vma_node);
> 
>         if (unlikely(page_offset >= PFN_UP(bo->base.size)))
>                 return VM_FAULT_SIGBUS;
> 
> bo->base.size appears once in the function, bounding page_offset on
> entry.  page_last comes straight from vma_pages(vma) and is the loop
> terminator:
> 
>         if (unlikely(++page_offset >= page_last))
>                 break;
> 
> so the object size never bounds it.  For an object of N pages, a fault
> on the last in-object page passes the entry test with page_offset
> N - 1, and the prefault loop then walks N..N+14, reading
> ttm->pages[page_offset] or
> ttm_bo_io_mem_pfn(bo, page_offset) and installing each frame with
> vmf_insert_pfn_prot().
> 
> page_last exceeds the object whenever the VMA is longer than it.
> drm_gem_mmap_obj() rejects that on the DRM node, but the fbdev path
> reaches the object function through drm_gem_prime_mmap(), which does
> not.  It is also exceeded by a mapping no longer than the object taken
> at a nonzero file offset, so the handler needs its own bound.
> 
> With a 128-page object mapped 192 pages long,

And exactly that sentence explains why this whole patch is superfluous.

A 128 page object absolutely *can't* be mapped into 192 pages VMA!

If we would allow that the driver side could crash extremely badly long before we even get here.

Do you have any reproducer which exercises this?

Regards,
Christian.



> one read fault at index
> N - 1 leaves the fifteen frames after the object readable through the
> mapping; on a fresh mapping, reading index N without first faulting
> N - 1 is SIGBUS.  For a system-memory placement the page array is
> over-read as well:
> 
>   BUG: KASAN: slab-out-of-bounds in ttm_bo_vm_fault_reserved+0x248/0x57c
>   Read of size 8 at addr ffff0000078aac00 by task e1/219
>    __asan_load8+0x84/0xb0
>    ttm_bo_vm_fault_reserved+0x248/0x57c
>    ttm_bo_vm_fault+0xe4/0x140
>    __do_fault+0x6c/0x2f0
> 
> Clamp page_last to the object.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: ba4e7d973dd0 ("drm: Add the TTM GPU memory manager subsystem.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo_vm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index a80510489c45..14ebf6ee3c47 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -212,6 +212,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>                 vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node);
>         page_last = vma_pages(vma) + vma->vm_pgoff -
>                 drm_vma_node_start(&bo->base.vma_node);
> +       page_last = min_t(unsigned long, page_last, PFN_UP(bo->base.size));
> 
>         if (unlikely(page_offset >= PFN_UP(bo->base.size)))
>                 return VM_FAULT_SIGBUS;
> --
> 2.50.1 (Apple Git-155)

