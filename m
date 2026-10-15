Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021078.outbound.protection.outlook.com [52.101.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583CD183CC3;
	Thu, 15 Oct 2026 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792034036; cv=fail; b=AvV62y5I7pdr5GrTW4FV2oYrlj8KxiB0QpeUhmljADSxXeruq/UtGto/fEUUuiwkSpuiKapuKsGrIN2XLRxghUO4AsKuPbHa1p2kkYiHwbua0KR44Amw22OxBnA6xZnTOn3TK+cvrmr8nJVD88bXep/MwINRRTuli2k4KQLXSqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792034036; c=relaxed/simple;
	bh=EUiJKL4sXDSSjX3LgxYLVEhlKWjLpXqaoQsPsjtzfRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MNHFvTEqCQNsXRISI9kEC9teaK1txIeqNhxGBVe3ktxuar3Ni0pG49Uxwwp1EnnF1z0h9xEcH70N5Z3w9EMcNI9boNQVfda+AMWAynhax/c7k6vsGhkvdr3I9UHZi9sDAy1f3/EJJ2dMeOZEgk5J6iooagHqsaZr6UBXSKCo0Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oV2miEhzrRVlWWtzmz/KsgTE7ZPyPvFfj4nob53Ywc7zZIMGOVH/Kbpd3eKLNjgpEmH0Uah4hy4Bcjc+qMgOsswVjAwvOeZoTuA7pSPITurwfvl0GPj4pP3CNDGR9G6w5CUVroCpu7rUlvISZ00GQYNBN/HTz2xNpkTav9LvjzeNZF2gbUNYkHmUW8DbPmsp8oJTsgOvr9WvWogVCYLY3gpQzFObPQLIckGg1vEZaKYfahgMFLg6qkX1pkeDJTWl65b1qbtxUt+YoAV6zFFv30TcItkbWEm1yMOyEc+SWJer4KN+KIDS02HemDVHK1AnC/HYinnQzrbUGR8RUs9yZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=slrQzxZJL//Undy73aEAf+CLdYf5GsmWTELOlXRCQDA=;
 b=PpH8YbhzZpc8lrTwPzmuyLMuzvoTzXtmezhBXMFys5AZWYmcK5BSHPpCe79kUjiMVx8uhYlX2HWpKo6ex35MV/+zznCqW2xIQb6UDeOTD/nv2tU82WW5+ErELB3P8kY0WIg2KoI63qnsh6m8Y611Bw1JZU3GG92J3LfkgZOLElMgXB1847nmVBfMdXa32ozt99cjqep08sFEoRGMPS38nZOQ+xFKGRMflxwvorG0NlixlN/xeoltEAFbkhVjR39fGpu3z326MCu+XRfr6rymSLtWCJ4zBy2YvOvYq/CwbcSJvmwB07M4G1sEml0CJSsiMMuXI8WWfSRChAcF74hmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b2::11)
 by CWXP123MB2789.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 03:13:49 +0000
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383]) by LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:13:49 +0000
Date: Wed, 14 Oct 2026 23:13:45 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk
Cc: tom.leiming@gmail.com, hare@suse.de, dwagner@suse.de, 
	frederic@kernel.org, tj@kernel.org, sean@ashe.io, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: dispatch kworker to housekeeping CPU when
 hctx cpumask is empty
