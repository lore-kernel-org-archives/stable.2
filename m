Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795861563;
	b=Asz2VH4S3c8GxyTOafddMfjk66rbdbPRJcYhyGoVt4xnD1e7LtcvIf0jdZmHjpJ7C/pa
	 4VCQyg+swXk+xwcStUiChJlyVBq1u13Tg/ZpPREX49A/jAUzcFai2GegJd44eR46YWb8V
	 r0RC/FjdX9Ev8rudqdYPsBYFcSCUDwDsXoswqSfkEsu1RS2rM2f09E5qgssI4Y62p1Pg4
	 mS93hFlvrvbqcvH8Ayg5eyT48w9q8VKadsx6C18YwVXls/ClF5iPOViW7c3hQUVFsOReG
	 SntYGN/2KtRfFvSd/Yie8jPlJ9z2wYd7e7WJMMlN/wlYzP0fqQDU7z4RwBhHnvMGJ5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861563;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=vUZAV1PEQVt12kHTO4y6UWeZRP/jng0rcFrNs8UsQJo=;
	b=IL+ezzy4cX0t8cLFCfW3T+1YBmT8KY0BwjQkiNEVIXLWo6KeCczsAnh6c7aF9LYuWkf3
	 g7atG1klUDIYEp2VmFw8l6VZKIDpnyGosnIu+mu2XPOiHUJelX+RcmZuEFfDPD2NLbz4x
	 ZgiN6Q5IspJuJUE2NuFOu/k+nN7L5V8/NKAMlJrL6ZOcLXtcBosdxHMc60+4otzpxONZ+
	 AVYLnRGesWc/HCFafEljLfQWftDnX5FhNEsWxzfpg5JXx4FKwYOh7lVG0zOdzGgkRONNp
	 3HfSSiFgQb2gwXH+tsOwrj48fx+ukN9GblU+HE971ffBw9RRt6nLvv3sS1Lhlz7Re3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="g24b/+4M";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.38
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F4F606A31F
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 10:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81F4F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g24b/+4M
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLalBPQQVQemF9DzbKTcNUAyxSuyWo/vCIrYdgbwwVv752LL495bFk6G68aq74odBmr8LW0mTorh9dSc4gAI/51xm084jXpRWclSQ1nBRleEZjT8qB8v9XhRwBfInoCyPB5lk+2dm2gFvqaPCMMyfVZ+q6Kta1ZXK5VYONBC8TAej1CIqt3h3mHA6f2si2MENIPYWSioilYze/34PK8BPfkW+md3kvCeSsAY0cF8LaE+NZJckOKb1w86HvrtADnUV5POouwV8foXbtKJJw4H6on3fzwDDU++VQGokAjIjeIJcfCXQcXBVD9MwLIZCY2dvAa+cydQidUe4X+W0XLbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUZAV1PEQVt12kHTO4y6UWeZRP/jng0rcFrNs8UsQJo=;
 b=MDtSq1SowkJiMA2/LfdDXJMiGEIq9s5Iz8/7DcSJ7+PN8ZdAbTMZJKXIErbgPp0Sk8dq7s5ahNWquo/r5k2O2iQhESo6b24p/ozQjyjpd9LMQDwJ9LQ2HDdwIIq5vaQMk9WqygRqLWq7rFxdMgoFOkPfmqWJfYT2L2XnQoOIsInj+tIX1P2bq5kcSGHmSbo24XQkI98r6Bp+eheN4S9A8Nef6LeQ+79V0kYbZIGNXpxJGI2uXzFs2pnRf3J41n+HZF/JfOSkkYyu/8bA6vPTAvUoGWtN3OiwIoa7HdsZPPA5RbE7f8Bdmu4JI/PprZErae7dQU0X7KP7pNFyLXjmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUZAV1PEQVt12kHTO4y6UWeZRP/jng0rcFrNs8UsQJo=;
 b=g24b/+4MKO541+gQzpujPyrcSL3XQ4gmMTWaSOv6BegWLQ5EVwJSKhtB5/mvXGFiIASMxVNUXXuZm74zD8JoYHU0xmCa8d/71A3TsN5Px7QJM8GVvjlF0tLX5KpfT1yfulB/lDvnZR41LWwPHN/0Yc28moFHCsuEJfoF7aIhso0sadwR13xrIuQujWWjZXHr4miAskyw293ENNORuOkwHWsL+rDKns8H3gV/uROM7hh0PJPLMNzndDyvsF0yItlsHtpJOEsV5kof8xDncz7bo/bgXUUY5ztI6ITgffjUWxVd8fEVR8zr6tw3OlDIY2MJwhk6zi1Gh3Y5Coct4fIYMw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 10:25:59 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 10:25:59 +0000
