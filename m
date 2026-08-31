Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5043D5C1D;
	Mon, 31 Aug 2026 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166899; cv=fail; b=guOc7s4EjW0OSNRHoH8vddvjjzvNXNlOP0w3gZLhIQuG60Xo2FJsJAzqyMJsAVeyVNU/nqTsVCoBhCno9JuVW443GWTHxHU5PXgPPsu5gzFvtk5qgOeIg+Bl2t5GZ4kmzHJYfXAKTwV3L4P1zl0H4q2adK0UaU+iFAJqTbtjjOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166899; c=relaxed/simple;
	bh=gQboNW4ItGiMzAHnAAx8sHFwUIQZc6zRW98dGmSNXRY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U1wwvBwmt0ZFBx2Own+bA3ful37yjxrHOWDE/XLzRzYVaBkayUeNshziPfdSSqMb6yR00Wkbq+aG+ao9eHqwjfoSuWDN1K2mGP/YsAKKN+FdOOJ+HT17dKVgKTqsIoTCSdhAqR4p57qfkVAXqUFfLUn/cHaE6+/fR1wnQxTNFQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5PvTI2V3; arc=fail smtp.client-ip=52.101.62.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5PvTI2V3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3ve05jTKhn1AxKToH7hoaH4PiiG8O2lPyV6KTjyytG/7WaHxGdj272eRcBTEuUVLEfRy2V7W+JCOV3mshWfv7HOVOqpzfEhJkzDLh8UPyrdcf1DNEXoJUHQUVuZp2w9POtYBaVrDyl1jFYadPsDmNDhtckUeoAV82T6CMay2ZdNyX9WTYytDCsZV1avTRzGpQ1sKyqZc25hle2vG6rjqSh3C3vHoUTbOqdqT5gItYi1uNyk8LCCqa/9q4qnQNdmjr4z3L94ElOl2MQj8iDLVEhHfUcWEsruv72j70s2781B6GvqGP94X1Bir0vfInTpyAnqami5p4Dh0KXI3oyC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PapCkqc8r64UqJJmvHzUJECWkknjTTpiJblKoGoSiYE=;
 b=JnrJH7e8CmcxTNJLBwKqrU3dz0xPBAvuTADBDYjlEV9d2m0Q7HGgIdhregEaWFzpRPNuD/WKOJl52yiklwpZEsdxvLez0cl9SyFZHzuGMizNOPAsOWyDoK/Y/jhe6WOBS399unmqd4Tbw96KG7vFM1B9wpyvyfmWK5h6Rq86K2GP9KUu310n/OFhzZIX7h5SIrkSoIbI4/9kmMVK5yzSPHEnvS4hQ96RXurc4XU1gvj4nnUuEWAoHMO9kNWIINkfpBdd/d3dXfN+p1jrUTwjaCyGwZExcSczYwlZoknGde4XUrYGM9KjN29FOreRQm8JP6VEbAxOZSnRSxp6Cn4vEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PapCkqc8r64UqJJmvHzUJECWkknjTTpiJblKoGoSiYE=;
 b=5PvTI2V372TAfaC78u1dU5ML47GqlQX3ZHugR3L0dMr7xxwVelyKbu/7CtZY5ySBZXcIgBlv0/PgtF6exZW8OPPmUo2DmMohSSF+MmDrMqkSesKx9wJYlAWXmX7oEjXrF56riypkP85suQXkouTbD0qB/t61AmH9zywItYeCnrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 09:01:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 31 Aug 2026
 09:01:35 +0000
