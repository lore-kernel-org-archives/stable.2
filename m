Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D4340A76
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788824; cv=none; b=pdQ9UE6t+KBC8Zc2XQem4rSLyW8Ce44f5aaRrtGrgu41u93IiyI89xU4BZsfvZPBZDxgB2KDDRXUC9CNeKA5sCQjEuwIFkGxjxF+9PmprqpFcoT9zH+DxYTXo0fjvz5e1jql/UUdPTS5z+n/wSbRUVnxDDaZrXQX6nA48kBgdMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788824; c=relaxed/simple;
	bh=P255w0JQaVdNF5MW/P9LjBA5Z+lfy8fiR3qnR7mdm9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9XlNU7uRcWxanIcxzUh9NA3GqoKnW18lhmcCX2u5yZtIZHOLudbmwYB79fU5eu1ebXnPGetieNYOcWKandCrJpnxWsy83KUBwTL2MC1QVyJGZg7zIOcUh04GrgCq9gqNZCbTiclR11eQrGszK1q2r4aT2CeCkcXy1Aa16VOvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNxJaw4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNxJaw4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE14D1F00A3A;
	Mon,  3 Aug 2026 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785788822;
	bh=MU3DsyKj8fjuEa7H6o/m0IPNXnQMl9rBw6Na/MTz2D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iNxJaw4aLU5MTsgXqKnH5rHddCRn7ure20BsgdotOeEM5cWx2KF7a0M/jn4O95lFP
	 OtdxxlcBPrO1ekJc1h6DiNMhMMdAeITKJmyMLzD0K/R3/Ry6M6VrVdEoJNwye7xyFF
	 jXwNaHU4fnncpX4kpcyB5/oh76nvHiMy1j/sW6k1jvcVb/ml3kKfpXxuUBSacqdMfi
	 Ty/tY84um1jzP0+7SQwb3VkKYyXDAFLv1oUjq04FQmXgm4U88FBJVA5EDtKo3aJEjq
	 sN7adLae2HyyGhgV2KpujxhxRLR3CFnGNQ1KUYgN+6pIxk9b5/3xU2MOMigXE22/xF
	 fMe8AD4dbTfHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Suraj Kandpal <suraj.kandpal@intel.com>,
	Santhosh Reddy Guddati <santhosh.reddy.guddati@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] drm/i915/hdcp: Skip inactive MST connectors when building stream list
Date: Mon,  3 Aug 2026 16:26:57 -0400
Message-ID: <20260803202658.1647132-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803202658.1647132-1-sashal@kernel.org>
References: <2026072917-dugout-sufferer-eb18@gregkh>
 <20260803202658.1647132-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suraj Kandpal <suraj.kandpal@intel.com>

[ Upstream commit 0161e2c2016337a2f22ef79dff0aee43c0841bce ]

intel_hdcp_required_content_stream() walks every connector on the
digital port to populate hdcp_port_data->streams[]. The only filter is
connector_status_disconnected, which reflects physical presence on the
MST topology, not whether the connector currently drives a stream.
On a multi-sink MST setup where only a subset of sinks are modeset,
the loop can pick a sibling MST connector that is connected but has
no active CRTC / VC payload. intel_conn_to_vcpi() then logs "MST
Payload not present" and returns 0, and the bogus StreamID=0 is
written to the repeater in RepeaterAuth_Stream_Manage (DPCD 0x693F0).
Authentication completes, but the repeater shortly raises
LINK_INTEGRITY_FAILURE (RxStatus 0x69493 bit4) because the StreamID
does not match any stream on its input. The HDCP check work then
tears the link down, the Content Protection property drops back to
DESIRED, and userspace observes a spurious HDCP enable failure.
Filter the connector iteration to only those with a CRTC assigned in
the new atomic state, so intel_conn_to_vcpi() is called for the
connector actually being enabled and reads its real VCPI from the MST
topology state.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Santhosh Reddy Guddati <santhosh.reddy.guddati@intel.com>
Link: https://patch.msgid.link/20260505094022.4064256-1-suraj.kandpal@intel.com
Stable-dep-of: bbb15a6b042d ("drm/i915/hdcp: check streams[] bounds before overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_hdcp.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index 0ba324ec60d32..15b28d056687f 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -30,7 +30,7 @@
 #define KEY_LOAD_TRIES	5
 #define HDCP2_LC_RETRY_CNT			3
 
-static int intel_conn_to_vcpi(struct drm_atomic_state *state,
+static int intel_conn_to_vcpi(struct intel_atomic_state *state,
 			      struct intel_connector *connector)
 {
 	struct drm_dp_mst_topology_mgr *mgr;
@@ -43,7 +43,7 @@ static int intel_conn_to_vcpi(struct drm_atomic_state *state,
 		return 0;
 	mgr = connector->port->mgr;
 
-	drm_modeset_lock(&mgr->base.lock, state->acquire_ctx);
+	drm_modeset_lock(&mgr->base.lock, state->base.acquire_ctx);
 	mst_state = to_drm_dp_mst_topology_state(mgr->base.state);
 	payload = drm_atomic_get_mst_payload_state(mst_state, connector->port);
 	if (drm_WARN_ON(mgr->dev, !payload))
@@ -2111,8 +2111,7 @@ static void intel_hdcp_check_work(struct work_struct *work)
 static int i915_hdcp_component_bind(struct device *drv_kdev,
 				    struct device *mei_kdev, void *data)
 {
-	struct intel_display *display = to_intel_display(drv_kdev);
-	struct drm_i915_private *i915 = to_i915(display->drm);
+	struct drm_i915_private *i915 = kdev_to_i915(drv_kdev);
 
 	drm_dbg(&i915->drm, "I915 HDCP comp bind\n");
 	mutex_lock(&i915->display.hdcp.hdcp_mutex);
@@ -2126,8 +2125,7 @@ static int i915_hdcp_component_bind(struct device *drv_kdev,
 static void i915_hdcp_component_unbind(struct device *drv_kdev,
 				       struct device *mei_kdev, void *data)
 {
-	struct intel_display *display = to_intel_display(drv_kdev);
-	struct drm_i915_private *i915 = to_i915(display->drm);
+	struct drm_i915_private *i915 = kdev_to_i915(drv_kdev);
 
 	drm_dbg(&i915->drm, "I915 HDCP comp unbind\n");
 	mutex_lock(&i915->display.hdcp.hdcp_mutex);
@@ -2297,6 +2295,7 @@ intel_hdcp_set_streams(struct intel_digital_port *dig_port,
 		       struct intel_atomic_state *state)
 {
 	struct drm_connector_list_iter conn_iter;
+	struct drm_connector_state *new_conn_state;
 	struct intel_digital_port *conn_dig_port;
 	struct intel_connector *connector;
 	struct drm_i915_private *i915 = to_i915(dig_port->base.base.dev);
@@ -2322,8 +2321,13 @@ intel_hdcp_set_streams(struct intel_digital_port *dig_port,
 		if (conn_dig_port != dig_port)
 			continue;
 
+		new_conn_state = drm_atomic_get_new_connector_state(&state->base,
+								    &connector->base);
+		if (!new_conn_state || !new_conn_state->crtc)
+			continue;
+
 		data->streams[data->k].stream_id =
-			intel_conn_to_vcpi(&state->base, connector);
+			intel_conn_to_vcpi(state, connector);
 		data->k++;
 
 		/* if there is only one active stream */
-- 
2.53.0

