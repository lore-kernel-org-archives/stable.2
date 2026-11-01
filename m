Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793527085;
	b=U4X6p8HFQW3Hm5xwftBdhdVYaO+tp0vFjbDOezEm2sB10Q/3/rU8AdMpPSq/LEdQ/XJD
	 TIv68NFB/4XodkI9dv8xOqlVrBMS9w8Qq9FsHPRiR5Q6//gw4VD9SOWa/yabB96Ufctd4
	 pVfOED5S8SQN7Qr8v4srdqsP4NHs7V1nXTjbupAawTSUzU17a5LxHQtikAtYOmAXQuioy
	 0yuNtPgR+Ox6BCb/EhATw1cPq4T1jOO3a4K7Qoir9lJMXJAiHw75ajOUghdTYp5q+8gY/
	 +jafLoDLWJhf5hsm0YuzGRtoHINKerZT4sBBEr8bjOXdcRG79odkvNsu+yl9yUwsLMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793527085;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8xnBzjwCE8sPHtEp9RM3ZWkfBVkxawpnG/dVeRbBTaw=;
	b=lZfqd1Fymyj7wRYLXYfWl4uowB2MBpWm0J16Ha07p+Tth1fU4x61MHOy3mH9kXs0tHN0
	 dLnQH7LtSIKQxDyISIvT9NSKi96LLKvryBYcogKR7FKUamqcoBsU1scGY4kCiYdE4SiC9
	 Pe0jWR53xGaTqACLvTN0AJtkBgtsSbUSJ0J9NhmNMUHAhfUccdeeDAVPWYUp/87WBx9B3
	 WPoMT5zYqBm6q4bPIQuhYE5My0WR0YNOJlSIq2wqZqvxM+ApjUOuZWldYwlmWYEBfGK87
	 wdWaLOuFmnCDdsQRvkJjAdavuHbnzmYNR27DyyZ/ul58lAYL3PxmZsJF3ke+y4llvuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=softbase.tech;
	spf=pass smtp.mailfrom=softbase.tech;
	dkim=pass header.d=softbase.tech header.i=@softbase.tech header.a=rsa-sha256 header.s=protonmail3 header.b=pPiSD5Lc;
	arc=none smtp.remote-ip=185.70.43.172
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6261606A325;
	Sun,  1 Nov 2026 09:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6261606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=softbase.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softbase.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=softbase.tech header.i=@softbase.tech header.a=rsa-sha256 header.s=protonmail3 header.b=pPiSD5Lc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softbase.tech;
	s=protonmail3; t=1793527082; x=1793786282;
	bh=8xnBzjwCE8sPHtEp9RM3ZWkfBVkxawpnG/dVeRbBTaw=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=pPiSD5Lc2qdIFUqqQ0hJX5aWFrXBB/VPR2bUzYhKQ3zX4/qdry12Pu8bAzmBtEYRr
	 iPodWnQatHGVbNigMkL0mcx0JZ93rjajjkywKasIXm5+U/kpWYFOEp2dI2KsR82tbg
	 vFPQ2rjpSBqo1GT8JHQ8G4AMCyRBPqonceDsf/Lz9nEOn9rfE1NVNS103Ofx3odV1r
	 T0QrnAJ9gAlcnBTGUX9N4uf0IZwYZfWN/KPuGuAJQPox07kBBcbADeIdAqCw8V7GvV
	 dsqJmz9GV1r49h/Qhv3abFIz49Volr3TMvesIbTkiPKRPjd+egr0vyon8hD+31gvnF
	 SPFuSl0MsZTKw==
X-Pm-Submission-Id: 4jHVdM62gvz2Scn7
From: "Beat M. Liechti" <beat@softbase.tech>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Federico Amedeo Izzo <federico@izzo.pro>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Beat M. Liechti" <beat@softbase.tech>,
	stable@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: don't reassign resources on color management changes
Date: Sun,  1 Nov 2026 10:57:45 +0100
Message-ID: <20261101095754.33840-1-beat@softbase.tech>
X-Mailer: git-send-email 2.53.0
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

Since commit 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide
GAMMA_LUT DRM property"), dpu_crtc_atomic_check() releases and reserves
the hardware blocks of a CRTC whenever color_mgmt_changed is set, not
only on a modeset. A commit that merely replaces the GAMMA_LUT or CTM
blob of an active CRTC can therefore move that CRTC to a different
CTL/LM pair without disabling and re-enabling the pipeline, and the
hardware keeps scanning out through blocks the driver no longer
considers in use.

