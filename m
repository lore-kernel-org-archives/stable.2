Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795861580;
	b=GG1xtw3q+NKQgl0arun2rbaSWTrGdz2J99XfnimHTVRCWMS8H/nKBhAoCZAhW1HEAJac
	 XZKqZPDcKMMJ4GEnSMwMHY46pSAOSCTFw+5m0cst87B8Woe1Wde0gfJKCs58jz1UDlZzh
	 jvbP0UUT43Gq6EfZZ+DhzPHjzXMGrhdEC8TSC0dxIRS8tTxm69m5kiDVLytaCBtbQoFZ6
	 d0HVQEZV5/vPyJU67Ng4hWaheDRZLP9aYJjJHitt5vo34HTCNtelsIm6hc4pwnWREkGxd
	 f1sBV9GAdhTYeYUHykqY9luHqew2qyrzUgBAbsHoXsFJl4KUoa1dW5x5bZZ6LFZqI6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861580;
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
	bh=Z/g2ai4UiVIQmk4g4tg3d3heSiJNwRCUQ6PvrFnJUJo=;
	b=gTvn88XEMLwSX4pXV5YcqD7Vznqu3VdPMFess4AlnPGfpkDjylgyMIiVg1LUQ7pmHYQ8
	 4KCf/e6c3uhGKzOgpU8+Me2H/uE+OjhmS3X1WNRJDmaggG/vfg1Js0CRp9sH1cXe4d1WC
	 fsTlqNXKRz5RCfImizC/cYLCqr7ULVxGAz2QUO/wejW5IdwN8fQCqYNm0gNwN5aOu3fQC
	 pzU5Tcbf/xQYp/FpOsZH5VJ7umQEcrH6RtYM8BXsLcI0cBEA1eer/h8QdFskuCL19cO0t
	 hu18CIK+HLcPh0P+qLCajA0d1VNgYGYFcMoeSNIEgow+QAmhJ1wpbaTcuo4tJ04rTNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IB3AOhyV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.15
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142F3606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 10:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 142F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IB3AOhyV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ow/OGt+XhbJluTMO7JJFwkgKibDG97IGVRndn3yPNSVsgOD+NJuBAI96wGoyH6Os5P5rWbTJOf2egt69U/+xLa4I7FX3+/wWgfLWF9k6xAw97BRkIpO6djuINjN7EXc8TDbBUPV0YB4tf31BNZmeqsfqQQU2MZMkYUaDRMS4VfHfwzMyO8tp0Rl3lkzAtoKmA/aEJRTGdHX5vjBmS6399I9tbT2fVVBHgxs3+zaPv05up1sgFh/fYW1Y0MX2gtCoRXsa2dLjWAVxBV40E/K8Ojhz3SrTlQ8J/Sf9dAWg0qHvI/fwjTiJ2g+KDF2Dpbs/3r8X460X5mBWfHc+m08/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/g2ai4UiVIQmk4g4tg3d3heSiJNwRCUQ6PvrFnJUJo=;
 b=RpMvmfx78tvotlYF/rSXhYzyxXf5HfDNaz3bV9EsV1Bj26lSCzZ4lehJZHzZ8L8+UQPzSD4sGFfDX1nY9DWYNaOSItes8H7n5jh6aiXAAZtq/DwPxPsqlcKrDjxVBD//ewXBKRvGcIQ7MczZFv6WWjin7b2mf0VU4oDqibT2FugqtEWVrAmfjby6/L8HmqnzzWfdVIXrfga70EVCudW1wje5Q5wHwaj4lHr0j1th4c+1BE658EaXNm1YwyfHDrhAXroxlMT1645magyirgidE3JUq4tGbxQkAJ0lwjlNszd6TARm0B0XYaA7ZaE74sV1N2FWX16BHw/wDE/TVMjndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/g2ai4UiVIQmk4g4tg3d3heSiJNwRCUQ6PvrFnJUJo=;
 b=IB3AOhyVNhnG+7zglaRyTHOmsJVNaghntIAGdPaLd22mTnntFy2Op9myzzYUtliIX7xniEAvxNpADLJulxP+KF/x7O0lMnSigWcKVNKBTbQYW8FPqvmcCnA4+6xyK0KYUy2D+zPd9sYdcF0bNtI63FDlP1RlQm6GVkOGamArwek2TaHF7HdJB+zJ9fLu5UrXcQMnB8uzpaQjEXE66dFdEpmU03ccDWU2qJz6rzy2HViAHUicX+1DMk30BSkSBcc3D9il6VzNHWFJPRH9yM1Gj9IpV2PAIkKQk2x/J6kjtGd4Rh5V0fnBIJ0VYY9/M9sLQ7GA5H50tkpmgVOKwojOPw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 10:26:17 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 10:26:17 +0000
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
Subject: [PATCH 7.1.y 5/8] sched_ext: Wait for SCX_OPSS_DISPATCHING before moving tasks off DSQs
Date: Sat, 28 Nov 2026 11:23:48 +0100
Message-ID: <20261128102535.655465-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128102535.655465-1-arighi@nvidia.com>
References: <20261128102535.655465-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008C8.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::436) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 8ae79d24-d76a-45e4-c2f9-08df4d3a0948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|11063799006|261009221227099003|261009223027099003|18002099003|22082099003|260925021911599003|260925021311599003|56012099006|10067099003|261102123227099003|261021123027099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261028144727099003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	3GCLMBUaTDJKfyQ89XGr+eIlSwA2EeGm71bIGIXgdFInSJyWPcKw3g73J7+h1cO1VpYVJ3lemj8WqilKwK85FVbhc34bpGZJEHWPfAHq9Zg3SyYfzmM04Xcwc162+OjFJZkhY/q1h4hLTJyhREpakL1XsIB8gbvgFsySVA4Ujl5Zjp+EMj80PxCCHn1Ar9S/s6PAoKAZ5v+Sbb2DsRd35Ff1wJxyoNEUM9iCyVbyuNTJDeQ8nS0KMn83rS4QWsZFTEBFfaf0WdP2a5wZg3eRNGIn/Xma4lKic+XfUIE8Twp6QoN+xCTyktCCs8AXZFI4Y/Q9vnA4aLPqAusDSgqLW1DDdIJ4wYoJBZtnzLUWpjtTK3zZ7HzL3kGTSFNx0P/xtB+CB5YLcETdGFWoGxHr3HghznQcIo+Ln/o/29TJIPXA6mhYd0qpVOgmiwg3VrfZ3hoW7o68XbDQR6Rhh/0dczHLFZEnakd8aKo5w9d3FjsUAu8kefMY1B+n84JDBDoy4KB91CmcwVXvhSPBHdgrHPj5c3Vmt8E0rGxZJ0YJFoQWEXWDQePOXPcbeZu2XkPpC4tf8r8hzkYnbH68M/QkYBz6XSRu/gTrWT+Z4cfi7u/ptUX9gPJY4kGrhDAOMy6s5Mg0pn63V0exqB4BiCDxkh5pxx6y8txpRbXCL6KAvEU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(11063799006)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(260925021911599003)(260925021311599003)(56012099006)(10067099003)(261102123227099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hOZH82vblBK4B/ouQFiaKQKKYX9MFFe+GdB42FLTH7OPrsFn4zt2Q/lhODNx?=
 =?us-ascii?Q?gmwciS7P69T3GVsCOBTbA6pEkohzJqxnvi68DUPz9uGZ9bvo8lGV7Y0Z4Zsx?=
 =?us-ascii?Q?4fDN7mHqsTC1GgI7/CovRnzoAI7g9u0FPoAKueXGzv8RcXzKsugxkJzKTS9Z?=
 =?us-ascii?Q?y70Y8lntE1Q7imbWGzOg2yYoFb1P9q1ULFzdm0BCy+iWGCBqgwcLPWrwvwyR?=
 =?us-ascii?Q?urlUdMsr7/R5P18lWltCb98cdsUPW5EzCwzr6jNNqNHGqufnPgymjAyAfI3Y?=
 =?us-ascii?Q?co7c8zAdJSaH1BfDi4eMlprC+MZBD9vJnrd9x463g1WLGjqtnaAhNNKBj7V1?=
 =?us-ascii?Q?wPVpa8VQ7hG+AgFy8N94s94FpRIY/2D7i7LdeLtNFThNj0SwKWKkm/gMDC+J?=
 =?us-ascii?Q?C52zImBZYIVpclzYtUGwMF2KuJbx1l53qwE2AT/l3qKZtrgj7cgu0qjkhHbX?=
 =?us-ascii?Q?HWdISj3H7fNFEm9EGVcfGz3D8L5tFINVMx9ZcowfEAyDn856k05zAvdMOEpu?=
 =?us-ascii?Q?dDWSYLEM0WKawbppsLm7DJAYZDZeGV0qZWinBV4oZmBEwBJONWUnp62wzFvP?=
 =?us-ascii?Q?CA963UaWesxNf6ZRlQneGwZoQ7K4txRZ8F3dUwPk578Wg2/tTQItjVcMCv26?=
 =?us-ascii?Q?3v+RUD+mypSoS5rL/QbwJZppV+bHdc+t3vD80NEUGBi9tVocho/wbgf194Fk?=
 =?us-ascii?Q?QmeMlrOnKYWtK140XGvaF6RMB4tKL/LMWTLuMeiYbI0zkP2NhF6PEg5oqkI6?=
 =?us-ascii?Q?iuZPyvUZ8fKeynb0fifcLqLimxajbRCmnXsmeWu77G7mTH1aZlkBJEBR+TUR?=
 =?us-ascii?Q?6AyX87gcOS4ysQKAEbvvd6waVIydi7yZe5cpCULz1cevcqOU8887Acl6J2g8?=
 =?us-ascii?Q?7dJOJc2wJsmW+mZJYqsaDMrB+wAwjNBBpadQVLKUwaGfdKUUwlriIItSuYm/?=
 =?us-ascii?Q?VRl/8HJl1oTdnxLW5av4TVrU82nRRFDNf/WNj5ukMVo/11F6URtidJ+xJMUu?=
 =?us-ascii?Q?yzjtPevwJnWPJ9OTxYe69+Ti39UQnb2liwm4WoRPVWyKIL8SnXrQKy2fuzer?=
 =?us-ascii?Q?+wRcUPMUvxnwwk1JagPm+pnR9CGQW1uGDkYBZCpGuw4PRCTZrGTOIWarUIxW?=
 =?us-ascii?Q?ykQ0GBe8rLez1o7ZDwVkZXk44zQHgCOwrlAuE6ZGLUzm8bBgxpkZyYm/z4rG?=
 =?us-ascii?Q?Nuhz73+S5OZBYRz93oCZUYvKnj4L2lNmX5psrPhgN73khsNN33FJU2H9q+x2?=
 =?us-ascii?Q?eCOhkziSbB05mtpiApDbVKqpFF1FJRZyDnegNG8Z36pKlTlf7Y5p6zRpkvh0?=
 =?us-ascii?Q?QXwwW4On2qFDREEJQpEUF3SJq4VUUkSpe+RSGdrA3N4XIlTgCUjkghJaUSB7?=
 =?us-ascii?Q?UO/QWaVSPghB+xOmlplne0BCJtjgE62WiiXLYzkwaIIiYalgRcPi5IzT9eR2?=
 =?us-ascii?Q?qWqACUSi3Uy7j1E96DuzWaL5N6Tp2eBruohfrJrRt3CtxB0tu7TfEzlOCvuD?=
 =?us-ascii?Q?Xb9mZF6rGvn/G+6a8MhmHp+KuHMkbby/lPN+lH8t2Kahkd5hpRdSnVCAbF99?=
 =?us-ascii?Q?Jgg3+ACqwj5LiRGVSNMhVRbpodKjcJCF4yfdZFAUP88UjjUOyysYwAv6KQ5g?=
 =?us-ascii?Q?M5JDa5uV3Uv8Y7nojpI9u3skj2X8YI93t4peHvAWP8iA5hPw+NBQDikQWEV0?=
 =?us-ascii?Q?x1MkrU0JYW/fQ6jYRfp+bp9qXZbTulBTe7gf5aQ3EC0c7UTG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae79d24-d76a-45e4-c2f9-08df4d3a0948
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 10:26:17.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej7dfU3JLmauPvrQOVTaVhj78Ia2pbbcWE+PhUAl4cV8ul26W5aUXJfxTtUcob5CKzpavTNbMA32ExlyLiR+xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

From: Kuba Piecuch <jpiecuch@google.com>

commit 2935062be77113c1c4565ca9d0c72180449aafee upstream.

A task can be found on a non-local DSQ while the CPU which dispatched it
is still running ops.dequeue() and hasn't cleared SCX_OPSS_DISPATCHING.
The DSQ consume and move paths don't wait for the dispatch to finish and
can operate on the task concurrently with the dispatcher.

Call scx_wait_dispatching() in scx_move_local_task_to_local_dsq(),
unlink_dsq_and_switch_rq_lock() and move_task_between_dsqs() before they
operate on the task. In scx_move_local_task_to_local_dsq(), wait before
scx_resolve_local_dsq() as it may update p->scx.flags.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Fixes: cb86607ada73 ("sched_ext: Don't run ops.dequeue() with a DSQ lock held")
Cc: stable@vger.kernel.org # 7.1.x
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[arighi: Reuse the 7.2.y backport cc2839946328, with inline checks and
 the older static DSQ move and rq-lock helpers.]
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7fbbdac45f27b..f47f0349935c6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2249,6 +2249,8 @@ static void move_local_task_to_local_dsq(struct scx_sched *sch,
 	lockdep_assert_rq_held(dst_rq);
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
+	if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
+		wait_ops_state(p, SCX_OPSS_DISPATCHING);
 
 	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		list_add(&p->scx.dsq_list.node, &dst_dsq->list);
@@ -2419,8 +2421,13 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
 	raw_spin_rq_lock(src_rq);
 
 	/* task_rq couldn't have changed if we're still the holding cpu */
-	return likely(p->scx.holding_cpu == cpu) &&
-		!WARN_ON_ONCE(src_rq != task_rq(p));
+	if (likely(p->scx.holding_cpu == cpu) && !WARN_ON_ONCE(src_rq != task_rq(p))) {
+		if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
+			wait_ops_state(p, SCX_OPSS_DISPATCHING);
+		return true;
+	}
+
+	return false;
 }
 
 static bool consume_remote_task(struct rq *this_rq,
@@ -2466,6 +2473,9 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 	lockdep_assert_held(&src_dsq->lock);
 	lockdep_assert_rq_held(src_rq);
 
+	if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
+		wait_ops_state(p, SCX_OPSS_DISPATCHING);
+
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (src_rq != dst_rq &&
-- 
2.56.1

