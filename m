Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743296;
	b=giQsjebtiaJBIRqFMDjPtYStQ9D9wHrlFIZ1XUmXJCQwj6EJKg1XnlY/slgeLXZgMW3o
	 g53lZQ+sr2qhs1wf644ZiY4ZoWRetEHuYq1offR8Sbouq3OoOoeFZgBP0jT+vWXmdqHt7
	 21dcBnmMx69hfH5LY0otjYAuafMQdSXvzmri8E4HvmLQWrvzDx9A17XSkWubA0jAacj1l
	 fkucgPtPqWTMGk8AX7RGi6jVX/Ck/lwhrwohBCorc8p4/zaghcg8jj336u1X23M5xcou4
	 qzJGhSGg+s7vyNId49ZZ2jwBtEQpgNroZWMEjniwAoNwdAHGcb8xMkvpAtwRjzkCdsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743296;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=9zw9gLo4xSdeNGbb2wIoBEkOuWDWIwBbMytZCe7N47s=;
	b=IRKB2OgFWL5TbGLy/oG4u4GuwSQKzCDnHUhzstYPZup8Wh5Qo5MUcOyHmjYV3E412xAa
	 mB8KV6dT+EGpJ4T65CrEpSu8oFegPGPBVMAgFsmgZkBlorRImC/jOQr4T6kLHQQqudg7V
	 NXln/T52CTBB30amtksFQf1xePibYMsBFm6+iWmwlOieGCRBHboC+o/EbInu4vp3chrMO
	 /8cr82BvbAP3mRHS+CLbJUy/0D0Aj1NNtp4ePzPlXW3i0a/urKeXY47O9y5YStwSATrNS
	 hNKDJs0LNyctligYnBKi/4JkF43hb2FZw5x4AzBnjru5sXr3iR9nliErWCuhejJsK+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b="jTHSvA5/";
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF49606A8B8;
	Sun, 15 Nov 2026 11:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AF49606A8B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=jTHSvA5/
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04f2;
	Sun, 15 Nov 2026 19:48:10 +0800 (GMT+08:00)
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
Subject:
 [RFC PATCH v2 1/2] drm/bridge: protect complete HPD helpers during unplug
Date: Sun, 15 Nov 2026 19:48:07 +0800
Message-ID: <179474328799.103840.339489006600833395@seu.edu.cn>
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
X-HM-Tid: 0aa1df094ac503a1kunmbac61c98bf7ba
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHx9NVkpLSUwYH0xJGUlITlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=jTHSvA5/LJKPs2weugYzR09ChYp1GF56CvCcatsb3rpW3QtLCt9A7JC4We2q2h7mvlYronOSvXow5nJbrq2IQbTVYj4oaNiyB+RfRi80ghzHjlQIFMJ9/01QZrSrFhoKumo3QSGaJ1ApqWce3n6a2cJvmWWlOoI1bk1D5S8x0S0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=9zw9gLo4xSdeNGbb2wIoBEkOuWDWIwBbMytZCe7N47s=;
	h=date:mime-version:subject:message-id:from;

A bridge driver can protect its HPD hook with drm_bridge_enter(),
but the core HPD helpers acquire their own mutexes before that hook
and release them after it returns. A driver-only section therefore
does not make drm_bridge_unplug() wait for those mutex users before
drm_bridge_remove() destroys the HPD mutexes.

Enter the unplug critical section before acquiring HPD mutexes in
enable, disable and notify, and leave it after the final unlock. An
unplugged bridge then rejects later calls before mutex or hook use,
and unplug waits for the complete helpers already in progress.

Found by the author's in-house static analysis tool.

Fixes: d36137085a4a ("drm/bridge: add drm_bridge_unplug() and drm_bridge_enter/exit()")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260728135214.1850-1-getshell@seu.edu.cn/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/gpu/drm/drm_bridge.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1b4ee74..e2adb94 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -300,6 +300,16 @@ void drm_bridge_unplug(struct drm_bridge *bridge)
 
 	synchronize_srcu(&drm_bridge_unplug_srcu);
 
