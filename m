Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB65476EF
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181830; cv=fail; b=GTnFdu5wVrtcfvit5Aq95DaVTWEIBFDOauAnva/i26zUGupm4/aI4yGR+2xV73kiZAo+45ir2JL9GI7GXIQ6AvUZkrZ2ZTNpp+pXQO9POtZQhSxKqMub4O/cVCQPg6aiAv6asIaClcW8JGJwgmjaueleCrJ2keRS7Lxt+2h7fUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181830; c=relaxed/simple;
	bh=oomCUKd22jPjVNiQkfNf3su2UtmI1iJpZmu6gL+Yf1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeN2gQCm5KYU/7+tJOp/BQKo1LLrJjtjACAZkKq0qzZvqbytb7uMs+UHUbtC/lvFySHhi6whTPXeaEakyi2IoUSpqdY41whmQFGF/uYk/d2qtrCGPrpC1wL3UjjbHFkveUGk62iEnVqUtVxQCAjjE/UtVY2YcNVZSvhe0j2Hxtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ktQBh98+; arc=fail smtp.client-ip=52.101.46.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ktQBh98+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7HHDGeby27BD5MvuByMrwBR6TsyLl6zZi8tmtpmQ6/OVPnB/DbuV6+4v2E0CiuUQGxxqzoVFy4oiGKB5+Ou/liuEMdjxr2oz3KqZE6p6WjulSJk4NJSGOrFruK4UFjyaF6A72ycqiaXBFhyTFA2qOEFm/3EUKq9rzK1Kb4GXFXnOPL/AsN0BZUz372ezFVAngh140yS+QCZz8hnvKRjpSWtCibiwczhmT33dW0LNKuzX0ehj7g9dnDh08oxO0AiPkFh0zbNsILjEZ2HJSBsxuu0kW2pKMIv9o1vWa+ZRgXlN8AeaSMZHOfVtpjmkM6lcNfITsMtfIlvtDCVe2T9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnjNNwmdlRkZH00dXJSf8089gqhpxjkZAyo+q5qFZik=;
 b=nu2F+RUW/Dl0XZvVO6RbRfF8eySoxdCTbUQOpUzMlEwtoXVPvFeayT+IRUcBdkfFN1TvCY3D2e6icM2AQyUAAGrcNcfG3DSZaERLXkDFTRBW5vVryNlkOq+h/lzt3FNt8Vg+8xVW/QtPKHAvO4JeKHDMFGHMmtyjEuBHFGi4OodeVCjXXlHPtyB8ozivGkoqa9if+2Br3Vzrq+p7cbLX7NunHx4JiK2/+0wuW88MnPHVb7qyHlJny9RknYIKnb2df1j/flsoY9SAj2M7hjkB3cbG3Moz91vwdhSGyRtMtaP9DT4mbhwAMuPzvshKjWCAxl0XcmgWtIPEF8TYHthL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnjNNwmdlRkZH00dXJSf8089gqhpxjkZAyo+q5qFZik=;
 b=ktQBh98+fXaH3DQrs4bHAkSOWQCb2BT9M9Jlf40U4N64cUWXOxbOhWQdLgE6njCW/lntgMF7zGMpF8GRcCA09CjnMpb63CzcC/EHneu4n9iZ7B62o3m4UU09i82vP2Ck8V9s7LV4+mhVcL0JBnS2NBWIgSO7eMMINiDQTmcBJ2w=
