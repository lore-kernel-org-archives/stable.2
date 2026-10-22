Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.119
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792640866;
	b=DXzXsRALCRE2Rz3dd57ZKNrzoRlEs8sUgGIbz7PL1q8Y/9WRjECmc72uYAwwDWqGXMzA
	 cKcxlPTiOnBWiFy3pUx/5GiL4Xkt6Ky8yUZZhtunG+MNUTEPKjc0iOk5eDaXQg6vON2lv
	 UyomFJU9UaGMr+uoveic49Q57MJCLMwwJBdyexpjXYgdnVBtdcr8tIYKyq2ZtoKUEGCyi
	 ClXxgKBKkyNGD1yQSQ6ygpWpSQXt4+c9gYvHXyOGpreiLNnDb/iWI3oJznJUv+J+qRaLh
	 1fdON0IT4SB71f8n2P/jEQEBu5hyGwdzIS3J6GQ6S2/QvPdJJVRRAbGIzTmYO4fX8qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640866;
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
	bh=7o/OKGUqzASBzZxe4q5udcwgWGBSzO70TxMF4mJ7ey0=;
	b=Yofx42xsBBrMsuTF4mVtg1NePfr29UstmsQZZRUwdmiOL0D68EXq2tYIdoNVD7ALdSni
	 mFImcunqdCAe6XazPT6b65cUGbunyYLY5uSduEa+We8seuS0NHbHk4ming0+/oYbidFvy
	 hIC/QpMh3lFJW/jXK7HS8VkOz8lbaOs0AoJLufdDMX5Bykf9eI3DviFDZFZySrmQHleTl
	 UotLEPZoF3BMAHbmfiB6ajgatU25VhD3te5wB0ns3ewcTLkA9BqbFKTdCRbDApGJfKKh1
	 QxPWfDXDHWl/gJyfRsQyamDFYZVe41UVaugs9Pcxi0jGE6en+IxjpkD4md2W043qatg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.119
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022119.outbound.protection.outlook.com [52.101.96.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A003606A31A;
	Thu, 22 Oct 2026 03:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A003606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6I2KI2vtEvXX2EvkR1nOAglOtLp2nGHXuT8qz2Aafx09DhWjv9FewGwY+ih+uMLHa6PRDq3rU4xSQ90GXQ2LOGBB6sS3PZFBja1NJsiOZxJ/iLlDLNyRmuQGJQN/De0CcGLDb3SmSkS3luRWMz7+5WWnHdpAmPdXDBhr1u5E6aCDTii7LZxQ6ArE9h8Awx6i+apXnuNFDb4coPqZ6WB0sxRyZjQq0OT2vduk4ColXmTGUZljl15w0FrZVDWkQ+BPwN2cLyF+HG79q3zjBRkvrZx/aAMqBKGQAwauhriWAeLoXkdpyDgXakFI4pPKIYjYOPBq37m9dKu2EWpDEg8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=7o/OKGUqzASBzZxe4q5udcwgWGBSzO70TxMF4mJ7ey0=;
 b=hjgOgRcyK+MVFpEQgcTKSqDJhHwbCNvhzXAQt3n9Jx8Z2PTwbSttpq4gRV+7zMhnssfwHw7sYjBC4w47sQ17owoZMjKIcplzx60u6CsmaQqZxonzdtlQZl+iG9E1C/nF/zOndaYYmhhzWJyjqx4YEeOkvzqgBXN28cPaycwycwClg9No/lhC26QeV1CdSxi+iTKxyPdrlitQYqz7bBAilejh5evhsXQwyz911eBmk/D+fjpaEFMr5IO/1ouHQLnZ5/pvbDtEx6a7MtD7FTS/f4e3s4C1JIqPjFq6JCdz/P0k91m2IZPwKYa2Cv1Q1F9OpLby7D7SvN+QcPZj4uxvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LNXP123MB3723.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 03:47:42 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 03:47:41 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk
Cc: tom.leiming@gmail.com,
	hare@suse.de,
	dwagner@suse.de,
	frederic@kernel.org,
	tj@kernel.org,
	atomlin@atomlin.com,
	sean@ashe.io,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] blk-mq: dispatch kworker to housekeeping CPU when hctx cpumask is empty
