Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D81376A0C;
	Fri, 24 Jul 2026 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886943; cv=none; b=maE1Klm8gpS0oVcA4oh0g+nSGFusl57MG8rHhRMrqxrmBRP/x33TO0p7MdlH6K4hrKMxqo5/HvPMAS7ucE/lHZ3SRIg8z5XxKngrHfdIO3Mxtyf7GcwOuP//GUylfTO0igX+wAMxADYGyKLp84Kckw/p7YzmhL5dTX00HP+p8LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886943; c=relaxed/simple;
	bh=ISf/fcfsxb/7A12ng8flieQ6Km2aMX2qcDbWR0OVq60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l76qs1CBbT617/YQAaehAmHLds1IWZyvHljXN1BVNJJxOl+Im/nRV5g0Algf5+DEe6tbKtqFPikM+SUkwst0VLwSwp+RckjTzgY/A5NeWvkOZJq6dTMd96eEZW1xB1htmM8IZS3GvA5n1Z135oH2PRji+tOoUmUs1sm5JCuOd8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JZI9T3Ft; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JZI9T3Ft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784886899;
	bh=ESAfwVqYnYTkT6H8Hu9AQ967kCY6HTSE9AsbwnGyibE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JZI9T3Ftsmw8xFFxWRaC32A0PjluMvnzqQRbcDiXfJy/V97BHVtCeEw9IKu/P+QGr
	 erXR5yZjrq90ds4GB/z77Kh4fS7+S/UY2A9HJW3ZDUL2sV7rUlWWXSVR/0RMh0DLtc
	 os+IdNCH3Sa2eF2uOe5oZiu9urYmL2gsrkyiHMSk=
X-QQ-mid: esmtpsz18t1784886880t90f81de7
X-QQ-Originating-IP: d2LkRACRXDf/JaT5K08zTTGPqYMCoLT1I65bSu3IuI8=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 17:54:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11193573203578943115
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: samkay014@gmail.com
Cc: sre@kernel.org,
	imx@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH v2] power: supply: pf1550: enable charging when battery profile exists
Date: Fri, 24 Jul 2026 17:54:37 +0800
Message-ID: <097F0559A936ACCB+20260724095437.368905-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M/f9iSOkHncYMgeJtDk19P9OR/hhcJUiJD+Tv7Iql6qY/o6W5EEUW5df
	RBDPVbNHjABplmhj4AyiQqxR/ePMhDnu7vid6GufiBbukFZveclLTMfql9FiuWH64ZwXCob
	UXOs6fVb5acQuW1sJ0W5vzAcc7EEw+shipaUO9sNaoJjra/3U7ucahZkZRcygigb/s7UZXt
	VYfFITumhVW3WXlHpQlWPnRdqaEEqWnVsXlJt1vzSyhy3yqRvZtiPaqPk5YfSZHWWRpinJ/
	eKWaY9EyKgj2WnQlQdhmxPunGkEQaziNz/zrnnGap2bZIWCgSiPan3nF5yiNspvbCe/oJLo
	raFl0MX2Rje9QfJ9N5XsVUydFPcDcSXjntKWB4HJI3t19e1rVY8tAUYFN44iYPxwfUILwKG
	e21c+PWYUSIvulC7heGNdxg9bMfDfBfQHhoQizwzihsld5VEhfb2HTUPnThjkKqRxA/HVI2
	jGj61uHyrsc2VhyED1/zGoajX2wdui2EgsZUsCaT+xzr5UlpTiUKReQ/HaH1s8f3woFoOL2
	Jg1d9U9PX4u+e+Mqbbg0PrqPLw98kUpf/JboxJqSEb1eF3w+n+usuCDylpTAPcanuVLqMzf
	0mt8gwj32LEjDDrCQk0aiw2XoZE8Qp/aPUAbFF9C7gBfixzGUE2e9ZdHGPePwEkMYveAsIe
	oWLO/7WCpq6pyMfoLH3oqd2N6aEhxQCyAzvae6MqUqzbz6jgT1VII02C2f8ZK+5octZUS3G
	CBNxMotsqJNKxJyUhEUpCVeb2fvNLs5p5h/EuLDLZwtsDmaERe/7Xh763MTpdr91DloZQFV
	2GspmvbNPKk02nusIp5rWRN/1V56AW1b1VQ2A+YO8Z1rvLARsTh1pO1y0lZUDVTES+g8PPM
	vlO+DAJRxd8Msbn40kYI2D6rUsQwAaVBGxmUkObYUJt8DzbsnsZEIlp0Au6its/VR2GYYP3
	YjBjE/2hXgGLqheIVRyukZJv4WDeVOgXhcUklLx29XYxcKsCReW2yeWDHy8vCd8lzyvCr2h
	/1IKbHlqphLnkQFjAaEMT9KTlLeJEDfoNYsh8JcWz+XOvHxy0+xx75Fdu6t51DWwmd7pWl6
	cJmPFPpb9730t87nezj9oNNTYWsxIXjjbz4rXAX2gXGZYGbg/uSmC+LFjzANCXOtFlos957
	HqNgz27jXxVV2RZV3DYomVUCBg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

PF1550 starts in charger mode 1, where charging is disabled. The driver
comment says that mode 2 should be selected for applications using a
battery, but the condition is inverted: PF1550_CHG_BAT_ON is written only
when power_supply_get_battery_info() fails.

Consequently, a board with a valid monitored-battery profile is left in
the default charger-off mode, while a board without battery information
enables charging with fallback settings.

Select mode 2 when battery information is available.

Fixes: 4b6b6433a97d ("power: supply: pf1550: add battery charger support")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v2:
- Drop power_supply_put_battery_info() calls because static battery
  profiles are not devm allocated.
- Leave the pre-existing handling of an unspecified constant charge
  voltage for a separate fix.

 drivers/power/supply/pf1550-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
index 41036f4cb64a..38cac156d2e6 100644
--- a/drivers/power/supply/pf1550-charger.c
+++ b/drivers/power/supply/pf1550-charger.c
@@ -514,7 +514,7 @@ static int pf1550_reg_init(struct pf1550_charger *chg)
 	 * a battery. The other supported mode is mode 2, the charger is turned
 	 * on to charge a battery when present.
 	 */
-	if (power_supply_get_battery_info(chg->charger, &info)) {
+	if (!power_supply_get_battery_info(chg->charger, &info)) {
 		ret = regmap_write(chg->pf1550->regmap,
 				   PF1550_CHARG_REG_CHG_OPER,
 				   PF1550_CHG_BAT_ON);
--
2.50.1
