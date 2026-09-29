Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55713A1E80
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710225; cv=none; b=hStNkGUuSxiAq94LeyEUnPEFIZA4i6uE4zi2Nx+bkqRxkUbyGDQR3fuTG5xVAeA8xPr5yE8MsQbKe8ti6rAXpttDNTlXbm4aN6+ANl2z3VtzQt2fK2TFLqLyEyzOGHzxTjIurwpwwRjh+SNOUwR4mcn8DNOCg7l4vlFqtOKDXEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710225; c=relaxed/simple;
	bh=19o8g0ByFxsRnIlOLaT8uFqxlT67sp23nG+O+ptkN4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4/ozAxi+mndMrHEKldvZvLLU/RIs+1jS5AIezjVt0kIzD4He65qUeonZTRuioQOGmSJfHazJLXX30qcS8gq+pgs30fof9nt8CgTMj8gDwN2mPtnxUEfYfzlH0XSIKsd56mFc1ZZkbGZhM1v5705sPWRS7EE9hJBt//vfvRzVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0nuJ+kv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0nuJ+kv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D571F000FF;
	Tue, 29 Sep 2026 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710223;
	bh=05HUWQr/QgLTdQbWuKSOGQbrN6+ojXx4E0N4btnvXtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0nuJ+kviHhCUccMTGzjLGZry/Rp0hD5qKEV5exXFjaS32TsA4BWC7zjZJ146ZPhF
	 hQ/KEeP7/lI1Jw3WliNd6MQczAIZXjrbIU8Ch5Y1QNu3ccIM+B9dv8WJuBdbk6YPqA
	 c7074MrQxpx9Z6rXlDDemWCFdNdBwbZJfIJA6+TdgHA9/egdlcYNPidtkFl2L+R7pV
	 Vhylk2EQZUC/QEHTBRHnro76uNvyZlzzyf690C9/+5ahcGCTjG6CZlnsTCHnHONIep
	 k3+EsPJg0CZ1juOFSretOHkMq1I+/RV4To3fiFnaGm27uCMtn8G7UcxIRMcg25h0T9
	 Y/tTqVUziBcoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/i915/dp_mst: Fix configuring TUs for a disconnected stream
Date: Tue, 29 Sep 2026 15:30:21 -0400
Message-ID: <20260929193021.823447-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092957-hardening-slingshot-e073@gregkh>
References: <2026092957-hardening-slingshot-e073@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit a443e0b8d647c1401b110d9f919d8c6cb8607260 ]

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
(cherry picked from commit ee00f8fbb2b202002ab90834e02e9ba372773a36)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
[ adapted MST field accesses to `mst_port` and `mst_mgr`, reusing a local `crtc` lookup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c  | 21 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp_mst.h  |  2 ++
 drivers/gpu/drm/i915/display/intel_link_bw.c |  7 ++++---
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index eeaedd979354b..eb0ee759569c3 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -2053,6 +2053,27 @@ bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
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
+	if (!connector->mst_port)
+		return false;
+
+	if (!connector->mst_port->mst_mgr.mst_state)
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
index 8343804ce3f8d..261a97e24d91e 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.h
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.h
@@ -27,6 +27,8 @@ int intel_dp_mst_atomic_check_link(struct intel_atomic_state *state,
 				   struct intel_link_bw_limits *limits);
 bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
 				     struct intel_crtc *crtc);
+bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
+				      const struct intel_crtc *crtc);
 void intel_dp_mst_prepare_probe(struct intel_dp *intel_dp);
 bool intel_dp_mst_verify_dpcd_state(struct intel_dp *intel_dp);
 
diff --git a/drivers/gpu/drm/i915/display/intel_link_bw.c b/drivers/gpu/drm/i915/display/intel_link_bw.c
index e7a9b860fac6e..da4f0186311ba 100644
--- a/drivers/gpu/drm/i915/display/intel_link_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_link_bw.c
@@ -32,11 +32,12 @@ void intel_link_bw_init_limits(struct intel_atomic_state *state,
 	limits->force_fec_pipes = 0;
 	limits->bpp_limit_reached_pipes = 0;
 	for_each_pipe(display, pipe) {
+		struct intel_crtc *crtc = intel_crtc_for_pipe(i915, pipe);
 		const struct intel_crtc_state *crtc_state =
-			intel_atomic_get_new_crtc_state(state,
-							intel_crtc_for_pipe(i915, pipe));
+			intel_atomic_get_new_crtc_state(state, crtc);
 
-		if (state->base.duplicated && crtc_state) {
+		if ((state->base.duplicated && crtc_state) ||
+		    intel_dp_mst_stream_disconnected(state, crtc)) {
 			limits->max_bpp_x16[pipe] = crtc_state->max_link_bpp_x16;
 			if (crtc_state->fec_enable)
 				limits->force_fec_pipes |= BIT(pipe);
-- 
2.53.0

