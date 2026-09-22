Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CB556B846
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095344; cv=none; b=uro5cMScaQrYH5XAdNVGTX736NLi8Pm7Dfl+liQnFkNSV5limPvG0KrWTTvbvGC/blgOnmBJlJwjVYsK9fnzcPHpDL0hq9Jq9uVMHpE9P+v9j1Fgnuq3VGHNDaMfNLuK1e0kUACxxeFFlksDQ7tIfCwNyq7MaeN8x18ZyKFppu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095344; c=relaxed/simple;
	bh=Nq+uJZiKBJsQZkjAkNo4WbU8rm2ce5X+cWl5GsVsSLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxY7WSM3xiohgvfJU84iQrkeh0jFk8MN4ngiNILISvfHHbTzt3Cy2zdYh0yhHMRFm1GP+MPbwXKrLBfR5alAli2HoBpLk5lpM1yTpoTy9e6t8QGkRSlp1AtLZ9+N1RtpI9sGPj+ovvJp4GAdjjhdWqB63yV5coYFNbCctQxJ744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezX1hC2w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezX1hC2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF161F000FF;
	Tue, 22 Sep 2026 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095342;
	bh=3gqYDa/W9N5RoeqUZOyeCaOHA+o7YYAXGlG9qt9+qM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ezX1hC2w6WGHlQYbvMwF0g9pKvYSTcm6eceq508wynI2YUKHsWYT+4owToPRsYQKH
	 uk4e19mS4OvBpB5duEQ8Wq4Ep7NiP65vgvcgJf1Kf1Nk4cGKQnUtTcPz3R0DGoHN40
	 URCocLt5+Mi3cuQNVxENEx5AgRILnRRUEUFb9FtmbMjFFO+QHO9uVHIfgacQK0tg5A
	 5gwylJueIFQFqagnNnrWhUCVX5jQcniFoV0J4EpgIh4adjjAMQQkvLP2goCQ1y3cNy
	 M7wwRG1DG3xhzxbWo6rkaDI1NsC+5ZZJ16Hfe8DyqoDDHkZvGrVRNP6GDYDi96UKR4
	 QDZyVO3q5asCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] i2c: qcom-cci: Stop complaining about DT set clock rate
Date: Tue, 22 Sep 2026 12:42:18 -0400
Message-ID: <20260922164220.3108746-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092211-crept-ether-35ce@gregkh>
References: <2026092211-crept-ether-35ce@gregkh>
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
index 4989d0e705d71..4c525bcbad431 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -603,14 +603,6 @@ static int cci_probe(struct platform_device *pdev)
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

