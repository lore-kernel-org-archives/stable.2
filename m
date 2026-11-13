Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794590978;
	b=BJx6WdhQmR8ev0niB7Wdi8KVzkxupbK+7bqC1/M67KCfuYvzor2h3wy3iNVG/zq7LijM
	 LVG5uuvifsR3057cr7+MHPn9+IkeEuAlsv2uCiGTsFrmFHKz1vDZR9MH7vr5xuOjOTfeH
	 Ps50Smp2br0TgX2Zwa8A05p24/iMJVRMODFktFFtoyOQM8L130SBcL7XTnMGzdXkzxrQT
	 67U3RAD1IZ/hNq9SPkcxEs94MsMHJq/yO/C8jYr3tNq1+BszaSeuD4mKpxNDAHPWxGTuF
	 WUq8INhkhrocRI1BgkmO/8o9pr5dP56gfyyr6A8q25oir4ihVD1Rsuif8U+5O53tGyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590978;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bHCdmHaEynqnRmEXbmAEkFDJz/IbtZhPYgt4QOtuCks=;
	b=sQ8sScqx3XdOLM/Pe/7Yvq0W6/C8PlQOWjHNUaJHBckjc7AKOO032Jcun3+JFmGf8Baj
	 VY3ZmRZglsDkHQCB3zoPzTptM5aOnFy3EHrhEjy5dvrbATb3cJwxgSlAzgwRwH9QmkZLR
	 tqpPjjXpFHt4omumIrFlprJFZ/EK9l7yXIAD3k0Yzxz03C/lBaen/NMnEc59R2tBFJ3vK
	 uehzA50wva34vWxIkKIaSmtqHvkL2mv2WuSy3Qp+O8ckUSVim91GoNk1AC2DtUyGN2x44
	 79AUHEWkXXIhE3XAfD4Igc2bdWGlWpUPw+MzVin3LDnVuFUEK1UgrzoOEWgMRv59x/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EAbK1zE6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.8
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184F5606F728;
	Fri, 13 Nov 2026 17:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 184F5606F728
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EAbK1zE6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppwrMvbLCVOcwmr2+YKm5/YKJ5SxJWVwpwIAVpEKUcMTX3l79knhQKvA8fyP1zUMEk5tb0eJuGeF5A6eTuDJM2D1WENoh+jo3ho9a9LUnK6M3C7Gr1HmKBxFhCmiIPs0u7Yvv1vPKtABAqUTRm5bYjoldknv/NRzwcOK6wN9agsO1gtW7eCujcuZ0KXC380cAzyabcQ4aZAaq0hcKaKGPPeACOwWb31LrgJt1HoDhViydRWT/5b+l5dQR4fKGM5Dgb8zrmHiOfZLJUrwZKvCAqASWNZxf9NHvTQdvqqIBdfWM03GR8LlYngR9B5qJVpJR4Uu+RdD3wXyIPevOfG+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHCdmHaEynqnRmEXbmAEkFDJz/IbtZhPYgt4QOtuCks=;
 b=yUamshuZdLG3Hdwf5Q65O82kVUoIdnRfbwdTONVTojjBbHfu3R3LyL/y7EYvxPrIOUfciGH6eDpcl32fWeE3bOhtUBDy9A4ZUJWz6Xa0BqwMMxz3jIobHQ1DfTn0AsY8c6obvB9XEmAz1xE9t6A+sUGfvKlgg/TY8XUSlE3p/9Yxp06kpkzQwI4+OZq8T714ZEQlXXyrEWn+AcOcJKK0qIGGO3Mhov1AuLeXP5XsD90BZWVlvI/9YDnAX/pyvjAWvptnYmYfj4ob/c7V9P5HIXUd9o+E/o5v9NUaYzjTuGK+1DU+nS5O/ULR3slKnpqyLpJdsuRl0wQnw/JdtSdn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHCdmHaEynqnRmEXbmAEkFDJz/IbtZhPYgt4QOtuCks=;
 b=EAbK1zE6CrfhuU2SdEjnMbOgfw2yxyhW+kP+xad0DK/LoIz8kjiZTrdUxcocrKFMoO2aQNmecArBivFzHTUxxjsCeFqCZvvlBglbbouOG+5wJdJMOOHc9B/Q80/bjvuuw1F2pgGZCLAyBMLJ2zCLfx4SZWYmxxlrOM0/FbMI52Y6BCSAsIcr9N3E5gJhIO0GUPgOdG3DJrKoySykbK/0Ca0yeJagYmbBI3a3QzV4GvzLoSWRlpJNnqhiomQKFtvXypDf4gpWHlwXYgE9FlnbYp6PuO7cnoe49V5er2sg2XlQUr+N73SH3DAozRko60Ao1uFPQZkYQWgsn3JNu+dlSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SJ5PPFCD5E2E1DE.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 13 Nov
 2026 17:28:56 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 17:28:53 +0000
