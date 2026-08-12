Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739C1426D0A
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531627; cv=none; b=nuyHs5AthfclcYc3C8yM91GimLUhHePtwtzX/TjM7VEVZj6p7TAHKcaz4DZubywzw/tf6Ld5j5KFBOjBq2ztUyvIPq06ESeTLlSZbumsDZ8skjnEceNfiV4NiCEeHbhauAdw52R+kISfZTBa7l5zXqvFPqxKH4fRQP53AEctE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531627; c=relaxed/simple;
	bh=8fNYk7wRn2xNKS93HmFgWHoUlCmDPuCfRc1atDEnXX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiNaSDhMEaevO+UuTXX3MUWcSOsdxfnH7XPM0b3SAHvZo6vMfzHSIJfZs7PqaCx4qliqlByGt4H7wc1NJrB2cL/W5FarYxu2nHWuJn+zKK45sEDBZ+p7eb4WMJiGnsXhA74dmiujRtChF9RH4o/tbRMTUgHu5XJqemoMvsSpt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJU44SLK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJU44SLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3FF1F00A3E;
	Wed, 12 Aug 2026 10:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786531626;
	bh=K2Xst3j3Z80Jp5vUHWUlEvziV9uaCLxVHuJv//zqysA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gJU44SLKYxBcMU3VzdZ26hyS9Omf6hrykvO4/qQbFutfdMKJXpyjVKoH1ma0IuFga
	 TTWkWW3eS6+tobbm+1h0pJj1P3ewH+zlbbmcLVhWJbxpHRbM8q4tLXXbsbvIVngxkx
	 TuOWt6JIhVZYZkTFKNPPJqm/un3k8EVBoWIFgHPUvWv05SXJHfT04e922yBpngm6RO
	 JLybTgmuGXKFQGW8nBa8rBOlBf6Pg0AOxO3BMsuT+CwPX87tuH8CwNzBITNNaFHzbi
	 K3+p4RONO16n24zeF5BML9IydtjTNO1imdOEjdQ3ECmVTWIPNKryJ3lNF8V5l/RbLI
	 31kHZUyRWMLMA==
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
Subject: [PATCH 6.18.y 5/5] can: rcar_canfd: change the initializing flow for clocks and resets
Date: Wed, 12 Aug 2026 06:46:59 -0400
Message-ID: <20260812104700.1834989-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812104700.1834989-1-sashal@kernel.org>
References: <2026080503-lyricist-prowess-dca1@gregkh>
 <20260812104700.1834989-1-sashal@kernel.org>
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
 drivers/net/can/rcar/rcar_canfd.c | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 9081ddb59f8b3..45af1d121a845 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1978,20 +1978,12 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 	u32 ch, sts;
 	int err;
 
-	err = reset_control_reset(gpriv->rstc1);
-	if (err)
-		return err;
-
-	err = reset_control_reset(gpriv->rstc2);
-	if (err)
-		goto fail_reset1;
-
 	/* Enable peripheral clock for register access */
 	err = clk_prepare_enable(gpriv->clkp);
 	if (err) {
 		dev_err(dev, "failed to enable peripheral clock: %pe\n",
 			ERR_PTR(err));
-		goto fail_reset2;
+		return err;
 	}
 
 	/* Enable RAM clock */
@@ -2002,10 +1994,18 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 		goto fail_clk;
 	}
 
+	err = reset_control_reset(gpriv->rstc1);
+	if (err)
+		goto fail_ram_clk;
+
+	err = reset_control_reset(gpriv->rstc2);
+	if (err)
+		goto fail_reset1;
+
 	err = rcar_canfd_reset_controller(gpriv);
 	if (err) {
 		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
-		goto fail_ram_clk;
+		goto fail_reset2;
 	}
 
 	/* Controller in Global reset & Channel reset mode */
@@ -2043,14 +2043,14 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 
 fail_mode:
 	rcar_canfd_disable_global_interrupts(gpriv);
-fail_ram_clk:
-	clk_disable_unprepare(gpriv->clk_ram);
-fail_clk:
-	clk_disable_unprepare(gpriv->clkp);
 fail_reset2:
 	reset_control_assert(gpriv->rstc2);
 fail_reset1:
 	reset_control_assert(gpriv->rstc1);
+fail_ram_clk:
+	clk_disable_unprepare(gpriv->clk_ram);
+fail_clk:
+	clk_disable_unprepare(gpriv->clkp);
 	return err;
 }
 
@@ -2065,10 +2065,10 @@ static void rcar_canfd_global_deinit(struct rcar_canfd_global *gpriv, bool full)
 		rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	}
 
-	clk_disable_unprepare(gpriv->clk_ram);
-	clk_disable_unprepare(gpriv->clkp);
 	reset_control_assert(gpriv->rstc2);
 	reset_control_assert(gpriv->rstc1);
+	clk_disable_unprepare(gpriv->clk_ram);
+	clk_disable_unprepare(gpriv->clkp);
 }
 
 static int rcar_canfd_probe(struct platform_device *pdev)
-- 
2.53.0

