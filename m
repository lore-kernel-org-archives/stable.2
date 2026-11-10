Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289848;
	b=nDgtslHMw1RaDeVDCOg478ldWRPTDLLWzhVUjH2G0iqPLeqxdMKdzwJPN6KvttApopxx
	 pBdvsiqkTlfQ7MKk0QJrwedNAp1O2ejJoUoXdukBNdj7Xym8VwzMWFHKQNEWH55X8w3fx
	 92nPzDcpvMjFei0GTaPWLP+XuTJPUvYb4xA9vOtwAvsssn8OsFttUmszD1k3Kqv9mCv/s
	 IlcU1ksEoLpDL/XlmYuDmdMYuDg6RVU7booqghx35sf1OdHu6ScEECQPg4Zft0ubfUrZo
	 Nwm2jUBS1lnL6UdZeiDfAFogUJBDCNNnrkU06aTALHSQLIxE86+4NqhFmUwKytOqQMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289848;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=GQhdVSS7zODy0kJ7ys7A6cBk+yn7TDp6NFcxMO+tZ0A=;
	b=G7za19XX4BJtSe6Z/AvRYqmeAF3aAl8spR7CJS0Z4jOIPsYdAV4+W9Bh3S9TX2DF+B3g
	 zBmSMf++JHfRB4//6svNwjN4pMNiKFJ4M/l59R+TBL3e9qM49lNwy8ruz110kRCCzltHy
	 YrV6qe+02xvgSdph/05cuhQATzxrQShEIDOkm3DowXqRPC9lpKUeViGL64vGM3UqXj1jG
	 I2MKVf9nEK0QrCrQW13GBS2FZIsIdfCxZ5JilZiD3xmM4ERLW39vhRGkVpwWEstF/+npN
	 JwN3fZ0MQ5nfreaoZVMtdpaMt87BcNJPwMIXEmjdCWoIWBcqS50RKiHwc4lG+nkuRFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b="Y9/pnu1a";
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C3606A31C;
	Tue, 10 Nov 2026 05:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 367C3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=Y9/pnu1a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794289828;
	bh=GQhdVSS7zODy0kJ7ys7A6cBk+yn7TDp6NFcxMO+tZ0A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Y9/pnu1auoAwgfZcn8yFKJWSWzddCq1JjBFGhufKd8fv9VYN4cyi3JErZEoepfxlm
	 yWH+yHcCtq7/1pApIJMNEG7A8QFywmS2bL09Qbwb0HO3M7P/BAWrQyxg6+es7Jj9wH
	 uK1SOCx5QeyNV2HjGR0E2kwa0dJI0h2oQkpv5xF8=
X-QQ-mid: esmtpgz13t1794289824ted8b4a7e
X-QQ-Originating-IP: OTEMxqyzXc7rWMgb1H/tkZN8A+JjhUSoicioysD1g+k=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 13:50:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11791463934339592707
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: sre@kernel.org
Cc: linusw@kernel.org,
	robh@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: gpio-charger: Keep properties per device
