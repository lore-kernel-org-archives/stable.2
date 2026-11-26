Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706749;
	b=sVBFuIqqTfDZK7PojaDbh5qFK1ka6N+aLiN5IxYPaTxKIUpJL2PjDTreEHiWTfLa4/KF
	 JQHobmkAQtpWRwlB59ytCxPvbeZfEaVs2oylp8BmeRTTI3mCnrG2vbdnvZhcxMTD29X7/
	 cTG75K+4TsRL3+PlcESUhE1CTAN5vghI17+rZHE1V6Z5hX44mgUJ9YBYPMjFpbKp2dziD
	 l2TgpaNFv2QveDrt8H4sUUcTcr9FSbwVx7WKJtHHNS+Tm6lEt/O0jBh1RQdGZsXeC66vq
	 jTqCST2oJDfAtgYq/jBQpkhHQ1OL6YbbP3hUr88Xs5xssZ0JqjYxTTQLpfB1FSiAfQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706749;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Hji4EQadAt9csq8K/OkCbOzkFcjvK+sytnP3Xoz9gEA=;
	b=hW25CFzQ5eh9Rn/DHO0blmBrmOS0jG/FjDXCogdUwY0dVWtXqhZwtWT1QpLObYiXyIEq
	 y7KDbW5uR0CV/5NpZ6KIC2ulIDc6kMis4qA2YUDC7Y6sCyv2GNLR3xhRXbb81rPn7loaK
	 BnWFq6xm8qtCdxibLRAcWxPg492iHOtWl3Jw1enLI2MbA4n32RaKmwglSUBBllDZFWPit
	 63dJJkHthxHXreVDIJv2PqBKTx5rLhdS5D5L4diAYmqRFa/jXZDMaMkg32Tb8IZwDt3+q
	 U/NxxLhPIOrbQgdxPNP6WCHSUiIfpl1knLgZTuDpE4VZldlNrltzA06yMPy/+w0GKKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsKwxvME;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB12606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsKwxvME
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3525D1F000CF;
	Thu, 26 Nov 2026 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706749;
	bh=Hji4EQadAt9csq8K/OkCbOzkFcjvK+sytnP3Xoz9gEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OsKwxvMEM2/NiScvdoIgaFg/xtJPxgW7vnjbLnqQ1hMYN4wvH6QQtA1o9tKvPvcjF
	 4TyFvE/ifbUfTTMqYpdOPutx1qhdvFqTZcA73P3XYWsY/uHxUzplJ6sNiz0wIP/pvU
	 JAHUZdU0a8U7fS/5W4RgsdHbawqTOqEHGtyN/CK/fx6kWUgssPoAHbPERIsHFjc2Fj
	 vt0ubkAvXufjH9LbA0cUYysk4Gqvw2cbCsVpXBPjvKr6K7DyWAosWQ6mGIC3rxcU8i
	 uHfHVs2fC8DoaD0qHkZdheR5BVUy+GNeWbR4cfHxPDDdGAopRkkQDyCAFD5ts6YdPg
	 /5a3kq3vTofRA==
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
Subject: [PATCH 5.15.y 2/2] serial: rda: free the interrupt on shutdown
Date: Thu, 26 Nov 2026 10:25:45 -0500
Message-ID: <20261126152537.2443991-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126152537.2443991-1-sashal@kernel.org>
References: <2026112540-fiber-tribute-8e1c@gregkh>
 <20261126152537.2443991-1-sashal@kernel.org>
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
index b59331fc360bc..18e7f1067b816 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -477,6 +477,8 @@ static void rda_uart_shutdown(struct uart_port *port)
 	rda_uart_write(port, val, RDA_UART_CTRL);
 
 	uart_port_unlock_irqrestore(port, flags);
+
+	free_irq(port->irq, port);
 }
 
 static const char *rda_uart_type(struct uart_port *port)
-- 
2.53.0

