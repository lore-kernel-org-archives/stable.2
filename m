Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A0425CF7;
	Thu, 11 Jun 2026 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194882; cv=none; b=Op5QUHmFEnIj1juv2/h1DXmTD7NUMJjIyI56GUc/l4hu+VYkMuPlc9B4GrWRgNCGwXw7U0ypdDiaSUQYlteiuh43pHGMKbA+WHhN8kyOg6SAwHy7QniJ9WUyZ3XoRNrbhkOrRCo5d05xmFEsia1G42ZzW/5ip3I7gKCXqKkokxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194882; c=relaxed/simple;
	bh=/t4jyeDK2IvqS0+9MlVEkaR3MYfgo1rC9yuzyQbe5oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqYv+CsgxHyv924JcAAe0bqtWfVBv3s77PaRogiER1NOfrwWw4odkkO3pFs822HPlADjaGDKHn9Bs97b08SLQkzvhnZQszFVFABQYh0/uKmo5q0WrwZAc46BYWdJcAmytYsNmMyxKbza4EatosjiXV0F81TZKVdPZYDPL64JiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=BpRjE/DB; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="BpRjE/DB"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 420765eaa;
	Fri, 12 Jun 2026 00:16:07 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: broonie@kernel.org
Cc: david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	Paul.Handrigan@cirrus.com,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ASoC: cs35l34: drain threaded IRQ before runtime suspend
Date: Fri, 12 Jun 2026 00:15:53 +0800
Message-Id: <20260611161553.3378721-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611161553.3378721-1-runyu.xiao@seu.edu.cn>
References: <20260611161553.3378721-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb77830f003a1kunmccb51b6d16b65d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSE0YVhpJSkpNQ0xDTkpCTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BpRjE/DBu48nvcOQ6bkGn7W+jne3svKx0CeX2CxLeeMB40JSDFNT38Fa0MTlAZlrWMi9mBId907AzeAjl8ANqtczDnR0fdSaqEa47McTuNI7iJn7EpY2V0P9ooHx7QYJ8b3HuqTQfFr091XYmaypcxCoMTmpx0PeQ1wmkp1lqWI=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=i0Zv/u7L567sfUl0cz5HV/ubd0jANpYYqAp7pHutO1U=;
	h=date:mime-version:subject:message-id:from;

cs35l34_runtime_suspend() currently switches the codec into
regcache_cache_only(true), asserts reset low, and powers the device off
without first quiescing the threaded IRQ registered by
devm_request_threaded_irq(). That leaves a window where
cs35l34_irq_thread() can still run after suspend has removed live
hardware access.

A running system can reach this during runtime PM while the driver still
has critical fault IRQs unmasked. If the threaded handler runs in that
window, it reads volatile INT_STATUS_1..4 after cache_only has been
enabled, ignores the regmap_read() failures, and can still execute the
PROT_RELEASE_CTL release sequence or the BST fault power-down writes.

Use disable_irq() before entering cache_only/reset-low/power-off so any
in-flight threaded handler is drained and no new IRQ thread can run
while the device is suspended. Re-enable the IRQ only after
runtime_resume() has restored live register access with regcache_sync().
Since probe only logs request_threaded_irq() failures and keeps going,
track whether the IRQ was actually installed before disabling or
re-enabling it.

Fixes: c1124c09e103 ("ASoC: cs35l34: Initial commit of the cs35l34 CODEC driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 sound/soc/codecs/cs35l34.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index a5a8075598ff..35bc38132f23 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -45,6 +45,7 @@ struct  cs35l34_private {
 	int num_core_supplies;
 	int mclk_int;
 	bool tdm_mode;
+	bool irq_requested;
 	struct gpio_desc *reset_gpio;	/* Active-low reset GPIO */
 };
 
@@ -1032,10 +1033,12 @@ static int cs35l34_i2c_probe(struct i2c_client *i2c_client)
 	}
 
 	ret = devm_request_threaded_irq(&i2c_client->dev, i2c_client->irq, NULL,
-			cs35l34_irq_thread, IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-			"cs35l34", cs35l34);
+				cs35l34_irq_thread, IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+				"cs35l34", cs35l34);
 	if (ret != 0)
 		dev_err(&i2c_client->dev, "Failed to request IRQ: %d\n", ret);
+	else
+		cs35l34->irq_requested = true;
 
 	cs35l34->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
 				"reset", GPIOD_OUT_LOW);
@@ -1140,6 +1143,9 @@ static int cs35l34_runtime_resume(struct device *dev)
 		dev_err(dev, "Failed to restore register cache\n");
 		goto err;
 	}
+
+	if (cs35l34->irq_requested)
+		enable_irq(to_i2c_client(dev)->irq);
 	return 0;
 err:
 	regcache_cache_only(cs35l34->regmap, true);
@@ -1153,6 +1159,10 @@ static int cs35l34_runtime_suspend(struct device *dev)
 {
 	struct cs35l34_private *cs35l34 = dev_get_drvdata(dev);
 
+	/* Drain and block the threaded IRQ before cache_only/power-off. */
+	if (cs35l34->irq_requested)
+		disable_irq(to_i2c_client(dev)->irq);
+
 	regcache_cache_only(cs35l34->regmap, true);
 	regcache_mark_dirty(cs35l34->regmap);
 
-- 
2.34.1
