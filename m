Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611786;
	b=YyxBEqLDWeVKFRyI4VT0tUHXEcbZyTIhpXtReMnpRSwlZmlyIFcvAAy//eiOYRAq3Hqz
	 8Up7mhQpKM9E3M1jUzN0QFtsX/dPGjYpcHHRvG+JJbdhehAN+Jr+HSI+EPYJb6qfy1VsU
	 yKYHaeIVnif7YJoVUFLkApkim9Sqizd4PNQELtdW4miDXypx+sMSiQXQiouhr4rArQvKu
	 dSEZVhyJM8ek4I6VFa90gFpXwi2/aOr4SIsaR3jx5IH00TE7y4vcvAJL1Cw6gwXn1xyPC
	 MjG5snPahqwPsOzlOZc+0T4MFeIIqtS1wJef/YYPJBBJgAndgj+Yrfwy+3ohDkNkuhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611786;
	h=DMARC-Filter:DKIM-Signature:Message-Id:X-Mailer:
	 Content-Transfer-Encoding:Received:From:X-Original-From:
	 X-Lms-Return-Path:To:Cc:Subject:Date:Mime-Version:Content-Type;
	bh=Jpf0sF3BsXWuW2vGarlxt3BK+rqyO+jWFnFGPUZEX7w=;
	b=hfHzjlKZb4b1w/3uQnGaRxnw1tNRk/V5mUT+uCKvNpJ3wiDsF21Wxky12VWFuTfXQb99
	 drWx0yeEi4WFXrVHQoKTQ3+goMomnwV8DqEgyWkebT6aWh3kV9PqzHjVP4ILIxPywIKby
	 SXY4wUpEJDUVaPecIQ/U0JCCsFAtp4yJWCBG2Qqnf+HnXacdZEK4NjsATHSkMDE0QT0Hy
	 0xrc6Hy4xtcH3RYVd55QS+L04ALceYnGlASGvZqdpBHwKP6nun2sYm0mfhIUP+d86JpaP
	 J/fuu0q3yV2Q+LITz1BHzaXCs+/L3bgThMLOXidkqiHMK9uE8cKncNUOBld0qrYKQyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=semidrive.com;
	spf=pass smtp.mailfrom=semidrive.com;
	dkim=pass header.d=semidrive-com.20200927.dkim.feishu.cn header.i=@semidrive-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=QvGE84iy;
	arc=none smtp.remote-ip=209.127.231.56
Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF75606A32D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EF75606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semidrive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semidrive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=semidrive-com.20200927.dkim.feishu.cn header.i=@semidrive-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=QvGE84iy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=semidrive-com.20200927.dkim.feishu.cn; t=1793611780;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Jpf0sF3BsXWuW2vGarlxt3BK+rqyO+jWFnFGPUZEX7w=;
 b=QvGE84iyCF4F4PfGp3vs/4L91mQS7ENqcovQ8VMI+HHs5625TXNdpXHcSb7GRzNrbf/Bj/
 CUG4jVw9giXayHBFShzDG/EnJZiEEnU9k4uKca6MNNzHp9vIO3xsWJ/n7R5GLVJY8PfaTi
 mcwX4VGuHqxzsoU0chZ+WUVsj3COrJSPob2zYTmECsCK9x3ypVRUUOuchkQqkaVMNgZ7kM
 ahLiK5cX2wicApx6Vfz2KEEPa7kcx0IYfawp6ABCE8/4suj2xxI8zxxuBq/SRDwU/AYV0J
 HSZG+pWyM1SUPGRdqs88/T4vnnhTPiITW+YvN6ebXIBJKdq3IVmIssHE0zV5tg==
Message-Id: <20261102092930.2397649-1-fuzheng.meng@semidrive.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Received: from localhost.localdomain ([163.125.147.214]) by smtp.feishu.cn with ESMTPS; Mon, 02 Nov 2026 17:29:37 +0800
From: "fuzheng.meng" <fuzheng.meng@semidrive.com>
X-Original-From: "fuzheng.meng" <fuzheng.meng@semidrive.com>
X-Lms-Return-Path: <lba+26ae85802+20fadb+vger.kernel.org+fuzheng.meng@semidrive.com>
To: <fuzheng.meng@semidrive.com>
Cc: <stable@vger.kernel.org>
Subject: [PATCH] serial: 8250: restore FIFO in serial8250_console_restore()
Date: Mon,  2 Nov 2026 17:29:30 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
Signed-off-by: fuzheng.meng <fuzheng.meng@semidrive.com>
---
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
