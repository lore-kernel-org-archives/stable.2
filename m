Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040942641B
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531628; cv=none; b=XWyBb6wRl9V8+Yd92USHInnlvDvHAudy18ze7mwCMHsmaiUZnRY98mY364PeTSd7ejHmvoyBBqo+Vx6p17mCyD6yzvl37muOt5Nei3506ez5+2gS0cmduNlXw4nF3W+ui1Ti0Omajqn1ltILFGXsCNSxcCGP7qAusoLmxydi0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531628; c=relaxed/simple;
	bh=e0v5AZJfv4u6LrjOJZV7njht7iJvv6zbYWcpeXj0IEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVPnw1N0O+wJ+tpe4gfbka/l8VcS30w2bweFVEhad4RQ4UL4fHA2x6PSu6BASyMNJ12XdtbmeAcBFN1VrdQ+g/AD+6priEBGxRtrLyCNuQnaKsh4pKFT94/8rGawoa+7eq1R0nVOqNOMcGqQns0+oDvKeglqxmmnEWfA4DsHQl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV/MCTwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV/MCTwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58601F00A3A;
	Wed, 12 Aug 2026 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786531623;
	bh=L8HqUA4Y1zzlG6Ja4axDHu5QtJiMMKWBqVMSxA8epeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WV/MCTwTUgldn2xdLOFm4cR1BZtjhxSWtw5hk3akGJpvIC7Capk33k09fRUd3iM8k
	 lluaNp89YstVgPHuaYwYMG3g0wCGhrZYB8ExKO0SpYkJFKsfdY+4IiGCJzL9dP/mOt
	 xTHwjybtmvHUfEG3oDqhx/X4LOD+QuJ1PnUATsD/pCA91JaVcXM+qC6Oqyx9y/69O3
	 Mu2Gwi8mevXjFqx6/13+eJHmFvwESYRwDFXwZE8wf9IGwvv21/CWBnQbDXhIwNeQGA
	 wTzHimhyavQEk1d1c19nr1rHw9YZbe2eG0XDN2aOlv9tTiRewUWfhaQNdQurvAxHFY
	 +buKHGtDcGfsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Vincent Mailhol <mailhol@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] can: rcar_canfd: Invert global vs. channel teardown
Date: Wed, 12 Aug 2026 06:46:56 -0400
Message-ID: <20260812104700.1834989-2-sashal@kernel.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 790ec4c453890f1221ea595674a1206bbee41dc4 ]

Global state is initialized and torn down before per-channel state.
Invert the order to restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251124102837.106973-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Stable-dep-of: bef9004c5b91 ("can: rcar_canfd: change the initializing flow for clocks and resets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 4d746e87bc27a..c6da880f8f89e 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2213,14 +2213,14 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	struct rcar_canfd_global *gpriv = platform_get_drvdata(pdev);
 	u32 ch;
 
-	rcar_canfd_reset_controller(gpriv);
-	rcar_canfd_disable_global_interrupts(gpriv);
-
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
 		rcar_canfd_channel_remove(gpriv, ch);
 	}
 
+	rcar_canfd_disable_global_interrupts(gpriv);
+	rcar_canfd_reset_controller(gpriv);
+
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-- 
2.53.0