Message-ID: <oedptybqueluvi7abnerr4zn4t7lnh7telsen75lvkzyp52nee@6jkbqf6gb33s>
References: <20261015020225.422107-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015020225.422107-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:408:fc::21) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P123MB6616:EE_|CWXP123MB2789:EE_
X-MS-Office365-Filtering-Correlation-Id: ab39b4a2-48f3-4fdf-e1c9-08df2a6a5500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|6133799003|10067099003|22082099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9ZWw2pAsJ8vltiRO3tlZhAWfJ0UQl8iEqdGnJMtVL3OH56T7AFumsdczcVHOrocGc8QRe2ScbRdFy8VRuZIEXBLVr9CbUlLmYPryFwd+TyjdUUqzEar8daWtzEltBsrXw320c0YiNBh4LruZEKQ/El9SCoLIZePzNa4PFu5eaIOA6PFXHLxJgmN5IQGWVHWrnOVjOlx5YqoLtcyYMVLUfNspkAJuw4XpjB/r6hX4zAL6dE3P2S7V9jAxET4g1KpmU03OTFltwREi1ndA5lp3atpBTYePdwm4AGhyoJIAZnRZb75dyVHpPJCyJiHgUC/PWeSk6g+7hY5d0HsqiyclkCsOSoS0VWYsabZW5guYvXXFc7dH1hVg8fbRx+b1muDYO1O6gq/94IWRqJhq8hYq5mT1evfivp4yeTBAPJWLyiLIDsdwDRO8ZnKOor2xpdzvB4uAxpAhLWQ+1AEXZY1udVnObKgmQdGpzbvYrl4K/jBKBQPhVcOMFbzkNxlOodA8eE75Rqk4YnfpYwOLXEO+erpsuPPZvFJw0IM1lNmM8XAoCsov7zdAiRam7KNCQv9wi4WzVyVOUgVjSEqwhjCsO9KATX/0awGd1g+ebO9cfF8YlC8gcrWX8C5ApWLcvYYj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clNBdGczOUxrUy93eEFiMkxzSzZTYzBmT2YrdlJoTXlxRTN3NnJUU1h4YVNO?=
 =?utf-8?B?QUNMNkpZSUZyc2k4cm9iVEdhY1lXTHB0bzd2NG91T2x5M01NMkJRdzF4N0or?=
 =?utf-8?B?SmZtOVA2ZHBEV2FOWTVubEt5TnB2bzluMElzOHJGQ2svdXNBcGRVQklaV0Vi?=
 =?utf-8?B?ZDhmMDE2aWw2VkI3WTZJb0FzQVdMcjNSWERKN0ZpWkt1WEVha3pUU3hNNEhq?=
 =?utf-8?B?OHk5T3RKWHU0U2YzdFdiTHU0dys1Y0lnQ2lKeEdxM3R3a0VaR25yZ2FqUTBJ?=
 =?utf-8?B?d2g3NFlQSnVYVUVaV0h3SXVtT0dqeWxUdlB1Y0ZoZDloK3EzUWluQStyUERn?=
 =?utf-8?B?bklyRkJUdnBvdE9ZTXpHc1ZpTDBxUkRXdkl0aHU5Y1g1c3ZzTVV1c3BMVnlw?=
 =?utf-8?B?TEdiMUJhbytVQWhOc2oxVEhQZEQ4MFFLMDRQT0pYQm9tZDdIcVpHMmdNVVV0?=
 =?utf-8?B?YWYzYmx6NmVUdVhKTnZRRk9LQ2JhTWdkQ3lncXMrd25tdGFyc0RYVUpFdGpL?=
 =?utf-8?B?WEl0YjJYR2UwWVFpVlI1c2Y5M093UkFzenJvVCtQVURsU2tnWDNLT0g4ZjFj?=
 =?utf-8?B?eGVjdUt4b3NNY2ltTG9zYXhKWjdOV29IYm4xSmFTZ24xRkoyNkRvR1JKUFN1?=
 =?utf-8?B?RzRHQVJ3MVFwU09qRnV6cmc3UkJDbVR0YUlTVDcwemxzaFJrNE1zbGdxejY5?=
 =?utf-8?B?aythSmxUbGFGUVAvNmxtWWFoV3ZzZVllM1RaYzhuN1IxSHhhdktEa2VsMW82?=
 =?utf-8?B?bWNqbm1xTk1NTnVtdE8xMG8rVm0rdGR6Vkc0bkZmQWN2Z09NOGlnRWJ0T1cr?=
 =?utf-8?B?VUNFWUI5YXFQRlc1TzVrT0t2YUl3L0hhckFsaDdHVTNTaDQ5ZFJhdVUrNmZr?=
 =?utf-8?B?UzVERDA4bkJRN1VlYzI2NGlMTXg1aFFCRVpBMy9hYlN5OUwvUmJzc0FrSGEr?=
 =?utf-8?B?VHl0WDR4UHB1Tk1WZzV0U3hSaWU1cE01dXVEeWJyV2NxaUpBelBRTmFtdjJ0?=
 =?utf-8?B?RGZtdExGRkd1ZjRGMW1VNURJSnNWUzErSHQzcmxyZHpKeGRBVzJhL0ZoZEJr?=
 =?utf-8?B?ZGk0SWVNVkV0bSs1cXVlZ0o1VGNLV2J4alg4WDk2aVBkQ2JWSzdpcFRvWWhp?=
 =?utf-8?B?RGUzRXNnRVpNMEJkSEoyWVNNNVFjOFlCazhVTHlCUzh1ZmRhSi84Tll4VU00?=
 =?utf-8?B?WEtpVDN3OTdyMk0ybkt0RnFPcGI3ZmU4SjJxV3JPbE1jTFJNdy9FUTNrZTl6?=
 =?utf-8?B?bldHZFBWeWl0S0Nid3kyVnlqeWVOeWV5Q25mTVVaV1l2MlZOdjVtQlZmWGRB?=
 =?utf-8?B?by9qZWZ2OTdPb3p0TC9KMThKWHZYRkhrbHlZR1RrWktVdStHT3BtNDA2SEk2?=
 =?utf-8?B?WEh4NExhbm9DTy84UmZZd2drSHRWMUt2Z1ZtYUhqVkh4ODlIOVdxTzhlZmJZ?=
 =?utf-8?B?aS84NGJoUjNxeUhBbmlDelA4WC9aTG9HQnNKdFY0SmpzUzI1Y2MrSkRkQkhG?=
 =?utf-8?B?Y2hmTlpZMXNDTW16SkdHRXM0NE0zZklSTTdxU0VOQ0k1Ykh4ZGxvbk5RYUZB?=
 =?utf-8?B?Y0ZrZjAwR1BRREhuaTNMaittS0Z1SFdoSm83eDM1elVhem5JWGlobmpYVU1X?=
 =?utf-8?B?NHQ5MWVtUVg5NENMRVJYWkZsYm91TE51Y1c3WXViRE0wRE00Sm1UTmxSdlpV?=
 =?utf-8?B?eTR0ZW5DSjlGKzUwRm9DcXlmMmV6WlNBYnJ5WVYrbWhMQ0xyVENjc0lkUEti?=
 =?utf-8?B?eHovSWFSd1JzNkxZQWl3NnJQZmlwdFBTeFBSQUtFVDFYYi9FY016dU53eTQ3?=
 =?utf-8?B?QnNHSGVNbjdHdWFBWmR1NWQzZjllK3h5WVB3VTRGUjF2SzA3QW1CZEpmK3Qv?=
 =?utf-8?B?Q2lnMHNjY0lMbzd2UmVBdlNvS1VzeUFSY2FLZ2hmUVA5RU5iVjd1RWZKaVd6?=
 =?utf-8?B?UmVCMGFsYmxJZ0kvTklqajJRTXBWYndoZHhOOW90U3JDb1gwSmJHN0Q4ak9T?=
 =?utf-8?B?b2ZCNmc3WmhhSHc3NWMxcHFXT1NNVG53RGdzcCtzNGw1dmg1bDM4SmlHcFNt?=
 =?utf-8?B?VjNic3BycFh0S01WUUZOck02TThaM2c4MjJHckhkT0tQNUZsZ3VsdXF4Qis1?=
 =?utf-8?B?VmRrVkVJTkhETzNNV3dzYUxOSGhWNHgxc3A0UmVPeEx4R2RjTXJJRGlHOERQ?=
 =?utf-8?B?R1VudEhYcjAvZVpsWTNsWlpuTjAxUE8zSHk2bXZJc0xxK2VmZjUvNHZWaGlh?=
 =?utf-8?B?VENsK2MvdjZkZDZiZktaNyt5aVN6U05lWWlJUzRqZWFlOURuWXdEb1hSL1c2?=
 =?utf-8?B?Wm1qNmx5dVFyTC9xZldwWkVHd0RjMk1JaFROaSs4OWZtcWovU05CZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab39b4a2-48f3-4fdf-e1c9-08df2a6a5500
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:13:49.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntv4EQm+GZU+oA/iazTkGNd4wmOgL1nAJsAQwintnProAIeO2F/AOWDOnKb6iSJuJE5/RYE8TAOogLdtG76juA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB2789

