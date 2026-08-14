Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497F2E739D
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737046; cv=none; b=YEs1BFXdJwfbXZqJjWJxUdvNQe+5wXZDrS8vL6+j3vGClwQv5AQY/SxxUaq9gzg0tNoF3zJC8u5yLBWVkJCIQxn4/MhRuKuB5TIT4CUWPASTczSKHXeEZfZbqQSuq6GObflSMm+cFm4xT1oPE/9uYh6zp9+UckMPueoEQ33EcU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737046; c=relaxed/simple;
	bh=wvfaqA3nBIVWxP1673xDEsPHQFRAvqxe/IZf2HYZKIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgSfGMOUQ+IZSPG6aZFHfVP7nNhSiS632imgH4FXoicTxCqO4gwWhPBho7ppPW+NB4RCqcar/bmDTpxLYO/uGWkcC1ubewg1WbATBUkhcndzWlxA9Kc0pJwLqk1gN2KunoreaVi57YzvZGmoKZQHbhtDtFwIZGzA6XESexY5MCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeXofetN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeXofetN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2071F000E9;
	Fri, 14 Aug 2026 19:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737044;
	bh=YvOrS9X5jQXQO3s9Ist1rs2Dx9OfiNZ6Zug7YyGbtOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SeXofetNNqYOtqneWo8pYrmUbwM3mPtH3FoREhToH/ndaIr2eyG52D9CbS/HhE+xT
	 DEtGtyvhb7EKoNvn9oG5yaynY5gfWiItht/nNpE0OVmsE3PbIbJc1j2QIxEiN95U+L
	 R7E8aYwtg73cPX3T1wB/0bTLe8BQJ4R90ZG3YBp27tfiuvCNhZksvybqlTcmk1gzmg
	 SnGZZfd5IUYf6fC4W5p7mHzXVPX3dvtV7w+/KiVOB5SJnAvJdB03GRgH2xOJ2tYFJv
	 ZhBmolSrWFQdMLjXQ3h2bogLdINxMjx6Aik2oy+zQJCW+5dwLQpKVErR6PZFQTWGhH
	 MhGMUTu9nYSUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Vincent Mailhol <mailhol@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] can: rcar_canfd: Invert reset assert order
Date: Fri, 14 Aug 2026 15:50:38 -0400
Message-ID: <20260814195041.365045-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080504-effects-snap-d572@gregkh>
References: <2026080504-effects-snap-d572@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 41c13eaf39932fc79aa1ac245a9b97090fe23d5e ]

The two resets are asserted during cleanup in the same order as they
were deasserted during probe.  Invert the order to restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251124102837.106973-2-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Stable-dep-of: bef9004c5b91 ("can: rcar_canfd: change the initializing flow for clocks and resets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/rcar/rcar_canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 3d6daeea83553..7fc9e9f67bf64 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2035,8 +2035,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 fail_dev:
 	return err;
 }
@@ -2057,8 +2057,8 @@ static int rcar_canfd_remove(struct platform_device *pdev)
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 
 	return 0;
 }
-- 
2.53.0

