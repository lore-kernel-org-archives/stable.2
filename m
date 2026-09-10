Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A8258F067
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067469; cv=none; b=CPzm/XLEt9S3ytUole/IkzZx1JZL3v2LezJ7NIYHp/1/TpFcQPBj4CaEprIs80rHP5BeBlEk0RhkYcQy83PCJbxRzELfHlpD62Qe29Y31h9DaG4DnF7USP5A2/xt98zZm2a+hcRxhr6sy4aEYPer3xPCsyL5MKQ/U177YWmF6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067469; c=relaxed/simple;
	bh=Fyr7+LFs9AarTPhE5/LNp7k9xNQ4YXWIuQIhWkoYI40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kb/M/3Q5PnAywgPJDn4KSxyzGu25uKnKCtwF2PZDHon0sXBWbgH0Nm1PGvFNzj+byFEbtCs7TG8ofh/MTGhurSH9NU8R9ci2zp+raxGPXwIAOC57RqTiaSOUOkEUAOUzWuY095jpIOk65v0RGWT/U+GWEDrU8p0SByiLHgONapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caUpIx9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caUpIx9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C30D1F00898;
	Thu, 10 Sep 2026 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067468;
	bh=bLTCktLAUxyA9nQFBcvp4r0Wvphzpn4aySV0gBOIJeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=caUpIx9HyYwg5OLIfzuS3HKGS/XiiKkRdjxi71Shp+fH4iWmHGdD6iZYzcs5YBcph
	 Oz9751AsF7wLx+PJHcqMfrAWp1K8IwVF02AUFPHyjxwgoaTqO3+EEweP4losGkfgAj
	 kxM+z4P/UJB80fohoWfEZria3ooOaXlAqGdrtt/3qiyL12aG814G0TsfOoCJc9AknV
	 k57FaxEP0lmoGeoWlFjJgE2zJCjChE3mIt+fO0h/DU9cCl36ktsY2i8ZW/S+AC8KmM
	 cE4W89UMA9ot/zb5HDpHwdqjBpxQZOoW5izGrfkSXWXYK/ZwQa5U+zhQjEN8o08PsU
	 1CYJHNZtCb4jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] i2c: qcom-cci: Do not check return value of cci_init()
Date: Thu, 10 Sep 2026 15:11:01 -0400
Message-ID: <20260910191102.1467479-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910191102.1467479-1-sashal@kernel.org>
References: <2026090909-palpitate-shortage-3ec4@gregkh>
 <20260910191102.1467479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

[ Upstream commit 17c5d247e3e4708cac05ff087c8013c0dda383a2 ]

The cci_init() function is not supposed to fail, and it never returns
a non-zero, so it'd make sense to convert its signature to void.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260515234121.1607425-3-vladimir.zapolskiy@linaro.org

For this stable dependency, retain the existing disable_clocks cleanup
path while removing the impossible cci_init() error check.

Also fold in the initialization/reset adjustment from upstream
697d58d457e999a03c7c395ff0fbf13e765f0997 ("i2c: qcom-cci: Move
cci_init() under cci_reset() function"). Reorder the existing functions,
call cci_init() after a successful reset, and remove the now redundant
initialization calls from probe and queue timeout recovery. No functions
are added. Runtime resume continues to call cci_init() directly.

This supplies the probe context required to apply
f98d4986482151a835b521a734722fe8dc5ca37d ("i2c: qcom-cci: fix
autosuspend cleanup") without conflicts. Keep the stable tree's clock,
I2C callback, IRQ cleanup, and platform remove adaptations.

Stable-dep-of: f98d49864821 ("i2c: qcom-cci: fix autosuspend cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 43 ++++++++++++++-----------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index b3ccbea140e9d..4544772361435 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -229,25 +229,7 @@ static int cci_halt(struct cci *cci, u8 master_num)
 	return 0;
 }
 
-static int cci_reset(struct cci *cci)
-{
-	/*
-	 * we reset the whole controller, here and for implicity use
-	 * master[0].xxx for waiting on it.
-	 */
-	reinit_completion(&cci->master[0].irq_complete);
-	writel(CCI_RESET_CMD_MASK, cci->base + CCI_RESET_CMD);
-
-	if (!wait_for_completion_timeout(&cci->master[0].irq_complete,
-					 CCI_TIMEOUT)) {
-		dev_err(cci->dev, "CCI reset timeout\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-
-static int cci_init(struct cci *cci)
+static void cci_init(struct cci *cci)
 {
 	u32 val = CCI_IRQ_MASK_0_I2C_M0_RD_DONE |
 			CCI_IRQ_MASK_0_I2C_M0_Q0_REPORT |
@@ -288,6 +270,24 @@ static int cci_init(struct cci *cci)
 		val = hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->tsp;
 		writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
 	}
+}
+
+static int cci_reset(struct cci *cci)
+{
+	/*
+	 * we reset the whole controller, here and for implicity use
+	 * master[0].xxx for waiting on it.
+	 */
+	reinit_completion(&cci->master[0].irq_complete);
+	writel(CCI_RESET_CMD_MASK, cci->base + CCI_RESET_CMD);
+
+	if (!wait_for_completion_timeout(&cci->master[0].irq_complete,
+					 CCI_TIMEOUT)) {
+		dev_err(cci->dev, "CCI reset timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	cci_init(cci);
 
 	return 0;
 }
@@ -308,7 +308,6 @@ static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
 		dev_err(cci->dev, "master %d queue %d timeout\n",
 			master, queue);
 		cci_reset(cci);
-		cci_init(cci);
 		return -ETIMEDOUT;
 	}
 
@@ -634,10 +633,6 @@ static int cci_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto disable_clocks;
 
-	ret = cci_init(cci);
-	if (ret < 0)
-		goto disable_clocks;
-
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_active(dev);
-- 
2.53.0