From: Andrea Righi <arighi@nvidia.com>
To: stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Kuba Piecuch <jpiecuch@google.com>,
	fangqiurong <fangqiurong@kylinos.cn>,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>,
	sched-ext@lists.linux.dev
Subject: [PATCH 7.1.y 2/8] sched_ext: Don't run ops.dequeue() with a DSQ lock held
Date: Sat, 28 Nov 2026 11:23:45 +0100
Message-ID: <20261128102535.655465-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128102535.655465-1-arighi@nvidia.com>
References: <20261128102535.655465-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF000016A1.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4f7) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: be262984-4f80-4dd5-cab0-08df4d39fed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|11063799006|6133799003|5023799004|261009223027099003|18002099003|22082099003|56012099006|10067099003|261102123227099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	ISrnwODn3FBGanq4Wx8rAnp4dARXUWpyfORUEeZ5u6O4kmhEpfISdhacoqqffjtST6cWWMnWNBYk//dzpE4NwFi2bOYsJhPtFQDZfHLq59Z39c77YkhnFdbyBkTxEJ5FxUcVL9bBAwRyZ6Aw3AiBTAdbBKTTeCugE1RaBtUo4cCzdmGMELwH6PByQbgn9eNhyo1m34WRS0kompsksRGBSIKx2KS+8rK3aKc8nVmcG/WZ1cwbWS26rm8I0sxnM0vW/Ao3s04Ud6GUDuwPU4AeESlrwJoTEEL3mSZ2+xbymD5wutcI5qQcOfJcgbRqJuWXBIiTjfMiyD4C6z4ZpqS5Wy2GdjYFwYvW/A05WGTqfwJ4iQEAgJ/pnquhi/0Tyy7e+DmxhfCa0iiZXy6YRDV2vrzQY3QKSBMTNC1UOLSKckL6so0DwAnOUkigDIjiHEvrjOkDqhgm2VidFH45kUkzeBAkzi9Nk5B1Dw3p8zPUxYZBJU2tFCqzlQy8WBxLCx8qGSKQ07edgM/9LzottJvSskpj8d9HJ5vQfvl05Po0teF9zBp2yBlJMvsufSrIoHOdpIusN/sdiEy8qS7UImH2FOmZjvm2HeWuYrRfEWXX2I1/0Qkd7IHyHDnTp5fGDdKwQR1kzjIpdQJnfORIeeEOJu2B5xPnF+BH02K9IAQsv5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(11063799006)(6133799003)(5023799004)(261009223027099003)(18002099003)(22082099003)(56012099006)(10067099003)(261102123227099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2FrxBP9Z3mzGrcjeGi41PcSWFpNnordxSG9bb29ht4XyZqCF0rM1srW9x0Bk?=
 =?us-ascii?Q?44x2+/WYHve3aH+wjRAV+rFRjSqWOS/5aeKim8UINl4gmBzWq0BIOaUx2HxK?=
 =?us-ascii?Q?6JevurJlDdeVkPtRjt4gwo3mL85WAmBmlTuA8Bn+Zdg3/ljwYgiEKpi/Q/wV?=
 =?us-ascii?Q?AiT4O+xffhTa1insYNaAi8D/XjVcoYFriRVKdfqrJglyyhqKRMFuXBE6bPcC?=
 =?us-ascii?Q?AMLYTx/HdwQw+9ew6AGy44XUFjqTdAKpi1wpauclBmVQg0f+QRv+pBr2WfDs?=
 =?us-ascii?Q?Kr76ZeASH1XAASd573r0+hblUf8CwUfmSgjc5SHZYRywVQLGuxMf5Nu8o6Sz?=
 =?us-ascii?Q?VoymUTzBxhKvftdGJYPLetX6psJVW1Av3vBPRF8oajWW4NrepotMPnNrTuks?=
 =?us-ascii?Q?FmvBMxrMH0rKkSLzHrs+FJlW7Fcf1kH193f+eSaoulIcsYCxZmY49Doq8K54?=
 =?us-ascii?Q?ihx8MNiTSSvFlpIQaU3pz3S573dpgm3l9KNqRigogVdUr8a0dDdFXMWVzPTv?=
 =?us-ascii?Q?JNioQyj4INjyOpeAM1J6rLiMWM9sMMn8SQAeIrSLok792woqRRkK8Z+wMyTF?=
 =?us-ascii?Q?f6mRIDGAIN4pkuiUK/J7kz5CRkYd4pB45bNtLQqHxhSKuMMkqyXRSSW1ZIVU?=
 =?us-ascii?Q?JHjY+yj9hu4Dv0U5e6KZtC8WEBq8yrRY9ZGOnSdgSA6ARKhh6bQnWBPCmqXy?=
 =?us-ascii?Q?Rn0tUEc5D6Wn28BXkUWLR1dSO2GU8mnQJ7R9Q8xl7z4SEi+NN8cQvWrGqWO0?=
 =?us-ascii?Q?H685gETADYx+V44QJKv9HEktDFcY3icH1L5yc8k0N7zgjmv74QRopBElgRZf?=
 =?us-ascii?Q?ApIAbqeKZr1yCputiUFS7plpUmFcil3ooGwJGOnL9DEL+scBHDqXhizfvsJb?=
 =?us-ascii?Q?eoGdrT4dRRMeQntIltl+MVuuN+hG6kzDp+k6VPARUSxFckZNQfdfiyTUaDl9?=
 =?us-ascii?Q?5MZKtVfhrdXo2X151RK6N7tdZNJRERZn30ULmYg4r4zMI24nfOxvwVEpZyMC?=
 =?us-ascii?Q?ftE3sQPuJwratdb3I6CbNVEwgn1ykQ2dGDCUmFN1tMJLFZy2pE8rTAV0WP1K?=
 =?us-ascii?Q?FlPvDXI6X1ynocgKXEYCma8jdHv+oNXRany9fhpXOsA0tMa6kpzrkHC/UJ1Q?=
 =?us-ascii?Q?hiwF4tlkrjluC2cMPjUUAbw5k3rFyqy55M2vdHh+Ji/nLYicRGPmI2iFamAy?=
 =?us-ascii?Q?zrDp8ZnyBi62iXcQMqRd7I0cat/e8lPPTkDWDDycIbQUHE7T3uQU5RcQXVVh?=
 =?us-ascii?Q?aizNL5x942A7+dkhYktFr7NJlGjJ3V5Wb/RdwxCnZ1DEg2k4WBb0HqUDsW2Q?=
 =?us-ascii?Q?hMHclxtLmeMHiEqGwRiZz/0jEuhsp31RT7dbXM2Lsiy72WX781P3MnZvdUth?=
 =?us-ascii?Q?RK8eDGXv+R/jlXbeZNz+NdtyLJC4g+OOsWRlTDmtBJQFpxpFMzZWHJnbpKI/?=
 =?us-ascii?Q?Ax3NqhaD/e0FH19IrtFlaEqlH9yWCqqdNO3OY7VOuGt2jK/tPVPJg2nTZhz7?=
 =?us-ascii?Q?gvlGf1FI1KTgxA95WuVr428qoTOBjk4j6+NOb/u92Fq+hBKKzaDXaf3E6r6Q?=
 =?us-ascii?Q?QIN14Fr/9Oi1Qh61rVFDWuBqF5nPuPtWOJLiEnDVQKlcyLpVkk3qaovzo9nC?=
 =?us-ascii?Q?zQrZXdCo3lcPcVXUP3j5DmBf50gpv3ze15gkBbvUCiXVZ9S1rauVws7tu0uM?=
 =?us-ascii?Q?R8ffW2Az1R94uU0YOPmAyufJ8lxTbjsI81QQ7Jo1whxRlVVG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be262984-4f80-4dd5-cab0-08df4d39fed2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 10:25:59.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /h6MjQ06OKtBOGZDFi9Pcxc6gtGwQw532r8I0gj6X4MSnqds+HX3blqzudUJ/hxxYAYKFa7uw01bgOb4ljSeEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

