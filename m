Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7552352C35
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973437; cv=none; b=LEIDPG6CU3p+UG7YaesKI3BhxsMDZLvDQxnLMuD586hUhpGF7EENLH0yyPUKJR4fF1kqbgnD73Du3I/G/4f38Aij3ewJh2HTFA14F+Tp21zRCPOMIXXfsCNWlT0lD9Bz4O+39dbJG3W/mtzOwFOXrrIhWQbGOEypU31Ge8EItE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973437; c=relaxed/simple;
	bh=o+8VC0ZZ3sCADNbrkgWwYoVfi7IE8oto4aqHPKtjf/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XE1FXWIA424e3oNvaCYxXnr4j5GNFaChfWF01x5ZFHLKRl6suHHN7zcDvm4ws4w99rk0fPH7eS3W342nB5BbS4o0bXXfBCHn6jbUpXgc0rDeS8IFXLlsImpNEuzf6EnfVcqKu9gfGN/jV10aZ/wPZ780QTRMr3KuxwZcTwiSdck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/SUTU63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/SUTU63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BF41F00899;
	Wed,  9 Sep 2026 17:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973434;
	bh=O6KTAV0VxukJZYWLeXP/LPWV0xqDmKBtj85hs+DxMsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g/SUTU63AWmCDxhZ21DWTYIKbA57blLevdfhLptvX0eljED/yFKK/MwQurQxaxG+q
	 MGaMn+SxIGYCmSJu/Hx5hnZNroVaXhLPpBlQvftmoG8h5bXQb2bylmM2MW3EAzxofI
	 GWQPnlyLM1QeTjULADHOeoUnoHPEVliAa975i6zzcGAGWzvTtqTxRAuWNbZqC+Y+7j
	 H0Qhmc43wfsxco8vGzoTjHaIUGuViITbHPkrWYNPSZ5wZSn/7Co/PC0Ni/nzQHpaaF
	 O3cayG2eMhNA0+npTBioYaQjrX25O2hLO0M0Xf3l//BwtFN0dZ+nIufWawAHHAe5It
	 5xw6PdYMYDgmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Lucas Stach <l.stach@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] power: supply: ucs1002: fix use-after-free on remove
Date: Wed,  9 Sep 2026 13:03:50 -0400
Message-ID: <20260909170350.3177206-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909170350.3177206-1-sashal@kernel.org>
References: <2026090327-abiding-enamel-2481@gregkh>
 <20260909170350.3177206-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 609af0ceeaefdfa42cd01dd060b20f2e41f9a232 ]

ucs1002 has no remove callback, so unbind runs entirely through devm.
The alert IRQ handler queues the health_poll delayed work, and the work
reschedules itself while the chip reports a bad-health condition.  devm
frees the alert IRQ, which only synchronizes the handler; it does not
cancel the delayed work, which can then run after devm frees the driver
data and dereference it.

Register health_poll with devm_delayed_work_autocancel() before the
alert IRQ is requested.  devm then frees the IRQ before cancelling the
work, so the handler can no longer queue it and the work is cancelled
before the driver data is freed.

This issue was found by an in-house static analysis tool.

Fixes: 81196e2e57fc ("power: supply: ucs1002: fix some health status issues")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Link: https://patch.msgid.link/20260802051249.424015-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ucs1002_power.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index 332cb50d9fb4f..ee3c1e6888c24 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -644,7 +645,10 @@ static int ucs1002_probe(struct i2c_client *client,
 	}
 
 	info->health = POWER_SUPPLY_HEALTH_GOOD;
-	INIT_DELAYED_WORK(&info->health_poll, ucs1002_health_poll);
+	ret = devm_delayed_work_autocancel(dev, &info->health_poll,
+					   ucs1002_health_poll);
+	if (ret)
+		return ret;
 
 	if (irq_a_det > 0) {
 		ret = devm_request_threaded_irq(dev, irq_a_det, NULL,
-- 
2.53.0

