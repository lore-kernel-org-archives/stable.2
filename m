Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793134927;
	b=lHeyCofXuk4BrzP1UoWwbM2gLHETwEqHH5xCwHhjyqRGyJx+P+n71ErSCjBcpKt07jVJ
	 yIBaoZwuq7g42iF0TcC7NFRkdRa+t5tWc8ajRMgp/380BSz/UI139vgWGL4mvWZGlrD0X
	 KtfrdvCbNHb+cxVhrchFDKzgRnOFGFGn1efKVOvuK6qUckbdROWBBf6v6vIjldAIfZ2lu
	 FeknoC2DZF5RWgH+MMM7wQG9mShN7+TbWqUpcRCVaZpTa5kmVuJYpRJ5yWmRTuZMH39dI
	 71YB+haGdIGwsbTSEVx97WZ+q+1IxcBPGZL5Lpl846tX7rywO9IVd7KZnmdNNFQi80A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134927;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=J7PISI0rTxx1HAp4ny7a7MbQ+lot89H/oW+yZtSQyxM=;
	b=hu6oLZNpBrG6T85eXLe8dms60eEXqLgCYN16CAVva7//u6MdF138Ka8T86EFwA0T2TVF
	 5tcpeeJgyD2OzRNxBk3eYT9Na35g2A6JbdU1c8pWc0VofBUEqlTwcwZKajUkxUTYge7dL
	 pY8krxTjkFzLS3mzszVFkqMYpte+v+UWzxrOodyoR4h5FlVOi11rLOjdkvbSmPjJzr5IO
	 ZRfNo+lkIT7Bz0PA/wuvbY7upgp3CuxMJ96S4Hn34qwme7UWzUh3Mk9S84kM6gsdk1MNp
	 bniRMVPsZjJ7yTclOcZDMSHTE/YGOLhzbkEaEW38KOKtyLsN6xqtXP4Gfu2pNUu1onA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VFh2Xb9+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.10
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD64606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BD64606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VFh2Xb9+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VE5WLgtPIumVVWH+NVllhllhHNi5PpOXEojpQI3pOtIj8GcAu4q83B9pbtr62bxnAQc5IpAWywHoWc1ZDDKNQKVr6jUbemqxKiAdpAWoirbTiMY2LZMNqrZG2hXhugIT7VXcQz+9vzUL/ekrBKIpU5/or6UNimOVrBIab8aIfGbzP8QdG0oxkfqLbIMwu495npsRXnqQ65PRMu20jNfT6GBoskYPmceOz6BWvnnVW17CwJJDta9NULM1E+z7rVxEcu29yG8NmDNY8WhDxPBpHnVh06LHpLxwiAv+6OvJ/3pBkKgRw1IYuQF6lj+rcCq6htqt63p0jheV3n7j4/ubig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7PISI0rTxx1HAp4ny7a7MbQ+lot89H/oW+yZtSQyxM=;
 b=PFzCJI1On2Xe4syHJ/hl1Sx4eeVUBG4HZwAMDjDJwMgfmThRVVmnCw+bEI8MxXaLPh2soVVmMcqJzyeMj3z8y+nEkf23HCPK3mehMRKvNS9FGl0I4FDMU117aLHTpLca+Zj7BVcA24y28kcOGj6lKMQLOQTD+36A9gLqNkGQ/F0oBKpzA70UjWNO/rHQsZ7zETEhfDkGwSIea0W17K/tKgEHm6tc+gv7M5ftbYkVmwq0nB9tukCPN/r/SO5MNAgq4/11V/jPlXayeLbxJbYSoqE2aCtlNTygquaKPMcaT9RishLvUm4xOabBVBCMUcKYfU99JxtpoGdVLYJKTT70FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7PISI0rTxx1HAp4ny7a7MbQ+lot89H/oW+yZtSQyxM=;
 b=VFh2Xb9+lagW/re4ppiWaPu5Ao9p81pThnetFmcbwyF9hwBFGrV71FO3SvIpIGxAKnuywkSn3SGmLMJSIQqlB/f80/JEw5PHVwSmpzaRT+jFCDm+NDsbzVTSqRjqN73aOyiDL/1lwK+Avr8/9oNbjMyHp0TPU9dLb2TddOivMBo=
