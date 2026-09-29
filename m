Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0841B8EB;
	Tue, 29 Sep 2026 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716052; cv=pass; b=UNhrDmcA9MHTwg27h7G3tCHakCREojYXDCCxi9Z3yYStI0EQvoKIUOODell5mSeBWot+HP3UzX0AgOeabbzFRRD460640EkQxXX64rLrN8qmZkgDnPreHPOLOqvhU9TB1YU8cbUHeQVk5FgeUWyaXTRxL2g2z2cGQ5y4OK/zSew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716052; c=relaxed/simple;
	bh=82vnsJPzIOPJG4mqgPhwtcpVd6DgPG277k+sraDnl+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6y7m5mq7nqJ7hHE7PqqdPlMdbx0vzielRghfKdyRO/Mhwf1dGXdwoL++Mbvv8JaG1jY1diT94i5l0IoxQR/CvJQWJAe+Kk9/m4d9aX9rcBQTLSw0O6ISSSm/nQmiqv5kx6EZyRsVpFmOCrMADwr6ipm53NXcaG2fCLUhTEC7cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=VmBLyh7f; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="VmBLyh7f"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DDBCE201CF9;
	Tue, 29 Sep 2026 23:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiwX3o7x1yPYcflQ1RIttaef4sy8FZ96/OYMTcCjjzI=;
	b=VmBLyh7fl/uinc8u+AZ8qTteP4k6YQYIJ7o0+keLDbbCtCPBGP4qYFRpJw8rLrTnmzDFq8
	QGvKqrewDAfmE6s99wT8M7kwbdfYxzJFQ0FLZdvyYJ+v29vd5j2+MBqTd41MZSreT5wX3i
	45oP1IRUTp4bopyOgFgEJ2ptvM0wLIFfO2sJxISdktj8ZNoyIlmCmvjwgiKmIG+OeDWYTB
	r3caB8eO/RysZOT2Hypf/q0nstJ+Qo3mxLZ0F8k0tOEBqrJX15wrpfCtRCd2mNNyNScZIt
	4xJa/MXRHG1ALuW7hw7HsClhDLlfulBTtZrYO1+F4mnxY9TIUOHjjcuA0rqrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiwX3o7x1yPYcflQ1RIttaef4sy8FZ96/OYMTcCjjzI=;
	b=S0zs+NoXLBvSmU/IRPEcm7reGOj8kuNJe8PLYAYDCygVL1otup1MnIf7XuJmQdvTBLo2Ff
	FUOpk70QcSJBpIz5sMEJZXD+BEGL3a9H5dxufMbwZlA/HEhQ5+9jFeGccUZnKuyZAVo28D
	cOwM44UUc4NLfm267UKsLv2R93lxwuJ1JV3OHx4vn8II030qPitiYbr0CpZPJiQ6ELN1Bb
	mDN13fQcArhITYJuTqtqRFGu2W2xeGVUmhmPERZ6C6HoY5w2UD+O5g4uiIp4vTFaJSI6UI
	eQzvmLxmz8sj2W2pji5xdmKEfw0ANoNPuvCRDm897ErdVtmkvzBT6rZpVfjPJg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716023; a=rsa-sha256;
	cv=none;
	b=JO6LnVWvgUBxkE4MkP8m6MJX6wk2SgpJAeMjKceycEgKNc3R6hVPYHGCjhHH9T3QexLUGL
	+dRjKXuhEmLpdmax1L1/iSQcRZMKqUuS3lZ90af96ZeJ4Seqv0KYD2hzeTJL7xPlPXtYsP
	VU3OPeHeCQ5/FKbbAZXonFfXE6j2phNKZuBJVg8znVu5jXtrFqKBk0lf5NftEQTq8N/uBg
	EJelUybpz8cnqozE6ArJHmrlm7b6LW3OQYkDOP6UJDBlaCxtyBD/vEmEodezyQkt0l+3rl
	7S2NNJPzzyD7qb6+8QjlU9Zk7IPBKQzT/VTN5LcZmmSUkmkO4CnVavwv2JVh5w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2V-003S3t-2N;
	Tue, 29 Sep 2026 23:07:03 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7877A5B4CDA;
	Tue, 29 Sep 2026 21:07:03 +0000 (UTC)
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
Subject: [PATCH net 10/16] usb: f81604: fix struct f81604_int_data size mismatch
Date: Tue, 29 Sep 2026 22:44:00 +0200
Message-ID: <20260929210700.1183036-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929210700.1183036-1-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
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

