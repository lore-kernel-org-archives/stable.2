Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE2468C28
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549466; cv=none; b=SsyaJEwUk+u7ErEMduwDdsLGVWHax0I/24rAjRlSRqXwQm6xitaHjpTl8haURkx0cxENg9Vb4ba2TsE0JNiD3r2ZttAKS/h75k59TQFjPulI5Nd09ZPcCmxqdt0NEcf/cmBmWaqEn+MUfrvdAauXPJ4uPimeiixtb2BH5LQJMZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549466; c=relaxed/simple;
	bh=b9qWWGV2h4+oJmhawi5HNQ9x5mYj5NosjNyozgXW4K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GM/pqkVwjh9rMu2LMzqmlJjbvm3SfdKwHiN6QTNmnssO9PaOnv+uUQDqswUhHTaj5cHqj6g9OpFML5VezcvKnG/3cQsNxAQAxAojdQqd7SVVmHC/expTMkX3rCiePwCxVJc2txNj3Q7uCsmcl9NjSDclnziid9GL7kuTgH1VtxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvQyKIg7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvQyKIg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A491F000E9;
	Wed, 12 Aug 2026 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549465;
	bh=SNAsojsNN9dlMlyosqlbk0dohPmPyASBdU+PkSDusAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SvQyKIg75fM86zmY+a8o/xwDMVHaV4AQRPEClUuen7K3kECHAbzXyaoN94RAiCLzb
	 Ws95KcfanqCUwhd9LNBVusCXuxjZI2qQD3KsDtHd2KIi8OWt7wD33BvDg5gf/HKNg3
	 iJkGnYRQs9RVNUo573xd9ubHOzyIyqSx85aUCVO8ZWtNGFeWaza+3VVdKe4Hi+RH+u
	 YuQUKSflFAgRvvWIXTh6aic5l6Vkk3fXynVwm9TKCHwC1/n2Q+bmxFsle/lBc0PcK4
	 Rf2neINmHs/fCSY6bQKt2qnOJZF6qs8Gi7LAVjImb+kiHWxhoiuPPRi6dUYcX/CBom
	 Ig/Jd68hEkIFg==
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
Subject: [PATCH 6.12.y] can: rcar_canfd: change the initializing flow for clocks and resets
Date: Wed, 12 Aug 2026 11:44:21 -0400
Message-ID: <20260812154421.2235364-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080504-absolve-stand-bb3e@gregkh>
References: <2026080504-absolve-stand-bb3e@gregkh>
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
index ba662bef155ca..de2fef2652510 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1989,27 +1989,27 @@ static int rcar_canfd_probe(struct platform_device *pdev)
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
@@ -2061,11 +2061,11 @@ static int rcar_canfd_probe(struct platform_device *pdev)
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
@@ -2085,9 +2085,9 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 
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

