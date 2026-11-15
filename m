Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743297;
	b=fSfYZnJGkuQ7yk/xG7EZIKIE8JwfG6ADJJexc3mYhmFbxgJUHu9wIWO5lrNEVsQYbyfh
	 urfvtCfye7nZraYoFgi0HS/uqkZavUjQCOEWpx+OD8/nOOq271J9LhnR7Xcw70GJjv2Qz
	 C2ZOsaAahJRJhdLUBha16WOX2CjIDcF4XTEH6TMqUDgBRSk/lfD/m+XwR97VlYgjPeefz
	 rv79oAL9xWNmUdkN7jTjhI6DGHX1J+uFGkCo0F4FnyGDm6DPZhFnJfdxIwmjFy4NpQBhF
	 YDyuL4PXaDiTEW30GN7bPu6zXVX58KdCgcDToG/NPszVMKS8SoSN5tr8clqy1pQlYXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743297;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=JhFY9s977gWLU5B0JYOLgxgpJ8mn60xjCJZlcBkPhRI=;
	b=e9slx2Bf/wZd+XK+2pCLtA00K1w4DD7mspNMh9qfoMOAdtZeML6IUkD7ki6mC4Q/xKQK
	 qsEEDU+uZZ+ykdYMpUHuxM199nMB3bBRnjrxfMmQfUxujPjIIyccWKF/dATcrqOecHvDj
	 JjdBr7sVK5/YCnbpJWlR//I7SaWVH7a42tcxcub6HNaxgKb6t/nRrbudrjKc743ysh09Y
	 RmhRxrmwFPYSmqwqf6qU6FNNwET4dMtV/forI9uSepOxzG//6A8imKVGfvkt2fky5IA5W
	 bGfStf21w9lPHRaq4NHQ/xyuGZFNR8Kk+3m8NlFZWcX0yoBsu5kYiQO1OgQ1b4czL7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=L7noFR46;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037DE606A8B3;
	Sun, 15 Nov 2026 11:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 037DE606A8B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=L7noFR46
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04f4;
	Sun, 15 Nov 2026 19:48:12 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [RFC PATCH v2 2/2] drm/bridge: cdns-mhdp8546: exclude producers
 before teardown
Date: Sun, 15 Nov 2026 19:48:10 +0800
Message-ID: <179474329002.103840.2247392197839757167@seu.edu.cn>
In-Reply-To: <179474328603.103840.4363768155390012601@seu.edu.cn>
References: <179474328603.103840.4363768155390012601@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df0952b003a1kunmbac61c98bf7bd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0MdVhhCSx1MHxofTU9DGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=L7noFR46Lneoogb4Ja+SdjhYa0H+tmwE0wgho/ZQGg0qnQCIklU2VgUu73evcU8gH+b0VGutsu1EWqHw8dNjZOdJtgnTH09ZwrnHk/eh9RKYcKMYj8yxhu2Udr4AUBwwK01eKkaiwVpa3JGU5FD5Kk5AUk9a+pARp0RNdQ+sRps=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=JhFY9s977gWLU5B0JYOLgxgpJ8mn60xjCJZlcBkPhRI=;
	h=date:mime-version:subject:message-id:from;

Moving work cancellation ahead of controller teardown is not enough
when atomic hooks or firmware callbacks can still queue that work.
The asynchronous firmware callback can also outlive the old 100 ms
HW_READY wait, which is not a callback lifetime bound.

Guard resource-facing hooks and work callbacks with the bridge
unplug critical section. Hold a bridge reference for asynchronous
firmware loading and reject a callback after unplug before touching
device resources. Unplug first waits for active guarded operations
while their IRQ service still exists. Then mask and free the IRQ,
drain HPD, retry and both HDCP works, and finally stop the controller
and release its PHY/runtime resources. The preceding core HPD fix
also covers mutex users outside the driver hooks.

Retain a checked connector reference in retry and HDCP property work,
and serialize connector assignment/clearing with the locks used by
those readers. Revalidate the connector before updating its state.
Preserve platform IRQ errors, including deferred probe, while keeping
the IRQ number for explicit synchronized removal.

