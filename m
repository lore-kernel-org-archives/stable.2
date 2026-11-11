Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434036;
	b=MyHiupWe4RLJF7POM/pf6f6je5uvC0hvgdeXOmkLU7U8efGf1SW5dSCxjWEJgNmRm3iT
	 XTMbpm6u/LqLmSCPYM+7Yc/1/IyS6sa4/z9IszkbbfkzAFpIwbgQuedKWi/nA831g1pC1
	 ge8ASvKfzfFJk0oUgtp+afHg5e7eqP8CaeG1+gwsCPojBUL7P5hqw8x86pLzgtT3z4P72
	 qxjxdly3DQmGuBUeEeNkwwoLsOmz+sc/ueq56wBHKUxOEHZMPAtN7GrQmzRpokRqs6Nzu
	 qVf6xTEjJ1orKLdS5wdDYXrPT9VC/ckzInmaV2hE2LZ+EMbbcTqdu7oVRjLu3IE+gpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434036;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TMjWJojLqq3XorQYjDrTOwvU+KHQ5CXknXxUxLM6tic=;
	b=tAXvtR16V3SHA6ejT6D+hcDQPyG3N84AXdZRPwObk9TrJZ9Oi/OlD35a0Er/iOSN6cMf
	 JOqYJvSdF5vRbrnyfTmOh0TIbllbOjK5KFYz0L/GfKU2vKtWydak46liorUffatexx8G9
	 4gjZvuKywlDJW3BBnxFs/zGIfEvEtkm8JKRFLgSY/7Ta+A7GkaIrLu8uUeb1QTbXKagDP
	 CQQa3GYrW+ee08Uh16op7qw/gzuEIcYGQQxL2aJ21e/6AtJMRLIDCQfGK5Y6RgfN9gkJ2
	 oupzCUGla2dreOlb60Av6Bo3J6hiEUv7Wkc1ySazX/nzVV4YVDD1RYHlXeVDxFEtQwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKDStbMM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED834606A324;
	Wed, 11 Nov 2026 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKDStbMM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497D81F00A06;
	Wed, 11 Nov 2026 21:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434035;
	bh=TMjWJojLqq3XorQYjDrTOwvU+KHQ5CXknXxUxLM6tic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iKDStbMMhf8I64er8ZomLvhQlc8b5OA/YQCC3iT8gnx/Z5pGtug4uwX1onasbj+nE
	 vWTdXpFsKHlzhN5K1JO8tCeTylCbfBSydYL28LmIJqIgiPjEXBxGu5MMQiOvqOC30i
	 Mmepxeg14KOlK7H1NxsuEPUDW9XtLRec+mn6yoExu5bLXKFsVs6aMEl26u3M8iL88/
	 6bjZdrTrdUWRXX5f+hnSduKQbQCg28bLFgtgpAGJS7b/MXWSi8vvWspMTbW7/yPNtK
	 34ZjPAxw3zWoN64dKuxibiVGCsTny3xbIlKl9ANHt5tMmAYLW+7I2x49xnblWmxyYf
	 0munKaX1QsKcQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/10] pinctrl: single: Reject invalid register width in pcs_probe()
Date: Wed, 11 Nov 2026 21:51:52 +0000
Message-ID: <20261111215256.1982044-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215256.1982044-1-lee@kernel.org>
References: <20261111215256.1982044-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the "pinctrl-single,register-width" property specifies an unsupported
width (anything other than 8, 16, or 32), pcs_probe() hits the default
branch in the switch statement and continues without initialising
pcs->read or pcs->write, leading to a divide-by-zero in
pcs_allocate_pin_table() or a NULL function pointer dereference when
accessing registers.

Validate pcs->width immediately after reading the property and return
-EINVAL from the default branch in pcs_probe().

Fixes: 8b8b091bf07f ("pinctrl: Add one-register-per-pin type device tree based pinctrl driver")
Closes: https://sashiko.dev/#/bug/linux-a0303b6e-d0c6-4292-aeeb-fa8a21861827
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/pinctrl-single.c | 34 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index e0eb7240a985..13e0ae8bb389 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1811,6 +1811,23 @@ static int pcs_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	switch (pcs->width) {
+	case 8:
+		pcs->read = pcs_readb;
+		pcs->write = pcs_writeb;
+		break;
+	case 16:
+		pcs->read = pcs_readw;
+		pcs->write = pcs_writew;
+		break;
+	case 32:
+		pcs->read = pcs_readl;
+		pcs->write = pcs_writel;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	ret = of_property_read_u32(np, "pinctrl-single,function-mask",
 				   &pcs->fmask);
 	if (!ret) {
@@ -1860,23 +1877,6 @@ static int pcs_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcs);
 
-	switch (pcs->width) {
-	case 8:
-		pcs->read = pcs_readb;
-		pcs->write = pcs_writeb;
-		break;
-	case 16:
-		pcs->read = pcs_readw;
-		pcs->write = pcs_writew;
-		break;
-	case 32:
-		pcs->read = pcs_readl;
-		pcs->write = pcs_writel;
-		break;
-	default:
-		break;
-	}
-
 	pcs->desc.name = DRIVER_NAME;
 	pcs->desc.pctlops = &pcs_pinctrl_ops;
 	pcs->desc.pmxops = &pcs_pinmux_ops;
-- 
2.56.0.567.gdb80ae8cd5-goog

