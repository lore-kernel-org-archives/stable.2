Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D063374A08;
	Wed,  5 Aug 2026 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939578; cv=none; b=lD8pZZTlj+3Ml1Q2WrT+hOCHZ7MuR5jwSUk286ftpzyZQ3lYsvfmmhziHVs0L1A0FSM9O4zn5XybzYIsXSYq+par/yh0QDxTgCDV1ABtlletrHZtjJYch02djagD4gCh+ZxbhIqb+GhrySb2vfPjKsiHDZXF3fCeQR3ePRTB60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939578; c=relaxed/simple;
	bh=IJ5thZhW8GL9Aibbn+HyiqNnBcFwETx098EIc9+Nza0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9piazn6BX8wJYhW3s+EPYsqxvRXNsxOxUbjpiWENjsWss5nxMWVYK/FTuwWbrKwvBHiP4LZoXlqtszxTgCCAXBEaFqkOA5g4XyGCEkjczXqn9+4BFrL41jYolUYODqKYq11mERGx3VAECSfyyJC8O8fTbaVKGIBUZplPY3YZko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCHgD9gRnNqa6ZpAA--.20506S3;
	Wed, 05 Aug 2026 22:19:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgB358xgRnNqByiTAw--.7866S2;
	Wed, 05 Aug 2026 22:19:12 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Marek Vasut <marex@denx.de>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v3] drm/bridge: ti-sn65dsi83: Cancel reset_work on remove to avoid use-after-free
Date: Wed,  5 Aug 2026 14:18:16 +0000
Message-Id: <20260805141816.216900-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805115546.152786-1-fanwu01@zju.edu.cn>
References: <20260805115546.152786-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgB358xgRnNqByiTAw--.7866S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?3EJdcwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI2Ta2RgZfddM+Y1FlRj8fDxb1K3cJlUE22gKRBQ9mMNwa2M
	i+f+EPnglYqAJbTSbN0=
X-Coremail-Antispam: 1Uk129KBj93XoWxuF43GFWDWw48KF47XryUCFX_yoWrXw1rpF
	4fX390yrWvq3WI9a9FyF15Ary5Awnrta1rCr1kKw1Sva4rWa1Yq34kArWjgF1akFW8J3WY
	yFs0vFy8ArWUAFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU86c_DUUUUU==

The error recovery code queues reset_work from the threaded IRQ handler
and polling monitor_work. Neither device removal nor a probe failure after
requesting the IRQ drains that work before devres releases the bridge
allocation.

Keep the IRQ disabled after it is requested and enable it only after the
bridge has attached successfully. This prevents an IRQ during probe from
queueing reset_work before bridge->encoder has been initialized.

On remove and the post-IRQ probe failure path, synchronously disable the
IRQ before declaring the bridge unplugged. This prevents an asserted IRQ
from repeatedly invoking a handler which can no longer acknowledge the
device. drm_bridge_unplug() then blocks new DRM entry points and waits for
existing bridge critical sections. Finally drain monitor_work and
reset_work before devres can free the bridge allocation.

This issue was found by an in-house static analysis tool.
Compile-tested only; runtime testing is appreciated.

Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes since v2:
  - Request the IRQ with IRQF_NO_AUTOEN and enable it only after the bridge
    attaches, so it cannot fire during probe and queue reset_work before
    bridge->encoder is initialized.
  - Disable the IRQ before drm_bridge_unplug() in the teardown helper, so
    an asserted level IRQ is acknowledged by the handler while it can still
    enter the bridge instead of re-firing once the unplug barrier rejects
    it.

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..d7648b5d5636 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -296,9 +296,14 @@ static int sn65dsi83_attach(struct drm_bridge *bridge,
 			    enum drm_bridge_attach_flags flags)
 {
 	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
+	int ret;
 
-	return drm_bridge_attach(encoder, ctx->panel_bridge,
-				 &ctx->bridge, flags);
+	ret = drm_bridge_attach(encoder, ctx->panel_bridge, &ctx->bridge,
+				flags);
+	if (!ret && ctx->irq)
+		enable_irq(ctx->irq);
+
+	return ret;
 }
 
 static void sn65dsi83_detach(struct drm_bridge *bridge)
@@ -997,6 +1004,19 @@ static irqreturn_t sn65dsi83_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void sn65dsi83_stop_error_recovery(struct sn65dsi83 *ctx)
+{
+	/* Stop the IRQ before the unplug barrier rejects its handler. */
+	if (ctx->irq)
+		disable_irq(ctx->irq);
+
+	/* Block new bridge users and wait for existing critical sections. */
+	drm_bridge_unplug(&ctx->bridge);
+
+	cancel_delayed_work_sync(&ctx->monitor_work);
+	cancel_work_sync(&ctx->reset_work);
+}
+
 static int sn65dsi83_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -1039,7 +1056,8 @@ static int sn65dsi83_probe(struct i2c_client *client)
 	if (client->irq) {
 		ctx->irq = client->irq;
 		ret = devm_request_threaded_irq(ctx->dev, ctx->irq, NULL, sn65dsi83_irq,
-						IRQF_ONESHOT, dev_name(ctx->dev), ctx);
+						IRQF_ONESHOT | IRQF_NO_AUTOEN,
+						dev_name(ctx->dev), ctx);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to request irq\n");
 	}
@@ -1061,7 +1078,7 @@ static int sn65dsi83_probe(struct i2c_client *client)
 	return 0;
 
 err_remove_bridge:
-	drm_bridge_remove(&ctx->bridge);
+	sn65dsi83_stop_error_recovery(ctx);
 	return ret;
 }
 
@@ -1069,6 +1086,6 @@ static void sn65dsi83_remove(struct i2c_client *client)
 {
 	struct sn65dsi83 *ctx = i2c_get_clientdata(client);
 
-	drm_bridge_unplug(&ctx->bridge);
+	sn65dsi83_stop_error_recovery(ctx);
 }
 
-- 
2.51.0

