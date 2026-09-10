Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E358FD05
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067311; cv=none; b=GX4k1v/g47l6f0zWJ4NZ0Fnf1TOLNi4JyHLqa9MGKTTJp86xYIo8gEIP4T2VKz3wjpovdQ4Th7ljgtMO2wMX2Wa1H4GRRmDNmIejcfhrrNfHTPBlYmJmlcrbUMootJLarWHrms8gw9y8I9qQbXOAUC8wTUSGiUgcR7lHLF5QXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067311; c=relaxed/simple;
	bh=otv6vIdyANiSuEgKlVcuMIPiaa54rdopWY9VBNe7glE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEZ5QIT0sv64JYkGRmSTC0CvvHksOrscGGfVl2CtUm+2wkyWd1u1ujPD9GCRiw0HwLq2KtuirWHsqZXba8hGW3blJaHJnrY+WZl/EWnJxQpLOW5yy7f1kw7cs5Mb/KkBgob1uowmskVmnSJAixn11tu8qZMNGNJS3FyBnFgcNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb7EW24T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb7EW24T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15B11F0089B;
	Thu, 10 Sep 2026 19:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067309;
	bh=U55GZkdyFAKtUOZsYqCfn7znO0RqCoFw8vBWjLK6YOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pb7EW24TZqMqIPJdzw1nNRvs8/DgjBXIil2iUGT/YVhTQNZBeCWKNwSZr4cYBYYj/
	 HjRb5BE/OXnoC2ItpG3/evMqBs9GNsJ3ogBkQqI9cg+Sppq+u/S/dv710fkfrBu/Nm
	 y3ra4Cp2Q7jG1+TVEwsFyWWZeCvra9XCRtmvzadueBDtOpAqt6u5bW2b29fCkbAOiH
	 qQGc3qiLUCJMQfS1vxegUg/KvCRwn1sMKT6W5CqtdGAok5W9061qHcUVQ8RSEQgg/s
	 Is4DBtFxYiQQohJ4b8zq2296KtKVkIKCxvHAAwk3T1WPEnNZstNmdntEyh/rgBcJZs
	 EJPTy76B/9y6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] i2c: qcom-cci: fix autosuspend cleanup
Date: Thu, 10 Sep 2026 15:08:22 -0400
Message-ID: <20260910190822.1452673-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910190822.1452673-1-sashal@kernel.org>
References: <2026090909-unmarked-juggling-ce1d@gregkh>
 <20260910190822.1452673-1-sashal@kernel.org>
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
index d91c9f8e15551..731ba28361674 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -635,9 +635,11 @@ static int cci_probe(struct platform_device *pdev)
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

