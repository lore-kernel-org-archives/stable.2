Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913358FD20
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067470; cv=none; b=lt+EEh9WLYT1N8zgl/pNuqeAI6P8j3gncelEQv9HXurtlNhZlLvIaBkhusbaKhq3foJ3MoXunWGzBe3KC9BFbb8QV7DSTk2HvsogXnR2tcU0gXokWtra/WCDXNb8/3pfWYkeI0PhJdCbaljehy2cV+H0Ps+1jIUSNh2h8870Zl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067470; c=relaxed/simple;
	bh=akMxhNvnKxYkWdbW6Awm0TTa8znAa958/Tf9oYBL1x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HI1tpKEYyTO6zE+mQyVa1CbZW2IJNBTZzZ9CetTRg+KAZTLV5Y9nBTWE3fx7Mmtneo6wQfj5t78JImddqNHfvEtM4xN2abb8khmSpDLYYD6ch8kG5Atg2808DMmkyKT3gKTcL6x8+Fq2nYM7C/h6mNKxP9ZEbyWzQktADvHqpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8Z/wd86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8Z/wd86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780D11F0089A;
	Thu, 10 Sep 2026 19:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067469;
	bh=SC/CXZY/semrvaWdF84G9uQTdS23v1ii3CKvCSjw9kE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H8Z/wd86O22P7JjOB4soGgY71m3J8sNu18FfOGAIsqPjF+3HIsPSzXiBPAyFE2ALN
	 ZJzEDLqyCIC6m5D4VbglQdoHVfU7utjZxT0JKufbsKI4+u5Neb3joi+BBFjPSc8WVp
	 jSqQVp/PupTj1vA8kA7jyHiGFQeWcMk7Ua15+IXZFBa5E/ucfG/OyIZ1Gq8Hp6Zwav
	 uY+9RgOoa8VwHI2lljvsPTZLLv/4z3mDICOIXNkreCbyRiCo10myHHFi+pUKaANosX
	 /HqnAW5oY+DD8cTei6AkbYCB3kb9Mx5tmfv6fTo2vVSkIRYWeE69apKfh6H6gvfvEx
	 XiJrHY8Sk1G+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] i2c: qcom-cci: fix autosuspend cleanup
Date: Thu, 10 Sep 2026 15:11:02 -0400
Message-ID: <20260910191102.1467479-4-sashal@kernel.org>
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
index 4544772361435..30b0a47d95133 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -634,9 +634,11 @@ static int cci_probe(struct platform_device *pdev)
 		goto disable_clocks;
 
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
@@ -652,8 +654,6 @@ static int cci_probe(struct platform_device *pdev)
 	return 0;
 
 error_i2c:
-	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 
 	for (--i ; i >= 0; i--) {
 		if (cci->master[i].cci) {
@@ -679,9 +679,6 @@ static void cci_remove(struct platform_device *pdev)
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

