Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C298404BCE
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688308; cv=none; b=JxqGTE7sEfViRvBR+jMerHql34ZiM6b4UVZAfE44Q0dVZAcjrwLj6TD/eTKl0p3fXSUAWEj016iZqzDZu/4d4ooerC4+SGJ8dKl7VuwCfIv1DEShMkGvtQQ3lxG0sp1OJlFSJ63xcqEJCIzutlJORQpc/yVIK2nMugAoLwN8TM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688308; c=relaxed/simple;
	bh=LBWp/WbQgGve00jKeEbqkpGF/AWN0mfH4QqgpQ98/14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aC4/DSJT5w/S13w2QQMYrKat1yKkIB4ZCD0sExi/uvF0oGnlCg8vd5HVikgT9kaoc2F8jL5EhwFKrkLcS3AD0L0NPT6xjWKm9l43+e9d1oSHXkHNeHjFbn3BJPcyMja+n+32Fumkf6KAcZhckxtkSpi6DOFNVP+gj6AHI6E1iA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIS+cQwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIS+cQwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA581F00898;
	Fri,  5 Jun 2026 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688306;
	bh=RTH1RGlm3zsPQ37BBqMMBz8VS++NYbeBTDsWwQe+izU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kIS+cQwtBmsOQDHEYx897F9H+eHr1Jvmk3549+05F4cHmbnPiLMEXFGkYFXuvx7R+
	 cg447GCRyPF/2BwZIHDm+N/wzcTKij+26FoDkIbMlcNQmRGUY/WheWHwrh8VUg0rOk
	 uH7Y0M2Brqa25+9XtVHySX93uWTaFQFjb34EWyfBYuu7Fj1CLS+Sdw28BAOC59sl3U
	 +9s/FxfLzAZREh8+9atWyjZ5grFT5y0fJXNs3CYVHaJ79l15k19B1g9Lpx9kYVgj12
	 N6OgH4fjD+HQU7Hp5+uRI4EgoCO76fes5c/28rpkFUxLNkLiY4SqWmfyX6z58B2v8m
	 wogI4oV/J2yzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] tty: serial: samsung: use u32 for register interactions
Date: Fri,  5 Jun 2026 15:38:22 -0400
Message-ID: <20260605193823.2169333-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605193823.2169333-1-sashal@kernel.org>
References: <2026060429-earflap-scope-57c7@gregkh>
 <20260605193823.2169333-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tudor Ambarus <tudor.ambarus@linaro.org>

[ Upstream commit 032a725c16add79332d774348d7ad7d0d4b86479 ]

All registers of the IP have 32 bits. Use u32 variables when reading
or writing from/to the registers. The purpose of those variables becomes
clearer.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://lore.kernel.org/r/20240119104526.1221243-9-tudor.ambarus@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: a3bb136bff5e ("tty: serial: samsung: Remove redundant port lock acquisition in rx helpers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 67 ++++++++++++++++----------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index ceae15967e01be..1639a6a67e70b4 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -186,7 +186,7 @@ static void wr_reg(struct uart_port *port, u32 reg, u32 val)
 /* Byte-order aware bit setting/clearing functions. */
 
 static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
