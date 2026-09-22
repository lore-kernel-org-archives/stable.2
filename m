Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFED569F34
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095346; cv=none; b=qI/SWQMkNMTP6Rjs19bahKOQWnnu0kCLICllrpQkHfeFTT9E6OIDjIFyguF6/3spwd20Png+4QqPU85r7FtnUka8UFTs1DCdN5GD8csP/nZv50ltLB1Oy8ZW8AX+uzK9zIu2opqkRx5qVrZ5eyCzjGh2UQlhh5INP3IEO14kgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095346; c=relaxed/simple;
	bh=6AGBEG8zrHS5CtRBbqIdMFCnF06sZWLAYweu0dzexYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1GWNWlM59J7yJ1MwDRd7gWsBsp3r5wPc9JYVzvte3dYKR0mWj5nkr6Lf4EbnwOHovx71gB74615tZUZmEn4LEg0GeUnJEDIuJDkZDmbbtv2waqNzx2z1n4gnPuZdSJYXvVgTcLSpIlA36mW24QHVal/wqL9q+yyEyRrNIF/TvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sm6j6oR0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sm6j6oR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E28A1F0089A;
	Tue, 22 Sep 2026 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095343;
	bh=4LCApEcdP+ZOIK39e1vDpfsQWRg6nrMYaZ30K3PvMtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sm6j6oR0bNZS4Hiyt4fbgbIp8ci9Yb6H1L9xgxDhuqSnVqGr/+FKwEPbKnSz/11FA
	 K4FADAb1KR4vJwVoC5qQQUEtqW154XRuKs7ip/gjnjm3xY8P6+F1FfogeAIeC/v94A
	 cHXNmJT2m8zjWPaBPIjVdRwYiw2LdlvIPa++yG0ighY6dC/J+fYY1B+kAlchxjsa5e
	 F/953QBtiQmOx5/KwEM3LOqMHHYTJoC/QHcL1K0vKu4+xqDCNsQn/3Ipw07h1u04SJ
	 UbRBvwIE/KzgdQoGPG22DXJo2fmjqAm8id/IzmhH9EcVq7O/Kbp2f1dbncv+gknWM3
	 kGKtd8h/cD0vA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] i2c: qcom-cci: Remove the unused variable cci_clk_rate
Date: Tue, 22 Sep 2026 12:42:19 -0400
Message-ID: <20260922164220.3108746-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164220.3108746-1-sashal@kernel.org>
References: <2026092211-crept-ether-35ce@gregkh>
 <20260922164220.3108746-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ Upstream commit b88c79699d72caa947ecaae85839b3563662ccce ]

Variable cci_clk_rate is not effectively used, so delete it.

drivers/i2c/busses/i2c-qcom-cci.c:526:16: warning: variable ‘cci_clk_rate’ set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11532
Fixes: 8284750a1829 ("i2c: qcom-cci: Stop complaining about DT set clock rate")
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Stable-dep-of: 7362a1553eb0 ("i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 4c525bcbad431..0939f09f1c8cf 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -523,7 +523,6 @@ static const struct dev_pm_ops qcom_cci_pm = {
 static int cci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	unsigned long cci_clk_rate = 0;
 	struct device_node *child;
 	struct resource *r;
 	struct cci *cci;
@@ -595,14 +594,6 @@ static int cci_probe(struct platform_device *pdev)
 	}
 	cci->nclocks = ret;
 
-	/* Retrieve CCI clock rate */
-	for (i = 0; i < cci->nclocks; i++) {
-		if (!strcmp(cci->clocks[i].id, "cci")) {
-			cci_clk_rate = clk_get_rate(cci->clocks[i].clk);
-			break;
-		}
-	}
-
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

