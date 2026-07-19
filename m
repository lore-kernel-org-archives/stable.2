Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9392F31327F
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784499055; cv=none; b=EyB/6aCeaoWjbgnNutKQ8wnbZCZSnplpPdEBkzo3tYM/7QhSRVYuDhGFN1U1qK0WtnSiLPwLUIT1Q6T+SfK3BQdiSxvbyeCQnZ9A0j2bKG32OQmOPi/j+HjgG0QLPign/ijnarHr8c64GnnIAJxtjuDhgYJB+qHc20njZ1M9dL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784499055; c=relaxed/simple;
	bh=e/TsC2jyQghy+fHjzGFRoV6KHp39YYSJL7Ig0TqCdS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rE3sgQkm+QezIEMUgIkSgFDP91eu9ISvUkoYIwwTbkEENLFJLJyjG4/LEBd/ptOFiT63ivYrn6tVlrM1E+PAOLUMzBlgrwnWM+B0CEi8IlbvNTjdjX27bZL/hNTn5W3HLp/IX7cupd8ojokB2OSFtZDVJXgaVQWPSXXzEyXqcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFVxb1dW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFVxb1dW"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4955e639f5dso2368745e9.0
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784499051; x=1785103851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3PWe1Y8pYuAa7B+GagSYE8D0P3UeZCJcEkhdzL5G7fY=;
        b=CFVxb1dWBYUtUYBD2MKGawFay9IOV2JUYjaW/oPtAcQCtENU2uAL/R21mLOWsV8xRf
         BAmHnND+Ml5I2QI6ZmNPV1q7Y7EztOjetIieH72FZazQv4gFd6IpZT/2Lv2mNzUhzQtb
         pkswJGtK0HbYud9SIRyzfp3qjISSkFDInqlG0KSunTzOcQIpgHpTQYammdZlfZJbRtxj
         wH4a4idmuHt5h2gTvDrq8Xlg7qQhx0buq3NxdQbFrbZzPiuDxoaVIabXLBrdGtAYLrtK
         fywCUGVwuSl12/smI8SFwC6qObd3JxWfQnMbNr7fKAt1yhk/aPtXC5JdkmI7JdR8qeCa
         JThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784499051; x=1785103851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3PWe1Y8pYuAa7B+GagSYE8D0P3UeZCJcEkhdzL5G7fY=;
        b=A93qG6YNPAsxfrP9osYMKzUtXbrkc77T48I2GHuqN1kl5FrA+sYXGx0ik/GA9u0TWB
         DYPfcMABUkkqJX3yoysB7+Iuu/9vjqLLM/N9NJh0K/lS14O3jokmHK37ywndiC7fUcd7
         +NSbp6wv+k5Ax/pP4irS98m3hM1ShDT9EynwqAXzUR3PT2U0/zwHOx+n3WaEfinyDxeU
         IABHTLK88F4+yGpEzUSI8uzSlGjrVrT6rg49IKxCvgMfXD4o3VbzcNCpg6yfrZKDqt/1
         z7iNkY8mjBzS6DDcnMucjpWuAfoTZKrO4iCHZvYWXl2CRQe56cXVV31Wz67H7HEqcGS1
         FPNQ==
X-Forwarded-Encrypted: i=1; AHgh+RozS6J4CAOrdMGBVToJiHFQMPwFw9qVqR+Uzp3FClWJOmJW7P6qIhXOESHiwRc34spF93pijoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRsm+XTDWb7ZeoSGbnpyDRmuDGjNf/9bGfydEjvVUtZB8O7Vn4
	WGQzQlccZ63dEh6tEc7kkWn48xpUeOq5wy3ezPov1TqacmLngzIDHjGz
X-Gm-Gg: AfdE7cl1QM4bkS2IFWCDACF5EH2e94WHy3tZNh9DiaGFJcfQTMDfGcb5x3jwfs/bRfC
	PErmxKagR0W6Y8oaYjxXo5OZCyhZXfJsMchqkRA7LsiiSCIjseb4i6VeesbZi9YcKop7VbZb5QM
	4lzYTcXu3csyAPBcN7UjmxDLhgXNODlUoclS5tDg29CLnV33JuLb47Zdyw7sdgvNihywpLeSSTA
	I4hBjWe2vlOQ1gpEeUt/OKmERAHSmY96II0D4XDCa/d+htwOuB92aXF5SAE4JbC3CIIeoX1a0gP
	4PFk9u5SBmwW3h4QXG5sZciajtjyp/jIIp5bXG+P1GqlBpUwoLLtFMsr/UXPYAQUMw4uNJKdDdW
	/rlKaP2bBkP73G7WdX6uK5nvbtsf1DpjYFlZHDewcJHnoWF76wKuJXtqnO66ha48gt6Ki046P5x
	zyw5pN9qt0gkQ6b52B3tGAYKzVng24rJxxEjqsaQiz8Ip3x3QZbfVe7j9TWyHuKk/61qi9SlXN1
	7M7pIH/bTS5sGbWMj17wnp88O2YbEYG60C+OcmtOAc0ofy0/wbC9S6MQL2zV1aGj5wABOnTbiYh
	JlShrbXY/g1pYgymTJYRfmN8irQMVrilP/U=
