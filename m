Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77C3A6B76
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788815; cv=none; b=B6vObpwqLbvrn/DOJfMY0/xMwR9IZ4NB+RwexryiQhhb+rr6lJelyvi44SlAHzI+uSAXIgs4Tdt9u1C5dsJfhzZwm+EjA8bmPmlzjTajX/KBKioLHS6aX/aPwExjG7LnWHwDxuB3XXAeX29AY65rdtbYNngJNFyTQDTJgAXFG7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788815; c=relaxed/simple;
	bh=S9vhQ2MqYjl8E2eoqIERtb75YJhTurazHAXexCpHCnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYPGjDj2pmRVD6vo8Dx2R3/+BUrmKEnZV08WCpYUrkVKoEhJ8GVMxL9GRTl/22utHpcKXEZXL5WM15GJUDyALo2vXxnhy5NrcS0gDi3rZV6JuQB2iMUQyv2TPSqjJ5TK490pVhMZleKU5mY0Sof4tzOQqtXTxGWinf0ERzEJOMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYqGSh8F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYqGSh8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C19C1F000E9;
	Mon,  3 Aug 2026 20:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785788812;
	bh=xTtnoJAuXGxt5pv0aUU3sKjHNhaGpOeZEC/gZmrnHU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YYqGSh8FxhfVsqfjLb67VdHZgcMhmzOQCm6cRmJYJdnyf3C25OtnFH8FygaJiY8VM
	 Mf0eX45Egxhv/PhKxiwBP9qBdJUY5HrRxvOxyWWXUIiGSy/5mNlBRnS0DQ6wbToQ9C
	 kQZP7sy4lbhO+jBPpxe5akxPrd5PVORAUgElrv2kBr9DR4obLH+fEt98tan+mYRLvg
	 Pg8f7BmAqx3K6zYK8PcYJhJ85Xs/fviK9B/3p4Ze1b11i0+N3/S1/jFrno+/X0gKEh
	 q81v/e5vqIw8aOh83f3dnGGKo7jnLyRjARPbmmT6HEsWyv57a6D/laPL0+ZlxG/GXD
	 43XvxFj7n78GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Suraj Kandpal <suraj.kandpal@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] drm/i915/hdcp: Move to using intel_display in intel_hdcp
Date: Mon,  3 Aug 2026 16:26:49 -0400
Message-ID: <20260803202650.1646505-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072905-sanitary-gills-9e05@gregkh>
References: <2026072905-sanitary-gills-9e05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suraj Kandpal <suraj.kandpal@intel.com>

[ Upstream commit e35bf8f6a0ff06ceeff15bb032351cd5d006f92b ]

Move to using intel_display wherever possible in intel_hdcp.c
as a part of code refactor.

--v2
-Move intel_display to the first line wherever possible [Jani]
-use the closest reference when using to_intel_display [Jani]

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240911090540.643155-2-suraj.kandpal@intel.com
Stable-dep-of: db9e64c983dc ("drm/i915/hdcp: require monotonically increasing seq_num_v")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display_core.h |  3 +++
 drivers/gpu/drm/i915/display/intel_hdcp.c         | 12 ++++++------
 drivers/gpu/drm/i915/i915_driver.c                |  3 +++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_core.h b/drivers/gpu/drm/i915/display/intel_display_core.h
index 9b51148e8ba56..a6f2691ddaa0a 100644
--- a/drivers/gpu/drm/i915/display/intel_display_core.h
+++ b/drivers/gpu/drm/i915/display/intel_display_core.h
@@ -244,6 +244,9 @@ struct intel_wm {
 };
 
 struct intel_display {
+	/* drm device backpointer */
+	struct drm_device *drm;
+
 	/* Display functions */
 	struct {
 		/* Top level crtc-ish functions */
diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index 6406fd487ee52..f9cdd4db9eb14 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -1634,8 +1634,8 @@ int _hdcp2_propagate_stream_management_info(struct intel_connector *connector)
 static
 int hdcp2_authenticate_repeater_topology(struct intel_connector *connector)
 {
+	struct intel_display *display = &to_i915(connector->base.dev)->display;
 	struct intel_digital_port *dig_port = intel_attached_dig_port(connector);
-	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
 	struct intel_hdcp *hdcp = &connector->hdcp;
 	union {
 		struct hdcp2_rep_send_receiverid_list recvid_list;
@@ -1655,7 +1655,7 @@ int hdcp2_authenticate_repeater_topology(struct intel_connector *connector)
 
 	if (HDCP_2_2_MAX_CASCADE_EXCEEDED(rx_info[1]) ||
 	    HDCP_2_2_MAX_DEVS_EXCEEDED(rx_info[1])) {
-		drm_dbg_kms(&dev_priv->drm, "Topology Max Size Exceeded\n");
+		drm_dbg_kms(display->drm, "Topology Max Size Exceeded\n");
 		return -EINVAL;
 	}
 
@@ -1672,23 +1672,23 @@ int hdcp2_authenticate_repeater_topology(struct intel_connector *connector)
 		drm_hdcp_be24_to_cpu((const u8 *)msgs.recvid_list.seq_num_v);
 
 	if (!hdcp->hdcp2_encrypted && seq_num_v) {
-		drm_dbg_kms(&dev_priv->drm,
+		drm_dbg_kms(display->drm,
 			    "Non zero Seq_num_v at first RecvId_List msg\n");
 		return -EINVAL;
 	}
 
 	if (seq_num_v < hdcp->seq_num_v) {
 		/* Roll over of the seq_num_v from repeater. Reauthenticate. */
-		drm_dbg_kms(&dev_priv->drm, "Seq_num_v roll over.\n");
+		drm_dbg_kms(display->drm, "Seq_num_v roll over.\n");
 		return -EINVAL;
 	}
 
 	device_cnt = (HDCP_2_2_DEV_COUNT_HI(rx_info[0]) << 4 |
 		      HDCP_2_2_DEV_COUNT_LO(rx_info[1]));
-	if (drm_hdcp_check_ksvs_revoked(&dev_priv->drm,
+	if (drm_hdcp_check_ksvs_revoked(display->drm,
 					msgs.recvid_list.receiver_ids,
 					device_cnt) > 0) {
-		drm_err(&dev_priv->drm, "Revoked receiver ID(s) is in list\n");
+		drm_err(display->drm, "Revoked receiver ID(s) is in list\n");
 		return -EPERM;
 	}
 
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index be0ebed2a360f..a73a8144974e8 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -844,6 +844,9 @@ i915_driver_create(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, i915);
 
+	/* Add drm device backpointer as early as possible. */
+	i915->display.drm = &i915->drm;
+
 	/* Device parameters start as a copy of module parameters. */
 	i915_params_copy(&i915->params, &i915_modparams);
 
-- 
2.53.0

