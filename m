Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAAA5505C1
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089952; cv=none; b=UGymEqQFm3SSFvv8m6FMhCXEXg+weRlLTRXIId5tC5Q3Irp/u83Ja5rpURQ5/8uXMkaLh8r/ebRJ6edH2orlOchGziPuZJWQE3jbx81di1W2y0cdGj8ODJz+F9aAuuCLUx+iGc4ZzhQK94M21fVB+MN6d1LbPuDM/o7DHZhnOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089952; c=relaxed/simple;
	bh=mCLeBg9lsTbC3c+1lrJa9juABQ9e/vR94d3Rexkj1OQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=js+i7zd1tKZeIqNLFWLuB5Xhy0kv+CLJiIGt0AOGS6M0mV1Ycv5+xBMI5/HmiTeNmoFvILvtEXcRepGMP5pXIgxufbHTNDPBix+rNvRx0PnfS0nCyEkRcUQY378YB5+iQ6Wi9qPEL9G26pL124Pwbru8NetHCtdZyEClS/vidIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QX/P8pSx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QX/P8pSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5011F000FF;
	Tue, 22 Sep 2026 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089949;
	bh=M+/f1kOGy/SmZ2nqMy/2RJajznpxne/c8l/fnCDzjrU=;
	h=Subject:To:Cc:From:Date;
	b=QX/P8pSxjQEr/O6gr5rXiCg+bMILQTyGNXKDhnOnzo7rBNGm7wRl7dStTPoaHWmmw
	 Gmgk7F9fg3PmnTDySoxy4lU8RdhXRds6qPwIF9lm4sxUaLAieF22KMts7sl/FAkCoZ
	 JsTD/+/Dl6wzPxx35vVy2c9UuR80gKAgfKD1n0hI=
Subject: FAILED: patch "[PATCH] drm/amd/display: Atomize IRQ register read/modify/write ops" failed to apply to 7.2-stable tree
To: sunpeng.li@amd.com,alexander.deucher@amd.com,chen-yu.chen@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:03:20 +0200
Message-ID: <2026092220-morale-drizzle-4aa3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 63e19ef3ddab806c472748c825f4dc88dcd994e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092220-morale-drizzle-4aa3@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63e19ef3ddab806c472748c825f4dc88dcd994e8 Mon Sep 17 00:00:00 2001
From: Leo Li <sunpeng.li@amd.com>
Date: Tue, 25 Aug 2026 23:21:53 -0400
Subject: [PATCH] drm/amd/display: Atomize IRQ register read/modify/write ops

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

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 08b8605029ab..36d2f86f000a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1420,7 +1420,7 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 		if (acrtc && state->stream_status[i].plane_count != 0 &&
 		    amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
 			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
-			rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
+			rc = amdgpu_dm_irq_set(adev, irq_source, enable) ? 0 : -EBUSY;
 			if (rc)
 				drm_warn(adev_to_drm(adev), "Failed to %s pflip interrupts\n",
 					 enable ? "enable" : "disable");
@@ -1444,7 +1444,7 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 			/* During gpu-reset we disable and then enable vblank irq, so
 			 * don't use amdgpu_irq_get/put() to avoid refcount change.
 			 */
-			if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
+			if (!amdgpu_dm_irq_set(adev, irq_source, enable))
 				drm_warn(adev_to_drm(adev), "Failed to %sable vblank interrupt\n", enable ? "en" : "dis");
 
 		} else if (acrtc && state->stream_status[i].plane_count != 0) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3524931451c8..881c8d1c3cc0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -552,6 +552,18 @@ struct amdgpu_display_manager {
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
index 62eac6e65334..1d941be73561 100644
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
index 298de7b75ca8..ced8b3d2d762 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1439,12 +1439,13 @@ void dm_helpers_free_gpu_mem(
 
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
index d0239a3de2e1..74a8735168aa 100644
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
@@ -690,6 +691,23 @@ STATIC_IFN_KUNIT void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
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
@@ -710,7 +728,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 			entry->src_id,
 			entry->src_data[0]);
 
-	dc_interrupt_ack(adev->dm.dc, src);
+	amdgpu_dm_irq_ack(adev, src);
 
 	/* Call high irq work immediately */
 	amdgpu_dm_irq_immediate_work(adev, src);
@@ -750,7 +768,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 	enum dc_irq_source src = amdgpu_dm_hpd_to_dal_irq_source(type);
 	bool st = (state == AMDGPU_IRQ_STATE_ENABLE);
 
-	dc_interrupt_set(adev->dm.dc, src, st);
+	amdgpu_dm_irq_set(adev, src, st);
 	return 0;
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_hpd_irq_state);
@@ -785,7 +803,7 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
 	if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
 		dc_allow_idle_optimizations(dc, false);
 
