Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792500749;
	b=ZArUZ7xZ3TYn+FDuihbiMLLIIL2TT7wnH+dsF810CTHk8sdRBMChhlIVlBe3pQJEzkD2
	 wJT73oXPkRzz2jaGEAIDIoBo1JcRdswEjiFQ21E6IXmfMVzDoAB5Huk30SYqVWm6t+8Qr
	 iyQQvBzkU/1kObndSaQO4nktYdeG8VG7x6vSAdYNM+2JkosAsKUrdyt65mUg3sN7ueM4E
	 lgNVNiFF7prz2jF9XmsIJ9BbeKWfrdwWtY4D3o23XuSLonTNjQes14lMt3LG0RCrpp5G5
	 mx1WBN67hw/eiN0cFdkUBHQ6VDSdGgVe2fw0vNhta6ezeBpD19aBtFQXH4dZL3TDkig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500749;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Z9syTPfiC6hEWHcnLPr8tzi+ECDO4j0WuanQxl4vpJE=;
	b=cK9tPHw3f3d4v/Ai2PIPtZIoSoyFz8q7kV6DsCdxE8hq40CK91hLDq7nz16gwnDzL5Ec
	 sn9VdTt1e7mRvMLJ+RVqCBmlT02DXWVoN59RzPpbX9L4vbXZlwyPYr44CoStpHXrUbMUv
	 3lhMhRr4G4sfgg7k1zvts975pgXHRl9mD0FTQ6gQId5Rr3Jx1Xh5TR0rnVi1dQDdTy80v
	 IYsCfjXkQ8qplIs0aYDirvYm3T0xDFXtU2GNfcMHhUTiFR4G7KbNEZH1SY0+YQmE4ImAv
	 e6JxJGi5YPirglZhStPNqHuQ4xE8MyR5Ul2Z/kds+S7g3/aPONCE31xZPwKiIJomYdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Q4+CzYPh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.9
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B06606A31D;
	Tue, 20 Oct 2026 12:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47B06606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Q4+CzYPh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGRfWjcLtl1P0+ymn3zTuQVaoo/ENkhMDmhoO2Lrd+oP86EYRpl0oqw5mlDbb2OPakPxorxtCw6Nb/FPxz5vz6K5FIkrQFJqQS1xmveAa3RdiWLIsBcD9h6HLgy83qw6v8zeWMIH/7VmCdWDkbZifjZQfWmZaLm1xdAlbpoEChfI2wz0tiO8+zo0+W2AK8+kTKOapbsb0dIK3wn5ZgE1Q2q+seYB/VNhbhyGznT52gPbXBovp9Hf7lSgLpVUXI/mxbWC55lxNRmIWFm3aLuIMbit0YhVa5DuUm0qmISpOzCMNvAAi4s6qc4UbeDQSFjcE/a3C1Yi7zVNVZ/VqO+FBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9syTPfiC6hEWHcnLPr8tzi+ECDO4j0WuanQxl4vpJE=;
 b=cdu1wYiEjqMipCA+qY0kzPb8mno1NK9zkzp54O9LwFbkDZevzBKXY6EckrtN3B7tSfhb4Ms6EATj5PYhu9Jl1dJ6d/KxZVHjOFz7O7BhSrIaW0cKwVn/dOL7pZjXTg1jbuJYiB2aNNIipBcDCLQ9cs13AsCet3lcvFZTsArVyPWdXt7G/eMoGnDTvdwM6xySpbx1K3+/Y1ox6sv9ZQSCCEqn0Ysl/WgFt7tHqMWRO59HHQ5qXmyc7xzTlI7C8nGoDhr+75HRX3wY9ghCeLbEO66/uqwdzbEKcsS5QUar2hoTMrb6T72Wp1GDQotYa3cx3B5TcBKLO6dYAK+JIPn4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9syTPfiC6hEWHcnLPr8tzi+ECDO4j0WuanQxl4vpJE=;
 b=Q4+CzYPh0hvdHddtsBxeMZvlz1Aw3sEOiDeCwDXZKUHpy257EFXAQJj4CpljV3OULB3kwAwGKth5f6IlCnNydS6mgf8OjyohqT+nSg22bXWkAhH3/S9jU7b9ZJ9coPM8mUv9py+7LQtohLOF+BxoUq/dx4nK1YEBHgTZ7mP6BHJ4TYPiSoYLU2OD96OnVp4BvG59qjkCckJt7NRE2SpBB3CAzJ/E+eIQZAt6CksSQC1QnFh7wK+yYg9EBdjRpx/tRXj+X3wTLaFLIb6zOV6zF64GABGd4HczjjwoKf4nA3LZoAzosViPGWeqgzpl3ljmJaZi3eX3KCLJaX6vnExrtg==
