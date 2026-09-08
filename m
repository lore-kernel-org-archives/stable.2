Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC8238DC79
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867795; cv=fail; b=EC4RdxyGCbORreN6rzeOSQgudr6X0Tgr/74LP4Tslz1istQz/mIorVBJagF1Ib1zZo+h0vhrqIptm+4P5hMnxBp4NGZBHl2IyJPGVmY/ucLMa+mnCm1KH7QSMnH/FG8YbJJlRv8iMiGqSHZrpQ7HS3F8kFkPgOfq3EBHe0hx8Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867795; c=relaxed/simple;
	bh=QW9TIw0VxXlZbeVeeeiNmDdOLwX1aZIojEGahIhJUL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8Co1xdUeC5OzCJDFduEMKDOZCXcIETv3gjmfzGRCwQUHkoS58iWcUImTMDE1nJxSFFkk6Bj+yR+jBpXN8Q5f1zXk4bzivS/Pf2WSz7CVwKxS0AAa80LmvmeAfR+ZNhfnhDLNKyp1ctlWB3NaW6sPI7EUEEbwmv9lxf3W20GFcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r86ubTkF; arc=fail smtp.client-ip=40.93.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r86ubTkF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQKRFzY8Da9eRjIXzqYSa5/u3DxZ4SVZn2gQhLWo1jgazLSOjmPDJTXlDeN8J76cC7A6zANA//Obw7NfWc6D3i6m5Qlx0jPZRW8KFQBGjFSD1HMMrDVWES2cOV0Ee7dSmUQ4WYZkA2WmkvGWoemVzX4CEN2mBTt600UuSRAGUw7N6yTRiKDmpgfc/Xi2L1oqXiqAPA41MohzXUp+YqJJwTtiunK1R+pwtCwcZim9i98xVH9pmNGCrkoAQfCUwyVt1kYEkqqFactNPgahy88WXk0eSCoz+hsx8gMIHpzjavhqBUrQXAUSQhDqE2//vvXQmhzt1zEvmC6xneYAaNhPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2eivWX6zwOVuUUF1EwqqvF9g7Hx4NG73XlwWekH370=;
 b=XHGedIvG3AdD1Zba6ieCfX0MnGelnXC02M8baoFMZ4k20m7LKQKZ3jdRb4jwcrBMQosH5KoCde4XaNGSGDSehi6g980x9VJ+yfSyaOKWgKazy2nI8St3TxmwObmM5REfYrN6IOZRiniKPdFqNRnXcMAhIXkYDE90GDodU8GLGlrtpadiY0VEuDtKYBh/Ndjre5+ziJYn0jDAFF4uND0yX7UDMP+2tD9lQikNA6MK2lKu4xgiSc3gqMzZ24I2lp8bEuIVeqY91FXPOs5kOCzclMW6Eee9XiBYJXxly6hBTj6qnWJwfyngyK3TUyOjZna/j/XI8CRV2+nW5F4+vtt9mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2eivWX6zwOVuUUF1EwqqvF9g7Hx4NG73XlwWekH370=;
 b=r86ubTkFhdNOUdrFRh+furtfjLe7ZXksqkpv7q2A/1cIwrpLZ7DD+ofl6EY1y/FMT90zV3xzyAatKVkeFQec76gunYbuj8R33YH5v6M7FNgWLTlVrFcN/9r5ynhVwAZtGszd6gvaB25CmGegeswSYQwFQDeaq/GOv9waviQxevw=
Received: from PH7P220CA0120.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::22)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 11:42:56 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::ad) by PH7P220CA0120.outlook.office365.com
 (2603:10b6:510:32d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:42:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:42:56 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:42:47 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 58/66] drm/amd/display: Atomize IRQ register read/modify/write ops
