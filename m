Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EEE38C2D8;
	Mon,  8 Jun 2026 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949765; cv=none; b=XNee53P8bVUi2sc0MRBOD0YlrJZnXVGBbM+XYW2bUFKhEMBWiKtxAmm1YOiGLDz3uybqBgTXbbZzI6YI1xFNf9gZS5Hv4rkrPYB/ZhGzjDd0uLTHqL/Yet9viOGWDz6dyIz1OBTDj642se1sH3urO209AC7BLNLaOkd7LSIc5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949765; c=relaxed/simple;
	bh=ybBS33TQULf2cl/ktMtHZwTNoVPfCubN7wkXEHzc9gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjvMnPKhf80sDWOlhWuPgbYev1WQbFzGwh8LT//DrmW09hG0j7MxqWPaZYxo7wFWOnhUwA9VaVGz6eZFwraUC32RmKqQL3NWSkBCLM45yYT+V7aZqQ/s8m3+Z/RyeAI9MivYvZuHVdseJe2nqPDY1DzLlrPbFfMj5Yrin7G8CO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epm3BqGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epm3BqGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5311F00893;
	Mon,  8 Jun 2026 20:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949764;
	bh=683UmwIi1SQx+C8dZmNkBU6Aoy5p/F3p/7Oc7ikp9Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=epm3BqGFdiBcoVTRqOJFJHfdiCDIcuFsY35DwMZkb1mHfkzoEhPPvlu4J6iKNxK5f
	 MPzhf8HKU2xxL3kr/Rwp1DuuKSuwwIkuU8r7rAw+ut8UJcqwAYRgbPQ0CrI5YcdaYu
	 OVWRp9WNUbf0NHPiiK28PEPHmPQ8gCnTvJrAqS/js0y2Xo+LXXNgNB9HLfzoHUOxbj
	 FAi9xOrNmlPzZd++SuBuzQw30liJwo07IBaE8Kic0DisWmsKgc/24tj4USia03Wapj
	 Vu7mUIINEQut+bOyRTggX6tb909kK7B+GwucXKNL8UZFN2ph7/Lj9duxI56oD/XVF3
	 ncC4NMzVWYJxg==
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
Subject: [PATCH v3 04/17] i3c: renesas: Reconfigure the DATBAS register on re-attach
Date: Mon,  8 Jun 2026 23:15:30 +0300
Message-ID: <20260608201543.804902-5-claudiu.beznea@kernel.org>
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

During re-attach, the device may change its position in the i3c->addrs[]
array. As a result, it may use a different Device Address Table Basic
Register (DATBAS), which needs to be reconfigured.

Reconfigure the DATBAS register on re-attach. Along with it update
software caches.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags

Changes in v2:
- dropped the "if (pos < 0)" check in renesas_i3c_reattach_i3c_dev() to allow
  re-attaching in case of a full bus; along with it the condition to update
  the DATBAS register and software caches was updated to
  if (data->index != pos && pos >= 0)
- adjusted the patch title

 drivers/i3c/master/renesas-i3c.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 4c86e7257804..76a4831098c9 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -892,10 +892,26 @@ static int renesas_i3c_reattach_i3c_dev(struct i3c_dev_desc *dev,
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c = to_renesas_i3c(m);
 	struct renesas_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
+	int pos;
+
+	pos = renesas_i3c_get_free_pos(i3c);
+
+	if (data->index != pos && pos >= 0) {
+		renesas_writel(i3c->regs, DATBAS(data->index), 0);
+		i3c->addrs[data->index] = 0;
+		i3c->free_pos |= BIT(data->index);
+
+		data->index = pos;
+		i3c->free_pos &= ~BIT(data->index);
+	}
 
 	i3c->addrs[data->index] = dev->info.dyn_addr ? dev->info.dyn_addr :
 							dev->info.static_addr;
 
+	renesas_writel(i3c->regs, DATBAS(data->index),
+		       DATBAS_DVSTAD(dev->info.static_addr) |
+		       datbas_dvdyad_with_parity(i3c->addrs[data->index]));
+
 	return 0;
 }
 
-- 
2.43.0

