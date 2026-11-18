Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022750;
	b=eTbhOw1ZrjhOSmTohITBE6S7ESa4TQbIDJYfQJhShBfUXYe/uq4U9JYyFqO05B0EBKLO
	 ubdQ6uadJ3v1lmjpqqRfpI7igL+xe6SjtwmHS+B379adX+rIegT2jXuIiLCyMXwGEHLaz
	 cdDeXK7fWX2CGwvC0DmnwCTuSgxtvs3yR3EWDNk1YP8uBtyIuIvm9RgQZrHHK5d3UOvE2
	 P9WXucUtSKkTtjXMDNO0tSpDCz7crJflaSJv9jnTM9D7KBvMhUALYTSl9XJ8crBVrffuM
	 NXRbUh5Qcm1YqfTn60947l22JKcEKMMpq/29r4nXF1rtospnowizSpCu6WI8+kFujeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022750;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=x6Yn9nVVvzkj4kuG4KNyqMnRlTqVsBOrIHwYwoZ4SuE=;
	b=aV8d4EMGqGftu7fE1Xuf1xDl/MGGHT9NwcDrlJuZ+uzAT37BydE10eR7amVh1c0FhbuI
	 jQi4RUScBXKr7yTuRZCVCJm0w8NPAhC8jzNhLFSsxChsu2B1rZEgNr2Blolf5EwbOM37F
	 jsfAYUUsVpgV9e3o4gooXDF+jW+x1mcMoqIYUK3ndNJYSjNm8IfxOrj7ONpa0Z3u7pn10
	 cANiTWitwD5KF2ChOasPWZlhzqv+Xjnm7y1uiP+3/ioY0OTMhY4iXvjIf7QFGMckNdlUT
	 xKyRRV304J/p0hnxpdp9oYfk4HZSJYw1UTsm2s6A21ry4TTF2nWV6pquUY4mHiEHrMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="C0Tfdy/m";
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=D7BO09rM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C760A6F54;
	Wed, 18 Nov 2026 17:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B00C760A6F54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=C0Tfdy/m;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=D7BO09rM
ARC-Seal: i=1; a=rsa-sha256; t=1795022739; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IAOHYYcDQKvg5gxJbZh/KWQCyEO2iomMVSyP42UCOHIWSrtPc8wEIvwFrmv1LjDgg4
    Xa1BJeoEcVKQf+yNQWcHmLn9QkNKzEVQ7mjisPo3wyKNZ5RXYiwch2kLVnlMnTvqqjB+
    dLWVz27rn0SJsNP28BpVlaAiAx8u7cOB0abuA6Fn5+M9XeNiuZKeNkLUXMAU2dFsNjEe
    gAQfoOfTXiMyB+fEwXeU2IQcoeeU3GBaG/+ji2aCxXLbwajc6qNwcAUZb3tG3aBUdrix
    4q63sGnU4oiC+4CQp1H/VY1l1eUupA6qZrg8wteLqHHB0+15CrlDyrYoeK9UM0+fkUUt
    hhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795022739;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=x6Yn9nVVvzkj4kuG4KNyqMnRlTqVsBOrIHwYwoZ4SuE=;
    b=klJpgx66coVO7xRkx4H5TTCPqoyQn6IusRowEkKAb8hWP2qaBvM6FH670szfoOPE5D
    1c9jCU5UtF6u7oYHs3BxCBsgHtNG951gjsK9fccM1sfXYOt+okH0SMTfjlYSkvzqhAmM
    PIOQwINizUKGXJirlynJiPeAE9uQ89s89hid7UmJlyEWkyP/3Rg+E8Drl6hEBgX7/oUg
    l9dZg5Z8+d+8v9uPSI0tcORCwX3fPnXoF9kcmEeZuZ5oYvaxwPLmpgv5McRfbZWCpzRB
    5XW/IEs4zMqm+OM544RQCEWUNluzZXb6vgnAAXtMyQR1YtXwvZqxEc/uacl+wSe9t5iz
    KjYA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795022739;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=x6Yn9nVVvzkj4kuG4KNyqMnRlTqVsBOrIHwYwoZ4SuE=;
    b=C0Tfdy/mbEh9v1ZgTxbT+k+qTbUKUuBZWGHgQQHtPUymUzqqOQ5WsKNnRLcNmWE7ku
    9pMVzDCQft9obcsl/GngPzLA38HyZ8khwDyT4eymJXMRl8GTwA+I2gjmh1pNS8JjhoVx
    LddVtPLkxPJ5LVyptF1b57JBrdP78fLxENuv8LPea1oCc4jCejLbQITFPhCMIRkhevKg
    su2hSNvXGNnt+icIeKxJMLS6pXhVLOha6tgR9ohp0QlZM/+IzK1h+XeB+9dFld2KrFZw
    je/aFc6ekphUjsGOyXB3wLI+CVkLosZoUxJeLkHvctSnmihgTlc+oSdbbYvxOFqyRulD
    Gxng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795022739;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=x6Yn9nVVvzkj4kuG4KNyqMnRlTqVsBOrIHwYwoZ4SuE=;
    b=D7BO09rMy6ryk90mjZBuoab9fDhn4kLNw50Xv67z4kCNuK9itXv7fwherWXgEYLtF/
    2bQ5LHfhLwAPwID0RkBA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV2Jpcm8iNZLZ2IBizV+3wFb55dglUeZzcEX9J"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AIHPddiU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 18 Nov 2026 18:25:39 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	letux-kernel@openphoenux.org,
	stable@vger.kernel.org,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v4 1/7] pinctrl: ingenic: Swap ID_X1600 and ID_X1830
