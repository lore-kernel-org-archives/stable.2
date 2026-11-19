Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121310;
	b=vX+f8qPLMZBMEkV2n8fkPqdHh+J+fKJ94EAcux5UHPa+3KRzpEI7u7X0DRJZ24VaHUqr
	 JOWgPopypDZa+U0hSQwU6gsdIgwiQJ4BIonePVBo1phlTBEKl2tHHaS94dn20SPtTm+fh
	 KE1BoLBaptJO6iT6dkqvBb3p8E3/7H8otFn6Yok5UsOpoKWWqjQc+oLV+lkhUVJckCa4i
	 8IlUQBQ81e50HPCh+srFZz2hk05WsXxPOe1ZZNVlHUjga43ZoHpWA2N96UHqz/dCKerF3
	 qK/ljoXMGnTcGDb8ioUK3irRUk1rKImnfTXuSA95yl2m79TO2Ktn8MYsYmhTjyzqnTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121310;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OtxuJdycJg4ztQS2bYE6i0u4pJUkPkHwSDNOgdsJ2JA=;
	b=q0Q+3Y+uVjpx4wKnjtPTZrDCOqweSv0FZ2ypAUYpzQFmu9oGpiOK6IqhyUgQ001jRGoj
	 Il8N/+ynS2ijXx/noERb6fOdDEGG/F/k1CEukt22ZW+y2fLamizqgCQFstFlzFU5XhWdu
	 fokVvTdhlow2mWXOsiikXILvGe+KOCQWWxEaILU1kL1RhBBEL9MQb6h0yofiHJCPXiua9
	 FwJVbtFt4aBS9GGZ8dUZ86W3mnD4bo+Xsn6ynqa22hLrFOhWlfoHeQsSifSvBAv/nQMqM
	 FjCAivv2jpZlVTieAJhqj7wmIpG/Vu1RysnmfU7W//kz6cnKLLNnB5e/pqqjw3bSQfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvNfOuGX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57F606CC6A;
	Thu, 19 Nov 2026 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvNfOuGX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475461F000C4;
	Thu, 19 Nov 2026 20:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121310;
	bh=OtxuJdycJg4ztQS2bYE6i0u4pJUkPkHwSDNOgdsJ2JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UvNfOuGXgzOfIW+jo0Cw6IHNlnY5awQimnYd/wa2dMd1iPH9zcI2SS8X5OYP01JHx
	 ZnsLASdKAtk3zqh3387LMC1+zJ5Hw83sTiBF3jlOqqZivplBrYDb7+2zmmmuJMbrYW
	 8myd6s9TRh4ZWLiExoycbxEl/FWETDIQGSOiPxJ8+eFTFtYjcPOXfMvKyvmJvIREMm
	 kGSXJF5MeaabtAxXatcdlygRFRMVfGXC4E8euKlOVL3h8+wttQ9l4dsRjFJicJ8CxB
	 JSaEH/uXyg5s72EDl1hDz/D3krGbJQQME3MMA7LMlOIta9Z6u+lv32X4Ep8fKNDnln
	 ArmOke/Ap5B2w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Hao Chang <ot_chhao.chang@mediatek.com>,
	Qingliang Li <qingliang.li@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 5/6] pinctrl: mediatek: Clean up partially initialised hw->eint on error
Date: Thu, 19 Nov 2026 20:47:20 +0000
Message-ID: <20261119204748.2558209-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119204748.2558209-1-lee@kernel.org>
References: <20261119204748.2558209-1-lee@kernel.org>
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
hw->eint non-NULL with hw->eint->domain and hw->eint->hw unset causes
mtk_gpio_to_irq() and mtk_gpio_set_config() to pass the half-initialised
structure into mtk_eint_find_irq() and mtk_eint_set_debounce(),
dereferencing NULL pointers.

Jump to err_free_base on both error paths so hw->eint is freed and
reset to NULL.

Fixes: 3ef9f710efcb ("pinctrl: mediatek: Add EINT support for multiple addresses")
Closes: https://sashiko.dev/#/bug/linux-0689c07e-ef74-4bc2-b5de-bd2f361124bd
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Clarify the commit message regarding mtk_gpio_to_irq() and
   mtk_gpio_set_config(), while handling NULL eint on suspend/resume in
   the preceding patch (Sashiko)

 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index bf9d20b59213..95d0455f7d53 100644
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
2.56.1.750.gf70dc682cf-goog

