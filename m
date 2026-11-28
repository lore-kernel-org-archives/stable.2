Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795861572;
	b=ChLd5uRdbizFihwOhEIaODPOLaLgPljL2QGJLnE/wmHm/39SKlGWNR/O4AXmcBfIBFCW
	 X1PrPhk8Pnl9csg++isndle5c9AxLwpmbjKc7oVAji9XciVKcFDWhW+NVb0MKSX61Q5Zl
	 EShMAgQ84gMnpsSEwzHQ0q48UcJ+JiAleVIPoXiTQ92EzjmaDsrH7NC8SoNnyVMdQkyOY
	 srY3jEc3d5B6DVUIdu1UDhDx7kHWyQony/Nu6vRuSnMqwoTHNN1ZNubspo40K0zX8ZRyu
	 ybgqumDvQY2eCAuF6H3IpiaXKI41ZN8T6HFtVQswbCqHLr94Gsb1z8/ENJNlxocW4wA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861572;
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
	bh=a4ZqvAfP7I1qZLdH7KTVvFy+O3tE1POvRZFqp/38uhM=;
	b=rHpVR522xOCD4dWklX6jFmpEv4a0H0xx4/U3MFMdPdhqtWSN1Im0TRRsDZ3jnjS7oJml
	 pmwrOUhOlvXkhNZQwZ/vWJ8fUfJPqbR+e2FRpzTzCmj/SW0pthmvt1H7ik9Iuv4skgq2N
	 9jfD7uzn7Way/FHyCfqWC9Xt4SMwjSXM1iCzYj4DpA5y7nmIS0RC/B5cIp4j1r65hRdzS
	 xtCaW6wtbSTb+ms8P4ZO+UEDI79F1TtuVl4evbmQkLQtA93lLZrE/mWkKtdhSsxOiQbsy
	 SgEs5SDMG6BPG1BR6LlnOSG8oAakKV77bR1CcPdVfZsL4y1JWmuCtW+/G00+Gsl54XA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BuHp1c0n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.32
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB3606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 10:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCBB3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BuHp1c0n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6f7E2p/WBS+6iWNDZH9hNizBgeBJeKgrK7t4eT9xfDQEt2mzSO2wNG9Iuk4k3egXUAav5deLId1AYGIkTbiOlZ5/ugvLLcpMEzWyRwnincRmLNv+uU1DvgPZXAw2gQJX889NxdIB903F0D7qkn4Z2EN9PpG0jz3I779JG9xXA6AZj15jhMIjjb2+qfp5Tq5Q/X2WQeE/4sAr0fGs+4RgFN/8ws8SjnugA05OvhCEQ6deFroBoPMPIg78dBv+vGaORV6WnnN1PxvyBYMZQPMYQsdQepaRnFKFx93ps+ch27KnHQ6TKcRsX0mBAiNjhxSEOGsMp8dDvzXpkJKXMmxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4ZqvAfP7I1qZLdH7KTVvFy+O3tE1POvRZFqp/38uhM=;
 b=EanzgApOSn8OdLeigLLNFRhsa054N/uFNo2NZ1UnvepU9rVCZdEdAEh+/TKFd7NaWXggoh3ZnlqjqU7oqg9sM/q81aVBb+PjJySUwAOW+PDmgkdZgftWLlaSEAIQLaybXVohRLQ/35S4fjYEAiLszZ8UNlrkIt/wGhTd9PxP/50ZhZd7LhEEjd7YlJ8XGpS+Kb/E6oTeSSdN8u726ByREqTnXcMuIlzx2fIomZ8316atn7jxpYCGDR8p9Hnnx1LTjgFO3bcYnrxHWQ8bm1b/kQbowIX45ul+fH8KAClHHp4nJLIWFdqJAaG/4FsJa7w82O5z7BB52PAn/zC2O2jXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4ZqvAfP7I1qZLdH7KTVvFy+O3tE1POvRZFqp/38uhM=;
 b=BuHp1c0nPu8qZ64j5mTuwq9tC0fqv+JBYkEIpDnV6EAhW1H59ew/4uhTfroxIB3MhvCHCGCG+vMDQAf3JMQRrJL65qFSSinomFHuHM3Y0jzoBO/3tFakCxVRQeWBjgif9ta1ZKTXL3MkZ92r4ff+dQcaHntjBjMSi9AWaR8LLwRI1bFbl5wakP4cvNtMvcK+Qn8be9umNJ5VLbJgHyv4JBDl1mHov+HVXlMZc2ibNLA8QHi/CyW/pLQqlmMgfQicHurXTQzD0SPfL5CCQOPdHIc+kHvLj7tCMV3nMu31PL1C0hDAhadIEbuF5U+JRsk9J9IXCRvWp2DpnRyHBv4Orw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 10:26:09 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 10:26:09 +0000
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
Subject: [PATCH 7.1.y 4/8] sched_ext: Wait for SCX_OPSS_DISPATCHING before reenqueueing a task
Date: Sat, 28 Nov 2026 11:23:47 +0100
Message-ID: <20261128102535.655465-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128102535.655465-1-arighi@nvidia.com>
References: <20261128102535.655465-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:8:55::35) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 659107d3-9426-4d4d-bc90-08df4d3a047d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|11063799006|261009223027099003|18002099003|22082099003|56012099006|10067099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	vUeooZvB2t05fqnMZJ2FoQaPKI8/xgKzAwn2u52TeyX6izqMWehiwSZeX1YBx4yK1A/KxnIg9QKq9+AUKP0FC51u5g/Typo1rFJW32U6bvE8PUXzU5W9O3F36cLVj7qXCQguJayVoVykmKxmT9/j48+gX2j0gBaCMTgOAm0FIest6mDyofur6RqROjhwNGrYnW25hAH7UQpCMVcBUW9wQ1eGom5QEe3fPcrVIYEdxsVdAoRVxgFcwXqJiRgkM8hTzvapLmxjK11wgiKB87iFgeF5JhlA5n8etjudNejf6Ai6mvwjDuYqXhwen/LFqjUpvm+0x4gd1ot4PzjtPJVgNxRS2G+I4nzXXJP7hMtxdTZx5pnPwrqf153VNXoY+JFUbIl+apFwDp58VBZLU2gJkS4pYgBOLiVMEhB8oIE+aOrgM0KckIMCzm327Dp4Hht64jPyDMJP2Z9wU0iRaVWEi+LLJO5VaZgud8JXYLk3f0kxAnEGg3wiGawFzyoEhnGuEBHUvGYASqdlimRk5yLbSg2LsqdUnpqhxh2x9la/Y2klB+Uc83m4xjzKu9Z7PTnvge2b45frYtZN9uRtTnYXqbMh+HT2p15/DGj3DKfB2JY0F+Z/m9NrYO+1pW4TXTrq1/wQaqzZvTZN97dfGVjWCdonpYglYZ3e+fSfzFk8NSo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(11063799006)(261009223027099003)(18002099003)(22082099003)(56012099006)(10067099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2eZYYP9xAMLe7j+zSVTE3zS+HK2u7rscCck6Ly3gzs0Z09SQYr9j/VsR75i3?=
 =?us-ascii?Q?tjUlD8cn84hKYI7n3+4xBOEtwZIRzKJ5CrTX4ruteFEJIAT6ACseH7R/2lxP?=
 =?us-ascii?Q?xRqW09IwHn/SBSaa5n9Fe7WfxDmMvGPfWi8BPthdyZdZhGaxpkvCMl2lvNvd?=
 =?us-ascii?Q?88uRqNyxqyMUGckWPwDaw/Y8a7FcqGfCD60kZMYwhVt2L4fCO+VthXGgBXso?=
 =?us-ascii?Q?JeDYl2C3IWVxgATsnb2j3p0u9odhQm7KAhyQz1HJ+8EmwXZ5ASxmpsZKpg+7?=
 =?us-ascii?Q?AOIUPv+q6CN9WaqrWFzfCUTy0+SAZvqB4dnWdTR0vdltWx9bKnZNq2Y82MfP?=
 =?us-ascii?Q?wp0XBb/oZ2ORqOYHAS4ZWjBjIjLoj1cJV7yHe6mcFxDj3WvpHwqv6uF73hp3?=
 =?us-ascii?Q?hXhLUFt3JwWyL0llWx461QWgJ5l2u8gUnPDVD7E6VMg9CAI+nSfWb9nuHQE4?=
 =?us-ascii?Q?7WcqZ76O75TphFlL535h+oeha/SOw45NBgfocfr7JoZ6TapyFSFMgm+AXaiZ?=
 =?us-ascii?Q?k1tUXJrRdBPTvI/Bq/Kwm/1zLGqX3Cw9/dNqt3QcZxfBJpYKYwNfXuP9/P/c?=
 =?us-ascii?Q?rG4I7kKqNLx7G/6TMHZDE3GKU86/bnh6W2ISQCNj06OXQUR2LyLHLdMkdC7L?=
 =?us-ascii?Q?OM2eNDzndn01PaxfQZO/oUqcomjP/DqQ/bSYC5LlaWWsjLng8H0ZpF0Gs16K?=
 =?us-ascii?Q?9oyM1gNm4z1HBJ7NxhEo9p26qqIz0BlDsdIPHt1K3IM/W6MLMlP1298/hDc2?=
 =?us-ascii?Q?p1f9HMEKqS3dO7qAnlt4bzsZ9cubf2n0BY054iFrf88tiaM9f7T5NRTUQCAm?=
 =?us-ascii?Q?m1IkZCc1RSrr0Szb44BKMFRgCdWjVLFqBpS08pPwsz090EzpWRWb6Mi4EWir?=
 =?us-ascii?Q?MDqVWAnOce6ayUBFDlAKUB+adMyqs18ryKtiboKGw8hmz4wdPISoj+Lt327K?=
 =?us-ascii?Q?ouqj8fdUIuD9yaqeF1bhKIvY8PkNVUtaXASGfPKk+EA4clpTlQAggKa7fbpH?=
 =?us-ascii?Q?swWEf51ONkj3o45tFLg5Z804O/OglymVo8iEuLanVfocwe4twfilsG9uKzDw?=
 =?us-ascii?Q?6h4z0aqc05qo4h0BRP+ppZgF75YLAaHXHndi/0j9fJwCxWhODReiqaTS3AVp?=
 =?us-ascii?Q?NsQdAnmxCvkk2kyAcRbecdH/XATh6J9wI141VVlXlzbI9jCRbfFPx6P4fiQP?=
 =?us-ascii?Q?wYHuCPeqDG8lesDVD3aL6dfIfYDYhXTm6gSlDC29fGNH0FdQ6MvOQ2zdMMUK?=
 =?us-ascii?Q?uBPzUt4Fp2jme3qWhu4h1vXPPCYeXr/o0FUmjHRoUomb4c7Re7+9VXesaQ48?=
 =?us-ascii?Q?vLLGIyDrLQ9eVf2Q6RZOQLf4WK7KJt3emCP9z7SxVAy9nlS4T7LI1D8Q+RMp?=
 =?us-ascii?Q?6fbc2avbdhivePUEV0WHi/6dCB8fNbREKIpLsF2CEOZvlNeRRUis7q9MGGg9?=
 =?us-ascii?Q?j6PbVSl6muqqyZSnunP5FkmgiYTLaAlge+48+KPl2sb7IP2dt5zHlwA/LuXq?=
 =?us-ascii?Q?I1htdGweTk7zuPgWJOkG8tp40ZN9xQb1T4rSYHLHIg0zR1MIobzW2jiB/LSA?=
 =?us-ascii?Q?AHPCvEc9D3lhCCHd2AgZQllC15FZikVvrw8xE4+i/658S1BAN/z0WnR5VSKY?=
 =?us-ascii?Q?0paq9d5BBrj/EzEfS5bAtnrKVk6FCXaxzgidxRJjpXMbfyW5/Gj7ZOXus3Fc?=
 =?us-ascii?Q?60W7WCz5av4BhI18rfRyuWYhBucPF5kUlmGN0qimRHc6MxXZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659107d3-9426-4d4d-bc90-08df4d3a047d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 10:26:08.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXYViMY72qkbr7d1eLfUSXXm3PugAICkmFKJvQ8ITbNKvMmtdDdAKl1aSztoyRlThFiR0FiEq2WegxnNPKuxUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

From: Tejun Heo <tj@kernel.org>

commit 7de9a6fb44eae4f05e68c805d58b9c618815adfa upstream.

ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics") moved the final
ops_state store in scx_dispatch_enqueue() after the DSQ unlock so that
the custody update and ops.dequeue() precede it. A task can thus be
found on a DSQ while still SCX_OPSS_DISPATCHING.

The dequeue and core-sched pick paths wait for the state to clear in
ops_dequeue() but the reenqueue paths don't. A reenqueue in that window
runs ops.enqueue() and sets SCX_OPSS_QUEUED before the dispatch has
completed.
The dispatcher's final store then overwrites it with SCX_OPSS_NONE and
finish_dispatch() drops every later dispatch of the task.

Wait for SCX_OPSS_DISPATCHING to clear before dequeueing a task for
reenqueue, the same way ops_dequeue() does.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Cc: stable@vger.kernel.org # 7.1.x
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
[arighi: Reuse the 7.2.y backport 43457bf65500, using inline state
 checks in the local and user-DSQ paths in the unsplit ext.c.]
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e746ee4d9ce2e..7fbbdac45f27b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4104,6 +4104,14 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 		if (!local_task_should_reenq(p, &reenq_flags, &reason))
 			continue;
 
+		/*
+		 * The dispatcher stores the final ops_state after dropping the DSQ
+		 * lock, so @p can be found on a DSQ while still
+		 * %SCX_OPSS_DISPATCHING. Reenqueueing @p before that store lands
+		 * would have it clobber the new %SCX_OPSS_QUEUED.
+		 */
+		if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
+			wait_ops_state(p, SCX_OPSS_DISPATCHING);
 		dispatch_dequeue(rq, p);
 
 		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
@@ -4224,6 +4232,8 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 		}
 
 		/* @p is on @dsq, its rq and @dsq are locked */
+		if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
+			wait_ops_state(p, SCX_OPSS_DISPATCHING);
 		dispatch_dequeue_locked(p, dsq);
 		raw_spin_unlock(&dsq->lock);
 
-- 
2.56.1

