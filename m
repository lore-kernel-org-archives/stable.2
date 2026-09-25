Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C543CE77;
	Fri, 25 Sep 2026 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790320248; cv=pass; b=OP+n7yJRp0LTameZdsGmMhBfcApgEiAYXAWJDhKuLnh/DrbIoHUstcsJuY/iq3UK0euq1qskXIa5TgorKyJ7t8y0dG9YUHWVAPSUHqJyneHRINdgGkFPEcZUzJ4XxfikQlDsu6XGpjfZfTuX3iUvxEQ4nf/cf+EsRCdRAzy2Tl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790320248; c=relaxed/simple;
	bh=e9e/P9Q1l1aIvDXuqCCHIB0/JRGPPPUV+nMH8eVUboE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnvHi+ElZXeJrs/8LZ6Zu7qFfc7eD/opMKXhsp06jNUXKM/Jjhq5AYJ35kQTx9u80PtZkGMLVfe1DgKXaEjZyLTmWLVGzK2ZBmiLV0cB6feG+Q2JeTc6HOjzb+/c+ZKAK5owqJTBeENfxrXpRliPzy2TlJTFWzbV/qNeQX8swxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=c1FPdPQS; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="c1FPdPQS"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A9C82200291;
	Fri, 25 Sep 2026 09:10:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790320241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gmslxd0BabSwK5lq1LuZ+YcGvtX+1RwGLtRsWrJ9Zdk=;
	b=c1FPdPQSu4cFAYnzCMJZSUki+zeAw4iPwIOWrXx0er1/0BzG5kOHWGo8E4zgyL1/mTyWwh
	hMXsDdMH745zOp/Snh3o1+W14PqbEzYp3TH2UVevULw9vh0FwP2b1s1HjLVitohAXuMbBY
	SoYQ9YISmb2WDRSA4eyBVl3kyfrqANrVSDDFrewInz7uPva4lFszZ2o0jIwAWdnbMh/ffu
	KmrdB+Ni99h1GKUP8SE/qDm1w8leYWugHR31lZ5PAtJlpo1d9Kj8Blbo9XSlZ7u5p869dM
	cdKXtdmN1sbXrb+lTvLtI+eBiM4oQZkkh4txMO/A1weZAVjGhqN0jGzM46dzMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790320241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gmslxd0BabSwK5lq1LuZ+YcGvtX+1RwGLtRsWrJ9Zdk=;
	b=UYBx9G5765vRsLhrLbaD5qdVwC5T3QmDJvKpTyFYnABbjuH8NAHN6LQg0uG9CsJZc7/5WF
	uGNJKbfT8RqpqD517rQ1Z+UCHc7MwF3dulIHfiQnNDcUZuVejXWtRcn1BK08cBaizllvE2
	DvHttHDL4lBAIiEmCnRwEDehm3mBWMIDbKhj5Na9uKT8mHeavmkHHRPwp9hpeZC913rVZj
	oku1fMAWh6pSZ8ZXYcGEaGpC0jGtyQhQ1NoJ+uG0FKzaftKOva8ETl6imyZTHq61h1Zf1z
	40JM+dTctfICPqe4FbshVlXahI7S0PNN/K5XYdiUKldcx3UgZsUonVJYH2u3ZA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790320241; a=rsa-sha256;
	cv=none;
	b=g/Je5L5WgguF9wkS+zZ7BIZ+eSez1a7xX4VDa1tQ1536FPQP+YyiZhLPzgTpH8sgS5gYNH
	2qaNCik4sldjiEtaTxJ7L83VAL7kt399V02HZRTMFwMlK7Ce7N2Po9Issr+09AAd/xtp1P
	arfmGJMXGAp7pjeFoFZXfO2AXWYIyshN2/Z74zTMuKezauhXzH2yF6tcq78gcodh7frbQM
	luIdoG8zhng+1oJ1wAbZf8pGiWYd5ghPaEPwEsipO4TfOjHCEJxAnPTQv5aM5euB7ISElb
	7uL4mIPS6PnrtCWlYOZcnaHzDD/CFxfKCNdoF9U9q0ucCBVA4AtkiHSiL7rR5g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 98FDA38058C; Fri, 25 Sep 2026 09:10:41 +0200 (CEST)
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	nic_swsd@realtek.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Dennis Piecha <d.piecha@ymail.com>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net v1 1/1] r8169: disable EEE on RTL8168h/8111h
Date: Fri, 25 Sep 2026 09:10:40 +0200
Message-ID: <20260925071040.2137178-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Force EEE off on the RTL8168h/8111h (RTL_GIGA_MAC_VER_46) at PHY connect
with phy_disable_eee().

Commit 202fef9bbbf5 ("net: phy: realtek: fix EEE advertisement write on
the internal PHY MMD path") made EEE actually advertise on the generic
Realtek PHY; the write had been a no-op before. On the RTL8168h that
un-masks a latent defect: once EEE negotiates, RX silently stalls after
~7-20 minutes. The carrier stays up, no counter or dmesg moves, and only
"ip link set down/up" recovers it; disabling EEE keeps the link stable.

Root-causing the RTL8168h LPI/RX path needs hardware not available now, so
disable EEE for this version. Use phy_disable_eee() rather than dropping
the version from rtl_supports_eee(): the latter also skips
rtl_enable_tx_lpi(), whose disable branch clears the MAC TX-LPI bits (ERI
0x1b0[1:0]) on link up. rtl_hw_start_8168h_1() does not clear them (the
RTL8402/RTL8106e init does), so a warm reboot from an EEE-active state
could otherwise leave TX-LPI asserted while the PHY no longer negotiates
EEE. Keeping the version EEE-capable preserves that clear path. This also
covers the RTL8168M, which shares RTL_GIGA_MAC_VER_46.

Reported-by: Dennis Piecha <d.piecha@ymail.com>
Closes: https://lore.kernel.org/all/353419280.954808.1790290283530@mail.yahoo.com/
Fixes: 202fef9bbbf5 ("net: phy: realtek: fix EEE advertisement write on the internal PHY MMD path")
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ec4fc21fa21f..ee1bc9bd0447 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5484,6 +5484,12 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 		phy_disable_eee_mode(tp->phydev,
 				     ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
 
+	/* Keep EEE off but the version stays EEE-capable so that link-up
+	 * still clears the MAC TX-LPI bits.
+	 */
+	if (tp->mac_version == RTL_GIGA_MAC_VER_46)
+		phy_disable_eee(tp->phydev);
+
 	/* PHY will be woken up in rtl_open() */
 	phy_suspend(tp->phydev);
 
-- 
2.47.3

