Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792821023;
	b=E+3OoFtVWpYIokdqcHjHMafQVMa2E+xjHd6x6ax6E6HP7WKx6CyXjeBEWZaN2OCK7Vl0
	 nKY9npqof7LDErn/TXrk5w0VejObnp3IgwiJpREuQyMdBwcoh2BiU1bDy1VfReDyRIEzW
	 I8JV55cNMjcuaOkbR9E5zGoqzczV7NBSu9f8QplLQUaXnYEyLtQjyR7I+1AxVuI+/mK/M
	 acpFJhKuxxJAiWRsROr6/M0RWfs9wH9OhGQDr0h+z4I8ECnSaAVwhAJ+oX6Aj7fmA67zp
	 C1SwjdXjr9qSaS75tullx1XEa7ftInoYI5WWRRjGmhl37BA1dcb3SBNGe+aOXh+bwmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792821023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=XEq7BJISvWrYZRawdSztbA3abkuHTD/bmyAUQoKx548=;
	b=hu4+4djZneBdJJGvmSaiaDYR9dCQRI+PuONpWaGK1GC+1rM99nQ4QJ9uBPxRw0tEBfYK
	 UNjA6OR9YKyV0w1yZ3MzjPdf6vKXmze7aFVsWi3HBhNVyBBuWAL66DceyIHP6FDJbZ0NA
	 HF/CwiVFw8m1+oKmzAmbhrL6nCY4TU3PjV+GfeQERmv3x2oKmmKsbTzNuBZIBwlTE7CKj
	 QXm2wZMRjXWdq1Z9xfNLcJXMelyfbDaeZE2k/WFryiRbZhEe4HYGug8nU6fX4zd6Gtmlj
	 sSiPpy7rH3NfJ4+WI2R93Ajjwc7ax0Yn6n3/dahOSJeGWP5KttmbaHM+MZJHMXM+HBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ljsoYV7l;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263D5606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 05:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 263D5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ljsoYV7l
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-84a248254f4so989496a34.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 22:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792821021; x=1793425821; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XEq7BJISvWrYZRawdSztbA3abkuHTD/bmyAUQoKx548=;
        b=ljsoYV7l95fh24Ei7MO1YbariBg9iLmsVp2HPUfYBhsZrTPhaLU58Qq9KAxUn+udIM
         4ygWHM4GsqWhCWu5HJeteywZ3teCPktoKSSH/bDTzIkx9bTFOAJtJbZ1PdEStNRY/RSC
         tnnjI8fnsJhfdlJ/i8J+nuVYrWY76U15kLWoEQyfouKZu54XlMRibjp3zUtEeIIytDs9
         5MLYB0uyZuTvYJa6jMjHlx943H31nKTUuQZszQ6n9CaeqsQomxUsDptpYGAqBV+8bkmG
         y9pwXXLQCVU+yNZBJS4nGxdL/dkmPLVWZ4enlSIIXrn4MMx2XCAED02JfhNnhoDPmBjc
         uwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792821021; x=1793425821;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XEq7BJISvWrYZRawdSztbA3abkuHTD/bmyAUQoKx548=;
        b=kP8WBvRes0tEpIh9METgwpNIIQMAvKU7wUVyAxp85CTFGvKmk/ewUQHFzqtuAIq+b6
         pmeQOavZlZiu8OxEa8eUFK+8XfHo6HGUoOKl7TDOvq4ijw8iqQS3CCF6RWo9rCUC5AvI
         BAgkHxArWqclJNjqFcCmInyxE2DrVjEBOJMfOaetO5fty6gjRjdp7uCO5Qu+5YrHc6iT
         lmE45ygQXqw1/uv1C/kcpRIcqsZiSGkSy8muWJEBTvd+KRgHZLwLrMfYeRdt+pB3eAe8
         pcdY0zrPqpwAkLR/XFZIYihxs4p60WAM6/fnNejd5GD0Wxtq7BzE/8ywTmpQRSeigwCO
         BG8Q==
X-Forwarded-Encrypted: i=1; AKwUvBw8+MJ7pWrMs1k3JXQzD6K7grum99jXWX7V9X2o6SrEP0Yd0nLhSA3r0tTPHjIWf43AzOZM+8Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLP8NxPqcAe78vgj8wEGn11d4yPan9ePGK52RWIEv/B23DDJbZ
	kZNPpBcVd6ecov9rCw/7CZe8epO5w/dNL68m64JC5K84LdEmS0HHmdUX
