Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0236B05E;
	Fri, 26 Jun 2026 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782501233; cv=none; b=Ts4uKngrAISEOR7Ms3S5Y3BXKDLIl7T8YyRdA18hfHaaxoNdQnUPmAPfJojOxASboreU4gEyFNS297vqqvLYc6d2cfrB/JZUIgcmRAD3BHb3LOizuFybYRuVo22L/9TAutuRiTEyqPFxPVn3gJd6lYJashiMS39lWHKe/mIH94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782501233; c=relaxed/simple;
	bh=JlC+TRGJIZL8ljFJ21ScvQFLhWMH7gX475BoHYb8aN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvnaXPl75KLD4FI8+w4xMeq8qPLVLoPY6NcPM6LitEzffrSPamvXf2MB98tAzdDlUb5TNpQb0bLCu0jFm6dieP5fmx17mEhlyJ7/V2DRFNh+HLpSkoCe4Joaz23sumy1xi5blrfgPCPAmwXASouFktFwvJmUUUs8AJ8JL0cW1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=V3Yc3L7o; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="V3Yc3L7o"
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:1743:0:640:287f:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id D03C8C005D;
	Fri, 26 Jun 2026 22:13:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (smtp) with ESMTPSA id VDgZvirmX8c0-CwsHMUqk;
	Fri, 26 Jun 2026 22:13:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1782501219; bh=jNeglCViEBka8yVtR4z5raXj3iuBh/ECJABlpgTpemQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=V3Yc3L7oLn1exA8LeYfoQtfnj8/pVwN991YkA4uX0bX/F4bCEtKyyEWA8yZ1Xig8U
	 IoHAfosCeg281DD+G8MtnSgQntE1iWpso+GSozZ91pxSPZbsrH8kUolwUZ6p7ANXLX
	 6ELXikKk032hyzfftzeWqSnzUmgWenfzGRpDshOI=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	mario.limonciello@amd.com,
	alex.hung@amd.com,
	superm1@kernel.org,
	timur.kristof@gmail.com,
	ivan.lipski@amd.com,
	ray.wu@amd.com,
	aurabindo.pillai@amd.com,
	chen-yu.chen@amd.com,
	mripard@kernel.org,
	Dillon.Varone@amd.com,
	mwen@igalia.com,
	chiahsuan.chung@amd.com,
	kenneth.feng@amd.com,
	srinivasan.shanmugam@amd.com,
	tzimmermann@suse.de,
	Alvin.Lee2@amd.com,
	dmitry.baryshkov@oss.qualcomm.com,
	chaitanya.kumar.borah@intel.com,
	ekurzinger@gmail.com,
	pierre-eric.pelloux-prayer@amd.com,
	HaoPing.Liu@amd.com,
	Tony.Cheng@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v3] drm/amd/display: Fix dangling pointers in state reset functions on allocation failure
Date: Fri, 26 Jun 2026 22:13:03 +0300
Message-ID: <20260626191314.29933-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple reset functions in amdgpu_dm free the old state before allocating
a new one. If kzalloc_obj() fails, the function returns without updating
the state pointer, leaving a dangling pointer to already freed memory.

Fix this by allocating the new state first. In case of allocation failure,
the old state remains untouched and the function safely returns, preserving
the existing state.

For amdgpu_dm_connector_funcs_reset(), additionally restore the explicit
kfree(old_state) which was lost when the function was refactored, as
__drm_atomic_helper_connector_destroy_state() only frees resources but not
the state structure itself.

This affects three functions:
- amdgpu_dm_plane_drm_plane_reset()
- amdgpu_dm_crtc_reset_state()
- amdgpu_dm_connector_funcs_reset()

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5d945cbcd4b1 ("drm/amd/display: Create a file dedicated to planes")
Fixes: 473683a03495 ("drm/amd/display: Create a file dedicated for CRTC")
Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_types and amdgpu_dm")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
Changes in v3:
- Restore explicit kfree(old_state) in amdgpu_dm_connector_funcs_reset()
  to prevent memory leak (reviewer Mario Limonciello <mario.limonciello@amd.com>)

Changes in v2:
- Also fix amdgpu_dm_crtc_reset_state() and amdgpu_dm_connector_funcs_reset()
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 46 +++++++++++--------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  8 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 14 +++---
 3 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 97ab1e83b318..8829e884167b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8151,33 +8151,41 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 
 void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 {
-	struct dm_connector_state *state =
+	/* Remember the old state */
+	struct dm_connector_state *old_state =
 		to_dm_connector_state(connector->state);
 
+	struct dm_connector_state *state;
+
+	/* Allocate new state */
+	state = kzalloc_obj(*state);
+	if (WARN_ON(!state))
+		return;
+
+	/* Release resources owned by the previous state and free memory */
 	if (connector->state)
 		__drm_atomic_helper_connector_destroy_state(connector->state);
 
-	kfree(state);
+	kfree(old_state);
 
-	state = kzalloc_obj(*state);
+	/* Install and initialize the new DRM connector state */
+	__drm_atomic_helper_connector_reset(connector, &state->base);
 
-	if (state) {
-		state->scaling = RMX_OFF;
-		state->underscan_enable = false;
-		state->underscan_hborder = 0;
-		state->underscan_vborder = 0;
-		state->base.max_requested_bpc = 8;
-		state->vcpi_slots = 0;
-		state->pbn = 0;
-
-		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
-			if (amdgpu_dm_abm_level <= 0)
-				state->abm_level = ABM_LEVEL_IMMEDIATE_DISABLE;
-			else
-				state->abm_level = amdgpu_dm_abm_level;
-		}
+	/* Initialize AMD-specific connector state */
+	state->scaling = RMX_OFF;
+	state->underscan_enable = false;
+	state->underscan_hborder = 0;
+	state->underscan_vborder = 0;
+	state->base.max_requested_bpc = 8;
+	state->vcpi_slots = 0;
+	state->pbn = 0;
 
-		__drm_atomic_helper_connector_reset(connector, &state->base);
+	/* Initialize eDP-specific defaults */
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+		if (amdgpu_dm_abm_level <= 0)
+			state->abm_level = ABM_LEVEL_IMMEDIATE_DISABLE;
+		else
+			state->abm_level = amdgpu_dm_abm_level;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 3dcedaa67ed8..6146fbc528c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -437,13 +437,15 @@ static void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state;
 
-	if (crtc->state)
-		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
-
+	/* Allocate new state first */
 	state = kzalloc_obj(*state);
 	if (WARN_ON(!state))
 		return;
 
+	/* Destroy old state only after successful allocation */
+	if (crtc->state)
+		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
+
 	__drm_atomic_helper_crtc_reset(crtc, &state->base);
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index e957657b06c7..eb1c0a26f20d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1488,17 +1488,17 @@ static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
 
 static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
 {
-	struct dm_plane_state *amdgpu_state = NULL;
-
-	if (plane->state)
-		plane->funcs->atomic_destroy_state(plane, plane->state);
+	struct dm_plane_state *amdgpu_state;
 
+	/* Allocate new state first */
 	amdgpu_state = kzalloc_obj(*amdgpu_state);
-	WARN_ON(amdgpu_state == NULL);
-
-	if (!amdgpu_state)
+	if (WARN_ON(!amdgpu_state))
 		return;
 
+	/* Destroy old state only after successful allocation */
+	if (plane->state)
+		plane->funcs->atomic_destroy_state(plane, plane->state);
+
 	__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
 	amdgpu_state->degamma_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
 	amdgpu_state->hdr_mult = AMDGPU_HDR_MULT_DEFAULT;
-- 
2.43.0

