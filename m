Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDCE3806DA;
	Fri, 12 Jun 2026 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280320; cv=none; b=OadO9SglA+dj265No7VJUl31sopcgyJAjEXP0QY4MjTU3vXFmG55WXZUHcdbMB1TiHnv/zauRu1Gz539cw2BeAwJJRCQAFUC0kWjKvu0BpNMU9plIapvDBoyoP+F3b6EiB73Q4c0EF0nsqwjEO2Rh+Lr2yhjoNTPiTOP4zfBiK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280320; c=relaxed/simple;
	bh=VwA2753pg2k/ynXpbCLfyE4qpjk1TQUzkrVnanRi56c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zj1HCEwjxLbN/5mEWld45CIzCE+xQuvZZ0Q08gbU5Xg1AqzGrCcUpnXpBerj4Jm9s/Po6SIS8FSAYm9H5dszAgz0Lvbh8Rjh+9IGd96qrqG36aBozww1hGCXniLhnr6GKgYhe7u8G1PTs0pyXGpIqRJVrrDvaIA6ItOt8dsWVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWVk/2r1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWVk/2r1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632FF1F00A3A;
	Fri, 12 Jun 2026 16:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280318;
	bh=TKn9uhAJWlT6BrId2omUn9JuAlf/aJfC5YydL8TPGko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QWVk/2r1crt+eXao2CkRRqy4pwZgUIyndoN9dxOtUZuPiNAuG+ei2gPIV7OINrrAC
	 0AWiQA2qD8QLxcMi2Ai5SqTK6XYDvkOj+40CzmURwPiQLzXFtOef7sMVAdUMy/jgP0
	 jK/DnY4QVowCf1ufwCjt4btBZoC5JCNSviPQpHEP0vt04oHKrRj40L4q9zA3YjDJoE
	 o40ApMVtIDz0oTDDQij9NBiYk6JbqKSmiab3fDW7KeGa5SQfE/3Rtww3j9gvRzrViW
	 7FeK6xOnCA12DeEU4CJwyc0gbXg882Fm+v9afn5wLms2mMAWpz5rhd2FCY9oZDfrlA
	 s5hdQVc9JfghA==
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
Subject: [PATCH v4 05/16] i3c: renesas: Reset the controller on resume
Date: Fri, 12 Jun 2026 19:04:47 +0300
Message-ID: <20260612160458.3102106-6-claudiu.beznea@kernel.org>
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

Reset the controller on resume after enabling the clocks to follow the
same sequence as in probe and avoid potential ordering related failures.

With it, renesas_i3c_reset() was updated to use read_poll_timeout_atomic(),
as the driver's resume callback is executed during the noirq phase of
resume, where interrupts are disabled.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- collected tags

Changes in v2:
- replaced the read_poll_timeout() in renesas_i3c_reset() with
  read_poll_timeout_atomic() as the renesas_i3c_reset() is called
  in noirq phase of the suspend/resume; updated the patch description
  to reflect that
- collected Frank's tag. Frank, please let me know if this should be
  dropped. Thanks!

 drivers/i3c/master/renesas-i3c.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 4b81c32b1fde..67b9a31300d0 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -480,8 +480,8 @@ static int renesas_i3c_reset(struct renesas_i3c *i3c)
 	renesas_writel(i3c->regs, BCTL, 0);
 	renesas_set_bit(i3c->regs, RSTCTL, RSTCTL_RI3CRST);
 
-	return read_poll_timeout(renesas_readl, val, !(val & RSTCTL_RI3CRST),
-				 0, 1000, false, i3c->regs, RSTCTL);
+	return read_poll_timeout_atomic(renesas_readl, val, !(val & RSTCTL_RI3CRST),
+					0, 1000, false, i3c->regs, RSTCTL);
 }
 
 static void renesas_i3c_hw_init(struct renesas_i3c *i3c)
@@ -1485,6 +1485,10 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 	if (ret)
 		goto err_presetn;
 
+	ret = renesas_i3c_reset(i3c);
+	if (ret)
+		goto err_clks_disable;
+
 	/* Re-store I3C registers value. */
 	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
 	renesas_writel(i3c->regs, EXTBR, i3c->extbr);
@@ -1504,6 +1508,8 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 
 	return 0;
 
+err_clks_disable:
+	clk_bulk_disable(i3c->num_clks, i3c->clks);
 err_presetn:
 	reset_control_assert(i3c->presetn);
 err_tresetn:
-- 
2.43.0

