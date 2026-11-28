Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795861568;
	b=G1iq337dKVYlU0hgfT07VKx8iAtUhb8n3BcLke0Xc/i6IRHH5l5063IY5Y2EZDXc5zfT
	 HydoND+H9z65bfw37l9BJpltCxJAXi8u9Rd86iQBiCARNQSgLHL+Nr0fH+SzUkbT5hxA+
	 gPY12vcoPDca5G/TgpergsbJSfbdnw9J2cOg1G1jJRJBOZ4bDnp3VlYzxUARkZmVdizt4
	 PG02tAoUhOC1iZRLw3JOWnCuocYRRFClOeV8+jXyEO8b+QFcdAnAJlBUrzjndVOWZfyVW
	 sdjIe4cfRXL+1n01oUQSV/R61sIcotIfAXeztIDrJziHRs9iVQskTyQCwFjPesVmzzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861568;
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
	bh=HPYzmkGleGjwmNDwKz4I3GnafMr+B0+KDZYfhY0UQ1g=;
	b=4+6pZgtJomIJ2EybWHVc29grRJHi5BfZA/2apIliWjyHhnISIXfYEnqpvI80s5qm4fhj
	 B/gbuQa1zLJenXXenHMgmDUe9eAr6rdHkMzO1hSOI8WeHd3r1e2rSSuKn5PncnzvKfPOp
	 tbpy9RECT1Lx3lMCqJ0g9lngCRS8sc/eij3plYzW7PGZcOiFXxKQsN1DO7g2x6X5YaIcB
	 qMv3Zk/tdHgbI0p+Uu827aWJ9ejB4ov1Kehw79OCzmHR+HZ82Mqwp4q3mj8TVT1AP0Oar
	 cd88cClcCveNwNwehDFA/WCgTmnVMxn520QqlM3KrGELEc+IHJIBg2OaW+f+hisK8Sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ENFtGLUB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.14
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C495606A321
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 10:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C495606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ENFtGLUB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+sWz1/UFhJBZAu0h9B9bKwBb8UTOA77NpLFkUvpqklT8GFJO6ayLH8N8mn7H+f2ZHNCTXSljvQzbDy5s8dkxlWCo/eZH4Ap5xT/0/pONKVzigJ/ulxu5H1CoOiEIOtHBPGw+V01rfS5Fp7XH2HpiY9ZqqoXP9rASUB61pP7qmnr1rakSwGizpFfnTpCPxEyc7r75lNoza5iEiBoxbgBAh9G3V3X7JCOgPzR8NcYD5GPoaKUpy6TI+lqJQYr1goP01kaI8kWP3YbPkkpo2+87Dm2VxhF/h9l25zhQo97bilNaNRDlcHyLrc9Yum6v+fzBPFDV2KrPjPgl1bO7IVY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPYzmkGleGjwmNDwKz4I3GnafMr+B0+KDZYfhY0UQ1g=;
 b=dWQC4efzcNjBgfxMtBYZh91BtJ/c1HTq1xP3ees2tDC3Fz8XZLGSXRTaS/w1UHldbarv6m7NO2ytFloSH/UFymF4yU2moEh7JgnyVpfKys/RI+jgacM7gkzm1oG+PBS+q4g/p/q6ebV1NLnPlCXomSHGDAQN80K3t1SOzHxkMbR8YS/q1S2kFrEsW7UvgzFUHFpIPD8flACy0a6CLEvxq87n4M//EHBFFZ7ZNc1F3TWkn+nyWsvQ40w9X0vBsi2y0fUiOjj/K+4L7Qb6HYHuVUoETr49by/RGvEAtDx2QCgZlK31Ddf8lduupF7X69+0s2yNtddRBr2CJeshCDIWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPYzmkGleGjwmNDwKz4I3GnafMr+B0+KDZYfhY0UQ1g=;
 b=ENFtGLUB4yE4ZfIjjo9lMntPkjRnhVjvWirPhSl+jBiBewcLKWzzmBOv3pFksfOyPpkl2FXHLfOf8Htma9TXLrQnCBAcqJVA6NNa5VDBuneBAnnehheYT37AAQplINlv9kSHAvXXkZMkDUnhFY0+fB8vWD87xOIDkOETkPmn6c4/Cv3saguyRoBOlP0Ozl/28bkxd49TDAqhZ3DP8uMPOqcwfgxbtrdTVWN0b+C5jwa9FXHwjzB34TaEBQkXIB9w2av06W/U+DaoY4FUXmz0P73r0v0OAJ1nTGvExEgmn9CBb8seNhMBc7V4iR7/eCI4J2dF5zvRpMCqWEDS4C/Kfg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 10:26:04 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 10:26:04 +0000
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
Subject: [PATCH 7.1.y 3/8] sched_ext: Call ops.dequeue() when a task arrives on a remote local DSQ
Date: Sat, 28 Nov 2026 11:23:46 +0100
Message-ID: <20261128102535.655465-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128102535.655465-1-arighi@nvidia.com>
References: <20261128102535.655465-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:8:55::30) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 2d270fc3-d02f-4ca3-2949-08df4d3a01db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|11063799006|261009223027099003|18002099003|22082099003|260925021911599003|260925021311599003|56012099006|10067099003|261102123227099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261028144727099003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	L8197ae3FD4QdVg/lVA0W9w1GJKimCOJAYUCtNaboeDtqqR8lxJZCY21NTAc6Q29GeXErC7Q9LhmCr/Cpr2eHtkgHL5JCs8X4X6Lw2zJv1TQg98LdHcm8k+6n79miwIvXXXkfeUqLQ64lko6cdstQrfLw1X6Ykr3fjyCGs/yLuLDa1k1MHVVAJkWCtT4zVUJF19m3scjZex/OkW2EHFF0MfM9Op6KXJKgtysN/HQaNFg4LmBfcLQ/vgCxarisPJeonmnKCRKyPbMoKDUOygo0925KjlAeeiw6PiYchnZU7T6tbSb5/Ti+WG4jKo6qrWLDA9kAVgfJZPjgXujCKmeZuJX3qOOyheObNFDY8xw4xaFkvBYRi1RoqCfTYsND9xVLcUi6O8jx7OKtNUB/LNo01v3wG4HdciYlR4o2gSMXX44VZZxr/O8SseE6B9CRlT4+BiIhsozv2J8coHvxcOIhM9tiMu8ewMC5kCS4R8foIOf0m0EyV/PCM0wdRhGgU+2nD1TknpMuv/u1XAbhj/47y0zs39xyZB0X9KYjC0aPxDBnQGSt63Yyfzjq52o50d5kduFe+nvRx29dqAIuNm2lWUWH9Wsisz8Hdbk6L3ow3YSRqQHguRoBS4uNUBpzlSPzCyO9HQEXTvcbOTcHDqnGixWCL78DuH2yioUp10oQaI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(11063799006)(261009223027099003)(18002099003)(22082099003)(260925021911599003)(260925021311599003)(56012099006)(10067099003)(261102123227099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261028144727099003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xoYM4QSKph0FQffFxmKWKloPQuWUhB3zIo9t8geAQsSYFMgqSM2suClQ2vpS?=
 =?us-ascii?Q?+1WE+jYo2K7I6XOe0EQLBGzxM1PPgko9u210GNagjhT4VbndsAwcC6B2EzON?=
 =?us-ascii?Q?4Yx6ZuwI931WX+Ov8kIlLODPsJdK99YZuM7CiFl7U4W5a9uo1kUZzqNypcCU?=
 =?us-ascii?Q?4VEZKjANRKnqvXXH3FAfDQYgg1Pi3NWlS4IFDVAmyzl006oi5vKdbd6PhZ9o?=
 =?us-ascii?Q?k4m/t51IwABh+50GIW27RjV3qaX6hMh1tuyMot8Thx3bsy0H4ISnctsSbSX9?=
 =?us-ascii?Q?pZhzGsl0x8UvAEgOhkWJTncZqtFm/GU9S6VjfGTB/l1kKhq2pcPgoTIlr0Dw?=
 =?us-ascii?Q?1jEzSczFOF8STA96+taEsZEfHxB6K2HDbMTuibYIsnhp1iO9JWiSxNLbJV9b?=
 =?us-ascii?Q?wKECVNiJUQ5ifHThSVL5WYGdZfgcsit+7YXwPWzgFKpmwHYDB1kEGjjk1D8Q?=
 =?us-ascii?Q?wcdaY16KqvCPesaG844i2qJiE0hAmHDMk/QosdTR+QZeGZEWU84jAwTv7eUv?=
 =?us-ascii?Q?klDV1SW7nxPODNS7DLfYANWx6yboAdVtCTl32L9glJzqU8A79v1GGhOC7lre?=
 =?us-ascii?Q?Zxw7v2Bo/WCbiQ2en4A1bvGW/YfZbvxSqYte52/DJ/nNy7W3ZuJkwhFTDV27?=
 =?us-ascii?Q?GgMrwMzThg4RkkTI2IMc7OqjT5aBZEFXTH0JZRz6ubHiLFaLJ7RFz7YKGA7c?=
 =?us-ascii?Q?HJjZlD60F67JUFsBeWEt99W985woORSa8PklGVX1UbBWIKLdfChSgO+rWgtW?=
 =?us-ascii?Q?UYgGDVcyBGBmBIu0EQc0MDxJKYs6ajuBuNOj9onKhYP2FFIHvAgAKAmeWEdZ?=
 =?us-ascii?Q?cPXVbXVJupEMfObyBqcj96EOz3Ooal4B37XGD9HZpWjfBKfDlU5MB9CRoz8Y?=
 =?us-ascii?Q?qbrXnfF2c1sS0LbRBN2eN/Sy0yZ/raBcqB5W0X5oivgVIipKUe0yV5cqCa1D?=
 =?us-ascii?Q?+VBZO7j+S/0F0L5Rrz1HvATcT18mWs9Z5aaqNF4qeU0tO/jn+ln1OQfIKXHp?=
 =?us-ascii?Q?IwL4JLbZ7LAWSANB5M/VMGNpxh58mMYfZPIqwNyzNAlK52TyFoH8vIdY1TZ9?=
 =?us-ascii?Q?RrMPX5yVWQJhLr4488v26zW2jiOr5XUr1OPuHICHhnrlojwhFe45NwCIL2kQ?=
 =?us-ascii?Q?ZN/pZcGpNCEAFRrcLsfkc85jX8nlAqXuJLh48AlCGfyxMU3nn7XN611i/AhM?=
 =?us-ascii?Q?Z2gi07s1leq5zr6n8PnEsymA4GGZ5rJXCJGjHcZnt6LPdgR0uIk4/Dfdk/mo?=
 =?us-ascii?Q?EhKaioL8IzMOjO/2En2e2V7DgNvygnD0TDKCt2XPVFoBKRBb6t1+oh/MM6+d?=
 =?us-ascii?Q?6/9Np+lRwRVZOk4pbQPCKkQzKyXDZQipX9Z5XXyZHnrJE+hGKgGHbpUfB/k9?=
 =?us-ascii?Q?camnLHwGF3xB4gyrJa73q0cMgWHspxqOHGgzw3h72Kh4MXJyI1THM2aXs/AP?=
 =?us-ascii?Q?9Z1nQaX19VP0hkSm4n6tGC5jHP+GPVyj/Eo98kFHKr892sDBW5ypEW4LCVCF?=
 =?us-ascii?Q?QCVByLYO04VB0ci6nC6KLDDvWAyYA2U9JTijx8M+5Tr3WOYVZ3gow+zUPw5C?=
 =?us-ascii?Q?Z8ZIMGb51bsQ0NCdMWWreV/6RPomZ6jH/NoniclIOnjxppExftpUEPGSB7iP?=
 =?us-ascii?Q?UAAPZjuEDPNDrpZS8vO2X07CLldH/Qy8t+1TA87Jb2Lr+xFxHFmzjeCLsE2c?=
 =?us-ascii?Q?1tuRDZ+NNKxJh2crbiC/WGXVsC5OREqs87zeuUpWXxyOEyJJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d270fc3-d02f-4ca3-2949-08df4d3a01db
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 10:26:04.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Cpz6+T+kKe2/cOtdA66tXCeEg2YpDcExSx6U/1mCqoaoUEGCcb0fHxheEa3FjmlE8VpwFGL9s7crlu7Tx8deA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

From: Kuba Piecuch <jpiecuch@google.com>

commit af701b8d3238b9eb7cd450b0491300452c700bf5 upstream.

When a task in the BPF scheduler's custody is moved to another CPU's
local DSQ, ops.dequeue() is only called once the task is picked for
execution, from set_next_task_scx() with SCX_DEQ_CORE_SCHED_EXEC, even
though no core-sched pick took place. It should instead be called
without flags when the task is inserted into the destination DSQ, as it
is for same-rq dispatches.

move_remote_task_to_local_dsq() sets p->scx.sticky_cpu across the
migration so that deactivate_task() on the source rq doesn't end
custody.
Since commit b75aaea24c9f ("sched_ext: Properly mark SCX-internal
migrations via sticky_cpu"), enqueue_task_scx() only clears it after
inserting the task, so task_leave_custody() still sees the migration in
progress and skips the custody exit.

Clear p->scx.sticky_cpu as soon as enqueue_task_scx() has read it, as
was done before that commit. The source side is unaffected.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Cc: stable@vger.kernel.org # 7.1.x
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[arighi: Use the unsplit ext.c path and retain the existing wakeup
 flag handling. The rq-tracking prerequisite is already in 7.1.y.]
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 22922692e0bb3..e746ee4d9ce2e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2016,6 +2016,13 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	int sticky_cpu = p->scx.sticky_cpu;
 	u64 enq_flags = core_enq_flags | rq->scx.extra_enq_flags;
 
+	/*
+	 * An SCX-internal migration ends on arrival. Clear sticky_cpu so @p can
+	 * leave custody when inserted into the destination DSQ.
+	 */
+	if (sticky_cpu >= 0)
+		p->scx.sticky_cpu = -1;
+
 	if (enq_flags & ENQUEUE_WAKEUP)
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
 
@@ -2049,9 +2056,6 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 		dl_server_start(&rq->ext_server);
 
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
-
-	if (sticky_cpu >= 0)
-		p->scx.sticky_cpu = -1;
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
 
-- 
2.56.1

