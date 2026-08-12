Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71F82F5A06
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549863; cv=none; b=ee6N3tj4Wjc0sxuDLkuuQ2i+qXUCHDF6fOkRrbynJJkzO4rsbNbjiXhRynBK3b8nkD2a5262r5xfAIrM90xnwso0wudXcHVn2SDqr7ZE6CYe1an5F66J6yaGGGD7JPgSc9BCKrT1F6zfuelO4Kcw/hRgEMEYOMEkTE0O/g2D0qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549863; c=relaxed/simple;
	bh=K/48J1jFntIEyQXgBwurifAkkH5y8MQgo6niYQ/ejKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9pmRqka2SBr4mMJTv3pTr+M3yJrtwavRW2BSHExxoXMEKptPovFRJOdQkNwMxCjVxUpU4vyGqgvgdfuqjGnfvSxbDap0S2rkrCstH6YB4nhEkMeqV02UqNP7jnVz/atRNaaz2zG45ado7amE7hM0GnINcpjWBdvQSQcMrABGYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRpy1Mdj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRpy1Mdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C461F000E9;
	Wed, 12 Aug 2026 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549861;
	bh=H9O4h4Xj7vnLLOh2/euIHYru+NwpOaKP+diZp9mJotI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VRpy1MdjH23Rhmtz4CmjBwZg882dN7IAVZi9oZE1A3utU9NDcYTT+ZKfFKZqHAEJR
	 TC9dJW3DNhx5EI0fLKtKl+meXS/h6mD3sBxLFXwGqtr/t/xV5Xe9G/LXIKKjYIJiVH
	 96qZFr/BRaG7YZRcaXTnx9YYhW4ALw0yZJ3NonwBjGqd6wzY2xXyCsWOoi2BNL7Vpw
	 bHsGD9t20MpOmjCwPXpVNx+NFr1X1/pSPbvUh5MKHT0rQylrEzbvxot4IjGO0HuV1d
	 KN9O+L3E34IR+fdmR9JvaXbHrRUZB7fAOPajsL6U+QTSdo6LRPv+NI8+ukgl1+GrLz
	 0vOyUIhRbp/YQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tu Nguyen <tu.nguyen.xg@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] can: rcar_canfd: change the initializing flow for clocks and resets
Date: Wed, 12 Aug 2026 11:50:58 -0400
Message-ID: <20260812155058.2239706-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080504-perm-haste-c08f@gregkh>
References: <2026080504-perm-haste-c08f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tu Nguyen <tu.nguyen.xg@renesas.com>

[ Upstream commit bef9004c5b91debfceaea2841855a4ebe81ff2b3 ]

Testing CANFD on RZ/G3E shows that many registers do not reset to their
initial values with the current flow of deasserting resets first and then
enabling clocks.

Based on the HW manual, clocks should be supplied first and the
resets deasserted afterward.

 section 7.4.3 Procedure for Activating Modules: RZ/G2L
 section 4.4.9.3 Procedure for Starting up Units: RZ/G3E

So, update the order of the initializing flow for resets and clocks
to match the hardware manual, resetting all CANFD registers to their
initial values. Also update rcar_canfd_global_deinit() to assert
resets before disabling clocks, so the teardown path mirrors the new
init ordering.

Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L family")
Signed-off-by: Tu Nguyen <tu.nguyen.xg@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20260625135216.130450-1-biju.das.jz@bp.renesas.com
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/rcar/rcar_canfd.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 5a30667001c94..0a2dc41d40d4f 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1999,27 +1999,27 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = reset_control_reset(gpriv->rstc1);
-	if (err)
-		goto fail_dev;
-	err = reset_control_reset(gpriv->rstc2);
-	if (err) {
-		reset_control_assert(gpriv->rstc1);
-		goto fail_dev;
-	}
-
 	/* Enable peripheral clock for register access */
 	err = clk_prepare_enable(gpriv->clkp);
 	if (err) {
 		dev_err(dev, "failed to enable peripheral clock: %pe\n",
 			ERR_PTR(err));
-		goto fail_reset;
+		goto fail_dev;
+	}
+
+	err = reset_control_reset(gpriv->rstc1);
+	if (err)
+		goto fail_clk;
+	err = reset_control_reset(gpriv->rstc2);
+	if (err) {
+		reset_control_assert(gpriv->rstc1);
+		goto fail_clk;
 	}
 
 	err = rcar_canfd_reset_controller(gpriv);
 	if (err) {
 		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
-		goto fail_clk;
+		goto fail_reset;
 	}
 
 	/* Controller in Global reset & Channel reset mode */
@@ -2070,11 +2070,11 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
 	rcar_canfd_disable_global_interrupts(gpriv);
-fail_clk:
-	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
 	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+fail_clk:
+	clk_disable_unprepare(gpriv->clkp);
 fail_dev:
 	return err;
 }
@@ -2094,9 +2094,9 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
-	clk_disable_unprepare(gpriv->clkp);
 	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	clk_disable_unprepare(gpriv->clkp);
 }
 
 static int __maybe_unused rcar_canfd_suspend(struct device *dev)
-- 
2.53.0

