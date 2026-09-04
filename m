Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B0D4078F4
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522064; cv=none; b=ETHeRFNzu2iZuMdjiCvT9HotkyUiP76vTaBqrqU8E3lcgepbwfL1aCyFaAV2dDfxAjcsJol+RmFUV6eGXlVmhrKDqlzcBErILc+8CfQacczNSQ9+LFsBpH+n6gGe+xo7hJC95HMP8VKIq5ILZY4bgUThG8cjUWNE8vRpRVZg9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522064; c=relaxed/simple;
	bh=S7vIQvfdSoKEZcoRYuV/f865ImybKNSp0PhtaluwhSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdbI6FHnSAcbs2E5Qh+JCoEU9Qelru1pjidEYA/6UaF8OgdvtWtfRInVBwJPwzmwcxG3rCPvVUwNoe2JxiELsQ5KDGNTUjhq96Id69UpsWVR3WCj7dnwHe/QcGR7K+tDKtoWGCal3LbhvBryZ8+u5kmU5Hss1bIyaE5+bnY8BH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5nOmoAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5nOmoAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5141F00A3F;
	Fri,  4 Sep 2026 11:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522062;
	bh=JM0Jmku4uWCeGUVEKqLovRQByHqUgH96EJfIMUmrDuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R5nOmoAfHSd0vIYNeU3lcZrylC1GQM04seqHVBO6RuEC/TxrgyazXxHW5M0GM3hrI
	 Z/Apo/rHe1FNYDnUSbOv76Rgog2waa64yTfvfF7H4iucVLUptQ/C6BCCbT13H3ABXC
	 nmN802n+27Rj6wIkeGxW2w7Xu9cTLtwTbHXu1FjtyD3i8Qm7rMR+Cz5V/mHnnk+INR
	 04XpK+UTrQQeUZfrlOFJhsa1+xOk7837bC7Au0Ae04EeemZd3KLX8c6jAY30jUDcyY
	 9VBbOyn2yE5SJxxZA2fdV8d0AIOTSrv2tWu4+LbdJKgW/pw6ez9nLGwoiESUrNnSgN
	 ltnqgX1rC66Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] serial: imx: serialize imx_uart_ports[] lifetime
Date: Fri,  4 Sep 2026 07:40:59 -0400
Message-ID: <20260904114059.3685169-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904114059.3685169-1-sashal@kernel.org>
References: <2026090332-sizing-praising-4243@gregkh>
 <20260904114059.3685169-1-sashal@kernel.org>
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
index 11d5fa8249f28..8e8391d879a3d 100644
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
@@ -2018,6 +2019,9 @@ static const struct uart_ops imx_uart_pops = {
 
 static struct imx_port *imx_uart_ports[UART_NR];
 
+/* Held across uart_add/remove_one_port(); console callbacks must not take it. */
+static DEFINE_MUTEX(imx_uart_ports_lock);
+
 #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_uart_console_putchar(struct uart_port *port, unsigned char ch)
 {
@@ -2490,11 +2494,19 @@ static int imx_uart_probe(struct platform_device *pdev)
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
@@ -2506,7 +2518,9 @@ static void imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
+	guard(mutex)(&imx_uart_ports_lock);
 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	imx_uart_ports[sport->port.line] = NULL;
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
-- 
2.53.0