Date: Wed, 21 Oct 2026 23:47:37 -0400
Message-ID: <20261022034737.47820-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0497.namprd03.prod.outlook.com
 (2603:10b6:408:130::22) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LNXP123MB3723:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca804fb-a2c7-4e16-ad86-08df2fef394f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|261021123027099003|56012099006|261009223027099003|10067099003|18002099003|6133799003|261021121427099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	RptQp62I8o7jvV+XwrBtkQtfchE1RfgKNZTllMQh8aLlFYYQe1Vb+8RLOkgRE2AHu/3tNrZ7p9wNF66hhTjM1WDxHvnArpquQzb0+c4/f4xuR5oGLCoYLsVIbWDVnPocyz00mBxktcyu4Tnay6NeSWNpO0hrCMkTNs4i78Tms6eBErPjcEEXvlasOHEKWLurv42I/mbt4x3eTXUS4+gwJJBV868oyfu8WhTgT1PRMHo85jZt1fHaUdaLROEDPhTvDjyMwx+YUl8nPp2/k6+heqnFldLme6A0+mlhaYSXDv5V2WjL+MRmwyABSNbC6SIfHVY5/7LHp+cx2K1/skX94qnh4tDZev3JUkQNPP3Qn0/uJMXViED2TEHJHtji6yDELbkagWx5xaHNHQFE+kou+f3lX/5oUr1N3yMaIuDLy6fjap44OAitLReDfKNlubjw2Qv/1mmu2hwKj765tBjrG70oa7Nwi1RvCH6ilBX112l5+OM9FdYCdbV5LG1fBimt4ZI/4ScM68qphTdcxoZbYm7gN+MDTSS8Oqzv7XO0LLRlq+livOxXB9ovFuuf6lJUv03ZcHy70HfIfZw3QNp34xe3qzEZYeDRQdy/xD45pXckjJQmDI0NHGBWbwyvBDCc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(261021123027099003)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003)(261021121427099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hlW+kc6D9msnKlnwP2ep3/rAn8mVMwNeQJEgoUT8NYlX1KN8Ri81f3KR4xDZ?=
 =?us-ascii?Q?yYjOX16MIBKJwsLesWsEENh03sBtBtTC7PTCI0Inwg1s64V5er17OtB6pULk?=
 =?us-ascii?Q?8tYoNBT+n1Wn2PUGfsbihYBii7kZoHDNTszxbf50dBnrX9GkoFYAgT9zcuVi?=
 =?us-ascii?Q?uZfkzi025kabIDIaiiG+uoy6MRUVVTNyryYHGyzDeJ2pTTFI1w0SUGJsqBLo?=
 =?us-ascii?Q?ao3fKAawOhZh21r/wCn5ATfHDMXdJfOUh/+Rzp1exp8iiRR9sITP/ieCKMZ4?=
 =?us-ascii?Q?QSyYcr1e0xM4TaV9a3YiGMlPJtjcOczXsZ48uuJmCqwEhUsCQtfdygGcZ01j?=
 =?us-ascii?Q?BqS6VUrRAOJWd6lnhwFMS4FUMOqDm9BkQRb5JfOg1c6llKVttvILzPHOESpo?=
 =?us-ascii?Q?LqCNrP7xcgQy0KLVcBNg7hd9enqud5K7FP1+SA5NK1FT1Y/fePUnOdjPyFPD?=
 =?us-ascii?Q?B30C6A+Egg/xc1iT5jItp1HFtQYlZLjqp+6SMPClBPR1O3aTAUvkccvSV3d2?=
 =?us-ascii?Q?WmC+jm73fSZ+SLy4UEGgPy+FbaagtElAjz+V9PFSzHaLCPz/F6Oc5T1RB6yJ?=
 =?us-ascii?Q?vSvVb0BFGY+JWcutipyKdxEDqGPfJ7wrHUuXiAOpr9tE/j1oB658Zy0uBXHW?=
 =?us-ascii?Q?RvfuBcUc9IVS/XztI25f1t9vOHAYASvkedoBECZlGTc+mNfbVXBC5nULT39Q?=
 =?us-ascii?Q?w0BiPC+TMoSJLb4+a8jUTlKtuB7ppxR+Mk/5rrG3OC2mb04WJgjEwHNrEJlf?=
 =?us-ascii?Q?y/ZtX8WLcj3Z732DaFf0UO8xMGklO5c8KeIEy0G8JRdz6MtrGrvagGJEBEuu?=
 =?us-ascii?Q?wwe94bMDjm57NY4NiQmfdbZk6V2oRoO1d2BRbAtZgUZ8Am7kH0cvCSvD+OAA?=
 =?us-ascii?Q?UrHJbBuWnW+I0AmEiDuh9abeYVBnUBWz8PLU0dLqQIbbgOUpu9HwdfGbZ9pJ?=
 =?us-ascii?Q?xvH5+mNnWsPWD148LN0JKI2yPLloWJuDn6VKKQ/ab0dF2B0OwZOE7rt95b7i?=
 =?us-ascii?Q?uEU8Ib14XEGz/vi+Q6jti6Dbt4kMfZBar8QhXSzC/ctFF/0QJH0fdIr96Vn/?=
 =?us-ascii?Q?E5U7Lwf9e8BXMh8sYuXipoQvm/+wpb4T8ueb7CNa8pf+Q5JGNjTbHTC03sLu?=
 =?us-ascii?Q?sTF0RCGzJwHbFFSxmYBORIjoEIRxAVKcjrA0zyDA1lGFrdLLuEtKpHipl271?=
 =?us-ascii?Q?RAqUbKneNMbNik3o+ldyOCYg3VAdNTQfT4365bxmyTumStmc09c+qczRiAxH?=
 =?us-ascii?Q?iLAgXQKOif6nIe5lK+k3Th8rQEL4R5ct/exwIYaJ2cttY5rQIEmD8Jng+xRj?=
 =?us-ascii?Q?LhCsqDjQTjcQgnbzrFj8sPmrUl8PgisbD6xrtROhWEbnzWbgnnmy1ChGgR7v?=
 =?us-ascii?Q?zJN4YNq/noSL5LXtOz/qktCYg6DEJa0akbpIb0J+VKXovJxm2ypwyEx72Z4Y?=
 =?us-ascii?Q?cF9biVKN5PHYUqYC3/prBE5ObKf4AMt0G7Du09RycIS/0AWdj9CYe+IpEYKd?=
 =?us-ascii?Q?AznjGByzpgcyl8/0QD9SFk1qf9Qe22rJHt3XUBW0PQJnO9GO5RpO573+84WZ?=
 =?us-ascii?Q?s8HUfqVoeEhMpn/ZJe4anTv2cFrBLcyb3yJLA5R7A3BLDeSUhmCjz+CfIFRR?=
 =?us-ascii?Q?AntplDsFFmHoiRa86vjOYj4hiXB+oB7KkPMOmwunrX640Dh+qTt5J3ZW88WU?=
 =?us-ascii?Q?oLH/lguLTI6Lzk+QZrWNUWoBrxFjRopbbwlWs1Xe1ybdZV6I/AL0Fg/Rw1E6?=
 =?us-ascii?Q?Gudat0RsHA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca804fb-a2c7-4e16-ad86-08df2fef394f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 03:47:41.8441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pTkgUprsUY2L9RUmAQrEEXg16kTd3Y/T3Kmp8frdQZC0fjUh2ugFu5571Yiq8gQ+t+mLLxCAcUFybnaDCcXPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LNXP123MB3723

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
triggers an asynchronous queue dispatch with zero delay (e.g. upon
hardware queue congestion, tag/resource exhaustion returning
BLK_STS_RESOURCE, or plugging), &hctx->run_work is queued directly onto
the local isolated CPU's worker pool. This causes the local per-CPU
high-priority kworker (e.g. "kworker/6:1H-kblockd") to be scheduled on
the isolated CPU. In real-time environments, an active SCHED_FIFO workload
will starve this SCHED_NORMAL worker, causing hardware dispatch to stall,
in addition to introducing unwanted latency jitter on nohz_full cores,
thereby defeating the original objective of commit a46c27026da1.

Introduce blk_mq_hctx_unbound_cpu() to select an online housekeeping CPU
from housekeeping_cpumask(HK_TYPE_DOMAIN) via
cpumask_any_and_distribute() when executing on an isolated CPU, and
otherwise fall back to WORK_CPU_UNBOUND. Use this helper across the
unbound fallback paths in blk_mq_hctx_next_cpu().

Additionally, for single-queue devices, gate the check behind the static
key housekeeping_overridden under CONFIG_CPU_ISOLATION to ensure that
common configurations without CPU isolation incur zero overhead on the
fast path.

This ensures that:
    1.  When executing on an isolated CPU, deferred queue work is
        cleanly offloaded to an online housekeeping CPU across single-queue
        devices, hardware queues with empty cpumasks, and offline CPU
        fallback paths.

    2.  The per-CPU high-priority kworker on the isolated CPU is not
        scheduled, avoiding priority inversion and latency jitter.

    3.  When executing on a non-isolated CPU, WORK_CPU_UNBOUND is
        preserved, maintaining optimal local execution with zero CPU
        bouncing while avoiding timer pinning hazards.

    4.  On systems without CPU isolation, single-queue devices maintain
        the zero-overhead fast path via a static key.

Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
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
 block/blk-mq.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 025a799f35b9..f8f862a0e525 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2241,6 +2241,23 @@ static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
         return hctx->next_cpu >= nr_cpu_ids;
 }
 
