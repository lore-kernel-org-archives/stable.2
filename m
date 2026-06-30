Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FDE2DB794
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782842620; cv=fail; b=SbaobURyk5tOkWqZJhUOEU+IhO5nWN1fzqjjh2dqUUms5OXK6WljLSre2PrWIMWdTppPjtKIvi8+fUJD+JM/KeVXneon5HxU8GgIBe1Gbw8TcB6piurIG8x6vb3M3ekjr0kqqG9grhyWwdjFRZI2ALfUnTemxF0XDrD2tJIuDKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782842620; c=relaxed/simple;
	bh=PfazlUyEhfBiyzrfqCY/MPaXx4UfqLW2Wn3lUZ5KlGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PS3N7s1uM/Falgjxh5VE3YZd1IeIUzxNBJqXn+50he5cbqfDqEbT4rxgKAQ5qEkgvizVwmYOejHTo1Nnzxf0jXT5O9Nh8rry7q+fGwY6q+kG6ATn8nku4rIMM2s5ebXQgvbFcxPpMWEfzHbf0WHFJYXJTgdZvcl+lLdfdY0tW70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N1buWu5O; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N1buWu5O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb8ZaPSPewiWZnCCioMKEdoUeAHhFNYQYkMWW5z3pLnAxjWGvuq6rMbTByU1QPBsBwHzOKY3eBVlnxMiTVut/OPWj/J7dPN58ohOTVo1UahJBic2SdFBaaoFV9SO0io4XeyPmrGXYcA3AbCGLhY9RUEqNCiQQr2xrCuGEZhyZQKeq9D9WMi0oHxOgjhH8Nq1FXfH37oTrbwV+V2Pbp17c8NzM0yC0sjydtfKR8cLs3vKlcFKKT1/aSWIeUoJfKA+pa0sDWoWaK7vNLX1MxpB+ShycxsozjRyLuE5NdOEhIZEKi4pXNH9JVOcJjgGjyULTXxK5kWlASCMB+EdzWZ57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUGiakTwXMNGr5f8ngWvCFBOV5YhmU217dwdkHY/2vU=;
 b=jOtG45jjNfLtUQbAVczFbUjMD0SuPdNTujU1uJHmkGXM78+D2R3l1X5P4KT6cYP1eAaJr+Fo9eZ6KX4iVYVHs/dCQHskcjGhMBh/rQcvtDH0kKXoEjjQnSmmedGC4tk5HQiftqnM+MSUFjL5qM2rJxmr7EpTdo4xay5DCblduYS2GOW8QRnkQNmulJh84A4NIyyEFTrD812UsjG+qCmCeHUFPR31d7frhf2BkbYohVIyD5l0NQfMhw+7UfqlgueK7cCPGNcqccJLeVrOf1wWnXOUWA82uAsO+dtVrAna5n4KaKiAhWTwGQSYU6zvRkhY5jdYQaq7kNyqfSRimIjR4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUGiakTwXMNGr5f8ngWvCFBOV5YhmU217dwdkHY/2vU=;
 b=N1buWu5OBlcpdrfuHxNC3YDqhk5hRc7BKScdnu1sB7VJmcFUgNriRDMXuAxgLjEO6Nu4EJkMflDMmsLyGY+SiQTwjOamwdG/eGsl6KiMqxclh19fuX9qHWpH4OgRAqBDf3+6MkL/Crmb2tqRKRH2F6Dv6PZXK7LyJ4o38J5QH6Y=
