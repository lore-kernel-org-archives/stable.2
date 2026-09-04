Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE19B476072
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531801; cv=none; b=J5DESx8zep71zhNhRkhcjRHVE4sC3EDAX4Z24MDBR6EIyg7xdAy/7qdjuy1ocPtWYF5W081+dtbkXzW1JvvontQTwDd/Or3/38aj810FMP9a3KdGIGOamiFwYG2lXxHPmVb3bfiORgUtTD9D4Q5VCtSDukjPFKkiW4Y6AjAUuUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531801; c=relaxed/simple;
	bh=X48ysqbvYnFnU8JRevRhRCWQfQFxt0K6vvUYeq2RphU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukPLt0leOc2SKwUdoW4ru8+rMRVIoJLnaDyRjR6qsHCQ6PceA15lIdhqPB8/Nw4wDvK8UwdiQOxvDHVoSUFm9OKXqb4+i2IKpRf2+Dv9KcIlyl91JCvflofAqe1XZHQTBokvoJV1gh0hMy6a21ql1O/Xw96/bfOV6TOMfQTD45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMGLlJ1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMGLlJ1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DD51F00A3E;
	Fri,  4 Sep 2026 14:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531799;
	bh=9W/ey3gKoJqWcPrP+9v62XtMrpgI/8bNQRrlgabz1EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hMGLlJ1DH0VyGgiU8ICd4vzpCiqpzTEqSF10tQGOVS4IZw1hTAEP6hOdOAHC4FW/T
	 KytH1lT3psT/O8YSZdAYkMrJaIMHqBVl5uUBoidABQDWxm0yRJfwgAn3VDYOEIuZ7a
	 tnBguIINe4s9K5bHYGGPdLum7Y0CectiYOjnLdbwp0Q/jaujzOjcGP4d/8K2+Eo4hN
	 zL9bf+mIXo7IkPPU04yXUuqDcNuTjV3cXQHfbhdPRttbnWXTN+lbz/MW5Kx/qpy/MM
	 4dcSMVeq58L+gMMINUDqwd1JkIGVCNp/h3NFqwiM6tyn2Rvlrqu0zLf3agKhUrb9b1
	 r8f/xzdS7aS2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] serial: imx: serialize imx_uart_ports[] lifetime
Date: Fri,  4 Sep 2026 10:23:16 -0400
Message-ID: <20260904142316.780585-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904142316.780585-1-sashal@kernel.org>
References: <2026090333-applause-active-107a@gregkh>
 <20260904142316.780585-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karl Mehltretter <kmehltretter@gmail.com>

[ Upstream commit 8b0b29fdcb47907ae0296b8fe829e918e05e300f ]

imx_uart_probe() publishes its devm-allocated port in imx_uart_ports[]
before uart_add_one_port() because console setup uses the table. The entry
is not cleared when adding the port fails or after removal, leaving a
dangling pointer.

A sibling probe can register the shared console through that stale entry.
This was reproduced under KASAN on QEMU mcimx6ul-evk by unbinding a
sibling UART, unbinding the console UART and rebinding the sibling.

Keep the entry valid through uart_remove_one_port(), then clear it. Protect
port addition and removal together with their table updates so sibling
operations cannot interleave. Reject an occupied slot rather than
clobbering an active port during a duplicate-line probe.

Fixes: dbff4e9ea2e8 ("IMX UART: remove statically initialized tables")
Fixes: 9f322ad064f9 ("imx: serial: handle initialisation failure correctly")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260719162850.043B41F000E9@smtp.kernel.org
Link: https://lore.kernel.org/all/20260719222501.CB4CB1F000E9@smtp.kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260731181844.11330-6-kmehltretter@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ replaced guard() and scoped_guard() with explicit mutex_lock() and mutex_unlock() calls for GNU89 compatibility. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/imx.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index b558cee2966f3..329b72f648fa3 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
+#include <linux/mutex.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/rational.h>
 #include <linux/slab.h>
@@ -1987,6 +1988,9 @@ static const struct uart_ops imx_uart_pops = {
 
 static struct imx_port *imx_uart_ports[UART_NR];
 
+/* Held across uart_add/remove_one_port(); console callbacks must not take it. */
+static DEFINE_MUTEX(imx_uart_ports_lock);
+
 #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_uart_console_putchar(struct uart_port *port, int ch)
 {
@@ -2455,11 +2459,18 @@ static int imx_uart_probe(struct platform_device *pdev)
 		}
 	}
 
-	imx_uart_ports[sport->port.line] = sport;
-
 	platform_set_drvdata(pdev, sport);
 
-	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+	mutex_lock(&imx_uart_ports_lock);
+	if (imx_uart_ports[sport->port.line]) {
+		ret = -EBUSY;
+	} else {
+		imx_uart_ports[sport->port.line] = sport;
+		ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+		if (ret)
+			imx_uart_ports[sport->port.line] = NULL;
+	}
+	mutex_unlock(&imx_uart_ports_lock);
 
 err_clk:
 	clk_disable_unprepare(sport->clk_ipg);
@@ -2471,7 +2482,10 @@ static void imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
+	mutex_lock(&imx_uart_ports_lock);
 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	imx_uart_ports[sport->port.line] = NULL;
+	mutex_unlock(&imx_uart_ports_lock);
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
-- 
2.53.0