+static inline int blk_mq_hctx_unbound_cpu(void)
+{
+	guard(rcu)();
+
+	if (cpu_is_isolated(raw_smp_processor_id())) {
+		int cpu;
+
+		guard(preempt)();
+		cpu = cpumask_any_and_distribute(housekeeping_cpumask(HK_TYPE_DOMAIN),
+						 cpu_online_mask);
+		if (cpu < nr_cpu_ids)
+			return cpu;
+	}
+
+	return WORK_CPU_UNBOUND;
+}
+
 /*
  * It'd be great if the workqueue API had a way to pass
  * in a mask and had some smarts for more clever placement.
@@ -2252,9 +2269,17 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 	bool tried = false;
 	int next_cpu = hctx->next_cpu;
 
-	/* Switch to unbound if no allowable CPUs in this hctx */
-	if (hctx->queue->nr_hw_queues == 1 || blk_mq_hctx_empty_cpumask(hctx))
+	if (hctx->queue->nr_hw_queues == 1) {
+#ifdef CONFIG_CPU_ISOLATION
+		if (static_branch_unlikely(&housekeeping_overridden))
+			return blk_mq_hctx_unbound_cpu();
+#endif
 		return WORK_CPU_UNBOUND;
+	}
+
+	/* Switch to unbound if no allowable CPUs in this hctx */
+	if (blk_mq_hctx_empty_cpumask(hctx))
+		return blk_mq_hctx_unbound_cpu();
 
 	if (--hctx->next_cpu_batch <= 0) {
 select_cpu:
@@ -2281,7 +2306,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 		 */
 		hctx->next_cpu = next_cpu;
 		hctx->next_cpu_batch = 1;
-		return WORK_CPU_UNBOUND;
+		return blk_mq_hctx_unbound_cpu();
 	}
 
 	hctx->next_cpu = next_cpu;
-- 
2.55.0