Received: from DS1PR06CA0004.namprd06.prod.outlook.com (2603:10b6:8:458::16)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Tue, 30 Jun 2026 18:03:29 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:458:cafe::2f) by DS1PR06CA0004.outlook.office365.com
 (2603:10b6:8:458::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 18:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 18:03:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 13:03:29 -0500
Received: from flamewok (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport; Tue, 30
 Jun 2026 13:03:28 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
	<wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
	<xaver.hugl@kde.org>, <mario.kleiner.de@gmail.com>,
	<michel.daenzer@mailbox.org>, <matthew.schwartz@linux.dev>,
	<chris@kode54.net>, Leo Li <sunpeng.li@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 1/3] drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock
Date: Tue, 30 Jun 2026 14:02:59 -0400
Message-ID: <20260630180301.362070-2-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630180301.362070-1-sunpeng.li@amd.com>
References: <20260630180301.362070-1-sunpeng.li@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 498625a6-3732-434d-7fc4-08ded6d1e3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|32650700020|1800799024|23010399003|7416014|82310400026|376014|18002099003|13003099007|22082099003|11063799006|5023799004|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	Y5cA39HSTTWIbFtFpKEiLnBYTQ0jXwugV52v2W5VMkScWhucl30HoLx/PyD2lFwqdW+TotuCSdBXbf5qKTHh6dbZhrP5mmLGRfhRO0SaCy4SEzy+GFOYI+GZT13DvyVRfWzM45XQqLqKDnUIwLF8/dBsUr7O8mRePbjqFyrEqHSPNHriGGKLf8lIsx1l27/pLqDKqjaZRM35Etspl2WhcObnUVnmQ03Z7OC16DrM+l1Nhs+WSd3nyJLYJa0os7UCyvR0vNafn6KeIzudO27Z9ge5GXsVvrjc4anrZgQgm05pGh8UZJruq7qBxEW6NqMSIe1vd3Msl0iYWl4xJpmS6NXGlizYGll6aBkSE60N1TPNYAD6XHuPTMRSllEelLvA5bB+UPsgi1NuJq2DQH2FBSxJYX6DU/Yi8bXiaRA1diXvsHyxy+QeFZV9fMq5lDeVX3CxAZVbyWZBqCJexnrRPK9xh/N+xOF9VSfBJ5dwvbdSGPlNUvuu4jGav++Txn3moyLhTGMJYWCcgZXkdlV3TtDJge+uYgfJqLPd7YNSx8lc2rVbslyXieEYbyTJY50y6E+znh87n0R8kPMBw3AyBQRxYgppzeq42tZsL4ev/pfHAxDLGbowcQm+A6TzO9LOWSjk5s32v4GB+WxZZaHQiwlNHnTobDihPBeZwqL0D+sgEPRaWmnifPXwhhCVipVDck5WU7h3iavRSlaVTTIgMw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(32650700020)(1800799024)(23010399003)(7416014)(82310400026)(376014)(18002099003)(13003099007)(22082099003)(11063799006)(5023799004)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rru8ujQc63DslYNRe5AsaGJB9ZMfZFeCLEbhZy4c9RAQ9iXgohXWHFfzmndKrO9FwdJOSs+bnJv6tocLSdlHLKFN9nM4DRLWUGdVZS40iqh4oIOZ1cQnz7ka9/MwUqK1uo0O7mSupP4uQyswOjDJTPJTLa7xXjNx4Yqgg7NmOjns4XlZq5El5dVFHnuTYS3TmD7aW7NUn2QFV8xaPSiQTvMw83SNVzaiEPVsu2TV/ipXOmTVPhY6DdSRjxujwwB8GTg8vOnsOPbmwSLYeHAJ61AaRkTMIDElnUYXvbXZ2m7GqQb8YMT0fI2WWjkFq1IYGqExvBdLKhhPyensEeg+LxqW66lk6aU1IusYaKlmfPf7N0dSoqk1mDaNocnjolrhyKJbO2Ok0PiRMVPRUMcdbYNNRaIzjwttXvYj8JsSAHau0T1HM7mNILNVDo/37pai
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 18:03:29.2931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 498625a6-3732-434d-7fc4-08ded6d1e3eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866

From: Leo Li <sunpeng.li@amd.com>

[Why]

On DCN, vblank events were delivered from VSTARTUP/VUPDATE
(dm_crtc_high_irq/dm_vupdate_high_irq) and pageflip completion from
GRPH_PFLIP (dm_pflip_high_irq). These signals can be masked by hardware
by a few things:

* DPG - DCN can Dynamically Power Gate parts of the display pipe when a
  self-refresh capable eDP is connected. DPG is engaged when there's
  enough static frames (detected through drm_vblank_off). Once gated,
  even though the OTG (output timing generator) is still enabled,
  VSTARTUP and GRPH_FLIP are masked.

* GSL - Driver can use the Global Sync Lock to block HW from latching
  onto double-buffered registers during programming, to prevent HW from
  latching onto a partially programmed state. This will mask VSTARTUP,
  GRPH_FLIP, and VUPDATE. See dcn20_pipe_control_lock().

* MALL - A DCN accessible cache introduced in DCN32+ DGPUs that can
  store fb data to allow for longer DRAM sleep. When scanning out from
  MALL, VSTARTUP is masked.

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

v2: Do not gate VUPDATE_NO_LOCK on DCN in dm_handle_vrr_transition()
    Also toggle VUPDATE_NO_LOCK on DCN in dm_gpureset_toggle_interrupts()
    Re-cook vblank event count and timestamp for immediate flips

Cc: stable@vger.kernel.org
Fixes: 9b47278cec98 ("drm/amd/display: temp w/a for dGPU to enter idle optimizations")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/3787
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/4141
Assisted-by: Copilot:claude-opus-4.8
Co-developed-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  68 ++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  70 +++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 282 ++++++++----------
 3 files changed, 230 insertions(+), 190 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c72c417903fbd..2a64012295521 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1541,7 +1541,8 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 		acrtc = amdgpu_dm_get_crtc_by_otg_inst(
 				adev, state->stream_status[i].primary_otg_inst);
 
-		if (acrtc && state->stream_status[i].plane_count != 0) {
+		if (acrtc && state->stream_status[i].plane_count != 0 &&
+		    amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
 			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
 			rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
 			if (rc)
@@ -1569,6 +1570,13 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 			 */
 			if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
 				drm_warn(adev_to_drm(adev), "Failed to %sable vblank interrupt\n", enable ? "en" : "dis");
+
+		} else if (acrtc && state->stream_status[i].plane_count != 0) {
+			/* DCN only needs to toggle VUPDATE_NO_LOCK */
+			rc = amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, enable);
+			if (rc)
+				drm_warn(adev_to_drm(adev), "Failed to %sable vupdate interrupt\n",
+					 enable ? "en" : "dis");
 		}
 	}
 
