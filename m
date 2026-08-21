Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE33DDAF4
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323780; cv=none; b=DZGTSM9Q7HtmFLpVVskJY7flfmyLRueyB7GDOGycc9DBxNlXOY16hZoMZnjv6U3Nbekvu8WIYwhZ5NjDgqzh3T9Amj9Tznf5XkikzFQXMKzw2nIEK/JnRDTRQH8NhVFqjLQmPWWFNNniiQ4TOYPo0yGjT6erCa1RCuZraGebdic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323780; c=relaxed/simple;
	bh=SZrUBnUtgCncIhr67NAbenP/jOWj0Fxsavisplo0nVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmbHBdoi0Ow7nX+tA0295j2dG9Hql+PtnZkoZrcvF8O/TrzwNl4OKkkpiKaAT+c6KAXqqaJbkZy799q2mypviNh6omd1H013ym7RIvVzRQY5tJKF4+oDKcnjQ3jWRPuiLTrmnweJMeMQlMWkOmSrqogwraxkQK8H7uJQ2F/0yag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcRxOYzi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcRxOYzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EFF1F000E9;
	Fri, 21 Aug 2026 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323779;
	bh=3LTrdkRnZeFkQKUH8cClbynXos0sQiaA+FoeGFMPKQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NcRxOYziLHhhCTJ9t1204EdKY+XMcxYkUCPV0RPZMQpMZJmntWT7Ggh/Har2eM22J
	 FGNfEBBJ3mStzEtsNtsyd0Vwiknkpg745xIm7vEz59wyEz+hhcN9QNBjP/Ih+yPnN2
	 ZYb6fFXqbav6ZTAalwlhUfgqXONReDM5S2qBGoxq1r6D0VH6EaPn1Bk+fCTwykb2ho
	 shMfrMtPNqj1aK/jxcQ26l06yVJf+c1geEkfyAVpsERN/tcY6QBqJRIUncWzAQ/Snn
	 0hHBmntvWLzddU0lS+RmfE2rEmrPzhBvLwiLGC5+aK7u2VlU6ex6ptkGEGCcxbbHRy
	 19kkaSomfdo7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] serial: sc16is7xx: use guards for simple mutex locks
Date: Fri, 21 Aug 2026 10:49:33 -0400
Message-ID: <20260821144934.3428649-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821144934.3428649-1-sashal@kernel.org>
References: <2026081755-unbaked-recycled-24ab@gregkh>
 <20260821144934.3428649-1-sashal@kernel.org>
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
index ad2a4f19686ae..cdf24617cf10d 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitops.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -794,18 +795,15 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 
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
 
@@ -845,10 +843,7 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
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

