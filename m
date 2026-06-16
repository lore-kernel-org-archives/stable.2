Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F2389110
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 20:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781641143; cv=fail; b=EF+0vtJUtSxM14scmYF9wL5/VOuMpVS0lmAGhCJSLC7uq/N/wJ1/EiavGFgGp2CGFVmtta4cjlQouq4qq9NHjbM51XSBgscs0nsPoJpXm5fHuCQ5NNKGhVoP7qDV4+rNHsVp6+Sh/EdO2LEqLx4Jpk+fxGd569Nfk7HUygeSJSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781641143; c=relaxed/simple;
	bh=6aep8WkGroXE92Vuu4Nqb7eMlZqYh07xX8h4QYSFdL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSkCeb321uvTSZtUgGROuyi/7t9GTGRuQgE0MwazSCk65ofaVGbON42aQX4bRfBZAP6K7I9rPTF0BIDTOKCtCQAvKVJGdBX1YOjJWzDso0iFiBImoup5+xOBO1Zv3tQy9PleCVyhYQMAarylDN8qtiQ4iaYg8IX6ZE2WSADUV2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B6EsrERv; arc=fail smtp.client-ip=52.101.57.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B6EsrERv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfwelDGMMMHv5/zPgEbvyZWLChgK9HumQyrF1bZKOkJYHaCaF6+6h0U0J/fAmmQ7z1WoYIFok/cEgi4NxG+bqB9bybBCr9rJgOxWTkWj//EbS0DB5H4oK2bp/x+C/IxJddh5wlqJ5tvd4rzLyYb9a1xw/Z3hFO1/sIpfVR2XGENsncTe8gMePBFdop26M91W2hWj302XWEOsMeU2ShF87YziR+jAQUXjsMMvTwlAC7ZZUPwjUqDTC5v9KgaNfRUTtp1l8kihf3AJShb+VRdDVZknpMIPnBsI7RcmT7zUsxdXkMFy81c68SPsWgHk/h7A5LWketAEn9c2w6NUrVkYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDt30zIMB9tKU7nDZnGCcdBJJL4ZX7LnNecq8KtUd8s=;
 b=frDJMbJB+on3qJpMVWu0Dgax7T5Jzh6r2RcK7N0ZXUcoqdYJKQX4270ZaIvjK8AkHCeJHvQpxOA8gCXDErVoJlBmLNyu9KgVzSllhLwAR4bu+DCeBVBOMk4XJEt4HBehR2dKvfuj1yZbAsEb0RlMOMj5z/Pf5Y0XmKQ+iRQUADKgAY5c2SIdTFNzChuG5tgXekC1geNjKNCBKcCd4S7p74OSu0T+AIqxe/kgyJmAXQEONVP4AJLxIVvTYKHwvI788sU7Lsm8QaNy9RBkoBL+HhSPm7YsV6Y9iKrahVwHSopp0N5If+uX/AcSf88cj31DJvRBUwvOF4XBmFrSXuLFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDt30zIMB9tKU7nDZnGCcdBJJL4ZX7LnNecq8KtUd8s=;
 b=B6EsrERvMVf/FwZDyxkeeE/iPMysrP9VHLUKbDAxBR5xusuRGjE4Sfv9CUVwtUGOwhHNqdUuKpi8rVYAd6hYIwz8FoHkFEXPG3+5SWRDwHET0koUgsnM19+0MaKPSuBdQ6CcHI8bJ6wib1fJts4wvoSJDbwK1TtEsIUwveVEfxw=
