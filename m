Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793516238;
	b=lJgzdNfIGwqN7LuuYGo3F9h1kZ1eVUI3t/vbqry1kVYPRrntED1dc/qWxNMm1mt9fq19
	 ckvoFqks6Mg2v/YOywNt+R6TcNZPjsm7DgScPuq6Mch0eSgDLdcve9/vqSDTrcqxlYl9K
	 WANqd2CCu6991u1EtCc365W65vLAIGTUejv+gK93/DdcX0Q4R3gjEu5gwU9CxzC5zJ+5a
	 Hi/2/qx38LYzIw8lW1zpXSF3iNSOb8u9cF4EDfV3/VCuTsC/+hEv2UpqcC8iBl2hbdrB1
	 nT165U93KRiwtnoRYhkMV3Z0ZYTOyvdC4a1pwdmjZ8jsWtPf1wJqs9Wx4cxQXhLq2Yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793516238;
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
	bh=b96trpxjHQJVqcH6E28ViaeUQDmXODuEzO/P/FwDT5o=;
	b=vkPUPFsF0EVnkSxmXQjv6WGmXhGHtKthPhF5UwxArFW2i5J7Ts5XViR/KQEibvkYh3bu
	 Z9iTXjb3vOPsrXF+vECS23xrFICQag1MJm5MdC0XaW5pYHMrFq8EH8mrPdc2OyO/p+0eW
	 Zr59IaXswg2akh014hdjtka2AzIA7Dd7ci5pjadxCz1TH1P7Zq/S7aZhID89DOyyJXc45
	 lrZmfvv2JW7t+DpODggm2tiZ6TzkCq9sviaUKBUoCE8DuKUFRiQ0cj6RBU25hMAqkw6ft
	 5AjUnA07asdOJNpavQbu+li7cu0uWetVq9pdXWqR+uV5IP1vPTETjFDfIk8K173eQTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qSE7BON6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.60
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918A606A324;
	Sun,  1 Nov 2026 06:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7918A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qSE7BON6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEEuAJZG8fMJihUsxjjHKCO8v1CeyJI9Q9xbYqusfF4EP66HDeOac3JaQjyyfJoCOw4Km+7HurHnuF9ZL0TBw335sdY1NiRs4Bx6kl3ekp+8x/K+o97sqvXu385GsBgMWhcxrzT9L5DtasC5IYdlyjVOtexF6n3kRZeDBUnXdxh1k9ELS63vtJF9PZcnbFVaZEe+E1BJxrZBfqfoOknfEzai7rQXLmttm2627bvpXl1Jd6Ete04JjytHqow1RaVqSazisApqkKeWgvJkca5r3HeiY9ZL/rxxp+RjFUZbxIlIXEyi1+W5KgcgwwotX4ZSrGXEP9qEXWtTdLq0kCvP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b96trpxjHQJVqcH6E28ViaeUQDmXODuEzO/P/FwDT5o=;
 b=kyms5WP5j4mdm+e5+oX05uIJwkusTeGCPzba+r0gzpYM1mLxNIOceaU382iCl5bDY7CRQPPVzFXC5Y7Tm5TRgTZQSd3tU49VFtbJHKiXvIjrrMFq4nIHpOmEuNod5CqsJEc+y9WBt0pMvdmJc0cZVQNicVBDO5TOplmRg4swLL4bvTuHXyHdWehWXJEeVcWbqJq3VIKPEqONcisWdBIKJr4jtz5rEagvymlnf52h1IaFS4wDKkfDc3nnPhCIFyUd/qiE6ZhM5cLuVGakPCQf1kKf1LSU0f593WHY8ZxQ11uXA2RUzD/2XydVE5lclWs8VKmlh5P2pa9h1zkhMCsrIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b96trpxjHQJVqcH6E28ViaeUQDmXODuEzO/P/FwDT5o=;
 b=qSE7BON6RIZjsTrC8w4R/JAIEBozWZcB8vHzsn2S+3d2xdISJ1NNNp9YsLXJuVzZHZOLB3h2PpRc1RetAU0BuvbSRIu3FxfgeOEEH31DCe9lb0gDkctD4YTbZ2UKS56Szt02QRelKN52ahGbfLiPWWcln4BSMReL+kF0iHDyQf+V+OWRiUeQJVSR/0iFYNCsgHM0pkh7wv9U6Wm7geIptrcbhyxOv37HEQVSws3hzaIXXA2UfMUdWYUUn9lRHcuDTIh8OFDvLNCQ/43YEejcpGfWhtoyKm7JiQApCMQneso5wi+KO9Ika2XuFSGJyZYAV3L3OylqCccrxdOrG9oVEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH4PR12MB421003.namprd12.prod.outlook.com (2603:10b6:610:51e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sun, 1 Nov
 2026 06:55:11 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0569.010; Sun, 1 Nov 2026
 06:55:11 +0000
Date: Sun, 1 Nov 2026 07:55:07 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.4-fixes] sched_ext: Fix stale pick
 when the donor changes during dispatch
