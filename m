Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741473;
	b=hVB8mTVXhotPJWlg8n83se9tg4g0e/1Bl5TH5MOHoEgx6wvISABXdapxKE9mch2uGczG
	 bIvq7b7jSn1qS9tGgtPZtxT1xE2oUaDUv2GnrEBMYujXEbJWvYC9wFqPINojKgUrrrLLB
	 KIXO+gwb9WGoeUZTdKdMEDbf4iHVx+oiyWG1oWmmjK4ldGpTySfxd55EGK5QSjAdxgh+T
	 Gg2FLot+Y3WC4dSoioXSn76uN+9zUvCTHtF+vMzHSKU+/QiJ2AQi+XO7eTLHxDN0lLRdJ
	 dEXcGzRf8p0upHtFrXS2bwC6MgHsN/hmJ661dcWCu6AVrLMnswBO/RbEPuMq4YyrCsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741473;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=f0ma+jHzcciETFu2F4xi1pN1CPcSp4hOEtFv0IsiDV4=;
	b=Zi40DGrs6JwS4dJ3MnXo1EQEP6UbNoWfXDDMx5ksjujXGUs+2awCXTJkq8xkgxDsBzfg
	 SAluOd6c6JasnPuqoLxPTvMmQ7pBIagA45YoDUvKQhQcv8tu5EmxpkoV6ktLkCqvhJyaz
	 1EIL4ATsw/qH0hBB2Y5ssGD4ye5bAwHHtjZWr1mScj1tLK9XsQdIoeGrm1cIW9GHrXPbD
	 DMi4S4f2TBnXlOriTmLyfU7rMWzB1+Jn+/4oT5VNOITG5+AX8NFPvCWd7f+oyKSwyjbQJ
	 52QvUQZkWH4ZKE9CPFnrsZh+NbbDq6wHC4VQWuoYhV9mxuE5YO7UH9caGFnCCszLriA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fr4Psa/B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848BE606A326;
	Tue,  3 Nov 2026 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fr4Psa/B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDC21F0093A;
	Tue,  3 Nov 2026 21:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741473;
	bh=f0ma+jHzcciETFu2F4xi1pN1CPcSp4hOEtFv0IsiDV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fr4Psa/B2JpwdpKsWn4kacWBVEmwIR9mGxLeXDKCcfoVujwzps+XBrF7qnJ6LEgK0
	 MUlkzd2LzQQ4VFcrTG6mkfOzNG7xuXexVUuwVuy5u8BjhjrfmfSX9VHLla+lI0LzOX
	 7Nq38h4yFwiT81Dsn5HqCqCHTEKV4bp9spFUQs7cX6led9HyS2W+JOkMYsE7Zzhbfr
	 Sa9Hz++1mamyR38F1EZhg1J1ec1D5YZKWEkQ3pPFoCy4zwSoEIE5aUxnKUHwF/o8Gy
	 /2MsmpHL4PntxfTSP2F0TeFLF+JwKGaewegHhohmNespDtKihaIHqoktlGwdRgm0z8
	 rF6+O3CnKG/dA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ryder.Lee" <ryder.lee@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/10] pinctrl: mediatek: Prevent divide-by-zero for pins with fixed drive strength
Date: Tue,  3 Nov 2026 21:29:14 +0000
Message-ID: <20261103213002.1673560-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103213002.1673560-1-lee@kernel.org>
References: <20261103213002.1673560-1-lee@kernel.org>
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

mtk_drive[] only defines entries for DRV_GRP0 (1) through DRV_GRP4 (5),
leaving mtk_drive[DRV_FIXED] (0) zero-initialised with min = 0, max = 0,
step = 0, and scal = 0.  If mtk_pinconf_drive_set() or
mtk_pinconf_drive_set_rev1() is called with arg = 0 on a pin with
drv_n == DRV_FIXED, the range check (0 >= 0 && 0 <= 0) succeeds and
!(arg % tb->step) divides by zero.  Similarly, mtk_pinconf_drive_get()
and mtk_pinconf_drive_get_rev1() divide by tb->scal (0) if the pin has
drive register fields defined.

Return -ENOTSUPP immediately when desc->drv_n == DRV_FIXED.

Fixes: c28321979ba8 ("pinctrl: mediatek: add driving strength related support to pinctrl-mtk-common-v2.c")
Closes: https://sashiko.dev/#/bug/linux-d3852d37-6806-4c41-a493-f249dd59d0c6
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index aa15c9e047d8..1243862983b9 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -1040,6 +1040,9 @@ int mtk_pinconf_drive_set(struct mtk_pinctrl *hw,
 	const struct mtk_drive_desc *tb;
 	int err = -ENOTSUPP;
 
+	if (desc->drv_n == DRV_FIXED)
+		return -ENOTSUPP;
+
 	tb = &mtk_drive[desc->drv_n];
 	/* 4mA when (e8, e4) = (0, 0)
 	 * 8mA when (e8, e4) = (0, 1)
@@ -1069,6 +1072,9 @@ int mtk_pinconf_drive_get(struct mtk_pinctrl *hw,
 	const struct mtk_drive_desc *tb;
 	int err, val1, val2;
 
+	if (desc->drv_n == DRV_FIXED)
+		return -ENOTSUPP;
+
 	tb = &mtk_drive[desc->drv_n];
 
 	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_E4, &val1);
@@ -1095,6 +1101,9 @@ int mtk_pinconf_drive_set_rev1(struct mtk_pinctrl *hw,
 	const struct mtk_drive_desc *tb;
 	int err = -ENOTSUPP;
 
+	if (desc->drv_n == DRV_FIXED)
+		return -ENOTSUPP;
+
 	tb = &mtk_drive[desc->drv_n];
 
 	if ((arg >= tb->min && arg <= tb->max) && !(arg % tb->step)) {
@@ -1116,6 +1125,9 @@ int mtk_pinconf_drive_get_rev1(struct mtk_pinctrl *hw,
 	const struct mtk_drive_desc *tb;
 	int err, val1;
 
+	if (desc->drv_n == DRV_FIXED)
+		return -ENOTSUPP;
+
 	tb = &mtk_drive[desc->drv_n];
 
 	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV, &val1);
-- 
2.56.0.385.gac671c819a-goog

