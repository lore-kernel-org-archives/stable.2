Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998263E63A6;
	Tue,  2 Jun 2026 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406943; cv=none; b=aBcyuM4n9NmqDbCsOvwVlICeb9rBHo9XKShoewRvg2h316njVrN7l1GpOkuBLGrhdc1J1S7sJr55tmCpyKtgrrcfOkAhzXcY6VaYaJHoLo8XjVofi9aRIUJEKrM8QJY5m+yMPoa6D7y88dATNRfSzlEaDn2atm7R8Bq4DLqkl8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406943; c=relaxed/simple;
	bh=YPbIXm+JSBimFwt0xBV5hfH5fdtSlFueddvGrzKCAd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOkVcok/hyKCmT8ttnjRtIzBxSr7TicpkbFLp2OH42l+MH9PUbWCu0nZeaMtVJYEhv1F/8O1ZTYHL6QLV6zA3nZgecKztyKgoFzYoP75bmTreAfvq6dgTVHcvMhLk26ko2T+8yPsJ062T5YXjVd2nBHiUkRBLiSxtlgL6mvJGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSO0Uo1f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSO0Uo1f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D117C1F00893;
	Tue,  2 Jun 2026 13:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406942;
	bh=oYMOrxgRJMWSL8TQv7hQo8EwvU2bnk7SM1kv7Y62O6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MSO0Uo1f004DvILS7nrFuA1dvjTlttKNR0UToOdSXhXOSmB+Jl99Tvn4lapxBXglM
	 BfUklN3KwDgq3FmBnr3GjPRzSx72L+eyiNfMW3sreUIJiN8lp+bun9e1DuD5yn8ZiV
	 LYXzJySaEOhHOQdoVcL8NjT4Au9ssXA/xfNUXrzF1m2bFm60QLtCRXVXBKsbxZMCzg
	 sDxB7L99LjpfEaXGq/TychYjP+OAUcPYJIy1Ob/OTBmWKmRV1/aBtnAK/M70r+MEup
	 6S3R/U2xiXM4bthVfM3k4NgAxwIo8ZnJGPrGv2jGqSk3k4w8LUYi5ZGNpnVLYCNj3B
	 18ORIoRy9WzWg==
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
Subject: [PATCH v2 08/17] i3c: renesas: Clean DATBAS register on detach
Date: Tue,  2 Jun 2026 16:28:15 +0300
Message-ID: <20260602132824.3541151-9-claudiu.beznea@kernel.org>
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

The controller uses DATBAS registers on TX/RX logic. Clean the DATBAS
register for the detached I3C device to avoid issues.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/i3c/master/renesas-i3c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index de09f0cadb72..7167ca12a328 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -964,6 +964,8 @@ static void renesas_i3c_detach_i3c_dev(struct i3c_dev_desc *dev)
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c = to_renesas_i3c(m);
 
+	renesas_writel(i3c->regs, DATBAS(data->index), 0);
+
 	i3c_dev_set_master_data(dev, NULL);
 	i3c->addrs[data->index].addr = 0;
 	i3c->free_pos |= BIT(data->index);
-- 
2.43.0

