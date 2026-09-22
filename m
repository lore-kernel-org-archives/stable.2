Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7BA56852F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095025; cv=none; b=ruwXdvLnu+fsU2aS/jpBNY+4d7WVAYi5RrlSDOj0hxMEDaTh1u8qmNbZCi/jhRm4hPjwcprsuE5y0UGuQlTaZ8qOgbmLIC2AytObLUw0B8fe88ynDX0tmETrqcUNuKI0GZ0yMY/mAAVbcUOV9btKedRvM1gUkNaXareZ+4pWiOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095025; c=relaxed/simple;
	bh=Fy2FGKlJsh14oN/DQe+8VGJqWoS6YNSbu/tqvoG2XtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYDJtPBVbTZsWiewTfpQgp2sfJELay7gRVcOsRGB9vKAb9mhWrygf1F04Q8ZYo7sw75NHj0vIOZmOTPiylKCMWj/Z/h0zUeFyhoHKNG2krQEaYZBPve6/xM80lwdwmJ2x7pt18lomkJwBQ1POwV7efH1FJdDKLPcVHZ4Fsd0ESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3ECSfBW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3ECSfBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9AF1F000FF;
	Tue, 22 Sep 2026 16:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095015;
	bh=YxyhnOqM/vZAJ21E2eyDBx8cvrIyUl0b1+tahYfTxzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H3ECSfBWFvqMkwZ2mE1t/Xpcx7SvUi2GvBUmBghAitNX4alyOVajIsf7efz3lamnt
	 hkvhFh+uk1sDunU7wHZEzf9EoQu9rVNOf5H086Uz46sLom0JqTB+9+4i4+UM5PUCpo
	 9D21JbuSqxOUlahVVaqL9HkczRJluJf8e0SMLnZcaF6j7BACsx8uub4ol7Svvjd5ps
	 rEPRxv7gXLZEASlMT2EvP5Tazmi7RLuUApUZwV2ni2vazp4C77wG7fResMemgdzWuo
	 +ZUebKX/ef5UaMdqW2FL3BOrUfmsgucA0LMLrjDOivjlcy41Ev7JNGiiXjOB4B74Fv
	 3qSYE3MDyXD7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] i2c: qcom-cci: Stop complaining about DT set clock rate
Date: Tue, 22 Sep 2026 12:36:50 -0400
Message-ID: <20260922163652.3066989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092210-vacation-hangnail-e82f@gregkh>
References: <2026092210-vacation-hangnail-e82f@gregkh>
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
index 85de659bb3627..22fae6a5a9022 100644
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

