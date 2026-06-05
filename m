Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D23AD520
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684282; cv=none; b=tquMTi8TZ60EeSE5OSa96zljdBvrEABBIfyWWhh4uz3dHVMdUgjBxpdI+riuf/lgWfsvaCAE+dSwHr6NTLXpvM1K3jMTowfifmmtginEyjqIJyb8WSEqxQvp1dAc9HdrEe23HxpB2aspvPa6/L66/tA9Hks9nd42WX2fPK+ZbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684282; c=relaxed/simple;
	bh=R4RArynYaMLqaJaxE6s/+nTaH2UxWqY8l/X+kbsC/eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEwg7ECgDJKZRgosN5rpHe2t0Ofvq32PfrkrkinFnR8Ow64uvupTCmi7utwRgSTHI3fFQGhsaMhkP8HK1bsoL7kdICG9N7suC0NJKGHGJXJTDRxseD5SGmUtQYvlqOnh/0UYwFKBA3I2qyc++3d1X/M52/YW6rKGLYP5mnvBCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixsphNn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixsphNn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C651F00899;
	Fri,  5 Jun 2026 18:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684279;
	bh=ZtBc0YPkEZEODZ2FJ3gJzrsZbeIDVP2E1NObPKfA/Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ixsphNn4icMCaG1O90L7F5gh6iw/0hR19pLzbNeNE5FAoGJ6oPDkY4KC6PrMvZfCO
	 gwvQEVvn6hpxIPUxqzMKFQibRmD1PQ+oHBX6E7ViylW4VuWCmr9y+RQQ94SbOEcrqn
	 GOnJAHjDlrqF4Mcj8gOJerJnfh/ijYY9FzmfyGcEI4lIFYx+L2lFyhC5+3bLa6KFZi
	 Lr5ja/ownNNaWB7LU8m8QYJEQ+CmZZnI+vyrBgZV3WZG+p5G6/WvqhXxOLcpzcAi+N
	 Nq0Z5qKeKdEz0h9I/58v85CDvZ70AAc1x1BuNVC2Olh+iPH6L4zTgb/7j++WA2sRZf
	 pyISgaZ7CVAvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	stable <stable@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] tty: serial: samsung: Remove redundant port lock acquisition in rx helpers
Date: Fri,  5 Jun 2026 14:31:15 -0400
Message-ID: <20260605183115.2054750-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605183115.2054750-1-sashal@kernel.org>
References: <2026060429-saddling-hacked-b97c@gregkh>
 <20260605183115.2054750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tudor Ambarus <tudor.ambarus@linaro.org>

[ Upstream commit a3bb136bff5e6a5e48cdd813246c9c4686feaaa9 ]

Sashiko identified a deadlock when the console flow is engaged [1].

When console flow control is enabled (UPF_CONS_FLOW),
s3c24xx_serial_stop_tx() calls s3c24xx_serial_rx_enable() and
s3c24xx_serial_start_tx() calls s3c24xx_serial_rx_disable().

The serial core framework invokes the .stop_tx() and .start_tx()
callbacks with the port->lock spinlock already held. Furthermore, all
internal driver paths that invoke stop_tx (such as the DMA TX
completion handler s3c24xx_serial_tx_dma_complete() or the PIO TX IRQ
handler s3c24xx_serial_tx_irq()) also acquire port->lock prior to
calling it. (Note that s3c24xx_serial_start_tx() is only invoked by the
serial core).

However, s3c24xx_serial_rx_enable() and s3c24xx_serial_rx_disable()
unconditionally attempt to acquire port->lock again using
uart_port_lock_irqsave(). Since spinlocks are not recursive, this
causes a deadlock on the same CPU when console flow control is engaged.

Remove the redundant lock acquisition from both rx helper functions.

Cc: stable <stable@kernel.org>
Fixes: b497549a035c ("[ARM] S3C24XX: Split serial driver into core and per-cpu drivers")
Reported-by: John Ogness <john.ogness@linutronix.de>
Closes: https://sashiko.dev/#/patchset/20260506121606.5805-1-john.ogness%40linutronix.de [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://patch.msgid.link/20260515-samsung-tty-flow-control-deadlock-v1-1-93255edbc9bc@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index e83e39ea176a67..1d8f5d3f440b8d 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -242,12 +242,9 @@ static int s3c24xx_serial_txempty_nofifo(struct uart_port *port)
 static void s3c24xx_serial_rx_enable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned long flags;
 	int count = 10000;
 	u32 ucon, ufcon;
 
-	uart_port_lock_irqsave(port, &flags);
-
 	while (--count && !s3c24xx_serial_txempty_nofifo(port))
 		udelay(100);
 
@@ -260,23 +257,18 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 1;
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_rx_disable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned long flags;
 	u32 ucon;
 
-	uart_port_lock_irqsave(port, &flags);
-
 	ucon = rd_regl(port, S3C2410_UCON);
 	ucon &= ~S3C2410_UCON_RXIRQMODE;
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 0;
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_stop_tx(struct uart_port *port)
-- 
2.53.0

