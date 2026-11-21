Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795305133;
	b=zMB3L2e5X5TlALeaIdiox8P1nDgiFTGo4xGOPOrNe14Izx1pyN4aIrAL0nkekY/qk1Vs
	 36QZKytQrxXWgbh9wTIPCeoPfbipd8LlC45QxP5gGW2dkzJbjRBZC2n+1VjKBcjxEmIZF
	 1DyytG/hywTW6K7UhfnRP4Z2izhhnImODAPeLNJZt3qcA2nmA5XWGtwTXFFph0vPCf30B
	 lolUEmHYqTtzI4PDMRAMRO9qsPG0nZcGLISXNaaiDClqkl7bC/M/tVdzen4UTPCwoxc/I
	 VProlgCWxXd3ioaMkq2axkUtmF3zSwqMqINjZly0bmTF2i0cjVybPIUtp9xWBhaWWMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795305133;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Oqtq3tqI3vD+9JfBwTKAAvU1628vcy87NyB6WrgQkGA=;
	b=NOzT9y1tVu88lffQyc1jh9c2Lc1eoAgemCi4CDWwy4xYztoS+XvejIdN4PdP2BdjIbeE
	 oSk2180zvR2Q9860Q8o0EV47RHKUUsaIgNPQINs9zKnawmYprQxUiQL3r+GQIHcjcefQJ
	 0j0tamzQGJBprdg6ziLOWojfB1OMM6PBHkF4uwC+YVigy7tXGMRUgw8ut1xR+v7H3qC0u
	 ow1XtmItdN02Cx7vKSeRNT5n/9ZYcDPOLzyLw/ZtJ1K7dpu2wDZ5tSMSkrRvG9x892n6F
	 9rwvrxdu3yGPy2qcNaGCIXHbPsIQFWDj8ZdKsOd6GvUDFyEZvCe8Cw9YfXy0JReloJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.131
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021131.outbound.protection.outlook.com [52.101.95.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995EC606A320;
	Sat, 21 Nov 2026 23:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 995EC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aalA9HCb2DlNgMAE3s27grkUV32QNLhDFdJ60hhLRnrfSxhDB3g3t7lzRo7V7TH/3g1QKJhpVVlQh99SIVARPAMINC/WoljS70C/MB6DbknJpj9iLdatZRhAziW6xDFPlcLWpyXWPuvmD4SScQxi4Tajw/PLzJRvcN02Z3u1vrBT7v6DEriUkv/8xA6loDHN08ScG/mtEmdedaqkuRDEqKvPFLoHLPG+ovAJ1ZZYlWdkmIoF55Bgx7DZLt0xbP3E/h1unFShlAoZwZbB9pa3nTpMo99rYodeT4mvm8UNbgOu1Bsu0Bq2D5SjzMbQb6qiaKXCgoqw9o55CanTjrhVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Oqtq3tqI3vD+9JfBwTKAAvU1628vcy87NyB6WrgQkGA=;
 b=BJjDu0niKaDEtnUN+lOOIM4YKeOV2OywICQ9nTQmsQ1lNS9CITJmUaLSS1JyI55gW8y1ZgVq9oQokPIJAfTuLpzQQughFDKb9D6cICreyOllyDfgJsyEJI7TWa4w0/kQjHh9dFSNPnHp4qLZtNYBov2LSrNz6NDwLjoioFkmUpLr3lKMjerlhjI8SK3QHYtNrGI/784xBp+6JwwBwLyrsFS2uKwYsR6BA0MU25+pujVHws7ndsrb8nscIfxdeOeMTm3TJfxtCQ4V7g0abm0mP1G7g5Qxh5mvI4R+RgOcThxKnkc0YUtclO6Gn2BrRmk6BRDvn2OEKFRd8XwvESh0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWXP123MB5665.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 23:52:08 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0639.012; Sat, 21 Nov 2026
 23:52:08 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk
Cc: tom.leiming@gmail.com,
	hare@suse.de,
	dwagner@suse.de,
	emilne@redhat.com,
	frederic@kernel.org,
	marco.crivellari@suse.com,
	tj@kernel.org,
	atomlin@atomlin.com,
	sean@ashe.io,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5] blk-mq: dispatch kworker to housekeeping CPU when hctx cpumask is empty