Received: from DS7PR03CA0193.namprd03.prod.outlook.com (2603:10b6:5:3b6::18)
 by DSVPR12MB999193.namprd12.prod.outlook.com (2603:10b6:8:496::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 16:43:37 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::4f) by DS7PR03CA0193.outlook.office365.com
 (2603:10b6:5:3b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 16:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 16:43:37 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 11:43:36 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <stable@vger.kernel.org>
CC: Leo Li <sunpeng.li@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7.2.y] drm/amd/display: Atomize IRQ register read/modify/write ops
Date: Wed, 23 Sep 2026 11:43:30 -0500
Message-ID: <20260923164330.3658735-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026092220-morale-drizzle-4aa3@gregkh>
References: <2026092220-morale-drizzle-4aa3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|DSVPR12MB999193:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f1e497-fe37-4bec-b8da-08df1991d0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	0wpHmagnktlMyZAuuQwz7w7dpTUN2UrUF7jKszg5NcpDHJAqQJsRW2fAq2g4Ze/+TW3QMx7QB0S9ffHitP8wR34bUYkOpL65iMK5bVlqG/rG1iKojWodQETJRo8M/FR/phgyheQ381xNh8DQi21RiymEeSY0P+VHivGBBEAgfB3DiPKsnfHsrwXKSXjU6hagknZq2cwy1A/d/ar8yfMaY0+sjpRNLK/JOTpCsduZy0Fd7d5tAlslzPcg4fnBo054qgcS7aiiHUtUSdugRRe+1yh08XMTQrcN4el8z/UWYOEMcJJKSvYA9oCQZ7yXEpnPlhWGt5tmUD19Ua+v+4GhQFsZZtDOl3z/YViKp7xrh+XIs69p2PWadyMfX/iBr2//zN6nZuzptqyQ+o5p0bziodZlbPgFBQCf8KClcizYmIB4WKyefJ++rjN9OXyuZ/52V68vb2FLPzYuM8JddKBcnE/dc0kPGW6AgxGuqhUtVww2fgDdNSCGj/bUI41G7GN0EzYfe4lM/YLq4ZqKgLt+YJ2+K8imjybrrcSNym1X5+4PeFkKtvC/cUwDcZWOGE89oJT1IGMjoSLSHOD894R3jMYcAJryhqWk8Z2lgVwDa+N7YiYooGWD6PPY6FlZXyUemRepN5mR6vA+q1GgXFw32w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DLVT5HYwr3hM8TDOT3L9d5Gp6kYmZacwHumLkUhRdb4b4yZ6gwi20xLMZXbxo9fQL2i3VeBQtKdi7v8Ix/vOVYjJICEMny82pNXRFD3sIaUALiWDSjwicROxDCL9xtxeCqkg5EpYwwSUU0ORruOacJznoFXlLwH3+cNhUo6KhDH5pcmNIqzh1glEpxt5X/L7pYljcYtveez+KzzkTGloVkCFbwh9piUpw205F6gIKu/u3dFGg1BK4iKutoaPwAKAyEYUhoKRQfB3lxbw98FNUO72KxptyRx5mdiJo5RwPaLxLJzPpS/Fq6ONvbuE51jV5UDSK9XPUzrYvf3SJzai6UkREDL2ZbMM4PqdaVrbNv29XqdOLN5BfZsBZVxveEfd6qBW1cRWYE8ExJVchVbkvNEgBM28z18ULfqs+DBXnIGEbjdpRHhWIddrppmXEt9t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:43:37.5223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f1e497-fe37-4bec-b8da-08df1991d0ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999193

From: Leo Li <sunpeng.li@amd.com>

[Why]

The OTG_GLOBAL_SYNC_STATUS register controls various HW IRQ sources for
the output timing generator (OTG). VUPDATE_NO_LOCK is one of them.

To enable the IRQ, driver sets the VUPDATE_NO_LOCK_EN bit in the
GLOBAL_SYNC_STATUS register.

To ack the IRQ after it fires, the driver sets the VUPDATE_NO_LOCK_CLEAR
bit in the same GLOBAL_SYNC_STATUS register.

The bit sets are done through read/modify/write operations, which are
not atomic. Thus, the following race is possible:

    Thread A:                       IRQ handler:
                                    *HW IRQ fires*
    # IRQ disable
    val = read(GLOBAL_SYNC_STATUS)
    unset(val, VUPDATE_NO_LOCK_EN)
    write(val, GLOBAL_SYNC_STATUS)
                                    # ACK reads VUPDATE_NO_LOCK_EN unset
                                    val1 = read(GLOBAL_SYNC_STATUS)
                                    set(val1, VUPDATE_NO_LOCK_CLEAR)
    # IRQ enable
    val = read(GLOBAL_SYNC_STATUS)
    set(val, VUPDATE_NO_LOCK_EN)
    write(val, GLOBAL_SYNC_STATUS)
                                    # BAD! clears VUPDATE_NO_LOCK_EN
                                    write(val1, GLOBAL_SYNC_STATUS)

Regarding the tagged Fixes: change, it appears the change made this race
more likely to occur. Since VUPDATE_NO_LOCK is now the sole IRQ source
for vblank handling, a single race on high refresh panels can lead to a
time out.

[How]

The GLOBAL_SYNC_STATUS register is only one example, other IRQ control
registers also share the same scheme. On top of GLOBAL_SYNC_STATUS,
let's clean up those as well.

To keep things simple, Let's atomize the IRQ rmw ops via a single
driver-wide spinlock. Due to the small scope of this lock, it is
unlikely to cause noticeable overhead on top of all the existing locking
within the IRQ set/handle paths.