X-Gm-Gg: AYBFou3MNiWPlT4aJD8E2hhoH38AtxMa7m6MxehtbkAUFjcQNZYhy8u3RYLRYUUtkIF
	zqeRc6QVF9oDDn2/hC69nZbHhv0XcPGwFQ1Fq7FbHMS2kJdQaUBYgzhN/xyf59ecFzhbWRkwUdz
	7VDtY1E4ZsFTDohrEOTw9jpAaJJ88L2Q6TDEviUh96G/hWdkqf7wvZJQSgTOGYZtjol+OYFICux
	KFX7sBGP7mcVMSLzeR4nceCF2d8ldesB28eHJK4zd2cOTefSWOjRELG4MDTZpy4UcvpTdHn2fYP
	grcqvjxZBD5v06yxizmamcaZDXnDxR/BhtJtAqmr4fvtlw/0i8MYN/oAN8hCE39KjFZeRJ+GUsK
	nTVfTd4FHDPazg2yyDTGXfsM/OTot06rMOhlHKMqRVa3+owcFJw3lds02CKnb0Ra6G43cOFDdsX
	XUNvrtiQ5Y7Mn3ZAbMRKB+ebYv4LNMO0FXCyboc7P70Lc8r1JGA59KJXN/M5xykPV2EzflUvPn7
	BKfQYgUU9gzKXo2fzuaE9ukiqQztLsDM7itt+d3Ye50KGd6VCkCXRs5RdQ4fYWoYrbD2Jp7wmYc
	dK2Yaq62SN8Sz+gDyUcIlmDOxsRaYS+lFV32ZfV+SzK4P1ovfRjNXICq1PbxVOrZxlvIGanJw6s
	Rv+XXrYXk6JU2Is8OVhVJVOWpQf1WUXD6BxcmaVLa6tDj2/2xupv46lQxMVvSekhrmX+9pi76fu
	/2sGQKCYmcUVIY2noSAu+DaqYA
X-Received: by 2002:a05:6830:4408:b0:821:c01c:2ec3 with SMTP id 46e09a7af769-850f81696eamr1208809a34.0.1792821021056;
        Fri, 23 Oct 2026 22:50:21 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fc002444sm1460625a34.23.2026.10.23.22.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:50:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 23:50:17 -0600
Subject: [PATCH] serial: 8250_dw: preserve BUSY-safe fractional divisor
 programming
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-submit-serial-8250-dw-divisor-v1-v1-1-f452d4bb1b1f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSw7CMAxEr1J5jUUSlCpwFcQiH5caQYqSUIqq3
 p0EFl680czzCpkSU4ZTt0KimTNPsYLcdeBHG6+EHCqDEqqXQh0wv9yDC7aZvaNRWmB4Y+A6nRL
 OEvUge3OkILQ1UDXPRAMvvxfny5+r40a+NG9rOJsJXbLRjy0q5bOvh5GWAtv2BY04vRCjAAAA
X-Change-ID: 20261023-submit-serial-8250-dw-divisor-v1-5f1689ed05a8
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Raul E Rangel <rrangel@chromium.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

dw8250_probe() installs a divisor setter that makes the UART idle and
checks DLAB before writing DLL and DLH. When dw8250_setup_port() detects
fractional-divisor support, it replaces that setter with the library's
callback. The replacement writes DLF and uses serial8250_do_set_divisor(),
bypassing the divisor setter's idle sequence and DLAB readback.

If the LCR update fails to set DLAB, the subsequent divisor writes can
reach TX and IER instead of DLL and DLH.

Install the BUSY-safe setter after hardware discovery and extend it to
write DLF when fractional divisors are supported. Program both divisor
fields only after DLAB has been confirmed, retaining the fractional
divisor calculation selected by dw8250_setup_port().

Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Previously included in the DMA cancellation series v4:
https://lore.kernel.org/r/20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com

Changes in DMA cancellation v4:
- Keep DesignWare's BUSY-safe divisor setter after fractional-divisor
  discovery, writing DLF and DLL/DLH only after confirming DLAB.
- Link to v3: https://patch.msgid.link/20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com
---
 drivers/tty/serial/8250/8250_dw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index eca02e8bd6d1..7b7dfad583fe 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -190,6 +190,7 @@ static int dw8250_idle_enter(struct uart_port *p)
 static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 			       unsigned int quot, unsigned int quot_frac)
 {
+	struct dw8250_port_data *pd = p->private_data;
 	struct uart_8250_port *up = up_to_u8250p(p);
 	int ret;
 
@@ -201,6 +202,8 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 	if (!(serial_port_in(p, UART_LCR) & UART_LCR_DLAB))
 		goto idle_failed;
 
+	if (pd->dlf_size)
+		dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
 	serial_dl_write(up, quot);
 	serial_port_out(p, UART_LCR, up->lcr);
 
@@ -651,7 +654,6 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
-	p->set_divisor	= dw8250_set_divisor;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -768,6 +770,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
 
+	/* Use the BUSY-safe sequence for both integer and fractional divisors. */
+	p->set_divisor = dw8250_set_divisor;
+
 	/* If we have a valid fifosize, try hooking up DMA */
 	if (p->fifosize) {
 		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;

---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261023-submit-serial-8250-dw-divisor-v1-5f1689ed05a8

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

