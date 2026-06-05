Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA95A3A7F5F
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673470; cv=none; b=uSbvYUNf03yv+t8gTslUpIImxGTSqZKzNr3ZnyV3Z8/4PWrV7vgR3vcZssmzALItheV86BZFhEhyLg4bdAa4hQnxl6us7CLddUbLV+xh+xuWN1bmkj9fqN3679iOg3HUhzmjn2b80Fd0t1W0Sr4ZBGCMGBe26Ca1mWztHQ+QLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673470; c=relaxed/simple;
	bh=E3vUjfK8pVM+IGL0TujgbNQw6DNDLOdR2Qy0AWxYbM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvGVpcjNH1+9AnTWUgl67YrUaUhvlyW494oD5pqIvwS1gGv/igOrWjJcsVlZ+rgLFvsVsZVxYTbTlyJGqEO3Ntmt5uJEBQTU0ofCeG9KTg/gWBu3snGBFo5nxwCKzMo2XEKQRqpi4z+GLRnaq1S0RsvpNW5fsfybkjvEU70KWoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0WIUUou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0WIUUou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF87F1F00898;
	Fri,  5 Jun 2026 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780673468;
	bh=TamH3rmE84Ze2dT7Tk1ObXngdC7eOkLjOqlNBVAqgOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M0WIUUouRf/0W/Rp5/cP7LSdTDzrtQphbToL2u2IR9BEhRvjykYrPhYwwtmLvUrGb
	 j3G6XxRyw4WmDP7IfzAiBA128npWKpYjfOKR20SOixceIj2Ly5ITF/TT7vuQucFDQ3
	 Evg1IB5HOMuX9ZoMisZRkxoHR4/gBeGyn++RVwGvlyS/rq5oFOqei4wxE+oIyIVVAC
	 k01E3KMY+OOiJWFvME7oYllNiX/RF7/bH78jsdkg1XbUKXzx4VQlnnvsV3/M0KF/6Q
	 SJTMOy9bO4Jx3IyOEy2adfc9kXjpDF3gHj/mD8BtFird++qHQ/fk2uQEwx1YtZT+XS
	 cHb7Vx82QuXbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	stable <stable@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] tty: serial: samsung: Remove redundant port lock acquisition in rx helpers
Date: Fri,  5 Jun 2026 11:31:04 -0400
Message-ID: <20260605153104.1929085-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605153104.1929085-1-sashal@kernel.org>
References: <2026060428-showdown-storeroom-5e99@gregkh>
 <20260605153104.1929085-1-sashal@kernel.org>
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
index 9d825dd8b6cd4e..b8756576699c05 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -247,12 +247,9 @@ static int s3c24xx_serial_txempty_nofifo(const struct uart_port *port)
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
 
@@ -265,23 +262,18 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
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

