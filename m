Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412D38839F
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781641138; cv=fail; b=kVDP3/258ehM/A+CmuQV+5c/SohIfdzG1eN/p5ZL+k3U9NbcPMJDmAPSjHMM4CEIs3Eo+YsBxb0mHuHxbph2R4ezq9xh9I25BfrBbeqnHLQc/NEmCZP9Gc9ThM6CuwspA+CkYmCVVuUGigxYTfGt5PFE7lOQAF33vJmVJhfed7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781641138; c=relaxed/simple;
	bh=eviq9f8XGDkrRgw34ujOAt6roYOCdXt79jNYvAIxI9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8SVYPl7JcaqcG/eR/3pKxI9Hli52TizUcLZlzOLBSy3+EWzoOXRzi7459gM2BmdBdT772cxErFmU7/ygpDdCMkOBXta3I/iCPF8TZN0CkEdVBF8olD7ABPMs+O8pyAQ67+2HpQeywmNCi34TnvpPHuREC4MaoZP67BXmT39e6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WxpBaZnH; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WxpBaZnH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnbXmwyG2R0NRS0T2KS6e2+qq/586l3hUznQpWkv7dOL7D2IYw3S2l693v7aZZG1JjelULVqCba7oZpweCI1OuNrMJEGg+3Cw6JrU8c987+jGwQkdplTCLpuea26ygfJCkEeS4n4eNHKEvdcllX2zaZMUkSnr3IsSO9s9r7zGvIMUkff/zBruYsL2Ky9mGW0oc5w+8CvF1BVReDxklL23gKLjmVBJJa2EMDurC8w+Z+DV9LQrxDihB1bAJsxspkhlQF6cHoZYow5Z5Hzo+aThdANLzu2MZ5etOvpI/gm7dVb0OCaGPilFvjIvJXEiMcNoXJRtjh5VB7IrZyN9CxdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhJ66J8aHWVVX3hl3+NloLLRaQy3vSoT+nsDG5f1pwc=;
 b=dff/tDcJ+XNtGf+323Mstg4QEz77y1s0tGcCyVAWpdY36dvVWbQxHz2ZUzXo1p89G/nIX+ONhN/IJ9uAiEPTpAAem6uTpEtF5pXutdej0EQx7j/T8XPe4tn4LvLxEF66MAxPYqWG+0I7RErsqwJgACdacpYjUCvUhfytmWFYEJdqhed2ydN7+B3uLBqQrqhWb19kSU3d6VFEFU+m5PxbgS6dpSnn34tSky3bhvAHX6PfS6M6mspPD1URrqlSeXAtN+cAbtEFvZaQJgYVF/AJPjfZbZgjtjhp/Xb61VFGtJnlO16CjiFYk/TmYdRYHQ7DrA2+O7Oc2CXVn7MOXd6VOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhJ66J8aHWVVX3hl3+NloLLRaQy3vSoT+nsDG5f1pwc=;
 b=WxpBaZnHVK5AdgWXKmSITSgPSk5jkhfQxppgjeTDF2cnly5ORd+X7RciH4U2idDwDXl0L2almptQt8Izvm+LUGSQUTjJQqfKA9dQAwciyIvDXLFK8BuX0abGVJptvQlqCJaRPFYaXbd2iGDjA8w9hd3064sywpOP2V1o7Z9HLtE=