Date: Wed, 18 Nov 2026 18:25:31 +0100
Message-ID: <0fe84b1a87a384d810764c1043624e10a9214b8d.1795022736.git.hns@goldelico.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795022736.git.hns@goldelico.com>
References: <cover.1795022736.git.hns@goldelico.com>
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
Content-Type: text/plain; charset="us-ascii"

From: Paul Cercueil <paul@crapouillou.net>

The X1830 predates the X1600 and uses an older GPIO register layout.

Swap their IDs to reflect the hardware evolution. This allows
is_soc_or_above() to distinguish newer X1600-based GPIO features
like X2000 (and X2600) from the X1830 register layout.

Add an is_soc() helper for features specific to a single SoC
generation and adjust the existing pin configuration checks
accordingly.

Fixes: 4da56f9c6f14 ("pinctrl: ingenic: add x1600 support")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes V4:
    - Add Fixes and stable Cc trailers.

 drivers/pinctrl/pinctrl-ingenic.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 37310d9679457..88c5edeaaddcc 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -110,8 +110,8 @@ enum jz_version {
 	ID_JZ4780,
 	ID_X1000,
 	ID_X1500,
-	ID_X1600,
 	ID_X1830,
+	ID_X1600,
 	ID_X2000,
 	ID_X2100,
 };
@@ -166,6 +166,12 @@ static const unsigned long enabled_socs =
 	IS_ENABLED(CONFIG_MACH_X2000) << ID_X2000 |
 	IS_ENABLED(CONFIG_MACH_X2100) << ID_X2100;
 
+static bool
+is_soc(const struct ingenic_pinctrl *jzpc, enum jz_version version)
+{
+	return (enabled_socs & BIT(version)) && jzpc->info->version == version;
+}
+
 static bool
 is_soc_or_above(const struct ingenic_pinctrl *jzpc, enum jz_version version)
 {
@@ -4090,7 +4096,7 @@ static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
 				!ingenic_get_pin_config(jzpc, pin, X2000_GPIO_PEPU) &&
 				(jzpc->info->pull_downs[offt] & BIT(idx));
 
-	} else if (is_soc_or_above(jzpc, ID_X1830)) {
+	} else if (is_soc(jzpc, ID_X1830)) {
 		unsigned int half = PINS_PER_GPIO_CHIP / 2;
 		unsigned int idxh = (pin % half) * 2;
 
@@ -4142,7 +4148,7 @@ static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 		if (is_soc_or_above(jzpc, ID_X2000))
 			reg = X2000_GPIO_SMT;
-		else if (is_soc_or_above(jzpc, ID_X1830))
+		else if (is_soc(jzpc, ID_X1830))
 			reg = X1830_GPIO_SMT;
 		else
 			return -EINVAL;
@@ -4153,7 +4159,7 @@ static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_SLEW_RATE:
 		if (is_soc_or_above(jzpc, ID_X2000))
 			reg = X2000_GPIO_SR;
-		else if (is_soc_or_above(jzpc, ID_X1830))
+		else if (is_soc(jzpc, ID_X1830))
 			reg = X1830_GPIO_SR;
 		else
 			return -EINVAL;
@@ -4190,7 +4196,7 @@ static void ingenic_set_bias(struct ingenic_pinctrl *jzpc,
 			ingenic_config_pin(jzpc, pin, X2000_GPIO_PEPD, false);
 		}
 
-	} else if (is_soc_or_above(jzpc, ID_X1830)) {
+	} else if (is_soc(jzpc, ID_X1830)) {
 		unsigned int idx = pin % PINS_PER_GPIO_CHIP;
 		unsigned int half = PINS_PER_GPIO_CHIP / 2;
 		unsigned int idxh = (pin % half) * 2;
@@ -4298,7 +4304,7 @@ static int ingenic_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
-			if (!is_soc_or_above(jzpc, ID_X1830))
+			if (!is_soc(jzpc, ID_X1830) && !is_soc_or_above(jzpc, ID_X2000))
 				return -EINVAL;
 
 			ingenic_set_schmitt_trigger(jzpc, pin, arg);
@@ -4314,7 +4320,7 @@ static int ingenic_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		case PIN_CONFIG_SLEW_RATE:
-			if (!is_soc_or_above(jzpc, ID_X1830))
+			if (!is_soc(jzpc, ID_X1830) && !is_soc_or_above(jzpc, ID_X2000))
 				return -EINVAL;
 
 			ingenic_set_slew_rate(jzpc, pin, arg);
-- 
2.56.0

