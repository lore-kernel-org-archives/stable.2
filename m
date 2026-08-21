Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937CA3CBE6E
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310014; cv=none; b=YscWiPTaxqSTPrvdyI3aFo4aG5OXrZ+A2uewzVxwACgWmW6P5wQewEgXUqnoWynvlWQJJ74xWmoCSxSbXQcOPlNPOBYRCXVu9PqBiYNJyDdrYA3HY+wBvF2hi2YbUUTqRP/DJNGhhZZ7zv1hLCofzkU0PXSij1VpTQUuQXVBAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310014; c=relaxed/simple;
	bh=BrWfD8lLphSBEdZwM2uLAXEyxfaUG3GHMyxxn8Er8ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQT7y1Ah9OaeJT9cWY7Qw416b0hPYeUcn61lYPTSTA/4BrSGXYydIhC0YWRdb9l5MmiJS8C43AUKupAAA3HIbGN9N9fZkTicGKICiAy7pS+2GQmGbC2WtlEjL0Jb2pXBWHwxt3Gk9xAMqgmjzjfWWHJaHg+UHjFBJAA8BaAcapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbxvvJKb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbxvvJKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED61B1F00A3E;
	Fri, 21 Aug 2026 11:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787310012;
	bh=AHax4weKezthdMYnna9DwncRKIqZN89iUOjbNnHdd5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UbxvvJKbHpXjSRMdVIFnfJOUJY9vWMgmVQLY0cZlG6zaU8uejKMX6rrGnUDK19DQc
	 v70xZlb6NWqoOxC67xShNqXQfZqajRZLVAGKqRY9abwLIZ8zMu+dMd6T/O+Mwp6xKK
	 BhwYWyhvmDHDUjZrgXa5D4RQejIPskraUQVv1O8r/Ud942QrleBhf9QjWeharAiIJe
	 XpaiSY63eNJl6UagHfIL+LhZ4mfp8IzeEFa2r77x0je5JVcENbFmdyHaTsrBOo8Li6
	 fHPtiHW4cu3aVlZg9Bp1zKuat9sUWULUixl48KEkrdEA33Xr5w1qMQL/S9+JL2eXdQ
	 h38xqIBuiOdSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] serial: sc16is7xx: rename EFR mutex with generic name
Date: Fri, 21 Aug 2026 07:00:06 -0400
Message-ID: <20260821110008.2816500-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821110008.2816500-1-sashal@kernel.org>
References: <2026081755-absence-womanlike-85b3@gregkh>
 <20260821110008.2816500-1-sashal@kernel.org>
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
index df21f6eb7726a..694e3d78d6e78 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -330,7 +330,7 @@ struct sc16is7xx_one_config {
 struct sc16is7xx_one {
 	struct uart_port		port;
 	struct regmap			*regmap;
-	struct mutex			efr_lock; /* EFR registers access */
+	struct mutex			lock; /* For registers sharing same address space. */
 	struct kthread_work		tx_work;
 	struct kthread_work		reg_work;
 	struct kthread_delayed_work	ms_work;
@@ -437,7 +437,7 @@ static void sc16is7xx_efr_lock(struct uart_port *port)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	mutex_lock(&one->efr_lock);
+	mutex_lock(&one->lock);
 
 	/* Backup content of LCR. */
 	one->old_lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
@@ -459,7 +459,7 @@ static void sc16is7xx_efr_unlock(struct uart_port *port)
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
@@ -765,7 +765,7 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 	unsigned long flags;
 	unsigned int status, changed;
 
-	lockdep_assert_held_once(&one->efr_lock);
+	lockdep_assert_held_once(&one->lock);
 
 	status = sc16is7xx_get_hwmctrl(port);
 	changed = status ^ one->old_mctrl;
@@ -796,7 +796,7 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 	struct uart_port *port = &s->p[portno].port;
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	mutex_lock(&one->efr_lock);
+	mutex_lock(&one->lock);
 
 	iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
 	if (iir & SC16IS7XX_IIR_NO_INT_BIT) {
@@ -843,7 +843,7 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 	}
 
 out_port_irq:
-	mutex_unlock(&one->efr_lock);
+	mutex_unlock(&one->lock);
 
 	return rc;
 }
@@ -875,9 +875,9 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 	    (port->rs485.delay_rts_before_send > 0))
 		msleep(port->rs485.delay_rts_before_send);
 
-	mutex_lock(&one->efr_lock);
+	mutex_lock(&one->lock);
 	sc16is7xx_handle_tx(port);
-	mutex_unlock(&one->efr_lock);
+	mutex_unlock(&one->lock);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -944,9 +944,9 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
 	struct sc16is7xx_port *s = dev_get_drvdata(one->port.dev);
 
 	if (one->port.state) {
-		mutex_lock(&one->efr_lock);
+		mutex_lock(&one->lock);
 		sc16is7xx_update_mlines(one);
-		mutex_unlock(&one->efr_lock);
+		mutex_unlock(&one->lock);
 
 		kthread_queue_delayed_work(&s->kworker, &one->ms_work, HZ);
 	}
@@ -1587,7 +1587,7 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].old_mctrl	= 0;
 		s->p[i].regmap		= regmaps[i];
 
-		mutex_init(&s->p[i].efr_lock);
+		mutex_init(&s->p[i].lock);
 
 		ret = uart_get_rs485_mode(&s->p[i].port);
 		if (ret)
-- 
2.53.0

