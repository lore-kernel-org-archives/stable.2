Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707117;
	b=OAQhEgUaytVAKgDY6n31NSGSIRBK3oV7V+/SbTLfFwq5XqoX8JOMYIrzlsQu7vDEl4MZ
	 An2paNaaFPQ+83RApXEt3j9jUC90Bp1a3MJLbhrrXMQPoOMbaXt9TfZxVLujyQSHL2NLx
	 LlRV+iobZQTBatsnDJDzFh4dum2iY3OGu6cs2JI9pgLTOikIur8vOA4lRRVl20bD17W63
	 T0Ie3iLafnVoGXMyh5HutwUe9g2M9dCsTF1mRvsCmxYhqhJFhTiHrZz0Mw66Y4uEklACx
	 6KAeJPiGeYmYaSC1KKq+HRQZgz69n0VzHN1ZCmxv3gaZqZftOlY4AbKmDa1oOJopAQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707117;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+KtsR+83guEk5pthD5kTz+kZv97qfY/va3ZKdfI1WLQ=;
	b=XQHJvppakxRX+qaaMdeWs+CFXbGzR6PyRFKPrvxJ27B1OZn3y3fxN7ITLSRiSWD5AOgZ
	 JF0RUGkSpvr5kmBh3xA1/+/U3ENHgLgsVWC6qCs/t6FnaDBy4TQGU0cg/t4TVb5AMjLif
	 GS/XZixS3I7SvnCcKgJ4QNDXhB98FsqeeGx1SRClqwy4XAPUsR0bD8q5gkWpmsKar7pZY
	 ZAQvyStoyrBwidxidq/oiQ/r6pLKryxn818TPgJc74uReTDRGDpp33oNU4R+oiqz70yor
	 HjbZuKOxbkVDobipmOUTMjj1kzYqznC/lWP+xD/9ZtiDeNjY2c1DtYWRsGuk5iIicvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8l7zZ+y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C704D606A68E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8l7zZ+y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D525C1F000C6;
	Thu, 26 Nov 2026 15:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707116;
	bh=+KtsR+83guEk5pthD5kTz+kZv97qfY/va3ZKdfI1WLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g8l7zZ+yWlONWyoPn+rYdSEd/gXPNvw5Rp5CMXCJRqd/3Npgva9emd8YJC5XXMdfc
	 x/hmJzryXDHrNu9Zt778Ls0ux5SP1MmMMkysQFW4m97ArUH7Oj+z0grFOBEZ66AF3m
	 dJvDKFUjc74z9sm7emSvTe/ola0qbmmefaVws0wu0YXncOp4xZ/RY8QQBlXl6so6NS
	 FkpTYDMVKv/x5tmJWWw3tnvZW/PWSswIj72z4ruk1hMfHD37Rs2Uk1dOWQR+sQoCWq
	 lzJ6VMvt8wuE+pOtZ7eY53syaR0OGNdniW900yqXXxHZQSVC71FAZxWWfjVqsMTnPW
	 0A9J+g9zlFdXg==
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
Subject: [PATCH 5.10.y 2/2] serial: rda: free the interrupt on shutdown
Date: Thu, 26 Nov 2026 10:31:53 -0500
Message-ID: <20261126153133.2455392-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126153133.2455392-1-sashal@kernel.org>
References: <2026112541-comfort-tidiness-5bde@gregkh>
 <20261126153133.2455392-1-sashal@kernel.org>
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
index 993fa7a91aeaa..fc9fc6e46806e 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -479,6 +479,8 @@ static void rda_uart_shutdown(struct uart_port *port)
 	rda_uart_write(port, val, RDA_UART_CTRL);
 
 	uart_port_unlock_irqrestore(port, flags);
+
+	free_irq(port->irq, port);
 }
 
 static const char *rda_uart_type(struct uart_port *port)
-- 
2.53.0

