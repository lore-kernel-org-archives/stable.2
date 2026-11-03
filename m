Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741466;
	b=gcWQBz+ihplGz/L00C8Vb1aQwVyTReVJWXMuz0L4DNBLwPWmw6bVLk8xY/IxeqjuiBPZ
	 +37vgq3Y69bkEtjLaO6SfRRwwWXU3GoY/F8CzvMPStszweowvP1QNJXfnBpTY87jHlmC2
	 0TqnODbo603qCCeIllFUKHa3K3lHwJzqcfeUEdaGf18r9egSvk0v2GcLdAJrDz1W7+97p
	 kUmns4YtlyrcXgggTX7cVMMaaY1IzhbIHH+Dd5sQN535+B7AYv7FxH0DXXyZ3uyzwUUDO
	 TUuT+YLzTI0TiAp9wxXO32Y/WDI6H7gG1uzgN1psgGcS82SLl/lmyspigM1qZSKDP0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741466;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3/oOsHewxoaJAaDJ/rO1u+yX1SuMv/P/AudEIBEMG7w=;
	b=JVbd4cSpfSCYdHmLngU15azdgdIbE+Lfqos/8azEAKJ8ZAMvyhilN/4yMmGR4hdG1dqY
	 M8xMwtDM5t0FY+tD6zluUahhdgahV4MD4IhOht2FTHKt/m8tfUqlFCx0UnkrGDKbvAiqY
	 0HKMA1qr4yqWGlcy/E9b/sMPnDNTs4ASjeLCOrAcU5kS3Zojq6e6Uxs5p2LJjS/Yo07so
	 SbSjuiZ/WqBEAG2b/9ey3JqM5nQCMIHdFjHLO+5h15rHgaRmSGUEu/j7pjad2WOY9K6qj
	 iwdTIGdNsplyNRDy2bGEKupQNi+lz1Tg2JD78KXALHtFDzD/OSvFExwiXHfT7yAXiDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMWVqxa1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1C606A31B;
	Tue,  3 Nov 2026 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMWVqxa1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5025F1F0093A;
	Tue,  3 Nov 2026 21:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741466;
	bh=3/oOsHewxoaJAaDJ/rO1u+yX1SuMv/P/AudEIBEMG7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FMWVqxa1FNxP1228G32bTLVARYQ3QmprHch71ewzUY/3cokfxHRbiLY8bJdd7QIY6
	 9b/IJJINomPPHFXkkbRjzQzlMnWaXqmIX+D0uM2IC+ik7B1EtxY/6c1gwP2PLupO2w
	 WRcQ2O0Lir3/wtmX7pB8ql3mia8EWlLhDi0UU0U0jUGC69f7a9Kmpx7tvNdDykFhd1
	 zg2VtXHVIuY9Aql8rftE6fdeCdhIyA28K6ntxQOvOcCI9pRn5/aTK7I8YRNkIRcLGN
	 mXIoqqqbzvuyYRXz3W5+3ANaY/QYRVxDF1ODKuPaEq+0KsSOk5xU9YWMikFRVHt0B3
	 KgWBzfYAUBKUA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hao Chang <ot_chhao.chang@mediatek.com>,
	Qingliang Li <qingliang.li@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/10] pinctrl: mediatek: Clean up partially initialised hw->eint on error
Date: Tue,  3 Nov 2026 21:29:13 +0000
Message-ID: <20261103213002.1673560-9-lee@kernel.org>
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

In mtk_build_eint(), if of_property_count_strings() fails or
hw->eint->nbase is non-positive, the function returns -EINVAL directly
after allocating hw->eint without jumping to err_free_base.  Because
callers such as mtk_paris_pinctrl_probe() and mtk_moore_pinctrl_probe()
log a warning and continue probing when mtk_build_eint() fails, leaving
hw->eint non-NULL with hw->eint->hw unset causes subsequent GPIO or
suspend/resume callbacks to dereference a NULL pointer inside
mtk_eint_do_suspend() or mtk_gpio_to_irq().

Jump to err_free_base on both error paths so hw->eint is freed and
reset to NULL.

Fixes: 3ef9f710efcb ("pinctrl: mediatek: Add EINT support for multiple addresses")
Closes: https://sashiko.dev/#/bug/linux-0689c07e-ef74-4bc2-b5de-bd2f361124bd
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index faa6dbf0f635..aa15c9e047d8 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -382,12 +382,16 @@ int mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev)
 		return -ENOMEM;
 
 	count_reg_names = of_property_count_strings(np, "reg-names");
-	if (count_reg_names < 0)
-		return -EINVAL;
+	if (count_reg_names < 0) {
+		ret = -EINVAL;
+		goto err_free_base;
+	}
 
 	hw->eint->nbase = count_reg_names - (int)hw->soc->nbase_names;
-	if (hw->eint->nbase <= 0)
-		return -EINVAL;
+	if (hw->eint->nbase <= 0) {
+		ret = -EINVAL;
+		goto err_free_base;
+	}
 
 	hw->eint->base = devm_kmalloc_array(&pdev->dev, hw->eint->nbase,
 					    sizeof(*hw->eint->base), GFP_KERNEL | __GFP_ZERO);
-- 
2.56.0.385.gac671c819a-goog

