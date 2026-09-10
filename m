Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075ED5328B9
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058979; cv=none; b=jXKHE8BtXK/+EcKV0pRC8wNUIpz1FTc5yPv/xfr1ctbZRj6mtI0wqC5l2MD/1ph8I5Tsk3tnyChBIgF9k6qlPW9woBjWVys7EvoouCN9o2TAO/0Ly8+/hTg7Gu7YgwCs8kiBpu2VlihUz2PlcM2xT+saUN0o5K4UtlZL/NkrgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058979; c=relaxed/simple;
	bh=HktelD7xSN2tppNo8fDUaoTFtCs+tPOIIu5e4/S1bMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhGdnL6DRUK3L9CaeXHpFf6rwUMq3Qhs3TGYBbq+nXy2LrAQGisVJXAIMpVFUYGaXy0ztkh0stG1FRYOLZmakIeZWPHl1Gi3alGT3HdpRa1UTnd3zwOprifGIOgotiS8Pd3AmVNsiUDXTjji/yqCXmT0F/jDkD7aNidn3sxYckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDRUi4W+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDRUi4W+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE80B1F000FF;
	Thu, 10 Sep 2026 16:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058977;
	bh=HbFmMnAQo9hSXCZ6zkcSErWNZuWPTLf2AANeem+l56U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XDRUi4W+eZ/xIcMRYKN6ChENMKqWQmlNC2956FUgQQB+gBaG/f6P81AmKy+GIkkSq
	 4sqCbHSxCNbpAeMOIiO+rc3nMh4JcmH2ZQd11QqNgzGUmz4vGSfKQKxgOk35tdih4h
	 Uok1gM+sLKpEt6ZuBz9npSWlWGRa9eW54SaBH5tKyYaQWxM7MjWy9K+4xHbrunpaIr
	 MpJE1rOqC3OvDFnoMreMeBqE6Y4QYCMeG+Uho8iFGNO0nRgMD0khSurTE9ZMIAbJGT
	 zbr42zX55idQxMo+wkVf1J6z07ItxwqJSYygTJVG9VW5Tcb3PxEZM2NwMt5gvsADE4
	 eP+HN0r4ob2Rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] i2c: qcom-cci: Do not check return value of cci_init()
Date: Thu, 10 Sep 2026 12:49:33 -0400
Message-ID: <20260910164935.1257325-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090908-parrot-escargot-18fb@gregkh>
References: <2026090908-parrot-escargot-18fb@gregkh>
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
Stable-dep-of: f98d49864821 ("i2c: qcom-cci: fix autosuspend cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 85de659bb3627..bcc67427b6c3f 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -247,7 +247,7 @@ static int cci_reset(struct cci *cci)
 	return 0;
 }
 
-static int cci_init(struct cci *cci)
+static void cci_init(struct cci *cci)
 {
 	u32 val = CCI_IRQ_MASK_0_I2C_M0_RD_DONE |
 			CCI_IRQ_MASK_0_I2C_M0_Q0_REPORT |
@@ -288,8 +288,6 @@ static int cci_init(struct cci *cci)
 		val = hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->tsp;
 		writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
 	}
-
-	return 0;
 }
 
 static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
@@ -634,9 +632,7 @@ static int cci_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto error;
 
-	ret = cci_init(cci);
-	if (ret < 0)
-		goto error;
+	cci_init(cci);
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
-- 
2.53.0

