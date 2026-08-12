Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F22402B8C
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531624; cv=none; b=m83fQVMzqhSkVGU5Lx578uoWzxASJXVAULJwWNSzJVluMhzF33xlb2zeqSaJh/dBqXS+cO9HVK7rgdPUTgxZjcS0YIXD/pXaOmMvVqJgU6RiJ/9+f7odAxr64pAxxN4cZSIqUYt96YEX0IOGPD2X/lGYLZIhD36YCwUGyId2sgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531624; c=relaxed/simple;
	bh=Dm5nsCEAELpPhQlKFxFDjo+xRS3ptdGgPQScnuW1e7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHkpG0zHMeOsyCOY3v/EPa0vn/6ICe68KmYratkpUEl494yaRCRo/pADdqgi+mirMj63szXPxnWPSNmzGY+rtmnEu1XZ0ITwQtINUuxAyV115c1IpQHasIKX4IKhsw4OCnSTpMc/1On+IcIw+D9rF78ZICcabhZDdJCYkduwRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bg3VX9p6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bg3VX9p6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45311F000E9;
	Wed, 12 Aug 2026 10:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786531622;
	bh=Gk+1fZNQk+Sit3eHKREHpZOIT3rMyXfqRiYins2I2Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bg3VX9p6Ae60jvcGJfKaJoHKn5n8L9WkTgda+JZOd3nYLXit2APmiiQPnmE2pwPg+
	 tTluWSJdNlxOpxKhCQxwRyBSjJgjlUOKSx4swXHEAEwhx5Dv228ZKaJMBrmfCfCd7h
	 PXzdAlFhvzl2cHoWTy7fuN2QlbhUk1+tSGABIHdLKkVzfdI7GjW3JRW3tkxcIF2/Qh
	 99E+e+6Tm/x1/SiIuSo06BVgpLY6z5UJkmFcuT3SxiwlDwJeHBmooDdPsWJvKL7Z6q
	 1pyrJ9wPMloZFnpvnMLPkCHB4Ua7jUDhsx8Sc2AEFiIJfSPSVv92F78gjPbM5Wa1Y0
	 BwAwxe2jwDO7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Vincent Mailhol <mailhol@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] can: rcar_canfd: Invert reset assert order
Date: Wed, 12 Aug 2026 06:46:55 -0400
Message-ID: <20260812104700.1834989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080503-lyricist-prowess-dca1@gregkh>
References: <2026080503-lyricist-prowess-dca1@gregkh>
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
index 4c0d7d26df9f3..4d746e87bc27a 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2202,8 +2202,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 fail_dev:
 	return err;
 }
@@ -2224,8 +2224,8 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 }
 
 static int __maybe_unused rcar_canfd_suspend(struct device *dev)
-- 
2.53.0

