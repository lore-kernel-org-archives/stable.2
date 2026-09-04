Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871492C11E7
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522485; cv=none; b=KTQ3FnPUluX6QoYhMQmVsWaTj5RPmgqeO+jkDNXpDEDc7sbdz3YoQk5GQ57OmysZ3CsDLxPeAdp2jwj6ZjUEFLnB++zC/gFFyf2GRRW8hy7lJIXhyiTWcezaPv/OQtwBpKDLXhV77ukkOsGn0mcrYWd4zqt0fBu3QE4KIeTg9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522485; c=relaxed/simple;
	bh=sYPFimC5DEPxOmi8QALfaX+DFvMdAtG8zzZbNpTjkvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMYC6FxkblicPfSUg0QFTdITplEtH+88dPu9BD0rVjZnssBe28ZBjbVlESDsl1sii/DUX6HC9qIleW31HIX0BmBOiRF0u/UGYDwUBYAVX4RcJvKsnE4+J6QX0Jr5hA/mipUsqfTLxNMCMBjGAnfiseNm/KbCOMMetPikX0Twin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXnm8AnW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXnm8AnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890D41F00A3F;
	Fri,  4 Sep 2026 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522484;
	bh=IfsNr3sHv2utiNOLa+F4UAyovP/OHSx+35mMtV2VVYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OXnm8AnWWutajPIsDxdfDMog4RZJPL+W5kbiwfOWvZXVISwl0zZS3lrb5wpjfhkkn
	 YBSuowRvCQ3yChWLCPBHrVMoDjSAnrZL1Nlsjczq8QzV3zMKlaR7/hfXzFTT3ZVbrY
	 jE5EOCplcvt4k56m7gyBbZ4oynTQjI5oGZhpcOqOyeaft53G7+2Xpj32faW5ZEbhrB
	 zs1QKsyxHGSxGY+Mqh31V1PJF/0uThRH8XXKYrc0cuqH1Q9pFne9lYQm5j7dQjtc8a
	 e7TZ088qeyj8yOybPsBcJownk/JuwKBqhF+8169LRlHuYyPUx5EBwSTJ37o6Gw8QMQ
	 TzhT4M+H1QkFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] serial: imx: serialize imx_uart_ports[] lifetime
Date: Fri,  4 Sep 2026 07:48:00 -0400
Message-ID: <20260904114800.3757105-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904114800.3757105-1-sashal@kernel.org>
References: <2026090332-deputize-flying-c9c8@gregkh>
 <20260904114800.3757105-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/imx.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 020ede9568af4..fccba3cb9d5a0 100644
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
@@ -2037,6 +2038,9 @@ static const struct uart_ops imx_uart_pops = {
 
 static struct imx_port *imx_uart_ports[UART_NR];
 
+/* Held across uart_add/remove_one_port(); console callbacks must not take it. */
+static DEFINE_MUTEX(imx_uart_ports_lock);
+
 #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_uart_console_putchar(struct uart_port *port, unsigned char ch)
 {
@@ -2522,11 +2526,19 @@ static int imx_uart_probe(struct platform_device *pdev)
 		}
 	}
 
-	imx_uart_ports[sport->port.line] = sport;
-
 	platform_set_drvdata(pdev, sport);
 
-	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+	scoped_guard(mutex, &imx_uart_ports_lock) {
+		if (imx_uart_ports[sport->port.line]) {
+			ret = -EBUSY;
+		} else {
+			imx_uart_ports[sport->port.line] = sport;
+			ret = uart_add_one_port(&imx_uart_uart_driver,
+						&sport->port);
+			if (ret)
+				imx_uart_ports[sport->port.line] = NULL;
+		}
+	}
 
 err_clk:
 	clk_disable_unprepare(sport->clk_ipg);
@@ -2538,7 +2550,9 @@ static void imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
+	guard(mutex)(&imx_uart_ports_lock);
 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	imx_uart_ports[sport->port.line] = NULL;
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
-- 
2.53.0