+	/*
+	 * No helper can enter any more and every in-flight one has finished.
+	 * Drop the HPD registration now, while drm_bridge_remove() has not
+	 * destroyed the mutexes that protect it.
+	 */
+	mutex_lock(&bridge->hpd_mutex);
+	bridge->hpd_cb = NULL;
+	bridge->hpd_data = NULL;
+	mutex_unlock(&bridge->hpd_mutex);
+
 	drm_bridge_remove(bridge);
 }
 EXPORT_SYMBOL(drm_bridge_unplug);
@@ -1551,6 +1561,10 @@ EXPORT_SYMBOL_GPL(drm_bridge_edid_read);
  * Hot plug detection is supported only if the DRM_BRIDGE_OP_HPD flag is set in
  * bridge->ops. This function shall not be called when the flag is not set.
  *
+ * Calls are serialized against drm_bridge_unplug(); once the bridge has been
+ * unplugged, this function returns without installing the callback or calling
+ * &drm_bridge_funcs.hpd_enable.
+ *
  * Only one hot plug detection callback can be registered at a time, it is an
  * error to call this function when hot plug detection is already enabled for
  * the bridge.
@@ -1560,9 +1574,14 @@ void drm_bridge_hpd_enable(struct drm_bridge *bridge,
 				      enum drm_connector_status status),
 			   void *data)
 {
+	int idx;
+
 	if (!(bridge->ops & DRM_BRIDGE_OP_HPD))
 		return;
 
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
+
 	mutex_lock(&bridge->hpd_state_mutex);
 
 	mutex_lock(&bridge->hpd_mutex);
@@ -1582,6 +1601,7 @@ void drm_bridge_hpd_enable(struct drm_bridge *bridge,
 
 unlock:
 	mutex_unlock(&bridge->hpd_state_mutex);
+	drm_bridge_exit(idx);
 }
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_enable);
 
@@ -1596,12 +1616,23 @@ EXPORT_SYMBOL_GPL(drm_bridge_hpd_enable);
  *
  * Hot plug detection is supported only if the DRM_BRIDGE_OP_HPD flag is set in
  * bridge->ops. This function shall not be called when the flag is not set.
+ *
+ * Calls are serialized against drm_bridge_unplug(), which waits for any
+ * in-flight helper and clears the registered callback before removing the
+ * bridge.  Once the bridge has been unplugged, this function therefore
+ * returns without calling &drm_bridge_funcs.hpd_disable.
  */
 void drm_bridge_hpd_disable(struct drm_bridge *bridge)
 {
+	int idx;
+
 	if (!(bridge->ops & DRM_BRIDGE_OP_HPD))
 		return;
 
+	/* drm_bridge_unplug() has already dropped the registration. */
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
+
 	mutex_lock(&bridge->hpd_state_mutex);
 	if (bridge->funcs->hpd_disable)
 		bridge->funcs->hpd_disable(bridge);
@@ -1611,6 +1642,7 @@ void drm_bridge_hpd_disable(struct drm_bridge *bridge)
 	bridge->hpd_data = NULL;
 	mutex_unlock(&bridge->hpd_mutex);
 	mutex_unlock(&bridge->hpd_state_mutex);
+	drm_bridge_exit(idx);
 }
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_disable);
 
@@ -1624,14 +1656,23 @@ EXPORT_SYMBOL_GPL(drm_bridge_hpd_disable);
  * enabled by drm_bridge_hpd_enable().
  *
  * This function shall be called in a context that can sleep.
+ *
+ * Once the bridge has been unplugged the event is dropped: the registered
+ * callback is not invoked.
  */
 void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 			   enum drm_connector_status status)
 {
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
+
 	mutex_lock(&bridge->hpd_mutex);
 	if (bridge->hpd_cb)
 		bridge->hpd_cb(bridge->hpd_data, status);
 	mutex_unlock(&bridge->hpd_mutex);
+	drm_bridge_exit(idx);
 }
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
 
-- 
2.50.1.windows.1