Since DM is responsible for locking, wrap dc_interrupt_set/ack with the
spinlock in the new amdgpu_dm_irq_set/ack functions. Migrate/drop all
references in DM to dc_interrupt_set/ack to use amdgpu_dm_irq_set/ack
instead.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5616
Fixes: c87e6635d2db ("drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 70de0a0216583a53c946155f8c8adedfdca6b4e7)
Cc: stable@vger.kernel.org
(cherry picked from commit 63e19ef3ddab806c472748c825f4dc88dcd994e8)
Modified for unit tests not present in 7.2.y
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 12 ++++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 62 +++++++++++--------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h | 28 +++++++++
 6 files changed, 82 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9320e49e44289..0c57a419f07d1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3332,7 +3332,7 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 		if (acrtc && state->stream_status[i].plane_count != 0 &&
 		    amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
 			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
-			rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
+			rc = amdgpu_dm_irq_set(adev, irq_source, enable) ? 0 : -EBUSY;
 			if (rc)
 				drm_warn(adev_to_drm(adev), "Failed to %s pflip interrupts\n",
 					 enable ? "enable" : "disable");
@@ -3356,7 +3356,7 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 			/* During gpu-reset we disable and then enable vblank irq, so
 			 * don't use amdgpu_irq_get/put() to avoid refcount change.
 			 */
-			if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
+			if (!amdgpu_dm_irq_set(adev, irq_source, enable))
 				drm_warn(adev_to_drm(adev), "Failed to %sable vblank interrupt\n", enable ? "en" : "dis");
 
 		} else if (acrtc && state->stream_status[i].plane_count != 0) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index dd199e0b79226..043ca49367132 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -550,6 +550,18 @@ struct amdgpu_display_manager {
 	struct common_irq_params
 	vupdate_params[DC_IRQ_SOURCE_VUPDATE6 - DC_IRQ_SOURCE_VUPDATE1 + 1];
 
+	/**
+	 * @irq_reg_lock:
+	 *
+	 * Serializes the read-modify-writes of the HW interrupt control
+	 * registers. Several interrupt sources share one register - e.g. the
+	 * enable and clear bits of both VSTARTUP (vblank) and VUPDATE_NO_LOCK
+	 * live in OTG_GLOBAL_SYNC_STATUS. Therefore, enabling one source must
+	 * not race with acking another. Held only across amdgpu_dm_irq_set()
+	 * and amdgpu_dm_irq_ack().
+	 */
+	spinlock_t irq_reg_lock;
+
 	/**
 	 * @dmub_trace_params:
 	 *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 56bf907f1f6cc..e236ea1dcd65a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -31,6 +31,7 @@
 #include "amdgpu_dm_psr.h"
 #include "amdgpu_dm_replay.h"
 #include "amdgpu_dm_crtc.h"
+#include "amdgpu_dm_irq.h"
 #include "amdgpu_dm_plane.h"
 #include "amdgpu_dm_trace.h"
 #include "amdgpu_dm_debugfs.h"
@@ -87,7 +88,7 @@ int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 
 	irq_source = IRQ_TYPE_VUPDATE + acrtc->otg_inst;
 
-	rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
+	rc = amdgpu_dm_irq_set(adev, irq_source, enable) ? 0 : -EBUSY;
 
 	DRM_DEBUG_VBL("crtc %d - vupdate irq %sabling: r=%d\n",
 		      acrtc->crtc_id, enable ? "en" : "dis", rc);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 41aa8f9bb152b..903038ba4cf9f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1377,12 +1377,13 @@ void dm_helpers_free_gpu_mem(
 
 bool dm_helpers_dmub_outbox_interrupt_control(struct dc_context *ctx, bool enable)
 {
+	struct amdgpu_device *adev = ctx->driver_context;
 	enum dc_irq_source irq_source;
 	bool ret;
 
 	irq_source = DC_IRQ_SOURCE_DMCUB_OUTBOX;
 
-	ret = dc_interrupt_set(ctx->dc, irq_source, enable);
+	ret = amdgpu_dm_irq_set(adev, irq_source, enable);
 
 	DRM_DEBUG_DRIVER("Dmub trace irq %sabling: r=%d\n",
 			 enable ? "en" : "dis", ret);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index e49803a90edad..d59434e01dfdb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -424,6 +424,7 @@ int amdgpu_dm_irq_init(struct amdgpu_device *adev)
 	DRM_DEBUG_KMS("DM_IRQ\n");
 
 	spin_lock_init(&adev->dm.irq_handler_list_table_lock);
+	spin_lock_init(&adev->dm.irq_reg_lock);
 
 	for (src = 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
 		/* low context handler list init */
@@ -496,7 +497,7 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 		hnd_list_l = &adev->dm.irq_handler_list_low_tab[src];
 		hnd_list_h = &adev->dm.irq_handler_list_high_tab[src];
 		if (!list_empty(hnd_list_l) || !list_empty(hnd_list_h))
-			dc_interrupt_set(adev->dm.dc, src, false);
+			amdgpu_dm_irq_set(adev, src, false);
 
 		DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 
@@ -533,7 +534,7 @@ void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
 		hnd_list_l = &adev->dm.irq_handler_list_low_tab[src];
 		hnd_list_h = &adev->dm.irq_handler_list_high_tab[src];
 		if (!list_empty(hnd_list_l) || !list_empty(hnd_list_h))
-			dc_interrupt_set(adev->dm.dc, src, true);
+			amdgpu_dm_irq_set(adev, src, true);
 	}
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
@@ -558,7 +559,7 @@ void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 		hnd_list_l = &adev->dm.irq_handler_list_low_tab[src];
 		hnd_list_h = &adev->dm.irq_handler_list_high_tab[src];
 		if (!list_empty(hnd_list_l) || !list_empty(hnd_list_h))
-			dc_interrupt_set(adev->dm.dc, src, true);
+			amdgpu_dm_irq_set(adev, src, true);
 	}
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
@@ -645,6 +646,21 @@ static void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 }
 