Found by the author's in-house static analysis tool.

Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546 DPI/DP bridge")
Fixes: 6a3608eae6d3 ("drm: bridge: cdns-mhdp8546: Enable HDCP")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260728135214.1850-1-getshell@seu.edu.cn/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 333 ++++++++++++++----
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |   2 +-
 .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   |  76 +++-
 3 files changed, 324 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index f47717b..6c10809 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -53,7 +53,7 @@
 #include "cdns-mhdp8546-hdcp.h"
 #include "cdns-mhdp8546-j721e.h"
 
-static void cdns_mhdp_bridge_hpd_enable(struct drm_bridge *bridge)
+static void cdns_mhdp_bridge_hpd_enable_active(struct drm_bridge *bridge)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 
@@ -64,7 +64,18 @@ static void cdns_mhdp_bridge_hpd_enable(struct drm_bridge *bridge)
 		       mhdp->regs + CDNS_APB_INT_MASK);
 }
 
-static void cdns_mhdp_bridge_hpd_disable(struct drm_bridge *bridge)
+static void cdns_mhdp_bridge_hpd_enable(struct drm_bridge *bridge)
+{
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
+
+	cdns_mhdp_bridge_hpd_enable_active(bridge);
+	drm_bridge_exit(idx);
+}
+
+static void cdns_mhdp_bridge_hpd_disable_active(struct drm_bridge *bridge)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 
@@ -73,6 +84,17 @@ static void cdns_mhdp_bridge_hpd_disable(struct drm_bridge *bridge)
 	       mhdp->regs + CDNS_APB_INT_MASK);
 }
 
