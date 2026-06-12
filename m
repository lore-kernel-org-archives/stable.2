Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091253911AB;
	Fri, 12 Jun 2026 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280311; cv=none; b=NkGJbb0ETh1pFjSp1cvDpHlOQ+UAHm8KbZzmoDBWdd9QeN2eXiFhXbpTMxz7b97pgnZqWWd/ApplBamhENvEXX9aJLmJS79RZzSVfocxqL3CXoAlAo0wzGUOcRrIdd9V/D3EIVQTwwDBeBDxH6n8BgYuAIlbVd+4HGSAOsetlTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280311; c=relaxed/simple;
	bh=QUYwVVkdhEoHgG7BrDWT+nE6QS3QMWKhNxOgpKncNjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXSEAtQbN6wVFW4i86hzeLMBdE1abIGC3XPV9B/7sLg2GIiDlML8pyfzEbFAsAM0YL/dQDxxR+SMfJISy8JKrySJ6xz2jlBOYFZoi01AXienRG1jrTS9Nc3j2Il+IDraZJN6WMxD8+6S3TCn0al3wUOvMk7KWzII5H4sATjgLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbyYukb6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbyYukb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DCE1F000E9;
	Fri, 12 Jun 2026 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280309;
	bh=tR0Cx3C0zN+0GRZV2yNNDzwsqggbnUj7KfM77CzIl2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BbyYukb6FnC/uEAg0XOzyMjPODkyRC/Hz6Yi9DQGWxBBZKzgB8IDKmneE29ojuecY
	 rGMzDYufwOOS3Ju8NfupYSDpj7Rjs9drlxam0RFwdxKjiJDEbUPil1Fpyb/PT3OjGX
	 67RghkL8pjTOrbRqgjNJ4EFypMEE+ImXuPI6/PsDZdXwwQTK7V6H4fc7P4jXIC8khc
	 STODo1d0EQUBezaoeMjHWR/np0pgt/6Ej+ZsRcfWgso+gc02ZWhSVd5H8xJwr7jtDu
	 wtc0/fIuxx65O3OCjKIDWBJy6eov1+hqq+6LY3zvsGmmbGWeTMhQNAAnHJI9m6LmV4
	 w8JmZkOotq2uA==
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
Subject: [PATCH v4 02/16] i3c: renesas: Restore STDBR and EXTBR registers on resume
Date: Fri, 12 Jun 2026 19:04:44 +0300
Message-ID: <20260612160458.3102106-3-claudiu.beznea@kernel.org>
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

The Renesas RZ/G3S supports a power saving state where power to the most
SoC componentes (including I3C) is lost.

The STDBR and EXTBR are configured in initialization phase though the
struct i3c_master_controller_ops::bus_init. Set them on resume function
as well to keep the same state of the controller after a suspend with
power loss and a similar initialization sequence as in bus_init.

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

 drivers/i3c/master/renesas-i3c.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index bc1a0ae1d12d..e70db3a17bc7 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -260,6 +260,7 @@ struct renesas_i3c {
 	u32 dyn_addr;
 	u32 i2c_STDBR;
 	u32 i3c_STDBR;
+	u32 extbr;
 	unsigned long rate;
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
@@ -607,10 +608,9 @@ static int renesas_i3c_bus_init(struct i3c_master_controller *m)
 	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
 
 	/* Extended Bit Rate setting */
-	renesas_writel(i3c->regs, EXTBR, EXTBR_EBRLO(od_low_ticks) |
-					   EXTBR_EBRHO(od_high_ticks) |
-					   EXTBR_EBRLP(pp_low_ticks) |
-					   EXTBR_EBRHP(pp_high_ticks));
+	i3c->extbr = EXTBR_EBRLO(od_low_ticks) | EXTBR_EBRHO(od_high_ticks) |
+		     EXTBR_EBRLP(pp_low_ticks) | EXTBR_EBRHP(pp_high_ticks);
+	renesas_writel(i3c->regs, EXTBR, i3c->extbr);
 
 	renesas_writel(i3c->regs, REFCKCTL, REFCKCTL_IREFCKS(cks));
 	i3c->refclk_div = cks;
@@ -1470,6 +1470,8 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 		goto err_tresetn;
 
 	/* Re-store I3C registers value. */
+	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
+	renesas_writel(i3c->regs, EXTBR, i3c->extbr);
 	renesas_writel(i3c->regs, REFCKCTL,
 		       REFCKCTL_IREFCKS(i3c->refclk_div));
 	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYADV |
-- 
2.43.0