Message-ID: <aubiSxuL4cEJbpU7@gpd4>
References: <20261031162803.541236-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031162803.541236-1-tj@kernel.org>
X-ClientProxiedBy: ZR2P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::19) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH4PR12MB421003:EE_
X-MS-Office365-Filtering-Correlation-Id: d751252b-1a10-4099-a3ad-08df37e5126b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|5023799004|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FyBz0cLz2gp1ohvpdUH9a9xYRjkGtqPFQZDixeTqygNeVHGWRzZr+BvRbV3CnpEHRxFkuwl1nJPvdW3drVgEc2NePp8pXLgzCP5JDKYH+UTSQt8I0JWzmq4YipOsuqgupIdZfRAJr5D3aXFFCxBNM9Blk87Yu5BcR1xwqAaHMbFYVaz+51DJnVkiJFYBe564SKf1Ol0Q1bwSWZe9h8tsxTIMXvsbuySpkks3eGkPkLJBwL/8tujWEmBiBFHEFQRIawq3+rgQCbzoHWrAVUcF1+dEENH2sBhcgq+rB9TS++1raJXII54NLrXZ/aRnIlOYgu/KKOYfGd3QiU/0ieouhfmmdh480hWZF6hfhRuyCO9TcsTjL8HEUd0lfqMur3mG5BjlGLF/pnImDp+pOJ1heby3Ma1cXzWZNMBR9v1G3Q0F/pY2e/G6/LCyuvsQ3inUCyax+XsIBbpHP+KVKcHifiVfhaW1Kh03Z9YnzDOAQktHnA8PlD4NN4ZFSbHFwoFUFdgVMBjLyi+66Tgjoee6rOh++o7fuA+4S4yntIPk1HdjxIGzLmmfdhk5a05gGkEAvigG2YXXWVB4VMsGVz1wHlShCtA4pUHWu894QBKZ6bbsZTud1vZlVrN1nboyCFmhjy2jFcZ+80RKRf4KBIbIWb729ubK9J5T3dg+53qIuAw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(5023799004)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?id3Cb01P99/skBD9k+T3xKmCinaH2A9NNC0Qe+5RhSUtaI3tSYrvHsjog1if?=
 =?us-ascii?Q?XK+gLOdAJMEAYjfx64WQtkeeXpr2pdCIYEhKnxZS2kxs6k2KkCI4vPc/mn3N?=
 =?us-ascii?Q?Sn9cLSl2+ZSb0ACeu06nrc/IZk6rlKExE10rrJWyGlm6rtWAhv6kLdaydE/D?=
 =?us-ascii?Q?Up2Hs1KaXUmrGPvkHrYgHtPYWzq0OzmNCiBEqYN0zhzf2afx4NDuA/Cq/eKK?=
 =?us-ascii?Q?g0Le3LLRWDc0g0o/GD+xvqKKMEiv25nRwylrzkHb4KUsyOXLEqNgBgiS/Gg6?=
 =?us-ascii?Q?idmiJwmVjAxSIgAX8L1H15QUe84CPkNGhLe7UeFVEdDcOC2IoozpSUttbxTl?=
 =?us-ascii?Q?MzsVTdeJ0nTo0tAPHMXYX3o6wqQigwVPDJBuh81+aBhoJ/P/A4jADGvsBlua?=
 =?us-ascii?Q?5C0TUVysjmhJpa95vvwqtjD5Ocru+7oELz7X4hzh4BJK4Pil572xZHhvQVte?=
 =?us-ascii?Q?Xz9uv1lZ7KBgw5dCzZHmdxOljfUvtON7VBfnd0oDpL+oCtu6sttKVK8R1upD?=
 =?us-ascii?Q?Tiy5zU7utbCo2Za2QIfcmrZ9OUtfBkM42Q9jhrEAEaewPQrkJRqnf0dCRPd0?=
 =?us-ascii?Q?tGBqL8OI+25QdTsFQdjExKyq5HbLKWd5etldrm163CKmhC1EJzi2rTrQqYk5?=
 =?us-ascii?Q?1jlk6KWb/eiiEz3q5dm4yDBbENn7683r13oJQj/y1Pze4xqszx0w6hqkwqQ7?=
 =?us-ascii?Q?5vD8m3GwYvIYxbKF591ePrpvXyV6NZg8AvPHl3DhHxdVhCje6X4eFlFp5w5H?=
 =?us-ascii?Q?+/C1pQr2YgYjTSRAV1bRsV9eTCcwwfEKXKKG59/QJeU/hOYpDU3ysker6S8t?=
 =?us-ascii?Q?yo2nvvCqm9ZkwEDqNCW4nZ+6YFa11NH/rGNkGjKKReUjUqnLSh+n7t4DrtxS?=
 =?us-ascii?Q?NuFU4Xx2S+xwa1Fm28s6/Hp6avkc1fleq6UjWzSANXCZvcTWjJnvT1/Iz6OB?=
 =?us-ascii?Q?g/8/ytx2N7piBrwoIHDc1dQXwGCzXWkeGjspKaDs+6cjOCvV9zmWrsMYRFFt?=
 =?us-ascii?Q?aeMj9J1hvep5XZxYblNYBRDpD/CKpKLPYQ69Qs1+ViAwaAe7dYnlLoTUeSGA?=
 =?us-ascii?Q?L/yxRd/cttbZRJPtoiuC1EqojNfGOuVE2huNNA7XjagAStrkYoKJbsu/oX8o?=
 =?us-ascii?Q?d5sGJ7iVRcl2/LEOqwRyaB2KYyTW5wfpDpSPeV/3EekgU0RTb4b9pw2mkyd6?=
 =?us-ascii?Q?avnEpymPBqqpxA818h7E94sxNq/4NEJnYKYRAArwL2FrloydeIJxYrvpa3dS?=
 =?us-ascii?Q?+0VCcIKizKpVNXxJDlzFUM/lZ2izI8BxsHvQZkt8RlZgc1EXrC0S6cfoxMyH?=
 =?us-ascii?Q?X5WhQ7fsqT5hdldcl4Y+Z4cJZA4ofsVBHvj2xvmNUo2I/NzLBehrHNd904H8?=
 =?us-ascii?Q?Gnq9fm2CQAqeQfSUjrNiJUdX2VFaDNPyZBg4cUh68NvB5z9nv5MZWihywseI?=
 =?us-ascii?Q?qCZOPq9lBf+mifHQnlHj33XCpOLGxNulsDlZ2ibSUuEeMvgRxBWySryDC8qc?=
 =?us-ascii?Q?EIYxYSUyd/vrmSIG3mmaskQjUFISjz4NO9p/DiwHLZHHCjZAlNrPp8ekILIl?=
 =?us-ascii?Q?9eHqtgKFhQebVTnraldFX2PmNGd+lKfvJltB1uTX1Ltww4L6FR9WgsREaAcq?=
 =?us-ascii?Q?ZsWrYa0/dOpMI0czUJQEFBWTgsP8dMrpI0FZYdybl2xvUNoPxSBMD8adbTOU?=
 =?us-ascii?Q?iJuhDgFpyLYHl/bJWQkou6OLRpNG3EMIzpdL8yim4jKIXq+4MZr9tAunIXfl?=
 =?us-ascii?Q?gvIDRG6tyg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d751252b-1a10-4099-a3ad-08df37e5126b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 06:55:10.8912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +C0r6tMTWQDfKzRwjKd7XeoZD0Apw57ofCzTwoD3NJPuWGYnqKfzihNzo5bjKq1jVMaORixqkc4xwKDiu23TjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB421003