+static void cdns_mhdp_bridge_hpd_disable(struct drm_bridge *bridge)
+{
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
+
+	cdns_mhdp_bridge_hpd_disable_active(bridge);
+	drm_bridge_exit(idx);
+}
+
 static int cdns_mhdp_mailbox_read(struct cdns_mhdp_device *mhdp)
 {
 	int ret, empty;
@@ -702,7 +724,6 @@ static int cdns_mhdp_fw_activate(const struct firmware *fw,
 
 	spin_unlock(&mhdp->start_lock);
 
-	wake_up(&mhdp->fw_load_wq);
 	dev_dbg(mhdp->dev, "DP FW activated\n");
 
 	return 0;
@@ -712,44 +733,42 @@ static void cdns_mhdp_fw_cb(const struct firmware *fw, void *context)
 {
 	struct cdns_mhdp_device *mhdp = context;
 	bool bridge_attached;
-	int ret;
+	int idx, ret;
 
-	dev_dbg(mhdp->dev, "firmware callback\n");
+	if (!drm_bridge_enter(&mhdp->bridge, &idx))
+		goto put_bridge;
 
 	if (!fw || !fw->data) {
 		dev_err(mhdp->dev, "%s: No firmware.\n", __func__);
-		return;
+		goto exit_bridge;
 	}
 
 	ret = cdns_mhdp_fw_activate(fw, mhdp);
-
-	release_firmware(fw);
-
 	if (ret)
-		return;
+		goto exit_bridge;
 
-	/*
-	 *  XXX how to make sure the bridge is still attached when
-	 *      calling drm_kms_helper_hotplug_event() after releasing
-	 *      the lock? We should not hold the spin lock when
-	 *      calling drm_kms_helper_hotplug_event() since it may
-	 *      cause a dead lock. FB-dev console calls detect from the
-	 *      same thread just down the call stack started here.
-	 */
 	spin_lock(&mhdp->start_lock);
 	bridge_attached = mhdp->bridge_attached;
 	spin_unlock(&mhdp->start_lock);
 	if (bridge_attached)
 		drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
+
+exit_bridge:
+	drm_bridge_exit(idx);
+put_bridge:
+	release_firmware(fw);
+	drm_bridge_put(&mhdp->bridge);
 }
 
 static int cdns_mhdp_load_firmware(struct cdns_mhdp_device *mhdp)
 {
 	int ret;
 
+	drm_bridge_get(&mhdp->bridge);
 	ret = request_firmware_nowait(THIS_MODULE, true, FW_NAME, mhdp->dev,
 				      GFP_KERNEL, mhdp, cdns_mhdp_fw_cb);
 	if (ret) {
+		drm_bridge_put(&mhdp->bridge);
 		dev_err(mhdp->dev, "failed to load firmware (%s), ret: %d\n",
 			FW_NAME, ret);
 		return ret;
@@ -758,8 +777,8 @@ static int cdns_mhdp_load_firmware(struct cdns_mhdp_device *mhdp)
 	return 0;
 }
 
-static ssize_t cdns_mhdp_transfer(struct drm_dp_aux *aux,
-				  struct drm_dp_aux_msg *msg)
+static ssize_t cdns_mhdp_transfer_active(struct drm_dp_aux *aux,
+					 struct drm_dp_aux_msg *msg)
 {
 	struct cdns_mhdp_device *mhdp = dev_get_drvdata(aux->dev);
 	int ret;
@@ -799,6 +818,22 @@ static ssize_t cdns_mhdp_transfer(struct drm_dp_aux *aux,
 	return msg->size;
 }
 
+static ssize_t cdns_mhdp_transfer(struct drm_dp_aux *aux,
+				  struct drm_dp_aux_msg *msg)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(aux->dev);
+	ssize_t ret;
+	int idx;
+
+	if (!drm_bridge_enter(&mhdp->bridge, &idx))
+		return -ENODEV;
+
+	ret = cdns_mhdp_transfer_active(aux, msg);
+	drm_bridge_exit(idx);
+
+	return ret;
+}
+
 static int cdns_mhdp_link_training_init(struct cdns_mhdp_device *mhdp)
 {
 	union phy_configure_opts phy_cfg;
@@ -1493,9 +1528,9 @@ bool cdns_mhdp_bandwidth_ok(struct cdns_mhdp_device *mhdp,
 	return true;
 }
 
-static int cdns_mhdp_attach(struct drm_bridge *bridge,
-			    struct drm_encoder *encoder,
-			    enum drm_bridge_attach_flags flags)
+static int cdns_mhdp_attach_active(struct drm_bridge *bridge,
+				   struct drm_encoder *encoder,
+				   enum drm_bridge_attach_flags flags)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 	bool hw_ready;
@@ -1533,6 +1568,22 @@ static int cdns_mhdp_attach(struct drm_bridge *bridge,
 	return ret;
 }
 
+static int cdns_mhdp_attach(struct drm_bridge *bridge,
+			    struct drm_encoder *encoder,
+			    enum drm_bridge_attach_flags flags)
+{
+	int ret;
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return -ENODEV;
+
+	ret = cdns_mhdp_attach_active(bridge, encoder, flags);
+	drm_bridge_exit(idx);
+
+	return ret;
+}
+
 static void cdns_mhdp_configure_video(struct cdns_mhdp_device *mhdp,
 				      const struct drm_display_mode *mode)
 {
@@ -1749,13 +1800,14 @@ static void cdns_mhdp_sst_enable(struct cdns_mhdp_device *mhdp,
 	cdns_mhdp_configure_video(mhdp, mode);
 }
 
-static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
-				    struct drm_atomic_commit *state)
+static void cdns_mhdp_atomic_enable_active(struct drm_bridge *bridge,
+					   struct drm_atomic_commit *state)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 	struct cdns_mhdp_bridge_state *mhdp_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_connector_state *conn_state;
+	struct drm_connector *connector;
 	struct drm_bridge_state *new_state;
 	const struct drm_display_mode *mode;
 	u32 resp;
@@ -1765,10 +1817,15 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 
 	mutex_lock(&mhdp->link_mutex);
 
-	mhdp->connector = drm_atomic_get_new_connector_for_encoder(state,
-								   bridge->encoder);
-	if (WARN_ON(!mhdp->connector))
+	connector = drm_atomic_get_new_connector_for_encoder(state,
+							     bridge->encoder);
+	if (WARN_ON(!connector))
 		goto out;
+	if (mhdp->hdcp_supported)
+		mutex_lock(&mhdp->hdcp.mutex);
+	mhdp->connector = connector;
+	if (mhdp->hdcp_supported)
+		mutex_unlock(&mhdp->hdcp.mutex);
 
 	conn_state = drm_atomic_get_new_connector_state(state, mhdp->connector);
 	if (WARN_ON(!conn_state))
@@ -1840,8 +1897,20 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 		schedule_work(&mhdp->modeset_retry_work);
 }
 
-static void cdns_mhdp_atomic_disable(struct drm_bridge *bridge,
-				     struct drm_atomic_commit *state)
+static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
+				    struct drm_atomic_commit *state)
+{
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
+
+	cdns_mhdp_atomic_enable_active(bridge, state);
+	drm_bridge_exit(idx);
+}
+
+static void cdns_mhdp_atomic_disable_active(struct drm_bridge *bridge,
+					    struct drm_atomic_commit *state)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 	u32 resp;
@@ -1869,11 +1938,27 @@ static void cdns_mhdp_atomic_disable(struct drm_bridge *bridge,
 	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->disable)
 		mhdp->info->ops->disable(mhdp);
 
+	if (mhdp->hdcp_supported)
+		mutex_lock(&mhdp->hdcp.mutex);
 	mhdp->connector = NULL;
+	if (mhdp->hdcp_supported)
+		mutex_unlock(&mhdp->hdcp.mutex);
 	mutex_unlock(&mhdp->link_mutex);
 }
 
-static void cdns_mhdp_detach(struct drm_bridge *bridge)
+static void cdns_mhdp_atomic_disable(struct drm_bridge *bridge,
+				     struct drm_atomic_commit *state)
+{
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
+
+	cdns_mhdp_atomic_disable_active(bridge, state);
+	drm_bridge_exit(idx);
+}
+
+static void cdns_mhdp_detach_active(struct drm_bridge *bridge)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 
@@ -1890,6 +1975,17 @@ static void cdns_mhdp_detach(struct drm_bridge *bridge)
 	writel(~0, mhdp->regs + CDNS_APB_INT_MASK);
 }
 