Received: from DS1PR03CA0014.namprd03.prod.outlook.com (2603:10b6:8:450::11)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 12:52:26 +0000
Received: from DS2PEPF00006E1F.namprd05.prod.outlook.com
 (2603:10b6:8:450:cafe::65) by DS1PR03CA0014.outlook.office365.com
 (2603:10b6:8:450::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 12:52:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00006E1F.mail.protection.outlook.com (10.167.23.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 12:52:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 05:52:06 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 05:52:05 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: <axboe@kernel.dk>
CC: <ming.lei@redhat.com>, <hare@suse.de>, <dwagner@suse.de>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Nirmoy Das
	<nirmoyd@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH] blk-mq: clear stale inactive flag on hctx reuse
Date: Tue, 20 Oct 2026 05:51:29 -0700
Message-ID: <20261020125129.430600-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E1F:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad27586-d7cd-4105-40ca-08df2ea8fdda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|10067099003|261009223027099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	j3n3uQCoTZP8WTe18BtS1r8JgK4dZqZ08tUpdpsFwCm7fnq+685dFGc4+DDJmI2GMoAvM9rUX3JwSOiisLKg70dxIs33kvtKEMw1pxNvgifRDjS1kwkKuNihmcH2d6ihhhgLHx2u5IJfYrnKi9iANg4LF1pL96o/M5SD6LsJImW8RSSpwGNTIU35xRdnMwom5mQb8Q2yiDOM80uD2sBzTt9EpPDqQQc+bWxu8mUESHP5xWIbBi6a7RqFOqywr6zesvaXaWXbFYLPQYYMCjwFNW4FjipOKYHB2a9K18IIOtZ7oh6Tj/QaAuiEHBlMIpNhn0mE7I/umnwHfvaCIuVmCH4Y7RhjKCiGsgpDB/bt0P2eR5mVBggsmRjrvvUxXBwHlsUlHdNHcsmBL5lihoeMIYQx13mNYwAStjExq9Bb7xsFWlIBfWDnPdQuRWEbyTNg8su6CORlHn2EN2EeCBIvuBNQ4sk4gMqUP9CoaOrF9+gTfhX//dhIXt3dxYW8j4/G/11sTUZrPJwlCcC6VWNRTUJqaB9e96DYp30tIZpUa9fwyoUE8wuABedUhi1OSwQDVu+uYbzb2X+ADiI/aOgHAVk4EuJG89ZuoTHFgbQH1ZhDFXu6gftFplqU/8LSOH+32VkGKTRUD28KkLIKdq92Ilk04H7jSnRBWqI39sENXfy70ePvk/IYkDHXepdua1l3W6co1PJ94PLI85NClDwEUg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(10067099003)(261009223027099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oUa3YA7N3vU9y1sImCrsq4gYKgTwhX6KARUlXHcBFBFGRBZrmCxlfs9Sx8J2qaYUCCTOzHvYSMXtA5LV+hCJm2Sokpo9mniFwBRRCpd195A7qp7hzlqi+R14WVmoAE3renHJW+lUpl2Jtx7WqZFcX5md1Q3tfaCwcKuAwThf/gvX+SWtP7Iv2z2A2UwBbtZN/nDE4TbO7yVPspOHa4rJkOn/Q+vwZP3tICkWpZuZDKg5flyycHZNhpIBa9YHn+9LQN+FEQ3R5JLZOxlKayqGU5apFpPb7jjqVxQfYKtjx1NSK+DZ28OfiJ/uaNA9BK1k270eTvGMhqA908/B2J1/aLIf0Ws8NqR6qon0R8eaqDi65VlSSKoaNEz/KEbOuK4rZSfiBj1wHlZxUTi2vy2MBme3/WbSwFViAMVgt0jRBfUBm/SDJSevFCkGrvLXxv5n
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:52:25.5957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad27586-d7cd-4105-40ca-08df2ea8fdda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00006E1F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310

When the last CPU mapped to an hctx goes offline,
blk_mq_hctx_notify_offline() sets BLK_MQ_S_INACTIVE. Updating the
number of hardware queues exits every hctx and parks it on
q->unused_hctx_list. A later update can reuse a parked hctx through
blk_mq_alloc_and_init_hctx(), at any queue index, and nothing clears
the flag.

If the reused hctx is mapped to an online CPU, blk_mq_get_tag() keeps
returning BLK_MQ_NO_TAG for it. __blk_mq_alloc_requests() sleeps and
retries, expecting CPU hotplug to move the task to another CPU, so a
task that stays on that CPU never gets a tag. Onlining the original CPU
doesn't recover it either, because blk_mq_hctx_notify_online() only
clears the flag on the hctx that CPU now maps to.

Clear BLK_MQ_S_INACTIVE in blk_mq_init_hctx() so a reused hctx starts
like a freshly allocated one. A reused hctx has no cpuhp instances at
that point, so the offline callback can't set the flag again before
blk_mq_add_hw_queues_cpuhp() registers it. Clearing the flag in
blk_mq_exit_hctx() is not enough, because a parked hctx keeps its cpuhp
instances until blk_mq_remove_hw_queues_cpuhp(). Preserve the other
hctx state flags.

Reproduced with null_blk on v7.3 in a four-vCPU arm64 QEMU/KVM guest:

  modprobe null_blk nr_devices=0
  mkdir /sys/kernel/config/nullb/nullb0
  cd /sys/kernel/config/nullb/nullb0
  echo 4 > submit_queues; echo 1 > memory_backed; echo 16 > size
  echo 1 > power
  echo 0 > /sys/devices/system/cpu/cpu3/online
  echo 2 > submit_queues
  echo 4 > submit_queues

Offlining CPU3 marks hctx3 inactive. After the two updates it comes back
as hctx1 and is mapped to CPU0:

  # cat /sys/block/nullb0/mq/1/cpu_list
  0
  # cat /sys/kernel/debug/block/nullb0/hctx1/state
  INACTIVE

A 4K O_DIRECT read pinned to CPU0 hangs in D state, while the same read
on CPU1 and CPU2 completes. Onlining CPU3 again leaves hctx1 inactive
and the CPU0 read still hangs. With this change hctx1 state is empty and
the reads on CPU0, CPU1 and CPU2 complete, before and after onlining
CPU3.

Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 025a799f35b924d..00b75eb95dd943a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4002,6 +4002,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		goto fail;
 
 	hctx->queue_num = hctx_idx;
+	clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
 
 	hctx->tags = set->tags[hctx_idx];
 
-- 
2.43.0