Message-ID: <3abb966d-6a9a-4c00-9c51-687c8601fa5c@amd.com>
Date: Mon, 31 Aug 2026 11:01:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-buf: fix some kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20260831031956.3410813-1-rdunlap@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260831031956.3410813-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: 537a22f7-71b3-4024-7de6-08df073e7578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GTNEEdewXZg0OB0uB4BXsX+ZN5Q38H7iFrB7sn+AMscofbefJJ6IMzHfa/oravD9oa2tMGaXkLP9prMKBy+JVGWgKfIh9gRN0OTUvPqMCLr2xIUBDnXQuAqBpx+069ffM1kWoARiXPPX6N2Bu6zv2SNQi8yL3UiPWzlfK0oIeJiZSCvfWvHFJMiDZJ96VMyKGeaa457L2aM7ciCye/roI4GeEAwckZgXlDfu1b3VfeeyoeXmJPuyq4al7yI36fyiMBY+cAfd8q+ylxR6KoBTmrwJlf+fiaicsAQB3ZOMVSPtfMtonTgabltTLPzJv6F/Xn+PHQvL6UMcNgldr6Q1KHTgyHFij2tduqUepBgBdzlYbSbiUzL52T228E0B2MJ0sj5CDJFqeWsAuOUiWNgxxGFL5f+DiiYjexcH0mDQklSGMFOAlUl2ivcAxLBK3uqqplLI6/smPXxFR8y4hMLMuHoJOXKzExZzaVhNs1Rsr8CH2mk00TGE9AM51gvvoAUNHvPfpXTym8emEqSuG8s/N8O3X87S8iSS8voi339isjnrVc5n65USbVWnIxqOpxxSfVHKVviR/mD0KNzAOsvbZs6MVRfQ1NF0Q3yLHWIw2FtQfZbG0F5p+5ULS/mu1Zqv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1lkbzRDNzBkaW1oSDlqSytWTHpTWHJEbCtUdzZuOUFjZHN0bzJ3L1pIbXlu?=
 =?utf-8?B?b25NTWxrMlA3bnJSRlVtZDdhemh4L2dFRGhqczE1QmcyUjZobGg1U1loR0Vm?=
 =?utf-8?B?U2p6ZnVrWnd0N0FPMS94Ry82Zks3ekJJWFo3UmYxQzFtSUxCbE8xSnkrMTJv?=
 =?utf-8?B?YzFoUDJmeC9yNHhEQndwY09oQVpjb0JIeWsrTzRHb0NLSmIrbEhJck5jUUVk?=
 =?utf-8?B?UzB6b2ExUlllWlNkNk5Ib2NZcXd6bnBESkhwci9xaWNjMXhZY1NZUFRjeVR0?=
 =?utf-8?B?TFN6ZHY0SjVRU0FSZW1iYU84ekRCcHE2bUJ6UytOWWZobXZhaE9WNm9VWEJj?=
 =?utf-8?B?WHpES3RETnA4RkdSdkV2MGRucTVJNVJ3T2RqeGRhMk1Fa1JxSG5FVFRpdGt1?=
 =?utf-8?B?RVhJelgxTWk2V1BKRmpUSFZ1SVZFWHlnQWwrM0xxalFKemwzWk9JYjA3Y0gz?=
 =?utf-8?B?WlQ0dlFDclUvUFRoV2krT0U2YkJMUXh2YmtyOVp2SytVQXUxUjVuaVMrajQr?=
 =?utf-8?B?dEZLVkRWa2R1RjNaRWtFUlhlT2hzamgrbFEyNG5hNGUwaUtVdkdESmNkeGRK?=
 =?utf-8?B?MHIxdC9SUFkrYXVRN1NyUW1qcDFWRldLaytYUnFpTUluaUJDclN5MUFlQVJ6?=
 =?utf-8?B?VytCRkJjT2RBRitjYU9mQ2pNbWFZWDRTa3d0Y0pycHBhZHB0ZEEyUFRNVlI3?=
 =?utf-8?B?L2lQanh4cVU3dk9YQ0lqamE4R3JJV1BtdG9IU1hUdXJ4b0dhQVRXSVA2KzJW?=
 =?utf-8?B?b08yRWI0bmhzT1dzSWNMTnY1N1I4dVFGLzhQUGF3d2tPSHFRME5kZE1xakVN?=
 =?utf-8?B?bC9zWWxJRENEUVcvOTdreUM0Rk0rbmxjZFNraDJCUEtOS1RPaHlldyt2WVhM?=
 =?utf-8?B?QlN6c01VRGlRejZaNmlaMFF5cG0wUHNuTGNkUDBlRm9Lb3U1RVJ3Z3dETEJ4?=
 =?utf-8?B?cGlJT2lDYkZBaWluUXh3RXdJdXZBY011UjI1TnNidUtLenpPZTlnOUNyeTRT?=
 =?utf-8?B?VnZvR2cvZzBwVmoyRDFWeWRnZFB6L3U1clhqTGZWRWNCQ2o2Z1RrOUIxc2wv?=
 =?utf-8?B?R2tWUkxlUVhCSDRpLzJKM1gzUStIM240eEVRZURGbmhjT0t0cUp3MU9QMjh0?=
 =?utf-8?B?RFQ5WHhtMTlnT044UWpsaTRqVXVlakZ3d0RyeDFyMElIMGtnUkpiNmpTR0w5?=
 =?utf-8?B?YnlkR2ZGSm9Cckt3S1BPUDdKckl5cVZMSmk5NVFsYUl2UGFTRXJaMkZMRVd2?=
 =?utf-8?B?Vlg1L0RQemtSZzUreThiWndGY1hpSEQ1RWprdkhEc0c2eURKYnVLLzJadlNY?=
 =?utf-8?B?R3Q1RUw0bzdPanc3NHUrUXBmdnJHTDBiVHJRYjFuTTJyTkNScTFjZ0JWTzN0?=
 =?utf-8?B?MjRmTEsvRjJnUVBLelFPem1LNHcwNnhWNkZ3aEJJNEJaeDVYc05RTmNJSjVZ?=
 =?utf-8?B?L1c5MWdMem9rY3ppOFRaVjlvblRjdzVFeGpGMHBKSFJyYURVSUhXclZMTFlF?=
 =?utf-8?B?OXJtY0QvaStYRzJ6Um4yTUlUNlZpUXpHMmFhMHMwb0Z5UER3MGNhWGdxZHJG?=
 =?utf-8?B?dUt6aTNBTWpCYklkVkNNYVBQRVFJejQrYjludEM2RGo0SFBrWUtBWjlKa0pP?=
 =?utf-8?B?N29ObUFxTVp3OExlM3VLRlh0WC91czV6VzZuRjNqVXAxamYxZ05KbDhjakxr?=
 =?utf-8?B?ZDNMUldLQXIvMXBQSlZURGR5eGJ4MnQrdXRIbWVFL3FDUUNycTFxS1M4c0M0?=
 =?utf-8?B?MHEwOWhLT3EySk5yTENuSFVta0xCNlBHcnVud0laN3NUV1Z5UlAvbWpOaXdY?=
 =?utf-8?B?bEc5Y3N0TnErVVlFTFpsM3JJMVRQZ2hIK3lBdTRua0FsWDg1OGJ4TVFURkIy?=
 =?utf-8?B?ekhNR0N2Nm5mc1hqNjg2a0VoOW05S092TlJxcFhoT0ozRkRuQW9NZEUxaDZz?=
 =?utf-8?B?ajNxVCtmejgxeWphQTdueUpkUE9peEJ5WktEUHMrYVdKb1BrbUZpQ1llRjU2?=
 =?utf-8?B?Z0lrSmc5ZXc3eUVjY3pmYVR0M3JldURRV1k0UWRqa0ZlVlpRaTBhOGxiRU9H?=
 =?utf-8?B?OVZrajF6NVRiUy9vZE55c0xjUEpkOGZnU1Jnd2hBSGF3TzExNUMyYzdYQ0l2?=
 =?utf-8?B?QkhTMHlmd2xXUGpGbHc1MlVaQUFtUC8rSzNVem5Oc0YzSVZaa1lkcVhadEk3?=
 =?utf-8?B?Vkt1QXZKRWtsaXlRditYdnZwWkoxNFlxNFhoN3VPYStXNHZHVkRiM1U4cUVX?=
 =?utf-8?B?OWVhbjlGcVUyUE9HWTdCTHRkVFF4Y1BpemlMcUwyRHhFRGg3L2N3U0FaVjVk?=
 =?utf-8?Q?x8nbccuP1Zfhxc5Dpj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537a22f7-71b3-4024-7de6-08df073e7578
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 09:01:35.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeHUJahwiV+8VMt97JrTduOVH7JEfW0g40NylgJzVEdgokTfnHE4MtGAmyV3H6mu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175

