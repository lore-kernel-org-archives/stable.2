Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A13EAC8D;
	Fri, 24 Jul 2026 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883889; cv=none; b=JVkUeT/hr1y+k/Vu7sU0tVqOmxYSeWOzjspbIJl3/gPvIYiiH7eD3HgJaM6p3d1yMayz9eO7765aOfC/CbJUwhpa5P4P/lsTRxG8Ww75MpNvSiruluQjJoDmqYTPgjE7KYC+0xhR/5oYgQ3Kly8mIU1Pb4lO9AIwtWV33a+1Mis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883889; c=relaxed/simple;
	bh=jnrZmWTFeMxFTUwStiBfwvMQ8RkfQc/nNrHZyeKGKeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOqTR1sR3c3C35IIgX2uOTQgExRXr10gFdsUzOiGhULvvhcIs4RGtN+ezMTKFa5QutZcuCA8+W0D+S+jVV9ihhkpcDtwDgm8YAFFXqGZzflWRmUk3s7L0DHnJAd/e3CPTrROOaYVud1g5Kk1XD5/veauJ9ipLh4Y7NJZ0oy2lSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SmQdg2+P; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SmQdg2+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784883844;
	bh=hmRF4Eq5A6tckPpf8JZ4Rd+UeZxcZzoQLn9CAt6h6jw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SmQdg2+Pb2usdZ+r3140GvI+Sy0CtSwG3t7qewIR3TwtxVF+aKquvnJo1fxnKCq2w
	 V+wDoIzkDP1Qnzz2X2X1xlHfepv2uCAAjox+B+inXXSJHoi7WhpzC4/3a2HIv/i+XG
	 oq7OVU6zgEk2DTVjrqe51LUpusk7+gRwK8cz3PnY=
X-QQ-mid: zesmtpgz4t1784883824t58784818
X-QQ-Originating-IP: 0ZLd6iLlcwCMXtIzKSUDmafX3fUFpYo/W0NNqky4P7Q=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 17:03:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6979303866208148507
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: samkay014@gmail.com
Cc: sre@kernel.org,
	imx@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: pf1550: enable charging when battery profile exists
Date: Fri, 24 Jul 2026 17:03:41 +0800
Message-ID: <D5A5255CD2B683AC+20260724090341.297438-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MHVOuy5eETPyWBgdUDgEreV6/zlBevCEAv7fAAw06Gvf2hyLGYaf0WZG
	2SqkwbHYQjsVRBj2rAbeSe9rk3KJFFVqkGi5GQpS0TmUcAXzdAAtaWjTC6HIcSIlSRq5Fcv
	C8RLdaqTTF4C4meu9oBT7i+eEXe0FYeF/ygrwuaU+JI91Oq1AP8A8CX97Wlg15Lc67T5cqa
	O8j+rhSgDCtHOcch6kjfIZbhfeU2SxWCkm7+m4mwnVY38hxSZj1Hlva/9Wy5M/ASywiaxTu
	6y0K6aVNvA1pujYvwxe09FwA240QFRC60/y7ic34tvG3ahT4/EtsHFvTDcJC2pKluVQKHi1
	2hEllD1N7N72t2B3g7SEqurGpfQAWH9EPlrxP9hDsjS8Mch3Yk7XfJVawrICStiTlMfD0ML
	OJ9dw3+qINgHO530N8KKaHcoWwwgAxyBoHDMLOu8AsMqKKUKx/0jzDhEDeMKthF8IMmaL9j
	gbyqGqNVLh4prAMGYPnBkK7YYy3kMHyK24hMF4oyqwy1PGOi+pGQk4IXnsNF/sVt4AirNYJ
	8LvVGjz4O1sSQJNNcF/D/Ny8Irwlw14xTMqmo3b+Du2Vlu6Sg0lhOLWggTBUohw8k6eSHdp
	LQf7CUpsw26jzTl8fi/oJXI9ee1LAOKFj34g+PFMzo0+x7IRoeX5sozQ6HJkIVpeRofFZ1W
	ilNJ/BvbmHHmZvTsOXqtnANOQZLVha2erNRNtm6kTAmVuhtKuir3v+2l7m0EsrrIavGP+kK
	qTzcBzv5Kchsyo3hEjCE0vILZ8hDuBVaBYRYOMC6VEM+0qWi3MCgggW91NAlgmih8zOtyPG
	Icf555lceuRkfda5HnLVO8fmgnUT/gZjyMbYb7bRkkF2etRJ08A2XSqUW9j8Yrtf9ggpPBx
	Ciit4fPP94aXkTuq2Z6AcyukWniIdSEwfnnKFSqUmYTbBz2vG6z3r52isSYEGXvS6k9Xa8P
	YBm8Q2hqscYH04SWJf/YoAKajMalNODWOPsdKxNkZDq00sR9lR812MExBHRDcwek6sHYyrX
	yKxfTFjHIjq7V03mI6N4Mn4QG7fFnk1gB2IaVlGOLItL9LkDKCcIN7xcBU42eW5tW4NX5Ig
	2OOjA22PojDq/fanSk1HeeVGJ5YDqrBZS9L/Qv/5dP070fVggSSF4c=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

PF1550 starts in charger mode 1, where charging is disabled. The driver
comment says that mode 2 should be selected for applications using a
battery, but the condition is inverted: PF1550_CHG_BAT_ON is written only
when power_supply_get_battery_info() fails.

Consequently, a board with a valid monitored-battery profile is left in
the default charger-off mode, while a board without battery information
enables charging with the fallback voltage.

Select mode 2 when battery information is available. Also release the
battery-info objects after use.

Fixes: 4b6b6433a97d ("power: supply: pf1550: add battery charger support")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/power/supply/pf1550-charger.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
index 41036f4cb64a..f698becd662a 100644
--- a/drivers/power/supply/pf1550-charger.c
+++ b/drivers/power/supply/pf1550-charger.c
@@ -514,7 +514,10 @@ static int pf1550_reg_init(struct pf1550_charger *chg)
 	 * a battery. The other supported mode is mode 2, the charger is turned
 	 * on to charge a battery when present.
 	 */
-	if (power_supply_get_battery_info(chg->charger, &info)) {
+	ret = power_supply_get_battery_info(chg->charger, &info);
+	if (!ret) {
+		power_supply_put_battery_info(chg->charger, info);
+
 		ret = regmap_write(chg->pf1550->regmap,
 				   PF1550_CHARG_REG_CHG_OPER,
 				   PF1550_CHG_BAT_ON);
@@ -540,10 +543,12 @@ static void pf1550_dt_parse_dev_info(struct pf1550_charger *chg)
 				     &chg->thermal_regulation_temp))
 		chg->thermal_regulation_temp = PF1550_DEFAULT_THERMAL_TEMP;

-	if (power_supply_get_battery_info(chg->charger, &info))
+	if (power_supply_get_battery_info(chg->charger, &info)) {
 		chg->constant_volt = PF1550_DEFAULT_CONSTANT_VOLT;
-	else
+	} else {
 		chg->constant_volt = info->constant_charge_voltage_max_uv;
+		power_supply_put_battery_info(chg->charger, info);
+	}
 }

 static int pf1550_charger_probe(struct platform_device *pdev)
--
2.50.1

