Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14883524B18;
	Thu,  1 Oct 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867958; cv=pass; b=bPP2TDFg2ixZouFV48ECoSyXDKn5gDjljidCXM2ivjIicY8ONF1drhncbQTuB1MnCZRBRDHhl8BVVuJUZDD04V7NY3L9fOSzX49DAdGfZ/HiurFpsmOufg3zYcq7/aBSO1NEfwWo0PQXOwrrEkdQtvn/J32itjhOh3iDn9X3LGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867958; c=relaxed/simple;
	bh=82vnsJPzIOPJG4mqgPhwtcpVd6DgPG277k+sraDnl+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOg8S1gXggAN5zPOOQ2j8yLdGrKR2Tyoqfp5r4isJ8qH+Mv2wr7OciUsXwNC4h7wWDt50ID/cM+2bfzR301u1oIc+bxekPW5ITcpyTqivLLlUWqemnHpLvb0gdxs8fTL4e6Eheh+byRBZB/N+gbZEpFviFVaw7SMTKAZe9W1lQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=HDFM6MyG; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="HDFM6MyG"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C788C202342;
	Thu, 01 Oct 2026 17:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790867947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiwX3o7x1yPYcflQ1RIttaef4sy8FZ96/OYMTcCjjzI=;
	b=HDFM6MyGBOV/Fr17M7pZkecbr+PZUSXhLhBwGFhAFqDk1aIVTgeoOqY+Lua+Ykl4e9O3NO
	kfd4p/xeSDImtIXD69F+c2prccv50XZu08Y3fw2tPpZ+GIzCl0MoIzl5IREh7iulIRm77l
	oY7wecDjIWQ2p9h02+i6/xoY4Z39lrUCpfgG3YhfXdtcnLwcOVeKRK+hi7ORbRm/XVHsXC
	NdWmOFIQCYv4ipZOMTOnmAJdjSWJMtUqDd+BiMq7EvDvTWvu5wTr7DUO07FzqIhJweCmMp
	MNBFZ8O9ulmwxOyPCe8bHaODzmWVjtnBaNzIx/6X94Bdn/9QNOfmueFyEEWa4g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790867947; a=rsa-sha256;
	cv=none;
	b=UWGcj5zmzq2G/+n4LO8ZCu1Q4ExtyTA9pCxjRuAYkW9ic3+qLtjY5ckb507xbwfgv4ds6q
	kqX3VPdepNh79Ax4ycWaioNTyP5U4zXogDAgTrBH/W3r6RQKI9yfqeaaa+3X3GFFLGrGb+
	KNd8GbZwuviw7F4QpFD9YHk7x+JjZFz1sZcOdX/mEJ01xQpCRzFtkcHt0LGA8XJc23v7s4
	rM43P6I47Ba5onnk1blRJIrH4nerKbjYwApgnrB9h+9rtT5WQDdLDchT6bIpSwfxcuQa0P
	7PhR/AWpPTFKOMQh/vr6tzBJ5DCrd7SE2s+AOtrLpPArF3UBD8DQQrrw7+Et7g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790867947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiwX3o7x1yPYcflQ1RIttaef4sy8FZ96/OYMTcCjjzI=;
	b=X5UjrgP5hYBp4c4RvXO2s7WHSjUbclIEdoqpqZlqg/WOtGBVB40dxKMC5Wb2zdQ8yXy7f/
	cQCHTV7wGkNb8PhBGXM9FjlcjlgGO3PMCtrzuZYCV88Ud5TsEwr/WTUoXUgnLVFzOQdlF/
	ygf3yyfpQOvhSoLi9yEWJ6OjBZwueyxv/MDa3ES0iozkYHfqqkc/zKb3BnEunt55IaRSOH
	T6rPv5C9B27jwvD51KfpxAyVQE26IW7Enbp+7NyQmfYz2oYPMjrE9Ik2/SFRtzIaAzRHe1
	cEXtj99UECUdjXi5gfCHHQhlazdsqzleI3umJaTYrzNcyseUNj42C4D7m7eBFg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCIYt-003kSf-2A;
	Thu, 01 Oct 2026 17:19:07 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 587485B7983;
	Thu, 01 Oct 2026 15:19:07 +0000 (UTC)
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
Subject: [PATCH net 3/3] usb: f81604: fix struct f81604_int_data size mismatch
Date: Thu,  1 Oct 2026 17:14:25 +0200
Message-ID: <20261001151905.1556270-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001151905.1556270-1-mkl@pengutronix.de>
References: <20261001151905.1556270-1-mkl@pengutronix.de>
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

