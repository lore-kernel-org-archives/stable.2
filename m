Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705794;
	b=5h8CEmN4F8n49WsaGfOJZPgvDZxm/11wXO35PelCFbgV7WJRmAClgv4Ue/miD/eaiwDJ
	 sqxGJuja/zS1uLcAvOOKUwzJuvBhhjJNEvAwaygjPujLjx3tsp+s3MVPgfLi01hOlf+Rs
	 i9+WkQinaa5d0vaQDFNVJ1dfXQpIcARMhvK9zQMga2cuEplBA9nOy3MZsyyfzE4yFIKwy
	 1aLPevexNsZL8Ci5dSBPuu7sN6S6N+EbQZNeWq2Opcwzk4K5QmEOCqdPVcNwemCL4eeuj
	 h0n+VXo5afUIug/d99GJX0bhNTmbM2Y3uMdnh4zUUeKiYdtYiMSUqiwir4xVIgadpqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705794;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gaWHTvtfHL1msoO+zT2CT/hWDGFI4DLiYa0+hvEmE/4=;
	b=YIi1M/YqEL5OzFdhRLI6juxM7oSstw1MLunCmbovfP4Gj4FU3NMGnny/u/8wkpQIamEq
	 fRaMeq4k4vMQeZO22pNstuzqO7KMAkNh8WVPiYgzBHRKLFlW2EM6mjZkis8JWw4gMtKI0
	 ONVHhLI+DDdmPP95ZKcN24Jc9duShJqdgwvPbTDSgh76x6/tBez4bVwkRewTqw7B+KeaR
	 2oJ1Z9+FlyVRkK5wzI50+L3n6O/B0DB/wXr5fl88z3+9v5YolGfoQtcLaXeZkCiTiIux4
	 2VeJn5pHqONzrgCKQvV8Eb/6LfH5moD90X0Q1xADT5croEAf5Ze0cPJJ4M+BNJRvLyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2QzqtKF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC8D606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2QzqtKF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B831F000CA;
	Thu, 26 Nov 2026 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705793;
	bh=gaWHTvtfHL1msoO+zT2CT/hWDGFI4DLiYa0+hvEmE/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k2QzqtKFDex6RYCa685NyQjKDnBlej2xQ6WQaamI21n01BKjot2vYYBLXzuzA91a/
	 wWw2OX6a/7XNgUR8jDqGF18XVyIeumF+3DCavPkOt7gH6nv6mSXe1+qFIMkl4otSjo
	 f/PWjp1ULW7Oksszyco988/+JIa78/Werbmeqaa2SC/86kWfwodNwbMRtCGBzCw+h2
	 z9/PQmyMlmCii2FeDdNwgMv3c5rlgSHqqLG37nwPK1qLXLkmei2g9MfZE72b/WbLUV
	 l+xj09iiHe8/k3pUQT+tZWbGvsaJ3HWxiIqEGrdtcll4f8LuRqramKyQfUD6dTtpey
	 o0M19e96bJQIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Olof Johansson <olof@lixom.net>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] serial: rda: free the interrupt on shutdown
Date: Thu, 26 Nov 2026 10:09:50 -0500
Message-ID: <20261126150942.2245374-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126150942.2245374-1-sashal@kernel.org>
References: <2026112540-stoic-jittery-a891@gregkh>
 <20261126150942.2245374-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 859f7c56709b161a72b629b6f2f1384dcd374404 ]

rda_uart_startup() requests the interrupt, and nothing ever frees it.
It is not shared, so once the port has been closed, the next startup
fails with -EBUSY and the port cannot be opened any more.

Free it in rda_uart_shutdown().

Fixes: c10b13325ced ("tty: serial: Add RDA8810PL UART driver")
Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20261027-tty-llm-v1-20-99b0202ae546@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/rda-uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index d824c8318f330..f8b59ec3a6e0a 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -476,6 +476,8 @@ static void rda_uart_shutdown(struct uart_port *port)
 	rda_uart_write(port, val, RDA_UART_CTRL);
 
 	uart_port_unlock_irqrestore(port, flags);
+
+	free_irq(port->irq, port);
 }
 
 static const char *rda_uart_type(struct uart_port *port)
-- 
2.53.0