From: fangqiurong <fangqiurong@kylinos.cn>

commit cb86607ada73185f321baa7f9d94a08a3a40bbf5 upstream.

ops.dequeue() is invoked with the source user DSQ's lock still held on
the consume and move paths (scx_consume_dispatch_q(),
move_task_between_dsqs()). A BPF scheduler which locks the source user
DSQ from ops.dequeue() - e.g. by iterating it with bpf_iter_scx_dsq -
self-deadlocks.

ops.dequeue() can only call the "any" kfuncs and none of them can lock a
builtin DSQ, so the global and bypass paths can't deadlock; however,
all DSQ locks share one lockdep class, so iterating any user DSQ from
ops.dequeue() on those paths trips the recursion check.

Move the invocation after the DSQ unlock on all three paths.
SCX_TASK_IN_CUSTODY is cleared under the lock serializing the transfer
so that the callback is invoked exactly once.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Cc: stable@vger.kernel.org # 7.1.x
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>
[arighi: Reuse the 7.2.y backport fe499ae9da46 for the unsplit source
 and older static helpers. No sub-scheduler changes are needed.]
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 48 +++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 46b15bfa92548..22922692e0bb3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1422,20 +1422,14 @@ static inline bool task_scx_migrating(struct task_struct *p)
 	return p->scx.sticky_cpu >= 0;
 }
 