Received: from SN7P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::12)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 20:18:51 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::40) by SN7P220CA0007.outlook.office365.com
 (2603:10b6:806:123::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 20:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 20:18:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 15:18:50 -0500
Received: from flamewok (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport; Tue, 16
 Jun 2026 15:18:49 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
	<wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
	<xaver.hugl@kde.org>, <mario.kleiner.de@gmail.com>, Leo Li
	<sunpeng.li@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/3] drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock
Date: Tue, 16 Jun 2026 16:18:26 -0400
Message-ID: <20260616201828.389985-2-sunpeng.li@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 682a3749-9863-4891-1759-08decbe47b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|32650700020|82310400026|23010399003|3023799007|22082099003|18002099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	dubl8jW9yu4hZKc/J/N+PmCSGJ0fAESRoU+6M80BoH0LezB8cL7w7g9kz3Njsw00Y3JcPBzwVl5FzCC6hJ4/NwjddLuI8F4vSh3Sh4Ka1+chUEqMxq3s719bh6IZBnpY/Mgh1gXugr5KOqqS8kWcdNbwz3C1MbVt2Xq9Faz0k1DuUXgwTWmdE6516FLsz+DRdFFyGBWDmYrNqFZWcF4pgNBYCpTjLm5fmqdz0/92ZCSRc58Glo/GN4fiddQNlUUJQgMeU5EULwshqw7fC3gQicCd1SJX0YhUWYDmy+xRHM4Px6cgfhT1FFQe4wIv0KygOUAJJhGz5U5WOX8hE5VVoP8/kzma1SiVibkS/jmBOpYTLsCTxin/0LiYFreE8vBxr5KoSNpCdDfLkSBYn6GHNpmGJxBzv6dVzB78voYjQ17XWM1toy7foEsKPshoeLTk8pFO6G52O+ssjuPM6hZQqMoLk+Iz1LVGqHxnBJqlXsvKxdl0G7M2RX17PTjRERYrEofPy0G6A90R7bHseoVc7rnb/yKb6APOFgNi/7W2ZL9jZ1bwJMhKK4aisAXcvke0CuadNT0bhQ65zBYduWFt1Y4e35w7QGDjOKOZdMvtflzrKe+0erHiI7TOV+rAvK8agdzFdjCTh+xs7AOL3NEWctFvcb6/QEeNSQxsRCV4HQ3dVQq1KoI2BeCtE2eCh2w4D7Xnp1f5zYKV5a1KA8Riow/JY+682m3qLp/4oer3aOM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(32650700020)(82310400026)(23010399003)(3023799007)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/Cl4WG0bcMXNto9lue95kiI/ilsM8FKmoNzbxpwUlM+LDjfJxc/Y1X43ZsQl3EPB4moWfxULPSsqxdGw2nRWXkUinfSKTlOmFXh9QXEQBV2ZiUHt84bD8opYavMMSPU0iOPSSKcTlcLyvmkXLwYLiFwHjsPWt+VdjqYzxXuBiKW2PYcGb+p7D/AoU8hRlkEDYLMGSILbvHQsz7ZmkLFXMRVepgLVaBEGvyihjTtsuJLBMwT09J8GUZMpqa6SfmpQrbKXYGmhGjKE0YoNQVQkY0CzG7m0hQZln1D/8ZieJM77ZHuaHzcUh0JIk/Vh/kOt1MVT4inzIgg0lcZgjxeDkWYSCSh33pC1SOIMBwlZ2rNYDdDGEE/c73porlLC0kcXV59bI+o1jLzTr4n+KI2pcTdDPuT1KEzbrlcVmBD0U9/9uOzFz7kTnNRtbj+Kjfsk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 20:18:50.9225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682a3749-9863-4891-1759-08decbe47b01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259

From: Leo Li <sunpeng.li@amd.com>

[Why]

On DCN, vblank events were delivered from VSTARTUP/VUPDATE
(dm_crtc_high_irq/dm_vupdate_high_irq) and pageflip completion from
GRPH_PFLIP (dm_pflip_high_irq). These signals can be masked by hardware
by a few things:

* DPG - DCN can Dynamically Power Gate parts of the display pipe when a
  self-refresh capable eDP is connected. DPG is engaged when there's
  enough static frames (detected thru drm_vblank_off) Once gated, even
  though the OTG (output timing generator) is still enabled, VSTARTUP
  and GRPH_FLIP are masked.

* GSL - Driver can use the Global Sync Lock to block HW from latching
  onto double-buffered registers during programming, to prevent HW from
  latching onto a partially programmed state. This will mask VSTARTUP,
  GRPH_FLIP, and VUPDATE. See dcn20_pipe_control_lock().

* MALL - A DCN accessible cache introduced in DCN32+ DGPUs that can
  store fb data to allow for longer DRAM sleep. When scanning out from
  MALL, STARTUP is masked.

When masked, events are never delivered, which can show up as flip_done
timeouts in the wild.

However, there is an interrupt source on DCN that is never masked:
VUPDATE_NO_LOCK. It's simply an unmasked variant of VUPDATE, which fires
while the OTG is active, at the exact point hardware latches
double-buffered registers. It is therefore the natural single signal for
delivering both vblank and flip-completion events on DCN, and the
correct point to timestamp both VRR and non-VRR vblanks.

DCE's interrupt sources are different, it does not have an unmaskable
VUPDATE_NO_LOCK. The only unmaskable DCE interrupt is VLINE0, but it can
only be programmed as a vline offset from vsync_start, making it
unsuitable for VRR. Thus, we keep DCE untouched and use the existing mix
of interrupt sources.

[How]

For DCN1 and newer only:

* Factor the body of dm_crtc_high_irq() into dm_crtc_high_irq_handler()
  and drive it from dm_vupdate_high_irq() (VUPDATE_NO_LOCK). DCE keeps
  using dm_crtc_high_irq() (VSTARTUP) and dm_pflip_high_irq()
  (GRPH_PFLIP) unchanged.

* Stop registering VSTARTUP (crtc_irq) and GRPH_PFLIP (pageflip_irq) on
  DCN, and stop enabling them in amdgpu_dm_crtc_set_vblank() /
  manage_dm_interrupts(). Enable VUPDATE whenever vblank is enabled on
  DCN (previously only in VRR mode). The secure-display vline0 interrupt
  is left untouched.

* VUPDATE_NO_LOCK does not early-fire on an immediate (tearing / async)
  flip, since HW latches the new address right away. Deliver the flip
  completion event immediately after programming such flips in
  amdgpu_dm_commit_planes(), and clear pflip_status so the next vupdate
  handler does not double-send.

Cc: stable@vger.kernel.org
Fixes: 9b47278cec98 ("drm/amd/display: temp w/a for dGPU to enter idle optimizations")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/3787
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/4141
Assisted-by: Copilot:claude-opus-4.8
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  48 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  70 +++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 282 ++++++++----------
 3 files changed, 213 insertions(+), 187 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 97f702dcbc222..00f7a3b445ebf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3560,14 +3560,22 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 
 		drm_crtc_vblank_on_config(&acrtc->base,
 					  &config);
-		/* Allow RX6xxx, RX7700, RX7800 GPUs to call amdgpu_irq_get.*/
+		/*
+		 * Since pflip_high_irq is no longer registered for DCN, Grab an
+		 * extra reference to vupdate irq insteaad to workaround this
+		 * issue:
+		 * https://gitlab.freedesktop.org/drm/amd/-/work_items/3936
+		 *
+		 * The callbacks to drm_vblank_on/off should really take care of
+		 * this though.
+		 */
 		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 		case IP_VERSION(3, 0, 0):
 		case IP_VERSION(3, 0, 2):
 		case IP_VERSION(3, 0, 3):
 		case IP_VERSION(3, 2, 0):
-			if (amdgpu_irq_get(adev, &adev->pageflip_irq, irq_type))
-				drm_err(dev, "DM_IRQ: Cannot get pageflip irq!\n");
+			if (amdgpu_irq_get(adev, &adev->vupdate_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot get vupdate irq!\n");
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 			if (amdgpu_irq_get(adev, &adev->vline0_irq, irq_type))
 				drm_err(dev, "DM_IRQ: Cannot get vline0 irq!\n");
@@ -3585,8 +3593,8 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 			if (amdgpu_irq_put(adev, &adev->vline0_irq, irq_type))
 				drm_err(dev, "DM_IRQ: Cannot put vline0 irq!\n");
 #endif
-			if (amdgpu_irq_put(adev, &adev->pageflip_irq, irq_type))
-				drm_err(dev, "DM_IRQ: Cannot put pageflip irq!\n");
+			if (amdgpu_irq_put(adev, &adev->vupdate_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot put vupdate irq!\n");
 		}
 
 		drm_crtc_vblank_off(&acrtc->base);
@@ -3599,6 +3607,10 @@ static void dm_update_pflip_irq_state(struct amdgpu_device *adev,
 	int irq_type =
 		amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
 
+	/* GRPH_PFLIP is not used on DCN; nothing to reapply. */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0)
+		return;
+
 	/**
 	 * This reads the current state for the IRQ and force reapplies
 	 * the setting to hardware.
@@ -4131,6 +4143,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	bool vrr_active = amdgpu_dm_crtc_vrr_active(acrtc_state);
 	bool cursor_update = false;
 	bool pflip_present = false;
+	bool immediate_flip = false;
 	bool dirty_rects_changed = false;
 	bool updated_planes_and_streams = false;
 	struct {
@@ -4293,6 +4306,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			acrtc_state->update_type == UPDATE_TYPE_FAST &&
 			get_mem_type(old_plane_state->fb) == get_mem_type(fb);
 
+		immediate_flip |= bundle->flip_addrs[planes_count].flip_immediate;
+
 		timestamp_ns = ktime_get_ns();
 		bundle->flip_addrs[planes_count].flip_timestamp_in_us = div_u64(timestamp_ns, 1000);
 		bundle->surface_updates[planes_count].flip_addr = &bundle->flip_addrs[planes_count];
@@ -4475,6 +4490,29 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		mutex_unlock(&dm->dc_lock);
 	}
 
+	/*
+	 * On DCN, flip completion is normally delivered from VUPDATE_NO_LOCK.
+	 * However, an immediate (tearing / async) flip is latched by HW right
+	 * away and does not wait for the next vupdate, so deliver its
+	 * completion event here, immediately after programming. Clearing
+	 * pflip_status ensures the next dm_vupdate_high_irq() won't double-send.
+	 *
+	 * On DCE, GRPH_PFLIP already fires immediately for immediate flips, so
+	 * this is DCN-only.
+	 */
+	if (immediate_flip && amdgpu_ip_version(dm->adev, DCE_HWIP, 0) != 0) {
+		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
+		if (acrtc_attach->pflip_status == AMDGPU_FLIP_SUBMITTED &&
+		    acrtc_attach->event) {
+			drm_crtc_send_vblank_event(&acrtc_attach->base,
+						   acrtc_attach->event);
+			acrtc_attach->event = NULL;
+			drm_crtc_vblank_put(&acrtc_attach->base);
+			acrtc_attach->pflip_status = AMDGPU_FLIP_NONE;
+		}
+		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
+	}
+
 	/*
 	 * Update cursor state *after* programming all the planes.
 	 * This avoids redundant programming in the case where we're going
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index c9916ed0ddc14..8a6b732cf80c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -281,7 +281,14 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 			drm_crtc_vblank_restore(crtc);
 	}
 
-	if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
+	/*
+	 * On DCN, VUPDATE_NO_LOCK is the single OTG interrupt used to deliver
+	 * vblank and pageflip completion events, so enable it whenever vblank
+	 * is enabled. On DCE, vupdate is only needed in VRR mode.
+	 */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0) {
+		rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, enable);
+	} else if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
 		if (enable) {
 			/* vblank irq on -> Only need vupdate irq in vrr mode */
 			if (amdgpu_dm_crtc_vrr_active(acrtc_state))
@@ -292,39 +299,46 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 		}
 	}
 
-	if (rc)
-		return rc;
-
-	/* crtc vblank or vstartup interrupt */
-	if (enable) {
-		rc = amdgpu_irq_get(adev, &adev->crtc_irq, irq_type);
-		drm_dbg_vbl(crtc->dev, "Get crtc_irq ret=%d\n", rc);
-	} else {
-		rc = amdgpu_irq_put(adev, &adev->crtc_irq, irq_type);
-		drm_dbg_vbl(crtc->dev, "Put crtc_irq ret=%d\n", rc);
-	}
-
 	if (rc)
 		return rc;
 
 	/*
-	 * hubp surface flip interrupt
-	 *
-	 * We have no guarantee that the frontend index maps to the same
-	 * backend index - some even map to more than one.
-	 *
-	 * TODO: Use a different interrupt or check DC itself for the mapping.
+	 * VLINE0 (crtc_irq) and GRPH_PFLIP (pageflip_irq) are only used on
+	 * DCE. On DCN, vblank and pageflip completion are delivered from
+	 * VUPDATE_NO_LOCK (enabled above), so don't touch them here.
 	 */
-	if (enable) {
-		rc = amdgpu_irq_get(adev, &adev->pageflip_irq, irq_type);
-		drm_dbg_vbl(crtc->dev, "Get pageflip_irq ret=%d\n", rc);
-	} else {
-		rc = amdgpu_irq_put(adev, &adev->pageflip_irq, irq_type);
-		drm_dbg_vbl(crtc->dev, "Put pageflip_irq ret=%d\n", rc);
-	}
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
+		/* crtc vblank or vstartup interrupt */
+		if (enable) {
+			rc = amdgpu_irq_get(adev, &adev->crtc_irq, irq_type);
+			drm_dbg_vbl(crtc->dev, "Get crtc_irq ret=%d\n", rc);
+		} else {
+			rc = amdgpu_irq_put(adev, &adev->crtc_irq, irq_type);
+			drm_dbg_vbl(crtc->dev, "Put crtc_irq ret=%d\n", rc);
+		}
 
-	if (rc)
-		return rc;
+		if (rc)
+			return rc;
+
+		/*
+		 * hubp surface flip interrupt
+		 *
+		 * We have no guarantee that the frontend index maps to the same
+		 * backend index - some even map to more than one.
+		 *
+		 * TODO: Use a different interrupt or check DC itself for the mapping.
+		 */
+		if (enable) {
+			rc = amdgpu_irq_get(adev, &adev->pageflip_irq, irq_type);
+			drm_dbg_vbl(crtc->dev, "Get pageflip_irq ret=%d\n", rc);
+		} else {
+			rc = amdgpu_irq_put(adev, &adev->pageflip_irq, irq_type);
+			drm_dbg_vbl(crtc->dev, "Put pageflip_irq ret=%d\n", rc);
+		}
+
+		if (rc)
+			return rc;
+	}
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	/* crtc vline0 interrupt, only available on DCN+ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 85711a2f2ae09..7c6db2bfc553a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1890,89 +1890,25 @@ static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
 	queue_work(system_percpu_wq, &offload_work->work);
 }
 
-static void dm_vupdate_high_irq(void *interrupt_params)
-{
-	struct common_irq_params *irq_params = interrupt_params;
-	struct amdgpu_device *adev = irq_params->adev;
-	struct amdgpu_crtc *acrtc;
-	struct drm_device *drm_dev;
-	struct drm_vblank_crtc *vblank;
-	ktime_t frame_duration_ns, previous_timestamp;
-	unsigned long flags;
-	int vrr_active;
-
-	acrtc = amdgpu_dm_get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VUPDATE);
-
-	if (acrtc) {
-		vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
-		drm_dev = acrtc->base.dev;
-		vblank = drm_crtc_vblank_crtc(&acrtc->base);
-		previous_timestamp = atomic64_read(&irq_params->previous_timestamp);
-		frame_duration_ns = vblank->time - previous_timestamp;
-
-		if (frame_duration_ns > 0) {
-			trace_amdgpu_refresh_rate_track(acrtc->base.index,
-						frame_duration_ns,
-						ktime_divns(NSEC_PER_SEC, frame_duration_ns));
-			atomic64_set(&irq_params->previous_timestamp, vblank->time);
-		}
-
-		drm_dbg_vbl(drm_dev,
-			    "crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
-			    vrr_active);
-
-		/* Core vblank handling is done here after end of front-porch in
-		 * vrr mode, as vblank timestamping will give valid results
-		 * while now done after front-porch. This will also deliver
-		 * page-flip completion events that have been queued to us
-		 * if a pageflip happened inside front-porch.
-		 */
-		if (vrr_active && acrtc->dm_irq_params.stream) {
-			bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
-			bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
-			bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state
-				== VRR_STATE_ACTIVE_VARIABLE;
-
-			amdgpu_dm_crtc_handle_vblank(acrtc);
-
-			/* BTR processing for pre-DCE12 ASICs */
-			if (adev->family < AMDGPU_FAMILY_AI) {
-				spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-				mod_freesync_handle_v_update(
-				    adev->dm.freesync_module,
-				    acrtc->dm_irq_params.stream,
-				    &acrtc->dm_irq_params.vrr_params);
-
-				if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
-					schedule_dc_vmin_vmax(adev,
-						acrtc->dm_irq_params.stream,
-						&acrtc->dm_irq_params.vrr_params.adjust);
-				}
-				spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
-			}
-		}
-	}
-}
-
 /**
- * dm_crtc_high_irq() - Handles CRTC interrupt
- * @interrupt_params: used for determining the CRTC instance
+ * dm_crtc_high_irq_handler() - Common OTG vblank/flip event handling
+ * @adev: amdgpu device
+ * @acrtc: the CRTC to service
  *
- * Handles the CRTC/VSYNC interrupt by notfying DRM's VBLANK
- * event handler.
+ * Performs writeback completion, vblank event handling, CRC processing, VRR BTR
+ * updates and pageflip completion delivery.
+ *
+ * On DCN this is driven by VUPDATE_NO_LOCK (the register latch point) from
+ * dm_vupdate_high_irq(); on DCE it is driven by VLINE0 at the start of vblank
+ * from dm_crtc_high_irq().
  */
