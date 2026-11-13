Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605560;
	b=KF28MHe5iO8VWygSxSXLkepJeoyGOqhyPB3ZRkodDtsQUKwtRWFIx92NqCWZyTPfppPc
	 TN9Q4WfG92+7SuZ60ym6KVt/dohVzq/wHjU1dJUle8OUveL5t3mU0x9o1HDzWvuql/xAn
	 FHJAqCgghkUoeNJkR/3RXTbnwxhYhgS/YwLSs22mzm6m3gKH0CropNlUXrhTM9xe9JvaK
	 xB1HkqCeI72No9uo9npjcOIcBCor+cQ6t2Z1afEO/+eAboP0V3kXy1V7fIIAixQmpCt67
	 KGh8GBGtxJg5iYtXHW7dwDTCYEvuBqqE2MN5dKVD0T4zq3R+VYB5OFtQlIobYW1dqEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605560;
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
	bh=WpR0nY57+P2ZCRspHo+NWuZ6aA5u8D+/K78UqcBxFxY=;
	b=30njonLncEAtlXzDfAV7BTwlpVD75t9xnhvgdflqSlyU+03Aphf8EQqYPqvrGU8uJgkL
	 bn42Zu8Hnaqsm4HWLyhRKbNDV+pZL/cjTYqsZNMMCQKWjGXbht6od5M/u/wbthqddcq4o
	 gDNZjSiHRBHKM7V8bIqeaqGokJ6amOHSdjjonh5/yj/CMINyVE6UOii7zRyla+si+q7QB
	 QSHtTz+UwuMnuMgSlFOYAd0O5fUVwpyUfvcMmuGU+2VqsM7WCAY3qBd8vsvHM8DBBXEpi
	 9G28fjRydoGOWLte4lWli9UoSIK0YcHIl4cAdosF0W99xx+IWZioNzO0F4LMTljP7rA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZXbPWydq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.70
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2E606A327;
	Fri, 13 Nov 2026 21:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87E2E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZXbPWydq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0oeUsZRtoeRHeIIOwb5tbkWq8TOFDnWki+5zF7oHMEBmTxsKsgGSGadT/2IU6wW011D+MDmTceRN9oyqUHJq8HR9R4fhcTtl60iz2OjNdsfimZPTP2pO/IyWYf56AXRyK3TlG3J7zAylXqpqsiyin6xPdtf96m5hRFvcDEsHWW0mv8pRPSFYRm1B4IiDfTy90jbG5zmdTKz9N2lJxtPhKtTRm9byDHAnXrOlQU6+LBjvm7TQ8xMgMIKAGf9P9CAr5YmDybzqCdQ1rx8H7uEUaq1r0OU+O0a+WWLnltomy5W/bNdib4WoQkCwS/wYSTqL6IV81sioj6+sqWrDHy8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpR0nY57+P2ZCRspHo+NWuZ6aA5u8D+/K78UqcBxFxY=;
 b=WU6SN0v0JS/vCvL9HYkHaSk37F42MvgsWnXzqT10gW6WClFdGltjKjlEWss24p8V9RCx77zDfMHDmeGFqd8BnHs3gdoHfrCOjabyf9kH0lJqN1zXsFZuciGf4Z32/Avq4C8CI0bbq9JD/InOjoDFdQdeaypjZak9AAzOuq/4TOi8+6Cwza7bVot6Nn/d49F4LkZ90WtSMfgaO2alOAOOp4fu8CFAijd93vlIf1cVtwoBn8ln+hoBmEIkN3+RbdTGVOvA4NUEsIiYdmeCiDsFbYI9DKItd1n28Uc99dfQK9kQt/jQMjsYuTjfMRHJDLMVsjjf4oG/vs8uM7Ejk400oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpR0nY57+P2ZCRspHo+NWuZ6aA5u8D+/K78UqcBxFxY=;
 b=ZXbPWydqbX7lE86FRvXMrKD1gaBst0x90obWtkggiTvzrCdjFwPHyfW9btGFkahNelh0xsR9pOO7/D60ACjuSZygpVLTe7HO0IBkY38SQgkijRA03s8vxl42ObvJf/xJ39/WajHd7P/hYqzqoI4RW7ejM8ZqCGltnLjtiKNFAzrSvBM9vvgJ89sF/6bcdWi3TYrqsS3sXuXZs3cjveERPaFLzSclQIzb6z0XjC5jVTkKIjekdzCxi/qBQ48KEXnvtc+2oiZ1HH6EHYBhLgD8CY3XPFahA2/Um4VdJ55Uni4kmx25biyhZBv925YtreAqaaWpw5553o52/YMzk2MHZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 21:32:33 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 21:32:32 +0000