-	dc_interrupt_set(adev->dm.dc, irq_source, st);
+	amdgpu_dm_irq_set(adev, irq_source, st);
 	return 0;
 }
 
@@ -842,7 +860,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *a
 	enum dc_irq_source irq_source = DC_IRQ_SOURCE_DMCUB_OUTBOX;
 	bool st = (state == AMDGPU_IRQ_STATE_ENABLE);
 
-	dc_interrupt_set(adev->dm.dc, irq_source, st);
+	amdgpu_dm_irq_set(adev, irq_source, st);
 	return 0;
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_dmub_outbox_irq_state);
@@ -870,7 +888,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *ad
 	enum dc_irq_source irq_source = DC_IRQ_SOURCE_DMCUB_OUTBOX0;
 	bool st = (state == AMDGPU_IRQ_STATE_ENABLE);
 
-	dc_interrupt_set(adev->dm.dc, irq_source, st);
+	amdgpu_dm_irq_set(adev, irq_source, st);
 	return 0;
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_dmub_trace_irq_state);
@@ -937,9 +955,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_set_irq_funcs);
 
 void amdgpu_dm_outbox_init(struct amdgpu_device *adev)
 {
-	dc_interrupt_set(adev->dm.dc,
-		DC_IRQ_SOURCE_DMCUB_OUTBOX,
-		true);
+	amdgpu_dm_irq_set(adev, DC_IRQ_SOURCE_DMCUB_OUTBOX, true);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_outbox_init);
 
@@ -962,7 +978,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 
 	/* First, clear all hpd and hpdrx interrupts */
 	for (i = DC_IRQ_SOURCE_HPD1; i <= DC_IRQ_SOURCE_HPD6RX; i++) {
-		if (!dc_interrupt_set(adev->dm.dc, i, false))
+		if (!amdgpu_dm_irq_set(adev, i, false))
 			drm_err(dev, "Failed to clear hpd(rx) source=%d on init\n",
 				i);
 	}
@@ -991,7 +1007,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 		 * of dm. Note that only hpd interrupt types are registered with
 		 * base driver; hpd_rx types aren't. IOW, amdgpu_irq_get/put on
 		 * hpd_rx isn't available. DM currently controls hpd_rx
-		 * explicitly with dc_interrupt_set()
+		 * explicitly with amdgpu_dm_irq_set()
 		 */
 		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
 			irq_type = dc_link->irq_source_hpd - DC_IRQ_SOURCE_HPD1;
@@ -1000,23 +1016,21 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
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
@@ -1061,16 +1075,14 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
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
index 0d998f204250..ae0f4da96252 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -436,7 +436,7 @@ static void dm_test_crtc_set_vupdate_irq_no_otg(struct kunit *test)
  * dm_test_crtc_set_vupdate_irq_dc_busy - Test vupdate irq when DC rejects request
  * @test: The KUnit test context
  *
- * With an OTG instance assigned but no DC attached, dc_interrupt_set() returns
+ * With an OTG instance assigned but no DC attached, amdgpu_dm_irq_set() returns
  * false and the function must report the request as busy (-EBUSY).
  */
 static void dm_test_crtc_set_vupdate_irq_dc_busy(struct kunit *test)
@@ -453,12 +453,12 @@ static void dm_test_crtc_set_vupdate_irq_dc_busy(struct kunit *test)
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
@@ -477,7 +477,7 @@ static struct irq_source_info_funcs dm_test_vupdate_irq_src_funcs = {
 	.ack = dm_test_vupdate_irq_src_ack,
 };
 
-/* A .set that fails so dc_interrupt_set() reports the source as busy. */
+/* A .set that fails so amdgpu_dm_irq_set() reports the source as busy. */
 static bool dm_test_vupdate_irq_src_set_busy(struct irq_service *irq_service,
 					     const struct irq_source_info *info,
 					     bool enable)
@@ -519,7 +519,9 @@ static void dm_test_crtc_set_vupdate_irq_enable(struct kunit *test)
 	irqs = kunit_kzalloc(test, sizeof(*irqs), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, irqs);
 
