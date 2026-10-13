Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A414B37A83D;
	Tue, 13 Oct 2026 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874143; cv=none; b=SLsaJmEgJyrZUf/Dqq2ih4uEqguQ01zjw6OWTFn5H3FvrPLM/CvR1T9eQRc41ym9ah7LkHQytTAs/TFgtJjPhDJFaF0Sv8G/XddXP4UE61Q/UjsoJ2L+XCYXUwHA0C7RTichjtaS0JgJBCKTt1UXto3egwg5BRM/dvrex1bBJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874143; c=relaxed/simple;
	bh=xZO3dCQ4RMWYxib/sG8yszLVdJo/CnLvoB+LT+ZfaKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfgMjzOqWp/ouW8DnIXnywRPLJkbPbP6N/RaMqNYNahNjpQXgWSnepzw+EbO4BD0gV1ciMyf+6UDqPBlKchmBfmmRZu20t7efffDdNcwflU94OduQIN2+h+dCo5LbRojw/wz4MWAmMoITpKJBOTrMH3AA3Z2Krgu3N82WyVVZRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhptOP5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhptOP5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183231F00893;
	Tue, 13 Oct 2026 06:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874142;
	bh=LQvgcT9XQ4Eabjr3P3Unw7c+nRmQJW/GjvlTWQpFZXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VhptOP5yawG4DOoWvXX0ciYKYSYJfzApvASKLFXdKzgOvJsuweQ/lArfRKWq5qx0t
	 bhMjsL3Zfe3M56f88xEKfhlQjNyC+dfS6Fczz+GbZbGBwUDHYAGDr1GUw8ZCUJHv+d
	 4UwkXArm86UOl5yJvL8sbvxynb+FmM2haWXxVTvxcvQh1of0QZnHHWnRVJA4Ro+peR
	 Zw9lWnMVai1/bJGZi2chi1+TBUE6rlmHfhAn8rkcs+rXijdwe7bd18BnGv/mXXye/K
	 sx90mE8o/B62pn8l36glBu6pDLIpy7rteCZTw/dorpIzQK4ExRrSZHJ5/QTE3m5SEu
	 A8v+B+CyX2Z5g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 5/6] serial: 8250_omap: set priv->line before enabling the IRQ
Date: Tue, 13 Oct 2026 08:48:50 +0200
Message-ID: <3b3a642f7df2285f49a7bbbe5d1c23fa442c7d94.1791873876.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791873876.git.jirislaby@kernel.org>
References: <cover.1791873876.git.jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap8250_irq() is requested in omap8250_probe() with IRQ_NOAUTOEN and
enabled only in omap_8250_startup(). The handler obtains the port by
serial8250_get_port(priv->line), but probe stores priv->line only after
serial8250_register_8250_port() returns.

The port becomes visible to userspace already inside
serial8250_register_8250_port() (uart_add_one_port()). So it can be
opened -- and the IRQ enabled -- before probe stores the line. An
interrupt in that window makes the handler call
serial8250_get_port(-ENODEV) and dereference a pointer outside of
serial8250_ports[].

Store the line in omap_8250_startup() before enable_irq(), so the
handler never runs with an unset line. Keep the assignment in probe
too, as remove and the system PM callbacks rely on it even when the
port was never opened.

Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for interrupt handlers")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Assisted-by: LLM
Cc: stable@vger.kernel.org
---
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/8250/8250_omap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 3a1473bf54d0..137175aa4183 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -711,6 +711,9 @@ static int omap_8250_startup(struct uart_port *port)
 	struct uart_8250_dma *dma = &priv->omap8250_dma;
 	int ret;
 
+	/* ISR and runtime PM need the line; probe sets it only after registration */
+	priv->line = port->line;
+
 #ifdef CONFIG_PM
 	up->capabilities |= UART_CAP_RPM;
 #endif
-- 
2.56.0

