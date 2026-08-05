Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323D83F410F;
	Wed,  5 Aug 2026 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920983; cv=none; b=GhGLQ8RMyTB3hRrq5YqzBKMmsOg0yg0ZvAXoY9h8DgIgE7xq6NWQBqVRVYX5yt06yqdC80bZdx1CXLrwRc7/qLPcVuMOF1lb8hFg+AjbKixJzTGqVCwIzB1RE7Vbe0UUTqpGWOJ7NH+s32ET6LoP+KS2q737195JTHmEHn6JZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920983; c=relaxed/simple;
	bh=9UaMQIIzDep4GFF4WTqr+2+cJAOj/WBb56I8DIyVQhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oeq6oRV9jsmHVQDiGGJx98m270JtyE8vmljZdr+Q3Rzhh8s5o5A+ya4HuFuUi5VlKr5et138s9Hd6pzrzsFLjKLFUrwZSh2U7TKzxT/V1qyd/bJlZXOdNKhKM2AC93Q565ShqQoZOaQNdbYP/gYt85qiONtU+oiukOrA7C4MXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCnvnys_XJqQsFoAA--.23227S3;
	Wed, 05 Aug 2026 17:09:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgD3DnGr_XJqMPv5Aw--.15483S2;
	Wed, 05 Aug 2026 17:08:59 +0800 (CST)
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
Subject: [PATCH] drm/bridge: ti-sn65dsi83: Cancel reset_work on remove to avoid use-after-free
Date: Wed,  5 Aug 2026 09:08:04 +0000
Message-Id: <20260805090804.78914-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgD3DnGr_XJqMPv5Aw--.15483S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?9RKe2QXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WMBzwIw6lQvkaUf6bwSXuEgIb5CSQ0Hx1t1bgLLzQ5Dx51z
	1w49cJTUDgdKWAabouHN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7uw48urWfCF4DWw17tFy8Xrc_yoW8ur4fpF
	WftryYkrWkXFWj9aykAF18XFy5Cw1ktayFkryUGw4fu345XFWYy3sYkFWYgFyakr1UAa4a
	yr4vyrWUZFy2y3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

The error recovery code queues ctx->reset_work from the threaded IRQ
handler and the polling monitor_work, but nothing ever cancels it.
sn65dsi83_remove() only unplugs the bridge, and the
sn65dsi83_release_resources devm action disables the IRQ at the chip and
stops monitor_work but does not cancel reset_work. The IRQ is
devm-managed, so a reset_work already queued survives detach and the devm
IRQ free and runs after ctx is freed, recovering it via container_of() and
leading to a use-after-free. drm_bridge_enter()/SRCU guards a running work
against bridge removal but cannot stop a queued work running after ctx is
gone.

Stop the producers before unplug, then drain: disable_irq so the threaded
handler can no longer queue reset_work, cancel monitor_work, then
cancel_work_sync(&ctx->reset_work). disable_irq keeps the IRQ registered
so a racing reset_work's trailing enable_irq() stays valid, while its
disable depth stops the handler from re-arming before ctx is freed.

This issue was found by an in-house static analysis tool.
Compile-tested only; runtime testing is appreciated.

Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..d334b2898e25 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -1069,6 +1069,12 @@ static void sn65dsi83_remove(struct i2c_client *client)
 {
 	struct sn65dsi83 *ctx = i2c_get_clientdata(client);
 
+	/* Stop the reset_work producers, then drain, before unplug. */
+	if (ctx->irq)
+		disable_irq(ctx->irq);
+	cancel_delayed_work_sync(&ctx->monitor_work);
+	cancel_work_sync(&ctx->reset_work);
+
 	drm_bridge_unplug(&ctx->bridge);
 }
 
-- 
2.39.5