On 8/31/26 05:19, Randy Dunlap wrote:
> - drop Excess description of @lock from kernel-doc
> - add missing function/macro short descriptions
> 
> WARNING: include/linux/dma-fence-array.h:47 Excess struct member 'lock' description in 'dma_fence_array'
> WARNING: include/linux/dma-fence-chain.h:48 Excess struct member 'lock' description in 'dma_fence_chain'
> Warning: include/linux/dma-fence-chain.h:82 missing initial short description on line:
>  * dma_fence_chain_alloc
> Warning: include/linux/dma-fence-chain.h:94 missing initial short description on line:
>  * dma_fence_chain_free
> 
> Fixes: 5943243914b9 ("dma-buf: use inline lock for the dma-fence-array")
> Fixes: a408c0ca0c41 ("dma-buf: use inline lock for the dma-fence-chain")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed and pushed to drm-misc-fixes.

Thanks,
Christian.

> ---
> v2: rebase & resend; add Andrew to Cc: list
> 
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: linux-media@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Christian König <christian.koenig@amd.com>
> Cc: stable@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> 
>  include/linux/dma-fence-array.h |    1 -
>  include/linux/dma-fence-chain.h |    9 ++++-----
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> --- linux-next-20260828.orig/include/linux/dma-fence-array.h
> +++ linux-next-20260828/include/linux/dma-fence-array.h
> @@ -28,7 +28,6 @@ struct dma_fence_array_cb {
>  /**
>   * struct dma_fence_array - fence to represent an array of fences
>   * @base: fence base class
> - * @lock: spinlock for fence handling
>   * @num_fences: number of fences in the array
>   * @num_pending: fences in the array still pending
>   * @fences: array of the fences
> --- linux-next-20260828.orig/include/linux/dma-fence-chain.h
> +++ linux-next-20260828/include/linux/dma-fence-chain.h
> @@ -20,7 +20,6 @@
>   * @prev: previous fence of the chain
>   * @prev_seqno: original previous seqno before garbage collection
>   * @fence: encapsulated fence
> - * @lock: spinlock for fence handling
>   */
>  struct dma_fence_chain {
>  	struct dma_fence base;
> @@ -81,9 +80,8 @@ dma_fence_chain_contained(struct dma_fen
>  }
>  
>  /**
> - * dma_fence_chain_alloc
> - *
> - * Returns a new struct dma_fence_chain object or NULL on failure.
> + * dma_fence_chain_alloc - Returns a new &struct dma_fence_chain object or
> + * %NULL on failure.
>   *
>   * This specialized allocator has to be a macro for its allocations to be
>   * accounted separately (to have a separate alloc_tag). The typecast is
> @@ -93,7 +91,8 @@ dma_fence_chain_contained(struct dma_fen
>  		kmalloc_obj(struct dma_fence_chain)
>  
>  /**
> - * dma_fence_chain_free
> + * dma_fence_chain_free - Frees an allocated but not used
> + * &struct dma_fence_chain object.
>   * @chain: chain node to free
>   *
>   * Frees up an allocated but not used struct dma_fence_chain object. This