+bool amdgpu_dm_irq_set(struct amdgpu_device *adev, enum dc_irq_source src,
+		       bool enable)
+{
+	guard(spinlock_irqsave)(&adev->dm.irq_reg_lock);
+
+	return dc_interrupt_set(adev->dm.dc, src, enable);
+}
+
+void amdgpu_dm_irq_ack(struct amdgpu_device *adev, enum dc_irq_source src)
+{
+	guard(spinlock_irqsave)(&adev->dm.irq_reg_lock);
+
+	dc_interrupt_ack(adev->dm.dc, src);
+}
+
 /**
  * amdgpu_dm_irq_handler - Generic DM IRQ handler
  * @adev: amdgpu base driver device containing the DM device
@@ -665,7 +681,7 @@ static int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 			entry->src_id,
 			entry->src_data[0]);
 
-	dc_interrupt_ack(adev->dm.dc, src);
+	amdgpu_dm_irq_ack(adev, src);
 
 	/* Call high irq work immediately */
 	amdgpu_dm_irq_immediate_work(adev, src);
@@ -703,7 +719,7 @@ static int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 	enum dc_irq_source src = amdgpu_dm_hpd_to_dal_irq_source(type);
 	bool st = (state == AMDGPU_IRQ_STATE_ENABLE);
 
-	dc_interrupt_set(adev->dm.dc, src, st);
+	amdgpu_dm_irq_set(adev, src, st);
 	return 0;
 }
 
@@ -737,7 +753,7 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
 	if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
 		dc_allow_idle_optimizations(dc, false);
 
-	dc_interrupt_set(adev->dm.dc, irq_source, st);
+	amdgpu_dm_irq_set(adev, irq_source, st);
 	return 0;
 }
 
@@ -791,7 +807,7 @@ static int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *adev,
 	enum dc_irq_source irq_source = DC_IRQ_SOURCE_DMCUB_OUTBOX;
 	bool st = (state == AMDGPU_IRQ_STATE_ENABLE);
 
-	dc_interrupt_set(adev->dm.dc, irq_source, st);
+	amdgpu_dm_irq_set(adev, irq_source, st);
 	return 0;
 }
 
@@ -817,7 +833,7 @@ static int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *adev,
 	enum dc_irq_source irq_source = DC_IRQ_SOURCE_DMCUB_OUTBOX0;
 	bool st = (state == AMDGPU_IRQ_STATE_ENABLE);
 
-	dc_interrupt_set(adev->dm.dc, irq_source, st);
+	amdgpu_dm_irq_set(adev, irq_source, st);
 	return 0;
 }
 
