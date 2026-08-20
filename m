Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA435E93E
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264886; cv=none; b=IXHsk8JWS++2to0vMB0GP/y+3qJ1XSjjAAtRi6E/tA9zGnXHen94nyLIT5cfFHHAKH2WRL6dUhL34Huml0LPsmlEqgGR7KXTfKyxrTLW3LRosz+menB/BrBBasNCAIW93qXVHjQZAv9pwn+ajQJfcV5WNb2i41BqukloRWTpAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264886; c=relaxed/simple;
	bh=jEQkHOe353UbMnTHbbkJuB/M7CC7RAz14L7buqoF3sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fG3ZBJKsBqQv0lYQ9+PuPHGmsARZo3vjo9FFVB329+bQ+UaeRLqwCkT0q7h3yIbPQPjlWXHyJbZJQ5OviiDk6+KVzFTyjbJZG/7qrcIlxvxrFIs4MGDQND+AkVefrPxWDsyLDf8vK+SGa9Q5vjUfwcOXYuNDIBJsSBut0V3I+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCdPrjpf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCdPrjpf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DCC1F00A3D;
	Thu, 20 Aug 2026 22:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787264884;
	bh=eUuSqjmEcC8o90tVYGFC2vTVb4XbXuAm0Jc0RkX5+dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oCdPrjpfjp5BEodeTPKgptQ9wOzQoLJ14pz0Gut6SV2UMFKneN80hqCd5J4ZLJV9A
	 rrCVgzr1Qv4f4/KTXff6co3pkrSz/vKLVMJspe0yx6ruArO0SkthU/zfTv/6hecXoN
	 gNnN6UaKn3io+yc+FO4QMaC+x6t6pO4SqaX7WKpwxKHYvKHV/JJgLpEOhfxljJOlYr
	 MLnDxPd2CGZLpvyXVGBa6ftjC3OJjpjr2wxcZ9yo5xYO5a2xQHd6xsiDzWqdzleepP
	 lR26nZgX0MbjCGEgU9DT03UOBi2E4jes8kyefxap4UaiV7Z/aZa+5m9GmtyW2caAhJ
	 J4UkIAtSdfulw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] serial: sc16is7xx: use guards for simple mutex locks
Date: Thu, 20 Aug 2026 18:28:00 -0400
Message-ID: <20260820222801.2320182-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820222801.2320182-1-sashal@kernel.org>
References: <2026081753-ebook-finisher-4e66@gregkh>
 <20260820222801.2320182-1-sashal@kernel.org>
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
index a890b0da58947..8fcfc8b322d10 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -11,6 +11,7 @@
 #define DEFAULT_SYMBOL_NAMESPACE "SERIAL_NXP_SC16IS7XX"
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -782,18 +783,15 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 
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
 
@@ -833,10 +831,7 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 		break;
 	}
 
-out_port_irq:
-	mutex_unlock(&one->lock);
-
-	return rc;
+	return true;
 }
 
 static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
@@ -878,9 +873,8 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 	    (port->rs485.delay_rts_before_send > 0))
 		msleep(port->rs485.delay_rts_before_send);
 
-	mutex_lock(&one->lock);
+	guard(mutex)(&one->lock);
 	sc16is7xx_handle_tx(port);
-	mutex_unlock(&one->lock);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -947,9 +941,8 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
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