X-Received: by 2002:a05:600c:1f93:b0:493:c8c6:4989 with SMTP id 5b1f17b1804b1-4954a3d64d4mr124694595e9.6.1784499050684;
        Sun, 19 Jul 2026 15:10:50 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955370d78csm114492445e9.12.2026.07.19.15.10.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 15:10:49 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] serial: imx: serialize imx_uart_ports[] lifetime
Date: Mon, 20 Jul 2026 00:10:14 +0200
Message-Id: <20260719221014.44354-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719221014.44354-1-kmehltretter@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_uart_probe() publishes the port in imx_uart_ports[] before
uart_add_one_port(), because console setup during that call uses the
table. The entry is not cleared if adding the port fails or after
imx_uart_remove() removes it.

The port is devm-allocated, so a failed probe or unbind leaves the table
pointing at freed memory. A later registration of the shared console can
then dereference the stale entry. Reproduced on QEMU's mcimx6ul-evk by
unbinding a sibling UART, unbinding the console UART and rebinding the
sibling:

  BUG: KASAN: slab-use-after-free in imx_uart_console_setup+0xd0/0x3d8

The entry must remain valid until uart_remove_one_port() unregisters the
console. Clearing it afterward without serialization still races a
sibling probe: the sibling can register the shared console using the
dying entry before it is cleared. The next console write then
dereferences NULL.

Use a driver-wide mutex to serialize table publication, port addition
and rollback with port removal and table clearing. Console callbacks
remain lockless because uart_add_one_port() may invoke setup while
probe holds the mutex.

The probe-failure path also relies on "serial: core: do fallible
allocations before the console can be registered", which moves the
uport->name and uport->tty_groups allocations before console
registration. Both changes should be backported together.

Fixes: dbff4e9ea2e8 ("IMX UART: remove statically initialized tables")
Fixes: 9f322ad064f9 ("imx: serial: handle initialisation failure correctly")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260719162850.043B41F000E9@smtp.kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/imx.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 251a50c8aa38..def874f9cd00 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
+#include <linux/mutex.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/rational.h>
 #include <linux/slab.h>
@@ -2080,6 +2081,15 @@ static const struct uart_ops imx_uart_pops = {
 
 static struct imx_port *imx_uart_ports[UART_NR];
 
+/*
+ * Store the port in imx_uart_ports[] before uart_add_one_port() and clear
+ * it only after uart_remove_one_port() returns. Console callbacks in both
+ * calls use the table, so this mutex serializes these sequences between
+ * sibling ports. Callbacks must not take it because uart_add_one_port()
+ * may invoke setup while it is held.
+ */
+static DEFINE_MUTEX(imx_uart_ports_lock);
+
 #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_uart_console_putchar(struct uart_port *port, unsigned char ch)
 {
@@ -2632,11 +2642,14 @@ static int imx_uart_probe(struct platform_device *pdev)
 		}
 	}
 
-	imx_uart_ports[sport->port.line] = sport;
-
 	platform_set_drvdata(pdev, sport);
 
+	mutex_lock(&imx_uart_ports_lock);
+	imx_uart_ports[sport->port.line] = sport;
 	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+	if (ret)
+		imx_uart_ports[sport->port.line] = NULL;
+	mutex_unlock(&imx_uart_ports_lock);
 
 err_clk:
 	clk_disable_unprepare(sport->clk_ipg);
@@ -2647,8 +2660,12 @@ static int imx_uart_probe(struct platform_device *pdev)
 static void imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
+	unsigned int line = sport->port.line;
 
+	mutex_lock(&imx_uart_ports_lock);
 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	imx_uart_ports[line] = NULL;
+	mutex_unlock(&imx_uart_ports_lock);
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
-- 
2.53.0
