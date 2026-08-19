Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AED3559CA;
	Wed, 19 Aug 2026 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106037; cv=none; b=IzsSTf9SQM1C3FpW5QgjrOVtx3XfliEWtyVTSKR4ENOgpadRoQ5B87YYrmB8GmEDA4jwkAJbWKB4rJebastImHXNPeuvG2DdoQl3A/oonktVw9SnmUa+uwmMVEIE9jW08GKHF40KGVQvJZ0zBmYEcVLSRSuwY6wikZK3/m64SGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106037; c=relaxed/simple;
	bh=OXEufZy6jRZLSh8G4vNttI4g37voPQPxQMaRI9h5bR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mshWS/fm7I8zXzJnCdf0LqA6Y7HbWEZWShyB8wnfLW3wDp6J8hjyn0v01ziG0i3O84iZe4Y7ciIXyzJy8ctJoMCTzxArqGgzL6uccsr6Do0jV/CHjc6vz4g3nu7BI7yDJjShEFYHFSxyMpzIAUYf7BpiTCCDIMd/F4mIN7DpfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wC3gX3bEoVq7JmmAA--.42198S3;
	Wed, 19 Aug 2026 10:20:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgCHiaPbEoVqNqb7Aw--.26282S2;
	Wed, 19 Aug 2026 10:20:11 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] serial: imx: cancel RS485 trigger hrtimers in shutdown and remove
Date: Wed, 19 Aug 2026 02:19:16 +0000
Message-Id: <20260819021916.442827-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgCHiaPbEoVqNqb7Aw--.26282S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?hwMz9wXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBFqHGffgUj/kiZ79lR96Dn6tPZKPn6Kv4uFpy6/Kyifm6gz
	W5tHy1KOfp+zmAq5OVip9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw48Kw4xXr4kJFWrCr47Jrc_yoW8tryxpF
	Z2gr9IkFWqqa1SvanrAF1jgFW5twn3AFW7Gr1xGa4Fv398JF1FkF13KFZYvFW7t34UtFWa
	vr48tr4DCFZrtFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

The rs485 delay hrtimers trigger_start_tx and trigger_stop_tx are
embedded in the devm allocated struct imx_port, and their callbacks
reach the port through container_of() and touch registers under the
port lock.  Nothing cancels them synchronously: the tx paths only
call hrtimer_try_to_cancel(), which does not wait for a running
callback, and the bounded wait in imx_uart_shutdown() can give up,
force tx_state to OFF, and leave a timer armed.  After
imx_uart_remove() returns, devm frees the port and a late callback
dereferences freed memory.

Cancel both timers at the end of imx_uart_shutdown(), after the port
lock is dropped and before the clocks are disabled, and again in
imx_uart_remove() before the devm free: serial core does not call the
driver shutdown on every path that reaches remove().

This issue was found by an in-house static analysis tool.

Fixes: bd78ecd6056d ("serial: imx: use hrtimers for rs485 delays")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/tty/serial/imx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 251a50c8aa38..86c99f73c50a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1707,6 +1707,10 @@ static void imx_uart_shutdown(struct uart_port *port)
 
 	uart_port_unlock_irqrestore(&sport->port, flags);
 
+	/* The rs485 trigger callbacks take the port lock and touch registers. */
+	hrtimer_cancel(&sport->trigger_start_tx);
+	hrtimer_cancel(&sport->trigger_stop_tx);
+
 	clk_disable_unprepare(sport->clk_per);
 	clk_disable_unprepare(sport->clk_ipg);
 }
@@ -2649,6 +2653,10 @@ static void imx_uart_remove(struct platform_device *pdev)
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+
+	/* Serial core can reach remove() without calling the driver shutdown. */
+	hrtimer_cancel(&sport->trigger_start_tx);
+	hrtimer_cancel(&sport->trigger_stop_tx);
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)

