Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB63DCD83
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696556; cv=none; b=kYT3Ul4of4YeL78NlGyzpgQwKOi7wAcpxMciE6eAJV0MC24ahAAZpp9ZAgZwnXp6a0gGHN75sNbeezsChkgiZrbkzNRUIpDT8k2XCVIOrGi7hI/XDgEB9DWM186WkBQyBv+zWpEMS4sdegAoF3AJFmJRY/lQC15vgU3CbEAOrcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696556; c=relaxed/simple;
	bh=vQYC7vUzBjRq20XZwRXQqFIFdwHBF+Qb6ogg+4X5u9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uxg4gR2wtmBHbNG8O9b09+0JYqNMMS3L94gsmykYP9XNVf/m2e/4qr1PGo/Qj3lPyzpzKcXYJZxl7usWAK/8foKoklDvoQjPHaop2H7D6vnPFSyP0C1pfJNHWQf+PhhWeb2qypRp08ogQ/dqmDQZ76dtHOSiCLpCGo/JdT9u0pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu0GhvrO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu0GhvrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C33E1F000FF;
	Tue, 29 Sep 2026 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790696553;
	bh=XYl0YGdw2ePVwaGyiWVKlo1EHJMJo+gktL3mn8iY9xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bu0GhvrOOHOKJRr7ADFqImeI/o2DbXFff0yS+dsBel7dj+QIb1BaBc4gpPC1Wty40
	 nQLmvJ3W6XgM4MAhhY/9GqPEq4iFs/m7YV02jv8ZhPFx2aAaYh7llkgxCmqHAQ+6mN
	 hVSRU3+tzSTVK9l/0Gf9ZQtpeiuSbuKuBfEVqAYg1ibNUngAXz/AUDDE5M6rIy8kLx
	 IXtRHoyxzl+DxBSZ4M+mR3TibhpCpAPrPuixD5nsbHwIWVO8l+C0S5VQycjsLbXBZ9
	 Ya3nRWHteClz95kmrI3F0ZG63J/gXP5MmO5qxEHCWOP+oGALGXR1+++zy8/RyYoCSf
	 FJZivy2kdabKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] drm/amd/display: Whitespace cleanup
Date: Tue, 29 Sep 2026 11:42:30 -0400
Message-ID: <20260929154231.4087621-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092929-evade-cling-0497@gregkh>
References: <2026092929-evade-cling-0497@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 3335a13535312c9fad4d8d1307a621e6617d6ed8 ]

Commit 075e2099c32c ("drm/amd/display: Fix race condition in DPIA AUX
transfer") was backported to stable, which I noticed because of git
saying

	linux-6.1/.git/rebase-apply/patch:37154: space before tab in indent.

while applying patch-6.1.21. While fixing the code location that issued
that warning, improve in few more places.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Backport dependency adaptation for Linux 6.1:
Keep the writeback-connector guard from 87de0a741ef6 while moving the
notify label to column zero; dropping the guard would undo the existing
writeback memory-safety fix.

Also clear new_stream after releasing its extra reference at skip_modeset.
The parent of target c5fd4eaad50d620c7e09ac2082b2fb55ee54170e already
contains this assignment and the target patch requires it as context.
The stable tree lacks it. Clearing the local pointer also prevents the
later color-management failure path from releasing the reference owned
by dm_new_crtc_state->stream. Retain the other whitespace cleanups; no
functions are added.

Stable-dep-of: c5fd4eaad50d ("drm/amd/display: Fix dc stream excess put in dm_update_crtc_state()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bb5e3a6086f2e..b3ee95aa5af0b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2336,9 +2336,9 @@ static int dm_late_init(void *handle)
 	 */
 	params.min_abm_backlight = 0x28F;
 	/* In the case where abm is implemented on dmcub,
-	* dmcu object will be null.
-	* ABM 2.4 and up are implemented on dmcub.
-	*/
+	 * dmcu object will be null.
+	 * ABM 2.4 and up are implemented on dmcub.
+	 */
 	if (dmcu) {
 		if (!dmcu_load_iram(dmcu, params))
 			return -EINVAL;
@@ -7077,13 +7077,13 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 	/* Standard FPS values
 	 *
 	 * 23.976       - TV/NTSC
-	 * 24 	        - Cinema
-	 * 25 	        - TV/PAL
+	 * 24           - Cinema
+	 * 25           - TV/PAL
 	 * 29.97        - TV/NTSC
-	 * 30 	        - TV/NTSC
-	 * 48 	        - Cinema HFR
-	 * 50 	        - TV/PAL
-	 * 60 	        - Commonly used
+	 * 30           - TV/NTSC
+	 * 48           - Cinema HFR
+	 * 50           - TV/PAL
+	 * 60           - Commonly used
 	 * 48,72,96,120 - Multiples of 24
 	 */
 	static const u32 common_rates[] = {
@@ -7709,7 +7709,7 @@ static void update_freesync_state_on_stream(
 		return;
 
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-        vrr_params = acrtc->dm_irq_params.vrr_params;
+	vrr_params = acrtc->dm_irq_params.vrr_params;
 
 	if (surface) {
 		mod_freesync_handle_preflip(
@@ -8264,7 +8264,7 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,
 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
 			continue;
 
-	notify:
+notify:
 		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 			continue;
 
@@ -9292,7 +9292,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 skip_modeset:
 	/* Release extra reference */
 	if (new_stream)
-		 dc_stream_release(new_stream);
+		dc_stream_release(new_stream);
+	new_stream = NULL;
 
 	/*
 	 * We want to do dc stream updates that do not require a
@@ -10687,7 +10688,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 	if (!dc_process_dmub_aux_transfer_async(ctx->dc, link_index, payload)) {
 		*operation_result = AUX_RET_ERROR_ENGINE_ACQUIRE;
 		goto out;
- 	}
+	}
 
 	if (!wait_for_completion_timeout(&adev->dm.dmub_aux_transfer_done, 10 * HZ)) {
 		DRM_ERROR("wait_for_completion_timeout timeout!");
-- 
2.53.0

