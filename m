Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809763CC337
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766847; cv=none; b=lvF87RzvXue+0Wq5+HywYabbQbQMJ/UKdR9sGkX2/SCB9tCbJW/Sn1S6CGVzTiKtYX0LS+z5nupLQPHXL1zrjFtKOLYsHC/w8HW9v0X0Rz8jeCropRrqhxhxTyNmdRkKO3lkL1vEWFzksGKiq1aL8+0N273BTe8VpfH1NzDbKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766847; c=relaxed/simple;
	bh=gbHEdA7nOPKK21JL7sWuzjBjt2juKP/VHp1z7BaPJok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AK2GszlKmILTGYbAL+5O1mkXlbWvlPG0YiPEHnJTWv5/BiQliDQbiBkFMohtkpWEkidvvj+pL+RsmMjzsCmcEW+l1V28S1SAGOGy7gVPAj9KdM8Qcz9Dg2+Z/hi/qk5otQBl5zP8Q7K/qsO5ezLWSfECFD7c+RTatMB77KwKaz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YufVeDJ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YufVeDJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7B91F00898;
	Wed, 30 Sep 2026 11:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766845;
	bh=LFjZOt0o18iP4w39DVAn1PHP5vq0UaSVVpOsfrVro5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YufVeDJ+rUou4hZG3czGkm7LfWw0xDcy//1FRalcD8UUJIdSdvUa9kkutFb/KDQUd
	 ePeHndSAJaXrfOC78IRDRoevzuWp7tPJZXcWzio31wCYjInE/MK69mIoz+j5UfMVOH
	 8bmuM0vNuVq0ziUxEXRc1pclRAitqQCVLk3/13hq4UYI56WXqlPZ4jlQYCkfgjlfzh
	 2ggbD6+ynehWEhLBdCRUzwgBxsOKGwCp2oluuK8yUtrI8an6fcnG97diI/IvhZGcqO
	 PKwhovwnBMhHX66qp5gus71kXpFKJVj7xYRkQMulhD9hpUPXo2q4RjVlm27WY5Ltai
	 8wdE29E6KYYJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wang Jianzheng <wangjianzheng@vivo.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] pinctrl: sunxi: Use devm_clk_get_enabled() helpers
Date: Wed, 30 Sep 2026 07:14:01 -0400
Message-ID: <20260930111402.1206529-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930111402.1206529-1-sashal@kernel.org>
References: <2026092930-embolism-unproven-18a9@gregkh>
 <20260930111402.1206529-1-sashal@kernel.org>
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
index f384bfec6c393..7c895ddcb970a 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1577,30 +1577,26 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
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
 
@@ -1611,7 +1607,7 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	if (!pctl->domain) {
 		dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
 		ret = -ENOMEM;
-		goto clk_error;
+		goto gpiochip_error;
 	}
 
 	for (i = 0; i < (pctl->desc->irq_banks * IRQ_PER_BANK); i++) {
@@ -1643,8 +1639,6 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 
 	return 0;
 
-clk_error:
-	clk_disable_unprepare(clk);
 gpiochip_error:
 	gpiochip_remove(pctl->chip);
 	return ret;
-- 
2.53.0

