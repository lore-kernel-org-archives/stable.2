Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079B25CC57
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284764; cv=none; b=CdCzNGajDXaO8axLpxcILxFy/XdshUjOhVVc9JKQCUi/hcgz8qdV5WIbNiEJSy0rV2DrucnN25Di055CLvmW04Vv1gRoCKJ5jCWGXDP1KdVJfQ0R1PYBH98TurseEPGxQ2F6V77KD/xVl/Qps2I2l+aDL+uzLmXwuU0VdaPy3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284764; c=relaxed/simple;
	bh=Pw4ynhiifeuq7U/tVeJXK1gaj8ifYFlcMYoWrVaZZ/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3TeMigV5F32QOvRXPJbbMYKZ/aMFVrId4MXsGlqLJ7LbM8zcwCiZV+3Cpj7lavkqmA6a3SzGjf4B8DIXazMxR8Yb9zXSkSn5aTTWn6VG7z7ttXDevbPihm1s8pjKV8jhEXyELyfYLobg8ium1mqQhPVMLYjBRShpIT3OD1zaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTYEUgwE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTYEUgwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D781F000E9;
	Fri, 21 Aug 2026 03:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787284763;
	bh=3W/rFjsqvgusYPcRfRmv4FWflN0vVddRjvKXqHBL1Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTYEUgwE5STRvPdw40et6CMVofvd+Po76CXQGpIZ2N1cQHsYzzWx2cn32f/3gQw+g
	 gKf9Ufl8kPQtS+d69zACoAri48AnuPBRd97HKeyC9f4YiPJIZcCozjLXlHnhVYxubq
	 9yrsHuM3Zp9hYkWsULqfgamPuJA5X48vXOc6s4NhUNnrF/ska1M592XiHatzloHYO/
	 Zy8dLkFKXi9f6q7WyMoFvX2sSXUgBKpIJKeMdhr2OUsOUncFqRKiH7UzgNzGtzBgxW
	 X2BHCK6my4VP4lge/oxkv33gEFco4mogejHsTlWrPy4+waxne4DQD4hKvy2AFMD8qW
	 IQhviOGxxVwUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] serial: sc16is7xx: rename EFR mutex with generic name
Date: Thu, 20 Aug 2026 23:59:18 -0400
Message-ID: <20260821035920.2524947-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081754-ogle-alkalize-4f27@gregkh>
References: <2026081754-ogle-alkalize-4f27@gregkh>
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
index 01de811bc1501..f9d4aaff6239a 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -327,7 +327,7 @@ struct sc16is7xx_one_config {
 struct sc16is7xx_one {
 	struct uart_port		port;
 	struct regmap			*regmap;
-	struct mutex			efr_lock; /* EFR registers access */
+	struct mutex			lock; /* For registers sharing same address space. */
 	struct kthread_work		tx_work;
 	struct kthread_work		reg_work;
 	struct kthread_delayed_work	ms_work;
@@ -433,7 +433,7 @@ static void sc16is7xx_efr_lock(struct uart_port *port)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	mutex_lock(&one->efr_lock);
+	mutex_lock(&one->lock);
 
 	/* Backup content of LCR. */
 	one->old_lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
@@ -455,7 +455,7 @@ static void sc16is7xx_efr_unlock(struct uart_port *port)
 	/* Restore original content of LCR */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, one->old_lcr);
 
-	mutex_unlock(&one->efr_lock);
+	mutex_unlock(&one->lock);
 }
 
 static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
@@ -590,7 +590,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 			      SC16IS7XX_MCR_CLKSEL_BIT,
 			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
 
-	mutex_lock(&one->efr_lock);
+	mutex_lock(&one->lock);
 
 	/* Backup LCR and access special register set (DLL/DLH) */
 	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
@@ -606,7 +606,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Restore LCR and access to general register set */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	mutex_unlock(&one->efr_lock);
+	mutex_unlock(&one->lock);
 
 	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
 }
@@ -753,7 +753,7 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 	unsigned long flags;
 	unsigned int status, changed;
 
-	lockdep_assert_held_once(&one->efr_lock);
+	lockdep_assert_held_once(&one->lock);
 
 	status = sc16is7xx_get_hwmctrl(port);
 	changed = status ^ one->old_mctrl;
@@ -784,7 +784,7 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 	struct uart_port *port = &s->p[portno].port;
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	mutex_lock(&one->efr_lock);
+	mutex_lock(&one->lock);
 
 	iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
 	if (iir & SC16IS7XX_IIR_NO_INT_BIT) {
@@ -831,7 +831,7 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 	}
 
 out_port_irq:
-	mutex_unlock(&one->efr_lock);
+	mutex_unlock(&one->lock);
 
 	return rc;
 }
@@ -863,9 +863,9 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 	    (port->rs485.delay_rts_before_send > 0))
 		msleep(port->rs485.delay_rts_before_send);
 
-	mutex_lock(&one->efr_lock);
+	mutex_lock(&one->lock);
 	sc16is7xx_handle_tx(port);
-	mutex_unlock(&one->efr_lock);
+	mutex_unlock(&one->lock);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -932,9 +932,9 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
 	struct sc16is7xx_port *s = dev_get_drvdata(one->port.dev);
 
 	if (one->port.state) {
-		mutex_lock(&one->efr_lock);
+		mutex_lock(&one->lock);
 		sc16is7xx_update_mlines(one);
-		mutex_unlock(&one->efr_lock);
+		mutex_unlock(&one->lock);
 
 		kthread_queue_delayed_work(&s->kworker, &one->ms_work, HZ);
 	}
@@ -1604,7 +1604,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		s->p[i].old_mctrl	= 0;
 		s->p[i].regmap		= regmaps[i];
 
-		mutex_init(&s->p[i].efr_lock);
+		mutex_init(&s->p[i].lock);
 
 		ret = uart_get_rs485_mode(&s->p[i].port);
 		if (ret)
-- 
2.53.0

