Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC41448CFC;
	Wed,  5 Aug 2026 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931024; cv=none; b=TFdALPB6tLtWwZEtBmjkfn2pTZHZYo8KHg+erczSl97t4PK/Vl+rbUpuHa2CojdsRvZ4dHDH7sU5ogb7tdO4omu/tKG0l0ItLWidzpc5J787dw6tj4qzWXvdFQax4lZXs5rriuP1ehvqa5D35aYARPD0oEWO3VYZ7ZQbylAkkps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931024; c=relaxed/simple;
	bh=10kVQYRCo6bNJci1C7wNF0Cjviiqu8GTE57w1E5iKRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c44GVhu0RvR3Tm6rC8bJOPTyBqXmSU6E259IM+A9a+F1rCCVnQF+c6xIWfiE5qGC+SGeNEOMqTpdF3Zc3iarTHNX9CorlJtrcoP2vHmpJixKi1VRuvdmCILn1QVOS+0HOkaCNUjpm3AxI7u43oBrXgrigdo1dy5fMLv1Ro2p8j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAX4n36JHNq4D9pAA--.20355S3;
	Wed, 05 Aug 2026 19:56:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgAnd5_5JHNqa4iKAw--.51924S2;
	Wed, 05 Aug 2026 19:56:42 +0800 (CST)
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
Subject: [PATCH v2] drm/bridge: ti-sn65dsi83: Cancel reset_work on remove to avoid use-after-free
Date: Wed,  5 Aug 2026 11:55:46 +0000
Message-Id: <20260805115546.152786-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805090804.78914-1-fanwu01@zju.edu.cn>
References: <20260805090804.78914-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgAnd5_5JHNqa4iKAw--.51924S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?VLvJIwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBHsHPRTq1nu9Lig+QZosvpoMyN+4DStAKd0ilpoZmfYoolR
	/bid1KQKukE0taufdXWp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxur4fJw4fCrWkZF15Ww47ZFc_yoW5Ww1UpF
	sxW3s8C3ykXa1I9a9FyF15AFyYywnrtayrGrnrKw1fZa4Yqa15t34vkFWqqFyakFy8Jayj
	vr4qyFWkZr47AFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
and polling monitor_work. Neither the remove path nor the probe failure
path after the IRQ is registered drains that work before devres releases
the bridge allocation.

Use drm_bridge_unplug() before stopping the work. It prevents a concurrent
atomic commit from entering the bridge and re-arming monitor_work through
monitor_start(), and waits for in-flight bridge critical sections to
finish. Then disable the IRQ and drain monitor_work and reset_work.

Use the same shutdown sequence when attaching the DSI host fails. This
prevents error recovery work queued by an early IRQ from accessing the
devm-managed bridge after the failed probe returns.

This issue was found by an in-house static analysis tool.
Compile-tested only; runtime testing is appreciated.

Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes since v1:
  - Move drm_bridge_unplug() ahead of the work cancellation so a concurrent
    atomic commit cannot re-arm monitor_work via monitor_start() after the
    cancel.
  - Drain from the probe-error path (err_remove_bridge) too, closing a UAF
    where a spurious IRQ during probe queues reset_work and a later
    -EPROBE_DEFER frees ctx.
  - Factor the sequence into sn65dsi83_stop_error_recovery() shared by
    both paths.

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..5f1a96856eac 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -997,6 +997,18 @@ static irqreturn_t sn65dsi83_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void sn65dsi83_stop_error_recovery(struct sn65dsi83 *ctx)
+{
+	/* Block new bridge users and wait for existing critical sections. */
+	drm_bridge_unplug(&ctx->bridge);
+
+	if (ctx->irq)
+		disable_irq(ctx->irq);
+
+	cancel_delayed_work_sync(&ctx->monitor_work);
+	cancel_work_sync(&ctx->reset_work);
+}
+
 static int sn65dsi83_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -1061,7 +1073,7 @@ static int sn65dsi83_probe(struct i2c_client *client)
 	return 0;
 
 err_remove_bridge:
-	drm_bridge_remove(&ctx->bridge);
+	sn65dsi83_stop_error_recovery(ctx);
 	return ret;
 }
 
@@ -1069,6 +1081,6 @@ static void sn65dsi83_remove(struct i2c_client *client)
 {
 	struct sn65dsi83 *ctx = i2c_get_clientdata(client);
 
-	drm_bridge_unplug(&ctx->bridge);
+	sn65dsi83_stop_error_recovery(ctx);
 }
 
-- 
2.51.0

