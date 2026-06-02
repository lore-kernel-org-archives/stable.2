Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3BB3E5A21;
	Tue,  2 Jun 2026 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406931; cv=none; b=d1/J5zEK/KpooGRsnC9HOYSpE2GgUne/P4aviGjlTYFOskW4gGGnaWTzaKC5bx30Y4Q264L9fVeopC6pbGdl+c4ZFu6HdT6kdtOnJrDJ0kqvWZWfaw6omVI21H7Vd0w7nzcnA84UU0z8N4povRl80DriNfCS6IqbTfOs4EQozxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406931; c=relaxed/simple;
	bh=/D9myWzOYhiJGEiwkgYqt1RXn9mtu4prLjo/v6yL5EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tj+Rtd3RUF3sMcVoWESsz2T/Pk8qp5BDGmpSfWzwZV9ZvJFJplee1xfAAa1e+1+OOyPN9A2YwJTmPJJ0/iNgVtSwslSAvdBx24egiGnIQSWpywI5jBoOtkW5pqfyambeinvtvUFTiQGJ+qniw0wtGiZDPsPCUwywTReHOrakRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXvVOurL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXvVOurL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0731F00893;
	Tue,  2 Jun 2026 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406930;
	bh=Qspis+L1JNnAbvAkosgr7KtefAU+xomaTqjuuxz6cHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YXvVOurLIVFgjm79RDECMKuvCjFBgY75NtILZzbDKD0Io5/oDfLID3eWGgOEU4hK1
	 GcKYI1dHMRdOvN5R8b/x+s6TSm1LpfNRIn4Y0h9on78kTHDy4gU5EjvRYZjHYEWefh
	 jPADOZ6qzfIvnobCL+nVmJ3eW6GTbR8Nu9ZlRii5pddhUrzKmbuIg3yYhLc7vBRvW/
	 UbhiYhydeaFbxfF4V4RYILBK+n1Y3Rv4ndJn9wAzDvrsPtddVSsYAq/hYPI2MNrGZj
	 NT/pMu9/rvd1D7B/OPQFTGjRQ3rpy23qV7oG7mNJYqO5ujO2F9C1ft5E29ltMlyCv5
	 60tTZvY33VkgA==
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 04/17] i3c: renesas: Reconfigure the DATBAS register on re-attach
Date: Tue,  2 Jun 2026 16:28:11 +0300
Message-ID: <20260602132824.3541151-5-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
References: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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