Date: Tue, 10 Nov 2026 13:50:21 +0800
Message-ID: <91858196CE770E42+20261110055021.263296-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NU4e3V92LJuQ4czWvYlTU8cSWUqMasLWaZNi01iuWh41TU7M/TS77+fe
	4TKqS6cXa3iVgQ/czjiWnFnRVu7tWWRux70UOfCsWmePbuf5sWbR9WuaXsC58h5faQkiM5+
	1lrRWWe9H4NWc0R6YcEBwI+u4KR8cATkpr4sTENB2usm7t1nDnmOUp6kk9W3H5HB2f4+vge
	ccJJP22GgcG90fZnPrsiAh/qz6EDiLPAJgyu0ut6M0lXZCbpyKx79FHZ/TKDQO/ywXrbo9y
	qA0R1Cwaiexo6WfSitbz9S5/MsurI0C00wrom3bFQlzBueG9xaxQiDmq7BmZlma9iIehs6N
	yk/aaVoQxjlGrKKVSiTx3pXR56HB0wgaQJyaDJFmrshm+6TeiC9N9q+FTN9spdVYET5NP0y
	qrV0fG3f5dvyb4/CAT9lN7AxT1YllO+e49WFO6a8N/PCZwIeZcXLoeTbGSzOGwZk9gW4Aoz
	8bsTDa9WqX0eaBmqOvDXC2mrHw64HUKP4PZDjeCIZcO2l/Ii9Cjd1qVY2384bOF5ltFZo5h
	z3HaEKAmsez4aYl4u6tH04tWeQsdvOKfe6tBYNBwg1AT41qq96Ga8saPv7asuCdzDoeEkUu
	/6pr/ffnseuA/kPtf3EgSCLfeNLtuy9b65pyvcYjfvsf2A66jYnFe0nJxL1x8oLwrk2ZEiM
	mLfZI4yw0d1zKJUwLdArQvT9x5oDHuMXAovrUuKCXQL5JNICRJn5eNNB5l1JbcBHT2adlXs
	vBKi++yEn1uoxfow4hffA17YuR9M1WhAPe6InVQzU4LZusxklmL7niOu14X/Rh1jB+TutnL
	6o+ByR5gvrnvFeAqHpHqn3fTu2sPWd81AXTdTYN/ozAcCD68+cLadrAXlhOgAX/tYjINN0F
	mAA6gx4YwnjEtRsKB660JRywBL4OD0lGio7hRU/SnVpBfmzCatj3P1gR6WHoLBP5c17wHRP
	LRNw8LVZdoNK3gWVqzspmqBoRUexYulT8eIniF78GZjP7CCHxGemYSTx5Z9kJYFv3X+LpaQ
	ZMuxci0EWnsHlQ9KS96BRB5wkTZxASfip6p4fzNgyQkKyRlfvZQ9eSLXCOpX8=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

gpio_charger_properties is a global array that is overwritten during
each device probe according to the optional GPIO features present on
that device. When more than one gpio-charger is registered, a later
probe can therefore change the property list referenced by an already
registered power supply.

Store the property array in struct gpio_charger so each power supply
keeps the property list built for its own device.

Fixes: 1d85f6d1b0c1 ("power: supply: gpio-charger: Make gpios optional")
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Cc: stable@vger.kernel.org
---
 drivers/power/supply/gpio-charger.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 1dad49acc424..99c1af99dd88 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -30,6 +30,7 @@ struct gpio_charger {

 	struct power_supply *charger;
 	struct power_supply_desc charger_desc;
+	enum power_supply_property properties[3];
 	struct gpio_desc *gpiod;
 	struct gpio_desc *charge_status;

@@ -262,17 +263,6 @@ static int init_charge_current_limit(struct device *dev,
 	return 0;
 }

-/*
- * The entries will be overwritten by driver's probe routine depending
- * on the available features. This list ensures, that the array is big
- * enough for all optional features.
- */
-static enum power_supply_property gpio_charger_properties[] = {
-	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
-};
-
 static int gpio_charger_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -307,7 +297,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	}

 	if (gpio_charger->gpiod) {
-		gpio_charger_properties[num_props] = POWER_SUPPLY_PROP_ONLINE;
+		gpio_charger->properties[num_props] = POWER_SUPPLY_PROP_ONLINE;
 		num_props++;
 	}

@@ -316,7 +306,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(charge_status);
 	if (charge_status) {
 		gpio_charger->charge_status = charge_status;
-		gpio_charger_properties[num_props] = POWER_SUPPLY_PROP_STATUS;
+		gpio_charger->properties[num_props] = POWER_SUPPLY_PROP_STATUS;
 		num_props++;
 	}

@@ -324,13 +314,13 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 	if (gpio_charger->current_limit_map) {
-		gpio_charger_properties[num_props] =
+		gpio_charger->properties[num_props] =
 			POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
 		num_props++;
 	}

 	charger_desc = &gpio_charger->charger_desc;
-	charger_desc->properties = gpio_charger_properties;
+	charger_desc->properties = gpio_charger->properties;
 	charger_desc->num_properties = num_props;
 	charger_desc->get_property = gpio_charger_get_property;
 	charger_desc->set_property = gpio_charger_set_property;
--
2.50.1

