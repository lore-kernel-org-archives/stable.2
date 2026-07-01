Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D417A18C02E
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782868709; cv=none; b=iwe1Zt8ZhSLZha3yBM8JmJqqORQIdZGTcDRkEI1hXQkIIqMOxnUaFGYieSvCP0PLrpdHkMXAIA8N8Ah8u9RK3plqBPQAg8yJS2cZa8I652FtEba4Kgz+PjUrUNuLi0pix572egEO+ab0LrjZWAlxebOrd7nzd1cfcalotUIkhYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782868709; c=relaxed/simple;
	bh=GoIit5ZgJzeUoYLJLQLtF2uIv4TnqktuvxGLsgKQkXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTnWOTkN8c7aXVDRO2fqwTp/6ngJjLj/WUOA4AgtTdGdMhx84vmAnziIKL1Dgnw9cEYjcunx3+koPaATwenvXAY6XdoghymjsP+jp2lDVGsIrMBf/609sVjzOhggq/FJhelaWyoh+3PvzqzOOHtYRsguEqKNNWW/se3DV/QtQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HaBE37u2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HaBE37u2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JU
	uIzGBuENJNFR6jnDgMY03QkRKxghPv/IrsQ6dbhz8=; b=HaBE37u2ovH1CHzVKd
	iaB484Tm/a3/MI53VVo5PzWvpbdg3WrnQXGpDEPHv7WUlM0wOSj2AmdQ8l4TOW58
	8N+648EcwaNjrY3kf4g8EcgPj81n/veGg5qpcs+N38DngyicC4FRZb9WS4bTlO3o
	VnESZo+xLWZsmxV4q3HYdt1C4=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBHr5HQakRqtXYGGQ--.1210S2;
	Wed, 01 Jul 2026 09:18:14 +0800 (CST)
From: "jianing.li" <m13940358460@163.com>
To: m13940358460@163.com
Cc: stable@vger.kernel.org
Subject: [PATCH] power: supply: max17040: handle missing status supplier
Date: Wed,  1 Jul 2026 09:18:04 +0800
Message-Id: <20260701011804.632-1-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHr5HQakRqtXYGGQ--.1210S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF48JFy8Gw45uw43XrWkWFg_yoW8Ww17pa
	90krn8Gw18ta4UC34DJa12k345Gw4jyrWUCrnrC39av3W3Xr4vkw1Utr1aqrykJryrZF4x
	KrZaka1fGr43Gr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRm-eOUUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC-BZ7tWpEatZlWgAA3J

MAX17040 does not report charger state itself, so the driver forwards
POWER_SUPPLY_PROP_STATUS to a supplier power supply. If no supplier is
registered, power_supply_get_property_from_supplier() returns -ENODEV and
leaves the output value untouched.

max17040_get_property() currently ignores that error and returns success,
so userspace can read an uninitialized status value from the battery power
supply. This happens on systems that use the fuel gauge without a charger
supplier relationship in firmware.

Return POWER_SUPPLY_STATUS_UNKNOWN when no supplier provides STATUS, and
propagate other supplier lookup errors.

Fixes: f4b782af61ae ("power: max17040: pass status property from supplier")
Cc: stable@vger.kernel.org # 6.7+
Signed-off-by: jianing.li <m13940358460@163.com>
---
 drivers/power/supply/max17040_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 60c38e822b52..bba6d91c9b9b 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -405,7 +405,11 @@ static int max17040_get_property(struct power_supply *psy,
 		val->intval = chip->low_soc_alert;
 		break;
 	case POWER_SUPPLY_PROP_STATUS:
-		power_supply_get_property_from_supplier(psy, psp, val);
+		ret = power_supply_get_property_from_supplier(psy, psp, val);
+		if (ret == -ENODEV)
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		else if (ret)
+			return ret;
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
 		if (!chip->channel_temp)
-- 
2.39.0