-static void dm_crtc_high_irq(void *interrupt_params)
+static void dm_crtc_high_irq_handler(struct amdgpu_device *adev,
+				     struct amdgpu_crtc *acrtc)
 {
-	struct common_irq_params *irq_params = interrupt_params;
-	struct amdgpu_device *adev = irq_params->adev;
 	struct drm_writeback_job *job;
-	struct amdgpu_crtc *acrtc;
 	unsigned long flags;
 	int vrr_active;
-
-	acrtc = amdgpu_dm_get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
-	if (!acrtc)
-		return;
+	bool is_dcn = amdgpu_ip_version(adev, DCE_HWIP, 0) != 0;
 
 	if (acrtc->wb_conn) {
 		spin_lock_irqsave(&acrtc->wb_conn->job_lock, flags);
@@ -2009,12 +1945,17 @@ static void dm_crtc_high_irq(void *interrupt_params)
 		    vrr_active, acrtc->dm_irq_params.active_planes);
 
 	/**
-	 * Core vblank handling at start of front-porch is only possible
-	 * in non-vrr mode, as only there vblank timestamping will give
-	 * valid results while done in front-porch. Otherwise defer it
-	 * to dm_vupdate_high_irq after end of front-porch.
+	 * Core vblank handling.
+	 *
+	 * On DCN this handler runs at VUPDATE_NO_LOCK, the register latch
+	 * point, which is the correct place to timestamp both VRR and non-VRR
+	 * vblanks.
+	 *
+	 * On DCE this handler runs at the start of front-porch, where only
+	 * non-VRR timestamping is valid; VRR vblank is deferred to
+	 * dm_vupdate_high_irq() after end of front-porch.
 	 */
-	if (!vrr_active)
+	if (is_dcn || !vrr_active)
 		amdgpu_dm_crtc_handle_vblank(acrtc);
 
 	/**
@@ -2047,18 +1988,16 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	}
 
 	/*
-	 * If there aren't any active_planes then DCH HUBP may be clock-gated.
-	 * In that case, pageflip completion interrupts won't fire and pageflip
-	 * completion events won't get delivered. Prevent this by sending
-	 * pending pageflip events from here if a flip is still pending.
+	 * Deliver pageflip completion events (DCN only).
 	 *
-	 * If any planes are enabled, use dm_pflip_high_irq() instead, to
-	 * avoid race conditions between flip programming and completion,
-	 * which could cause too early flip completion events.
+	 * Since GRPH_PFLIP is not used, VUPDATE_NO_LOCK is the flip latch
+	 * point. Deliver any pending pageflip completion event from here.
+	 *
+	 * NOTE: This can deliver an event for a flip that was armed but not yet
+	 * programmed into HW; that race is closed in a follow-up change by
+	 * checking the programmed flip status.
 	 */
-	if (adev->family >= AMDGPU_FAMILY_RV &&
-	    acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
-	    acrtc->dm_irq_params.active_planes == 0) {
+	if (is_dcn && acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED) {
 		if (acrtc->event) {
 			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
 			acrtc->event = NULL;
@@ -2070,6 +2009,104 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 }
 
+static void dm_vupdate_high_irq(void *interrupt_params)
+{
+	struct common_irq_params *irq_params = interrupt_params;
+	struct amdgpu_device *adev = irq_params->adev;
+	struct amdgpu_crtc *acrtc;
+	struct drm_device *drm_dev;
+	struct drm_vblank_crtc *vblank;
+	ktime_t frame_duration_ns, previous_timestamp;
+	unsigned long flags;
+	int vrr_active;
+
+	acrtc = amdgpu_dm_get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VUPDATE);
+	if (!acrtc)
+		return;
+
+	vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
+	drm_dev = acrtc->base.dev;
+	vblank = drm_crtc_vblank_crtc(&acrtc->base);
+	previous_timestamp = atomic64_read(&irq_params->previous_timestamp);
+	frame_duration_ns = vblank->time - previous_timestamp;
+
+	if (frame_duration_ns > 0) {
+		trace_amdgpu_refresh_rate_track(acrtc->base.index,
+					frame_duration_ns,
+					ktime_divns(NSEC_PER_SEC, frame_duration_ns));
+		atomic64_set(&irq_params->previous_timestamp, vblank->time);
+	}
+
+	drm_dbg_vbl(drm_dev,
+		    "crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
+		    vrr_active);
+
+	/*
+	 * On DCN, VUPDATE_NO_LOCK is the single OTG interrupt used to deliver
+	 * vblank and pageflip completion events; VSTARTUP and GRPH_PFLIP are
+	 * not used. Run the full handler here.
+	 */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0) {
+		dm_crtc_high_irq_handler(adev, acrtc);
+		return;
+	}
+
+	/* DCE only below. */
+
+	/* Core vblank handling is done here after end of front-porch in
+	 * vrr mode, as vblank timestamping will give valid results
+	 * while now done after front-porch. This will also deliver
+	 * page-flip completion events that have been queued to us
+	 * if a pageflip happened inside front-porch.
+	 */
+	if (vrr_active && acrtc->dm_irq_params.stream) {
+		bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
+		bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
+		bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state
+			== VRR_STATE_ACTIVE_VARIABLE;
+
+		amdgpu_dm_crtc_handle_vblank(acrtc);
+
+		/* BTR processing for pre-DCE12 ASICs */
+		if (adev->family < AMDGPU_FAMILY_AI) {
+			spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
+			mod_freesync_handle_v_update(
+				adev->dm.freesync_module,
+				acrtc->dm_irq_params.stream,
+				&acrtc->dm_irq_params.vrr_params);
+
+			if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
+				schedule_dc_vmin_vmax(adev,
+					acrtc->dm_irq_params.stream,
+					&acrtc->dm_irq_params.vrr_params.adjust);
+			}
+			spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
+		}
+	}
+}
+
+/**
+ * dm_crtc_high_irq() - Handles CRTC interrupt
+ * @interrupt_params: used for determining the CRTC instance
+ *
+ * Handles the CRTC/VSYNC interrupt by notfying DRM's VBLANK event handler.
+ *
+ * Used on DCE (VLINE0, set to vblank start). On DCN the equivalent handling is
+ * driven by VUPDATE_NO_LOCK in dm_vupdate_high_irq().
+ */
+static void dm_crtc_high_irq(void *interrupt_params)
+{
+	struct common_irq_params *irq_params = interrupt_params;
+	struct amdgpu_device *adev = irq_params->adev;
+	struct amdgpu_crtc *acrtc;
+
+	acrtc = amdgpu_dm_get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
+	if (!acrtc)
+		return;
+
+	dm_crtc_high_irq_handler(adev, acrtc);
+}
+
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 /**
  * dm_dcn_vertical_interrupt0_high_irq() - Handles OTG Vertical interrupt0 for
@@ -2383,38 +2420,6 @@ int amdgpu_dm_dcn10_register_irq_handlers(struct amdgpu_device *adev)
 	 *    for acknowledging and handling.
 	 */
 
