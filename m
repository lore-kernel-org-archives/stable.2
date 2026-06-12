Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379838F23D;
	Fri, 12 Jun 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280314; cv=none; b=thV2VlJQJQmDuZpDaOmwznCF2feg2yNXvsLgCy4cz/0syprzfE+mEvqpR0VJHg/5nPyLDjrpugsPdi6NgunCGfcSD/30VcyK1wodmaU4aAQpPcQrovxQTKDikkYuyo5Qo03zWRfFOKn6/xfFi6TLemjSLcl37hR82XKLcxR+Log=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280314; c=relaxed/simple;
	bh=ScWkQ+p/A2KDP2LS8aQJW1VwNQnxHu1eNdty8AIooLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fel9crA/nCsanw3XqCndACs7XGGzSyM7qP6ccdJa8NwwAyRllhivIlH49w/AcIjbddub2+HGQzuAF2Yov434m5Wf8sEyFcyZxMckM4f2Tah7gWS5mMcFccj2ht9qF02mtwUe4d0VoIfBpnAG5bes4XQEyGJTHTUYqWc8IwrgfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwdfzhRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwdfzhRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FE71F00A3A;
	Fri, 12 Jun 2026 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280312;
	bh=XRz/FFtSHJIJsXIK2VQ8xgiI0tAaDdPLADJ0hTGOc0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LwdfzhRLnprQdstyFT/VGiBdIGNt8e2NQQpsrOHSPJYjFxb2WuA6ERCi6iR0MjZs3
	 bBBE8UT1yLlsKI0bINxEP/IOI2znwHfIuqLFAjYOMyi5kvZRTTHM8an0AhqHw8Gjx5
	 D9+AEIFSMAPWaT7CdyAlg90KCNt7t8QlGWI1/Ub/YBx2z4r+a/Rv3TEH7YgfF4M8Z5
	 Bu93w4Vdzjxw/aabLRaIdwl97EDanfVHB1LCIqcW6IRNKjYVa25gKyvdVIdkW5/B87
	 b/SI9zqN1AIgVKr5DPh18GNA2CaLNUGOPbqeixcjMpThyua0mR66ifaaNB35AdlMzt
	 m51HjABKZa8nQ==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 03/16] i3c: renesas: Follow the reset deassert order used in probe
Date: Fri, 12 Jun 2026 19:04:45 +0300
Message-ID: <20260612160458.3102106-4-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612160458.3102106-1-claudiu.beznea@kernel.org>
References: <20260612160458.3102106-1-claudiu.beznea@kernel.org>
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

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/i3c/master/renesas-i3c.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index e70db3a17bc7..7d448936b74c 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -1457,17 +1457,17 @@ static int renesas_i3c_resume_noirq(struct device *dev)
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
@@ -1488,10 +1488,10 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 
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

