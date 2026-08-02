Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7F17557E
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785638002; cv=none; b=G8qmgnxNMJ7hIEM6/xlHNWKIdagQYt5isoC3TeXXuFKdoHJXSWg+1afsjz9wqYJ9r6CEs4CxEjLzkBrVRcQLWn5qPpnTZPYyDO+g/+m8mI7B//E8hdMxtTl0n5ozLVznUbtqI6ZXumZQHdQTCyGS0ie0fpaYV/yr6NSBuq2ZCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785638002; c=relaxed/simple;
	bh=Wprza5eq+gyapQfIDJ5T2X9vd1yznJxhpo9RLbuVgHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVDr4hjP1DtbryjHd3oPPiNLkJHji64Ibrgj6+993GzKt3MgGFFgFsHqKG4xfNQZlBPeJJFotDLMNgeXeHBHwt4eNTyUTCFey2EBNCzFnGT+XQxKklCVyGKwN0EnsEuzMKI2j/HkscbMXYd/vVJrT1fOkg5ox37c303P70YpPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNjtb2KC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNjtb2KC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25B71F00ACF;
	Sun,  2 Aug 2026 02:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785638001;
	bh=X9NxTWcmkd900DPZnWMyTKriUTJQ2HDWbZejTpzubS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HNjtb2KCDe9sbyOMUIYph9h8JFypkJH5ifGldnPDpt0v0fNXrefSc/hxI7naTFO6J
	 wYGcY3Pw22GCZBzUIAJ3JuFuNgS5VAFJaE6BOSAsFLmsinpz5aL83q0jWvw02Irbyg
	 0iDe+/en6ZCJpPjgqzlFFXgbeFwT+YAZgmlDaQx0OaMiafLSnf34gSwxRWLqeTHJwy
	 uN6uUXnLoGO7WHc2lJhL9qKSYbuMf1aZWXsaRqG93D934UW2FNfQcbP1lmpIJQnsAM
	 vnxgJbFLaEIwGk176Kp+tFnGgJZt8zUOcK/4opysdr1OYMDi3QQmOIb9OrczbEYMhC
	 vlXTPfQMmkPUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Suraj Kandpal <suraj.kandpal@intel.com>,
	Santhosh Reddy Guddati <santhosh.reddy.guddati@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] drm/i915/hdcp: Skip inactive MST connectors when building stream list
Date: Sat,  1 Aug 2026 22:33:16 -0400
Message-ID: <20260802023317.1298318-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802023317.1298318-1-sashal@kernel.org>
References: <2026072916-pelican-detract-661d@gregkh>
 <20260802023317.1298318-1-sashal@kernel.org>
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
 drivers/gpu/drm/i915/display/intel_hdcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index 565880d3a558..8dff524933a5 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -97,6 +97,7 @@ intel_hdcp_required_content_stream(struct intel_atomic_state *state,
 {
 	struct intel_display *display = to_intel_display(state);
 	struct drm_connector_list_iter conn_iter;
+	struct drm_connector_state *new_conn_state;
 	struct intel_digital_port *conn_dig_port;
 	struct intel_connector *connector;
 	struct hdcp_port_data *data = &dig_port->hdcp_port_data;
@@ -123,6 +124,11 @@ intel_hdcp_required_content_stream(struct intel_atomic_state *state,
 		if (conn_dig_port != dig_port)
 			continue;
 
+		new_conn_state = drm_atomic_get_new_connector_state(&state->base,
+								    &connector->base);
+		if (!new_conn_state || !new_conn_state->crtc)
+			continue;
+
 		data->streams[data->k].stream_id =
 			intel_conn_to_vcpi(state, connector);
 		data->k++;
-- 
2.53.0