-	/* Use VSTARTUP interrupt */
-	for (i = DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP;
-			i <= DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP + adev->mode_info.num_crtc - 1;
-			i++) {
-		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->crtc_irq);
-
-		if (r) {
-			drm_err(adev_to_drm(adev), "Failed to add crtc irq id!\n");
-			return r;
-		}
-
-		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i, 0);
-
-		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
-			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
-			drm_err(adev_to_drm(adev), "Failed to register vblank irq!\n");
-			return -EINVAL;
-		}
-
-		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
-
-		c_irq_params->adev = adev;
-		c_irq_params->irq_src = int_params.irq_source;
-
-		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_crtc_high_irq, c_irq_params))
-			return -ENOMEM;
-	}
-
 	/* Use otg vertical line interrupt */
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	for (i = 0; i <= adev->mode_info.num_crtc - 1; i++) {
@@ -2486,37 +2491,6 @@ int amdgpu_dm_dcn10_register_irq_handlers(struct amdgpu_device *adev)
 			return -ENOMEM;
 	}
 
-	/* Use GRPH_PFLIP interrupt */
-	for (i = DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT;
-			i <= DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT + dc->caps.max_otg_num - 1;
-			i++) {
-		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->pageflip_irq);
-		if (r) {
-			drm_err(adev_to_drm(adev), "Failed to add page flip irq id!\n");
-			return r;
-		}
-
-		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i, 0);
-
-		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
-			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
-			drm_err(adev_to_drm(adev), "Failed to register pflip irq!\n");
-			return -EINVAL;
-		}
-
-		c_irq_params = &adev->dm.pflip_params[int_params.irq_source - DC_IRQ_SOURCE_PFLIP_FIRST];
-
-		c_irq_params->adev = adev;
-		c_irq_params->irq_src = int_params.irq_source;
-
-		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_pflip_high_irq, c_irq_params))
-			return -ENOMEM;
-	}
-
 	/* HPD */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DC_HPD1_INT,
 			&adev->hpd_irq);
-- 
2.54.0

