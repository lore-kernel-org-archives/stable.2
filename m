Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F703F7872;
	Wed, 26 Aug 2026 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746254; cv=none; b=S6gPVBa94pu3XT5/nWpCJ7tJRZeVRujX9pdxhcxE8u4qvb7isLdKGKqHvHIAlCHuY+ZfvpVxFHcrfovqqoisaqXpFfm1rDlY4hXG33CfUe50kkEqz2ScAfHBNU71JGVdaBiXfHcNuWeK13aamMAdY2A27FJ5xe/qTot/irgpr7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746254; c=relaxed/simple;
	bh=82vnsJPzIOPJG4mqgPhwtcpVd6DgPG277k+sraDnl+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJVFfAc6bcmL2DrlZ78afkCztNgyEp+OaV0i43uz8wW3gmFBOBj/qWp3oMIS6wQP/SGEZJOeyKudA4aO0jnEKiAMc0Hq09culRp3xWXOT6/CdI/V8yec94IN5BcuCrkK9IhVxjIKnOwR6qd3DziFu05cqAX1j4uPJjE/VWzZXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5BF7C20240F;
	Wed, 26 Aug 2026 14:10:39 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzCSl-003R9W-0t;
	Wed, 26 Aug 2026 14:10:39 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 074EB58CD04;
	Wed, 26 Aug 2026 12:10:39 +0000 (UTC)
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
Subject: [PATCH net 13/14] can: usb: f81604: fix struct f81604_int_data size mismatch
Date: Wed, 26 Aug 2026 14:02:23 +0200
Message-ID: <20260826121036.2706424-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826121036.2706424-1-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
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