Date: Tue, 8 Sep 2026 19:31:51 +0800
Message-ID: <20260908113338.2433445-59-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7ab62d-974c-4395-a810-08df0d9e5382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|6133799003|3023799007|11063799006|56012099006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	V+8g0kEStcGwCpOwKggHjTtw4lmp3/hezENdhRgrs3lxff0Fm9VVmInJZpfbGULEzhrB0v3RfZSfVbD/8OApKaXX6RdQO2J+Z1IXv6cbaxOCVEgb2lfR6ggQDQXwdoKmvcxVZDy30kEYzWvxDietNOYjMYw+2bYqlsfW8M9ziFeeNKaLE2hDHsM7xAtk1oeL0m/7XP0GdTKTt7ZR57pregATwVB78YuIstUMZYz87+tW/hp8cVvftNU8yJeoqyRtDv7rjc6E3CW3qBbmLu2DOz33Boa80rg7TW3jFZsOlGirfweoUMRHaxKqzPC/xESukJAwKZG7qCSjdMMDIjdP+qlLYzcgV+SUF+DE7sgyR52dAzc7mRKMZ4D3u8zqCmq+3kze/eJt4pET0pS2PaThSnMA2DO7PhIEsaDfNgkX+3+wf90A603ddBV/dCYTT5JQIk0/p6HgNcdohtz6eMQjNW1XerqGskoVQw7p4H9u2fyD47U+LJ+lRDYcxRDMvz/vDhxF90wdS1zY6XA6NF53SX+yRr3p/noWWw3cXzxrkvNiSABCHoWjHVkkkIDuJdC4p4PJS1r05/IUn1jAS5848ve5RaS8WxrJoP4saUn0M4tfFjQFb+C6bs0c3HuL34+13bEvaGu9jF6X6OHe+bnF4Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(6133799003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PKzR3XrRDzsoWifms/UsfxTsEFgxX+xhva/5Tm1wYkDPxFUL/0142e68jgfwtvAzymC2OSqyqMkIbxo6gnj0qpdBjnnKRajNPc9azJ+cs4IUTbUUzGD1Yw3Ol0gs1uhCXvd2U4pUcxOctJ+9OIkEvuE/Td+OI9bG6xXcLMgnIcmdvRpz5+XIAgp4/B3VyXgcTw7GkmeT9Zw8BiIAgWSGLmt3eFRZaph/WbM6BAWBp62n3KqAQdCioOr4Bs4ns+cE8jwWWnMOGXrIYDlVSzpmIHAxrEoAyIq3KziRA0RNru/4EG1miEILVPu/3jT3TkXk2M7y243pvMyOuUmvLmp3lTZJLsGd7qEN9UMafyYE50hoMuyus5jwKHEd1owbSy20jFo4yxJN8aNTecKZ/2FRDCMF4qmo3f9fqPQNQyJ57ulgCUaUnDJZtUJaSPmwfWOr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:42:56.6352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7ab62d-974c-4395-a810-08df0d9e5382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761

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

Cc: stable@vger.kernel.org
Fixes: 8382cd234981 ("drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 12 ++++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 64 +++++++++++--------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h | 28 ++++++++
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 16 +++--
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |  8 ++-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 34 +++++-----
 9 files changed, 117 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 607aa5ae9b67..ca795cda8084 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1472,7 +1472,7 @@ STATIC_IFN_KUNIT void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 		if (acrtc && state->stream_status[i].plane_count != 0 &&
 		    amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
 			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
-			rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
+			rc = amdgpu_dm_irq_set(adev, irq_source, enable) ? 0 : -EBUSY;
 			if (rc)
 				drm_warn(adev_to_drm(adev), "Failed to %s pflip interrupts\n",
 					 enable ? "enable" : "disable");
@@ -1496,7 +1496,7 @@ STATIC_IFN_KUNIT void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 			/* During gpu-reset we disable and then enable vblank irq, so
 			 * don't use amdgpu_irq_get/put() to avoid refcount change.
 			 */
-			if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
+			if (!amdgpu_dm_irq_set(adev, irq_source, enable))
 				drm_warn(adev_to_drm(adev), "Failed to %sable vblank interrupt\n", enable ? "en" : "dis");
 
 		} else if (acrtc && state->stream_status[i].plane_count != 0) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 7b8941b44895..4aebf0231fee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -555,6 +555,18 @@ struct amdgpu_display_manager {
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
index a7979b418c2b..fa6a481c8765 100644
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
@@ -91,7 +92,7 @@ int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 
 	irq_source = IRQ_TYPE_VUPDATE + acrtc->otg_inst;
 
-	rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
+	rc = amdgpu_dm_irq_set(adev, irq_source, enable) ? 0 : -EBUSY;
 
 	DRM_DEBUG_VBL("crtc %d - vupdate irq %sabling: r=%d\n",
 		      acrtc->crtc_id, enable ? "en" : "dis", rc);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 836c06772a68..d47811665e46 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1469,12 +1469,13 @@ EXPORT_IF_KUNIT(dm_helpers_free_gpu_mem);
 
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
index f997a50c1293..c3ed63843202 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -396,6 +396,7 @@ int amdgpu_dm_irq_init(struct amdgpu_device *adev)
 	DRM_DEBUG_KMS("DM_IRQ\n");
 
 	spin_lock_init(&adev->dm.irq_handler_list_table_lock);
+	spin_lock_init(&adev->dm.irq_reg_lock);
 
 	adev->dm.irq_wq = alloc_workqueue("amdgpu_dm_irq",
 		WQ_UNBOUND | WQ_HIGHPRI, 0);
@@ -530,7 +531,7 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 	 */
 	for (src = DC_IRQ_SOURCE_HPD1; src <= DC_IRQ_SOURCE_HPD6RX; src++) {
 		hnd_list_l = &adev->dm.irq_handler_list_low_tab[src];
-		dc_interrupt_set(adev->dm.dc, src, false);
+		amdgpu_dm_irq_set(adev, src, false);
 
 		DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 
@@ -568,7 +569,7 @@ void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
 		hnd_list_l = &adev->dm.irq_handler_list_low_tab[src];
 		hnd_list_h = &adev->dm.irq_handler_list_high_tab[src];
 		if (!list_empty(hnd_list_l) || !list_empty(hnd_list_h))
-			dc_interrupt_set(adev->dm.dc, src, true);
+			amdgpu_dm_irq_set(adev, src, true);
 	}
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
@@ -594,7 +595,7 @@ void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 		hnd_list_l = &adev->dm.irq_handler_list_low_tab[src];
 		hnd_list_h = &adev->dm.irq_handler_list_high_tab[src];
 		if (!list_empty(hnd_list_l) || !list_empty(hnd_list_h))
-			dc_interrupt_set(adev->dm.dc, src, true);
+			amdgpu_dm_irq_set(adev, src, true);
 	}
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
@@ -693,6 +694,23 @@ STATIC_IFN_KUNIT void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_irq_immediate_work);
 
+bool amdgpu_dm_irq_set(struct amdgpu_device *adev, enum dc_irq_source src,
+		       bool enable)
+{
+	guard(spinlock_irqsave)(&adev->dm.irq_reg_lock);
+
+	return dc_interrupt_set(adev->dm.dc, src, enable);
+}
+EXPORT_IF_KUNIT(amdgpu_dm_irq_set);
+
+void amdgpu_dm_irq_ack(struct amdgpu_device *adev, enum dc_irq_source src)
+{
+	guard(spinlock_irqsave)(&adev->dm.irq_reg_lock);
+
+	dc_interrupt_ack(adev->dm.dc, src);
+}
+EXPORT_IF_KUNIT(amdgpu_dm_irq_ack);
+
 /**
  * amdgpu_dm_irq_handler - Generic DM IRQ handler
  * @adev: amdgpu base driver device containing the DM device
@@ -718,7 +736,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 		return 0;
 	}
 
-	dc_interrupt_ack(adev->dm.dc, src);
+	amdgpu_dm_irq_ack(adev, src);
 
 	/* Call high irq work immediately */
 	amdgpu_dm_irq_immediate_work(adev, src);
@@ -758,7 +776,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 	enum dc_irq_source src = amdgpu_dm_hpd_to_dal_irq_source(type);
 	bool st = (state == AMDGPU_IRQ_STATE_ENABLE);
 
-	dc_interrupt_set(adev->dm.dc, src, st);
+	amdgpu_dm_irq_set(adev, src, st);
 	return 0;
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_hpd_irq_state);
@@ -793,7 +811,7 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
 	if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
 		dc_allow_idle_optimizations(dc, false);
 
