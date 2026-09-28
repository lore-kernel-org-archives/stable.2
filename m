Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B4502D53;
	Mon, 28 Sep 2026 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624013; cv=pass; b=t3KsChOjswpLRWitEqs6DaXdZ343uhvp/sogu8CknVMSX4I86/0+ajx0VpXBZ7HsdkmoxgVKGKPUkicT1+9RFPe0m5ChtkFJCPKzoMUEms54OAM9bqRtzPaXskSjWgSXBe1RA6dSqUsWCXZjQ+5/yv2itRB0ZaodhTHR7bbhVUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624013; c=relaxed/simple;
	bh=82vnsJPzIOPJG4mqgPhwtcpVd6DgPG277k+sraDnl+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0ddUBV2YF6CPl+Z+fhVPNXMMvbLq1o48pJEuKugz7xN3vGmhNO8Mh2uiCZcfAzBl3uACXSaaGKbyueKiuruqtPfuP/TZDpgh8jmPSgXo3gQa3Iy4y7mw6PXWVq4hf+bv6kEZ0INWJM7pBZhWBTbF8GEsJ5uRmKcb+cwzEXQirA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=KPXhm5C3; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="KPXhm5C3"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C00012022DB;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiwX3o7x1yPYcflQ1RIttaef4sy8FZ96/OYMTcCjjzI=;
	b=KPXhm5C3disguxxxh1VNDHTGCVnE0I3o+nZ8dBbbhwvcDE8/s8Ahb9cBm/4kHiP+8z80xy
	puhohktPByhMgieUz3sR++Dbz2xOG+61SoC5nrdJTrDN+2HPpakkPgro52QHkrs8kcyNsx
	rp1JU0xCMOkfcxGI1cyYRrqRG5bW6kbixIxrE/U114GaYoBcIdSO5HGZi+EALCZ4Js6ahy
	81DL+2CLqeU4lGT1MEnrD/RelxuA4AxW++ugSdFgcv0lx3mccN+UYyd9CgBEP4ApoHp54d
	1du89DBOBpemsAEuWLdQTJ3VH8YRqPFA71CgcaNYLg4xpTXVL3og7/tPjw5zcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiwX3o7x1yPYcflQ1RIttaef4sy8FZ96/OYMTcCjjzI=;
	b=glAJMSQzJ1HD3p7CSGaikzeFk8grwbM3fOSW4lsjL6A6aVA9+p2WivRKlHiFcopPYpibjY
	m3d7yaiCDd1Hj86Gt25p++iiIx9QVkepXhZcse0PjwtBijfY+4NT99coS6YfrKxX7hm2wd
	Vopsyzb4z0Dyi2io34W8yDULDnJLYdxy2F026DgekNm9Vgkze/2d1IyS3PopdSixNnkHJQ
	peyWZvnUSpnm017CPF23zZD0+9bzyLZjMds2UNWhWf/M6yn09Vf4r5tDEc0wYUPphcPdbI
	326Ki+h5pQqchBHZ4ymUvOJa+ha+Q0Zo/NTUMytHK/R4UmiYD7wsLNTGoJ6u4A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=FOprakYlsSQqmHTFRFdjW9ImKyz4KmlOl47aLjfwNgn+0KAamhXwRUAap478F0+g4OFSX4
	QMQA7QY6tYZBbtwWgbpFgOF4XGhXG7XwGclahh4JjqUVQnKV7w4yz5kg7T0tizKp96NHqi
	zHDSZrkklxpHUB3StLsdVbwBBlF4+JNLsbu7zFT13VvABYKjgrIp2hKRyiUzXM0/yeVT3l
	32E4bxARm5mSqb3jYk/AO0M/eh16BOB/mxtKw8+vgRc5mvQqi29tABot8HS8dF+eFhXwZC
	F1KWFH80KRCb3Gj7Aw/6yNyRgW9bjZTgjjeMccDQnYNsSbrJvrKgJUKbc4E9ZQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6C-003H6a-1n;
	Mon, 28 Sep 2026 21:33:16 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 46B915B1559;
	Mon, 28 Sep 2026 19:33:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	stable@vger.kernel.org,
	"Dynetrex, Admin" <admin@dynetrex.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Drew Willey <dwilley@google.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 18/22] usb: f81604: fix struct f81604_int_data size mismatch
Date: Mon, 28 Sep 2026 20:45:25 +0200
Message-ID: <20260928193312.553632-19-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>

The struct f81604_int_data defines 9 bytes of interrupt data:
- Byte 0: Status register (sr)
- Byte 1: Interrupt register (isrc)
- Byte 2: Interrupt enable register (ier)
- Byte 3: Arbitration lost capture (alc)
- Byte 4: Error code capture (ecc)
- Byte 5: Error warning limit register (ewlr)
- Byte 6: RX error counter (rxerr)
- Byte 7: TX error counter (txerr)
- Byte 8: Reserved (val)

The hardware sends exactly 9 bytes for the interrupt endpoint.
However, the struct was defined with __aligned(4) attribute which
caused the compiler to pad the struct to 12 bytes.

This causes a problem in f81604_read_int_callback() where the short
URB check compares urb->actual_length against sizeof(*data). When
sizeof(struct f81604_int_data) is 12 but the hardware only sends 9
bytes, the check fails and valid interrupt messages are discarded.

This results in the driver only being able to transmit once because
the TX complete interrupt is never processed.

Fix this by removing the __aligned(4) attribute so the struct size
matches the actual hardware data size of 9 bytes.

Fixes: 7299b1b39a25 ("can: usb: f81604: handle short interrupt urb messages properly")
Cc: stable@vger.kernel.org
Reported-by: Dynetrex, Admin <admin@dynetrex.com>
Closes: https://lore.kernel.org/all/A3834A07-5639-4779-844F-C5843DFC3928@dynetrex.com/
Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Drew Willey <dwilley@google.com>
Link: https://patch.msgid.link/20260824-f81604-fix-v2-1-fc9be5581394@fintek.com.tw
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/f81604.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index f12318268e46..4c147b9d6d69 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -169,7 +169,7 @@ struct f81604_int_data {
 	u8 rxerr;
 	u8 txerr;
 	u8 val;
-} __packed __aligned(4);
+} __packed;
 
 struct f81604_sff {
 	__be16 id;
-- 
2.53.0