-/*
- * Call ops.dequeue() if the task is in BPF custody and not migrating.
- * Clears %SCX_TASK_IN_CUSTODY when the callback is invoked.
- */
-static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
-			      struct task_struct *p, u64 deq_flags)
+/* Must be called under the lock serializing @p's custody transfers. */
+static bool task_leave_custody(struct task_struct *p)
 {
 	if (!(p->scx.flags & SCX_TASK_IN_CUSTODY) || task_scx_migrating(p))
-		return;
-
-	if (SCX_HAS_OP(sch, dequeue))
-		SCX_CALL_OP_TASK(sch, dequeue, rq, p, deq_flags);
+		return false;
 
 	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
+	return true;
 }
 
 static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
@@ -1443,7 +1437,8 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 {
 	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
 
-	call_task_dequeue(sch, rq, p, 0);
+	if (task_leave_custody(p) && SCX_HAS_OP(sch, dequeue))
+		SCX_CALL_OP_TASK(sch, dequeue, rq, p, 0);
 
 	/*
 	 * Note that @rq's lock may be dropped between this enqueue and @p
@@ -1606,16 +1601,28 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	if (is_local) {
 		local_dsq_post_enq(sch, dsq, p, enq_flags);
 	} else {
+		bool call_dequeue = false;
+
 		/*
-		 * Task on global/bypass DSQ: leave custody, task on
-		 * non-terminal DSQ: enter custody.
+		 * Global and bypass DSQs are terminal - the task leaves the
+		 * scheduler's custody, so ops.dequeue() fires. It can run
+		 * without @p's rq lock (finish_dispatch() passes the dispatch
+		 * rq); that's safe because dequeue_task_scx() waits on
+		 * SCX_OPSS_DISPATCHING (see the ops_state note above) and so
+		 * can't race it. A non-terminal DSQ keeps the task in custody.
+		 * The custody transfer happens under @dsq->lock so that later
+		 * consumers see the flag clear; the callback runs after
+		 * @dsq->lock is dropped because it may lock a DSQ itself.
 		 */
 		if (dsq->id == SCX_DSQ_GLOBAL || dsq->id == SCX_DSQ_BYPASS)
-			call_task_dequeue(sch, rq, p, 0);
+			call_dequeue = task_leave_custody(p);
 		else
 			p->scx.flags |= SCX_TASK_IN_CUSTODY;
 
 		raw_spin_unlock(&dsq->lock);
+
+		if (call_dequeue && SCX_HAS_OP(sch, dequeue))
+			SCX_CALL_OP_TASK(sch, dequeue, rq, p, 0);
 	}
 
 	/*
@@ -2078,7 +2085,7 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		/*
 		 * A queued task must always be in BPF scheduler's custody. If
 		 * SCX_TASK_IN_CUSTODY is clear, finish_dispatch() on another
-		 * CPU has already passed call_task_dequeue() (which clears the
+		 * CPU has already passed task_leave_custody() (which clears the
 		 * flag), but has not yet written SCX_OPSS_NONE. That final
 		 * store does not require this rq's lock, so retrying with
 		 * cpu_relax() is bounded: we will observe NONE (or DISPATCHING,
@@ -2126,7 +2133,8 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	 * NONE but the task may still have %SCX_TASK_IN_CUSTODY set until
 	 * it is enqueued on the destination.
 	 */
-	call_task_dequeue(sch, rq, p, deq_flags);
+	if (task_leave_custody(p) && SCX_HAS_OP(sch, dequeue))
+		SCX_CALL_OP_TASK(sch, dequeue, rq, p, deq_flags);
 }
 
 static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_flags)
@@ -2230,13 +2238,10 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 
 static void move_local_task_to_local_dsq(struct scx_sched *sch,
 					 struct task_struct *p, u64 enq_flags,
-					 struct scx_dispatch_q *src_dsq,
 					 struct rq *dst_rq)
 {
 	struct scx_dispatch_q *dst_dsq = &dst_rq->scx.local_dsq;
 
-	/* @dsq is locked and @p is on @dst_rq */
-	lockdep_assert_held(&src_dsq->lock);
 	lockdep_assert_rq_held(dst_rq);
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
@@ -2478,9 +2483,8 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		/* @p is going from a non-local DSQ to a local DSQ */
 		if (src_rq == dst_rq) {
 			task_unlink_from_dsq(p, src_dsq);
-			move_local_task_to_local_dsq(sch, p, enq_flags,
-						     src_dsq, dst_rq);
 			raw_spin_unlock(&src_dsq->lock);
+			move_local_task_to_local_dsq(sch, p, enq_flags, dst_rq);
 		} else {
 			raw_spin_unlock(&src_dsq->lock);
 			move_remote_task_to_local_dsq(p, enq_flags,
@@ -2531,8 +2535,8 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 
 		if (rq == task_rq) {
 			task_unlink_from_dsq(p, dsq);
-			move_local_task_to_local_dsq(sch, p, enq_flags, dsq, rq);
 			raw_spin_unlock(&dsq->lock);
+			move_local_task_to_local_dsq(sch, p, enq_flags, rq);
 			return true;
 		}
 
-- 
2.56.1