On Wed, Oct 14, 2026 at 10:02:25PM -0400, Aaron Tomlin wrote:
> Commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated
> CPUs") excluded isolated CPUs from hctx->cpumask to prevent worker
> threads from executing block work on isolated CPUs. When all CPUs mapped
> to a hardware queue are isolated (i.e. blk_mq_hctx_empty_cpumask(hctx)
> evaluates to true), blk_mq_hctx_next_cpu() returns WORK_CPU_UNBOUND with
> the intention of offloading execution.
> 
> However, kblockd_workqueue is allocated as a per-CPU workqueue
> (WQ_PERCPU). When WORK_CPU_UNBOUND is queued on a per-CPU workqueue, the
> workqueue core resolves the target CPU via raw_smp_processor_id().
> Consequently, if a task executing on an isolated CPU submits I/O and
> triggers an asynchronous queue dispatch with zero delay (e.g. upon
> hardware queue congestion, tag/resource exhaustion returning
> BLK_STS_RESOURCE, or plugging), &hctx->run_work is queued directly onto
> the local isolated CPU's worker pool. This causes the local per-CPU
> high-priority kworker (e.g. "kworker/6:1H-kblockd") to be scheduled on
> the isolated CPU. In real-time environments, an active SCHED_FIFO workload
> will starve this SCHED_NORMAL worker, causing hardware dispatch to stall,
> in addition to introducing unwanted latency jitter on nohz_full cores,
> thereby defeating the original objective of commit a46c27026da1.
> 
> Introduce blk_mq_hctx_unbound_cpu() to select an online housekeeping CPU
> via housekeeping_any_cpu(HK_TYPE_TIMER) when executing on an isolated
> CPU, and otherwise fall back to WORK_CPU_UNBOUND. Use this helper across
> the unbound fallback paths in blk_mq_hctx_next_cpu().
> 
> This ensures that:
>     1.  When executing on an isolated CPU, deferred queue work is
>         cleanly offloaded to an online housekeeping CPU across single-queue
>         devices, hardware queues with empty cpumasks, and offline CPU
>         fallback paths.
> 
>     2.  The per-CPU high-priority kworker on the isolated CPU is not
>         scheduled, avoiding priority inversion and latency jitter.
> 
>     3.  When executing on a non-isolated CPU, WORK_CPU_UNBOUND is
>         preserved, maintaining optimal local execution with zero CPU
>         bouncing.
> 
> Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
> Changes since v1:
> 
>  - Introduce the blk_mq_hctx_unbound_cpu() helper to steer deferred work
>    to an online housekeeping CPU only when executing on an isolated
>    core, preserving WORK_CPU_UNBOUND and local cache locality for
>    housekeeping cores
> 
>  - Apply blk_mq_hctx_unbound_cpu() across all unbound fallback paths in
>    blk_mq_hctx_next_cpu(), comprehensively covering single-queue devices
>    (nr_hw_queues == 1), empty hardware queue cpumasks, and the offline
>    CPU fallback path.
> 
>  - Elaborate in the commit log on the triggers for asynchronous queue
>    dispatch (e.g. tag exhaustion, BLK_STS_RESOURCE backpressure, and
>    plugging) and the SCHED_FIFO worker starvation hazard on isolated
>    cores
> 
>  - Link to v1: https://lore.kernel.org/lkml/20261012012905.267920-1-atomlin@atomlin.com/
> ---
>  block/blk-mq.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 025a799f35b9..df6103b91e60 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2241,6 +2241,13 @@ static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
>          return hctx->next_cpu >= nr_cpu_ids;
>  }
>  
> +static inline int blk_mq_hctx_unbound_cpu(void)
> +{
> +	if (cpu_is_isolated(raw_smp_processor_id()))
> +		return housekeeping_any_cpu(HK_TYPE_TIMER);
> +	return WORK_CPU_UNBOUND;
> +}
> +
>  /*
>   * It'd be great if the workqueue API had a way to pass
>   * in a mask and had some smarts for more clever placement.
> @@ -2254,7 +2261,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>  
>  	/* Switch to unbound if no allowable CPUs in this hctx */
>  	if (hctx->queue->nr_hw_queues == 1 || blk_mq_hctx_empty_cpumask(hctx))
> -		return WORK_CPU_UNBOUND;
> +		return blk_mq_hctx_unbound_cpu();
>  
>  	if (--hctx->next_cpu_batch <= 0) {
>  select_cpu:
> @@ -2281,7 +2288,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>  		 */
>  		hctx->next_cpu = next_cpu;
>  		hctx->next_cpu_batch = 1;
> -		return WORK_CPU_UNBOUND;
> +		return blk_mq_hctx_unbound_cpu();
>  	}
>  
>  	hctx->next_cpu = next_cpu;
> -- 
> 2.55.0
> 

Apologies.

The proper approach is to query housekeeping_cpumask(HK_TYPE_TIMER)
directly and select an online core via cpumask_any_and_distribute(). This
avoids invoking smp_processor_id() altogether, and round-robins delayed
work cleanly across available housekeeping cores. Furthermore, because CPU
hotplug explicitly enforces that at least one housekeeping core must remain
online on a running system, the intersection is guaranteed never to be
empty:


    static inline int blk_mq_hctx_unbound_cpu(void)
    {
        if (cpu_is_isolated(raw_smp_processor_id()))
            return cpumask_any_and_distribute(housekeeping_cpumask(HK_TYPE_TIMER),
                                              cpu_online_mask);
        return WORK_CPU_UNBOUND;
    }
      

Kind regards,
-- 
Aaron Tomlin
