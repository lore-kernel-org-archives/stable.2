Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792431685;
	b=AcyWNOmP1agq78Rp+FyM/pg60w86sABM69CcJjO7Tjnea6w/brwnNuNSA/rArMG8rOxX
	 t1BLGfqG6hMcZ8y05/emz+njnZh6YjxrA3K32o3PXzjwU1Fop6l1rmrW60h6XXBIqTPv8
	 BqmS4k5sWSSxqxVNZ5EBu+3JwgNbWK4m5ZfzggZ572AbK3Mvyzf3y1pEuj133mAdWOuRP
	 87k8RZgzapwySL3awdGkBgsM4xEg+sn2nW4bvJX7Jl7eHh9/FVhULEtKrgDn0Zn1+7NPV
	 9NmWnYu5bPZgO46bNhxdgSH+d8cIr8CUtXoM8iF/skLTB0si6N5KiyuBrIvtnqeQFNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431685;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
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
	bh=EHXyXg1Wo2eEs4uLTGWFw5xQUc8eZGFEc0m8cjku9g8=;
	b=lE6/wEeB2PeOSgNsswXUajuPbmEfGCOvGf5F2Y4NtOhCh78XRQ3PgrmqAXCT1hQwXi7b
	 ZYyeus7+/lQfcqktXC6zhxokiqJRr4M6UG+i4fb7dKz4+Y4+wM9B8e1YbCxv671/pVMuM
	 4TlfUWuqCnV/Ynbr4YoFPVzUOgNU0CkMmBqtrj2+nXE1+vAGe2wNo/L3p+Rri+VHGHNIL
	 unLMSf0mScnx4CNOAVuhBkYAm4NKPE45+BOko//Vovszp58/gVriMCGTHE9zzdXrVNOLz
	 7uwN8mAoyynv0EOHopC6rJgd62vgVg21gTx4xn7u96FDBPGsONIYbB6FWOPlxr5JwuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="RpPe8/Cs";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.56
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF8606A31C
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCAF8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RpPe8/Cs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjlzcHkI0ZoDpJdhBD+nutQOCHTKojks89HgVBjcICrdZOTQ46VXmoC10L5NvpcLL8h5zG0eDyPJRnu/tNS/bQLQs9BECSPKG1YU0REDL1c+SeDhO3Nnnb+lrwx1MW9Zf8SkCELPxge3iW9GbwdTmNeftjDgTIcxjnXe1mWb8UQeOjxKdsl1vlV6QLmDat2WpfGbgHD+MHvH0YdNrga4Bn/JjQBlcnxsuOR56+74OA7GLnkLnlWKfH9brxKSdwWAdKiJH+t7jNNxyU7vXzo3SEV2zhJQWYKTkJC0PCT0PjwJIt8KwRW05tO3iEdsh1adNDK3PvUvBSNU3pTztkJ1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHXyXg1Wo2eEs4uLTGWFw5xQUc8eZGFEc0m8cjku9g8=;
 b=Yf4+aYteM4nQY6bgEEeNMpRLqWsUXM99Jy4gRw/M2JQ/j0FOS+r1eARGznmkVCS5BQ0y3yEjub/it5muh7AvNpnft26aG7u8bc7eXsm7MYahivr5JSKKmH0eN2O3p3irQQB4Nf61/Ub5Gc3sUylARPL9dLcZx7WGjL5KrkzVv2K1bW7we8TLqJ8ARGvTHyjiZ2nyH4WxoVM5sdAWv6MoV3wjLiUHu3EPLDvClmAU2wNjwhkENawpeMYioB5YQGW2j8WYtRuiQk/kCEyY5Q+bjR9VzB51pvj5qb/zj/maSfXI39sr73qXSl81ONJZBlU6S4s2InCibSXCRvDnE1M8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHXyXg1Wo2eEs4uLTGWFw5xQUc8eZGFEc0m8cjku9g8=;
 b=RpPe8/CstCUvsLlx6cnEUnkffUEyuUU7j0sT+hyrFLThstegyzf9rkDOQKPLkvjwc6ha5HZlnnJ1V0kX2QNMSFRggnTgUJIBqJcJRWuDXLVFsRpXqn7qZzP0NjjofZHtvQWdBdoi5z5k8sFxjyaR+hAaTaO45no13rm7kXNCjGU=