Date: Sat, 21 Nov 2026 18:52:03 -0500
Message-ID: <20261121235203.811792-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0513.namprd03.prod.outlook.com
 (2603:10b6:408:131::8) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|CWXP123MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcb677b-1a30-41fb-df1a-08df482a73d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|6133799003|18002099003|261009223027099003|3023799007|261021123027099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261022075727099003|261028144727099003|56012099006|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	fxAN4mtUKgAUNIn5g6b89AGLlOr1CKffy0TVWwCb5ZwOVIWzjANz26OLUQTyLRR6/CXdS7J906tN9oyfX4m5RAz34Y4gWmQU2oKdV4aTDETNcz9Dn6x3JyyOat5JV1cpe8Iv22aDTmczL/P0AzKGxoEtYlGPGrKpU4ttK9bJGILVMZJAm4BlJtNlqIqRXeQKvh/nU7aBJGKVEpJEKOmrlubmHsObShLK3oVjjmwSxd3ASRCkLQpDwap077tUY39HAwejG9QORQP1Zzh8xWrl+xtqm4T6zR47NyOQ53wMl5zukY6MA6uw6RH85i4hqfalbLJqfS03yvmcI+WWdOXOj3ZEPg7zEVmAvsWoROveSRQE5dHW+DrT3kH+06ZTaACSt0qfDtodkGtuB7o+5xq/Yizf+D+GcX+DGlmzWMGUZRRFA5WX+VjhDUl7NyoVb0qfR97H+rQke8vrtbvIYBw0yVH2ppp65suqw50Su4iomQroCY/DnMF4koNVdBYzSbVWGL4XTP7u1cBEbBkIcAzgdW+dUQQpuT943S4vEfLE0icoXJKUE61yfp/Zqek60POMJ6yv5y3JpT3peQBXMm4HDM4bj/JD3XnQJzm2qob1n7Ws3NSoV8TczZBWE/s2yKJs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(6133799003)(18002099003)(261009223027099003)(3023799007)(261021123027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(261102123227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?76z2JCRjOVr1541tGaE880H/8Xlzuq8pYEgLjiPJvmjLt9gfYQss5SXxCrt9?=
 =?us-ascii?Q?Cqn7I4NJy+8olei5mvMraZLwxzGedT6etsjsI/QejvsZ0UaLpTicZbrm5V5v?=
 =?us-ascii?Q?inbWgTW99jkZtVAPe2BQuOrlvjBJU/ceQXTZxeK73/6buG243+e0dD/B2ZH9?=
 =?us-ascii?Q?i6znh0O+dKsKlK3lf/6e4iI2NCxe86FdzQ2wHC5vaVQ4LKBpjJj1VcUhUf9K?=
 =?us-ascii?Q?uM8y8qOB/GRyLwTcS9EM5/9TdOW2ruPJGbD5MEQHsL60CjcGujmgC8+NGUE4?=
 =?us-ascii?Q?3kfSBgDdxa6evwa7H7IEDhYm7JOUA0NR4H/DBGEWClkHjI5ny6yzAWRCIhvu?=
 =?us-ascii?Q?hXbAhY6cc5agNf48L58qFEKtHPyjBq2XT1qZxHYWc/vhnOqRuG2TzCzf2yxS?=
 =?us-ascii?Q?fiODuySdVZjsrlrSCXDrpvt6Kb1QK1cYV2B7rQvLJ3fOil1RYvUsLSi74JQY?=
 =?us-ascii?Q?LiAZtAMJ9wcc7wXA/buVCEOa3ar1fTt70NQU+BU+MCAag8OFr5vPSsi8VQHz?=
 =?us-ascii?Q?qqUkKV9DHGUWVbreJXMwa0qivHaxSIYdMHhHN3HbzfnMxdX7SppiXGqGiFmn?=
 =?us-ascii?Q?Y5g1ck+kFlQF4XGvqtzcWkWthNPl2QqbzniqbDp/0uKQiI7wnPwR5JTKV6gp?=
 =?us-ascii?Q?GWNcx3AH2seb89NH9yImG0/37qbnpdEtCvl7KMpoEns6MCbv8mTZR6opO+SN?=
 =?us-ascii?Q?44DZvys2pFBxTbYEwu8JWB6GzusotJI39IpQKntINLAC3RJRYYm0NtkyXQlL?=
 =?us-ascii?Q?P/JrNVg5M5PKjjGHQtYuUnCyCbNswPjLVux+LYw5JlBywRrP3AeQEDfwXPHU?=
 =?us-ascii?Q?EIKsO7VXuJyaigLJYO8MA08N0ezfgO0E5Xy7fnNs+c+hLU+9iccMLDC+hXKB?=
 =?us-ascii?Q?mBpBptqqn2EVvc5DAxmsayWAo56VEq6BnqZ97B6andVEUH0Nfsl/Z+MRWOfT?=
 =?us-ascii?Q?HMLy7VKf7NSXbV0D3qw3KoXo2FOPSRjY9NHKeBqOyIQX903kcKyuD7/TpsMf?=
 =?us-ascii?Q?cjv9xchOyMOlzNVbBkLmycX+28ficY+VJm3ZrDE9EhXV5SDf6bwwoOmJ9Ixb?=
 =?us-ascii?Q?x/b77yj6aqT2kmKumO4SC2QTbdk6cDHLOwJGqoCPK4UeqyDy4eHcPq/5iDyA?=
 =?us-ascii?Q?f6ZvxKqZoKPzwlNMl8UOTS0DsqIZv7xfDlnIMUQBRQbCsuVeHko5F1JSDswV?=
 =?us-ascii?Q?Nr/2jhV2bDpjhhTcXlTG9MxFTGt1p2l75dI0On7Hsgr8OcHCaaDNJAQ5FjNg?=
 =?us-ascii?Q?n89GDKLt0KtFimlgdPRk1nUfzFlMrn4DFfjuCBOB6z/7aXLRZGjY1jN8IxWY?=
 =?us-ascii?Q?Uz7truBWZD/dK5ZToRgRAfextsGuv4gA/6YSxZ4/rzPMDRWWNA8NwlOmyy1D?=
 =?us-ascii?Q?BynhPUpnRwyi9vFkC1+0LnwKGTD/I+reCFpSqDHKHb+us/hZ8eV1STKzuWEL?=
 =?us-ascii?Q?JZDykBya23zBRhH4g/dAENaW4qRCM1EDVqxNvREk7g4gJfVtYoky2PGunESa?=
 =?us-ascii?Q?Gp/591586k1sK8Z6Oi1x+SAltFz5PtPzKbB1P94aBbDZVz14iOm/TkZ+yIU3?=
 =?us-ascii?Q?D7g7vcOsww5MprL3tzHQpFegDnjP/JZtezwiyxrRcVk2waZrsBV3hyk5alWl?=
 =?us-ascii?Q?X+a40EjPKGp/y3cs5D19hO7MnnHzGmlRCmrTYQOPd6qu+a8wOh380xL8QTrK?=
 =?us-ascii?Q?LgPgMC+QtZhKBp1cpbfNsMurWRGD/sxrECn9qL/nz3YBmT94eTcvjVHBo+I/?=
 =?us-ascii?Q?zCKserS0aA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcb677b-1a30-41fb-df1a-08df482a73d5
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 23:52:08.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnbhqzaMhmo94QLUUJNY8KlYFOCelS5iG8Bqm0ey1z4P52fQbQHIuHNZkx5nWANdxrvAq6xwyxQnLJ8XOnXghQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB5665

Commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated
CPUs") excluded isolated CPUs from hctx->cpumask to prevent worker
threads from executing block work on isolated CPUs. When all CPUs mapped
to a hardware queue are isolated (i.e. blk_mq_hctx_empty_cpumask(hctx)
evaluates to true), blk_mq_hctx_next_cpu() returns WORK_CPU_UNBOUND with
the intention of offloading execution.

However, kblockd_workqueue is allocated as a per-CPU workqueue
(WQ_PERCPU). When WORK_CPU_UNBOUND is queued on a per-CPU workqueue, the
workqueue core resolves the target CPU via raw_smp_processor_id().
Consequently, if a task executing on an isolated CPU submits I/O and
triggers an asynchronous queue dispatch with zero delay (for instance,
upon hardware queue congestion, tag/resource exhaustion returning
BLK_STS_RESOURCE, or plugging), &hctx->run_work is queued directly onto
the local isolated CPU's worker pool. This schedules the local per-CPU
high-priority kworker (such as kworker/6:1H-kblockd) on the isolated
CPU. In real-time environments, an active SCHED_FIFO workload will
starve this SCHED_NORMAL worker and stall hardware dispatch, whilst also
introducing unwanted latency jitter on nohz_full cores, defeating that
commit's original objective.

Introduce blk_mq_hctx_unbound_cpu() to select an online housekeeping CPU
from housekeeping_cpumask(HK_TYPE_DOMAIN) via
cpumask_any_and_distribute() when executing on an isolated CPU, and
otherwise return WORK_CPU_UNBOUND. Gate the helper behind the static key
housekeeping_overridden under CONFIG_CPU_ISOLATION so that common
configurations without CPU isolation incur zero overhead across
single-queue devices, hardware queues with empty cpumasks, and offline
CPU fallback paths, whilst non-isolated CPUs preserve local execution
via WORK_CPU_UNBOUND. Guard the slow-path check and cpumask selection
with guard(preempt)() to pin raw_smp_processor_id(), satisfy RCU
dereferencing of housekeeping_cpumask(HK_TYPE_DOMAIN), and protect the
per-CPU distribution state.

Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
Cc: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Marco Crivellari <marco.crivellari@suse.com>
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Note: As Frederic Weisbecker pointed out on v4, workqueue-level support
(WQ_PREFER_PERCPU) is currently in development to handle isolated CPUs
automatically, at which point kblockd_workqueue will be a candidate for
simplification; in the meantime, this provides a minimal fix suitable
for backporting.

Changes since v4:

 - Rebased against v7.4-rc1

 - Hoisted #ifdef CONFIG_CPU_ISOLATION and
   static_branch_unlikely(&housekeeping_overridden) into
   blk_mq_hctx_unbound_cpu() so blk_mq_hctx_next_cpu() retains a single
   fast-path check and non-isolated configurations avoid any RCU or
   preemption guards across all unbound fallback paths

 - Moved guard(preempt)() ahead of cpu_is_isolated(raw_smp_processor_id())
   to prevent migration between reading the local CPU ID and selecting a
   housekeeping CPU under CONFIG_PREEMPT_RCU, whilst satisfying
   rcu_dereference_all_check() without a separate guard(rcu)()

 - Consolidated the commit message summary into prose

 - Link to v4: https://lore.kernel.org/lkml/20261022034737.47820-1-atomlin@atomlin.com/

Changes since v3:

 - Create companion blktests test case (block/050) to reproduce this issue
   and verify the fix (Daniel Wagner)

 - Gate the single-queue (nr_hw_queues == 1) check behind the static key
   housekeeping_overridden under CONFIG_CPU_ISOLATION to ensure the
   common case without CPU isolation incurs zero overhead on the fast
   path (Jens Axboe)

 - Wrap the evaluation of cpu_is_isolated() inside guard(rcu)() in
   blk_mq_hctx_unbound_cpu() to prevent an RCU lockdep warning and ensure
   safe dereferencing of the housekeeping cpumask while concurrent cpuset
   updates occur

 - Disable preemption via guard(preempt)() around cpumask_any_and_distribute()
   to prevent a preemption warning under CONFIG_PREEMPT_RCU and avoid
   data races when accessing per-CPU distribution state

 - Link to v3: https://lore.kernel.org/all/20261016052203.489760-1-atomlin@atomlin.com/

Changes since v2:

 - Query housekeeping_cpumask(HK_TYPE_DOMAIN) instead of HK_TYPE_TIMER
   to align with cpu_is_isolated(), workqueue affinity rules, and cpuset
   isolated partitions

 - Query the housekeeping cpumask under guard(rcu)() to safely handle
   dynamic cpuset updates without lockdep warnings

 - Validate that cpumask_any_and_distribute() returns a valid cpu ID
   before returning, falling back cleanly to WORK_CPU_UNBOUND

 - Link to v2: https://lore.kernel.org/lkml/20261015020225.422107-1-atomlin@atomlin.com/

Changes since v1:

 - Introduce the blk_mq_hctx_unbound_cpu() helper to steer deferred work
   to an online housekeeping CPU only when executing on an isolated
   core, preserving WORK_CPU_UNBOUND and local cache locality for
   housekeeping cores

 - Apply blk_mq_hctx_unbound_cpu() across all unbound fallback paths in
   blk_mq_hctx_next_cpu(), comprehensively covering single-queue devices
   (nr_hw_queues == 1), empty hardware queue cpumasks, and the offline
   CPU fallback path.

 - Elaborate in the commit log on the triggers for asynchronous queue
   dispatch (e.g. tag exhaustion, BLK_STS_RESOURCE backpressure, and
   plugging) and the SCHED_FIFO worker starvation hazard on isolated
   cores

 - Link to v1: https://lore.kernel.org/lkml/20261012012905.267920-1-atomlin@atomlin.com/
---
 block/blk-mq.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d9ab295be4d9..4657a3287f3a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2252,6 +2252,25 @@ static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
         return hctx->next_cpu >= nr_cpu_ids;
 }
 
+static inline int blk_mq_hctx_unbound_cpu(void)
+{
+#ifdef CONFIG_CPU_ISOLATION
+	if (static_branch_unlikely(&housekeeping_overridden)) {
+		int cpu;
+
+		guard(preempt)();
+		if (!cpu_is_isolated(raw_smp_processor_id()))
+			return WORK_CPU_UNBOUND;
+
+		cpu = cpumask_any_and_distribute(housekeeping_cpumask(HK_TYPE_DOMAIN),
+						 cpu_online_mask);
+		if (cpu < nr_cpu_ids)
+			return cpu;
+	}
+#endif
+	return WORK_CPU_UNBOUND;
+}
+
 /*
  * It'd be great if the workqueue API had a way to pass
  * in a mask and had some smarts for more clever placement.
@@ -2265,7 +2284,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 
 	/* Switch to unbound if no allowable CPUs in this hctx */
 	if (hctx->queue->nr_hw_queues == 1 || blk_mq_hctx_empty_cpumask(hctx))
-		return WORK_CPU_UNBOUND;
+		return blk_mq_hctx_unbound_cpu();
 
 	if (--hctx->next_cpu_batch <= 0) {
 select_cpu:
@@ -2292,7 +2311,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 		 */
 		hctx->next_cpu = next_cpu;
 		hctx->next_cpu_batch = 1;
-		return WORK_CPU_UNBOUND;
+		return blk_mq_hctx_unbound_cpu();
 	}
 
 	hctx->next_cpu = next_cpu;
-- 
2.55.0

