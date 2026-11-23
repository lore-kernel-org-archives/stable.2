Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442400;
	b=xsdha97UYdP/g+VYth05Sw7LjcNbB9QIDcO6ocyf+vDdKO6l+On9NGNtZg6BcUCgkJAB
	 mNFAMi9JdavmOBqZwNB3f32zNUVBa0pBDR6LUpugBadcd+SGVrV5sAp35euWRtopNNZUZ
	 7xgBvKEmRXuYYYUAjC+AMJjTIQx4m8HS6bdw6agjEojMJeMgYtmF8yRwYxmcRHHNao4if
	 15jaYGkpzx8vETOMuZUL3q2iIanein8g7qaG+9SehK/1yyeNTGA7xjSG/uX3a8+EczPbA
	 rXx7sAQzgG2yblQLlI+EKSozthyqxifC3xAruRXbKwhlh44TVW4XwT/nLid1tJMol5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442400;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8/Ai0ZIeqooEunehz+6+0YRKMkDutU6G8QBtg0XNroU=;
	b=khuGLsRsVNiXYxhZCU6ir2c+xlZhC5jvqRj43jNijeyhbhxSufw/bQaA0L9qnASm+sa6
	 UEIcyKQHV7w7koVmIfuRz3ylpyCPir7f3SVZpA/zgmHoqcsonn5980A72dmJ0Qoj8ByTF
	 Nim0a2hH8uaxmaP+o7fY9KXvRvBVWIpFZJxNeTL/cQZJe8NMd0EaZt8ijGoolAZYYcsVy
	 bCXwb3cA1MhwmqEXf3cWQ4OmxTS/O9W0IXM3WQRUd/kZ0OOYedyZw2HB7sZBqxVkNh9Fr
	 Lzx+4K+fsAY8EGJi9XtXqFKGLD777RPfoV+Q+zChmiMTE+2+mUQAoo3+FaqJfbK5UmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="oBu/QvoG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.52
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7D606A31A;
	Mon, 23 Nov 2026 13:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oBu/QvoG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOaOLhOwSPhjh4qlfULOGtDPAEGjrzqvlX0JDRDMYdtsfOpXJh+87NTrH2Ak94IkX/X5KrUJqk8Pc1PJG1DByhcBpL2Zjho2HnK9PWZ/dHdMQ/TUhrmxorwYcXI2zAF55Nzq7UkAdJq54y/SXZ0d6jdrxviNNq99M+be2FUTp8b0u7fhatXm+jNZ5b5iYysT+o3PqVhaNt+VXy1MyUfPMH9OrW4utVKEklm2HCsSv0lKpbb4H/KRXgPgfoGtVSov7+oP2xDXGO1t23RA7cenfvr2EhBVPLP/KQREeW6JDIjNQGlkcYLZ+lxph/AJ7quW9w0H8GJMR0L/oq16goVDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/Ai0ZIeqooEunehz+6+0YRKMkDutU6G8QBtg0XNroU=;
 b=aC+D8CGdkzMBwzxdIjnFcJvibK2PQaR1MhM8Y66p1mtq4kcGlV/B5RMz84d/2gS650ui96qEBvTLf1SF4jgSrd5MiVAEIIXhAUzlrromc3X+FO4PTSLVKPwZZz47p13xvvgmZGnjGDfQVhjzS/fiXJIDrLDiLrHrxYKciQFsiulEsbq7nNXgRfcff+lPASX3zw7bw0Xs4M08mKM9eJGf9taXjwavTtCekd1V92nEdRGW8rLd5c+J7sFLKU0JjJmGKShQCwwdsi+0EPWxoG2zZZEUDTDPLUUZQVNCV4JKEXLQVD9qqrQaI5ZWgX1Z4dRxCN9+KIGkIVfaOEowp3hXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/Ai0ZIeqooEunehz+6+0YRKMkDutU6G8QBtg0XNroU=;
 b=oBu/QvoGbLVlMPpEGudpsGWGPB+wwECSpdWGDtzG5c6kGUg3g0v8Cpmip0A14QQGwYYAUJy6te8BduO7zjBh75PgxDeola/Js+EpuTmHXJHqovpCyEZjQcPNmzyh/1XjFHBBtxfrtX5oBgcDntOTa6WGUV3duwknIrb0uPo/1BoiA3fz5SqgjTyK1opjN1KzLuf9t9MMjtLxVCwKLfJ21zaISkqRFX9GRQWZeZsr/hgBFa8xWd8guqwO7rUrkY4FvtRdWVq7zCdMzDDKaSUWm8p4+rJHdz4GDLgpCyp6tor51U5EWI628htbaSsY8qj/y905vFsQcY60zn/oZxnbJw==
