Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0819D471D05
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129794; cv=none; b=Mdb94F7CYo5U4W0BZv9Ea3tGXyvPjebv/LN0pEFQ+COR9zIEY53gYlf4GnvylVKdFAB5dXQHaQj8bm4FfJrpAroVpf+jC20hn2lrzMnjltx/QPh3km2sU/k2RaghHcZile5HW+30HP1+eRj/BZYwCiog86DpbdnqTW4OM4enO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129794; c=relaxed/simple;
	bh=kH2qRCQW6tVsPsKPFL/5SN9YdkWKI5VV6EE0djst0is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D22ZNojEvOJNMfCFXsP4jlAFKkEqGUW/EWfBuCYQWjTKgebjyj8H5Q78rXCSmtmJ4dI7cufUNGO7quU+jKGbS1WIOMphfUecM4jhQ68OxE1IZzRkECQMsPER+LJflKv/y2RtHv4gg74COvI9jDXU4VoW98AezMnwmMABNLm3284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBPkjZVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBPkjZVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67201F000FF;
	Fri, 11 Sep 2026 12:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789129791;
	bh=h5wwFrfkgZ5WQgfOw2zMqW340FUi1iNV9HgaQ6w2H1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SBPkjZVIKOHhMtbS6f5uo0dlnZfOfft8lGH82Vucgm9ZAQ2ayS6HJ64++8r2ivIB6
	 m4FjSlQivkduuENdw8pL11gy7SeopSvt5D+JC72D2X6lZy+xlSNbXl2HvgCcl/pOBI
	 6igRhU2ZQVPHLpPfYX5zN3aHlZV/RePDcaD8QwmCXKhR3LaWAPB0jlP9IBJDtB8aiM
	 x0a0D79OWtusB2pL8rpNigjOUkdbKa8Oz9b4Epy+icqy0//tJWGEhCkL3iM4zPhyHE
	 H1Yk5UejB3CjraUEV+yc8oXfmBno3TlAKSiGMnhyBBfzRMe0O4ylMzAQbsYJRt28Gs
	 5R83o9ZxOms3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] media: sunxi-cir: Clean up dead register writes
Date: Fri, 11 Sep 2026 08:29:48 -0400
Message-ID: <20260911122949.555717-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090910-petal-cupcake-2b81@gregkh>
References: <2026090910-petal-cupcake-2b81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Holland <samuel@sholland.org>

[ Upstream commit 586bb700b3256a1cb38935f83c76e6522ac53d64 ]

The register writes during driver removal occur after the device is
already put back in reset, so they never had any effect.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 479aa6fa8c50 ("media: rc: sunxi-cir: Unregister rc device on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/sunxi-cir.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index 4afc5895bee74..7a67e79d637a3 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -310,22 +310,12 @@ static int sunxi_ir_probe(struct platform_device *pdev)
 
 static int sunxi_ir_remove(struct platform_device *pdev)
 {
-	unsigned long flags;
 	struct sunxi_ir *ir = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(ir->clk);
 	clk_disable_unprepare(ir->apb_clk);
 	reset_control_assert(ir->rst);
 
-	spin_lock_irqsave(&ir->ir_lock, flags);
-	/* disable IR IRQ */
-	writel(0, ir->base + SUNXI_IR_RXINT_REG);
-	/* clear All Rx Interrupt Status */
-	writel(REG_RXSTA_CLEARALL, ir->base + SUNXI_IR_RXSTA_REG);
-	/* disable IR */
-	writel(0, ir->base + SUNXI_IR_CTL_REG);
-	spin_unlock_irqrestore(&ir->ir_lock, flags);
-
 	rc_unregister_device(ir->rc);
 	return 0;
 }
-- 
2.53.0

