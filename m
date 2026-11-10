Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336020;
	b=U15GhuBsQLsjAzgkQ0h4Vx6vAUEupr54ufX7lAQr4mdkd0Dv+Y4rsTiFB+yOepWyipxE
	 0Hla/XH/Npfz1fvS8wiydDmyaZrrt5d/Sk4I45CCyTykhv0DGfzt8JBkzIn6npWH2Ht7q
	 UPPCgCoapgNsHO4nKWU0SQjbm0ql6PQ6CUPLM9y7qEMk1xVX5ui08RDRV7Th9mOp189ZK
	 oMy0/1TPhjHasaE35ux6cAoq3ch652OXpgoWiYPL9Ue6P9+KcQXSChHXXODWJ1ykuvSUm
	 /5RyjD3N2yI446cXtT4+6UHJPrWAxfS+DDzyrsrUuEZp8RUmtdRJbuHkgMjlU3OUL8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336020;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NX8Bgqj1cYflPJDUmwjJtPnSzWDqNwLdB/3DJANbDY0=;
	b=Dq9ibZ5y9Nbt52+dRTNvHTafq7pewdgU5QumCaozOsL2KrghdzHwEkz2fOT+xxVZdpxA
	 LpainLcWG2Nqj2xqDJHBaFm0ToUMi2KBS/d6oL++XyLeauScgJu4tZLcLfFxZlUMELCWo
	 wKqJXECqK2gZzw28LYOAQSRFi0sCOQjWCkJue57Yr8DxmokFIwtTkCZLpD1hb5dnulEnp
	 lvW7zq72UpEUqWmjxp3ZgyTQ6V91yjbYebcSvtLL97D8XeO4E3IgLkNxpy4GY4z5XrKaR
	 nc5dwB6Q56ItIdOns9xokOLG04NDu3Y7LO0CKqCPGPwkL6fkVn/IMKxF1qdRoFbvrTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNEHW8Dh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9960A260C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNEHW8Dh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31B21F0089F;
	Tue, 10 Nov 2026 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336019;
	bh=NX8Bgqj1cYflPJDUmwjJtPnSzWDqNwLdB/3DJANbDY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TNEHW8Dhp9KY/5lKuo0uqb46nt9CBA03HGfjMnQ5V+90gZxrwOprCiQChp/yuO2We
	 HDAhaD3fXkPGzeV5ZQiRJhTsjq6wX0OZ11mlqKEMaVOKrvqwYHnj9DGbWjm04n8CYe
	 yKuP1etJpb3VfegsgZ9h4tBd6WVJIb69+MYSKcwFpxx2Ism3P6M/jThiB1MIKV40Tq
	 A+nuCd4Jzvvv1yGx/+0lOSAv1SROXEIrfGBVvbX7qI5PMZ0DXHYlEOpTKVnnFa846W
	 fb8Hx3XixD9neKmF9cOhMhk1W+RAvzoNdIeFm64y/U+TKvYuGMG3amW7ZSLw6vhMkK
	 hxTCGyY+dhr5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Martin Fuzzey <martin.fuzzey@flowbird.group>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] serial: sc16is7xx: fix data corruption due to unexpected xon/xoff
Date: Tue, 10 Nov 2026 13:40:17 -0500
Message-ID: <20261110183856.3306633-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052156-failed-6.12-8bb50e95c0ab@kernel.org>
References: <20261107052156-failed-6.12-8bb50e95c0ab@kernel.org>
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

From: Martin Fuzzey <martin.fuzzey@flowbird.group>

[ Upstream commit 8bb50e95c0abd44607bc60a43032c1dbf7470d5a ]

The hardware supports automatically sending XON/OFF based on the
FIFO status and that is already implemented by the driver.
However that capability was not announced with the UPF_SOFT_FLOW bit.

When the port is opened with the default of XON enabled the driver
configures that in the hardware.
If userspace does not want XON/OFF (which is normally the case) it will
use TCSETS to disactivate it. However the serial core optimises this
to only notify the driver if someting imporant has changed, and for
XON/XOFF thit is only if the  driver declares UPF_SOFT_FLOW.

So we end up with unwanted XON/XOFF in the data stream.

The problem only occurs if nothing else needed to be set by termios,
ie if the user space requested values are the same as the default values,
except for XON/XOFF.
Since the default speed is 9600 this means that the problem only occurs
when requesting 9600, otherwise the call to the driver will be made to
change the speed, and that will also clear the XON/XOFF.
As 9600 is quite rare these days that probably explains why this hasn't
already been seen.

It also only occurs on the first port open after boot since the subsequent
opens will use the "logical state" set by TCSETS but not communicated to
the driver the first time.

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@kernel.org
Link: https://patch.msgid.link/20261001100534.1225894-1-martin.fuzzey@flowbird.group
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 942d12f40a394..2c33c053beff2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1615,7 +1615,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		s->p[i].port.irq	= irq;
 		s->p[i].port.type	= PORT_SC16IS7XX;
 		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
-		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
+		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY | UPF_SOFT_FLOW;
 		s->p[i].port.iobase	= i;
 		/*
 		 * Use all ones as membase to make sure uart_configure_port() in
-- 
2.53.0