-	dc_interrupt_set(adev->dm.dc, irq_source, st);
+	amdgpu_dm_irq_set(adev, irq_source, st);
 	return 0;
 }
 
@@ -850,7 +868,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *a
 	enum dc_irq_source irq_source = DC_IRQ_SOURCE_DMCUB_OUTBOX;
 	bool st = (state == AMDGPU_IRQ_STATE_ENABLE);
 
-	dc_interrupt_set(adev->dm.dc, irq_source, st);
+	amdgpu_dm_irq_set(adev, irq_source, st);
 	return 0;
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_dmub_outbox_irq_state);
@@ -878,7 +896,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *ad
 	enum dc_irq_source irq_source = DC_IRQ_SOURCE_DMCUB_OUTBOX0;
 	bool st = (state == AMDGPU_IRQ_STATE_ENABLE);
 
-	dc_interrupt_set(adev->dm.dc, irq_source, st);
+	amdgpu_dm_irq_set(adev, irq_source, st);
 	return 0;
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_dmub_trace_irq_state);
@@ -945,9 +963,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_set_irq_funcs);
 
 void amdgpu_dm_outbox_init(struct amdgpu_device *adev)
 {
-	dc_interrupt_set(adev->dm.dc,
-		DC_IRQ_SOURCE_DMCUB_OUTBOX,
-		true);
+	amdgpu_dm_irq_set(adev, DC_IRQ_SOURCE_DMCUB_OUTBOX, true);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_outbox_init);
 
