Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342066;
	b=F7l+doinCZUc8qukgMimKDIQcgAVawk2fAIVsiw5hR3Ama7MD+KKUXa6mBujTx13g+Az
	 Yxit6Py8EJ6D/bgYHXZAd92LtyzMsx2yUkvJOIpgQbmF0TKHHVXiNgXp/zlQFgzNpzwRs
	 SadeXngjxny/hhtcvELlZWkx0p0jjshUENVfx5aAgTisSaQCZ48xXkC1CsXE70dDAkSGA
	 b1hGJP6iq8/R/vzU/cBSYj4ATrbInLAmZBnGcS7AkU73kxpl2QtNZwqaksLCLua6pyTQQ
	 QXGFjGSNgDg2OZGQxY9tVMqOFJYRL+EvIA6KxbA/UIyBUV+21DEuuD/1QrrvIJKe6eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KZWkrvv64gjDYnRyJH53Fo4ww7DaVbD3uhTO1EvFmTs=;
	b=WIGJoAcxDWS3ZyYQxD44oYYukOBo+TsiNOXSIuornjcfe7TW37ek2h7sJwJIeFBLRVe7
	 E5Hi7WoILsiFpCIx+z+oqQfzRlLyj9Al1uxB0hiFdZhlhJYb6rIDHeo86sGozLnB3awHj
	 pJ2pON/njeZ1VJpXd2FlsCspnN2kM74OCC7h78HMbdIcSs1hhM4WtixjSzewy2yp2jHQu
	 9owQOLp9mfHQZM70tK1QiybzIA4uPjW1OtsNXlu3yizeDiRgtNZeMn7IUJncYkDsVKN72
	 F9TsQnfsmPkIrcbUePCpFOknmKXs69MdKfeL2KZKux5AspCRoYTn+4epZvjYxVlv8eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nrWeF8wE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C97960A3808
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nrWeF8wE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED751F008A3;
	Tue, 10 Nov 2026 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342066;
	bh=KZWkrvv64gjDYnRyJH53Fo4ww7DaVbD3uhTO1EvFmTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nrWeF8wEwxp9U8TvHoO5dgIv9tPDJqIj6n2l3xJSCiAuS+RnorJmbYBeD1esGagFN
	 BVCsrD2PLgs6FS8GGYxQ0zbwoh1ntTJqZkxDfccS8NX/X0OYqPMWZLH9PUQhZYrUfb
	 6kXNasRTNOl1ctQIqyDPW5aUueduzmQor0jTafonRfZmPADDk+6qbm25VxRc/Inhax
	 01Xec1M8EvwWfZQjaiZNwsCgfAmr2Mv18qSvm7SO1Vz4p9JJvDYYgYxFh/FlRDNw7r
	 pTuhlye4zPeyJQ+/1AXcJbd4cjSHg5SoFddD9v0RK29Ppd8GB49ATzPjJyFCe8GPFK
	 mw/Dh8zR4yIiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] serial: exar: fix checkpach warnings
Date: Tue, 10 Nov 2026 15:21:01 -0500
Message-ID: <20261110202051.3754797-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110202051.3754797-1-sashal@kernel.org>
References: <20261107053424-failed-6.6-33d337816e00@kernel.org>
 <20261110202051.3754797-1-sashal@kernel.org>
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

From: Parker Newman <pnewman@connecttech.com>

[ Upstream commit c6795fbffc4547b40933ec368200bd4926a41b44 ]

-Fix several "missing identifier name" warnings from checkpatch in
struct exar8250_platform and struct exar8250_board.
Example:

WARNING: function definition argument <arg> should also have an
identifier name

- Fix space before tab warning from checkpatch:
WARNING: please, no space before tabs
+ * 0^I^I2 ^IMode bit 0$

Signed-off-by: Parker Newman <pnewman@connecttech.com>
Link: https://lore.kernel.org/r/f7fa6c16cb5f2c8c1c7cb7d29f80bc7be53f91ab.1713382717.git.pnewman@connecttech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 33d337816e00 ("serial: 8250_exar: store the GPIO platform device in struct exar8250")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_exar.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index d8e2dd5a2451e..aa72d252c6bcb 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -133,7 +133,7 @@
  *
  * MPIO		Port	Function
  * ----		----	--------
- * 0		2 	Mode bit 0
+ * 0		2	Mode bit 0
  * 1		2	Mode bit 1
  * 2		2	Terminate bus
  * 3		-	<reserved>
@@ -169,8 +169,8 @@ struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *port, struct ktermios *termios,
 			    struct serial_rs485 *rs485);
 	const struct serial_rs485 *rs485_supported;
-	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
-	void (*unregister_gpio)(struct uart_8250_port *);
+	int (*register_gpio)(struct pci_dev *pcidev, struct uart_8250_port *port);
+	void (*unregister_gpio)(struct uart_8250_port *port);
 };
 
 /**
@@ -185,8 +185,8 @@ struct exar8250_board {
 	unsigned int num_ports;
 	unsigned int reg_shift;
 	int     (*board_init)(struct exar8250 *priv, struct pci_dev *pcidev);
-	int	(*setup)(struct exar8250 *, struct pci_dev *,
-			 struct uart_8250_port *, int);
+	int	(*setup)(struct exar8250 *priv, struct pci_dev *pcidev,
+			 struct uart_8250_port *port, int idx);
 	void	(*exit)(struct pci_dev *pcidev);
 };
 
-- 
2.53.0

