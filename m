Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C2838655C;
	Thu, 20 Aug 2026 04:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787201346; cv=none; b=tAeRJpOtd/TaqWrOUmqRzQAog7x0GdFiHKbsSvZc3wz5ATofzgp0MWrAaZcPQKlGtFkhr+D7xxwr8Jbki1QaLLsYpzdDCfYjhLjAzGA2IblquM3OjW77AzUyqXulfY8esIIOA3YswDPn7mhw6oHRjbvMiyJlcHTF+EM/FmVDE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787201346; c=relaxed/simple;
	bh=+u5LdgSKjbxahmT6rzXIbCebN48clPPnVMAXff7UB7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qHKdGSRpsPqySEsS6LSVoj2f7YIjR+ma1u1RPI4jlxUmS4D1CTF0dZ98Qop7aq5yLHWan3ic/L/dim5p/xbw2UdpNP87uk8xFFlEyJdKashECKI7gOJm6qU6XmF0OkhxXa6ET3TFu20fKAbrh9NnVH+rmEe/b1SBMBD1b6p1A8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wA38z0ph4Zq5P+rAA--.1783S3;
	Thu, 20 Aug 2026 12:48:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgBHl58ph4ZqoT0CBA--.40164S2;
	Thu, 20 Aug 2026 12:48:41 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Nicolas Boichat <drinkcat@chromium.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] drm/bridge: anx78xx: fix potential use-after-free on device removal
Date: Thu, 20 Aug 2026 04:47:46 +0000
Message-Id: <20260820044746.3087-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgBHl58ph4ZqoT0CBA--.40164S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?gbqewwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBHHYRxHJM7g4r1VIOGUvIO1duR0dLd7GrvyLtvOGt4K6CNS
	iK+Oo5rExaLy3VbWv8ip9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFyrCryDKFy5WrWDCFW8Xwc_yoW8Kr1Upr
	WfKF4Y9ry8GF17tw47Z3WUJFy8ZFykWr4rCa47K347t3WYyFnF9F9avFyYyan8Cr4rJF4x
	Wr1jqryDt34UZrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ructUUUUU==

The HPD and INTP interrupts are requested with
devm_request_threaded_irq(), so they stay armed until the devm cleanup
runs after ->remove() has returned.  anx78xx_i2c_remove() unregisters
the dummy i2c clients and frees the cached EDID before that, and both
threaded handlers access those clients through their regmaps, so a
handler running in this window can cause a use-after-free, or a
double-free of the EDID when a cable is unplugged.

Free both interrupts with devm_free_irq() before the dummy clients are
unregistered.  free_irq() waits for a running threaded handler to
finish, so the handlers can no longer race with the teardown.  The
probe error path taken when the INTP request fails unregisters the
dummy clients with the HPD interrupt still armed; free it there too.

This issue was found by an in-house static analysis tool.

Fixes: 0647e7dd3f7a ("drm/bridge: Add Analogix anx78xx support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
index ba0fc149a9e7..a5f4ecb96498 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -1304,6 +1304,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client)
 					"anx78xx-intp", anx78xx);
 	if (err) {
 		DRM_ERROR("Failed to request INTP threaded IRQ: %d\n", err);
+		devm_free_irq(&client->dev, pdata->hpd_irq, anx78xx);
 		goto err_poweroff;
 	}
 
@@ -1327,6 +1328,14 @@ static void anx78xx_i2c_remove(struct i2c_client *client)
 {
 	struct anx78xx *anx78xx = i2c_get_clientdata(client);
 
+	/*
+	 * The threaded IRQ handlers access the dummy I2C clients through
+	 * regmap and may free the cached EDID, so stop them before those
+	 * resources are freed below.
+	 */
+	devm_free_irq(&client->dev, anx78xx->pdata.hpd_irq, anx78xx);
+	devm_free_irq(&client->dev, anx78xx->pdata.intp_irq, anx78xx);
+
 	drm_bridge_remove(&anx78xx->bridge);
 
 	unregister_i2c_dummy_clients(anx78xx);
-- 
2.34.1