@@ -970,7 +986,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 
 	/* First, clear all hpd and hpdrx interrupts */
 	for (i = DC_IRQ_SOURCE_HPD1; i <= DC_IRQ_SOURCE_HPD6RX; i++) {
-		if (!dc_interrupt_set(adev->dm.dc, i, false))
+		if (!amdgpu_dm_irq_set(adev, i, false))
 			drm_err(dev, "Failed to clear hpd(rx) source=%d on init\n",
 				i);
 	}
@@ -999,7 +1015,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 		 * of dm. Note that only hpd interrupt types are registered with
 		 * base driver; hpd_rx types aren't. IOW, amdgpu_irq_get/put on
 		 * hpd_rx isn't available. DM currently controls hpd_rx
-		 * explicitly with dc_interrupt_set()
+		 * explicitly with amdgpu_dm_irq_set()
 		 */
 		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
 			irq_type = dc_link->irq_source_hpd - DC_IRQ_SOURCE_HPD1;
@@ -1008,23 +1024,21 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
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
@@ -1069,16 +1083,14 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
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
index 4c200a9614a7..bc16ecc67329 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -89,6 +89,34 @@ void amdgpu_dm_irq_unregister_interrupt(struct amdgpu_device *adev,
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
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 544445fbc770..f9457fc9e31b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -439,7 +439,7 @@ static void dm_test_crtc_set_vupdate_irq_no_otg(struct kunit *test)
  * dm_test_crtc_set_vupdate_irq_dc_busy - Test vupdate irq when DC rejects request
  * @test: The KUnit test context
  *
- * With an OTG instance assigned but no DC attached, dc_interrupt_set() returns
+ * With an OTG instance assigned but no DC attached, amdgpu_dm_irq_set() returns
  * false and the function must report the request as busy (-EBUSY).
  */
 static void dm_test_crtc_set_vupdate_irq_dc_busy(struct kunit *test)
@@ -456,12 +456,12 @@ static void dm_test_crtc_set_vupdate_irq_dc_busy(struct kunit *test)
 	acrtc->base.dev = &adev->ddev;
 	acrtc->otg_inst = 0;
 
-	/* adev->dm.dc is NULL, so dc_interrupt_set() returns false. */
+	/* adev->dm.dc is NULL, so amdgpu_dm_irq_set() returns false. */
 	KUNIT_EXPECT_EQ(test,
 			amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, true), -EBUSY);
 }
 
-/* Per-source funcs let dc_interrupt_set() succeed without register access. */
+/* Per-source funcs let amdgpu_dm_irq_set() succeed without register access. */
 static bool dm_test_vupdate_irq_src_set(struct irq_service *irq_service,
 					const struct irq_source_info *info,
 					bool enable)
@@ -480,7 +480,7 @@ static struct irq_source_info_funcs dm_test_vupdate_irq_src_funcs = {
 	.ack = dm_test_vupdate_irq_src_ack,
 };
 
-/* A .set that fails so dc_interrupt_set() reports the source as busy. */
+/* A .set that fails so amdgpu_dm_irq_set() reports the source as busy. */
 static bool dm_test_vupdate_irq_src_set_busy(struct irq_service *irq_service,
 					     const struct irq_source_info *info,
 					     bool enable)
@@ -522,7 +522,9 @@ static void dm_test_crtc_set_vupdate_irq_enable(struct kunit *test)
 	irqs = kunit_kzalloc(test, sizeof(*irqs), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, irqs);
 