Received: from SN7P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::22)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 20:18:55 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::42) by SN7P220CA0017.outlook.office365.com
 (2603:10b6:806:123::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 20:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 20:18:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 15:18:54 -0500
Received: from flamewok (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport; Tue, 16
 Jun 2026 15:18:53 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
	<wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
	<xaver.hugl@kde.org>, <mario.kleiner.de@gmail.com>, Leo Li
	<sunpeng.li@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/3] drm/amd/display: check GRPH_FLIP status before sending event
Date: Tue, 16 Jun 2026 16:18:27 -0400
Message-ID: <20260616201828.389985-3-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616201828.389985-1-sunpeng.li@amd.com>
References: <20260616201828.389985-1-sunpeng.li@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 4910e0d4-228f-44bc-811c-08decbe47d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|32650700020|23010399003|36860700016|13003099007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	rchD6SRqBRn6ooa/bMyphRJ/OzBjX6hUxHdCS3MiQgEJJcfCK3o0G39mbz/7or7H0wKozI5JiXw0l1aB6cMGV3x3/3VN21ptk08rBgyNmS3qzIzKoG0yzxXfyFmIF2PYwAHrzZ+Lkp8JbHkK9VjT6oSG9/OMaujIcrePqNmud5uqKHtAA5mLG96RtMn1kEbGBB5bfPMOSa+/U4vojbTUuvyhpwWL7967+NvaZ8ZjYmKckTPAuj6QiqrfIZbrQo7c7USw4gEIovu0eqGqGjphID8gJZHq4D6i89/WNlExtvG8xaaqjTs+4c5uVyzgtHHu7jVPSadLoU2uTgQChqB8l03ZWQnW+3RIgaLkJGFCfNNfAf4ujSQ/qwLpB1YFRsGIeLbUir8nWzEk+kH2U+2MgtNcMFHTH88FMV0VC3ccpmRX8F0PnQ2s4ZFhuJlo6e5nzcz22LhBofdE5yym/aeltUhG4WtC4GFQ6cfzHsOH5IPwt6lmKLb0fWTLyCCik0li3h9hZTSfllSXQDe/IzV8ygj7Ne5+g8fe3dRN9O6NUkUCoIenL02267CgxyIOuh8qX9j/quRAAGDGE79DJgeLFyXLS4R+ck9aRj4LkFGEHdLrxNGTg8e8MMvwbAtpxWj8EXEBkO3j6kf3B3wPbiHpkiBj6v8CtyKsRASA83gMbeU7uZWchWbh5hHsxxSOJZWx033/JNriQJGldWRQ9+fOreVZThEdrH0jHyGWxAkkFmw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(32650700020)(23010399003)(36860700016)(13003099007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5pzbqdtG143RGdAJRwDJVf39zSeMG00GZBOgO+ML2S8IzEmiqJfIKgBzSoqeY9dMCeJtqJasQ7ijwhxBD67f3q7QmeVPgy2ybHyPEn3wQJwo8kkYujbE8ukmP4kzEO1TPijd4ZNkl/zfV5b0eQ7jIcL0rflITveK45i33yumUIeNcRbY/yRdJwO5Go0JJqkfhuJKjjFaQQ4p2yDenzAdTbkj9Y59rVsHNub8PNZkrk9KX11+P6YrG9fOEdKGUZoApajr/Ky4g2HIkWPhzwBLP/bBWtbRbeJ+cBTZpexDwJphJDPoSt09fINe88GdkAXWIFXNFGZ9QDTA3ogkaoBjHVZDhp1q7ztKQCYOMkrzFQ1zOSwH8fa5CKAscYJS0j6ARP4BaB3ApSiMhn44V+QzLrpdMmIgLtuoQR/EcgboCRx5V9/Rjk0vgtwWqez8Ap4e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 20:18:55.1417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4910e0d4-228f-44bc-811c-08decbe47d85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420

From: Leo Li <sunpeng.li@amd.com>

[Why]

After unifying DCN interrupt sources under VUPDATE_NO_LOCK, we have two
remaining issues to clean up:

1. On DCN, flip completion is now delivered from VUPDATE_NO_LOCK
   (dm_crtc_high_irq_handler) instead of GRPH_PFLIP. But VUPDATE_NO_LOCK
   fires every frame, regardless of whether a flip has latched.

2. There is a window during commit where a flip is armed (pflip_status =
   SUBMITTED) but not yet programmed into HW. If the VUPDATE_NO_LOCK
   fires in that window, it's handler would deliver a flip event to
   userspace before HW has latched to it. If userspace then renders to
   what it believes is now the back buffer (but HW is still latched to
   it!), it will cause display corruption. (This issue seemed to have
   existed ever since the introduction of pflip_status. Enabling replay
   or psr extended the duration of this window, and hence made
   corruption more likely to be observed.)

[How]

* Add a flip_programmed completion. Arm it (reinit_completion) under
  event_lock together with prepare_flip_isr(), and signal it
  (complete_all) right after update_planes_and_stream_adapter() programs
  the flip. It starts in the "completed" state at crtc init.

* Add dc_get_flip_pending_on_otg(), which reads the HUBP flip-pending
  status straight from HW for the pipe(s) bound to an OTG instance. It
  is keyed only by otg_inst and does not take or mutate a
  dc_plane_state, so it is safe to call from the OTG interrupt handler
  without racing a concurrent commit that may be modifying plane state.

* In the DCN OTG handler, only deliver flip completion once
  flip_programmed is signalled (try_wait_for_completion) and
  dc_get_flip_pending_on_otg() reports the flip is no longer pending.
  Otherwise leave the flip armed and retry on the next vupdate.

Cc: stable@vger.kernel.org
Fixes: 9b47278cec98 ("drm/amd/display: temp w/a for dGPU to enter idle optimizations")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/3787
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/4141
Assisted-by: Copilot:claude-opus-4.8
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  5 +++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 34 +++++++++++---
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |  8 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 45 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 6 files changed, 92 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 00f7a3b445ebf..571198c46c0c2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4384,17 +4384,17 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		 * from 0 -> n planes we have to skip a hardware generated event
 		 * and rely on sending it from software.
 		 */
+		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
 		if (acrtc_attach->base.state->event &&
 		    acrtc_state->active_planes > 0) {
 			drm_crtc_vblank_get(pcrtc);
 
-			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
-
 			WARN_ON(acrtc_attach->pflip_status != AMDGPU_FLIP_NONE);
+			/* Arm flip completion handling and event delivery */
+			reinit_completion(&acrtc_attach->dm_irq_params.flip_programmed);
 			prepare_flip_isr(acrtc_attach);
-
-			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 		}
+		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 
 		if (acrtc_state->stream) {
 			if (acrtc_state->freesync_vrr_info_changed)
@@ -4468,6 +4468,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 					 &bundle->stream_update,
 					 bundle->surface_updates);
 		updated_planes_and_streams = true;
+		complete_all(&acrtc_attach->dm_irq_params.flip_programmed);
 
 		/**
 		 * Enable or disable the interrupts on the backend.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 8a6b732cf80c8..f8f4f8f350dbd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -789,6 +789,11 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 #ifdef AMD_PRIVATE_COLOR
 	dm_crtc_additional_color_mgmt(&acrtc->base);
 #endif
+
+	init_completion(&acrtc->dm_irq_params.flip_programmed);
+	/* No flip is in flight yet; start in the "programmed" state. */
+	complete_all(&acrtc->dm_irq_params.flip_programmed);
+
 	return 0;
 
 fail:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 7c6db2bfc553a..b4377444bf0bd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1990,14 +1990,36 @@ static void dm_crtc_high_irq_handler(struct amdgpu_device *adev,
 	/*
 	 * Deliver pageflip completion events (DCN only).
 	 *
-	 * Since GRPH_PFLIP is not used, VUPDATE_NO_LOCK is the flip latch
-	 * point. Deliver any pending pageflip completion event from here.
+	 * On DCN, GRPH_PFLIP is not used; VUPDATE_NO_LOCK is the flip latch
+	 * point, so deliver any pending pageflip completion event from here.
+	 * But only once the armed flip has actually been programmed into HW
+	 * (flip_programmed) and HW has consumed the new address (the OTG no
+	 * longer reports a pending flip). This avoids reporting completion for
+	 * a flip whose address has not yet been latched, which would let
+	 * userspace render over the still-presented buffer and cause
+	 * corruption.
 	 *
-	 * NOTE: This can deliver an event for a flip that was armed but not yet
-	 * programmed into HW; that race is closed in a follow-up change by
-	 * checking the programmed flip status.
+	 * Also handle the case here where there aren't any active planes and
+	 * DCN HUBP may be clock-gated, so the flip-pending status may be
+	 * undefined.
 	 */
-	if (is_dcn && acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED) {
+	if (is_dcn && acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
+	    acrtc->event &&
+	    try_wait_for_completion(&acrtc->dm_irq_params.flip_programmed)) {
+
+		if (!dc_get_flip_pending_on_otg(adev->dm.dc, acrtc->otg_inst)) {
+			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
+			acrtc->event = NULL;
+			drm_crtc_vblank_put(&acrtc->base);
+			acrtc->pflip_status = AMDGPU_FLIP_NONE;
+		}
+		/*
+		 * If the flip is still pending, leave it armed and
+		 * retry on the next vupdate.
+		 */
+	} else if (is_dcn && acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
+		   acrtc->dm_irq_params.active_planes == 0) {
+
 		if (acrtc->event) {
 			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
 			acrtc->event = NULL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
index f0c1b0c1faa9f..52c3c45cfe680 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
@@ -27,12 +27,20 @@
 #ifndef __AMDGPU_DM_IRQ_PARAMS_H__
 #define __AMDGPU_DM_IRQ_PARAMS_H__
 
+#include <linux/completion.h>
+
 #include "amdgpu_dm_crc.h"
 
 struct dm_irq_params {
 	u32 last_flip_vblank;
 	struct mod_vrr_params vrr_params;
 	struct dc_stream_state *stream;
+
+	/*
+	 * Completed once an armed flip has actually been programmed into HW.
+	 */
+	struct completion flip_programmed;
+
 	int active_planes;
 	bool allow_sr_entry;
 	struct mod_freesync_config freesync_config;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 379d3c97a5211..c7b48d321c108 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6219,6 +6219,51 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
 	dal_irq_service_ack(dc->res_pool->irqs, src);
 }
 
+/*
+ * dc_get_flip_pending_on_otg() - Check if a GRPH_FLIP is still pending on OTG
+ *
+ * @dc: display core context @otg_inst: OTG instance to query
+ *
+ * Reads the HUBP flip-pending status for the pipe(s) bound to @otg_inst,
+ * returning true if any of them has not yet latched its programmed surface
+ * address.
+ *
+ * Unlike dc_plane_get_status(), this does not take or mutate a dc_plane_state,
+ * so it is safe to call from interrupt context without racing a concurrent
+ * commit that may be updating plane state.
+ *
+ * Return: true if a flip is still pending on the OTG, false otherwise.
+ */
+bool dc_get_flip_pending_on_otg(struct dc *dc, int otg_inst)
+{
+	bool flip_pending = false;
+	int i;
+
+	if (!dc || !dc->current_state)
+		return false;
+
+	dc_exit_ips_for_hw_access(dc);
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct hubp *hubp = pipe_ctx->plane_res.hubp;
+
+		if (!pipe_ctx->plane_state || !pipe_ctx->stream_res.tg)
+			continue;
+
+		if (pipe_ctx->stream_res.tg->inst != otg_inst)
+			continue;
+
+		if (hubp && hubp->funcs->hubp_is_flip_pending &&
+		    hubp->funcs->hubp_is_flip_pending(hubp)) {
+			flip_pending = true;
+			break;
+		}
+	}
+
+	return flip_pending;
+}
+
 void dc_power_down_on_boot(struct dc *dc)
 {
 	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2de0f9cf8264f..f143b250cbf7d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2990,6 +2990,7 @@ enum dc_irq_source dc_interrupt_to_irq_source(
 		uint32_t ext_id);
 bool dc_interrupt_set(struct dc *dc, enum dc_irq_source src, bool enable);
 void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src);
+bool dc_get_flip_pending_on_otg(struct dc *dc, int otg_inst);
 enum dc_irq_source dc_get_hpd_irq_source_at_index(
 		struct dc *dc, uint32_t link_index);
 
-- 
2.54.0