Hi Tejun,

On Sat, Oct 31, 2026 at 06:28:03AM -1000, Tejun Heo wrote:
> Dispatch takes rq->donor as @prev and can drop the rq lock. With proxy
> execution, @prev may not be the running task, and another CPU can reset the
> donor to rq->curr meanwhile, through proxy_needs_return() on a wakeup or
> sched_proxy_block_task() on a class or scheduler change. The wakeup case:
> 
> 1. dispatch_one() drops the rq lock, e.g. to move a task from another CPU.
> 2. Another CPU wakes the donor, which proxy execution migrated to this CPU.
>    proxy_needs_return() dequeues it and resets the donor to rq->curr, and
>    the wakeup enqueues it, possibly on another CPU.
> 3. dispatch_one() sees @prev queued and returns SCX_DSP_PREV.
> 4. do_pick_task_scx() returns @prev, and this CPU runs a task that is queued
>    on another rq.
> 
> Under core scheduling, the core pick runs dispatch for the sibling rqs with
> each sibling's donor as @prev, and a sibling can switch @prev out while
> dispatch has the lock dropped.
> 
> Whatever dispatch concluded, and whatever it does with @prev after the drop,
> is about a task the rq no longer owns, whether it keeps @prev running or
> hands it to ops.dispatch().
> 
> rq_modified_above() catches the change only when rq->curr is in a class
> above ext, and the dl_server pick skips that check. dispatch_core_pick()
> retries after a lock drop, but by then dispatch has used @prev.
> 
> Restart the pick when @prev is no longer the donor. dispatch_one() tests
> after each step that can drop the lock, and scx_dispatch_sched() decides per
> ops.dispatch() call whether to hand @prev over, which also covers a class or
> scheduler change across a drop.
> 
> With proxy execution alone, the donor only ever changes to rq->curr during a
> pick, so the retried pick can't go stale again. Under core scheduling, the
> restart goes through the core pick, which already retries after any lock
> drop.
> 
> 7a3a6bfbd62a ("sched: Rework prev_balance() to avoid stale prev references")
> closed the same window in prev_balance() by reading rq->donor instead of
> taking @prev. That doesn't work here, as dispatch never evaluated the new
> donor, which may not even be a sched_ext task.
> 
> Verified with synthetic reproducers for both cases.
> 
> v2: Also cover rq lock drops inside dispatch (sashiko).
> 
> v3: Don't keep a stale @prev after ops.dispatch() (sashiko).
> 
> v4: Also cover a sibling switching @prev out under core scheduling. Retitle.
> 
> Fixes: 7b0888b7cc19 ("sched_ext: Implement core-sched support")
> Fixes: c6fe97c34a1a ("sched: Allow enabling proxy exec with sched_ext")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Tejun Heo <tj@kernel.org>

