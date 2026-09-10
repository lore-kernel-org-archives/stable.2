Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8C1511E98
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058981; cv=none; b=WDy9VGbsbNsEHbOYcyPVAX0AZCurZ8W77NS5eKTuEaEomQJ6Qpd/xyprJNP10tKUpzbqmz4g+qv2aw9JWpiY4QX0kNkSdxlcvnTZIXbPAp35hAD1QR7QorfyX29L+idbJZsSqboe2ZjkwZaMnV9GZK0SZZHP050Cv2edsI901us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058981; c=relaxed/simple;
	bh=r9bKV4ZlDzjxYkzbed0YwrNfkXm8cYobnba1BDXFJM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZW8ztRPEFltrVlBBNJ47mX/2DIELLqO+EP9PTkrkTWWiqymQCneUUKyTyMvQ+a2pDkpE7VLCT4eqjIJg7lX4C1MPSnc9UpjnHoi32VSuTwre+l2ROrwrO0HZgPhy3N74VsJTBq6h4Z/aBhibnr3cLYeItpAM6P5pmOmr50rXLEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SINiib7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SINiib7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64621F00899;
	Thu, 10 Sep 2026 16:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058979;
	bh=jmGHcH9YRlW22BhD5vAk7lHYwfpyqC+f6BnME4fdLmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SINiib7lkOHUm+gg1Zj2xZj152hDoACAQlIDWIRtJWUffxubLr3KDVF84YNTnqXz3
	 L3A0MKdccPmQXwUtp7+Khb/PloG58n93XUB3v165p0W6iQTFqeRtSkHeDfcZO5qUC5
	 RyGhdII0zT5cmsl/IWfpimnUkn9hAHP053LmDRrAK2Yu9HOyHwxNcB+d6+pj10AwqX
	 t2TvJzu2Tcbqkxf0Hw8/0H5B60SjmsrGdQ83dzkBUqf9/1BB44ecElwzHrqsy7qSKJ
	 VBwr6c8utKz26PMqNQKDwHc28GlmAGfshvdwebXocIcmWIbbBgIdA2G0B9bPOuh0XP
	 5RVDPMpZtte6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] i2c: qcom-cci: fix autosuspend cleanup
Date: Thu, 10 Sep 2026 12:49:35 -0400
Message-ID: <20260910164935.1257325-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910164935.1257325-1-sashal@kernel.org>
References: <2026090908-parrot-escargot-18fb@gregkh>
 <20260910164935.1257325-1-sashal@kernel.org>
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
index 2cbf47052d8da..9998e8cf9b649 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -635,9 +635,11 @@ static int cci_probe(struct platform_device *pdev)
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
@@ -653,8 +655,6 @@ static int cci_probe(struct platform_device *pdev)
 	return 0;
 
 error_i2c:
-	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 
 	for (--i ; i >= 0; i--) {
 		if (cci->master[i].cci) {
@@ -680,9 +680,6 @@ static void cci_remove(struct platform_device *pdev)
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

