Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E532F748;
	Wed,  3 Jun 2026 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499822; cv=none; b=AJxUqkXfnFJMWEbpexi8S0bPSF4GbIFiwY/8gIvFbCHBa2tI0g4N9s3QCjxfAlXz4MgXNZy5ly4X9jG8tUalKcpsI4XoU4ANW1zF8urr/FRJN/w4+NiH6Z2Y0swJL83EX5SsvnmQFa0XRVrY80B0uUk0rbJYeUBV4txu5E6wIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499822; c=relaxed/simple;
	bh=NyFiUec/36k2DOCc1WPXAm3C8qjmJZtAAuF0gZHzpEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAS5j88CwRrQFhQ1wsRQPjTZGCVH/WkmT8L+Gim+fSTzxTLAyzlvSAF/HESROuVgkJtu9V+MbhpHS/wGQx9Zr6okSGBh1eOeEhaqJGtJrBBOOGiUW7jlSwYi6yC12oBTig6cufYT4C4eRrGxuDWEf2MnQnQEAtYbSULYMOjoyBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMlO9bSg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMlO9bSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916801F00898;
	Wed,  3 Jun 2026 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499821;
	bh=XDIwh/usRBAV/ZKdp5/gXu5Q82igijMkQ+3odZ715bY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kMlO9bSgDDfK9IaZgh+oRNmQjjS/tJpX6hT3IQt6mzIreMrATDG6ZWsJetANdEjmB
	 A1dLXsBLbq+UzyaTb3i83jVIHAuqkhXi4k9xhoOOmoq5ByXgXzcsib3Kf5/OhNH5Gi
	 tImJKhswvL1dJvPT4vNbQBFGJC5wZ6LvbWMSx+wMf1uttB5K0OPqm2FbPuFnFuhLP7
	 khN/yUTotX0EwfIA0YZ/sdU8TlVXqvpo+NxnmJiP6YnHzf//KXkr7Rgw73Ts81XVUY
	 5vvmGAX+1SpNUF8imXG4gSH6uArIHR5ma8cXlZSvskg9YDF9PgQ9uSxkwM8y+XPXMP
	 e2iXMhVi20U+A==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: geert+renesas@glider.be,
	linusw@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/6] pinctrl: renesas: rzg2l: Use raw_spinlock_irqsave() on power source update
Date: Wed,  3 Jun 2026 18:16:37 +0300
Message-ID: <20260603151642.4075678-2-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603151642.4075678-1-claudiu.beznea@kernel.org>
References: <20260603151642.4075678-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The rest of the driver uses
raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() for locking. To
avoid concurrency issues or deadlocks, use raw_spinlock_irqsave() via
the scoped_guard() helper for power source updates as well.

Fixes: bbe2277dedbe ("pinctrl: renesas: rzg2l: Add support for selecting power source for {WDT,AWO,ISO}")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none, this patch is new

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 83c61dcb24b1..be52d47d77ae 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1137,7 +1137,7 @@ static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps
 		return pwr_reg;
 
 	if (pwr_reg == OTHER_POC) {
-		scoped_guard(raw_spinlock, &pctrl->lock) {
+		scoped_guard(raw_spinlock_irqsave, &pctrl->lock) {
 			val = readb(pctrl->base + pwr_reg);
 			if (poc_val)
 				val |= mask;
-- 
2.43.0

