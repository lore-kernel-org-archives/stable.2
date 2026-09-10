Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3A335081
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058816; cv=none; b=YcSCPSRUt3Qjv+0jpoSCwlaHF6D28c3hGH17+uhCMGONimhQ65SVDeswrcTDf67ILiEqbqjgaZFRXQYDdDi2F/4/8Et9y/IKBmp7IKORmK9CoNsLEMUTwm4mOeIklYJ93M4dZMPSE+cX0Bw4g7uuHkG3gV0XXaqxFHt+joj4kAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058816; c=relaxed/simple;
	bh=VHoUuGw5voYo1FQDhRMnS7MPVbz8r0vCWszTauMKPbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gG3YKGT0C18P7Iwr7OSy2RQtTISX/euDuv5OqZd1Af/6oZQ1txG/F6KPPyIngjdvHxVuBCn1jyT4ivA7hgQqPxsbrp0U+02HIjHorq8X0HVLFemdLij0+GfLXiOTnkRu1jd2tceY6TyfU1ugajrKpWA6ZrqLuOWBI21koHBQJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3BSnzss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3BSnzss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1924C1F0089A;
	Thu, 10 Sep 2026 16:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058807;
	bh=p7D4Zvj+NZynas1AW0sHEcRxUEzS9OISa3R5dR8vCdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X3BSnzssGoDLEs3ydAQQr/Lc0tZcLFSnx77N1UlGKiMFrQPied+rrGMmkzomzY4dG
	 cUdmoVy4J5GvGdNcMxsSmxa3j4OCRIjN+0q6d1VvOi3TJgqZgV5zTGstEpDuotBwo9
	 PWrMooKQfPcbJSoA5g4MZ+ldBiMgEE9ClL4Npz9Dx6wLgELFv5VK4ZKcbM0J9/7kcC
	 ZD+/hmWxz8rwBPeFwhFNBWH87R5R9Uufhq+uLHT3dQlMg9BNgGKBtedpMbv8pXi4B7
	 t+cfBC5TiIoxMDLFo46CMlyPNsoPrfWbbxwYV4IASVe7+npP4Kb6G0pKS43QQQ+PZl
	 PTR44nzVLPvag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] i2c: qcom-cci: fix autosuspend cleanup
Date: Thu, 10 Sep 2026 12:46:42 -0400
Message-ID: <20260910164643.1250786-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910164643.1250786-1-sashal@kernel.org>
References: <2026090908-bobbing-backlog-313f@gregkh>
 <20260910164643.1250786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit f98d4986482151a835b521a734722fe8dc5ca37d ]

cci_probe() calls pm_runtime_use_autosuspend(), but the remove path
does not call the matching pm_runtime_dont_use_autosuspend() before
disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without undoing the autosuspend setting during
teardown, this reference is not dropped and usage_count remains
unbalanced.

Use devm_pm_runtime_set_active_enabled() to manage the runtime PM
state. Its managed cleanup disables autosuspend and runtime PM and
restores the suspended state on probe failure and driver removal.
Remove the now redundant manual runtime PM cleanup.

This issue was found by manual code inspection.

Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20260812094425.3515179-1-lgs201920130244@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 57608846a98a1..776c3e36e9152 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -599,9 +599,11 @@ static int cci_probe(struct platform_device *pdev)
 	cci_init(cci);
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		goto disable_clocks;
+
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
 
 	for (i = 0; i < cci->data->num_masters; i++) {
 		if (!cci->master[i].cci)
@@ -617,8 +619,6 @@ static int cci_probe(struct platform_device *pdev)
 	return 0;
 
 error_i2c:
-	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 
 	for (--i ; i >= 0; i--) {
 		if (cci->master[i].cci) {
@@ -644,9 +644,6 @@ static void cci_remove(struct platform_device *pdev)
 			cci_halt(cci, i);
 		}
 	}
-
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 }
 
 static const struct cci_data cci_v1_data = {
-- 
2.53.0

