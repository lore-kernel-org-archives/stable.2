Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82835371887
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284765; cv=none; b=st00Q4xvQt4tB+vllCj0n1y3+7cUHHAxMFD+X9bTCxZfPfjWJ9S723RsMllFsdBGlaSN1P2gwX6mgBHYcQflK4nptonHaUFpNoYekZeCDXj1BhzbSDnCbgFH0Iu2Yd/JIVA7lvwiGJdA5/WwWhcE0b+6ahOq/sy9ljgDhO5JSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284765; c=relaxed/simple;
	bh=xUQKeDoDRHK3x/yoFqGFv1ZnedbzdZzISJmTbntGe08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S79Efgmv1XeU6e2pgxDx+SEXsbXO1IerGRVfDUFNoIMJGnGm/jJ66aJ6QpMc5wIx3Bdq9GnonWBVa1Gl1A8rytzBG189bEw9idnrFpM6imljq6vdv/7fcBJJxmt6A8x/zYjFbTVZ/eelhpL/fgYRUQgaD+3Q7h0LZaRHOpyassA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvTiuYCn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvTiuYCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4907C1F00A3D;
	Fri, 21 Aug 2026 03:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787284763;
	bh=c6dNTBV2WIJuLoA37s3pz1xxASQLjmoOX3TbN+hPA9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KvTiuYCnF1Y/MK5YQMDevZMggLxsEsnhKE1tIX0w+N11SZu8zoMwee+M13BaIigS0
	 FfUavycrNAID3J0/bWGG15qhFIHuydZ1UxtyZSk2FiI7CnqArrZKQLyI1yYzRDRmwq
	 7ObqmvVP4Cba7fU/6d80Ibfepyo+n+rVM8WZGxLKLtXnI2IyIB7LMdUXfJkWqhtZ/p
	 jsZfyvYB0EK6UOE3ZpVoWa0QxClHvP/cpjGcVfh1XkmWqTz3Wughy/eq1OoAp8oE8o
	 uBYUUwkd9HoazDyTiViz6yqgSALttMYNkrEXFo1FaHpCP6AkKWcgTTSy19BqYm7N/B
	 ceMn/dQKN9YwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] serial: sc16is7xx: use guards for simple mutex locks
Date: Thu, 20 Aug 2026 23:59:19 -0400
Message-ID: <20260821035920.2524947-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821035920.2524947-1-sashal@kernel.org>
References: <2026081754-ogle-alkalize-4f27@gregkh>
 <20260821035920.2524947-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 0f4f88bfd7e7bf3f3293045fffdc63586b0a889f ]

Guards can help to make the code more readable, so use them wherever they
do so.

In sc16is7xx_port_irq(), labels and 'rc' locals are eliminated completely.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://patch.msgid.link/20251027142957.1032073-6-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 246ac114f485 ("serial: sc16is7xx: enable THRI before filling TX FIFO")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index f9d4aaff6239a..b534a830ab2a7 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -11,6 +11,7 @@
 #define DEFAULT_SYMBOL_NAMESPACE "SERIAL_NXP_SC16IS7XX"
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -779,18 +780,15 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 
 static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 {
-	bool rc = true;
 	unsigned int iir, rxlen;
 	struct uart_port *port = &s->p[portno].port;
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	mutex_lock(&one->lock);
+	guard(mutex)(&one->lock);
 
 	iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
-	if (iir & SC16IS7XX_IIR_NO_INT_BIT) {
-		rc = false;
-		goto out_port_irq;
-	}
+	if (iir & SC16IS7XX_IIR_NO_INT_BIT)
+		return false;
 
 	iir &= SC16IS7XX_IIR_ID_MASK;
 
@@ -830,10 +828,7 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 		break;
 	}
 
-out_port_irq:
-	mutex_unlock(&one->lock);
-
-	return rc;
+	return true;
 }
 
 static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
@@ -863,9 +858,8 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 	    (port->rs485.delay_rts_before_send > 0))
 		msleep(port->rs485.delay_rts_before_send);
 
-	mutex_lock(&one->lock);
+	guard(mutex)(&one->lock);
 	sc16is7xx_handle_tx(port);
-	mutex_unlock(&one->lock);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -932,9 +926,8 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
 	struct sc16is7xx_port *s = dev_get_drvdata(one->port.dev);
 
 	if (one->port.state) {
-		mutex_lock(&one->lock);
-		sc16is7xx_update_mlines(one);
-		mutex_unlock(&one->lock);
+		scoped_guard(mutex, &one->lock)
+			sc16is7xx_update_mlines(one);
 
 		kthread_queue_delayed_work(&s->kworker, &one->ms_work, HZ);
 	}
-- 
2.53.0

