Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021093.outbound.protection.outlook.com [52.101.95.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FEE231842;
	Fri, 16 Oct 2026 05:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792128133; cv=fail; b=W0d+52LCV7huPsvIxwgHIpbugh34N95rfbEsoX7x4xNzWmpWrGT2onpkxJrsH6ZUFGJYnWcOu2GSbGMF6YCCt/P8W/MasZ3xI6V8RJeREx4hnDh5e+6xRBYCYWttDJ6fxM2s0KYOCXODXJgTH3usJEdl1simd7qnqKoiyAJfFeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792128133; c=relaxed/simple;
	bh=3P0bdV1ChZu3cbghzWNr8WuKxquRYC6y4h38BYKFHsg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NbmxlgI4Hh+BFFLzi4hxqDEEZ0ATouQAENfsLi24AAlIObt6w6UoKzeoT99YaLRPTltgZSI5iuJ0TlEr5VGPauLPHxf1zEqUgTcK2rqrG2vq/B6FOgPI1md+1rc15+k0VxPIKFHgzUH44tG+VC80SK7tmDdR6D1W3XISP/uews4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXoCFZQkONubayyGtiz85jSub0ML38MARGp6ANS+pDDRtY9X6omAvFMXWLZwSYIqVr6jZChXBD0MTv//DMM5HSQMMs0e/rP94uK7Ax+Ir4nLPKwimtSSnfyMYvWaK2O8+h/mnM0t4EwAq55CnHf+5QjOeXRcRywg20FkamfOVht+YphTIdkkrkJWyct9cIFnpAcmKN6EeIhHuDYRC4qZDEGK+0rAOXxmnhWLqNFvZXw94jrPsFRJZwOlr1ou4CjxqaJL9veAKm37VjSx4Sr86c15WLe1hUJlljMgIjUqfpwX4zHeGSWRPHa/6gdvSuwMkn6UBa2agOSQ/UGxjvrKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=i5XJPVHXQC5TRaKVj1mb+Ti+YsDitD6nePEV1Rk4cmY=;
 b=qPnpnPQ3Xk5U34paliLsEhhPSbNv1MzM2ZHNXmhWByDHh8A8BNG7zq3kCDblK0Vvb+C8QAOPVrmPrKcZN1qmFWln4LtQBoLud+SuYo8UJ7FmvHCmJyCvpQNBeX/T4l7A27E7auAZeiUZ6OWw/DnnmC3iaZWDF4BPCp9fSJN9xagpl9d2hwK39T2j4lmcA6hBKq+SYGuRgmS+xj42P9T3qyQXnLsr7TeOjZ4G4PRv2xXwTaaD9YTaYqEaktU6DHWC10Gx61mJPT9pMdhowis51pt0oV5siZO9FDcO6knZLztHzGefAtZ9QsH7jT1uiHkmn6vcguQ1y9CCsED0io0VkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB7541.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 05:22:07 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 05:22:07 +0000
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
Subject: [PATCH v3] blk-mq: dispatch kworker to housekeeping CPU when hctx cpumask is empty
Date: Fri, 16 Oct 2026 01:22:03 -0400
Message-ID: <20261016052203.489760-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::34) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 2010ffe8-8fbc-4464-e121-08df2b456bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|18002099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	mTgoklNhcJSc0AaA3OiQqd7s8sfwow4u/Nvo1CHhmWiNtlYtmrYl/QM6al0SIJ6UTrQlT/i2AGNL73AQUZsAjSmpNI0Wl5TiW4yJW2LuGQ/SU6IdiU+eZUfjN44ik/WsKoTRadfvqvRAw7wbLyHY3GQqwS3EI2yhY/GJfD7IUmksij+pJkOTgrYNcVXLq+WxwsOLXj0KQIWq7pXWMuqy8sEXeZFdA0IULXRuQgogUimNfaaGO3bcXmEaTi/f1zUmHLu9wWqlqMq7cm1avRWpJOixaUDe1SNfflAFDYHgSs6ANUQtF0aHt+k8FxYXLc2V/xEyYdR/AT+EmAO+MxR76K4uZOe9cGZ/M3VZ5CSJQVbQkgfyUqEOuHjiWZmCeiT5Ix76LdZ46mg+53R1+jGEwLaEhhfX0C2MYNOrn5CModxCpuVlbYSC/7j3zRPUXdXgzzRHT2YkRlGXQKq0ZF5FuorLUgvQa9x6OLlP9wpqLU/y8Pc9ZZjoTC3w+pOXPp6FopW2uMEpE2LEmwZuKcsk3ZdIG+M2QJEx0YIJnnbt3h6fIW/rcyBYB3m1tnq3c5zr0j8/txRD9I0Ro+cEYmmBC3D47qcD1TItGCqn9g6y+/T1pedlJZ1U/Ku6CeRFoVTI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(18002099003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QwRuUx7l/7Ng1v6wdr7YdPn+izFWOrzQr1mWhpfKDStarsON/xfuZtjVFyx0?=
 =?us-ascii?Q?81YcvLa4F6yC5dzOT3qWyMhdTlwGFyaz5cgPt7oOnAhNhu5X6PJg3XaAOgyv?=
 =?us-ascii?Q?Bs9CBCLPn/Lxm6yZOD3O+DeMHWxfw7XiHcLQaPGQ2jCCDBfZKceWUMMhCueO?=
 =?us-ascii?Q?2phWuMj+0+yG15deV2sdxLfQqdmuCbHtAjZV+0OwOpJos8xDKysV8Tbu3qY+?=
 =?us-ascii?Q?46kJ4scegQirNSzdPC216RMXAN+ral5vBuaa6EO+XhSHIzKmPJLEf4ED2nZf?=
 =?us-ascii?Q?TQcdTZtElfKt0/KiycnT12rBQHq7o9HR2Uf7ewZloBihq6ianVEASVJyCkbU?=
 =?us-ascii?Q?CkP3jWZSzMxem05JniBeVO8ox8MFNyEcuKvzYYXZp4VeVvKP7Ke/BkXTpqXA?=
 =?us-ascii?Q?FTM2c4oiuQM2X4dlD7ipDInImvXxaJRS8RoDGSU4GDZcMerXMSAghemWruyg?=
 =?us-ascii?Q?8rdjlq10YPSdh6jM1ZaOMJomVz6TT1TfdDlIOmGp6Vp9F2S+in1Dtu0HQSkt?=
 =?us-ascii?Q?yCFeKzRFVu5OLMM5JcS5PWH4g0yaHg0B4p7YdKVj89Y6hk8u+jdZaP2oIZkx?=
 =?us-ascii?Q?8JFYDfbjuVmWBaSnVaSLIjSHx6kXYlFueTQ5b2ISocoAKEF897bCoSe9XNK6?=
 =?us-ascii?Q?A41Cw2Aro6c7KTFYnefS0h/eZWVNrQps8ixd2P1JzKVHvPTz4KZH5DR8syeH?=
 =?us-ascii?Q?OCurdmwLFSDV/fGIsTB6X5krzSytC74LItcm4bgs3y/gVFFkHmLDMqsBPXBl?=
 =?us-ascii?Q?GS+IpNH0/Bvuf8B3F+YkCw87X48jbnwPqxlBL4y9k4Lb38HWXVkpRixXvlT+?=
 =?us-ascii?Q?KGsp+tjxC3+dw9rY/73VUbvGvTI10J/cZITVTOf+usLt9aS7M+9qBwcprgIw?=
 =?us-ascii?Q?Vj4Ar+tKpO2UNhkmfgIb8OtRF+WdJNKIWTKGo5BjD4j2zz9P5EZJuLpXIa6P?=
 =?us-ascii?Q?dPreHKiuSzLIsEoRKrb5mYEYmH87pBdewL0iK0vE0jxiMXu2midLpwkON0M6?=
 =?us-ascii?Q?5ilJZY7bqbEjqsyoI+uwSjaKOaUhAiP7jAKeaQ0FQNWJv/aOOV+twZBDVMxu?=
 =?us-ascii?Q?HwoQdAXprfbNFRqTIMt+AzctSlV7u23s4kdG2hDzIvJ1q02RInSMxTIiMbnZ?=
 =?us-ascii?Q?7jGIVpQ/BCi4SbpJ1JtduldRCEf6o34h6SVaXxbEPBmEL0HNB/RdUK9T4gu4?=
 =?us-ascii?Q?F3DmwmPwtsY5qdeObEySWb3YhyVOS2PrmVg8tDfAxVRvKZnWSle/Vd3iJ2BT?=
 =?us-ascii?Q?64UH7ztTw4Xm71Dn70Ej9tckGsIQRe5Cko8D+knOU71mhFRONGu9ToR1jLqM?=
 =?us-ascii?Q?z6js/NoZUZMDxtLBs0WZa05YhR4nSSgGKGmDV9/TBYVNNQCbgAwv0T9wx0QH?=
 =?us-ascii?Q?u6v/XDtcMhISRV+5kcLD61JvP2KsBs/rKC2jFnpxaeNxSD/IeGUDm/AyjJN5?=
 =?us-ascii?Q?MfKA5oV7uuppVQpr8Eobh9tyZigBSgrF5sbnUH50ec/91768EKiOldCMx4zm?=
 =?us-ascii?Q?FBkZctdHxt/upFqGKVV4pQShECdHy03oxFP9CSAgEwB5ZnM7nvH8tmboDAgU?=
 =?us-ascii?Q?u8ShYoiJrnLBAqTCDgoPkqTi4gRmI85ZFhalxVdbayET55eJMrJ+1B2b7ni7?=
 =?us-ascii?Q?LyjeRJZosQprayMYQbLWNZkdy+zrutGM6PAOiMUCq5QjQpydtjk3SWoz2eHU?=
 =?us-ascii?Q?DrBTKlUlzW+1J10ozYi5gzpuKbPYcIGTWcrjYktiJxHi01NaywhAjhO32kZo?=
 =?us-ascii?Q?E8vw16c1Hw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2010ffe8-8fbc-4464-e121-08df2b456bde
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 05:22:07.3645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +n0Jixwl/gIXk71+9yexOLjS7Hmu6rC6C3zxPkcYah/dcDG4NUbAE+jAXgePE0H5KiYeMbLKbKCh3B+neVV5BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7541

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
unbound fallback paths in blk_mq_hctx_next_cpu()

This ensures that:
    1.  When executing on an isolated CPU, deferred queue work is
        cleanly offloaded to an online housekeeping CPU across single-queue
        devices, hardware queues with empty cpumasks, and offline CPU
        fallback paths.

    2.  The per-CPU high-priority kworker on the isolated CPU is not
        scheduled, avoiding priority inversion and latency jitter.

    3.  When executing on a non-isolated CPU, WORK_CPU_UNBOUND is
        preserved, maintaining optimal local execution with zero CPU
        bouncing.

Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes since v2:

 - Query housekeeping_cpumask(HK_TYPE_DOMAIN) instead of HK_TYPE_TIMER
   to align with cpu_is_isolated(), workqueue affinity rules, and cpuset
   isolated partitions

 - Query the housekeeping cpumask under guard(rcu)() to safely handle
   dynamic cpuset updates without lockdep warnings

 - Validate that cpumask_any_and_distribute() returns a valid cpu ID
   before returning, falling back cleanly to WORK_CPU_UNBOUND

 - Link to v2: https://lore.kernel.org/all/20261015020225.422107-1-atomlin@atomlin.com/

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
 block/blk-mq.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 025a799f35b9..1a113679f15b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2241,6 +2241,21 @@ static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
         return hctx->next_cpu >= nr_cpu_ids;
 }
 
