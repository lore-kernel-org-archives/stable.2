Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619092;
	b=q3JY5ja1RF5S5kdoeMJh9IIERRmHqFJmW7jTmUAIHHeBinwfZZOptNDa+d5LGvZEMIwh
	 oTig4AKbW0JHXcbOPOztSiHrRIYZx7rv5Zi5MObmAqqZem7cfc6gRQnlLdKcU/uPqSX/i
	 0GsNVXY6pbSoob5c2WQQrN7rD68NIWb4yf0XRfRGM0LsZ7QgeCa/WRLJp+Rj7kUlZ4WkX
	 E7B/EXimlGze6sZRKoI2Qbyw7AFT353YOaRAerfjfjbms91E/i2p4T+jqEeWXkq8Qb3lf
	 wUL4T8NGNhwElXvYiQuXO5mJjkGcG8Agpt4dnW1/hH9uu1DXVmWQBsS+U8BdHqWqETQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619092;
	h=DMARC-Filter:DKIM-Signature:In-Reply-To:Content-Transfer-Encoding:
	 Content-Type:References:From:Subject:Mime-Version:X-Mailer:Cc:
	 X-Original-From:Received:To:Date:Message-Id:X-Lms-Return-Path;
	bh=zzcRomtmJBz03+ikYQlrxrqeTT8liFfRFpMETekX5Iw=;
	b=qE9506hDCi64u9+kyTqYHYe0RICllTtbnv/EjnsLagTmq6G30lFaniX36xgPty9Mm5MW
	 Ie+4ecf2th+4JPvR7RUNuJa6kg7hgAd8lpxL/lqDK8UwTrkF/3yw4z/SHy+r5ot7uEY0b
	 50C0HnZD+DWS0bzUdJJiZYNRUg0HRifAV9mP5Dl6SG+eegSJ+avQdCW5yYq8xoYXHhS6P
	 RLTEsSA44IzmBobdwOl2f7tVJF3iHcJtkmscR2f2HPw15Gif+so3dfqa3eTMNGeJVW8GP
	 vZzC7lkeXM89wGbrnT1Kb7jJczkxyA5cO2RVsoeWBcBNlrZcqp3NHs28Qnyoq0DfStQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=semidrive.com;
	spf=pass smtp.mailfrom=semidrive.com;
	dkim=pass header.d=semidrive-com.20200927.dkim.feishu.cn header.i=@semidrive-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=kZZrLj79;
	arc=none smtp.remote-ip=209.127.231.30
