Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF4525A88
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865224; cv=none; b=iQjDALYvjaRjWPlClSLdzIi7j6EbIEvgrTxdvofKi5pQoRjVHPykRpltnG8wKQLhOFkgsbhHYYtoP85S/TVntvMnlWL48+cfTAXqlsp4hCOvnKBl64bQFpZzu+vQ6qenh/CzJ/MfdxGzz+YoFVxqnmRAHozbeh2IxjR7G7WWV8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865224; c=relaxed/simple;
	bh=Suqd5ftmj9Y6jk+Ge3M0i5T+AGs4crNAREB6UPMJwV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apcnjkkrTkIQhkuJgUvP/KNW4m2sSV8z6JnxFgTZLthgcPPAt3cAVdYf+F6VxfNQpCgvTT6shVdEVpLoACm7HM0jwaMsETYjYXbPU2iotCyviOkGjd9CVwUzRsA3GhOcrojRrtdRYj2r+bMtPW2w1+hMXkS0ufIGUYvEdfzOCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adhKI/Vg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adhKI/Vg"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398e9698a70so3901853a91.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 04:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788865221; x=1789470021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5MIH5m8h4rgx1wf2ZdrB4T0rpezySvGnbGk7lhC4ZfU=;
        b=adhKI/VgY6IjyoKbGkVJRKJQQDOd3MHXFaskqhHxdUfVypJUWGy7Apq0tDqZA/KYrq
         BeETlPNboekbkvDse2AEMHNHe5HKWtXqt+Tr5CXebNFqNyPv/Krd569PnzFJ+ZurFb6l
         vuXC1GK5VVaZS4KZERM5VzX98pl8Nk5Wiq+nRNsapCFrVhw6MvwsjUZlf5++xM5isz+i
         4Wf+48Zve81n6ysG7E68TWvjHtpjQHN+2WkABUH6wV6PvWwJ0fopfqrMfZH5XQIPwRxh
         kmuqXZ6IIlCQcjwuGEdGVpAZmpULdiVot8o1Q/mTZbsee80kHSSsADOEqEnDxIDO2E1f
         gaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788865221; x=1789470021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5MIH5m8h4rgx1wf2ZdrB4T0rpezySvGnbGk7lhC4ZfU=;
        b=MhegK4PrqJ5QoKC4eQceC0A0xJuYXCRP1jVma4BLSO4PUpZxyVKyHvXdsui3wfd0D4
         HeE+xgpLCrbzthlG5WnfjLj2uU74zYHa+rmUz1wY7JwS1ZOj8mxvdCeATRE2vziQu/Tr
         q0y/E4UFZi0Wt5T2NHcZBvHUduu83y+JE7zJ43eJAY6emPyVozAx1qcUlZ1z5VOilUL8
         OR/xjuy2oWiajGWefBgnCCri+pzPbKIDcn3zgg1vU4kyr0Q2uhfV8RhdO3rwm+OLXrBC
         2ZnHy8yDO7PnT3X+R85Fi6qNngRduJvKq0g4qA3oUCF6EzSNd2WJBw/NfxJKgkk+e0qg
         kAtw==
X-Forwarded-Encrypted: i=1; AKwUvBywDcbcx95fdkx4uZEh8REz17bxuQhZMUatJAaxbStfybzWiA/GBXPQKmSxtYH5dGADyjGkPxY=@vger.kernel.org
X-Gm-Message-State: AFuF++mHtuNRXKCNHvjkdnh14jbNQvFNGlyIezOmdTFmDZXJonTrZa7B
	ZUhKVydGt0mihA4lcEbEGPvRiXacq/f0fhqBoqz20lI90So8JvAzgqM=
X-Gm-Gg: AYBFou2VucGy+tEiuEZg18E8UzfOtDOFGuCi+6W5QY024w4svPiYdcOb4OX9Lurs7/V
	yp6QP6tBvuwb6NtfwjrKEPLfVARorOW6c8/31SEWwdAf13h35Ohf0fRa2xO6yEsOSLWYj82Ubn/
	/GqDA+2R5OeY4UAq5oBctkN4z1TRV7Q0e5yJPzT/nHUGxIaBRHh47pPcAfr6hpIidDsw6/T42E/
	ObXX5Qz3p0bUvKIdz67nCXvBsS/eWFYwZi00wX6a4gNklBgJYqsl1uBV9pD2F+hXUfgSd2ON6jA
	MpimsM9fnXsjgy2oXQJdicFY/SxLeQNd9RTpRHVnLi97eMoXOw1YxHYnsNNsbWf3REtvdcROUAf
	8iXQbS9tcnk4sdRww3Lon7eF468XrWIlhnPWgS7WJZFFUAmsEeFD1drgc6G2MMg7H+SvIxYBHMZ
	qFRQAfAPfHWHO+GmtgXMELvr99rivveEJRq6LVIzb8sSuuJOjuOBGS5YfUkC/ZAsbpMLv5Xyfwh
	zLPNG3j0Ru5AAD5
X-Received: by 2002:a17:90b:3d92:b0:398:bf7e:b267 with SMTP id 98e67ed59e1d1-39b2614df9dmr43960484a91.2.1788865218856;
        Tue, 08 Sep 2026 04:00:18 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:f6ea:9d29:b387:9ed5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacbb0sm32429842a91.13.2026.09.08.04.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:00:17 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux@armlinux.org.uk,
	daniel@makrotopia.org,
	o.rempel@pengutronix.de,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/3] net: phy: dp83td510: handle the active-high LED polarity mode
Date: Tue,  8 Sep 2026 19:59:58 +0900
Message-ID: <20260908105959.70453-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
References: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dp83td510_led_polarity_set() only recognizes PHY_LED_ACTIVE_LOW, so
PHY_LED_ACTIVE_HIGH falls through to the default case and returns -EINVAL.
of_phy_led() propagates the error, of_phy_leds() drops the LEDs registered
so far and passes it on, and phy_probe() returns it. A device tree marking
a DP83TD510 LED as 'active-high', which leds/common.yaml allows and
ethernet-phy.yaml references for led@N nodes, thus leaves the mdio device
unbound, so phy_attach_direct() falls back to the genphy driver, which
cannot drive this 10BASE-T1L single-mode PHY, so the interface has no
usable link.

The callback initializes polarity to DP83TD510E_LED_POLARITY(index), which
is the active-high setting, so the request is already satisfied and only
the case label is missing.

Cc: stable@vger.kernel.org
Fixes: 5b281fe7e396 ("net: phy: dp83td510: introduce LED framework support")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 drivers/net/phy/dp83td510.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
index d75dae6071ad..9e9a41bf6457 100644
--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -439,6 +439,9 @@ static int dp83td510_led_polarity_set(struct phy_device *phydev, int index,
 		case PHY_LED_ACTIVE_LOW:
 			polarity = 0;
 			break;
+		case PHY_LED_ACTIVE_HIGH:
+			polarity = DP83TD510E_LED_POLARITY(index);
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.53.0

