Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC87B394E8A;
	Mon,  8 Jun 2026 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949763; cv=none; b=ZmHS0yZWhSqEFdbjyEmRaG1v0RADvbPzcC0GJOqAOEgqB1iDqyngvF5QZpCu7jTgmYWV7kSh0xRtOs22nM6i/LiYQ4ppHdZW+cplhf4ejhu4Ferp9Un+cuN6GBDZJIxE8uc0wBKi87gqQTms/XMfB8fzDFRKWsYhEvw3b6TddJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949763; c=relaxed/simple;
	bh=ctmc5Cnt5dYWekzTmByNoGrzWo7KMVKFFilklkPaABA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seXMeezbG7B8vcrnmiV5PFFGVmlGapgvp9PjPxGOpLjeFPpFehzqiRWLBGcLDmqak0BdnKaX1JCDl+RjF7w4EKixfGo55uDeKsmf/HF2CzIp2Cwy7bBUqOPL6TWiQLYWTOjNjqR/sZVqQwfvcSwSJCOK8wNBTwt87iLKo3taEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIvJ9q7S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIvJ9q7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0767F1F00898;
	Mon,  8 Jun 2026 20:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949761;
	bh=DHwFqL4VSTCkylyGRo5OPZaQBQuLH7xv9iUuuKDMbZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LIvJ9q7SbouUDhYrbdF7zGRR54pI6K2JbyUfMgZZUVGUciCR4gzDtCPJ0rILsEey9
	 eaLwN4Io+tyUU7UHXT/8XjB3lw/2kJIQ6Jr+sDqC7Yb8nmbX8QUYJvl6NU7VJ+cEQ1
	 f+DbiNA8EBIq+N/67uuBNTuQuK0MC0Fuy955RU050XgvpAXSDH1pNUhJtcuJS62vUC
	 hECSQYjY0uyyCZ9lTCslJIIReQp9VNKmJNNPw6XcYovvIpwR3tgRGrgsO5su6BvVlr
	 immTb/Kn7Ei+Fovf5cvWrOzTU2fqCrAkVorD3AR8KDpz6laV1cKGdYdxJRb6SjVhGn
	 r6w72Qvyak4+g==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 03/17] i3c: renesas: Follow the reset deassert order used in probe
Date: Mon,  8 Jun 2026 23:15:29 +0300
Message-ID: <20260608201543.804902-4-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608201543.804902-1-claudiu.beznea@kernel.org>
References: <20260608201543.804902-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use the same reset deassert order in the resume and probe paths to avoid
potential failures due to ordering differences.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/i3c/master/renesas-i3c.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 88a16efe096d..4c86e7257804 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -1455,17 +1455,17 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 	struct renesas_i3c *i3c = dev_get_drvdata(dev);
 	int i, ret;
 
-	ret = reset_control_deassert(i3c->presetn);
+	ret = reset_control_deassert(i3c->tresetn);
 	if (ret)
 		return ret;
 
-	ret = reset_control_deassert(i3c->tresetn);
+	ret = reset_control_deassert(i3c->presetn);
 	if (ret)
-		goto err_presetn;
+		goto err_tresetn;
 
 	ret = clk_bulk_enable(i3c->num_clks, i3c->clks);
 	if (ret)
-		goto err_tresetn;
+		goto err_presetn;
 
 	/* Re-store I3C registers value. */
 	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
@@ -1486,10 +1486,10 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 
 	return 0;
 
-err_tresetn:
-	reset_control_assert(i3c->tresetn);
 err_presetn:
 	reset_control_assert(i3c->presetn);
+err_tresetn:
+	reset_control_assert(i3c->tresetn);
 	return ret;
 }
 
-- 
2.43.0

