Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788388;
	b=GcyEa2ai63KxVG/HvUl7hhXwVoP7W7Ea7GgC487oh18g7nTvbWetGCFjvh0VKEvhhlp3
	 FHXKJlq9h2rKaE+5kp+lQRjzx061Ee6mvPcGGtQwKuaUens9n2Mqzlm/rVM/cwvn5hqtI
	 GsEZaF4GkwHN7ZQMnspmdooh9CPeZxfT//mrCNUK2ZhIqw7onc1Sk2WYg1CIsSp2dDsyL
	 536k45SWMP2LkpCI7kDhMMN8ilCM9retqLLR98iwN31OFuaQPLca9eRzBJBSrNz+mxUwN
	 gkCODkSGwmNOszYuAXLhLWGU2qIAmKxJpDvolx8ipqhqhsUAr2z3MD/WD1bxQskWCrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788388;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OTnxyO9HGZRIDB4lUzROzHOrnSel8Aijr2T9djhyVlY=;
	b=YHpnZGXPYbPGPwqtRhuDFmOQtcVxHhjwbbvf8peM/2X+n3J+Tbkgd7NHGlccyLv7Mzls
	 oBoa+ABzaODBIN/CwH3qlynmW9IxGEaL/tKk9VrgdxPgRmpb9sfJ0DRGNfQEIWEHA2RNU
	 uwH255z3CCcZdva7GOyUiusRQMrfdo2VGKU1TIm5Ekiujcx0Ph3JJpTPctNwuu84oBIrt
	 ezzxpQH3aBLv5K/mSRqm4Lb4WeSPJu9gy1KnCmcoLYaa67j6pQqNh0DSUwY3Pe0ETZsJh
	 Rd1lyVHoB9awVztSlQBAPZ1D8PcYQdBi64zKt2+gXFE3A9CS/3vXD8fbuYIdEfZ2qEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RCh2/hCf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39EE606A32D;
	Fri, 27 Nov 2026 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCh2/hCf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7381F00893;
	Fri, 27 Nov 2026 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788388;
	bh=OTnxyO9HGZRIDB4lUzROzHOrnSel8Aijr2T9djhyVlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RCh2/hCfuvxneGhDBIIgmoGkLj8by6aAmN0OLB2HjBHYHkz5EwM9GYpJLvqNigxyY
	 cweboX//B861BKyghKb+sRNzewo8C/VHoh030lEeSQX6Lesrl9+m3x8DHDmUt5ITZl
	 rB49Ph6i4qSfD6KSRlsObycS4OTpHtsAUvWI1mITpoUN8taDtMd0qfrKqARj72iNYA
	 do06VDu6nN0njZSmVdXlqy41nFePgqZsf2cgHvUkn32mzH+h48vOMcjXYJNVStisew
	 2Ki5fjt1cjHOQfP5NnMO5LnYFroePt94ioDpVfns9zt5++PkmlZva6O007QlFfE3yQ
	 nsf9TNQ+3xqQA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 03/12] pinctrl: nuvoton: ma35: Retain child firmware node reference in ma35_pinctrl_get_soc_data()
Date: Fri, 27 Nov 2026 14:04:51 +0000
Message-ID: <20261127140602.2790001-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127140602.2790001-1-lee@kernel.org>
References: <20261127140602.2790001-1-lee@kernel.org>
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

for_each_gpiochip_node() drops its reference on each child firmware node
as the loop advances.  Storing child directly in bank->fwnode without
acquiring a reference leaves bank->fwnode dangling once the iteration
moves on, leading to a use-after-free when ma35_gpiolib_register()
accesses bank->fwnode.

Acquire a reference on child with fwnode_handle_get() and register a
devres action to release it on probe failure or device teardown.

Fixes: f805e356313b ("pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver")
Closes: https://sashiko.dev/#/bug/linux-f140abe2-145a-4f6b-b626-bbabdc7327c4
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v2 => v3:
 - Rebase onto pinctrl/for-next; no functional changes.

 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index ddd3f4329f67..797b4dece7b1 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -557,6 +557,11 @@ static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinct
 	return 0;
 }
 
+static void ma35_bank_fwnode_release(void *data)
+{
+	fwnode_handle_put(data);
+}
+
 static void ma35_bank_iounmap(void *data)
 {
 	struct ma35_pin_bank *bank = data;
@@ -630,7 +635,14 @@ static int ma35_pinctrl_get_soc_data(struct ma35_pinctrl *pctl, struct platform_
 			return -EINVAL;
 		}
 		bank = &ctrl->pin_banks[id];
-		bank->fwnode = child;
+		bank->fwnode = fwnode_handle_get(child);
+		ret = devm_add_action_or_reset(&pdev->dev,
+					       ma35_bank_fwnode_release,
+					       bank->fwnode);
+		if (ret) {
+			fwnode_handle_put(child);
+			return ret;
+		}
 		bank->regmap = pctl->regmap;
 		bank->dev = &pdev->dev;
 		ret = ma35_get_bank_data(bank);
-- 
2.56.1.839.g22a8290db9-goog