Received: from CH0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:610:e6::6)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:02:03 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:610:e6:cafe::2) by CH0PR03CA0271.outlook.office365.com
 (2603:10b6:610:e6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 21:02:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Tue, 27 Oct 2026 21:02:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 16:02:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 16:01:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 16:01:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<stable@vger.kernel.org>
CC: Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx11: set KMD_QUEUE for kernel gfx queues
Date: Tue, 27 Oct 2026 17:00:50 -0400
Message-ID: <20261027210051.2679583-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: be54e266-8a51-4008-6728-08df346d8cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|261021121427099003|11063799006|56012099006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zNEj4MIBpOfgFKrcDP7Agt3h6r6FY5+LD2P9i9wTJgbTWiX5dyepdg2s93meDFX7Gxyt+IwVEzevsc9FXP9W4M3QGss4GEf3dIqHpdYliogSmVOVx8BUDOgAfS9WksHx9qRjvIAU6KtTW7vd2W/56O61hzlcnJGNtMpuwGnCGQvDmpr/4vCqyI0T1gfjIg89fmJuZWZeOamtVG4G5LI0CMxZMWvHhPdZbaCk/S1rMp1XYEeiZdy7GjZC1YlFiD2JVD/g6OjBSNHtZ+cGe2GEBlJ0cWVkuo0zFG0wahv9a8gM5EZYKgjDUYkRXp4dF17fYoq4Mv7hBRVm2yOAFPM/hZE/P/CidwQFwESisk+OXbKICn1Z+iD6MM5DN8/ypKzDRJlr0c6m7gPOyhCXrb2apP8c+/q3H5oWsHeZZO+cJ6NUZMCJHHgLzbYkQFQRofB4wG6UZ40yesUYXaNZ5ipuveCAI/31xO0Sf0cZp5netWGhXfit4G6yIR8OruWlGnftt0u8L2chRzDdVpjCYdgFo2aLwOtMMSwX/P2on1fWcfLzH6a/Axe63LjtjsjzD/hVJWIuZGl9Wwd12e5VS04eW/4QYZEUD/Pz/9ggsABBIH0WAzYpmAxZyPUEtw1TLJGNiTYLBTFTaDYA5JahEFu7GjwjGFytBEklpzd/zk3d0uK2+CUrgwmg/o5fo18jOMiXvArKwKnglt7zepMFbJ9GKA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r9rZ/fnCHJ5oxa/yaibzg9eUE9y8ZpzTBkRUQjV9uXJSIBYhOPFkjAKNo2iLdchDgo8YmqOVijAvT/iSJLE2S83kkvF2qz/VhN10A3gfZlUmSdGYY+zUjdhMGCOopoPjR8zNckUIMF0T4nYG7XzhnoIK2r4JLwRmd1ggrdM9j4OUhO0wyh6xVag+rlapNChn2zgWoBEXHfivFalFpJKw58AN/1tdQlzuBN1M0xc6+KAMDFBHYcWNaVBZB7qlnVaTS5Y/fH2Bbt6k82r/OxFWApgtWSVi7ZawQYFsxdnXPjfa3m4eN8Tom51j1MJLs3YH5zJPv+YWACMpObto+DYEP3ZUbrJqkkrzUHax7SixYRHgltGRbpzOdiS0hwUwqREDuYCrOB+d2orp5+7CjvZq4u2Bo/5KgF2UcAi9gFIvCWYDeJrdyp83Zs2ZFdvPRtGX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:02:02.7408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be54e266-8a51-4008-6728-08df346d8cc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977

From: Jesse Zhang <Jesse.Zhang@amd.com>

Set KMD_QUEUE in the GFX MQD and kernel ring control registers so CP
preserves kernel IB VMIDs instead of replacing them with the queue VMID.
Use prop->kernel_queue to distinguish kernel and user MQDs.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 893642e0e3b2f5aa818e0ee4a49e2d401d541e3a)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a78e8f98f4d0..5ade48c8d43f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3737,6 +3737,7 @@ static int gfx_v11_0_cp_gfx_resume(struct amdgpu_device *adev)
 	rb_bufsz = order_base_2(ring->ring_size / 8);
 	tmp = REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
+	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, KMD_QUEUE, 1);
 	WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
 
 	/* Initialize the ring buffer's write pointers */
@@ -4145,6 +4146,7 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = regCP_GFX_HQD_CNTL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, KMD_QUEUE, prop->kernel_queue);
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
 #endif
-- 
2.56.0

