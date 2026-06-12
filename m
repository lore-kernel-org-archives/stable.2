Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C7F395240;
	Fri, 12 Jun 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280326; cv=none; b=Ni4DYuIUXGbMcT9hWE1HRet7E+jQj/f1XieGG+CPQatbgnn43ys9YeLrpZMba9yOd4gbEch62YErmVwU5dTFuBGklYCqAqs8RoNJtQQFGJvfGEZy4m1EIuVHZEUmqqI6rfIkSvdJr6bRlsE4sExjlPuMytIv+y4YpBBV/zAHjdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280326; c=relaxed/simple;
	bh=C+JIHyPCN/QWKeNrRigaB8LKGffzfX4SpIHtMo4jSMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uv6eHaghj1uRyqzfwzGWBUDrXSFYEdjiKxuXAUgkLvYpxLXmbWaGf4ZH6+I6a1AOKmll7PG0++WnABXUTB/Bv2L1RPrfdlFB1usDZwNoqQ9qDyuIbWVscz2VK0VONyr9jx/NFFm148pIPgPST/n+a5Lllgc8LV+0E6tXZ69L8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRTcxi9Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRTcxi9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CD41F00A3A;
	Fri, 12 Jun 2026 16:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280324;
	bh=6CzvHKRqj39+/AvnEcb6S6lx4Dcw1R8+JnnIfeHoRPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VRTcxi9YUZQ4nHQIVe7kleJ0vzjRh6QhYFwLE0izBmP9MlRORiyzj6AZ+ly3kQ2No
	 iA5VS/+SFwmLN9PMRy714Pr4y/R2+z0X3ubo0SutnhEYL44LmWMEghvbP+SqSiBqbk
	 B547hPYBLL7EAgwg5Axwz92EFmitYmWSf91WNEbBYQE+HqwMxOOgbkvDtCMnN7ZnP8
	 yrb9twmdF9ANmf6Z9eIEoEoWMRfJU/4FK6+142XD9aZJ53pXaGpltU6NzuMOkwbTob
	 zX+CnBajJ2Z60IzGFRlgGAS9878KlnWUO/3DxVe7ay3IofehcxxS8pZEFUXFNIvKhw
	 Mfn7tuNErwzzg==
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
Subject: [PATCH v4 07/16] i3c: renesas: Clean DATBAS register on detach
Date: Fri, 12 Jun 2026 19:04:49 +0300
Message-ID: <20260612160458.3102106-8-claudiu.beznea@kernel.org>
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

The controller uses DATBAS registers on TX/RX logic. Clean the DATBAS
register for the detached I3C device to avoid issues.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
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

 drivers/i3c/master/renesas-i3c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index a63edddbc9fe..abe24e563d21 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -1042,6 +1042,8 @@ static void renesas_i3c_detach_i3c_dev(struct i3c_dev_desc *dev)
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c = to_renesas_i3c(m);
 
+	renesas_writel(i3c->regs, DATBAS(data->index), 0);
+
 	i3c_dev_set_master_data(dev, NULL);
 	i3c->addrs[data->index].addr = 0;
 	i3c->addrs[data->index].i3c_dev = NULL;
-- 
2.43.0

