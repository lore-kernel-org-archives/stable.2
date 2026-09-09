Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9F751357F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950073; cv=none; b=I7L5/3/VaOE3djLA8XmraBts0epqDRpFYpWqKDXo1FmQZ94Y4CKr1UWDYsuoOi+8NJiqknFCMBkvGulWQaHwWx8UMxl35M4OnJNtcjTUXr5VIslRv8mVGydVUj5RhS04Zm+KNyd9ER9GBjj8LJ+AMID0rQwT7n3MwtAICsAIUUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950073; c=relaxed/simple;
	bh=Pgdgc4qgT6Tj7MyCW58K/rF0lzQ+qv1T4CdybBrO6Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3m1QhmnVEZoRB/SdRlsUniG+ILcv3cSVYwLW5nKGR0+dythFG/AF0VHYyhDtdJVmB/3N2Wc9gRb6kSDq0UcdOE4fmbq7g8zsVq1rG7xSYhojLLwzAt4UempRPgMDdjv7SYL7NDuE7kaVN4SwG7PM3vkXumNNV8QaiZK9MbrAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQSrXxGW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQSrXxGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0983D1F00A3E;
	Wed,  9 Sep 2026 10:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950071;
	bh=d/32otrSXfz1bw8VvmU5sHXEAanwc62U9hHktrQcs5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQSrXxGWnt1QM7KRtdAj2kMxiJZlx4m7RWr0tQey/lhFsQNvxNrxjFIRh4N2JkQ20
	 T71VTz25F5T1BSC0xbZ8JYppYsH4yQfzbGyWoTHFuuzSZ54dj94o9hvUHS8brexVs8
	 PQ2vns1F1NtdepRjnoea9vQoAufeP76GXtMmsnmJKcEo4727ye6oyhezGrX2YNrnCb
	 Us7UlFds/Fk9uya5yUo8wyeevaYHjUNrUHgL8e8CnsnYsOPq3mZXEl/mg4aT7b9I6n
	 iIXmtt68+ObRd3px3EZs/HdX6F9qbqf+E70yGMPPbIhVCbnEPn1YZWB5DdbZRfAuBY
	 jxuh3JHiCHZWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Val Packett <val@packett.cool>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ASoC: codecs: aw88261: reduce log spam
Date: Wed,  9 Sep 2026 06:34:28 -0400
Message-ID: <20260909103429.1544487-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090348-garment-snowdrift-7618@gregkh>
References: <2026090348-garment-snowdrift-7618@gregkh>
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
index eed05b2508dd7..9019a12cd0f03 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -151,7 +151,7 @@ static int aw88261_dev_get_iis_status(struct aw_device *aw_dev)
 	if (ret)
 		return ret;
 	if ((reg_val & AW88261_BIT_PLL_CHECK) != AW88261_BIT_PLL_CHECK) {
-		dev_err(aw_dev->dev, "check pll lock fail,reg_val:0x%04x", reg_val);
+		dev_dbg(aw_dev->dev, "check pll lock fail,reg_val:0x%04x", reg_val);
 		return -EINVAL;
 	}
 
@@ -165,7 +165,7 @@ static int aw88261_dev_check_mode1_pll(struct aw_device *aw_dev)
 	for (i = 0; i < AW88261_DEV_SYSST_CHECK_MAX; i++) {
 		ret = aw88261_dev_get_iis_status(aw_dev);
 		if (ret) {
-			dev_err(aw_dev->dev, "mode1 iis signal check error");
+			dev_dbg(aw_dev->dev, "mode1 iis signal check error");
 			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
 		} else {
 			return ret;
@@ -256,7 +256,7 @@ static int aw88261_dev_check_sysst(struct aw_device *aw_dev)
 		check_val = reg_val & (~AW88261_BIT_SYSST_CHECK_MASK)
 							& AW88261_BIT_SYSST_CHECK;
 		if (check_val != AW88261_BIT_SYSST_CHECK) {
-			dev_err(aw_dev->dev, "check sysst fail, reg_val=0x%04x, check:0x%x",
+			dev_dbg(aw_dev->dev, "check sysst fail, reg_val=0x%04x, check:0x%x",
 				reg_val, AW88261_BIT_SYSST_CHECK);
 			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
 		} else {
@@ -548,7 +548,7 @@ static int aw88261_dev_start(struct aw88261 *aw88261)
 	int ret;
 
 	if (aw_dev->status == AW88261_DEV_PW_ON) {
-		dev_info(aw_dev->dev, "already power on");
+		dev_dbg(aw_dev->dev, "already power on");
 		return 0;
 	}
 
@@ -558,7 +558,7 @@ static int aw88261_dev_start(struct aw88261 *aw88261)
 
 	ret = aw88261_dev_check_syspll(aw_dev);
 	if (ret) {
-		dev_err(aw_dev->dev, "pll check failed cannot start");
+		dev_dbg(aw_dev->dev, "pll check failed");
 		goto pll_check_fail;
 	}
 
@@ -569,7 +569,7 @@ static int aw88261_dev_start(struct aw88261 *aw88261)
 	/* check i2s status */
 	ret = aw88261_dev_check_sysst(aw_dev);
 	if (ret) {
-		dev_err(aw_dev->dev, "sysst check failed");
+		dev_dbg(aw_dev->dev, "sysst check failed");
 		goto sysst_check_fail;
 	}
 
@@ -670,18 +670,22 @@ static void aw88261_start_pa(struct aw88261 *aw88261)
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
@@ -1210,7 +1214,7 @@ static int aw88261_init(struct aw88261 **aw88261, struct i2c_client *i2c, struct
 		return ret;
 	}
 	if (chip_id != AW88261_CHIP_ID) {
-		dev_err(&i2c->dev, "unsupported device");
+		dev_err(&i2c->dev, "unsupported device id = %x", chip_id);
 		return -ENXIO;
 	}
 
-- 
2.53.0