-				   unsigned int reg)
+				   u32 reg)
 {
 	unsigned long flags;
 	u32 val;
@@ -199,7 +199,7 @@ static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
 }
 
 static inline void s3c24xx_clear_bit(struct uart_port *port, int idx,
-				     unsigned int reg)
+				     u32 reg)
 {
 	unsigned long flags;
 	u32 val;
@@ -242,8 +242,8 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	unsigned long flags;
-	unsigned int ucon, ufcon;
 	int count = 10000;
+	u32 ucon, ufcon;
 
 	uart_port_lock_irqsave(port, &flags);
 
@@ -266,7 +266,7 @@ static void s3c24xx_serial_rx_disable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	unsigned long flags;
-	unsigned int ucon;
+	u32 ucon;
 
 	uart_port_lock_irqsave(port, &flags);
 
@@ -551,7 +551,7 @@ static inline struct s3c2410_uartcfg
 }
 
 static int s3c24xx_serial_rx_fifocnt(struct s3c24xx_uart_port *ourport,
-				     unsigned long ufstat)
+				     u32 ufstat)
 {
 	struct s3c24xx_uart_info *info = ourport->info;
 
@@ -623,7 +623,7 @@ static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
 static void enable_rx_dma(struct s3c24xx_uart_port *ourport)
 {
 	struct uart_port *port = &ourport->port;
-	unsigned int ucon;
+	u32 ucon;
 
 	/* set Rx mode to DMA mode */
 	ucon = rd_regl(port, S3C2410_UCON);
@@ -646,7 +646,7 @@ static void enable_rx_dma(struct s3c24xx_uart_port *ourport)
 static void enable_rx_pio(struct s3c24xx_uart_port *ourport)
 {
 	struct uart_port *port = &ourport->port;
-	unsigned int ucon;
+	u32 ucon;
 
 	/* set Rx mode to DMA mode */
 	ucon = rd_regl(port, S3C2410_UCON);
@@ -667,7 +667,6 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport);
 
 static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 {
-	unsigned int utrstat, received;
 	struct s3c24xx_uart_port *ourport = dev_id;
 	struct uart_port *port = &ourport->port;
 	struct s3c24xx_uart_dma *dma = ourport->dma;
@@ -675,6 +674,8 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 	struct tty_port *t = &port->state->port;
 	unsigned long flags;
 	struct dma_tx_state state;
+	unsigned int received;
+	u32 utrstat;
 
 	utrstat = rd_regl(port, S3C2410_UTRSTAT);
 	rd_regl(port, S3C2410_UFSTAT);
@@ -716,9 +717,10 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 {
 	struct uart_port *port = &ourport->port;
-	unsigned int ufcon, ch, flag, ufstat, uerstat;
+	unsigned int ch, flag;
 	unsigned int fifocnt = 0;
 	int max_count = port->fifosize;
+	u32 ufcon, ufstat, uerstat;
 
 	while (max_count-- > 0) {
 		/*
@@ -898,7 +900,7 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 {
 	struct s3c24xx_uart_port *ourport = id;
 	struct uart_port *port = &ourport->port;
-	unsigned int pend = rd_regl(port, S3C64XX_UINTP);
+	u32 pend = rd_regl(port, S3C64XX_UINTP);
 	irqreturn_t ret = IRQ_HANDLED;
 
 	if (pend & S3C64XX_UINTM_RXD_MSK) {
@@ -915,8 +917,8 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
-	unsigned long ufstat = rd_regl(port, S3C2410_UFSTAT);
-	unsigned long ufcon = rd_regl(port, S3C2410_UFCON);
+	u32 ufstat = rd_regl(port, S3C2410_UFSTAT);
+	u32 ufcon = rd_regl(port, S3C2410_UFCON);
 
 	if (ufcon & S3C2410_UFCON_FIFOMODE) {
 		if ((ufstat & info->tx_fifomask) != 0 ||
@@ -931,7 +933,7 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 /* no modem control lines */
 static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
 {
-	unsigned int umstat = rd_reg(port, S3C2410_UMSTAT);
+	u32 umstat = rd_reg(port, S3C2410_UMSTAT);
 
 	if (umstat & S3C2410_UMSTAT_CTS)
 		return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
@@ -941,7 +943,7 @@ static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
 
 static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	unsigned int umcon = rd_regl(port, S3C2410_UMCON);
+	u32 umcon = rd_regl(port, S3C2410_UMCON);
 
 	if (mctrl & TIOCM_RTS)
 		umcon |= S3C2410_UMCOM_RTS_LOW;
@@ -954,7 +956,7 @@ static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
 static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
 {
 	unsigned long flags;
-	unsigned int ucon;
+	u32 ucon;
 
 	uart_port_lock_irqsave(port, &flags);
 
@@ -1167,7 +1169,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	unsigned long flags;
-	unsigned int ufcon;
+	u32 ufcon;
 	int ret;
 
 	wr_regl(port, S3C64XX_UINTM, 0xf);
@@ -1210,6 +1212,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	return ret;
 }
 
+
 /* power power management control */
 
 static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
@@ -1261,7 +1264,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 static inline int s3c24xx_serial_getsource(struct uart_port *port)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
-	unsigned int ucon;
+	u32 ucon;
 
 	if (info->num_clks == 1)
 		return 0;
@@ -1275,7 +1278,7 @@ static void s3c24xx_serial_setsource(struct uart_port *port,
 			unsigned int clk_sel)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
-	unsigned int ucon;
+	u32 ucon;
 
 	if (info->num_clks == 1)
 		return;
@@ -1394,9 +1397,8 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	struct clk *clk = ERR_PTR(-EINVAL);
 	unsigned long flags;
 	unsigned int baud, quot, clk_sel = 0;
-	unsigned int ulcon;
-	unsigned int umcon;
 	unsigned int udivslot = 0;
+	u32 ulcon, umcon;
 
 	/*
 	 * We don't support modem control lines.
@@ -1712,7 +1714,7 @@ static void s3c24xx_serial_resetport(struct uart_port *port,
 				   struct s3c2410_uartcfg *cfg)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
+	u32 ucon = rd_regl(port, S3C2410_UCON);
 	unsigned int ucon_mask;
 
 	ucon_mask = info->clksel_mask;
@@ -2150,7 +2152,7 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 	if (port) {
 		/* restore IRQ mask */
 		if (s3c24xx_serial_has_interrupt_mask(port)) {
-			unsigned int uintm = 0xf;
+			u32 uintm = 0xf;
 
 			if (ourport->tx_enabled)
 				uintm &= ~S3C64XX_UINTM_TXD_MSK;
@@ -2188,10 +2190,10 @@ static const struct dev_pm_ops s3c24xx_serial_pm_ops = {
 static struct uart_port *cons_uart;
 
 static int
-s3c24xx_serial_console_txrdy(struct uart_port *port, unsigned int ufcon)
+s3c24xx_serial_console_txrdy(struct uart_port *port, u32 ufcon)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
-	unsigned long ufstat, utrstat;
+	u32 ufstat, utrstat;
 
 	if (ufcon & S3C2410_UFCON_FIFOMODE) {
 		/* fifo mode - check amount of data in fifo registers... */
@@ -2207,7 +2209,7 @@ s3c24xx_serial_console_txrdy(struct uart_port *port, unsigned int ufcon)
 }
 
 static bool
-s3c24xx_port_configured(unsigned int ucon)
+s3c24xx_port_configured(u32 ucon)
 {
 	/* consider the serial port configured if the tx/rx mode set */
 	return (ucon & 0xf) != 0;
@@ -2222,7 +2224,7 @@ s3c24xx_port_configured(unsigned int ucon)
 static int s3c24xx_serial_get_poll_char(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned int ufstat;
+	u32 ufstat;
 
 	ufstat = rd_regl(port, S3C2410_UFSTAT);
 	if (s3c24xx_serial_rx_fifocnt(ourport, ufstat) == 0)
@@ -2234,8 +2236,8 @@ static int s3c24xx_serial_get_poll_char(struct uart_port *port)
 static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 		unsigned char c)
 {
-	unsigned int ufcon = rd_regl(port, S3C2410_UFCON);
-	unsigned int ucon = rd_regl(port, S3C2410_UCON);
+	u32 ufcon = rd_regl(port, S3C2410_UFCON);
+	u32 ucon = rd_regl(port, S3C2410_UCON);
 
 	/* not possible to xmit on unconfigured port */
 	if (!s3c24xx_port_configured(ucon))
@@ -2251,7 +2253,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 static void
 s3c24xx_serial_console_putchar(struct uart_port *port, int ch)
 {
-	unsigned int ufcon = rd_regl(port, S3C2410_UFCON);
+	u32 ufcon = rd_regl(port, S3C2410_UFCON);
 
 	while (!s3c24xx_serial_console_txrdy(port, ufcon))
 		cpu_relax();
@@ -2262,7 +2264,7 @@ static void
 s3c24xx_serial_console_write(struct console *co, const char *s,
 			     unsigned int count)
 {
-	unsigned int ucon = rd_regl(cons_uart, S3C2410_UCON);
+	u32 ucon = rd_regl(cons_uart, S3C2410_UCON);
 
 	/* not possible to xmit on unconfigured port */
 	if (!s3c24xx_port_configured(ucon))
@@ -2276,11 +2278,9 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 			   int *parity, int *bits)
 {
 	struct clk *clk;
-	unsigned int ulcon;
-	unsigned int ucon;
-	unsigned int ubrdiv;
 	unsigned long rate;
 	unsigned int clk_sel;
+	u32 ulcon, ucon, ubrdiv;
 	char clk_name[MAX_CLK_NAME_LENGTH];
 
 	ulcon  = rd_regl(port, S3C2410_ULCON);
@@ -2677,6 +2677,7 @@ static void samsung_early_write(struct console *con, const char *s,
 	uart_console_write(&dev->port, s, n, samsung_early_putc);
 }
 
+
 static int __init samsung_early_console_setup(struct earlycon_device *device,
 					      const char *opt)
 {
-- 
2.53.0

