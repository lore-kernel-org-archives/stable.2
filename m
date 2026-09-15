Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C3A47F3DB
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511521; cv=none; b=fdbPCeR2BFoTgiuDzZZksegqD29laT+rZ6zmklo2bsDF3zDThEHL1GdsrGf21GT2hIpmOsSMvVSs+r9MW89pv5ae33UfSdIF8z1nEviNh6F6+44p+m0TSgdmOpYnp3apglJVcWdENY9AysmjHzbYOKxk3ArEy+j4spcGJV58ZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511521; c=relaxed/simple;
	bh=S2XZh3VaVySPUgw4QBLbbko84fncUIEkPW+FJJvR2HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6uWP9QDWLczD616v2HcYllM2GEqCZ1UIONFKxWGvFKmGFt79xsLTLYC3Dl/7GYj8u+PKm5kSFDjnCUzvKmnu2vo+mXs2cXqMk3clhwHtaEN82L0tunOLtvFgXCdIy3KtNfBqfSw7kUxI9TVUFhptOYV4LbIVWwRSG5ZQ3hFIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNkeHs8j; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNkeHs8j"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39b350c69b4so212716a91.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 15:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789511519; x=1790116319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zK0dUXrqiJhS7PWIeZXjl74BNkmdl+RVL7V4FpfahtM=;
        b=LNkeHs8jkAWzaqimW1OpBHWwQNsm+sLb77nTBTJGV5LR3jTczF2e0+CkQCZhlzUlbj
         iS7n+9Hw/z2HXrDHgVPOrJ6PppGzEE7iZU49fIDqiETzZMvGt+toBGcYbqythvErLwiQ
         V89wTt3b4I5AncYD+eZ/DaTqPxiADZTO91PNXLk7bkmg+WDhS9V15mjPEgrnIEWXEHgb
         wOc97lFR7JANpZSLumUNVVUxCet264RrsI9W5mUP1ynWcXiZNo0zrgA9919724XfToEG
         kIOQnNamI86owC9HRLibIW/OOkT3SrSnlgmyuSQ5/2l1C8guaytIteW1wa7C51WFZp8F
         sLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789511519; x=1790116319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zK0dUXrqiJhS7PWIeZXjl74BNkmdl+RVL7V4FpfahtM=;
        b=bxNEMZjgfC4Okf2Aar8DcufE1567n2DWYZnvsrq/AgN3V3h09Fo9m9qg99nWXlAmGd
         Ga2hjNYl8LPmj6wPb/KfSVxUgqUCgptLgWyjKmRfpkxxDh/M52DGpI219w2HceCSh9Po
         Pn3ZqHJLuExJLeDDt5Hjb8ZtTwQx6H1+/CNXRjFffgHJ+FvUp+0LSFUM76tzTs0tmAfw
         56UNVC2DtZnUSAjXUV6o8b+x5DVqioD0zN3deuqJNceEO9FJTJmev3nMFQZNGpX1O4rw
         VUO4jwoxyvfGyeq3o+oAqCvLKVQncLdFqW6J7kEbsZnWd4phabRZpfhW5UVmzddm8nn9
         wDAA==
X-Forwarded-Encrypted: i=1; AKwUvBwkMaQ2ZH9DIeQAI1ZWTsJqYiB9qxmv5ApchwL3RVonnDoOHzBKK29eBW0tI8C2uJ8fULgjS1c=@vger.kernel.org
X-Gm-Message-State: AFuF++nSCyDWyUuV8NlxpeyUV1/wpVeMAKBx5LevqAQE2irtGhbk0Yy+
	RGJM2xmqvMQAyVuwgew3Xz4rwzNiWhyNlKXSVqCiimXdpnqwdsHo838=
X-Gm-Gg: AYBFou37CbN8QHpa/RTxBtubq7Ybp7Xz/OPqRphx0LKLzFoB32ucGl0rQ0O2TqH+1qA
	qFnm645LeKgq3qOHiQgNlzcq4qY9eTzZ3oGvtDcSh+GsgrukMbmj0L1dtW98bx6O2zLg5KGtj1Z
	Z7N57ObIrWZPNpJnDdXfF32RvZ7XdKXW+6bOjoADsiT/0L5EEW7NAHb0tECHahmj0LLkSjAVA1h
	j/HexcUyPMZl5BI+HTinUEpWmg+cmMU9c6aJCqpVTKDD0jXAa1rBPYT7pzVy/Yp4XtJftuVnF0V
	9W8yOA/FggGkFt3E9BAy1S6YOF/0dlcsxPHzoQz3NDMOFucgOvj4clZ53jfZ+tpvumn4ecl+96G
	vJX+qp3Im2Nlm9dhEsJI57zEjlg7ZPg5RxfGESOLJvD/QKFTKYGh0jXfV33gYh9TRdahB6zsGUH
	8wt7sI0ApSjyCGGgX/TW54bcHEbsctJZcX61Nbl8hYiL0LIHw8db2aDttKBivm1Y+UgZmXwACkd
	9cS5ZC6Uok3u0vZrifD8GUmxg==