Received: from va-2-30.ptr.blmpb.com (va-2-30.ptr.blmpb.com [209.127.231.30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47D360A2614
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A47D360A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semidrive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semidrive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=semidrive-com.20200927.dkim.feishu.cn header.i=@semidrive-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=kZZrLj79
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=semidrive-com.20200927.dkim.feishu.cn; t=1793619085;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=zzcRomtmJBz03+ikYQlrxrqeTT8liFfRFpMETekX5Iw=;
 b=kZZrLj79zO80g64VO8tp2UY3hoAzMpGnRrGgw9jDvYHY45qntpJ9G/+o/sFvWTRjXI1hKL
 QQR9BB8LIjmrP4aep8FCe2xmnRGm/odBnNklCnadPFttbEJgnvYhz+iTDEFU+cVW5ri/DF
 NPJPahh0XuLE+1BlyK4E3q8G+7PGn8uJA/8RkoOCKE/xebg2MthxhWq6mntEcF9aAEGMbN
 drucpla2HrFuVe6nhPVGow2nXbuzARM1eiBEeLVI7gnoTMN/B7Ps7KIuNfEvz7kTWpDW1L
 AZdmB/89q5C2szqj9r8tzBP4BD7/yS3mDrgYWDaGiN33NFa/ppDwfwZc8GhP9g==
In-Reply-To: <20261102093609.2400381-1-fuzheng.meng@semidrive.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
References: <20261102093609.2400381-1-fuzheng.meng@semidrive.com>
From: "Fuzheng Meng" <fuzheng.meng@semidrive.com>
Subject: [PATCH v2] serial: 8250: restore FIFO in serial8250_console_restore()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0
Cc: <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
X-Original-From: Fuzheng Meng <fuzheng.meng@semidrive.com>
Received: from localhost.localdomain ([163.125.147.214]) by smtp.feishu.cn with ESMTPS; Mon, 02 Nov 2026 19:31:22 +0800
To: <gregkh@linuxfoundation.org>
Date: Mon,  2 Nov 2026 19:31:14 +0800
Message-Id: <20261102113114.2453899-1-fuzheng.meng@semidrive.com>
X-Lms-Return-Path: <lba+26ae8748b+8c932b+vger.kernel.org+fuzheng.meng@semidrive.com>

When console_suspend is disabled, the serial console stays enabled
over a system suspend, and serial8250_suspend_port() writes a canary
value to the SCR register (if the port has one) to detect whether the
UART lost power during the sleep cycle.

If the hardware did lose power, all registers are reset, and the
first console write after resume detects the canary mismatch and
calls serial8250_console_restore(), which reprograms divisor, LCR and
MCR, but not the FCR.

serial8250_console_write() decides whether to take the FIFO write
path from the cached up->fcr, which still carries
UART_FCR_ENABLE_FIFO. With the hardware FIFO left disabled by the
reset, the transmit holding register holds only one byte, while
serial8250_console_fifo_write() pushes up to tx_loadsz bytes into the
port after waiting for THRE only once. The burst overwrites itself
and the console output right after resume is garbled.

Factor the FIFO write path condition out into a new
serial8250_console_use_fifo() helper and use it from both
serial8250_console_write() and serial8250_console_restore(). Restore
the FIFO in serial8250_console_restore() when the FIFO write path is
going to be used: first write UART_FCR_ENABLE_FIFO, then the cached
fcr, as dw8250_idle_exit() does after its registers are reset.

Tested on a DesignWare 8250 based platform with console_suspend=3D0
over a suspend/resume cycle.

Fixes: 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
Cc: stable@vger.kernel.org
Signed-off-by: Fuzheng Meng <fuzheng.meng@semidrive.com>
---
Changes in v2:
- Use my real name (Fuzheng Meng) in the From: header and Signed-off-by
  tag instead of the account alias, as requested in the review of v1.
  No code changes.
 drivers/tty/serial/8250/8250_port.c | 64 ++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index 36b2b0a2c05c..ee6b02cff015 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3321,6 +3321,37 @@ static void serial8250_console_wait_putchar(struct u=
art_port *port, unsigned cha
 	serial8250_console_putchar(port, ch);
 }
=20
+/*
+ * Console output can go through the TX FIFO in one tx_loadsz chunk only
+ * if the port has a FIFO and the software state expects it enabled. The
+ * same conditions tell console_restore() whether the FIFO has to be
+ * brought back after a system sleep reset.
+ */
+static bool serial8250_console_use_fifo(struct uart_8250_port *up)
+{
+	struct uart_port *port =3D &up->port;
+
+	return (up->capabilities & UART_CAP_FIFO) &&
+		/*
+		 * BCM283x requires to check the fifo
+		 * after each byte.
+		 */
+		!(up->capabilities & UART_CAP_MINI) &&
+		/*
+		 * tx_loadsz contains the transmit fifo size
+		 */
+		up->tx_loadsz > 1 &&
+		(up->fcr & UART_FCR_ENABLE_FIFO) &&
+		port->state &&
+		test_bit(TTY_PORT_INITIALIZED, &port->state->port.iflags) &&
+		/*
+		 * After we put a data in the fifo, the controller will send
+		 * it regardless of the CTS state. Therefore, only use fifo
+		 * if we don't use control flow.
+		 */
+		!uart_console_hwflow_active(port);
+}
+
 /*
  *	Restore serial console when h/w power-off detected
  */
@@ -3345,6 +3376,19 @@ static void serial8250_console_restore(struct uart_8=
250_port *up)
 	serial8250_set_divisor(port, baud, quot, frac);
 	serial_port_out(port, UART_LCR, up->lcr);
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
+
+	/*
+	 * System sleep may reset the FCR, leaving the FIFO disabled,
+	 * while the cached up->fcr still tells console_write() to push
+	 * tx_loadsz bytes into the FIFO at once; with the hardware FIFO
+	 * off, the THR holds only one byte and earlier ones are
+	 * overwritten, which garbles the console output after resume.
+	 * Restore the FCR when the FIFO write path is going to be used.
+	 */
+	if (serial8250_console_use_fifo(up)) {
+		serial_port_out(port, UART_FCR, UART_FCR_ENABLE_FIFO);
+		serial_port_out(port, UART_FCR, up->fcr);
+	}
 }
=20
 /*
@@ -3495,25 +3539,7 @@ void serial8250_console_write(struct uart_8250_port =
*up,
 		mdelay(port->rs485.delay_rts_before_send);
 	}
=20
-	use_fifo =3D (up->capabilities & UART_CAP_FIFO) &&
-		/*
-		 * BCM283x requires to check the fifo
-		 * after each byte.
-		 */
-		!(up->capabilities & UART_CAP_MINI) &&
-		/*
-		 * tx_loadsz contains the transmit fifo size
-		 */
-		up->tx_loadsz > 1 &&
-		(up->fcr & UART_FCR_ENABLE_FIFO) &&
-		port->state &&
-		test_bit(TTY_PORT_INITIALIZED, &port->state->port.iflags) &&
-		/*
-		 * After we put a data in the fifo, the controller will send
-		 * it regardless of the CTS state. Therefore, only use fifo
-		 * if we don't use control flow.
-		 */
-		!uart_console_hwflow_active(&up->port);
+	use_fifo =3D serial8250_console_use_fifo(up);
=20
 	nbcon_exit_unsafe(wctxt);
=20
--=20
2.43.0
=E6=B3=A8=E6=84=8F=EF=BC=9A=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=
=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=E9=99=84=E4=BB=B6=E5=9D=87=E5=BD=92=E5=8C=
=97=E4=BA=AC=E8=8A=AF=E9=A9=B0=E5=8D=8A=E5=AF=BC=E4=BD=93=E7=A7=91=E6=8A=80=
=E8=82=A1=E4=BB=BD=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E5=8F=8A=E5=85=B6=E5=
=90=84=E5=88=86=E5=AD=90=E5=85=AC=E5=8F=B8=EF=BC=88"=E8=8A=AF=E9=A9=B0=E7=
=A7=91=E6=8A=80"=EF=BC=89=E6=89=80=E6=9C=89=E3=80=82=E6=9C=AC=E7=94=B5=E5=
=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E4=BB=85=E4=BE=
=9B=E6=8C=87=E5=AE=9A=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E6=88=96=E6=94=B6=
=E4=BB=B6=E5=AE=9E=E4=BD=93=E4=BD=BF=E7=94=A8=EF=BC=8C=E5=B9=B6=E5=8F=AF=E8=
=83=BD=E5=8C=85=E5=90=AB=E8=8A=AF=E9=A9=B0=E7=A7=91=E6=8A=80=E7=9A=84=E6=9C=
=BA=E5=AF=86=E4=BF=A1=E6=81=AF=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=
=E6=9C=AA=E7=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E4=BD=BF=E7=94=A8=E3=80=81=E5=
=A4=8D=E5=88=B6=E3=80=81=E4=BC=A0=E6=92=AD=E6=88=96=E5=85=B6=E4=BB=96=E5=9B=
=A0=E4=BE=9D=E8=B5=96=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E8=80=8C=
=E9=87=87=E5=8F=96=E6=88=96=E4=B8=8D=E9=87=87=E5=8F=96=E7=9A=84=E8=A1=8C=E4=
=B8=BA=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E4=B8=8D=E6=98=AF=E6=AD=A4=E7=94=
=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E7=9A=84=E9=A2=84=E6=9C=9F=E6=94=B6=E4=BB=B6=
=E4=BA=BA=EF=BC=8C=E8=AF=B7=E7=AB=8B=E5=8D=B3=E9=80=9A=E8=BF=87=E5=9B=9E=E5=
=A4=8D=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=
=8C=E5=B9=B6=E4=BB=8E=E6=82=A8=E7=9A=84=E7=B3=BB=E7=BB=9F=E4=B8=AD=E5=88=A0=
=E9=99=A4=E6=AD=A4=E9=82=AE=E4=BB=B6=E5=8F=8A=E4=BB=BB=E4=BD=95=E9=99=84=E4=
=BB=B6=E3=80=82=E9=9D=9E=E5=B8=B8=E6=84=9F=E8=B0=A2=E3=80=82
Attention: This email and any attachment hereto belong to Beijing Semidrive=
 Technology Corporation and each of its affiliates and subsidiaries ("SemiD=
rive Group"). This email and its attachments are intended solely for the us=
e of the individual or entity to which they are addressed and may contain c=
onfidential information of SemiDrive Group. Any unauthorized use, copying, =
dissemination or other action taken or omitted in reliance upon this email =
is strictly prohibited. If you are not the intended recipient, please notif=
y the sender immediately by reply email and delete this message and any att=
achments from your system. Thank you.