Date: Fri, 13 Nov 2026 18:28:41 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	kprateek.nayak@amd.com, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, samuelcrossley@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kas@kernel.org, riel@surriel.com, Arnav Aghav <aghav@meta.com>
Subject: Re: [PATCH] Revert "sched/fair: Add SIS_UTIL support to
 select_idle_capacity()"
Message-ID: <avdIycF_mZV8CHKb@gpd4>
References: <20261113153157.2495664-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113153157.2495664-1-usama.arif@linux.dev>
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SJ5PPFCD5E2E1DE:EE_
X-MS-Office365-Filtering-Correlation-Id: 61fbc9e9-e416-44d5-511a-08df41ab9682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|56012099006|10067099003|261009223027099003|261021121427099003|261022075727099003|261028144727099003|261026140227099003|261021123027099003|261102123227099003|261026121527099003|261022105027099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SU32KbdIe41wq1GhJ79/CpnjBSQ6E3G4mgurfSoG5J79xgyrrSF0liYCDQjRieoDlIp91+Y/fWAqh6rGEoM6wj03TE4dVBpmGKx4QxysXA0mdnRUgm72O4bx1+5+6aoP+dYz0XiVhAJOQ1xgke/QvnZCdraDgWcOswjAVzr2pyua61OuRW0ZFTlAuX4cXN4nOIjKjJZl1LqNAffECHYVolJ4wSrcvUAGOgtC8utBFs6nLFpf4wrBZojB3eXK8S1q+eHAqMpNzfVceZGObnwNqvnoI2ZqGsv6iNNx/mAFn/EyCjB6y6bNR+I+KKhwwvPLIfOQcuWI/LxPg+4yet0EGaR2ruKP0Soe2Qh2pVwkFiGw1sl2hontGaBaurSB0yvdQJEB+11hVLgNfe3FHJTe1ZSbAiAdNYc/+4CFT+Ef1f+LKoFfwoxtS7AGUn7TH8UWmIC4m67HgqLaJOjWA/rDYo/st0VyeELPZjn/QNN8h/ckbN0elThRXdMNjWur99g8GtX9MbzJyw1ftxAMtMQaWi9Qav57ZNyK8c2/ePHXoCwo39OebVUhrWNzgClAHHcFhhnojRvgshSfYtty6BlOR/0eawnVeCz7lWtnjziNTKI7hNBomo/gAvpz+c0zmfIYkJMSosdq+ytlvFMIFXCUooX/ryXpPSz07bYBLTMjuUI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(261009223027099003)(261021121427099003)(261022075727099003)(261028144727099003)(261026140227099003)(261021123027099003)(261102123227099003)(261026121527099003)(261022105027099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?acH2eQcj1ubtUGa7NibNUtqUK3USc0nziLSQv1bJHkzEbCvALJ1LZVf4+ls+?=
 =?us-ascii?Q?PWUfZ3tDmJcPN6+vcoyyGDQ4Lzupq18fGCrqc9nJqvw3+kmnN6Ldkh6BKPJw?=
 =?us-ascii?Q?XsZnEpNquyhjBnIRvharUi2KUqZVqHyWW62QsNJUQ2R4TuxHVlB4P/o7ITup?=
 =?us-ascii?Q?o1t6BELC7D7fJUg+Cix3otC/K/1hCkw+f8LSNGwiQLJR2a0ldulM52Xtv3rd?=
 =?us-ascii?Q?U5Fc03ZIpOyfbcHgBHEJlMHSpCMFeCAcvnEFJCohs1P8Dk9R7Y/Clb71nG2f?=
 =?us-ascii?Q?I4JkZm+qQBXrr1E9qmX1vKr7qqpm7MmlMDCWkSEezlo4WTw2i2kdTc27bFUN?=
 =?us-ascii?Q?giyfvNpfZwUQ8Da0tVeboalCGGqgMq4nME8qgB5mN85dwScOawRp/VFzFcpT?=
 =?us-ascii?Q?zvT/mEJZIozjTXP3MOub1nn/j1Ro4RsVCM9vMdaixd7EgEuVXQnUwbd2Tc+M?=
 =?us-ascii?Q?lt/VoKyek661B1qtbRXXXkUBzgJfvx1X2B3lKn+AY2ClxpxPK20cmbxZxxQX?=
 =?us-ascii?Q?Lj3BbtoWyEN/3VTgBg8+uEmRBwjF4lhDMZaEyy1Z/H9dp9C/tgg7rIBhj67p?=
 =?us-ascii?Q?+HfBLdpbtL51wAg/HAShzNb/mDVcLem5qNvyteWtkXgf40fMszot/9v6JRYH?=
 =?us-ascii?Q?qDBYpKaJAk01I+eRYk7KFPkM9LUhwGzT4Xh+4yX5uwoKM2BNTp6yugfc+LHe?=
 =?us-ascii?Q?WAtTqcLbo9iF3Lkbm3kuIUhHqsGdq1rzTjKJEIXuTnury2U1ijerUYCmVyWy?=
 =?us-ascii?Q?liq2F6nzAF8M+fOOh9WtB9etcBkEOjS++G8M7nDrV40xZEOcaxrRrOYZmk+K?=
 =?us-ascii?Q?I/fpB7Hhx2g7IkrgK9sP6PiTKA24vsZWzaQrRBrqkjexNGjYDWa+u+sO/amm?=
 =?us-ascii?Q?pSISlGuZ5e9qf69LffiGLRXQyIbmAwLRoV02sw7vZ7oRASVu3rRrqFvpCHUA?=
 =?us-ascii?Q?H4JnlW1upBg30qHYqX/9lLtNA6DFNgctK52RKIX1hD6ua2gDcmCp5xVjDZYx?=
 =?us-ascii?Q?cOcpGlY6/yMW1OQjBbKOsTadsMeG20efhKmsM6m95aexvtUGT2NTVSU47oqt?=
 =?us-ascii?Q?F4iNF1Q75uGYO70OB9EF9fq8zvqQlnDR0lw9561+uae9pzcSFWehFXZ9yLQ2?=
 =?us-ascii?Q?EdT0GQ8gseK/S7Ur6MpzBw5kuoJphF+oihAH6tljP66OBfQJCDYPe1LkFZVH?=
 =?us-ascii?Q?7uBCN5kGvCCqDhAee2BdNKVvP14KrHJIyzdm5IBGgk7l3i1c7EiWc76G0lrE?=
 =?us-ascii?Q?YOpyFIlKT/UR114DCWEBSYecQdY7oqswYXY4rB7oR+dQ4+jMVjmWiumoUFGn?=
 =?us-ascii?Q?aED6U9rNVWQB3S2cInjnlQ2ibzsUqKOVQlPccGDYmUc5FE3XL8NujSKG5FYZ?=
 =?us-ascii?Q?g02e1ZaF+qTd3FLnAcQRA928MSLPzRwA2m1nCU5klUGku7J6K+XMEy3HJCxV?=
 =?us-ascii?Q?UPMPLDkjVM8h+aDTlBoQo+8KcR9A2VuDE8/Su6Vj9mzBIUrNV6mF9h2P1zY/?=
 =?us-ascii?Q?mvSUREb7qQFredPADRmjfB0R28kSgxDODO4DYk3VzYJkz6bJIOuLNNzG2ZPn?=
 =?us-ascii?Q?8NcbucO1Yq4OuYkmKy9wUNgoaF/KsL27ALtULdtBbuqCyeBiDLPQvBOHCSI9?=
 =?us-ascii?Q?ydJ3PGYS86Fye2Z1lMvjGRftXFfyN2WBqRwOYIcwcHvEKx2qptGSIDO2wf43?=
 =?us-ascii?Q?qH7RuKCjqADBL5++uMW7Xmj1olB2CEIQn668We3KXZrAF+Ke?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fbc9e9-e416-44d5-511a-08df41ab9682
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:28:53.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+pkcCnmrPUBzkAR0RphXTXWg8Jig/DgJe9nZw86k9KZVGvohiGkPOJwC4bdS4yIW/fPhvumW5XTrsoaWo6W8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCD5E2E1DE

Hi Usama,

On Fri, Nov 13, 2026 at 07:31:57AM -0800, Usama Arif wrote:
> This reverts commit 61ea17a63719 ("sched/fair: Add SIS_UTIL support to
> select_idle_capacity()").
> 
> That commit applied the SIS_UTIL scan budget to select_idle_capacity().
> The early checks in select_idle_sibling() consider a few specific
> candidates: the target, previous and recently used CPUs. If none is
> selected, the asymmetric path calls select_idle_capacity() to search
> the allowed domain. With SIS_UTIL enabled, a zero scan budget makes it
> return -1 before that search. The caller then returns the selected
> target, even if an unexamined CPU in the domain is idle and fits the
> task.

Isn't this consistent with select_idle_cpu(), which also skips the scan
when the SIS_UTIL budget is zero? Missing an idle CPU is an intentional
tradeoff of that heuristic. Could you clarify why we should remove the
budget specifically from the asymmetric path?

> 
> The budget is derived from aggregate CFS utilization. High aggregate
> utilization can coexist with idle CPUs when a task wakes.
> 
> On a 72-CPU NVIDIA grace arm64 server, small reported capacity differences
> (1013-1024) within the single LLC activate asymmetric selection. Both
> the reference and affected kernels were observed with a zero scan
> hint. The reference kernel ignored it and still searched the domain.
> A latency-sensitive, wakeup-heavy production workload saw its reported
> minute p50 latencies average 129 ms on the reference kernel and 223 ms
> on the affected kernel.

Have you tried forcing the symmetric idle-selection path through
select_idle_cpu(), with SIS_UTIL both enabled and disabled?

It'd be useful to see whether disabling SIS_UTIL produces the same
improvement there and whether symmetric idle selection performs better
overall on this system.

> 
> Disabling SIS_UTIL reduced the aggregate involuntary context switch
> rate of worker main threads from 71.6k/s to 13.3k/s; re-enabling it
> raised the rate to 73.7k/s. A five-minute disabled run also reduced
> kernel CPU time per request by 10.9%. The available minute p50 samples
> averaged 149 ms, compared with 241 ms before the trial.
> 
> These measurements come from disabling SIS_UTIL on the installed
> kernel. The feature toggle also disables the symmetric scan limit and
> shared scan-hint updates.
> 
> Restore the search of the allowed domain, retaining the capacity,
> uclamp and SMT selection rules and their early returns. Domains with
> no suitable idle CPU can again require a full scan, potentially increasing
> scan CPU cost.

Yeah, this is my main concern, full scans can become quite expensive on
large systems with lots of CPUs in the same LLC.

Thanks,
-Andrea

> 
> Reported-by: Arnav Aghav <aghav@meta.com>
> Fixes: 61ea17a63719 ("sched/fair: Add SIS_UTIL support to select_idle_capacity()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  kernel/sched/fair.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4cc0caee6265..def5cda2e6bad 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9091,7 +9091,6 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>  	int fits, best_fits = ASYM_IDLE_THREAD_MISFIT;
>  	int cpu, best_cpu = -1;
>  	struct cpumask *cpus;
> -	int nr = INT_MAX;
>  
>  	cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
>  	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> @@ -9100,28 +9099,10 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>  	util_min = uclamp_eff_value(p, UCLAMP_MIN);
>  	util_max = uclamp_eff_value(p, UCLAMP_MAX);
>  
> -	if (sched_feat(SIS_UTIL) && sd->shared) {
> -		/*
> -		 * Same nr_idle_scan hint as select_idle_cpu(), nr only limits
> -		 * the scan when not preferring an idle core.
> -		 */
> -		nr = READ_ONCE(sd->shared->nr_idle_scan) + 1;
> -		/* overloaded domain is unlikely to have idle cpu/core */
> -		if (nr == 1)
> -			return -1;
> -	}
> -
>  	for_each_cpu_wrap(cpu, cpus, target) {
>  		bool preferred_core = !has_idle_core || is_core_idle(cpu);
>  		unsigned long cpu_cap = capacity_of(cpu);
>  
> -		/*
> -		 * Stop when the nr_idle_scan is exhausted (mirrors
> -		 * select_idle_cpu() logic).
> -		 */
> -		if (!has_idle_core && --nr <= 0)
> -			return best_cpu;
> -
>  		if (!choose_idle_cpu(cpu, p))
>  			continue;
>  
> -- 
> 2.53.1-Meta
> 
> 
