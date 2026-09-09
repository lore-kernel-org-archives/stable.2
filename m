Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9313533582
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953306; cv=none; b=HEWYy2mhlnnl869Ckk6Ps6ASGCkYVSaXUakhNBCyecm1r9j5f3nlPEIi8uYiU2P51JZpceRXPRCOAMcNws7dNbL8kxTf/A4pqPvVVhXs78tVMCvCQPym2LZli+8I7d+X8rtZiuoFiOtAMxH1nimdJtAZPzkMmZwqsOYFYZvye+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953306; c=relaxed/simple;
	bh=sZMHv0e49pJRdP60nRckR5SzKPHt04B+l9NjX1BrgTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUpZ4293WLAYdP8tQ8xiEU5fga0itR9OOTUw0E9uqUyRVqqXW5ivS2HTab/jgdwvZfKeJd5N4NXuqwCpfjQOuvz+f9ww1cZOlx1Ov3Tf8+yCos69knwTmg1gVQymdBrrzHjBdBMo+sZdumj6tMsA1DYiebClrjeHMXKW7bPspEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUf6sCM0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUf6sCM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6BF1F00A3A;
	Wed,  9 Sep 2026 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953304;
	bh=aoOFJpYnbMmYnCrVzk2adZZdZBwCN4Akhp3EY6TGDJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EUf6sCM0nxvtTOk7DxfjiC9qEqTCIiierCSOftliNUh+fF6CZDlHiox0ZX4ByQlQB
	 zD3KdG1DqmW+wNU9QHqGBYBOcpAE7c5TrIXr+cgagSIA6CjRdJ8QjFGBH+VQ9O/+Ds
	 exS/qkNaT089RER/hO6vswKEOSxp4j5IgdzlNopGo7rx3zUN1dVdYylHmgutYTOh1j
	 DYJManM86ru28/xyvBo/3nWFarjZxRLSEVyNynCsX4KblRd7O0i+yvNNxGgjeuH5dN
	 +Z9WiFPnM7xRK077s8oPQQVEkRBV6BUB0iRgnPvHS0jXl0Rk/3Rtrp1jNZIpCk4hbR
	 5WGHsq7bKjtIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ivan Abramov <i.abramov@mt-integration.ru>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] power: supply: max17040: Check iio_read_channel_processed() return code
Date: Wed,  9 Sep 2026 07:28:21 -0400
Message-ID: <20260909112822.1848327-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090314-oncoming-condition-a40f@gregkh>
References: <2026090314-oncoming-condition-a40f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Abramov <i.abramov@mt-integration.ru>

[ Upstream commit 2c68ac48c52ad146523f32b01d70009622bf81aa ]

Since iio_read_channel_processed() may fail, return its exit code on error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 814755c48f8b ("power: max17040: get thermal data from adc if available")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
Link: https://patch.msgid.link/20251008133648.559286-1-i.abramov@mt-integration.ru
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

[Stable dependency adaptation]
Linux 6.6 does not contain the optional IIO temperature support introduced
by 814755c48f8b, so omit the temperature-read error-checking hunk and the
unavailable status/temperature context.

Retain the local ret declaration: target 659cc3d8d5ef uses it to propagate
voltage and capacity read errors without adding a declaration of its own.
Use ret for the existing -EINVAL default case so this dependency builds
without an unused-variable warning before the target is applied. Keep the
successful return as zero; the target stores positive readings in ret.

This is a prerequisite-only adaptation with unchanged driver behavior and
no added functions.

Stable-dep-of: 659cc3d8d5ef ("power: supply: max17040: propagate register read errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max17040_battery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index ff42db6728991..28c66c1fe6e43 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -386,6 +386,7 @@ static int max17040_get_property(struct power_supply *psy,
 			    union power_supply_propval *val)
 {
 	struct max17040_chip *chip = power_supply_get_drvdata(psy);
+	int ret;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -401,7 +402,8 @@ static int max17040_get_property(struct power_supply *psy,
 		val->intval = chip->low_soc_alert;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		return ret;
 	}
 	return 0;
 }
-- 
2.53.0

