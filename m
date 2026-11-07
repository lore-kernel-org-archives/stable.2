Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048123;
	b=hhXb4iZhHLlRp0toUV5smc+UD7N/ZKwOjP/X1nwEf4skng2Gjj2QCQl8mfs+OD+C4Fo1
	 mZOSuojpZLR4wnhQV4AYvOCRsALDyoz0nxkhOhHQUk/hsW9FfAH6p9CFGNu0fIdW5VKVI
	 Dj95lkoUPjR2PjWiNVj7DW47q8BYNlUeox4w1FOULDkV3sp17RUTb+dPjgCezE5wThvZ0
	 Ak7s0lQpCVGKp1rIYsOCmakfFFCSKI6EF2KUiRk9GSxPnIV/ATWuTTe05z8bquw2LZZZw
	 on0VNuDfyCZhuPcwgziElYMoXc5/kms+ckVmkihlL3P7rHvyr6NmWy+QG7bWzgT+lsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048123;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YGKi2pshvUIDbcUgefkBfPBzAaa4neO42Kue5DYKiL0=;
	b=ETCZgyV4VEpQYBSmOL3ozmy1qlyL9EhwHR6YgesOMEYvMvy5MjKSNwPa6zJv8QpvngWW
	 xyfL6gPaz0FcRQcA4ddGmMdFXv4vYpGBKiE5FRiO2JYbmC3HhCz/No3DjtrVZZ0a27ii3
	 7iU2O9DjJTxNkxeVfi8nfBpqtfQf9Of95cXInkz/39vCSHgZJT0gEM6RfH3un8lAsiRR/
	 g3Aj+y2gDl0aVR/D2e69cExdr73BDcY8pTNlqGAjjW5TZL/WAkpDmHZkPXJPZQ9QpbYH2
	 zgzqdjAXaMC5L+J74aRR4JgaIsjDY831A98x5aj5m7tDTgx9lf6jxaoj8uFpa0rSNww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S76cRPrG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15476606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S76cRPrG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FEE1F0089F;
	Sat,  7 Nov 2026 10:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048122;
	bh=YGKi2pshvUIDbcUgefkBfPBzAaa4neO42Kue5DYKiL0=;
	h=From:To:Cc:Subject:Date;
	b=S76cRPrG+rYlA54mBmeIkmii5h4MX1Huv4Ur+2asGBs2UtlN70mO1b53vlsK56322
	 KMtrgRQ7bFM37CRoeHjxOLzGulKa8/mKJF36LM7QUcAGPMs0U266PypXWZP+Ov/n6i
	 1Y4gIeMNQzk6h1oNJ3GpWmZ3hDpdGY1lu5SQfr7TXn5uW8UZ/R6qFzFDbS4dzXvZFE
	 XhfIQnozX/U+zI7rH+gvGIFWPAX+b5kFUjQtSfwAee0Lia02M1/C8/jfIjpGx0kg3b
	 oGhHuL5S9md5ASKfP96tUg2DrU6rhRAOducjVR9aTUaTA/RmB/nZowbUvfYfCG44d5
	 PpMrUU/p3TEpQ==
From: Sasha Levin <sashal@kernel.org>
To: imre.deak@intel.com,
	luciano.coelho@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/dp_mst: Fix configuring TUs for a disconnected stream" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:01 -0500
Message-ID: <20261107054201-failed-6.1-ee00f8fbb2b2@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ee00f8fbb2b202002ab90834e02e9ba372773a36
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054201-failed-6.1-ee00f8fbb2b2@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ee00f8fbb2b202002ab90834e02e9ba372773a36 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Mon, 7 Sep 2026 20:44:13 +0300
Subject: [PATCH] drm/i915/dp_mst: Fix configuring TUs for a disconnected
 stream

During an atomic commit after all the MST stream CRTC state is computed
the driver ensures that the sum of TUs of all the streams on a given MST
topology link is within limits (63 for 8b10 and 64 for 128b132b). For a
disconnected stream the DRM MST core's BW verification doesn't ensure
this, because the topology state it uses for this is destroyed as soon
as the stream (i.e. MST connector/port) is disconnected. The driver
should keep the link state valid even for such disconnected streams, as
userspace may disable them one-by-one only in a deferred way. Ensure the
link's sum of TUs stays within limits in this case by simply reusing the
maximum link BPP limit from the stream's (i.e. CRTC's) old state.

The disconnection can happen either via the whole topology getting
disconnected or via only the given stream's port getting disconnected.
Check for both of these conditions separately, as a connector gets
unregistered after a link disconnect event only in a deferred way.

Cc: stable@vger.kernel.org # v6.10+
Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16073
Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16384
Reviewed-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patch.msgid.link/20260907174413.741851-2-imre.deak@intel.com
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c  | 21 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp_mst.h  |  2 ++
 drivers/gpu/drm/i915/display/intel_link_bw.c |  3 ++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 20766b6c0bcfa..0c362784afe4a 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -2172,6 +2172,27 @@ bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
 	return false;
 }
 
+bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
+				      const struct intel_crtc *crtc)
+{
+	struct intel_connector *connector;
+
+	connector = get_connector_in_state_for_crtc(state, crtc);
+	if (!connector)
+		return false;
+
+	if (!connector->mst.dp)
+		return false;
+
+	if (!connector->mst.dp->mst.mgr.mst_state)
+		return true;
+
+	if (drm_connector_is_unregistered(&connector->base))
+		return true;
+
+	return false;
+}
+
 /**
  * intel_dp_mst_prepare_probe - Prepare an MST link for topology probing
  * @intel_dp: DP port object
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.h b/drivers/gpu/drm/i915/display/intel_dp_mst.h
index ab09b487c6bb5..8ce89242c05c9 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.h
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.h
@@ -28,6 +28,8 @@ int intel_dp_mst_atomic_check_link(struct intel_atomic_state *state,
 				   struct intel_link_bw_limits *limits);
 bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
 				     struct intel_crtc *crtc);
+bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
+				      const struct intel_crtc *crtc);
 void intel_dp_mst_prepare_probe(struct intel_dp *intel_dp);
 bool intel_dp_mst_verify_dpcd_state(struct intel_dp *intel_dp);
 
diff --git a/drivers/gpu/drm/i915/display/intel_link_bw.c b/drivers/gpu/drm/i915/display/intel_link_bw.c
index b47474a3e9fec..e71e76d6fd3e0 100644
--- a/drivers/gpu/drm/i915/display/intel_link_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_link_bw.c
@@ -64,7 +64,8 @@ void intel_link_bw_init_limits(struct intel_atomic_state *state,
 			intel_atomic_get_new_crtc_state(state, crtc);
 		int forced_bpp_x16 = get_forced_link_bpp_x16(state, crtc);
 
-		if (state->base.duplicated && crtc_state) {
+		if ((state->base.duplicated && crtc_state) ||
+		    intel_dp_mst_stream_disconnected(state, crtc)) {
 			limits->max_bpp_x16[pipe] = crtc_state->max_link_bpp_x16;
 			if (intel_dsc_enabled_on_link(crtc_state))
 				limits->link_dsc_pipes |= BIT(pipe);
-- 
2.53.0




