Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13976395AD2;
	Thu, 11 Jun 2026 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194881; cv=none; b=OPSWQ6MJoOwbk563zqDAp4K0mUn5AFyVufkWTr9rxLWsJEALFbbkywHoLEFwl9/dc2mi5SeqeaqA5mbb9BBIa5gXPPXdkzgJgTacXeJb7kT31H7zzdcpu9eQSFDrWqMwxXz76TqvRL0fW7l+Ukz/P5bNH1oR0wXQOSq3TugDiVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194881; c=relaxed/simple;
	bh=XJc86QB+5kL1ZRVdMFWfLc4uKAaSmvYsb3ACW49+rOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c/7Uslj0aIJQIyGYnJGDFgLOp+4DS4yYfH8j6Nc4sUh2AsvOb7dn+vIbrUbnl0SZXeme/hFfy1w+qS1LjKYnWQu16yw6Z5Vyh4jK9EsBn4m1uFwp2nc2oyuEft//FQ1M1QMmXvHiAtYiLxilN3h0Fiyl5d5tZGqrxN65UJ5psCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ZSHyf1vQ; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ZSHyf1vQ"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 420765ea9;
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
Subject: [PATCH 1/2] ASoC: cs35l33: drain threaded IRQ before runtime suspend
Date: Fri, 12 Jun 2026 00:15:52 +0800
Message-Id: <20260611161553.3378721-2-runyu.xiao@seu.edu.cn>
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
X-HM-Tid: 0a9eb7782d8303a1kunmccb51b6d16b65a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSRhMVhoaGUpLTU9CTkMdSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZSHyf1vQnAq1O4g3mJTHAD+EnfM0bKcmCetFhXcDC8gbb8fnNb73QlC4Cexq+rMneVijjojALUfsTQ1ShWXSIQqN5BBsbBlByvMx1/lMfiRiOU7ghROWvbjT0l8QUKh5Jtm9D9R+UeJ0xlsM7VrAzQyJ51OmL7kpqamrVWI9Yqo=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=JcD5WughWGOu5c6ypcsnW+u0HANazIyLykF4ul8LDwg=;
	h=date:mime-version:subject:message-id:from;

cs35l33_runtime_suspend() currently switches the codec into
regcache_cache_only(true) and powers it down without first quiescing the
threaded IRQ registered by devm_request_threaded_irq(). That leaves a
window where cs35l33_irq_thread() can still run after suspend has closed
off live register access.

A running system can reach this during runtime PM while the driver still
has critical fault IRQs unmasked. If the threaded handler runs in that
window, it reads volatile INT_STATUS_1/2 after cache_only has been
enabled, ignores the regmap_read() failures, and can still drive the
AMP_SHORT_RLS, CAL_ERR_RLS, OTE_RLS, and OTW_RLS release paths.

Use disable_irq() before entering cache_only/power-off so any in-flight
threaded handler is drained and no new IRQ thread can run during the
suspended state. Re-enable the IRQ only after runtime_resume() has
restored live register access with regcache_sync(). Since probe only
warns if devm_request_threaded_irq() fails, track whether the IRQ was
actually installed before disabling or re-enabling it.

Fixes: 3333cb7187b9 ("ASoC: cs35l33: Initial commit of the cs35l33 CODEC driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 sound/soc/codecs/cs35l33.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index c927592f90c9..af9dad199084 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -40,6 +40,7 @@ struct cs35l33_private {
 	struct regmap *regmap;
 	struct gpio_desc *reset_gpio;
 	bool amp_cal;
+	bool irq_requested;
 	int mclk_int;
 	struct regulator_bulk_data core_supplies[2];
 	int num_core_supplies;
@@ -881,6 +882,9 @@ static int cs35l33_runtime_resume(struct device *dev)
 		goto err;
 	}
 
+	if (cs35l33->irq_requested)
+		enable_irq(to_i2c_client(dev)->irq);
+
 	return 0;
 
 err:
@@ -900,6 +904,10 @@ static int cs35l33_runtime_suspend(struct device *dev)
 	/* redo the calibration in next power up */
 	cs35l33->amp_cal = false;
 
+	/* Drain and block the threaded IRQ before cache_only/power-off. */
+	if (cs35l33->irq_requested)
+		disable_irq(to_i2c_client(dev)->irq);
+
 	regcache_cache_only(cs35l33->regmap, true);
 	regcache_mark_dirty(cs35l33->regmap);
 	regulator_bulk_disable(cs35l33->num_core_supplies,
@@ -1154,10 +1162,12 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client)
 	}
 
 	ret = devm_request_threaded_irq(&i2c_client->dev, i2c_client->irq, NULL,
-			cs35l33_irq_thread, IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-			"cs35l33", cs35l33);
+				cs35l33_irq_thread, IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+				"cs35l33", cs35l33);
 	if (ret != 0)
 		dev_warn(&i2c_client->dev, "Failed to request IRQ: %d\n", ret);
+	else
+		cs35l33->irq_requested = true;
 
 	/* We could issue !RST or skip it based on AMP topology */
 	cs35l33->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
-- 
2.34.1