@@ -3551,14 +3559,22 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 
 		drm_crtc_vblank_on_config(&acrtc->base,
 					  &config);
-		/* Allow RX6xxx, RX7700, RX7800 GPUs to call amdgpu_irq_get.*/
+		/*
+		 * Since pflip_high_irq is no longer registered for DCN, grab an
+		 * extra reference to vupdate irq instead to workaround this
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
@@ -3576,8 +3592,8 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 			if (amdgpu_irq_put(adev, &adev->vline0_irq, irq_type))
 				drm_err(dev, "DM_IRQ: Cannot put vline0 irq!\n");
 #endif
-			if (amdgpu_irq_put(adev, &adev->pageflip_irq, irq_type))
-				drm_err(dev, "DM_IRQ: Cannot put pageflip irq!\n");
+			if (amdgpu_irq_put(adev, &adev->vupdate_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot put vupdate irq!\n");
 		}
 
 		drm_crtc_vblank_off(&acrtc->base);
@@ -3590,6 +3606,10 @@ static void dm_update_pflip_irq_state(struct amdgpu_device *adev,
 	int irq_type =
 		amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
 
+	/* GRPH_PFLIP is not used on DCN; nothing to reapply. */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0)
+		return;
+
 	/**
 	 * This reads the current state for the IRQ and force reapplies
 	 * the setting to hardware.
@@ -3923,9 +3943,13 @@ static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
 					    struct dm_crtc_state *old_state,
 					    struct dm_crtc_state *new_state)
 {
+	struct amdgpu_device *adev = dm->adev;
 	bool old_vrr_active = amdgpu_dm_crtc_vrr_active(old_state);
 	bool new_vrr_active = amdgpu_dm_crtc_vrr_active(new_state);
 
+	/* Only DCE gates vupdate on VRR, keep it enabled for DCN */
+	bool vrr_gates_vupdate = amdgpu_ip_version(adev, DCE_HWIP, 0) == 0;
+
 	if (!old_vrr_active && new_vrr_active) {
 		/* Transition VRR inactive -> active:
 		 * While VRR is active, we must not disable vblank irq, as a
@@ -3935,7 +3959,8 @@ static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
 		 * We also need vupdate irq for the actual core vblank handling
 		 * at end of vblank.
 		 */
-		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) != 0);
+		if (vrr_gates_vupdate)
+			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) != 0);
 		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);
 		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR off->on: Get vblank ref\n",
 				 __func__, new_state->base.crtc->base.id);