@@ -881,9 +897,7 @@ void amdgpu_dm_set_irq_funcs(struct amdgpu_device *adev)
 }
 void amdgpu_dm_outbox_init(struct amdgpu_device *adev)
 {
-	dc_interrupt_set(adev->dm.dc,
-		DC_IRQ_SOURCE_DMCUB_OUTBOX,
-		true);
+	amdgpu_dm_irq_set(adev, DC_IRQ_SOURCE_DMCUB_OUTBOX, true);
 }
 
 /**
@@ -905,7 +919,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 
 	/* First, clear all hpd and hpdrx interrupts */
 	for (i = DC_IRQ_SOURCE_HPD1; i <= DC_IRQ_SOURCE_HPD6RX; i++) {
-		if (!dc_interrupt_set(adev->dm.dc, i, false))
+		if (!amdgpu_dm_irq_set(adev, i, false))
 			drm_err(dev, "Failed to clear hpd(rx) source=%d on init\n",
 				i);
 	}
@@ -934,7 +948,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 		 * of dm. Note that only hpd interrupt types are registered with
 		 * base driver; hpd_rx types aren't. IOW, amdgpu_irq_get/put on
 		 * hpd_rx isn't available. DM currently controls hpd_rx
-		 * explicitly with dc_interrupt_set()
+		 * explicitly with amdgpu_dm_irq_set()
 		 */
 		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
 			irq_type = dc_link->irq_source_hpd - DC_IRQ_SOURCE_HPD1;
@@ -943,23 +957,21 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 			 * and what bios reports as the # of connectors with hpd
 			 * sources. Since the # of hpd source types registered
 			 * with base driver == mode_info.num_hpd, we have to
-			 * fallback to dc_interrupt_set for the remaining types.
+			 * fallback to amdgpu_dm_irq_set for the remaining types.
 			 */
 			if (irq_type < adev->mode_info.num_hpd) {
 				if (amdgpu_irq_get(adev, &adev->hpd_irq, irq_type))
 					drm_err(dev, "DM_IRQ: Failed get HPD for source=%d)!\n",
 						dc_link->irq_source_hpd);
 			} else {
-				dc_interrupt_set(adev->dm.dc,
-						 dc_link->irq_source_hpd,
-						 true);
+				amdgpu_dm_irq_set(adev, dc_link->irq_source_hpd,
+						  true);
 			}
 		}
 
 		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
-			dc_interrupt_set(adev->dm.dc,
-					dc_link->irq_source_hpd_rx,
-					true);
+			amdgpu_dm_irq_set(adev, dc_link->irq_source_hpd_rx,
+					  true);
 		}
 	}
 	drm_connector_list_iter_end(&iter);
@@ -1003,16 +1015,14 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 					drm_err(dev, "DM_IRQ: Failed put HPD for source=%d!\n",
 						dc_link->irq_source_hpd);
 			} else {
-				dc_interrupt_set(adev->dm.dc,
-						 dc_link->irq_source_hpd,
-						 false);
+				amdgpu_dm_irq_set(adev, dc_link->irq_source_hpd,
+						  false);
 			}
 		}
 
 		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
-			dc_interrupt_set(adev->dm.dc,
-					dc_link->irq_source_hpd_rx,
-					false);
+			amdgpu_dm_irq_set(adev, dc_link->irq_source_hpd_rx,
+					  false);
 		}
 	}
 	drm_connector_list_iter_end(&iter);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index 4f6b58f4f90d7..f0a4577848f35 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -81,6 +81,34 @@ void amdgpu_dm_irq_unregister_interrupt(struct amdgpu_device *adev,
 					enum dc_irq_source irq_source,
 					void *ih_index);
 
+/**
+ * amdgpu_dm_irq_set - enable or disable a DC interrupt source.
+ *
+ * @adev: AMD DRM device
+ * @src: DC interrupt source to toggle
+ * @enable: true to enable the source, false to disable it
+ *
+ * DM-wide replacement for dc_interrupt_set(). As locking is DM's
+ * responsibility, this is a thin wrapper serializes the underlying
+ * read-modify-write against the other interrupt sources sharing HW control
+ * registers with @src, so DM must never call dc_interrupt_set() directly.
+ *
+ * Returns: true if the source was toggled.
+ */
+bool amdgpu_dm_irq_set(struct amdgpu_device *adev, enum dc_irq_source src,
+		       bool enable);
+
+/**
+ * amdgpu_dm_irq_ack - acknowledge a DC interrupt source.
+ *
+ * @adev: AMD DRM device
+ * @src: DC interrupt source to acknowledge
+ *
+ * DM-wide replacement for dc_interrupt_ack(), serialized the same way as
+ * amdgpu_dm_irq_set().
+ */
+void amdgpu_dm_irq_ack(struct amdgpu_device *adev, enum dc_irq_source src);
+
 void amdgpu_dm_set_irq_funcs(struct amdgpu_device *adev);
 
 void amdgpu_dm_outbox_init(struct amdgpu_device *adev);
-- 
2.43.0