Received: from CH0PR03CA0306.namprd03.prod.outlook.com (2603:10b6:610:118::35)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 23 Nov
 2026 13:59:40 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::34) by CH0PR03CA0306.outlook.office365.com
 (2603:10b6:610:118::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 13:59:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 13:59:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 05:59:24 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 05:59:24 -0800
Received: from f43.com (10.127.8.9) by mail.nvidia.com (10.126.190.180) with
 Microsoft SMTP Server id 15.2.2562.57 via Frontend Transport; Mon, 23 Nov
 2026 05:59:21 -0800
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Eugenio Perez Martin
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 3/3] vdpa/mlx5: Don't flush the workqueue under reslock
Date: Mon, 23 Nov 2026 15:56:46 +0200
Message-ID: <20261123135646.3962652-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123135646.3962652-2-dtatulea@nvidia.com>
References: <20261123135646.3962652-2-dtatulea@nvidia.com>
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
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c5d42e-9ccd-4307-5b07-08df496a04be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|261009221727099003|22082099003|18002099003|261009223327099003|261009223027099003|261009220027099003|261009221227099003|11063799006|261102123227099003|56012099006|261026121527099003|261028144727099003|261021121427099003|10067099003|261026140227099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	s0Tls5cZEd67qSKT/o/TjOmRqZ0WYJB2LUrEVj4JGkH2R/w+IsUjMZxyoZkMsQIBtfbPkwVoJul+4yx/5y8egeW9CMwMXDpD5BAo+tU7mwCZdSNjm0UgmgJmMD3msUZG5pvMnvX/sEcd4UT917ghBoWebYs9uhdfeOT5JyDw6aZkQUWDvNUTEwyJODRKQ7LDJp46bq6Zrpt18yi8VkIY5fHuaYHrspRS24pd6nmzN9R8nXwRXNdhA37Z5ajTeWGsV7Wu9c2D8ZLp21uClwEW6IxjksCb2rewtoAMhshXB7kcvkQbmNuhjgyZbijVoPcyUcSPmbi+Vw2zZozDm5h9lGItrm7vBa2OTHC7gEsuJ0G/LlqwAHCq3nHsjzB14x0F5iWIfPYCHTlwlPFzn/c396iUiKGoOPxgT2JQe10iPTqLvUZwUjp/o/5cCHDu161sXzXHtAq4saztCQAoB02BfOn0jKO4CnyGu4VfXVhEkb5zDoorYufXCfT94fh34bfdJPRcj/di/ZCbJ8ETBFkpU/uIM3G75XJ23G2MSIUUuPG8P++pMVelAL02zzQI4PpaG4RTDJVohtzWdvuEaclyfnKEPyYxjyAr7ujpyiILvVu3vtqkgOZXBHvnc00mTPOwcH/6+1EvHJFPifaVNPNBLxixyJ/AgHBkCdQxp/5Okmc2YAiVvhjzllw84TRF8l6v+rfdUlaVX32GuUbFoxp+Hw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(261009221727099003)(22082099003)(18002099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221227099003)(11063799006)(261102123227099003)(56012099006)(261026121527099003)(261028144727099003)(261021121427099003)(10067099003)(261026140227099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gMjgW4YD6uEuHqEhEIdjpOsJunXzo4zdtTci4he+v8B67X8g1l9h2afKqfiRhY98HNLz6X8EOSlL6H7pmyPoUseT1v0+VwNLUs8FljoCffLFrNesup8lH9C0dy1DexWYScdzApcLJKFnnLcZJB2VVcsIJ0YHE2YBnbv/E4dfjGDRu7yuH+CY1TrYfMJ8X8afw+GkiNamU6sHq7H/KFGrdQTRq4hvJw2xf/f7bbsC1SbetFnRy48qsRU2Ch0bPpJlRjQjDl/WWGfa/S/1HwIDmSKk4hKm6/cY5yvYG2q+Kf2eQxoIbUq+uv5GCidmTVMwEH7OjFfnwZLibkhtbNN3Yxy7uOkWNyWUNgGZbsR09YrzMyYdnjt9j9mygS3NZ2hU6Q7cLS+QQiJI8/8YR09Rh7H8JCkZ8yT36t8Scoqx/MnzP4W8RlZKYWLuJjZaz27o
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:59:40.3330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c5d42e-9ccd-4307-5b07-08df496a04be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212

The control VQ work (mlx5_cvq_kick_handler()) runs on mvdev->wq and
takes reslock. Device reset and the error path of .set_status take
reslock and then call unregister_link_notifier() which flushes the same
workqueue. A deadlock occurs if a CVQ kick arrives just before the reset
for the CVQ work.

Lockdep caught this when QEMU quits (pkill qemu) and closes the
vhost-vdpa device:

 ======================================================
 WARNING: possible circular locking dependency detected
 ------------------------------------------------------
 qemu-system-x86/5785 is trying to acquire lock:
 ff110001cd292940 ((wq_completion)mlx5_vdpa_wq){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x7a/0x180

 but task is already holding lock:
 ff11000136eb4928 (&ndev->reslock){+.+.}-{4:4}, at: mlx5_vdpa_compat_reset+0xed/0x760 [mlx5_vdpa]

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #2 (&ndev->reslock){+.+.}-{4:4}:
        lock_acquire+0x126/0x330
        down_write+0x87/0x1d0
        mlx5_cvq_kick_handler+0xb1/0x1180 [mlx5_vdpa]
        process_one_work+0x8df/0x1660
        worker_thread+0x62c/0x1030
        kthread+0x377/0x490
        ret_from_fork+0x4d7/0x720
        ret_from_fork_asm+0x11/0x20

 -> #1 ((work_completion)(&ndev->cvq_ent.work)){+.+.}-{0:0}:
        lock_acquire+0x126/0x330
        process_one_work+0x874/0x1660
        worker_thread+0x62c/0x1030
        kthread+0x377/0x490
        ret_from_fork+0x4d7/0x720
        ret_from_fork_asm+0x11/0x20

 -> #0 ((wq_completion)mlx5_vdpa_wq){+.+.}-{0:0}:
        check_prev_add+0xe8/0xdb0
        __lock_acquire+0x1801/0x23e0
        lock_acquire+0x126/0x330
        touch_wq_lockdep_map+0x93/0x180
        __flush_workqueue+0xed/0x1090
        unregister_link_notifier+0x10c/0x170 [mlx5_vdpa]
        mlx5_vdpa_compat_reset+0xfe/0x760 [mlx5_vdpa]
        mlx5_vdpa_reset+0x15/0x30 [mlx5_vdpa]
        _compat_vdpa_reset+0x29b/0x3b0 [vhost_vdpa]
        vhost_vdpa_release+0x16f/0x380 [vhost_vdpa]
        __fput+0x36a/0xaa0
        task_work_run+0x111/0x1f0
        do_exit+0x7ba/0x2590
        do_group_exit+0xb8/0x250
        get_signal+0x1f46/0x2020
        arch_do_signal_or_restart+0x79/0x4a0
        exit_to_user_mode_loop+0xbe/0x450
        do_syscall_64+0x257/0x4f0
        entry_SYSCALL_64_after_hwframe+0x4b/0x53

 other info that might help us debug this:

 Chain exists of:
   (wq_completion)mlx5_vdpa_wq --> (work_completion)(&ndev->cvq_ent.work) --> &ndev->reslock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&ndev->reslock);
                                lock((work_completion)(&ndev->cvq_ent.work));
                                lock(&ndev->reslock);
   lock((wq_completion)mlx5_vdpa_wq);

  *** DEADLOCK ***

 locks held by qemu-system-x86/5785: 3, last CPU#9:
  #0: ff1100021d7c2068 (&dev->mutex#3){+.+.}-{4:4}, at: vhost_vdpa_release+0x4b/0x380 [vhost_vdpa]
  #1: ff11000136eb44c8 (&vdev->cf_lock){++++}-{4:4}, at: _compat_vdpa_reset+0x16b/0x3b0 [vhost_vdpa]
  #2: ff11000136eb4928 (&ndev->reslock){+.+.}-{4:4}, at: mlx5_vdpa_compat_reset+0xed/0x760 [mlx5_vdpa]

vhost_vdpa_release() resets the device before stopping the kick
handlers, so CVQ kicks can still be queued while the reset runs.

The fix is to move unregister_link_notifier() calls outside of
reslock. The function doesn't need the reslock.

Fixes: c384c2401eed ("vdpa/mlx5: Avoid losing link state updates")
Cc: stable@vger.kernel.org
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index f1c5f72032a3..a175f734517d 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2908,6 +2908,8 @@ static void unregister_link_notifier(struct mlx5_vdpa_net *ndev)
 
 	ndev->nb_registered = false;
 	mlx5_notifier_unregister(ndev->mvdev.mdev, &ndev->nb);
+	/* mlx5_cvq_kick_handler() work needs the reslock. */
+	lockdep_assert_not_held(&ndev->reslock);
 	if (ndev->mvdev.wq)
 		flush_workqueue(ndev->mvdev.wq);
 }
@@ -3215,6 +3217,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	bool unregister_nb = false;
 	int err;
 
 	print_status(mvdev, status, true);
@@ -3257,12 +3260,14 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 	return;
 
 err_driver:
-	unregister_link_notifier(ndev);
+	unregister_nb = true;
 err_setup:
 	mlx5_vdpa_clean_mrs(&ndev->mvdev);
 	ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
 err_clear:
 	up_write(&ndev->reslock);
+	if (unregister_nb)
+		unregister_link_notifier(ndev);
 }
 
 static void init_group_to_asid_map(struct mlx5_vdpa_dev *mvdev)
@@ -3301,9 +3306,9 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
 
 	print_status(mvdev, 0, true);
 	mlx5_vdpa_info(mvdev, "performing device reset\n");
+	unregister_link_notifier(ndev);
 
 	down_write(&ndev->reslock);
-	unregister_link_notifier(ndev);
 	vq_reset = needs_vqs_reset(mvdev);
 	if (vq_reset) {
 		teardown_vq_resources(ndev);
-- 
2.54.0

