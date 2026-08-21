Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67B47F2C8
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310015; cv=none; b=WB7NAFbEHc9knOH5GAnxZWXYXM8AZutglNikNokMDVgUWN4uLtsSW2B5uvmuJiQvMyLYlN8ZAJvvRw3OPLLOuvvgjTFXTMToj6pGmB7gZA3u9A80KzWmm0Ouu43pm7uxfklS369XNhHAQmoKbJN6lZEn/z5gVr6fFXqi6I4OZ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310015; c=relaxed/simple;
	bh=feZBZbP2krK0y+LfcjOENcp4mqctyGoPSTOHkEnsfQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vELTUaw8Iimg3alXQnKPowmKnpbk2xp1DjU7U8DQ/giT6KQHdXkw7TEU4iyMgHl7OF1TvTNyeAYJ8FnamZMSQtE8uYwEWV2tt4GsLgSQdZ85cDNmCY1J962bsKSIzA3S35gI25Y0RoFtFOK+HzJgVeVmK79f3fRkPpQIkVH+QL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG78Jl+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG78Jl+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD9D1F00A3D;
	Fri, 21 Aug 2026 11:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787310013;
	bh=sNSztu9GmNjjZkXsWuEsA+QKLZ/UiHWcK27d12aif+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aG78Jl+WzwJPiO8ls5ACLb5KfEpFn6KSjMjEKtsOOtrUk32IZ8PM3SLH4trkZafWx
	 ISOKya2RU5mKOGFlfvE82MWEWxobM1yyZ7+MqFJqJ0MticfZDnZvzKVKs++U8FybD7
	 zZJ8PP4qXthi0D9pw+GpZcCwQ+uJo82mTkyoMrZSzyrmzPbsbTnDSJ1Z9NMqEc6g0n
	 Z9E6gqzltx97vh5qRMUBD2BbT4jDnkaRm1H1bFztejnStLvmwh1pwVoVIH2Nb2f7W4
	 pSaMu7Vrd2bawzvfk4FVysc1C8DEUCpjVjIUtbKTP7ElAPFJ2TQBcbpOIvhyfG8GDc
	 nul4cxHMIo9dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] serial: sc16is7xx: use guards for simple mutex locks
Date: Fri, 21 Aug 2026 07:00:07 -0400
Message-ID: <20260821110008.2816500-4-sashal@kernel.org>
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
index 694e3d78d6e78..d73bd07c864f1 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitops.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -791,18 +792,15 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 
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
 
@@ -842,10 +840,7 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 		break;
 	}
 
-out_port_irq:
-	mutex_unlock(&one->lock);
-
-	return rc;
+	return true;
 }
 
 static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
@@ -875,9 +870,8 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 	    (port->rs485.delay_rts_before_send > 0))
 		msleep(port->rs485.delay_rts_before_send);
 
-	mutex_lock(&one->lock);
+	guard(mutex)(&one->lock);
 	sc16is7xx_handle_tx(port);
-	mutex_unlock(&one->lock);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -944,9 +938,8 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
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