X-Received: by 2002:a17:90a:d650:b0:39d:f7dd:4e4f with SMTP id 98e67ed59e1d1-39e1e300ab8mr779291a91.10.1789511518725;
        Tue, 15 Sep 2026 15:31:58 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:556:537c:f7cd:8a1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1c337e97sm208036a91.2.2026.09.15.15.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 15:31:58 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Rosen Penev <rosenp@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH net v3 2/2] net: phy: qca808x: keep an explicit active-high LED across the reset
Date: Wed, 16 Sep 2026 07:31:38 +0900
Message-ID: <20260915223138.321307-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915223138.321307-1-donggeunyoo.kernel@gmail.com>
References: <20260915223138.321307-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the previous patch an 'active-high' LED node is accepted, so
led_polarity_mode can now hold 0. qca808x_config_init() only re-asserts
QCA808X_LED_ACTIVE_HIGH when the mode is -1, the value that means device
tree asked for nothing, so an explicit active-high does not reach the
register.

That matters because the bit does not survive a reset. phy_init_hw() runs
.soft_reset before .config_init on every attach and resume, and
commit f203c8c77c76 ("net: phy: qcom: qca808x: default to LED active High if not set")
records why: "on PHY reset, the Active High bit is not set resulting in
the LED driven as active-low". The polarity written from device tree
during phy_probe() is therefore gone by the time the link comes up, and
the LED runs inverted.

Re-assert the bit for anything other than an explicit active-low, which
is the one case that wants it clear and gets that from the reset for
free. Name the unset value while here: led_polarity_mode otherwise
holds a PHY_LED_ACTIVE_* value, so spelling the comparison
PHY_LED_ACTIVE_LOW says what it means where -1, 0 and 1 did not.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908105959.70453-1-donggeunyoo.kernel%40gmail.com
Cc: stable@vger.kernel.org
Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
Tested in QEMU against a synthetic MDIO bus answering as a QCA8081, with
the reset clearing BIT(6). With only 1/2 applied an 'active-high' node
comes up inverted; see the cover letter.

 drivers/net/phy/qcom/qca808x.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 3ba58f14e248..bab26e4c6140 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -87,6 +87,9 @@
 
 #define QCA8081_PHY_ID				0x004dd101
 
+/* led_polarity_mode otherwise holds a PHY_LED_ACTIVE_* value */
+#define QCA808X_PHY_LED_UNSET			-1
+
 MODULE_DESCRIPTION("Qualcomm Atheros QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -187,8 +190,7 @@ static int qca808x_probe(struct phy_device *phydev)
 	if (!priv)
 		return -ENOMEM;
 
-	/* Init LED polarity mode to -1 */
-	priv->led_polarity_mode = -1;
+	priv->led_polarity_mode = QCA808X_PHY_LED_UNSET;
 
 	phydev->priv = priv;
 
@@ -200,8 +202,8 @@ static int qca808x_config_init(struct phy_device *phydev)
 	struct qca808x_priv *priv = phydev->priv;
 	int ret;
 
-	/* Default to LED Active High if active-low not in DT */
-	if (priv->led_polarity_mode == -1) {
+	/* Set LED Active High unless active-low was requested in DT */
+	if (priv->led_polarity_mode != PHY_LED_ACTIVE_LOW) {
 		ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN,
 				       QCA808X_MMD7_LED_POLARITY_CTRL,
 				       QCA808X_LED_ACTIVE_HIGH);
@@ -615,7 +617,7 @@ static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
 	 * To detect this, check if last requested polarity mode
 	 * match the new one.
 	 */
-	if (priv->led_polarity_mode >= 0 &&
+	if (priv->led_polarity_mode != QCA808X_PHY_LED_UNSET &&
 	    priv->led_polarity_mode != active_low) {
 		phydev_err(phydev, "PHY polarity is global. Mismatched polarity on different LED\n");
 		return -EINVAL;
-- 
2.53.0