+static void cdns_mhdp_detach(struct drm_bridge *bridge)
+{
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
+
+	cdns_mhdp_detach_active(bridge);
+	drm_bridge_exit(idx);
+}
+
 static struct drm_bridge_state *
 cdns_mhdp_bridge_atomic_duplicate_state(struct drm_bridge *bridge)
 {
@@ -1955,19 +2051,20 @@ static u32 *cdns_mhdp_get_input_bus_fmts(struct drm_bridge *bridge,
 	return input_fmts;
 }
 
-static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
-				  struct drm_bridge_state *bridge_state,
-				  struct drm_crtc_state *crtc_state,
-				  struct drm_connector_state *conn_state)
+static int cdns_mhdp_atomic_check_active(struct drm_bridge *bridge,
+					 struct drm_bridge_state *bridge_state,
+					 struct drm_crtc_state *crtc_state,
+					 struct drm_connector_state *conn_state)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	struct drm_connector_state *old_state, *new_state;
 	struct drm_atomic_commit *state = crtc_state->state;
-	struct drm_connector *conn = mhdp->connector;
+	struct drm_connector *conn;
 	u64 old_cp, new_cp;
 
 	mutex_lock(&mhdp->link_mutex);
+	conn = mhdp->connector;
 
 	if (!cdns_mhdp_bandwidth_ok(mhdp, mode, mhdp->link.num_lanes,
 				    mhdp->link.rate)) {
@@ -2008,26 +2105,74 @@ static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
 	return 0;
 }
 
+static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
+				  struct drm_bridge_state *bridge_state,
+				  struct drm_crtc_state *crtc_state,
+				  struct drm_connector_state *conn_state)
+{
+	int ret;
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return -ENODEV;
+
+	ret = cdns_mhdp_atomic_check_active(bridge, bridge_state, crtc_state, conn_state);
+	drm_bridge_exit(idx);
+
+	return ret;
+}
+
 static enum drm_connector_status
-cdns_mhdp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
+cdns_mhdp_bridge_detect_active(struct drm_bridge *bridge, struct drm_connector *connector)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 
 	return cdns_mhdp_detect(mhdp);
 }
 
-static const struct drm_edid *cdns_mhdp_bridge_edid_read(struct drm_bridge *bridge,
-							 struct drm_connector *connector)
+static enum drm_connector_status
+cdns_mhdp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
+{
+	enum drm_connector_status ret;
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return connector_status_disconnected;
+
+	ret = cdns_mhdp_bridge_detect_active(bridge, connector);
+	drm_bridge_exit(idx);
+
+	return ret;
+}
+
+static const struct drm_edid *
+cdns_mhdp_bridge_edid_read_active(struct drm_bridge *bridge,
+				  struct drm_connector *connector)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 
 	return cdns_mhdp_edid_read(mhdp, connector);
 }
 
+static const struct drm_edid *cdns_mhdp_bridge_edid_read(struct drm_bridge *bridge,
+							 struct drm_connector *connector)
+{
+	const struct drm_edid *ret;
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return NULL;
+
+	ret = cdns_mhdp_bridge_edid_read_active(bridge, connector);
+	drm_bridge_exit(idx);
+
+	return ret;
+}
+
 static enum drm_mode_status
