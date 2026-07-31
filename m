Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1658A3B6BEE
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521126; cv=none; b=pksudpTwBWpHaU68EjFhB9kOXRuF7EMTcmjpKERQA4JGf+7iNxXwjlkX+uypbu78EGeG+OnAzHFPHcimS5kbJeE3hwJ5LXd27vcb614oGqWmTgINSmyrzpclTlZEXQaN5kkcEOHRESXw4Vgjuf86857r8YQJ0ekfqe5J8giub+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521126; c=relaxed/simple;
	bh=PsKOHHQKdkTPVr5CbgWuTRjCZmIzAuWQ/T5zBgCOXzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fT1vb8+Y+WdsFJ79UCErt68y1Hz4pXI1qrZhvG4M76tKQ9itzuNDYr7hXJDkqYN4B/pcA870WEyClLwLaVALeaqRbE3FPm4fWAIibVg3/M0rEtP7mo5Fb01G8hcZjFpB3cGZxc6VznyUgj8KOrJtN+s9RfAEMDQsHb8HVWsvXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRUYLd+X; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRUYLd+X"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47db714766aso1463520f8f.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521123; x=1786125923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6m+8w0QVgGm8urXe/cU07WfU5xAZ+QJVFPsiFH0egMo=;
        b=dRUYLd+XZDObOfJu7MYRna9XibQmadJYmxFq3QwgpDohKY40cTu72fcHSnYtooKM4F
         Cu5OBIrI6PcZvhnuHRZ9X4mTK67hgeLzdWDzor82yCM0g91xT4qYpiZqGxuRu0H0ONIC
         q5dcaSUmIzQ7N2piCxiK3SluYjRe18qUvQJICwNFyIQGnfu6nFT7pQlQb02WD8BIQnwJ
         up0e4aKM3TcYSRb5gcJlq6bpLSxGYEbbhKPXSepErqLyIKtBeIcPHowq19wX3sQ0q07Z
         2/H0F41wezJbcJRnMNYPq2ddHQwp6mQdHYXzERsrRxeGrE3/7NfyWHxmRv70S9e19BX2
         JsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521123; x=1786125923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6m+8w0QVgGm8urXe/cU07WfU5xAZ+QJVFPsiFH0egMo=;
        b=Ud9jNID113/q+CCxFabqGr04dMbQd/8BH0x2vdFtEQP0JLBAz8UQVL6aQI9In7kxD4
         BGdmtO1FiiVEkK2K1IcDYrkd9FypFwX/cyyhsgUCaj4zorsKBkF4PJmKKE4UKQCw5yXD
         iHYQrjC47xUqKNmPxm1xqeXN8/D9l3LTqTR6M3HWLgXUhpURq0hxpbCjbgx9+1Ytb5C2
         3Dn8c+o9CKs+zBTPIBq5g4FoDyNquul6m4SBOvrHGvm7OqyyQTEuVNIuT0XD+sVyC9Ur
         OBuqEF1WOMU3d7S62teLiALBh1sfC+Q9JteRQxNxeuLkWyAkA2R1qwzHXjOAzy3s2oce
         xNUA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4F/vZCt99GdxCPWitlrb3B4+HEcktNbra/LFJ1JJuz8uMsTQpTC17bLvVxxnTYhI3NESsyrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnbHnYuBJYRFDLxs5oOKEDgQD3emb7J6t8r0tVKTpVlPFr1fYc
	jnYy6a27pKOYSZx59PIYUPa/h5RfoTOZbj13qykupnsnsv0T0FZXf2+u
X-Gm-Gg: AR+sD122Dz+sZc9+dDkkYe7t4Nx+U8W3S0GiFzSILIfJdpQTnRhGeW9ZV8HKs8BOrAU
	CHk9OjEH/tipkY1tZdE/ZvMI49+CGj5MFwfEUvOixCAO3JoebjnHVsCywVwEtLz7z8ZP9MYkt0S
	zwKAl3TvZVbXkhlUEjSGp2tMSVfDgeCEEjPl3fOVEEe5YrOkrcNMgnYx09iR/JFEQUuxzNyllx7
	CIYw1zpalRoyv+qdCRrqHET4MxOgFYq+XVnVNZNe3JayEjYldWRGrnP5RwdxmJ4kkJAjZF/ZxZC
	EpRvMJxkZcizCqD07J9VJvpXnuu4WPDsZKwlL2XhzlwdKdsSu+AV+x/VRCEYRHHi4RW+oA3NCuI
	G3nYo8q+hKBt5rdTMliW+PzrLzf31Dx7K9mx3ozTKKcbTTM3oaWFx9Ihrrw/8r7/1YH6GlDcXOq
	dYKeeyIGpS8CRzcs2Yf2czBZHJAEQpKnsHnO3Hrkw2OTuwhEY6NnJNfDX4t89ZK8tza77wOboTr
	GQmYUR9c235qBBbE8fqmZ0CNUBiMEr/3xM8jCpYOsYbUMbLxNxcOt5BKQsdnUn7w8kXJeLfYkvb
	uLjMujKIZHNcQX+nvxd/zbtSnC55rWAkrqJiR7puyekhcN0zJ68/3FpQl9+9Uy18nGox
X-Received: by 2002:a05:6000:310f:b0:47f:775b:f5dc with SMTP id ffacd0b85a97d-47fd32e1c76mr5907524f8f.19.1785521123140;
        Fri, 31 Jul 2026 11:05:23 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a6besm7094559f8f.22.2026.07.31.11.05.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:05:22 -0700 (PDT)
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
Subject: [PATCH v3 5/5] serial: imx: serialize imx_uart_ports[] lifetime
Date: Fri, 31 Jul 2026 20:05:19 +0200
Message-Id: <20260731180519.10988-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Backport note: the removal fix is self-contained. Complete probe-failure
coverage also requires patch 1. With patch 1, all fallible allocations
precede console registration, so rollback can safely clear the table.
Without it, a late allocation failure (only reachable with fault
injection) can leave the console registered after imx_uart_ports[] is
cleared, turning the pre-existing use-after-free into a NULL
dereference.

 drivers/tty/serial/imx.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 251a50c8aa38..b0f34a6e7d4f 100644
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
@@ -2080,6 +2081,9 @@ static const struct uart_ops imx_uart_pops = {
 
 static struct imx_port *imx_uart_ports[UART_NR];
 
+/* Held across uart_add/remove_one_port(); console callbacks must not take it. */
+static DEFINE_MUTEX(imx_uart_ports_lock);
+
 #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_uart_console_putchar(struct uart_port *port, unsigned char ch)
 {
@@ -2632,11 +2636,19 @@ static int imx_uart_probe(struct platform_device *pdev)
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
@@ -2648,7 +2660,9 @@ static void imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
+	guard(mutex)(&imx_uart_ports_lock);
 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	imx_uart_ports[sport->port.line] = NULL;
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
-- 
2.53.0