@@ -3951,7 +3976,8 @@ static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
 		/* Transition VRR active -> inactive:
 		 * Allow vblank irq disable again for fixed refresh rate.
 		 */
-		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) != 0);
+		if (vrr_gates_vupdate)
+			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) != 0);
 		drm_crtc_vblank_put(new_state->base.crtc);
 		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR on->off: Drop vblank ref\n",
 				 __func__, new_state->base.crtc->base.id);
@@ -4122,6 +4148,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	bool vrr_active = amdgpu_dm_crtc_vrr_active(acrtc_state);
 	bool cursor_update = false;
 	bool pflip_present = false;
+	bool immediate_flip = false;
 	bool dirty_rects_changed = false;
 	bool updated_planes_and_streams = false;
 	struct {
@@ -4284,6 +4311,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			acrtc_state->update_type == UPDATE_TYPE_FAST &&
 			get_mem_type(old_plane_state->fb) == get_mem_type(fb);
 
+		immediate_flip |= bundle->flip_addrs[planes_count].flip_immediate;
+
 		timestamp_ns = ktime_get_ns();
 		bundle->flip_addrs[planes_count].flip_timestamp_in_us = div_u64(timestamp_ns, 1000);
 		bundle->surface_updates[planes_count].flip_addr = &bundle->flip_addrs[planes_count];
@@ -4476,6 +4505,29 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	    acrtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE)
 		amdgpu_dm_commit_cursors(state);
 
+	/*
+	 * On DCN, flip completion is normally delivered from VUPDATE_NO_LOCK.
+	 * However, an immediate (tearing / async) flip is latched by HW right
+	 * away and does not wait for the next vupdate, so deliver its
+	 * completion event here after programming.
+	 *
+	 * On DCE, GRPH_PFLIP already fires immediately for immediate flips, so
+	 * this is DCN-only.
+	 */
+	if (immediate_flip && amdgpu_ip_version(dm->adev, DCE_HWIP, 0) != 0) {
+		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
+		if (acrtc_attach->pflip_status == AMDGPU_FLIP_SUBMITTED &&
+		    acrtc_attach->event) {
+			drm_crtc_accurate_vblank_count(&acrtc_attach->base);
+			drm_crtc_send_vblank_event(&acrtc_attach->base,
+						   acrtc_attach->event);
+			acrtc_attach->event = NULL;
+			drm_crtc_vblank_put(&acrtc_attach->base);
+			acrtc_attach->pflip_status = AMDGPU_FLIP_NONE;
+		}
+		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
+	}
+
 cleanup:
 	kfree(bundle);
 }
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
index c5467f34c51f1..5c0ff345150d3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1890,88 +1890,24 @@ static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
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
-	struct amdgpu_crtc *acrtc;
 	unsigned long flags;
 	int vrr_active;
-
-	acrtc = amdgpu_dm_get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
-	if (!acrtc)
-		return;
+	bool is_dcn = amdgpu_ip_version(adev, DCE_HWIP, 0) != 0;
 
 	if (acrtc->wb_conn && acrtc->wb_pending) {
 		struct dc_stream_state *stream = acrtc->dm_irq_params.stream;
@@ -2000,12 +1936,17 @@ static void dm_crtc_high_irq(void *interrupt_params)
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
@@ -2038,18 +1979,16 @@ static void dm_crtc_high_irq(void *interrupt_params)
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
@@ -2061,6 +2000,104 @@ static void dm_crtc_high_irq(void *interrupt_params)
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
+ * Handles the CRTC/VSYNC interrupt by notifying DRM's VBLANK event handler.
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
@@ -2374,38 +2411,6 @@ int amdgpu_dm_dcn10_register_irq_handlers(struct amdgpu_device *adev)
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
@@ -2477,37 +2482,6 @@ int amdgpu_dm_dcn10_register_irq_handlers(struct amdgpu_device *adev)
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

