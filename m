Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAA0453A2E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931235; cv=none; b=uJAGi8jJ12P2GDeONi/O8FLZgNRv6KIRMNk6Lwd/zzHDoJVoN/W3pbq9O3hNGyAoRcFQQTziWHYaSX2mbRk////z3mOiOmtlPbHh0dTquTIlj7acfvNTStws90+xA6GGR8uptCyUKZIfGhMRnCqMRIpuWma/VdGlJ/14K4GKFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931235; c=relaxed/simple;
	bh=IQKCf+VuvETex3OrjEo+4iAyV5VGp1tpJpG3EUtqhvc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j+mJh4UK0+nVZGzFZuHYV+CLVdSFW9ovT3QYtS1XdPOSG7lR4fJtMQg/YM2qc2kRjzauiCCQcr33nSJJ5s1KRPmRWezN1MbG2+Clz6/ObMbRKTwZuJFA2F27O+3dt2yw7vCYGCYnHzhKpfEvNNVv23bpvlv4LYN9/5U3M2oPnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gSS013Mx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gSS013Mx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284261F000E9;
	Wed,  5 Aug 2026 12:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931233;
	bh=X8CIvQCF2XiBp12GfIuwhGp4bk0DI6+vz21TGkYpWh8=;
	h=Subject:To:Cc:From:Date;
	b=gSS013MxUkMKILMpUE3nJ0C9V19ghkmRRAzbLDCjsVK8EYtIZgRD1UpkfSzr6rWkO
	 Urto5XZ5QBtwxndlVjCm5yaEKfT+XC8sC2ATmnaUKrRHFGZxBfHXjmF3f46/Vu340U
	 N0biJXs3M0GBgi0r0c9GwJp0jyyxIaF9+lmKvoMQ=
Subject: FAILED: patch "[PATCH] can: rcar_canfd: change the initializing flow for clocks and" failed to apply to 6.18-stable tree
To: tu.nguyen.xg@renesas.com,biju.das.jz@bp.renesas.com,claudiu.beznea.uj@bp.renesas.com,geert+renesas@glider.be,mailhol@kernel.org,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:55:03 +0200
Message-ID: <2026080503-lyricist-prowess-dca1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x bef9004c5b91debfceaea2841855a4ebe81ff2b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080503-lyricist-prowess-dca1@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bef9004c5b91debfceaea2841855a4ebe81ff2b3 Mon Sep 17 00:00:00 2001
From: Tu Nguyen <tu.nguyen.xg@renesas.com>
Date: Thu, 25 Jun 2026 14:51:51 +0100
Subject: [PATCH] can: rcar_canfd: change the initializing flow for clocks and
 resets

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

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index eaf8cac78038..fcc37b73ed43 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2003,20 +2003,12 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
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
@@ -2027,10 +2019,18 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
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
@@ -2068,14 +2068,14 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 
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
 
@@ -2090,10 +2090,10 @@ static void rcar_canfd_global_deinit(struct rcar_canfd_global *gpriv, bool full)
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

