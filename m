Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706516;
	b=KQLm0BRx/y/v6yV7Tiu+dX/vsvBOeRHrcXvIHZwM0cD2tzqDxWb3ih/kh82Fh+yJaZY5
	 DBY2/ZX6uOOBRgzBvzdUdCWzPfsr/LoP0n6OAR20o1ROGQC5P4sBA29MZTe+vm5Ww6WUT
	 +WhGTgan4vo77bNdDFGi+JFkxfRS37o2U4yW9xUeg55cQPRR2uE+f0mET84ogGwsFssrS
	 f1PtRK8ytqXiBVDWNkm9BAMx/vayquqFWMaCr2jIJ//uDe0VCKhdgBvO0K9b78DUX+1Pn
	 xVLnvXE1jg/S+M7yf6c6LitO8gOMuEXwFgCMxUi9UdAzEVZsOLj0uNRXP74QG1YdiGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706516;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NNW+Ehx/XV62r0SvKGkV9qkWSbBM0zPoxnUSJcVYdeM=;
	b=yjrru3uwRIwe1dHcjeVsSsJwQ4rQMCk4mE+jSMpnIpolG/C1uTIUbGpCPN7JFwf4MHMe
	 J3oTeVcITADd6ZGrsGmcjXl7TSQ02AnaOTqEEoaOzTyWH7wJ8OMhmMNLCndjaH0c5/v17
	 1LaTNP5hkDiLTKhvVR3cULjmrp3ZVhSep2O7W7HJRczFGvtf+3X+fNXzhk22nJr1+x8EW
	 7veLry9e2pARCovMmDiN4Mzy9Vj4Ri6+KQsaZEnTzGouZJ+uPuxRKH97aCMR9rwqVbadm
	 kIhd8j076O+YQx0TvMeL/UzFL9NBJdRZ6TMGnv7wdtqR93D8amfxHS0hJpjwNKDnDlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKzV5uQ4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CEA606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKzV5uQ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61DC1F000C0;
	Thu, 26 Nov 2026 15:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706516;
	bh=NNW+Ehx/XV62r0SvKGkV9qkWSbBM0zPoxnUSJcVYdeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EKzV5uQ47InnMLMUqpLGi0lhFiB1iI6OhbLOetV/jBAgID0AOIkU1HR+QU35HH8AB
	 F3SJg6Fd9XZDsfq2oimgXwTBmWy/k1VGF8bNrsG+pi1/9AB5rq4M1qgULMaGza03QQ
	 ZS7X/10jiZ3NG8sJJrMJH02InZISD1SnhizUJ0+mKB72x1kHTGoIE3htGQIptMMDuF
	 +LdhKAt3czF+3v/FCO5DdL9jgZ386HEsRGZWLIQzPYxnzvVTxcooPTemTSOpx2cKyA
	 T5uczJsODnE8iMvsgkArbUTQZm+AH4LOHXTZMaN9lUfFso18HYxwZ2Ns17tUXi9rKc
	 Xt+UEfq5TBJvg==
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
Subject: [PATCH 6.1.y 2/2] serial: rda: free the interrupt on shutdown
Date: Thu, 26 Nov 2026 10:21:52 -0500
Message-ID: <20261126151455.2350374-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126151455.2350374-1-sashal@kernel.org>
References: <2026112540-patio-outwit-bcef@gregkh>
 <20261126151455.2350374-1-sashal@kernel.org>
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
index 9deb1c11f743a..fcbc49508d467 100644
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

