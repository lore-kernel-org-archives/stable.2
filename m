Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1D3CFF51
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767175; cv=none; b=X6Vh9XYkUldawCvYh9rYnb4noHxW/DwgZqimmO0dK82CNnUHWR1OThkstGdt0T0oiTnUTPPVmb0nuEQu/AAUUlbMdlSRSoPqmfMCmz147j65mOfcFlbQoRA8pwdNoofl8mWCdx0TlpVt7O91ATh7M/+UusokoCBJ3fiNvJaMI7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767175; c=relaxed/simple;
	bh=Oivjs9QwXS3ouD+6qvVCtisXQ1/ulzsYTeeTI6mf9oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkKL+I1hSqlT4LEaETrzBivSOLlCoP/O9n8+axu62cJc2NKN+16NJ5PFJPUgzdAU/IjJbyLgZEZehuyowOAAGtujBoki+qeAN23rEgdI8WmVk2AeU6YEB0tYTuZgrFf2yiu/6eGJzVsaedcs4rskDj4MZDsi72374rPJfVpUdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8yWXjsH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8yWXjsH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5B31F00893;
	Wed, 30 Sep 2026 11:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767174;
	bh=3fSAj/vKZoZQNmhAVeugPws/XSKLBnVH2tOfICxeHiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e8yWXjsHobij+Dh91YOkD7HcI5+Hsy4zvEKKRUqfPEzBR/zoDyw25aRvhODBJULqd
	 J2oTuGHhZFQQt5nVjrFY+2QDxUZz0FHeD52GZSPr6sB7vJHdHYYAdKr6L0ZNdQCeT7
	 5VbBdWVAEnSwsM8u3BkhwoYI6G35LM8nhIFmBKykWSe9jHFfog4KU+dhN7pMEf8G4S
	 abC5kHX8HAy08UPNdlN9RfbDvArdNR6UatZZZn7cDH969N+W7Ck+gZ9Rm5NdnXd8AU
	 4feuZZKqcjL2nSDAJ58TjFMYVMZcXwJwgGGMjkEa9rMz8tNw1TbBUbclc0Bj9Nr5Up
	 pRYA7uXD81w8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wang Jianzheng <wangjianzheng@vivo.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] pinctrl: sunxi: Use devm_clk_get_enabled() helpers
Date: Wed, 30 Sep 2026 07:19:30 -0400
Message-ID: <20260930111931.1214201-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930111931.1214201-1-sashal@kernel.org>
References: <2026092931-abreast-parameter-ef97@gregkh>
 <20260930111931.1214201-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Jianzheng <wangjianzheng@vivo.com>

[ Upstream commit 7dc92ece32ed87a352e285e3d9f0d392b61443e2 ]

sunxi sunxi_pinctrl_init_with_variant get, enable clk and
deinit_device disable and unprepare it.

This simplifes the code and avoids the calls to
clk_disable_unprepare().

Signed-off-by: Wang Jianzheng <wangjianzheng@vivo.com>
Link: https://lore.kernel.org/20240829064737.16169-1-wangjianzheng@vivo.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Stable-dep-of: a13f7f5d14af ("pinctrl: sunxi: keep a shadow copy of the data register output latches")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index a39a97bd26884..1b419ebdc0110 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1578,30 +1578,26 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	}
 
 	ret = of_clk_get_parent_count(node);
-	clk = devm_clk_get(&pdev->dev, ret == 1 ? NULL : "apb");
+	clk = devm_clk_get_enabled(&pdev->dev, ret == 1 ? NULL : "apb");
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
 		goto gpiochip_error;
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		goto gpiochip_error;
-
 	pctl->irq = devm_kcalloc(&pdev->dev,
 				 pctl->desc->irq_banks,
 				 sizeof(*pctl->irq),
 				 GFP_KERNEL);
 	if (!pctl->irq) {
 		ret = -ENOMEM;
-		goto clk_error;
+		goto gpiochip_error;
 	}
 
 	for (i = 0; i < pctl->desc->irq_banks; i++) {
 		pctl->irq[i] = platform_get_irq(pdev, i);
 		if (pctl->irq[i] < 0) {
 			ret = pctl->irq[i];
-			goto clk_error;
+			goto gpiochip_error;
 		}
 	}
 
@@ -1612,7 +1608,7 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	if (!pctl->domain) {
 		dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
 		ret = -ENOMEM;
-		goto clk_error;
+		goto gpiochip_error;
 	}
 
 	for (i = 0; i < (pctl->desc->irq_banks * IRQ_PER_BANK); i++) {
@@ -1644,8 +1640,6 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 
 	return 0;
 
-clk_error:
-	clk_disable_unprepare(clk);
 gpiochip_error:
 	gpiochip_remove(pctl->chip);
 	return ret;
-- 
2.53.0