This is easy to hit with GNOME/mutter on a laptop driving an external
display: closing the lid disables the eDP CRTC, and in the same atomic
commit mutter sets new color blobs on the still active HDMI CRTC. With
drm.debug enabled, dpu_rm_reserve() moves the HDMI CRTC from CTL_1 to
the just released CTL_0 while its encoder is neither disabled nor
re-enabled. A few seconds later the display SMMU reports context faults
at the refresh rate and the external screen fills with garbage. Opening
the lid again leads to a stream of "vblank timeout" and "frame done
timeout" errors and the machine has to be power cycled.

Color management affects the topology in only one way: DSPP blocks are
requested when either CTM or GAMMA_LUT is set. Handle that case in
dpu_crtc_check_mode_changed() by forcing a full modeset when the
presence of CTM/GAMMA_LUT changes, as msm_atomic_check() already does
for the CTM, and stop reallocating resources on a bare
color_mgmt_changed.

Fixes: 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide GAMMA_LUT DRM property")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Beat M. Liechti <beat@softbase.tech>
---

Notes:
    Testing: ThinkPad T14s Gen 6 (X1E78100), GNOME 50 / mutter on Wayland,
    LG 4K60 monitor on the HDMI port (DP to HDMI bridge), logind set to not
    suspend on lid close while on external power. Without this patch every
    lid close reproduces the corruption and hang described above. With it,
    closing and opening the lid produces no SMMU faults, vblank timeouts or
    frame done timeouts, and both displays keep working.
    
    That testing was done on a v7.0.14 based distribution kernel (Ubuntu
    7.0.0-42.42). On msm-next the patch has only been compile tested (W=1,
    no new warnings), not run.
    
    Open questions:
    - Like the existing CTM check in msm_atomic_check() (see the FIXME
      there), this sets allow_modeset on behalf of userspace when the DSPP
      requirement changes. Rejecting such commits without
      DRM_MODE_ATOMIC_ALLOW_MODESET would be stricter, but could break
      compositors that toggle GAMMA_LUT at runtime (night light). I am happy
      to change it either way.
    - The RFC "drm/msm/dpu: Force modeset if new CTLs have been reserved"
      (https://lists.freedesktop.org/archives/freedreno/2025-March/036824.html)
      addresses reassignment without a modeset in general. This patch only
      removes the color management trigger.
    
    The root cause analysis of the drm.debug trace, the fix and the
    changelog were developed with an AI coding assistant (Claude by
    Anthropic). I reviewed the change and tested it on the hardware above.

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 26 +++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 42d0a529b..3b304a896 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1516,6 +1516,20 @@ int dpu_crtc_check_mode_changed(struct drm_crtc_state *old_crtc_state,
 	    (!clone_mode_requested && clone_mode_enabled))
 		new_crtc_state->mode_changed = true;
 
+	/*
+	 * DSPP blocks are reserved only when CTM or GAMMA_LUT is set (see
+	 * dpu_crtc_get_topology()), so enabling or disabling color management
+	 * changes the hardware topology. Changing resources on an active CRTC
+	 * requires a full modeset; otherwise the CTL/LM blocks get swapped
+	 * underneath a running pipeline.
+	 */
+	if (new_crtc_state->enable &&
+	    (!!(old_crtc_state->ctm || old_crtc_state->gamma_lut) !=
+	     !!(new_crtc_state->ctm || new_crtc_state->gamma_lut))) {
+		new_crtc_state->mode_changed = true;
+		new_crtc_state->state->allow_modeset = true;
+	}
+
 	return 0;
 }
 
@@ -1534,9 +1548,15 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 
 	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
 
-	/* don't reallocate resources if only ACTIVE has beeen changed */
-	if (crtc_state->mode_changed || crtc_state->connectors_changed ||
-	    crtc_state->color_mgmt_changed) {
+	/*
+	 * Don't reallocate resources if only ACTIVE or color management
+	 * values have changed. A change in DSPP requirements is turned into a
+	 * modeset by dpu_crtc_check_mode_changed(). Reallocating on a plain
+	 * color_mgmt_changed would move an active CRTC to different CTL/LM
+	 * blocks without a modeset, leaving the hardware scanning out through
+	 * stale CTL/LM state (SMMU faults, corrupted output, vblank timeouts).
+	 */
+	if (crtc_state->mode_changed || crtc_state->connectors_changed) {
 		rc = dpu_crtc_assign_resources(crtc, crtc_state);
 		if (rc < 0)
 			return rc;
-- 
2.53.0