-cdns_mhdp_bridge_mode_valid(struct drm_bridge *bridge,
-			    const struct drm_display_info *info,
-			    const struct drm_display_mode *mode)
+cdns_mhdp_bridge_mode_valid_active(struct drm_bridge *bridge,
+				   const struct drm_display_info *info,
+				   const struct drm_display_mode *mode)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 
@@ -2043,6 +2188,23 @@ cdns_mhdp_bridge_mode_valid(struct drm_bridge *bridge,
 	return MODE_OK;
 }
 
+static enum drm_mode_status
+cdns_mhdp_bridge_mode_valid(struct drm_bridge *bridge,
+			    const struct drm_display_info *info,
+			    const struct drm_display_mode *mode)
+{
+	enum drm_mode_status ret;
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return MODE_ERROR;
+
+	ret = cdns_mhdp_bridge_mode_valid_active(bridge, info, mode);
+	drm_bridge_exit(idx);
+
+	return ret;
+}
+
 static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
 	.atomic_enable = cdns_mhdp_atomic_enable,
 	.atomic_disable = cdns_mhdp_atomic_disable,
@@ -2172,14 +2334,20 @@ static int cdns_mhdp_update_link_status(struct cdns_mhdp_device *mhdp)
 	return ret;
 }
 
-static void cdns_mhdp_modeset_retry_fn(struct work_struct *work)
+static void cdns_mhdp_modeset_retry_fn_active(struct work_struct *work)
 {
 	struct cdns_mhdp_device *mhdp;
 	struct drm_connector *conn;
 
 	mhdp = container_of(work, typeof(*mhdp), modeset_retry_work);
 
+	mutex_lock(&mhdp->link_mutex);
 	conn = mhdp->connector;
+	if (conn)
+		drm_connector_get(conn);
+	mutex_unlock(&mhdp->link_mutex);
+	if (!conn)
+		return;
 
 	/* Grab the locks before changing connector property */
 	mutex_lock(&conn->dev->mode_config.mutex);
@@ -2192,7 +2360,21 @@ static void cdns_mhdp_modeset_retry_fn(struct work_struct *work)
 	mutex_unlock(&conn->dev->mode_config.mutex);
 
 	/* Send Hotplug uevent so userspace can reprobe */
-	drm_kms_helper_hotplug_event(mhdp->bridge.dev);
+	drm_kms_helper_hotplug_event(conn->dev);
+	drm_connector_put(conn);
+}
+
+static void cdns_mhdp_modeset_retry_fn(struct work_struct *work)
+{
+	struct cdns_mhdp_device *mhdp =
+		container_of(work, struct cdns_mhdp_device, modeset_retry_work);
+	int idx;
+
+	if (!drm_bridge_enter(&mhdp->bridge, &idx))
+		return;
+
+	cdns_mhdp_modeset_retry_fn_active(work);
+	drm_bridge_exit(idx);
 }
 
 static irqreturn_t cdns_mhdp_irq_handler(int irq, void *data)
@@ -2248,7 +2430,7 @@ u32 cdns_mhdp_wait_for_sw_event(struct cdns_mhdp_device *mhdp, u32 event)
 	return ret;
 }
 