Date: Fri, 13 Nov 2026 22:32:23 +0100
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
Message-ID: <aveB5xbos9hRa3Nn@gpd4>
References: <avdIycF_mZV8CHKb@gpd4>
 <20261113182601.569981-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113182601.569981-1-usama.arif@linux.dev>
X-ClientProxiedBy: MI3PEPF00004EA7.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44b) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 329987a3-35db-4b81-5c9e-08df41cda03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|11063799006|261026140227099003|261022105027099003|4143699003|261026121527099003|261021121427099003|261021123027099003|56012099006|261022075727099003|261022113327099003|261102123227099003|261009223027099003|261028144727099003|261022115727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CMnCubheOw6QgzTtXFE5VfDem9HRyOr/EUkzkLUJpZ5DeQyUydcTzZppaOxG2Gm15k7WvJI6Kr9TagHw9SWOW5u4I0GgZE87snSFPSY1tOWhCJ6xFq3nZTJZ0iqTtgCPFsxKyOCG5Xfh41jK2w4Ka1u0iimrEiO7PSKhwnuYWjb8dHTOXb6UOqlCnLHZnQZtnCUSb51VlP3xpKjPCBpYxJU5ErN4sndUsbEC6RGIHIpRsh7jqQ9UU78pURvh3yHaDDMLR/MFtF62oft9IdZMXKaE3rFpa1LWhbpcuUamgJ6R1d8zGTc+Ql8tGWy/Pw9s3d9r5/x1pUnq22LUuQHFokQ7jC49uyRLczDcnxUYuPdumQ4T+bOxDSUiPmlIFhhiXPB842SYrKPAo8fVFWPm0+ov4I+htvl50QznlCn8gPHvKeVmljuITZMBCzeoOWUjDjvmcjkx1zseKUC8u1xgOH70lvvsvxxr7jSf21AHvM3MCrTZ7SaPfJFA7sCkaHbNpGVmf8Rk3cQriLLaGsHgFPlRUerlG+aqMlHx6RJ9LyGQEca42Yk6auJ+pZuRPM5VkvySsczT+SHdLBL5XH6QoH7NVuYvdyQHFgBfLpLUgJIzH4T7xVWrZxqPpljrqXu+79zjfvJDzxCn/ryGq24kFGZDdjwTiqe+nfrggTO21Pc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(11063799006)(261026140227099003)(261022105027099003)(4143699003)(261026121527099003)(261021121427099003)(261021123027099003)(56012099006)(261022075727099003)(261022113327099003)(261102123227099003)(261009223027099003)(261028144727099003)(261022115727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2tzratjIqEEgY+Of8pxaXVyuHsRVQ632pJ9d4Gj7n1WISjVtAP8Crw/kJVSV?=
 =?us-ascii?Q?1DiR+EpGlLilLJJelLKjtOvHkKZgwSkkviXWgjtG7Cw5TfJV4VI9wpycw+86?=
 =?us-ascii?Q?kcSeCO3Rs3YhnYeChCzSjYelKLCFG/16ynZPTGVq3Bqe4vK5Aup/D9dgwpIU?=
 =?us-ascii?Q?7z7DBiZCaw9yR2VoEBMb+qdU9pH7N7W5emDfkRy7x6BwFE/MpWERbLwPnhi3?=
 =?us-ascii?Q?6SM/CyikC8iPpnn38HsFMcrf7/exnRj76p+NxW35TzRvp+YGeKVYGAg8q5bo?=
 =?us-ascii?Q?uUfcC7l62WDojYo0Ev4gy8Lb+HU6mzu4b0WQtn7fjog4w87nlCeVPnbyW9fB?=
 =?us-ascii?Q?75W6u1fKzLJWp/pGXug4gTO52Fum1yruaX0V8GQBFVL9U19XNMsQJgmA8jqU?=
 =?us-ascii?Q?aw9MKVwliq7T96lP12m02SwjpWiJcOWTSTL10fZdDmWUQ2BOCCsjdMgY99jF?=
 =?us-ascii?Q?KWp8/RNqcvAJHF9shHtsy1RLKvAnmvcdVTL2t4dLD5GM3Ttunl7O+lsc6M76?=
 =?us-ascii?Q?yBtlfGFjuL1vaqzMsCbDZSvfqf29LHR4d1x7faVkuj/UTW9JF+X4tNL4mHkP?=
 =?us-ascii?Q?bdAmken6oOqRf41YcXvjt1JOi92XfPesCgQdmvLEVfV6vXq8CbmSgJfVUMkI?=
 =?us-ascii?Q?xdJfVhQ415XIcxlGI93PH6ay6EyY9CQ9cmjCqDwX9Uk26hIe2QvhcDjqVNyz?=
 =?us-ascii?Q?9qUe9daoRCv4o4A4pyv2P+Wwcibs8iguWymWI30PhMlmlDC3CEnZkYooRtrH?=
 =?us-ascii?Q?ymsDLqXS6jTj5+kOpCQEv3/Zhjkls+9usmOO/uwY+0BuxswitQo6hLJhGhxX?=
 =?us-ascii?Q?pBIH5ftxrJch7wwVAAPBhNFjZ103+VazKHQPke9wZeCofMpZ9Cnpo0QZu3HZ?=
 =?us-ascii?Q?QPbl6Mnkhg6NEj+Wuw0ZWguM3d+MpM5jCI8hkoB00ZgUtmZzGD1Zm4lpbbF7?=
 =?us-ascii?Q?xIhrEBCZ+w1mL3I2b++fhQt8O8KnSN/7OhQwCBZdd2mDf14uWOs/j2y6uzgB?=
 =?us-ascii?Q?9KCb4ztkwkZCGLIuOYyOfxnUvWX5jEWe1O5YGnBF2cWiaJt+94WugS6mJzv1?=
 =?us-ascii?Q?iAgPyiVZLM7ekYHjO4rkS8UtQy1lRmrEx5+x/tLFq9t9EqPvs1NfM3aP01/g?=
 =?us-ascii?Q?Wds1KFX+RvlhIFX5sqD2ODik/l5rWGHgveVLoEgfMEoNlWRur27T2Rqu+Cr5?=
 =?us-ascii?Q?GM0mL5acsUnZ/DiTYn6vLBOpj7zDvTT3c7BZD5y6clqS+5DcW3xHkEbGOZIp?=
 =?us-ascii?Q?YOlRzXjmp+8sUhutzHY+5DLovpsosyye7Rxxv211wDmKyiQcdNSFvbZ5OAqx?=
 =?us-ascii?Q?WVc9D6bvOFJe6INFzIwAEfsZoP13qbknR0cY6vmmqkM8MhWnwYHS53OVvgEz?=
 =?us-ascii?Q?8cYVYk/uJxbxZx2qz/YZMXnnmAvw9Cl9/on1aNmv73WRVG81ixMGEsl4O661?=
 =?us-ascii?Q?237niXaaxDX0mJMQuNXms+vI2Z9vX6FjC7TAruwV+NaSiMU7Kq/o15kSdpfR?=
 =?us-ascii?Q?GhB9BwLxZdFMT8pIr/bs70r029uaGBEB+fh16/f6CRc9gnI7kJZtQnl/+WrS?=
 =?us-ascii?Q?f8tbog2w2BqAuTaxLJt9b5d6fPuQrc0ycyiIE4v4OMreSWKveYUT1TL6jkvX?=
 =?us-ascii?Q?TRcBT2A/6AYzxyqkCUBSu2E6+KTUD1u6r2BBBNbLUuwpa5v9HX6IhRkHmeGe?=
 =?us-ascii?Q?hTyQ5vs8nE3wOesvRNndrByhb5Iz6DAZHo32aJ2zt3GfJrks?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329987a3-35db-4b81-5c9e-08df41cda03a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 21:32:32.7446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjrhiGYB/aSS7vrPVxA92zhxz8TmxTxISLcC1CefQTa5boa0OvA+2WS9qb2Pgas9oNzxRMKxCo1AVqwYbvpeOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232

On Fri, Nov 13, 2026 at 10:26:00AM -0800, Usama Arif wrote:
> On Fri, 13 Nov 2026 18:28:41 +0100 Andrea Righi <arighi@nvidia.com> wrote:
> 
> > Hi Usama,
> >
> 
> Hello Andrea!
>  
> > On Fri, Nov 13, 2026 at 07:31:57AM -0800, Usama Arif wrote:
> > > This reverts commit 61ea17a63719 ("sched/fair: Add SIS_UTIL support to
> > > select_idle_capacity()").
> > > 
> > > That commit applied the SIS_UTIL scan budget to select_idle_capacity().
> > > The early checks in select_idle_sibling() consider a few specific
> > > candidates: the target, previous and recently used CPUs. If none is
> > > selected, the asymmetric path calls select_idle_capacity() to search
> > > the allowed domain. With SIS_UTIL enabled, a zero scan budget makes it
> > > return -1 before that search. The caller then returns the selected
> > > target, even if an unexamined CPU in the domain is idle and fits the
> > > task.
> > 
> > Isn't this consistent with select_idle_cpu(), which also skips the scan
> > when the SIS_UTIL budget is zero? Missing an idle CPU is an intentional
> > tradeoff of that heuristic. Could you clarify why we should remove the
> > budget specifically from the asymmetric path?
> >
> 
> It is consistent.
> 
> Symmetric path also has this (I didnt check this before sending the patch).
> The service is running on Grace servers which report capacity differences
> and updating the kernel from 6.16 resulted in the problem I outlined below.
> 
> Maybe the symmetric path needs to be audited as well?
> 
> Or maybe this service should not have ever run with SIS_UTIL at all..
> (The only thing is that kernel upgrade caused a serious regression)
> 
> (Should have made this patch RFC :))
> 
> > > 
> > > The budget is derived from aggregate CFS utilization. High aggregate
> > > utilization can coexist with idle CPUs when a task wakes.
> > > 
> > > On a 72-CPU NVIDIA grace arm64 server, small reported capacity differences
> > > (1013-1024) within the single LLC activate asymmetric selection. Both
> > > the reference and affected kernels were observed with a zero scan
> > > hint. The reference kernel ignored it and still searched the domain.
> > > A latency-sensitive, wakeup-heavy production workload saw its reported
> > > minute p50 latencies average 129 ms on the reference kernel and 223 ms
> > > on the affected kernel.
> > 
> > Have you tried forcing the symmetric idle-selection path through
> > select_idle_cpu(), with SIS_UTIL both enabled and disabled?
> > 
> 
> This cant be done from a running kernel, right? My understanding is
> that the cpu capacities come from firmware, so cant be changed at
> runtime to be constant across all CPUs in kernel?
> 
> Changing kernel on a production service can be a bit of a process.

Yeah, this would require a patch and a reboot. Unfortunately there isn't
an existing runtime switch to force symmetric/asym idle selection.

> 
> > It'd be useful to see whether disabling SIS_UTIL produces the same
> > improvement there and whether symmetric idle selection performs better
> > overall on this system.
> > 
> > > 
> > > Disabling SIS_UTIL reduced the aggregate involuntary context switch
> > > rate of worker main threads from 71.6k/s to 13.3k/s; re-enabling it
> > > raised the rate to 73.7k/s. A five-minute disabled run also reduced
> > > kernel CPU time per request by 10.9%. The available minute p50 samples
> > > averaged 149 ms, compared with 241 ms before the trial.
> > > 
> > > These measurements come from disabling SIS_UTIL on the installed
> > > kernel. The feature toggle also disables the symmetric scan limit and
> > > shared scan-hint updates.
> > > 
> > > Restore the search of the allowed domain, retaining the capacity,
> > > uclamp and SMT selection rules and their early returns. Domains with
> > > no suitable idle CPU can again require a full scan, potentially increasing
> > > scan CPU cost.
> > 
> > Yeah, this is my main concern, full scans can become quite expensive on
> > large systems with lots of CPUs in the same LLC.
> > 
> 
> Yeah I imagine this was the reason for the initial patch.
> 
> The same workload on 6.16 kernel placed 69% of wakeups on an idle CPU,
> the affected kernel with the patch that this is reverting only placed 7%.

That's a substantial difference, I agree the regression should be
addressed. Perhaps this points to a limitation of the SIS_UTIL
heuristic?

We could investigate incorporating observed idle CPU availability into
the SIS_UTIL budget calculation, rather than relying solely on aggregate
utilization. Periodic load balancing already collects idle CPU
statistics, which might help distinguish actual saturation from high
utilization with CPUs still available.

Prateek, do you have any thoughts on this? Do you see a way to improve
SIS_UTIL for this workload while keeping the symmetric and asymmetric
paths consistent?

> 
> Do you know how much CPU usage can be attributed to the scan on these
> large systems if you do full scans?

I don't have a measured CPU-cost figure for this case. My concern is
the worst-case scan cost under frequent wakeups when few or no CPUs
are idle.

Thanks,
-Andrea

> 
> > Thanks,
> > -Andrea
> > 
> > > 
> > > Reported-by: Arnav Aghav <aghav@meta.com>
> > > Fixes: 61ea17a63719 ("sched/fair: Add SIS_UTIL support to select_idle_capacity()")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > > ---
> > >  kernel/sched/fair.c | 19 -------------------
> > >  1 file changed, 19 deletions(-)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index d4cc0caee6265..def5cda2e6bad 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -9091,7 +9091,6 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> > >  	int fits, best_fits = ASYM_IDLE_THREAD_MISFIT;
> > >  	int cpu, best_cpu = -1;
> > >  	struct cpumask *cpus;
> > > -	int nr = INT_MAX;
> > >  
> > >  	cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
> > >  	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > > @@ -9100,28 +9099,10 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> > >  	util_min = uclamp_eff_value(p, UCLAMP_MIN);
> > >  	util_max = uclamp_eff_value(p, UCLAMP_MAX);
> > >  
> > > -	if (sched_feat(SIS_UTIL) && sd->shared) {
> > > -		/*
> > > -		 * Same nr_idle_scan hint as select_idle_cpu(), nr only limits
> > > -		 * the scan when not preferring an idle core.
> > > -		 */
> > > -		nr = READ_ONCE(sd->shared->nr_idle_scan) + 1;
> > > -		/* overloaded domain is unlikely to have idle cpu/core */
> > > -		if (nr == 1)
> > > -			return -1;
> > > -	}
> > > -
> > >  	for_each_cpu_wrap(cpu, cpus, target) {
> > >  		bool preferred_core = !has_idle_core || is_core_idle(cpu);
> > >  		unsigned long cpu_cap = capacity_of(cpu);
> > >  
> > > -		/*
> > > -		 * Stop when the nr_idle_scan is exhausted (mirrors
> > > -		 * select_idle_cpu() logic).
> > > -		 */
> > > -		if (!has_idle_core && --nr <= 0)
> > > -			return best_cpu;
> > > -
> > >  		if (!choose_idle_cpu(cpu, p))
> > >  			continue;
> > >  
> > > -- 
> > > 2.53.1-Meta
> > > 
> > > 
> > 
> 
