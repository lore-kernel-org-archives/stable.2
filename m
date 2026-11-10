Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320188;
	b=UhKlmejhZWvcJwo2dYDGyffDwDL559+/jOjvbrc3L6Z8Op/gpJ0TyOvqAGKyO1Oo/7Wg
	 8SXHhAw0l9wC3JGT3bqIBi1htbiwVtcNkJ2NM44/MQVf1jFbg+gVINHceq+rcTQx8cxfr
	 EIOYL0NC+WcRSt/KzWqvwMTgiy8otgDxi2dOeRZNKtXrbSuXlvuO8t59kE6gE4fTpvkCD
	 5FXUU006/SLKJGyKhCClyHlEUL8BqmJRSoz0Nv1i8aaIiO2hKqROfQeju5MVBw6hbc5aG
	 Bg6jGWTgTOqoXAIM2l9TLDfdzfNjK1EOnuNvwBDfCbXNpyqYOM0+cDIhkstmnKKd+6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320188;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PBDJs2v7PdGbda2hrv8j351E4QB/+yp2RVlYA2/YxQQ=;
	b=Ya2pQwcpo8AbJH9lJ/mzyHR5IQgQZDbUP/IO5Cm9QTTb4AkhopbaUWFyFiY7uCUQEtD0
	 EJhZP2PAOCmkoFQlg43mZYrU0XjkTNVie/YUVOWRCLPzitcMEJVpiCsK/8dKaRXtXWnqq
	 g3EQWnaNZAhFbmDkbqIq7XzXlmk9YgYq7N3fpDzOzBKADuHO6cJjPkAm6Li5E8pIW3Tca
	 Xm44p4NYs886oqe69I7yFXJkeWVHzR7aaPfoW6GnTqfmaMfjcZp9YNfntTZOrdOwkXmoJ
	 iCciWybrIzEw7tXeuo2S0t+IWLOHkru35EoQZ4HB71ZhjABEK8SmbGoT3AYI99GhjoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epK+6w5J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0FB60A2626
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epK+6w5J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE371F008A1;
	Tue, 10 Nov 2026 14:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320187;
	bh=PBDJs2v7PdGbda2hrv8j351E4QB/+yp2RVlYA2/YxQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=epK+6w5JWBYy//n/86oDNZfRoBXW0gM6hGTzgr0TnQpvJYbQ4N4uK/6AtydE9QIj/
	 wmO6lniKkAqfyw9AmX97d0de/Pu53ds1hmAe+2IrRl5C1LX7LaDsIu75UCG/oan6P6
	 X9W78MORXVXzYuOnl7mZy7rCfCxZBz8P2BfwVEj+sHJGIOc56Nvlxv+HZltEImJJYr
	 jvYY7UGRXKpBCbcFcFN2QU7COOMFOV5PxxQG/N+zLR65LFAYMfuMUEacyzhTcFtWdp
	 l3pgPJ5k3EmGtxSa5HOfjlfeB5kjGGnFNydzcVaeYnT0D5g2SX6jPU8naGhBwKnzNn
	 wOYXlpwsHnvSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Au Dang <au.dang.jx@renesas.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] irqchip/renesas-rzv2h: Preserve TIEN state in rzv2h_tint_set_type()
Date: Tue, 10 Nov 2026 09:16:23 -0500
Message-ID: <20261110141537.1850847-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051143-failed-6.18-42bedd4af8cd@kernel.org>
References: <20261107051143-failed-6.18-42bedd4af8cd@kernel.org>
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

From: Au Dang <au.dang.jx@renesas.com>

[ Upstream commit 42bedd4af8cd50c32a1560d8744bd22d25be79cc ]

rzv2h_tint_set_type() clears TIEN while switching the TINT source and
then unconditionally sets it again, enabling the interrupt even if it
was disabled before the call.

Restore the previous TIEN state instead of forcing it on.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver")
Signed-off-by: Au Dang <au.dang.jx@renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261014095927.635132-1-tommaso.merciai.xr@bp.renesas.com
[ sashal: Adjusted context and indentation to fit the existing shared interrupt-chip dispatcher structure. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index c9f9099a51294..927b5ffa0c7cb 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -328,9 +328,9 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *priv, unsigned int hwirq
 static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 {
 	u32 titsr, titsr_k, titsel_n, tien;
+	u32 titsr_cur, tssr_cur, tien_cur;
 	struct rzv2h_icu_priv *priv;
 	u32 tssr, tssr_k, tssel_n;
-	u32 titsr_cur, tssr_cur;
 	unsigned int hwirq;
 	u32 tint, sense;
 	int tint_nr;
@@ -386,6 +386,8 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 	if (tssr_cur == tint && titsr_cur == sense)
 		return 0;
 
+	tien_cur = tssr & tien;
+
 	tssr &= ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | tien);
 	tssr |= ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
 
@@ -398,7 +400,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 
 	rzv2h_clear_tint_int(priv, hwirq);
 
-	writel_relaxed(tssr | tien, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
+	writel_relaxed(tssr | tien_cur, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
 
 	return 0;
 }
-- 
2.53.0

