Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020088.outbound.protection.outlook.com [52.101.196.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F22BF3F3;
	Mon, 12 Oct 2026 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791768555; cv=fail; b=pZ+ijJ5Gr0YRxaSLHeoZQtLEahJlbsdMc9aN5nr8C7uLflTgrXf999H4tqUVTLjVqFUVnbCXJrEDvuzJrdvsRmBG7MGcSp/2onwANXZbiksMiv5EjtNsaj6hKzMLHjGTvVaXH9hbfZEr7Rn6O6a+F9mtUs2RAWxuPjDnLyprsFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791768555; c=relaxed/simple;
	bh=taW9B5hy6hpwTZ05nVw9IMW1U0q6lSexJKJ1GwnopYI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uzS/kqzHaC12JqN8Vn2AQITcxxggkxUyfv7UlBdfexwYQD2A3n/InOoBgz6fq7rOh+DvlKkS1zo58By4lh1XV2kY+5H9OaWjXad5VmWvgUzagC+V5rg42BE8VCNHvBR0c4M5UxNCMIiyYrPrR5V3DgUVrild+doCvgstIb62jTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxzB6WtqSsU1K3ob+p3pYuT9iDKMaeWRwQwjfhQpReBauoAXs/SHVcSITC0+3HXKxtJtexGS81zGAGRfRJpM5C6f+N0zYurm8IofK2Iy5cCQXigGFCb+YD5C83RkM0AQG9vZKSWP7bWrt+geKf9k0bjpVD0M7b/PV3QQd81OtoDXcus1NyRyDNYLYbNNedmyPPER62xhwvW61AB8kdvYH5EW55uwlyeWv9bjkjnSz8c4gI2RPGpyFujWz9ZrKu0S1CosNjm0hm6yD0cvkKRWl8Dev984M5uFZyOyebmYR84VyIiQGjUwyRDPVwBkw2ky5hQW520TnwYpqxp4fC08iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=hi20PcVx5j/rEk/BQ+7VtpcAYS5mlc7WpcFes2HKqmg=;
 b=M7sITXh+5kMZGu3eySPXtG4JUEK2Zbx3SGOjES6Ps1DHDSv6g1AtDWGT48BMsl+kZrdBU+2PN70hbB6I9nblo25tt2k2fHH4WnUN5CHx/tLMZKPy0+3GV42DA8yv0mrcE+XZatcuAE5q4BELxcrPXTOe1HpDh75j+Kj/fVFAtHJlrYQkNg0n1z0tMggJz+Dl4JDA8bmObIkErOntpIzjjfwig20OamwoRFiN6Lvun9drbVgN6Rrxkfxq6PJujuaZFPnGV+PToOc984jCuXkyCuNHtSdIiICJ/PTChZz4vyZB4KHeXHeRIM/xqs2UJTKv8kgtQjX6NwLgToJrkiYNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB7027.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 01:29:09 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 01:29:09 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk
Cc: tom.leiming@gmail.com,
	hare@suse.de,
	atomlin@atomlin.com,
	sean@ashe.io,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx cpumask is empty
Date: Sun, 11 Oct 2026 21:29:05 -0400
Message-ID: <20261012012905.267920-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0952.namprd03.prod.outlook.com
 (2603:10b6:408:108::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: b7359ab9-8210-4b41-889d-08df280036a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|18002099003|6133799003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HnpAb7CuceWRbdlZD6TqRJ8UPHrst+3ZEx7zQENGbGdqA/32fFJrsCJD0dblOk4+YV636k4yHFmVyav67A+XnJmoxdAmuYrl0COeE4pmJh9xiFSRY2oJY+NJxiQzcl8J1MKwMfVNayCgkZu4SChrRDJ2AhDFUZPu1LPK4mSK3q+IFWFFbU9AoTEg1W4qhfCXzDn9pHYjc8n4rT6FJ477zexAfw+xpD2vqQ0AQcaH/LdURYWiiAR/e7FTvKKjmjSmjnjjbdtdpMqzCbv695c52s1D+XE6LG3zqqKYuZVhRWGae9SzXgM8JI3+QcUbIQRJNq7irYvmQHzwhyPWfm6klYPqwPg45mPxIwxJKqCVN++3Jo0RQ5RXrfyIs29cdF7dOC92e6rseBQsDWozCZlLoyjek8tcBaaVOou1bQSM0RjY/Q3mjiMvdOHjIdur+UgRBzvj2mz4a+7t5Do/jn84u+hIPbZgmZYolrD9tPpnOO5FIADw5KA6732OmAtq1/0sztMoaXpG3DuJR7blZNb0DUT+MWTDsmsWXyv2CRGa9fMem4Y34cYx6MzC2dizyKCTYjE3XFbBl8H2lzDlIUhXshn5i4UlwOR+nGXOD+kBGpa4gOQ5pn9zuWM5EtvDsdDFodpx7R9eafLLpLDKiZclNbYrwfi4+fA7H01rBXLmHAk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(6133799003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QD7PAQk0cyqiRAmrJYozwY0Nx8rt4CA38ndDoqgMOCISUqrHmC++hie+QH4Q?=
 =?us-ascii?Q?CNOpdz06SVy5FKL2Q51OwQj8DN9TpuF9tgGyvh22lc+Osz0aLMu/u1KqjFbj?=
 =?us-ascii?Q?L5brKDASmmHt/frZGtAJqXLtzQZ3H4xD7WPsF77J5DgrmyvK2h7GJ2E6acx2?=
 =?us-ascii?Q?gLxmk9k6I/ILvze0PkL+5o7dYG11AKK9nl5c7FgWlqh4pWh/fN3MtZN7Bt0e?=
 =?us-ascii?Q?ghrpk2Rwj5qlMdSsnV7BpB2urYJvUI926Nfjd8R7mjaPmsxOamtQUkurXa1U?=
 =?us-ascii?Q?W0XAyQgq9UtONP9/HhNs6P4mIBJ0bA9RDuL8V7U7OFphGkJkLk20U+qKkDU2?=
 =?us-ascii?Q?G0hH1xQU1h1Ipon/R4/4bQmyjsqMwFMSNBS7oUgJquDhM5FYDKOg1gr56Rrt?=
 =?us-ascii?Q?aOjHMOmWFwmqRKThy4E+n6VIeRKBkHr2DfXwSpPFXFLRnlpaNHB+LO3766D9?=
 =?us-ascii?Q?Fm7H7NbuQwm7YTFx8m9k+fquHPpfzIcoP8GzLRc9eVmmXYksw70ETUOw0Wqe?=
 =?us-ascii?Q?/GPL17Vo9zdol0SSgF8HawUYXEo7m/oPC8gLUstqpCcir9vM7Q+j/ydYHfae?=
 =?us-ascii?Q?urc8VDrLKJDs1hLqvHH4x752M1W8nc/G8v5KlNJld+Bd1vA+XBjwYtdl0IBQ?=
 =?us-ascii?Q?DB9AIBOwGmCy391Q3MHq/1zvtIxMv+ilGzGbEw8z0cZlPPC3yiBsgB7XnARH?=
 =?us-ascii?Q?Z/ZNhwA+sJsPtoeftJFwc60V7blpki3FhPhVXtdK3jtWa+yZyeAjYiNTGYyd?=
 =?us-ascii?Q?n1BNYMfRV2kfn3IR0vAqQHIDjyIZYfYYzcnm3gMyuy4gQLy6IN4woUS/8HLZ?=
 =?us-ascii?Q?Bas5eq+P1RmByoOkNaL5/8wf8JFp6tNrAqmf0pGylXtqPSozFCJkvmOf30uT?=
 =?us-ascii?Q?cNIpFF7R5qtTcIA86aqj9S3Mc/WLYpIjB4nOVWHu5kLxOA/f9z6zaxbKGLGK?=
 =?us-ascii?Q?Ch9qTvdtNzlP98MGJi5Q7BkyibiifNluQaTMnYJ9QWnTeY9EmlY9c4s2MSCE?=
 =?us-ascii?Q?wifL8fEu4/iMWSOvKC7F8Z2BOK5IasUNjbedoe6EO5P8ttmRRFlEvRtZBcQg?=
 =?us-ascii?Q?acc5T5FHs8VlMI8jnnMzP/mrK+Lm5nocl7PCvMmjbFAZnoIaj5LXUsEB+J/I?=
 =?us-ascii?Q?biesZ+TxgtL74CojjMoIbXEUctX7tCoPjKE3AKPBSsABHsPzb0Qge1yGYk4M?=
 =?us-ascii?Q?WEcj6qa8HvBh+n4UibxflZbmVLXZYvvCR22KqJK4w5Bdbb59XSexPv5rYNoI?=
 =?us-ascii?Q?7jMu2JHFSlerwXLHnNM2zIXSQVuqJjp2hjG3ED6PThkfQIMsZAA7T6iEE0f9?=
 =?us-ascii?Q?SDcHbwLZ+Lbml4VvRUvyu0nKuu+MtXR4jo7HJdFgIGiOp+jFZymbfRccMWwJ?=
 =?us-ascii?Q?fpXYKaBWJ6Gh5VXl7RPE7Fmb5oFtnN8QnA3/sDBsngRePvoYBh55KHQ87PVU?=
 =?us-ascii?Q?GZBChakkR9NmLkFFufs3YH9Vma45L3DC9XvMv7O+eZ/rID8CEJu9rgpAUw02?=
 =?us-ascii?Q?xAnk1ObV8hIOW0kRhOF5cb7JnGZ3MT18u9P3QtLmlABt1qhukjCaPXElJu4b?=
 =?us-ascii?Q?egE3s4DSZsi9/BK4LqensuHyW2gJkkVxNNsStFjZv1n3lePOo4qQjnmRUExd?=
 =?us-ascii?Q?kbGmUrQWv7iCvAN88S4//KE3q434LEX4O9t4jtXqa9pLpbHbH57IBMJ9v9gu?=
 =?us-ascii?Q?M/RGWfq6zFQjX5tpyZejnJIO3Z4xRnVSn0Hq+bv9rAHPr0p4vAi6Z5nx1OJd?=
 =?us-ascii?Q?mvnDxkN55A=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7359ab9-8210-4b41-889d-08df280036a5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 01:29:09.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MW+uXnMa0SkOip7cq6F5hfOlH2CL14rtN51JunLt/Ey6v3vW8agsGt3fJqYXr60jYy7H5R40tBH/atfqspOX5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB7027

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
triggers an asynchronous queue dispatch with zero delay, &hctx->run_work
is queued directly onto the local isolated CPU's worker pool. This
causes the local per-CPU high-priority kworker
(e.g. "kworker/6:1H-kblockd") to be scheduled on the isolated CPU,
introducing unwanted latency jitter and execution delays, thereby
defeating the original objective of commit a46c27026da1.

Rectify this by selecting an online housekeeping CPU via
housekeeping_any_cpu(HK_TYPE_TIMER) when blk_mq_hctx_empty_cpumask(hctx)
is true. This ensures that:
    1.  The delayed work is cleanly offloaded to a housekeeping CPU.

    2.  The per-CPU high-priority kworker on the isolated CPU is not
        scheduled.

    3.  Hardware queues with valid mapped CPUs preserve their per-CPU
        locality and batch round-robin behaviour.

Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 block/blk-mq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 025a799f35b9..9480c3aac898 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2252,8 +2252,11 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 	bool tried = false;
 	int next_cpu = hctx->next_cpu;
 
-	/* Switch to unbound if no allowable CPUs in this hctx */
-	if (hctx->queue->nr_hw_queues == 1 || blk_mq_hctx_empty_cpumask(hctx))
+	/* Switch to housekeeping CPU if no allowable CPUs in this hctx */
+	if (blk_mq_hctx_empty_cpumask(hctx))
+		return housekeeping_any_cpu(HK_TYPE_TIMER);
+
+	if (hctx->queue->nr_hw_queues == 1)
 		return WORK_CPU_UNBOUND;
 
 	if (--hctx->next_cpu_batch <= 0) {
-- 
2.55.0