-	/* Populate the per-source info table so dc_interrupt_set() succeeds. */
+	/*
+	 * Populate the per-source info table so amdgpu_dm_irq_set() succeeds.
+	 */
 	info = kunit_kzalloc(test, sizeof(*info) * DAL_IRQ_SOURCES_NUMBER,
 			     GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
@@ -1021,7 +1023,9 @@ static void dm_test_crtc_enable_vblank_vupdate_busy(struct kunit *test)
 	irqs = kunit_kzalloc(test, sizeof(*irqs), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, irqs);
 
-	/* Per-source .set fails so dc_interrupt_set() reports the source busy. */
+	/*
+	 * Per-source .set fails so amdgpu_dm_irq_set() reports the source busy.
+	 */
 	info = kunit_kzalloc(test, sizeof(*info) * DAL_IRQ_SOURCES_NUMBER,
 			     GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index ceedb8745267..b18486fa5645 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -2592,17 +2592,21 @@ static void dm_test_is_dp_sink_present_null_priv(struct kunit *test)
  * dm_test_dmub_outbox_interrupt_control_null_dc - Test outbox irq control with NULL dc
  * @test: The KUnit test context
  *
- * dc_interrupt_set() is NULL-safe and returns false when dc is NULL, so the
+ * amdgpu_dm_irq_set() is NULL-safe and returns false when dc is NULL, so the
  * helper returns false without touching real interrupt hardware.
  */
 static void dm_test_dmub_outbox_interrupt_control_null_dc(struct kunit *test)
 {
+	struct amdgpu_device *adev;
 	struct dc_context *ctx;
 
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	ctx->driver_context = adev;
 
-	/* ctx->dc is NULL → dc_interrupt_set returns false */
+	/* adev->dm.dc is NULL → amdgpu_dm_irq_set returns false */
 	KUNIT_EXPECT_FALSE(test, dm_helpers_dmub_outbox_interrupt_control(ctx, true));
 	KUNIT_EXPECT_FALSE(test, dm_helpers_dmub_outbox_interrupt_control(ctx, false));
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index d7d2dd49b1f0..c1b5c442ad0d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -360,7 +360,7 @@ static bool dm_test_irq_src_ack(struct irq_service *irq_service,
 	return true;
 }
 
-/* Per-source funcs let dc_interrupt_set() succeed without register access. */
+/* Per-source funcs let amdgpu_dm_irq_set() succeed without register access. */
 static struct irq_source_info_funcs dm_test_irq_src_funcs = {
 	.set = dm_test_irq_src_set,
 	.ack = dm_test_irq_src_ack,
@@ -382,7 +382,7 @@ static struct dc *dm_test_alloc_dc_with_irq_service(struct kunit *test,
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, irqs);
 
 	/*
-	 * Populate the per-source info table so dc_interrupt_set()/_ack()
+	 * Populate the per-source info table so amdgpu_dm_irq_set()/_ack()
 	 * succeed without touching hardware registers.
 	 */
 	info = kunit_kzalloc(test, sizeof(*info) * DAL_IRQ_SOURCES_NUMBER,
@@ -1351,7 +1351,7 @@ static void dm_test_irq_suspend_empty(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	/*
-	 * With no registered handlers the HW dc_interrupt_set() calls are
+	 * With no registered handlers the amdgpu_dm_irq_set() calls are
 	 * skipped, so suspend must complete without touching the (absent) DC.
 	 */
 	amdgpu_dm_irq_suspend(adev);
@@ -1399,11 +1399,11 @@ static void dm_test_irq_resume_late_empty(struct kunit *test)
 }
 
 /**
- * dm_test_irq_suspend_registered - Test suspend reaches the dc_interrupt_set path
+ * dm_test_irq_suspend_registered - Test suspend reaches the irq set path
  * @test: The KUnit test context
  *
  * Registers a low-context HPD handler so the handler list is non-empty,
- * forcing amdgpu_dm_irq_suspend() to call dc_interrupt_set() (NULL-safe with
+ * forcing amdgpu_dm_irq_suspend() to call amdgpu_dm_irq_set() (NULL-safe with
  * no DC) and flush_work() on the registered handler.
  */
 static void dm_test_irq_suspend_registered(struct kunit *test)
@@ -1454,11 +1454,11 @@ static void dm_test_irq_suspend_disables_polling(struct kunit *test)
 }
 
 /**
- * dm_test_irq_resume_early_registered - Test early resume reaches dc_interrupt_set
+ * dm_test_irq_resume_early_registered - Test early resume reaches irq set
  * @test: The KUnit test context
  *
  * Registers a low-context HPD RX handler so early resume calls
- * dc_interrupt_set() for the short-pulse interrupt source.
+ * amdgpu_dm_irq_set() for the short-pulse interrupt source.
  */
 static void dm_test_irq_resume_early_registered(struct kunit *test)
 {
@@ -1482,10 +1482,10 @@ static void dm_test_irq_resume_early_registered(struct kunit *test)
 }
 
 /**
- * dm_test_irq_resume_late_registered - Test late resume reaches dc_interrupt_set
+ * dm_test_irq_resume_late_registered - Test late resume reaches irq set
  * @test: The KUnit test context
  *
- * Registers a low-context HPD handler so late resume calls dc_interrupt_set()
+ * Registers a low-context HPD handler so late resume calls amdgpu_dm_irq_set()
  * for the HPD interrupt source.
  */
 static void dm_test_irq_resume_late_registered(struct kunit *test)
@@ -1716,7 +1716,7 @@ static void dm_test_set_crtc_irq_state_enable(struct kunit *test)
 
 	/*
 	 * otg_inst >= 0 computes the irq source and reaches the NULL-safe
-	 * dc_interrupt_set(); the ips_support branch is skipped (dc == NULL).
+	 * amdgpu_dm_irq_set(); the ips_support branch is skipped (dc == NULL).
 	 */
 	acrtc->otg_inst = 3;
 	adev->mode_info.crtcs[0] = acrtc;
@@ -1795,8 +1795,8 @@ static void dm_test_set_vupdate_irq_state_enable(struct kunit *test)
  *
  * With a non-NULL DC that advertises IPS support and currently allows idle
  * optimizations, dm_irq_state() must call dc_allow_idle_optimizations() before
- * dc_interrupt_set(). disable_idle_power_optimizations makes that call a safe
- * early return, and per-source stub funcs let dc_interrupt_set() succeed.
+ * amdgpu_dm_irq_set(). disable_idle_power_optimizations makes that call a safe
+ * early return, and per-source stub funcs let amdgpu_dm_irq_set() succeed.
  */
 static void dm_test_set_crtc_irq_state_allows_idle(struct kunit *test)
 {
@@ -2048,7 +2048,7 @@ static void dm_test_set_hpd_irq_state_null_dc(struct kunit *test)
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 
-	/* dc_interrupt_set() is a no-op when dc is NULL, so both states
+	/* amdgpu_dm_irq_set() is a no-op when dc is NULL, so both states
 	 * return 0 without dereferencing the (absent) DC.
 	 */
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_set_hpd_irq_state(adev, NULL, AMDGPU_HPD_1,
@@ -2108,7 +2108,7 @@ static void dm_test_outbox_init_null_dc(struct kunit *test)
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 
-	/* Single dc_interrupt_set() call must be skipped when dc is NULL. */
+	/* Single amdgpu_dm_irq_set() call must be skipped when dc is NULL. */
 	amdgpu_dm_outbox_init(adev);
 }
 
@@ -2126,7 +2126,7 @@ static void dm_test_hpd_init_empty_connectors(struct kunit *test)
 
 	/*
 	 * With an empty connector list the per-connector loop is skipped and
-	 * the initial clear loop relies on dc_interrupt_set() being a no-op
+	 * the initial clear loop relies on amdgpu_dm_irq_set() being a no-op
 	 * for a NULL dc, so init must complete without touching the DC.
 	 */
 	amdgpu_dm_hpd_init(adev);
@@ -2161,7 +2161,7 @@ static void dm_test_hpd_init_fini_with_connectors(struct kunit *test)
 
 	/*
 	 * num_hpd = 0 forces irq_type >= num_hpd so the loop takes the HW
-	 * fallback (dc_interrupt_set()) instead of amdgpu_irq_get(); with a
+	 * fallback (amdgpu_dm_irq_set()) instead of amdgpu_irq_get(); with a
 	 * NULL dc that fallback is a safe no-op.
 	 */
 	adev->mode_info.num_hpd = 0;
@@ -2247,7 +2247,7 @@ static void dm_test_hpd_init_fini_irq_ref(struct kunit *test)
 	/*
 	 * num_hpd >= 1 makes irq_type (0) < num_hpd, so the loop takes the
 	 * amdgpu_irq_get()/amdgpu_irq_put() branch instead of the
-	 * dc_interrupt_set() fallback. The mock device has irq.installed ==
+	 * amdgpu_dm_irq_set() fallback. The mock device has irq.installed ==
 	 * false, so both calls fail early with -ENOENT (logging an error)
 	 * without touching the base-driver irq state.
 	 */
-- 
2.43.0