+static inline int blk_mq_hctx_unbound_cpu(void)
+{
+	if (cpu_is_isolated(raw_smp_processor_id())) {
+		int cpu;
+
+		guard(rcu)();
+
+		cpu = cpumask_any_and_distribute(housekeeping_cpumask(HK_TYPE_DOMAIN),
+						 cpu_online_mask);
+		if (cpu < nr_cpu_ids)
+			return cpu;
+	}
+	return WORK_CPU_UNBOUND;
+}
+
 /*
  * It'd be great if the workqueue API had a way to pass
  * in a mask and had some smarts for more clever placement.
@@ -2254,7 +2269,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 
 	/* Switch to unbound if no allowable CPUs in this hctx */
 	if (hctx->queue->nr_hw_queues == 1 || blk_mq_hctx_empty_cpumask(hctx))
-		return WORK_CPU_UNBOUND;
+		return blk_mq_hctx_unbound_cpu();
 
 	if (--hctx->next_cpu_batch <= 0) {
 select_cpu:
@@ -2281,7 +2296,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 		 */
 		hctx->next_cpu = next_cpu;
 		hctx->next_cpu_batch = 1;
-		return WORK_CPU_UNBOUND;
+		return blk_mq_hctx_unbound_cpu();
 	}
 
 	hctx->next_cpu = next_cpu;
-- 
2.55.0