-static void cdns_mhdp_hpd_work(struct work_struct *work)
+static void cdns_mhdp_hpd_work_active(struct work_struct *work)
 {
 	struct cdns_mhdp_device *mhdp = container_of(work,
 						     struct cdns_mhdp_device,
@@ -2258,6 +2440,19 @@ static void cdns_mhdp_hpd_work(struct work_struct *work)
 	drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
 }
 
+static void cdns_mhdp_hpd_work(struct work_struct *work)
+{
+	struct cdns_mhdp_device *mhdp =
+		container_of(work, struct cdns_mhdp_device, hpd_work);
+	int idx;
+
+	if (!drm_bridge_enter(&mhdp->bridge, &idx))
+		return;
+
+	cdns_mhdp_hpd_work_active(work);
+	drm_bridge_exit(idx);
+}
+
 static int cdns_mhdp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -2265,7 +2460,6 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 	unsigned long rate;
 	struct clk *clk;
 	int ret;
-	int irq;
 
 	mhdp = devm_drm_bridge_alloc(dev, struct cdns_mhdp_device, bridge,
 				     &cdns_mhdp_bridge_funcs);
@@ -2338,14 +2532,16 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 
 	writel(~0, mhdp->regs + CDNS_APB_INT_MASK);
 
-	irq = platform_get_irq(pdev, 0);
-	ret = devm_request_threaded_irq(mhdp->dev, irq, NULL,
+	mhdp->irq = platform_get_irq(pdev, 0);
+	if (mhdp->irq < 0) {
+		ret = mhdp->irq;
+		goto plat_fini;
+	}
+	ret = devm_request_threaded_irq(mhdp->dev, mhdp->irq, NULL,
 					cdns_mhdp_irq_handler, IRQF_ONESHOT,
 					"mhdp8546", mhdp);
-	if (ret) {
-		ret = -EIO;
+	if (ret)
 		goto plat_fini;
-	}
 
 	cdns_mhdp_fill_host_caps(mhdp);
 
@@ -2373,7 +2569,6 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 	INIT_WORK(&mhdp->modeset_retry_work, cdns_mhdp_modeset_retry_fn);
 	INIT_WORK(&mhdp->hpd_work, cdns_mhdp_hpd_work);
 
-	init_waitqueue_head(&mhdp->fw_load_wq);
 	init_waitqueue_head(&mhdp->sw_events_wq);
 
 	ret = cdns_mhdp_load_firmware(mhdp);
@@ -2402,22 +2597,32 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 static void cdns_mhdp_remove(struct platform_device *pdev)
 {
 	struct cdns_mhdp_device *mhdp = platform_get_drvdata(pdev);
-	unsigned long timeout = msecs_to_jiffies(100);
+	bool bridge_attached, hw_ready;
 	int ret;
 
-	drm_bridge_remove(&mhdp->bridge);
+	/* Keep interrupts available to operations already inside the guard. */
+	drm_bridge_unplug(&mhdp->bridge);
 
-	ret = wait_event_timeout(mhdp->fw_load_wq,
-				 mhdp->hw_state == MHDP_HW_READY,
-				 timeout);
 	spin_lock(&mhdp->start_lock);
+	bridge_attached = mhdp->bridge_attached;
+	mhdp->bridge_attached = false;
+	hw_ready = mhdp->hw_state == MHDP_HW_READY;
 	mhdp->hw_state = MHDP_HW_STOPPED;
 	spin_unlock(&mhdp->start_lock);
 
-	if (ret == 0) {
-		dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n",
-			__func__);
-	} else {
+	writel(~0, mhdp->regs + CDNS_APB_INT_MASK);
+	devm_free_irq(mhdp->dev, mhdp->irq, mhdp);
+	cancel_work_sync(&mhdp->hpd_work);
+	cancel_work_sync(&mhdp->modeset_retry_work);
+	if (mhdp->hdcp_supported) {
+		cancel_delayed_work_sync(&mhdp->hdcp.check_work);
+		cancel_work_sync(&mhdp->hdcp.prop_work);
+	}
+
+	if (bridge_attached)
+		drm_dp_aux_unregister(&mhdp->aux);
+
+	if (hw_ready) {
 		ret = cdns_mhdp_set_firmware_active(mhdp, false);
 		if (ret)
 			dev_err(mhdp->dev, "Failed to stop firmware (%pe)\n",
@@ -2425,16 +2630,10 @@ static void cdns_mhdp_remove(struct platform_device *pdev)
 	}
 
 	phy_exit(mhdp->phy);
-
 	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->exit)
 		mhdp->info->ops->exit(mhdp);
-
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	cancel_work_sync(&mhdp->modeset_retry_work);
-	flush_work(&mhdp->hpd_work);
-	/* Ignoring mhdp->hdcp.check_work and mhdp->hdcp.prop_work here. */
 }
 
 static const struct of_device_id mhdp_ids[] = {
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
index b53335b..9418fac 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
@@ -359,6 +359,7 @@ struct cdns_mhdp_device {
 	struct device *dev;
 	struct clk *clk;
 	struct phy *phy;
+	int irq;
 
 	const struct cdns_mhdp_platform_info *info;
 
@@ -401,7 +402,6 @@ struct cdns_mhdp_device {
 	bool bridge_attached;
 	bool bridge_enabled;
 	enum mhdp_hw_state hw_state;
-	wait_queue_head_t fw_load_wq;
 
 	/* Work struct to schedule a uevent on link train failure */
 	struct work_struct modeset_retry_work;
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
index 5cd0b87..b769380 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
@@ -468,7 +468,7 @@ static int cdns_mhdp_hdcp_check_link(struct cdns_mhdp_device *mhdp)
 	return ret;
 }
 
-static void cdns_mhdp_hdcp_check_work(struct work_struct *work)
+static void cdns_mhdp_hdcp_check_work_active(struct work_struct *work)
 {
 	struct delayed_work *d_work = to_delayed_work(work);
 	struct cdns_mhdp_hdcp *hdcp = container_of(d_work,
@@ -483,31 +483,69 @@ static void cdns_mhdp_hdcp_check_work(struct work_struct *work)
 				      DRM_HDCP_CHECK_PERIOD_MS);
 }
 
-static void cdns_mhdp_hdcp_prop_work(struct work_struct *work)
+static void cdns_mhdp_hdcp_check_work(struct work_struct *work)
 {
-	struct cdns_mhdp_hdcp *hdcp = container_of(work,
-						   struct cdns_mhdp_hdcp,
-						   prop_work);
-	struct cdns_mhdp_device *mhdp = container_of(hdcp,
-						     struct cdns_mhdp_device,
-						     hdcp);
-	struct drm_device *dev = NULL;
-	struct drm_connector_state *state;
+	struct cdns_mhdp_hdcp *hdcp =
+		container_of(to_delayed_work(work), struct cdns_mhdp_hdcp, check_work);
+	struct cdns_mhdp_device *mhdp =
+		container_of(hdcp, struct cdns_mhdp_device, hdcp);
+	int idx;
 
-	if (mhdp->connector)
-		dev = mhdp->connector->dev;
+	if (!drm_bridge_enter(&mhdp->bridge, &idx))
+		return;
+
+	cdns_mhdp_hdcp_check_work_active(work);
+	drm_bridge_exit(idx);
+}
 
-	if (!dev)
+static void cdns_mhdp_hdcp_prop_work_active(struct work_struct *work)
+{
+	struct cdns_mhdp_hdcp *hdcp = container_of(work, struct cdns_mhdp_hdcp,
+					       prop_work);
+	struct cdns_mhdp_device *mhdp = container_of(hdcp, struct cdns_mhdp_device,
+						 hdcp);
+	struct drm_connector *conn;
+	struct drm_device *dev;
+
+	mutex_lock(&mhdp->link_mutex);
+	conn = mhdp->connector;
+	if (conn)
+		drm_connector_get(conn);
+	mutex_unlock(&mhdp->link_mutex);
+	if (!conn)
 		return;
 
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-	mutex_lock(&mhdp->hdcp.mutex);
-	if (mhdp->hdcp.value != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
-		state = mhdp->connector->state;
-		state->content_protection = mhdp->hdcp.value;
+	dev = conn->dev;
+	if (!dev) {
+		drm_connector_put(conn);
+		return;
 	}
-	mutex_unlock(&mhdp->hdcp.mutex);
+
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+	mutex_lock(&mhdp->link_mutex);
+	mutex_lock(&hdcp->mutex);
+	if (mhdp->connector == conn && conn->state &&
+	    hdcp->value != DRM_MODE_CONTENT_PROTECTION_UNDESIRED)
+		conn->state->content_protection = hdcp->value;
+	mutex_unlock(&hdcp->mutex);
+	mutex_unlock(&mhdp->link_mutex);
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+	drm_connector_put(conn);
+}
+
+static void cdns_mhdp_hdcp_prop_work(struct work_struct *work)
+{
+	struct cdns_mhdp_hdcp *hdcp =
+		container_of(work, struct cdns_mhdp_hdcp, prop_work);
+	struct cdns_mhdp_device *mhdp =
+		container_of(hdcp, struct cdns_mhdp_device, hdcp);
+	int idx;
+
+	if (!drm_bridge_enter(&mhdp->bridge, &idx))
+		return;
+
+	cdns_mhdp_hdcp_prop_work_active(work);
+	drm_bridge_exit(idx);
 }
 
 int cdns_mhdp_hdcp_enable(struct cdns_mhdp_device *mhdp, u8 content_type)
-- 
2.50.1.windows.1
