Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8C3AA4F6;
	Fri, 12 Jun 2026 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280317; cv=none; b=chNB9gAfsfRFg/V5cRIIsU5r/xeXJ+0ZciOzWxo/BMCzCUvKBIR2MAzU4vPqnt4ILL1hs8TwQYHaSDDPM7HBlJRijx5y5DJZDaZBWXNfW/1tCx14uXMc5NKd6CeSb6/6+VdoCWGx3NmzG2A5DeS4TQzADog7yArPaPZlSYmGWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280317; c=relaxed/simple;
	bh=rs+QyhclyPy5woNWbAt9HxEJEQQLvHcRyYJA0oi2GM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBtQZLFnouJg3Eh4VC8vF19v6arPM3EYti6cN9KkpnY1n1gJFlmbEN9l+HQOycL0iE0ZM7Wn3K14t+bnGXF/hROl4YbLejaj+N4UJSAbjLNLoQAhaLo5b24Cr5uO2vXPY7C71IIuncS9TiGkAb/XGHytF5pp5dnTjl6CN/LTxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NV7ARvWS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NV7ARvWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1FA1F000E9;
	Fri, 12 Jun 2026 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280315;
	bh=3PBZb7cGt6xcR9wbrJite7LTqkhXtfQAMt+/2SqMx8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NV7ARvWS/AAlXNnz6sUFeV8x2ljwnz5rdGC2QTrH2SM2fo4aRMgCKFB0nEqgi5BpR
	 KbhJM47Plph9jzKTsOfBzODQZ00Z+XvEL5kB4jkZfEKD27xXwMfXVxazXxKuArCg7c
	 tdxjAziEieb3w4mwhbTi8Hz+bGoSQhvHopIoZp2yF0WwBw05PK3q15siJZ0MvnQMQE
	 85zfuAzRV4ylgy/kmMuW5AO86jnGI6j91G4bb0p4jHi8oKLg2ICxZ/RmQpuZvY9LXR
	 GhZAXUYyySlXAy/o24cRum3689eaPadSmGxf7AjPB2XpDHUCzEZP/89THoBPfxUHd5
	 FlRIYajCIBwSQ==
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
Subject: [PATCH v4 04/16] i3c: renesas: Reconfigure the DATBAS register on re-attach
Date: Fri, 12 Jun 2026 19:04:46 +0300
Message-ID: <20260612160458.3102106-5-claudiu.beznea@kernel.org>
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

Changes in v4:
- use "data->index > pos" condition

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
index 7d448936b74c..4b81c32b1fde 100644
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
+	if (data->index > pos && pos >= 0) {
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