Received: from PH0PR07CA0058.namprd07.prod.outlook.com (2603:10b6:510:e::33)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 17:41:19 +0000
Received: from CY7PEPF000000E8.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::97) by PH0PR07CA0058.outlook.office365.com
 (2603:10b6:510:e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 17:41:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000E8.mail.protection.outlook.com (10.167.247.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 17:41:18 +0000
Received: from ubuntu-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 19 Oct 2026 12:41:05 -0500
From: Leo Liu <leo.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: call hw_fini for IP blocks whose hw_init failed
Date: Mon, 19 Oct 2026 13:40:39 -0400
Message-ID: <20261019174039.9771-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019153942.4067-1-leo.liu@amd.com>
References: <20261019153942.4067-1-leo.liu@amd.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000E8:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ddf823-27aa-47bf-8f21-08df2e082ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|42112799006|36860700016|82310400026|56012099006|11063799006|5023799004|261009221727099003|261009223027099003|261009223327099003|261009221227099003|10067099003|261009220027099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	lwzYtlRgKaa0d7g3h1Jw2CKu8LU2NKXGW7fGKLem0hRRE+cpy3gxV1cAt7VqbQ4TVg9f2repGBySLQ4386lZ6OQdCgMrBOouUaxA/fUWIJDnHOiHy8wxoo+SP7Uw1rOFc7O41l2m/99Ri/LcYIGbfSD1/hphfsvPOQLAeAxkpwX2FWPL/VDrbxellcyaAVVLhk6W23qnmbOGpgcD3cMSbct+lMUOugWK7p8sLLKGqDr4WLTKaw8ogVNfO7fbvRu49KRwK5CsxQ/QRVbkf5JD8M9KGkeZ9RLEmyCuW7a4QKG4QYVTp5ZTsDnp6od4kSTRWIraltNZnz1OvQaGID5XPorUh1FlBCG5u2D/81ziYdCsamNJhu3of8ZrSJd+O+0ICH2L4IyDDQXRXBAvkEVs3e0WLAONea70vMAP8i8DSg1hTyfW+tRxrARCkEGx6Wt3CT74NJNEB0kq/e91xEP5tOH69cN5tUEr1VDaTwSEbxy1PX0ssVZnt5xSXIDErJF/4Kqlu/v45xqOWMWUX8VAE+ZZSrnZFA3110neRedfINJ55BRsF16TohjuVPSH6ZUz3STHGfx/bQPB+BpBsD1TQaHeXJRSmJ39vg3w9/LyiSOMT1oZK3i5aqTqkTUE5kQyG6nLZeEMEu247ISxsKS0JzjtihGyulUokHDvOkuRXGzLXTZBQECYhtol8SiyUEHZ3XbWCaNjQ3rvzGLjot77vw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(42112799006)(36860700016)(82310400026)(56012099006)(11063799006)(5023799004)(261009221727099003)(261009223027099003)(261009223327099003)(261009221227099003)(10067099003)(261009220027099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cJ9QFxq4CMOCHLEh9c7e4JCjjbgdBKFe+VPX9ovbXk4pAcaopiPe9I5SVvsJtnHJABd9E51cVVUW4fD3dp8ff1TT58/bAdDbmNRxxjjuHth8OpptjXDi0x4I+qWIHI3mueAJhGeOPATEejgEcJ98lO+CaaaNfVEu0nYfBZVG0ByIAzltH3650r8s7de/haQt4VVaggOTjzi4rP9NZ9JchJyRopuZGTafn1IR01pdzAgc9TYVpHSBeCyCwnSHFIJWiE9udj3za0Vq2qXPw1Zc45r3I81VmVppMZXEpnHHnkoZt/A9UZTdahA4iqCY2Q4dGNtpZbUgyGWoGv/XiPSSGupyzbvoztUBdIMPqtLVip1KZnPc6e6uaq3mGvM4GPwv18kgENeIAuq0SZpTsIOmczQa5yRpbvtxZjUowHy2Typi+S0s0dkEMtq8d3NxSQaO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 17:41:18.7726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ddf823-27aa-47bf-8f21-08df2e082ebc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000E8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098

When an IP block's hw_init() fails, amdgpu_device_ip_fini_early() skips
its hw_fini() because status.hw was never set.  For VCN, UVD, VCE, and
JPEG this leaves their idle work queued after sw_fini() frees the adev
state the handler touches, causing a use-after-free.

The bug was reported on MI355X after unloading GIM then loading amdgpu.
GIM's teardown resets the GPU, leaving VCN unresponsive.
amdgpu_vcn_enc_ring_test_ring() calls amdgpu_ring_commit() — which
schedules the idle work — before polling rptr.  The poll times out
(-ETIMEDOUT), hw_init() fails, hw_fini() is skipped, and the idle work
handler fires after sw_fini() against freed state.

The ticket (Link below) suggests cancelling the idle work on all
failed-probe/sw_fini paths.  This patch takes a different approach: the
idle work cancel belongs in hw_fini(), which is already the correct
counterpart to hw_init() for hardware-domain cleanup.  Rather than
scattering cancel calls across sw_fini() or every IP's hw_init() error
path, we ensure hw_fini() is invoked for any block whose hw_init() was
attempted but failed.

Add status.hw_init_attempted, set it in amdgpu_device_ip_hw_init_phase2()
on hw_init() failure, and check it alongside status.hw in
amdgpu_device_ip_fini_early().  This causes fini_early() to call hw_fini()
for the failed block in its correct reverse-order position — a single
change in one file that covers all IP types without touching any per-IP
code.

Link: https://github.com/ROCm/amdgpu/issues/234
Fixes: 416e1fab4752 ("drm/amdgpu: drop redundant cancel_delayed_work_sync call")
Cc: stable@vger.kernel.org
Assisted-by: Claude:Claude-Sonnet-4.6
Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h     | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b74f9136aa2e..66e24bd0859a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2233,6 +2233,7 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
 			dev_err(adev->dev,
 				"hw_init of IP block <%s> failed %d\n",
 				adev->ip_blocks[i].version->funcs->name, r);
+			adev->ip_blocks[i].status.hw_init_attempted = true;
 			return r;
 		}
 		adev->ip_blocks[i].status.hw = true;
@@ -2850,6 +2851,7 @@ static void amdgpu_ip_block_hw_fini(struct amdgpu_ip_block *ip_block)
 	}
 
 	ip_block->status.hw = false;
+	ip_block->status.hw_init_attempted = false;
 }
 
 /**
@@ -2902,7 +2904,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_smu_fini_early(adev);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!adev->ip_blocks[i].status.hw)
+		if (!adev->ip_blocks[i].status.hw &&
+		    !adev->ip_blocks[i].status.hw_init_attempted)
 			continue;
 
 		amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
index 5dd6273982c4..bfa27ca05dbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -99,6 +99,7 @@ struct amdgpu_ip_block_status {
 	bool valid;
 	bool sw;
 	bool hw;
+	bool hw_init_attempted;
 	bool late_initialized;
 	bool hang;
 };
-- 
2.43.0

