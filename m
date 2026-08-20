Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F1215161
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264885; cv=none; b=ksL6m0WoCHX/ln4eoRXZfk4EfHbBtVMDnce3CB9MXPmb3yg527TrqiPZvj1G/24BhPbAvq1uR9ZIerm9WPjj4v626XmnCvbsfaoXqhC3bcUllyZDZcEzpkM8EeE3UnQfooHOMjFJg0XtNlVJx+sSwoa3J4j4zcQ/LzcHcbQnAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264885; c=relaxed/simple;
	bh=wayy42s7KmZBne6AHpL/hFJdq4l36AOrNauhaprH9zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVCaJV7Ak41YOcgg7uDKMEZlqZU2FrE0NZoSqYsmLeNiE0TH8rXoBm3zYfpthNkk+XGJ+hA9w8367VdZMskEBbeGX7WNf+ughn3QoJasCEidu7PVya2zpma1+PjP8neIfkmK12xYWp10BgnpRUlVhAlzNza0icAUDJthCF1YOIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jj8xTVxf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jj8xTVxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786371F00A3A;
	Thu, 20 Aug 2026 22:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787264883;
	bh=avln2IcH5e9leDfZxi4+xZIukLIwUi/qoKxzErMYEVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jj8xTVxfKm45F7QOSesaIt9l3pPfPMMEpuQMRyR0R4faY1D5CTr9PAjEFaldnt8re
	 frrNDFtzYFwLhdEmUeU6wKbU4NehQRchLlZncXSo+My0fo7CYohrgoHQBjWN8uZBPT
	 sTTjCjKXFBHgu+VRT6l8C550bDg39zNRn7i2Yw93lg0HzXlE6yHsKEme8ZcPE24X+D
	 8c2jafoigBfhHFjVUKPjxwNFxzUPHPWPc/flVMpvgG0fNb+d6DWKTKHLMiogAzK5jt
	 4YxV9D3Us+A8DG6YlOV+jrxfViwslR4o7sS8uVh5ns5KmYbbyo6Bn34OIEEROL2PJe
	 Tdg35qIfFgVhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] serial: sc16is7xx: rename EFR mutex with generic name
Date: Thu, 20 Aug 2026 18:27:59 -0400
Message-ID: <20260820222801.2320182-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081753-ebook-finisher-4e66@gregkh>
References: <2026081753-ebook-finisher-4e66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit d9b2d7ddbb973b981c20b21e9228581bb156f66f ]

This mutex is used as a lock when accessing registers that share the same
address space, not necessarily EFR registers.

For example, address 0x06 is shared by MSR, TCR and XOFF1 registers,
independently of EFR.

Rename the mutex with a more generic name to avoid misinterpreting its
usage.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://patch.msgid.link/20251027142957.1032073-3-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 246ac114f485 ("serial: sc16is7xx: enable THRI before filling TX FIFO")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 13a86f0c2d9b4..a890b0da58947 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -328,7 +328,7 @@ struct sc16is7xx_one_config {
 struct sc16is7xx_one {
 	struct uart_port		port;
 	struct regmap			*regmap;
-	struct mutex			efr_lock; /* EFR registers access */
+	struct mutex			lock; /* For registers sharing same address space. */
 	struct kthread_work		tx_work;
 	struct kthread_work		reg_work;
 	struct kthread_delayed_work	ms_work;
@@ -436,7 +436,7 @@ static void sc16is7xx_efr_lock(struct uart_port *port)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	mutex_lock(&one->efr_lock);
+	mutex_lock(&one->lock);
 
 	/* Backup content of LCR. */
 	one->old_lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
@@ -458,7 +458,7 @@ static void sc16is7xx_efr_unlock(struct uart_port *port)
 	/* Restore original content of LCR */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, one->old_lcr);
 
-	mutex_unlock(&one->efr_lock);
+	mutex_unlock(&one->lock);
 }
 
 static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
@@ -593,7 +593,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 			      SC16IS7XX_MCR_CLKSEL_BIT,
 			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
 
-	mutex_lock(&one->efr_lock);
+	mutex_lock(&one->lock);
 
 	/* Backup LCR and access special register set (DLL/DLH) */
 	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
@@ -609,7 +609,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Restore LCR and access to general register set */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	mutex_unlock(&one->efr_lock);
+	mutex_unlock(&one->lock);
 
 	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
 }
@@ -756,7 +756,7 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 	unsigned long flags;
 	unsigned int status, changed;
 
-	lockdep_assert_held_once(&one->efr_lock);
+	lockdep_assert_held_once(&one->lock);
 
 	status = sc16is7xx_get_hwmctrl(port);
 	changed = status ^ one->old_mctrl;
@@ -787,7 +787,7 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 	struct uart_port *port = &s->p[portno].port;
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	mutex_lock(&one->efr_lock);
+	mutex_lock(&one->lock);
 
 	iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
 	if (iir & SC16IS7XX_IIR_NO_INT_BIT) {
@@ -834,7 +834,7 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 	}
 
 out_port_irq:
-	mutex_unlock(&one->efr_lock);
+	mutex_unlock(&one->lock);
 
 	return rc;
 }
@@ -878,9 +878,9 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 	    (port->rs485.delay_rts_before_send > 0))
 		msleep(port->rs485.delay_rts_before_send);
 
-	mutex_lock(&one->efr_lock);
+	mutex_lock(&one->lock);
 	sc16is7xx_handle_tx(port);
-	mutex_unlock(&one->efr_lock);
+	mutex_unlock(&one->lock);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -947,9 +947,9 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
 	struct sc16is7xx_port *s = dev_get_drvdata(one->port.dev);
 
 	if (one->port.state) {
-		mutex_lock(&one->efr_lock);
+		mutex_lock(&one->lock);
 		sc16is7xx_update_mlines(one);
-		mutex_unlock(&one->efr_lock);
+		mutex_unlock(&one->lock);
 
 		kthread_queue_delayed_work(&s->kworker, &one->ms_work, HZ);
 	}
@@ -1635,7 +1635,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		s->p[i].old_mctrl	= 0;
 		s->p[i].regmap		= regmaps[i];
 
-		mutex_init(&s->p[i].efr_lock);
+		mutex_init(&s->p[i].lock);
 
 		ret = uart_get_rs485_mode(&s->p[i].port);
 		if (ret)
-- 
2.53.0