-	/* Populate the per-source info table so dc_interrupt_set() succeeds. */
+	/*
+	 * Populate the per-source info table so amdgpu_dm_irq_set() succeeds.
+	 */
 	info = kunit_kzalloc(test, sizeof(*info) * DAL_IRQ_SOURCES_NUMBER,
 			     GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
@@ -1018,7 +1020,9 @@ static void dm_test_crtc_enable_vblank_vupdate_busy(struct kunit *test)
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
index 82e0c984693c..639512bea275 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -2442,17 +2442,21 @@ static void dm_test_is_dp_sink_present_null_priv(struct kunit *test)
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
index 861ee9eaa032..95322d8c8613 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -268,7 +268,7 @@ static bool dm_test_irq_src_ack(struct irq_service *irq_service,
 	return true;
 }
 
-/* Per-source funcs let dc_interrupt_set() succeed without register access. */
+/* Per-source funcs let amdgpu_dm_irq_set() succeed without register access. */
 static struct irq_source_info_funcs dm_test_irq_src_funcs = {
 	.set = dm_test_irq_src_set,
 	.ack = dm_test_irq_src_ack,
@@ -290,7 +290,7 @@ static struct dc *dm_test_alloc_dc_with_irq_service(struct kunit *test,
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, irqs);
 
 	/*
-	 * Populate the per-source info table so dc_interrupt_set()/_ack()
+	 * Populate the per-source info table so amdgpu_dm_irq_set()/_ack()
 	 * succeed without touching hardware registers.
 	 */
 	info = kunit_kzalloc(test, sizeof(*info) * DAL_IRQ_SOURCES_NUMBER,
@@ -1227,7 +1227,7 @@ static void dm_test_irq_suspend_empty(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	/*
-	 * With no registered handlers the HW dc_interrupt_set() calls are
+	 * With no registered handlers the amdgpu_dm_irq_set() calls are
 	 * skipped, so suspend must complete without touching the (absent) DC.
 	 */
 	amdgpu_dm_irq_suspend(adev);
@@ -1275,11 +1275,11 @@ static void dm_test_irq_resume_late_empty(struct kunit *test)
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
@@ -1330,11 +1330,11 @@ static void dm_test_irq_suspend_disables_polling(struct kunit *test)
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
@@ -1358,10 +1358,10 @@ static void dm_test_irq_resume_early_registered(struct kunit *test)
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
@@ -1592,7 +1592,7 @@ static void dm_test_set_crtc_irq_state_enable(struct kunit *test)
 
 	/*
 	 * otg_inst >= 0 computes the irq source and reaches the NULL-safe
-	 * dc_interrupt_set(); the ips_support branch is skipped (dc == NULL).
+	 * amdgpu_dm_irq_set(); the ips_support branch is skipped (dc == NULL).
 	 */
 	acrtc->otg_inst = 3;
 	adev->mode_info.crtcs[0] = acrtc;
@@ -1671,8 +1671,8 @@ static void dm_test_set_vupdate_irq_state_enable(struct kunit *test)
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
@@ -1891,7 +1891,7 @@ static void dm_test_set_hpd_irq_state_null_dc(struct kunit *test)
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 
-	/* dc_interrupt_set() is a no-op when dc is NULL, so both states
+	/* amdgpu_dm_irq_set() is a no-op when dc is NULL, so both states
 	 * return 0 without dereferencing the (absent) DC.
 	 */
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_set_hpd_irq_state(adev, NULL, AMDGPU_HPD_1,
@@ -1951,7 +1951,7 @@ static void dm_test_outbox_init_null_dc(struct kunit *test)
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 
-	/* Single dc_interrupt_set() call must be skipped when dc is NULL. */
+	/* Single amdgpu_dm_irq_set() call must be skipped when dc is NULL. */
 	amdgpu_dm_outbox_init(adev);
 }
 
@@ -1969,7 +1969,7 @@ static void dm_test_hpd_init_empty_connectors(struct kunit *test)
 
 	/*
 	 * With an empty connector list the per-connector loop is skipped and
-	 * the initial clear loop relies on dc_interrupt_set() being a no-op
+	 * the initial clear loop relies on amdgpu_dm_irq_set() being a no-op
 	 * for a NULL dc, so init must complete without touching the DC.
 	 */
 	amdgpu_dm_hpd_init(adev);
@@ -2004,7 +2004,7 @@ static void dm_test_hpd_init_fini_with_connectors(struct kunit *test)
 
 	/*
 	 * num_hpd = 0 forces irq_type >= num_hpd so the loop takes the HW
-	 * fallback (dc_interrupt_set()) instead of amdgpu_irq_get(); with a
+	 * fallback (amdgpu_dm_irq_set()) instead of amdgpu_irq_get(); with a
 	 * NULL dc that fallback is a safe no-op.
 	 */
 	adev->mode_info.num_hpd = 0;
@@ -2090,7 +2090,7 @@ static void dm_test_hpd_init_fini_irq_ref(struct kunit *test)
 	/*
 	 * num_hpd >= 1 makes irq_type (0) < num_hpd, so the loop takes the
 	 * amdgpu_irq_get()/amdgpu_irq_put() branch instead of the
-	 * dc_interrupt_set() fallback. The mock device has irq.installed ==
+	 * amdgpu_dm_irq_set() fallback. The mock device has irq.installed ==
 	 * false, so both calls fail early with -ENOENT (logging an error)
 	 * without touching the base-driver irq state.
 	 */

