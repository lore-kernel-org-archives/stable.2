Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B34A4EE3;
	Thu, 15 Oct 2026 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059771; cv=none; b=kc06IZ+IomYrOMgcuvEqkH33I5A+XW2DQ4cBH6LkXY/X2NwTXUdwOJkdb2yIfRR1ptdZe0f2Dr5Dl33asvzQIzyiIBFh2C241heT+9s0SqjarRrbkvXhGu/520DKLi058DhBLRg+/+9UhoJkSPKlRQcLEy9Q9SmxKklHj1Rgm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059771; c=relaxed/simple;
	bh=XMhav62srv7yxY7b3uPFAZHR0Ww6maijRWT5EJkstUI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CyP6nuGZ8KkyMqSaevpz+SUcpCah8Zznf0L1L8i9LWtjF2VBjJ/wts79hJoP5azOLCKoIQMVeS0QRWpncd1xsHpC68mn16qhQvzsyngIYEakKsejMN9tLTr/Vy8qpB3xhR4AdckUzE0EOlYCHDBAEU8sbJI4KjgxSgKwvp5uhQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MHHkDkX8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fa4kRjCW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MHHkDkX8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fa4kRjCW"
Date: Thu, 15 Oct 2026 10:22:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792059767;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqoEnpdmqTF+wtey2RG5mf3tRFQHchvkSem9Dhxt1+M=;
	b=MHHkDkX8es/YGsXgdZA3e2e5MCcLgb0F1yPFIGcopOTQQpE2n68z9+3b15hTqWv91z6XE0
	oM1U/uKEoO1+0ERVAXP7XqMmjLt013XXHyA952mLkY4oU6yMU62CLJo3RVYxbEOww4dyKX
	ToOCGkjI1+C57KPZesDXVB+lsjgJyT/l1BA/mQ0ubiMXESiBm3YlrSyeWlYjDtjXeYqD/D
	958jQZzxy+uBnG4gpH7/gjzhleSd+JBoBNyNHSjEBWMnb+a0zesqH0ZwwcWE7TaQkI5Oci
	FijOIJ+H6bkaTGoOYNZfxhu6E385SGx/xJeAajO+sNrTduqa8buiV/e4QX5cJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792059767;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqoEnpdmqTF+wtey2RG5mf3tRFQHchvkSem9Dhxt1+M=;
	b=fa4kRjCWeOFxnDwsPk2NgSRRdT569Ps2256qmuCZRkFCxEYrMK44+u1ivFzGxKKO9U7Gng
	xlcwvLrapjQ8ygCg==
From: "tip-bot2 for Au Dang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Preserve TIEN state in
 rzv2h_tint_set_type()
Cc: Au Dang <au.dang.jx@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Thomas Gleixner <tglx@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261014095927.635132-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261014095927.635132-1-tommaso.merciai.xr@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179205976578.2666988.456425920660052574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     42bedd4af8cd50c32a1560d8744bd22d25be79cc
Gitweb:        https://git.kernel.org/tip/42bedd4af8cd50c32a1560d8744bd22d25b=
e79cc
Author:        Au Dang <au.dang.jx@renesas.com>
AuthorDate:    Wed, 14 Oct 2026 11:59:22 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 15 Oct 2026 12:16:59 +02:00

irqchip/renesas-rzv2h: Preserve TIEN state in rzv2h_tint_set_type()

rzv2h_tint_set_type() clears TIEN while switching the TINT source and
then unconditionally sets it again, enabling the interrupt even if it
was disabled before the call.

Restore the previous TIEN state instead of forcing it on.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) dri=
ver")
Signed-off-by: Au Dang <au.dang.jx@renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261014095927.635132-1-tommaso.merciai.xr@bp.=
renesas.com
---
 drivers/irqchip/irq-renesas-rzv2h.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesa=
s-rzv2h.c
index 1a4703a..485c3ee 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -420,9 +420,9 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *p=
riv, unsigned int hwirq
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
@@ -477,6 +477,8 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsign=
ed int type)
 		if (tssr_cur =3D=3D tint && titsr_cur =3D=3D sense)
 			goto set_parent_type;
=20
+		tien_cur =3D tssr & tien;
+
 		tssr &=3D ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | tien);
 		tssr |=3D ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
=20
@@ -489,7 +491,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsign=
ed int type)
=20
 		rzv2h_clear_tint_int(priv, hwirq);
=20
-		writel_relaxed(tssr | tien, priv->base + priv->info->t_offs + ICU_TSSR(tss=
r_k));
+		writel_relaxed(tssr | tien_cur, priv->base + priv->info->t_offs + ICU_TSSR=
(tssr_k));
 	}
 set_parent_type:
 	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
