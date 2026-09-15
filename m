Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CAB44AB73
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511514; cv=none; b=gcYgIYhYXdSU/o64Pg07Zlk1ygb5RC5QjPOByhDQf1g1bAOYWtgM7xFpdkMBxsa8awVN8yFI7GTT7XFMTF9RzmT3Jz0tjOgG3P2czJa3kIz4WaaN6cVzQTdmVZQKXkv9OOnTs743P9bcWjecn4F6sTIGXfgdI9Xivf9h991V56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511514; c=relaxed/simple;
	bh=vq9B+WHtR7YcxOfQ0HtBcAM9E5zRf5ErIV6WMfZLrhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6SP10+WLQqgLgv5DQvlfm76UtYMOKulaRAmXEpp7lBvBfkLzAUizULJ6kIgrFzvBefPU0VC8VX0K5qHwWEXrCczbPxFEPcL7V1IUhW1y6Cq1vs0sXs2xcsWILfCcQ2wcNvjdD2yoYNeM61ZqHKHO9ULI09jS3S17h13KFkuD90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VckqRcbO; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VckqRcbO"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso205106a91.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 15:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789511512; x=1790116312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dY8BjpTJUvWkhY18qZeTDa5Pr7EX9PKwjyY0lXAdA+0=;
        b=VckqRcbOZ76p9baLN0i/tU4UeInXNMe1NOx2/5EtnFdLjZZch14O16Kh85glM2DYA8
         k/V8jbc4YnzXJ1mLfs/154OlhgxF/aCdpGhTWjeWOnF5dk+qOc68n4Ye1t/G2JQ2Sgwn
         rwcyvfUdmeeKpppH9MSedwYs3fi3SrW/MMZ4MNQAnhfL3hwvyxNUnkvLHUPLQ/P9swel
         Ajj0Vg17vzBSJ1UgCwzwdLXhEvaFHiLgzKwSSwtyTt+54Wf4PQxSw3TWgJwgRu18zrGS
         rTGS9drf7empPlX6Sftmxz+KYMt72XmQWwSY36lJTDC/WchL0hqUPEEgymova6qIcHtU
         sZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789511512; x=1790116312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dY8BjpTJUvWkhY18qZeTDa5Pr7EX9PKwjyY0lXAdA+0=;
        b=hcizPEkWegVmz6pwTAk+j8dX5BoineH0M/mP+4LcygGUeaAYtXsVS2R9r2crN4d8v/
         H2vjhr5VUoWxA5nwNz9+o5ob1Jvdb1uAph0WuJC6V6jeW4BLEEpJMITtbAEZdFf7uz3x
         Jq+WxO3Y/bVhbD6YChksGvCV4HSfKXmDqImZWt1PBqVFrNw20JBcL5DK3iexqnfdSyDR
         Lah+TqNN4EPFJNGFsEUkiw5BSze9PsRl6xullEhbT9mevgEgAlnFF3ANGuIK/G4HEsQW
         /X+bmEk2zAYtrK39SF1xJqtvQJgdYR7V9fAfY8yV5sCoWu1Nzle5c0JKxKR2ABkaqXpD
         ovuA==
X-Forwarded-Encrypted: i=1; AKwUvBzUN0vX8GV8e2DIHBYwwEnEup1ZKRNO2/rRMIcePhXumUctMogsoNPhVYDRcnThOAxupJFBZIA=@vger.kernel.org
X-Gm-Message-State: AFuF++n/mVyrPta+6ve8B5iG5IB6uwJrYliFCCm/CV6oHaL1gbA613nw
	ye8z4/zyNwN2x8NF2Lzh0HmIkhUpIPcjmYKOMBTF++rMPQvi7h0PxZ0=
X-Gm-Gg: AYBFou3H1EEmMiWTFYJFtFVCsqkYDw0Sd5QoAnxEn88HejthflLsuVeZ9ifZR1CfMHj
	g2rXRoEfWsSXMEtXH+3UaycmxP7B5N9s4bKBdL2kKjEwcSld6HgEDAuGD/abkSotfdjh03+mJkV
	HZ0Dumvsy0fkm0rXfTWQ3go6SeojRiSk2vk+sd1l+EwkNF1LFK9ibibQSGWKJrWSEV7pewlsdsD
	imPKVSoYWJspC6ytXrDbG777l9oAi5tEUz8qid/j09qsDyUIyAaOpGj5MAv7y+7+gpXrgY3PCgE
	E5bQrZNN/ePoHzF5/mq9gKfd/8VO7pYfU1xkEGck105KJA0WGeh8UUDbc1LCco5QPrVw52wMqqw
	MFlbhQV0B1AdCUFZuMx4EUMnKzEQdv2tKXYv4NpbKLMckJfZJwynMWqynYMUy9h0LsJxqClmSSN
	3RBN046nmP3xwVAAYTX2jkI5pYNSrnw9tS32UG4ZMKO4n/Pe3QJ6VRn765a5iO+bK6E+eAuMRke
	5dRIGq/JxWDRVHObLGbWiJ1pg==
X-Received: by 2002:a17:90b:4987:b0:39d:f064:3a68 with SMTP id 98e67ed59e1d1-39e1e4d371bmr651073a91.21.1789511512282;
        Tue, 15 Sep 2026 15:31:52 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:556:537c:f7cd:8a1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1c337e97sm208036a91.2.2026.09.15.15.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 15:31:51 -0700 (PDT)
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
Subject: [PATCH net v3 1/2] net: phy: qca808x: accept the active-high LED polarity mode
Date: Wed, 16 Sep 2026 07:31:37 +0900
Message-ID: <20260915223138.321307-2-donggeunyoo.kernel@gmail.com>
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

commit a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
added PHY_LED_ACTIVE_HIGH, but qca808x_led_polarity_set() still rejects
everything except PHY_LED_ACTIVE_LOW. An LED node carrying 'active-high'
therefore falls into the default case and returns -EINVAL, which
phy_probe() propagates: the mdio device is left unbound and
phy_attach_direct() falls back to the genphy driver, so the PHY loses
every qca808x-specific feature, not just the LED.

Accept the mode. The register write below already handles both
polarities.

Cc: stable@vger.kernel.org
Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
Tested in QEMU against a synthetic MDIO bus answering as a QCA8081; see
the cover letter for the three-arm table.

 drivers/net/phy/qcom/qca808x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 8eb51b1a006c..3ba58f14e248 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -603,6 +603,9 @@ static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
 		case PHY_LED_ACTIVE_LOW:
 			active_low = true;
 			break;
+		case PHY_LED_ACTIVE_HIGH:
+			active_low = false;
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.53.0

