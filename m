Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8D429037
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099471; cv=none; b=MVeizvMhxqAcqOadlSLZ2ICOQf/sOOn9zuCFLrtQ9SD0znqVWaExF3AOvFMAm5msOgK5xdIc1gj9XH3SCtjdxRvoYRzAEr4guuwZ6ha+YmbRSz8Dx58XkvjIWrXckbUuVoIfVX3rfSAOxYtdAhOKJQ/s50UFmohVn1ZzYpmpQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099471; c=relaxed/simple;
	bh=u6wW6RL/S9B9i99ebuBXKAf/ahzyyIEIXbU5b0Rbb6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7oked80HBInsnvtCzW64HemO+J0XhYUVx/qW3s3j3w6cL/E0wSG98t/F46VanETEOh73CLUL6FQzXyZJr0iCYiOlyCMfjSGg0MVB2Wu6Ij1+LSl3L+uBPug9X4oztPtYrjXJYGYr8eSc49qafqGCoLI90EziOe/Z29ImHqi7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4m+0fxI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4m+0fxI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF271F000FF;
	Tue, 22 Sep 2026 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099469;
	bh=cYPJzBuOO92uKMn6F+NconfB/okeXu94vL+PUW46lz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4m+0fxIwL5DOIcQl7Ooijn5rO2RSVv3w7SPlJzMzZDRS+I26g4RAd/qvJI8UOZfe
	 9eKcai6lp5zPp8rT/CfXS660H9U2SHFkO1Z45W9XXR7CwtsQFSdmjN9PZnaSjJMq82
	 IuKJrtcJovdBgqr6Ozpi4kkYnxsWN77BtRYCCpmH8Zqh+lgumJ/tKUI17+pG1/J4RM
	 0xCRz8nhz/d8llzx1sB4vanuHczqPE4FJuHcm8fNX1yQujjxXt5g2df61JvzEhkQNn
	 w2xZDrzjrCOjQSrhhxYeNrLmx//VbkRWTERnxe0NnOsP853oj9V18l2/PnmVh5ykG3
	 VKocIyPnOQCkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] i2c: qcom-cci: Stop complaining about DT set clock rate
Date: Tue, 22 Sep 2026 13:51:04 -0400
Message-ID: <20260922175106.3308111-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922175106.3308111-1-sashal@kernel.org>
References: <2026092212-fruit-deploy-01d6@gregkh>
 <20260922175106.3308111-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[ Upstream commit 8284750a182937bf805f703311501730f02eb40e ]

It is common practice in the downstream and upstream CCI dt to set CCI
clock rates to 19.2 MHz. It appears to be fairly common for initial code to
set the CCI clock rate to 37.5 MHz.

Applying the widely used CCI clock rates from downstream ought not to cause
warning messages in the upstream kernel where our general policy is to
usually copy downstream hardware clock rates across the range of Qualcomm
drivers.

Drop the warning it is pervasive across CAMSS users but doesn't add any
information or warrant any changes to the DT to align the DT clock rate to
the bootloader clock rate.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Link: https://lore.kernel.org/linux-arm-msm/20240824115900.40702-1-bryan.odonoghue@linaro.org
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Stable-dep-of: 7362a1553eb0 ("i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index eae21899e0f3c..657840f5639c8 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -602,14 +602,6 @@ static int cci_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (cci_clk_rate != cci->data->cci_clk_rate) {
-		/* cci clock set by the bootloader or via assigned clock rate
-		 * in DT.
-		 */
-		dev_warn(dev, "Found %lu cci clk rate while %lu was expected\n",
-			 cci_clk_rate, cci->data->cci_clk_rate);
-	}
-
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

