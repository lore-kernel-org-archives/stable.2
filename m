Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5C3ACA4B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948966; cv=none; b=XaMWkYj53GdzBgl7ilLcDWfWovFntPAXylzgM2BlGqrQvp0Iu6sflnremNXlsgjY0iJKXn4ERctp+aMUwe3+71FdwN2AGQurA0H8dwfJOPiw4FS7jeUrFu6Uuj+zNcdsWJnaiJfZS5cEFCyOyQbOEpNjHgPS8WQuHuJ2Jn2myIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948966; c=relaxed/simple;
	bh=dbXT2ZlPG/TNfW27ZTXVmfXZY6qF3o72B7dhX+OB1D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLnqG2cEYt42Bjzbp1lmJ/HfrtlFf5XTqxgGBBKnmMvmZ5fnQMNWg3NxJB6jeLRNMSfqYJP+hKR6wCfXq1lkRZc+op8i3J6uSEIGrDK79TOrkm0gbo8E0GKQ69nbrxQ3WQGT/AEYTGMyL9SJs3Pl/XBpFz9koQk4EPlotRY5wQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6usTMsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6usTMsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49321F00ACA;
	Wed,  9 Sep 2026 10:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948956;
	bh=6Mag3S7sSAgE2c0SllP4sxze24k3BVLAFtuSPJQkdJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X6usTMsQgvA36CO1C12AFdxEG6ycwhOBSRqwI6Bxd51JM6TewGo2ucCV0mWoFhKJB
	 qApay/e8imVKTc40bmWM8N+AzQ4bIlekxPYHts14P9H9sTAkc2VfnxFf3x6Y1aNlQ+
	 hYcq/UmBFGT9TWDnuQBPNXDFHQLimbbIjbD6oZ32GCHbamvK2s5/6CUemP6TuCsh8C
	 UZjzd0QEtat1T3r5zmTABA7qoLdKh6fnOuCqJbJlG2hY/dW2oJ+rhtiGn6vRVq0E9q
	 7s88jppkoQX6gBAo7ekgiViulKw53yQP03JX4yHdU3a0c/Fk2g7dggKwJ+7Gu+s9pW
	 q9IeFNlvb423g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Val Packett <val@packett.cool>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ASoC: codecs: aw88261: reduce log spam
Date: Wed,  9 Sep 2026 06:15:53 -0400
Message-ID: <20260909101554.1482003-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090347-flagstick-stinger-0d57@gregkh>
References: <2026090347-flagstick-stinger-0d57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Val Packett <val@packett.cool>

[ Upstream commit d90c361af215a9fa2a986d9f47d554d0cf3401dd ]

This driver would create a wall of logspam during initialization due to
e.g. the PLL not being ready while waiting for it to stabilize. Change
intermediate dev_err() calls to dev_dbg() to reduce the noise.

While here, log the detected chip ID when that check fails.

Signed-off-by: Val Packett <val@packett.cool>
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Link: https://patch.msgid.link/20260529200550.529719-4-val@packett.cool
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 06b6f1245567 ("ASoC: codecs: aw88261: only check PLL and clock state at power-up")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/aw88261.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index 999461885a62e..66a46b42d521f 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -150,7 +150,7 @@ static int aw88261_dev_get_iis_status(struct aw_device *aw_dev)
 	if (ret)
 		return ret;
 	if ((reg_val & AW88261_BIT_PLL_CHECK) != AW88261_BIT_PLL_CHECK) {
-		dev_err(aw_dev->dev, "check pll lock fail,reg_val:0x%04x", reg_val);
+		dev_dbg(aw_dev->dev, "check pll lock fail,reg_val:0x%04x", reg_val);
 		return -EINVAL;
 	}
 
@@ -164,7 +164,7 @@ static int aw88261_dev_check_mode1_pll(struct aw_device *aw_dev)
 	for (i = 0; i < AW88261_DEV_SYSST_CHECK_MAX; i++) {
 		ret = aw88261_dev_get_iis_status(aw_dev);
 		if (ret) {
-			dev_err(aw_dev->dev, "mode1 iis signal check error");
+			dev_dbg(aw_dev->dev, "mode1 iis signal check error");
 			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
 		} else {
 			return ret;
@@ -255,7 +255,7 @@ static int aw88261_dev_check_sysst(struct aw_device *aw_dev)
 		check_val = reg_val & (~AW88261_BIT_SYSST_CHECK_MASK)
 							& AW88261_BIT_SYSST_CHECK;
 		if (check_val != AW88261_BIT_SYSST_CHECK) {
-			dev_err(aw_dev->dev, "check sysst fail, reg_val=0x%04x, check:0x%x",
+			dev_dbg(aw_dev->dev, "check sysst fail, reg_val=0x%04x, check:0x%x",
 				reg_val, AW88261_BIT_SYSST_CHECK);
 			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
 		} else {
@@ -549,7 +549,7 @@ static int aw88261_dev_start(struct aw88261 *aw88261)
 	int ret;
 
 	if (aw_dev->status == AW88261_DEV_PW_ON) {
-		dev_info(aw_dev->dev, "already power on");
+		dev_dbg(aw_dev->dev, "already power on");
 		return 0;
 	}
 
@@ -559,7 +559,7 @@ static int aw88261_dev_start(struct aw88261 *aw88261)
 
 	ret = aw88261_dev_check_syspll(aw_dev);
 	if (ret) {
-		dev_err(aw_dev->dev, "pll check failed cannot start");
+		dev_dbg(aw_dev->dev, "pll check failed");
 		goto pll_check_fail;
 	}
 
@@ -570,7 +570,7 @@ static int aw88261_dev_start(struct aw88261 *aw88261)
 	/* check i2s status */
 	ret = aw88261_dev_check_sysst(aw_dev);
 	if (ret) {
-		dev_err(aw_dev->dev, "sysst check failed");
+		dev_dbg(aw_dev->dev, "sysst check failed");
 		goto sysst_check_fail;
 	}
 
@@ -671,18 +671,22 @@ static void aw88261_start_pa(struct aw88261 *aw88261)
 	for (i = 0; i < AW88261_START_RETRIES; i++) {
 		ret = aw88261_reg_update(aw88261, aw88261->phase_sync);
 		if (ret) {
-			dev_err(aw88261->aw_pa->dev, "fw update failed, cnt:%d\n", i);
+			dev_dbg(aw88261->aw_pa->dev,
+				"aw88261_reg_update failed, cnt:%d, ret:%d\n", i, ret);
 			continue;
 		}
 		ret = aw88261_dev_start(aw88261);
 		if (ret) {
-			dev_err(aw88261->aw_pa->dev, "aw88261 device start failed. retry = %d", i);
+			dev_dbg(aw88261->aw_pa->dev,
+				"aw88261_dev_start failed, cnt:%d, ret:%d\n", i, ret);
 			continue;
 		} else {
-			dev_info(aw88261->aw_pa->dev, "start success\n");
+			dev_dbg(aw88261->aw_pa->dev, "start success\n");
 			break;
 		}
 	}
+	if (ret != 0)
+		dev_err(aw88261->aw_pa->dev, "start failure (%d)\n", ret);
 }
 
 static void aw88261_startup_work(struct work_struct *work)
@@ -1200,7 +1204,7 @@ static int aw88261_init(struct aw88261 **aw88261, struct i2c_client *i2c, struct
 		return ret;
 	}
 	if (chip_id != AW88261_CHIP_ID) {
-		dev_err(&i2c->dev, "unsupported device");
+		dev_err(&i2c->dev, "unsupported device id = %x", chip_id);
 		return -ENXIO;
 	}
 
-- 
2.53.0

