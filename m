Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022129.outbound.protection.outlook.com [52.101.96.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B738DD3;
	Thu, 15 Oct 2026 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029755; cv=fail; b=WWG9P+Im4eGJHgL4udBUp/PFYX/8LLmkFbagazmJXeCFIlv7PYDzvIBAT0vjqf2NFg7lRYSx5WPo1/nj3dYUducgnfvhGLbLJPZxZVBs1WnHhF5HrW7HDMBO2oyF4j8ahLOitUxKbxb4YPsEiSwg54jV2IdWk6HrMsU12yJZiVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029755; c=relaxed/simple;
	bh=LmFqJKo/ZL36Hvhu+HsGX/jnLE47Wrm0L4MgTP6hre0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XocDDU94MlR+1BjUqMAFgKYttyd2bY3s00ffEpkoPHbqAo8vTt1x71qLKMQ/DM+8lcwAJxr3APMjAdzxF6Lpj72H7uzv79khqD0wYaRH/20+OBBM5nuFIbK92ntlAiqTx5G56aIb3ssAhFPmWOhplURv+AMrMt6+1kUNirOzPr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6pWJH05BYTfc6XQywV481OncSzO5uYWImCcbzTMxhksAaZhRrXOlou9JbSvxE1P1pc3kb+zzBRIPofAbPUBn2g0tkmPeMJapxI2R0XNV0GPm46k5tD5MakRVuTxyscvnkmV/KsXMY/3LnYC5c5865ZAjfjzyzc+oCP+aKAlD/fYcSriM4JT4ETNBQSlDcc08wOL0v7v5IXZDHyNuVLpYHU9ScO4g84onFQGV71Ep+tcRKMFhWS3CE8X7o7WO/5K142hESS8ZkX/37hWYsycmiMteP8YRJ2RZi5Wm3zghR/sW5UPzYcD4sImOPPvHTpis7xXPLJ5GQWDU1KKRW3YgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=LKCmTLBE0nLTNqlkTW1dHWmovKsHW0QlP7iBP1IPDOY=;
 b=xWjLW/4vhGsuIscQyldMoFFLfnPfYrDmtdBrLAHDPQsocjb1w6nG7UuP1EUhKgd5DGJHFFM51vUaVwaMYeB/HC0x3YZTP9dbzU8eCiWgwfIGyDaxVC5gnCrHTIVx7bq78FqjF61gc34bPrQoyz5yf7BU1mfHnAZ3w7GSQDCE/tubJTI4PimaZ+TWPAKqw/r4D7VqTI16Dtg4Ugs03v/ii6zCeu18s/SMGH2mpam2GZCR3yp1Y7A+NjMBzTIdtFt2Okl0bGbgDyVSxB6YBcY7ih3Y8UrihI3pz+hc9/Nm4kRwB4F9v9aRWOm1FZGeItwuanPKEDToCt+dYALbg0HLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB7410.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 02:02:30 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 02:02:29 +0000
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
Subject: [PATCH v2] blk-mq: dispatch kworker to housekeeping CPU when hctx cpumask is empty
Date: Wed, 14 Oct 2026 22:02:25 -0400
Message-ID: <20261015020225.422107-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:408:f7::24) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 361c62ec-35c7-4b4a-dd31-08df2a605deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|261009223027099003|10067099003|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	8fYNglJsBpqQXLoSPYiuWOSTTTChrG5ONsx0ytDu+Nhe6BvO5sRAe7Tf5NVr6apaOLKGHufNwtBheSVpNjiGh19UgDsiHWZIQE3Ye+o69TE4iCj5kpet0fL99nSjJ8v0d4rY2Tyb6iAbLcCGe1zh1OxMPBWW+LtcuuQqMNlb9F5OPbQYiNOtkzlSyGywiXm+yEY9SYTO8NR7H86jPPrZZ3naQnp/UQSLcGSxQucs8Aaiqx0YKK560AOcGBOY8jkgHBAeW15FMAD3bMlXs6ZJJOnVWEjKn4PON0x3v4C6GubNnWuOsFx/iGz3KT0fZWeqI3eloiN4IFYWX8moJgJSs9uXpG9eBgxABYtWA3tZDwi1xWUw5zx9bpV9nozxTkSRVxWnkVed/CBMorxdd8jibNFofLzZxDQSpiCwpBJitGq4g2BK3ioKoTw6wTTwtAjAQESWj6TY7QrlHv/CcQY0UmRT9DqUui9CNPrDHDJt80eFsDDiS+5XE1HSxig+3nwKhTOWlLD1Hcp5AdBicg6PdXfNiJIr8VjbHEfZn+lXf4yaibaSSyu7poRs7vha03QtJ5c2lUUtrbVwVxUCI/rEaTZ3Zr5cW2Hytn5cHfb7NENwI+GmcVMb1qHZRxmAsX5/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(261009223027099003)(10067099003)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cuGVMnY8sYb2Sx2VFRv4S5OB/4vJQUjddMLZ7cxJ8hlqkB7VSAhuPQYPkjQ3?=
 =?us-ascii?Q?KbMbZgEr/dQEQ/DNWaefoV1AcsMACjJYIsuLnuPUUa/D5RJbFb9znRw1+l65?=
 =?us-ascii?Q?+UDCH5ZHjIqAckPsFc5Uy/1tdPNUISZwnSK7pCF4nYAYMJcV7LTPcvMQZ8zw?=
 =?us-ascii?Q?CcGYtgr9zXSDwrDWcPZNWax2pW4qaJ/7h1ImZCo05ia2vpKlXZ413zNdBb9U?=
 =?us-ascii?Q?MUiysKlMApAMhwLVN9YmoG9FY203vU+r7o8PfEX08ioyKefnbpzCcnFd9RG4?=
 =?us-ascii?Q?xNfkq9hN3ZbQpPCQ6SURVM5kIbzSPeqRWSUfSn5ok4k220tqyJhINnWN3L8w?=
 =?us-ascii?Q?sL6b+jNcby+ifIwDgi58xLoFq/yAJGnofp67NoSioUvQtQe+tIeNz2ivxGax?=
 =?us-ascii?Q?0HxPU6UTgeX+V48dCxuNhWq8/NMd6yScHK/4Vmrcw3joGJIfGwY6OYhqtbSF?=
 =?us-ascii?Q?Od7rMrWJIkXNEnQ1J/lYRj5WRC/rQ+zq5vlCJ8c1mMYp/UDauDDQCDOlwAeY?=
 =?us-ascii?Q?NfVXSZGjBzw+XKOzZ0VxQOlOZh9lcb/yaHanA1z9qVyRtlsJO5Wht9rFiHF6?=
 =?us-ascii?Q?XzBR7UEmFNtS6P+5jbfA/zkyopx1qTRqI5q3nNJegON3/wKqP1SGhPsR4D78?=
 =?us-ascii?Q?wS0H9xh5EDTEiN2/gWWmdH1a+9jxi+4siLxWP/7EK/SOPT+1UFUsB5abb6A8?=
 =?us-ascii?Q?AK34fJNAO2IUPtpf4ZT4/9TdzJUaS2Jif2tIVRnZ4pi/D/LZgj+tNIcuAuQo?=
 =?us-ascii?Q?cY0HTMu4YuP0Lk5PQCnzTGG0mEohT7povZN9aN0NJK/0rE4DJToebehIJ5kG?=
 =?us-ascii?Q?0XStvKzgHjIRFV6PtNuLr6cbPqtvaUN0cjbBVhUOkpHjOjvadNrHWHn/Kd87?=
 =?us-ascii?Q?4tBNF2Urg/VwyDAyqTnsL4KDgHNITkDmmRpynDdS8rPiePQLkKr6i1RHtCje?=
 =?us-ascii?Q?BjYToDW0vVvjVCBjUbYnM91EvzezS5/++8BOhROpUvkp/sF/XPXyO7HC+2+Y?=
 =?us-ascii?Q?/C5dForM3AGsWLJiMcWjazQHxuBNL75pm+6wPNfUdiy0Zrqo+9kaDPX6iqsl?=
 =?us-ascii?Q?eZLb8A5qlt7VjBHuCUSHhb1fR7SDQdYs0GFoSlavry0br48uwj7A5zUdzZPl?=
 =?us-ascii?Q?8nCHvpMBl3mdjxpu5AtiTQhPTHwuBsc043IevIcx9vvBy2QzjC/brnTNgt+W?=
 =?us-ascii?Q?prISht7F83pPGB+NwtstrRsbCeQRSFNnuo+eADAAeQHWlzpdotxnkRUyIVnJ?=
 =?us-ascii?Q?0p3yDe9t83rSMKsBm91NsVHnvMaSEi5/PCoqOOdyyNXMfMRPUqB5+DJD4lem?=
 =?us-ascii?Q?JqdK6eGhrlDjZPGVChLkb5/xk/624+i8Qg5mJc3FZbmzWSdsvVKh222oVgNf?=
 =?us-ascii?Q?2SvuxsoU1YQzKW03GEFzDtB+vcxAfAp1HWIjjvcUzUOfLkaf3ePhkoarGhnJ?=
 =?us-ascii?Q?zxAunzzC+fY4ndkGsn+vuKnRGm3SvtVwAsQ5u04f4O2/EKaH8adwLSifwXzj?=
 =?us-ascii?Q?PTASfyrj8Fg/mF2XIqSG5dzpX9q7NCLhy6hcoeZSnbO9KZAPKMlCaHEBSyc2?=
 =?us-ascii?Q?6E8pisIKX41T5wn8V0dMqCihG0Nv/8AAIrndI0gY+ABalntEqRMY1wWr1VRS?=
 =?us-ascii?Q?0qflsGDLYbFNdeq5VuYdYeKZCNN6H1oN4cHZAS4LkKjvfe7wLPJN6qAwV3og?=
 =?us-ascii?Q?YO/k/1UM/5tf418NEKmFzb51VrFyIf27RbfKVjARj18oifYK4TvOB8IyBx3Q?=
 =?us-ascii?Q?CLC7pEHkcQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361c62ec-35c7-4b4a-dd31-08df2a605deb
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 02:02:29.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Brau5zPiz+2MMJyaRTzaSJB6p5t5BDFds9Ux/MpnjDIZw8exws3wCxPfk8vDGhT/Jqug585z4p9wzWRtI3kqYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7410

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
via housekeeping_any_cpu(HK_TYPE_TIMER) when executing on an isolated
CPU, and otherwise fall back to WORK_CPU_UNBOUND. Use this helper across
the unbound fallback paths in blk_mq_hctx_next_cpu().

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
 block/blk-mq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 025a799f35b9..df6103b91e60 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2241,6 +2241,13 @@ static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
         return hctx->next_cpu >= nr_cpu_ids;
 }
 
+static inline int blk_mq_hctx_unbound_cpu(void)
+{
+	if (cpu_is_isolated(raw_smp_processor_id()))
+		return housekeeping_any_cpu(HK_TYPE_TIMER);
+	return WORK_CPU_UNBOUND;
+}
+
 /*
  * It'd be great if the workqueue API had a way to pass
  * in a mask and had some smarts for more clever placement.
@@ -2254,7 +2261,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 
 	/* Switch to unbound if no allowable CPUs in this hctx */
 	if (hctx->queue->nr_hw_queues == 1 || blk_mq_hctx_empty_cpumask(hctx))
-		return WORK_CPU_UNBOUND;
+		return blk_mq_hctx_unbound_cpu();
 
 	if (--hctx->next_cpu_batch <= 0) {
 select_cpu:
@@ -2281,7 +2288,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 		 */
 		hctx->next_cpu = next_cpu;
 		hctx->next_cpu_batch = 1;
-		return WORK_CPU_UNBOUND;
+		return blk_mq_hctx_unbound_cpu();
 	}
 
 	hctx->next_cpu = next_cpu;
-- 
2.55.0