With the separate rq->dl_server issue to be addressed in a follow-up:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

One thing about stable backports: ops.cpu_acquire()/cpu_release() are
still supported interfaces in older kernels such as 6.12, are we
considering them deprecated in general?

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c     | 10 ++++++++++
>  kernel/sched/ext/inlines.h | 37 +++++++++++++++++++++++++++++++++----
>  2 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index cd923f9f1f2a..e533c1a5c56d 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3407,6 +3407,12 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
>  		rq->scx.cpu_released = false;
>  	}
>  
> +	/* the ecaps sync may have dropped the rq lock */
> +	if (scx_dsp_prev_stale(rq, prev)) {
> +		verdict = SCX_DSP_RETRY;
> +		goto has_tasks;
> +	}
> +
>  	if (prev->sched_class == &ext_sched_class) {
>  		update_curr_scx(rq);
>  
> @@ -3449,6 +3455,10 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
>  	}
>  
>  	verdict = scx_dispatch_sched(root_sch, rq, prev, false);
> +
> +	/* scx_dispatch_sched() may have dropped the rq lock */
> +	if (scx_dsp_prev_stale(rq, prev))
> +		verdict = SCX_DSP_RETRY;
>  	if (verdict != SCX_DSP_NONE)
>  		goto has_tasks;
>  
> diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
> index 1e39d12678c4..5dce394e0813 100644
> --- a/kernel/sched/ext/inlines.h
> +++ b/kernel/sched/ext/inlines.h
> @@ -18,9 +18,32 @@ enum scx_dsp_verdict {
>  	SCX_DSP_NONE,		/* nothing to run */
>  	SCX_DSP_LOCAL,		/* local DSQ has tasks */
>  	SCX_DSP_PREV,		/* keep running @prev */
> -	SCX_DSP_RETRY,		/* pick helpers only: restart the pick */
> +	SCX_DSP_RETRY,		/* restart the pick */
>  };
>  
> +/**
> + * scx_dsp_prev_stale - Test whether dispatch's @prev went stale
> + * @rq: rq being dispatched for
> + * @prev: @rq's donor when dispatch started
> + *
> + * @prev can stop being @rq's donor while dispatch has the rq lock dropped. With
> + * proxy execution, @prev may not be the running task, and another CPU can reset
> + * the donor to rq->curr. With core scheduling, the core pick runs dispatch for
> + * the sibling rqs too, and a sibling can switch @prev out. Dispatch restarts
> + * the pick when that happened and doesn't hand the old donor to the BPF
> + * scheduler.
> + *
> + * With proxy execution alone, the donor only ever changes to rq->curr during a
> + * pick. Only __schedule() on this CPU sets a different donor, after the pick,
> + * so the restarted pick takes rq->curr as @prev and can't go stale again. Under
> + * core scheduling, the restart goes through the core pick, which already
> + * retries whenever dispatch dropped the lock.
> + */
> +static inline bool scx_dsp_prev_stale(struct rq *rq, struct task_struct *prev)
> +{
> +	return (sched_proxy_exec() || sched_core_enabled(rq)) && unlikely(prev != rq->donor);
> +}
> +
>  /*
>   * One user of this function is scx_bpf_sub_dispatch() which can be called
>   * recursively as sub-sched dispatches nest. Always inline to reduce stack usage
> @@ -33,8 +56,7 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
>  	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
>  	int nr_loops = SCX_DSP_MAX_LOOPS;
>  	s32 cpu = cpu_of(rq);
> -	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
> -		scx_task_on_sched(sch, prev);
> +	bool prev_on_sch;
>  
>  	if (scx_consume_global_dsq(sch, rq))
>  		return SCX_DSP_LOCAL;
> @@ -106,6 +128,11 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
>  			rq->scx.sub_dispatch_prev = prev;
>  #endif
>  
> +		/* the dispatch so far may have dropped the rq lock */
> +		prev_on_sch = !scx_dsp_prev_stale(rq, prev) &&
> +			      prev->sched_class == &ext_sched_class &&
> +			      scx_task_on_sched(sch, prev);
> +
>  		SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
>  			    prev_on_sch ? prev : NULL);
>  
> @@ -116,7 +143,9 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
>  
>  		scx_flush_dispatch_buf(sch, rq);
>  
> -		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice)
> +		/* ops.dispatch() and the flush may have dropped the rq lock */
> +		if (!scx_dsp_prev_stale(rq, prev) &&
> +		    (prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice)
>  			return SCX_DSP_PREV;
>  		if (rq->scx.local_dsq.nr)
>  			return SCX_DSP_LOCAL;
> -- 
> 2.56.0
> 
