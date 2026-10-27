Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121066;
	b=UJOSnWRvOcTEjPpGxfB5Twp9P3kjdpU7mhJNnmWwUP2PD4Noq+KF15xn+8AUWweGVBHQ
	 pLc+pEBIRT6dML4f37JvBKpv+/N8+wIHGJ9+qdrJbmkgZUYfo4n/1IVv6/7wFW4GJiwa3
	 TClSD9H/vTS2FL7NGzF3yxRuKjZRTiQR6GIqVN+ZG4LGaRjbeRaZfydtHR4Oc6JGFH/zQ
	 a1ngzE0PKjn6shmP7d0fqgBuUeoMcxfZCOVnLFfr1n4TR5OdLZ0zZR21AI7QAEXEprcTw
	 uTXH0Irenrlq/Q+wc6za8eo+ABtYO03tsuWA38XfeKBJWHyNcOIJ+r0Z+i0NfILv7fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=aSSGdTxE1BTiwe1su80qJLKASHzeXOFM873+44F4KYE=;
	b=TFuSBt3D8/i+bYqHP/3rcnR+zv/7BBf6I/cUCSqMfuAa9MeQtWHTtUcpq6J4fhYeqfzv
	 4pHW/k3brcllUtY4o7sUCtarpEoQcMZERzWpVDpACg2usMNntxU0rhcqJxke9h9PD2jG3
	 JNI1Iex0DBS2EHenhnbffuIJW5bowtMaQ26WeFgo4abpc3TUb62oPEd4B1O599A4kWCzO
	 9a1Yip4eqVRvYWWXSPZUwxejWqNj+MUgQDuah5Rt7Ycd51mXHk/bypS3B8aIK2kOzbm8P
	 B1GQ+++g/tTMzzOf4CWUOwXYH5kwfbffebfiViXoOyoJ1WRopLEzvvKz82p1mwOhApw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hFmjYzhq;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BA0606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 17:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13BA0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hFmjYzhq
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-84a248254f4so50570a34.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793121065; x=1793725865; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aSSGdTxE1BTiwe1su80qJLKASHzeXOFM873+44F4KYE=;
        b=hFmjYzhq8jncXh5SWcqqr9vcSjgBHjJ/0ujMw1TuUkutLW1gNsuW+7J/t9TFilfRHP
         JQqFapd7dhVXsTQDnyJ3+KrUiBoZJ5pwUN041avArKdg/pIQ15rbDwAN5vko/S/6kFui
         WkHmp6irSutL8XZnXx1rbNmH/lAcYIvrbUNGdbLVszf3NaM3FZXgDvOzUF1mlBTSWGoc
         ix011qvzykBFhCUienmKA1gNIXN5R67sA2uSwmGLOnOaHAnrSSTzdSHUSosdhzyOGQGX
         FJ6nnK6TdA4b7A4Boe2lNXcDPGjwVbu5mqxvbaIX1PL3tpO3WzKxeSN9fTI7PYR2rEjN
         +E9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793121065; x=1793725865;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aSSGdTxE1BTiwe1su80qJLKASHzeXOFM873+44F4KYE=;
        b=A8SLDI9TI+IcOl6PSGXUzAc8mvHafXFZy6luIyZNMk/oIJ5PbrNm5QY6t24R+EjLHF
         WyCaRB1kE1zRy2gIPeljsf2+KwGzztNZgHb6Cnig+Bf7zznkUVPuEGO992gw5nK9iu3p
         skjHorPwLBKAnEWPby6ZMsH96Fu7QA2olL2qBxXcjfGksNn5oiYCuxYwOR9nyBvOP3md
         1P6byjCB+Gr38Q2u/rFb2Rv1O6LNC/N63tFbvJmfrJHZPbFVDA7cQ09eB9VvNlVK5Wk+
         LMdxHc/GE+nZJ77x2vj/wJKS5vL2xV+oeFGFhMQ90crWHMfZ4wfBegdHrNOR9fT+pM6B
         8dYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvnrB/kOsYkqquPvLRfsYJlw1FvZH7m3AK+fOJp20tvR8p3DpPeIF+8XSId6x1+KP3WntnIF8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwQIQ4mM50u8jCMotKps35b4rRPrYGo3ZG35R6FqATWKzCddGT
	HzBUcjrDwpPlkPMHAvozS01w2FR2FZglkVZvlWylu68jyfwG+jrfwVlW
X-Gm-Gg: AYBFou27dXI2NKlouuA4bwhJjVWGJXOPcYFg7jOl7NjrYiOzjTp8NW49OA0ssftkWQJ
	1IQV9+pIZGDZ0Jkm+r+qhZ7Dr9naV2+859fnqcCd179dcRffZ/xynFy0CiGOoiVj0JPmAz1F8vU
	JNtmo56dvcdsdMDbbJO1BtcsTm9ZwIM2O3cFz6sFsPo56OmIDKBR9CtHDUz3nV2T2/rAcZ1sK5J
	pkaaiFLv+UOn4RYbk7XIG/BaQ6bthbpsrwbZwrd8FTHxMq2ZYi8+da+aaMlAeQDMrA5W/fig999
	arpjL6oY0tmqWQhWVzVrW2bRhF8Y/GoMnANe0VqULhh+p+oxqXkKXkw2AH6r88COYPOB8PifmMf
	Z8KCfYZtcwM+sEVs/1mzBcRhRlNHcPKHzLt2i2pAWJPoFCILfrTfpmFK+O5AT8AUsur6m8lK4kP
	DQeq7Ugm8hhUyG96tQOeW+R17tFR2MkmIIyCpZNsI8/lagIdRmOkE+m9d1puTCQdAhAetaPzljP
	im39Ky8sNHned6NBYTKshRdDZHZj6/mfWOxrs706EqekKF3mH5xLmwPqxYR1Bpe0wshJsCGrHLk
	lJhnv8uOetVQV2on/9y+SmduU1KoesbCDnklOElIVJRz4tGKJa+Pq1AXgU014JdjyV52N4wO94U
	mUTkmwwu5H61lidZcbdtplTNqeLe7VfLa7+RvNfqsns6lgcrENnPpPVWS8uxdES9SAtfI5OOpbJ
	7IYA==
X-Received: by 2002:a05:6830:b15:b0:80c:d34f:5f66 with SMTP id 46e09a7af769-85abdc07c3emr95370a34.31.1793121064652;
        Tue, 27 Oct 2026 10:11:04 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fbc1b072sm12101200a34.21.2026.10.27.10.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 10:11:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 Oct 2026 11:10:57 -0600
Subject: [PATCH v4] serial: 8250_dw: preserve BUSY-safe fractional divisor
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
Message-Id: <20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XOy27DIBAF0F+JWHdSni7uKv9RdcFjiKliuwLiJ
 or874VkY3WVSrC4wBzujWRMETN5391IwiXmOE81yJcdcYOZjgjR10w45R2jXEA+2zEWaGPmBJo
 rCv4HfKyjc4KFgQqs0z16qowmlflOGOLl/sXH5yNX4wtdaW57YU1GsMlMbmhHpVxf64YJL6VdD
 zGXOV3vFRfWmH+0qYtBkIp7aS2zLByOo4mnvZtH0tosfAvKJ0BeQSq4M0oILVT/FxRbsHsCFBV
 889azXiILQm/BdV1/AZmNzsujAQAA
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

Expose the library's fractional-divisor calculation and DLF write as
shared helpers. Install the BUSY-safe setter after hardware discovery and
use the shared DLF helper to program the fractional field only after DLAB
has been confirmed, alongside DLL and DLH. Keep fractional-divisor
detection and calculator selection in the library, preserving the core
calculation for integer-only ports. Let the shared DLF setter check for
fractional-divisor support so callers can use it for either kind of port.

Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v4:
- Leave fractional-divisor calculator selection in dwlib, removing the
  platform driver's DLF capability check and getter assignment.
- Preserve dwlib's existing getter callback through a static wrapper
  around the shared calculator, as requested by Andy.
- Link to v3: https://patch.msgid.link/20261026-submit-serial-8250-dw-divisor-v1-v3-1-7dbd194e1f38@gmail.com

Changes in v3:
- Move the fractional-divisor support check into the shared DLF setter,
  allowing the BUSY-safe platform setter to call it directly, as requested
  by Ilpo.
- Rebase onto current tty-next.
- Link to v2: https://lore.kernel.org/r/20261024-submit-serial-8250-dw-divisor-v1-v2-1-032ca5338359@gmail.com

Changes in v2:
- Share the fractional-divisor calculation and DLF write through exported
  dwlib helpers, and use them in the platform driver as requested by Andy.
- Select the fractional calculator only when DLF is implemented, preserving
  the existing core calculation for integer-only ports.
- Link to v1: https://lore.kernel.org/r/20261023-submit-serial-8250-dw-divisor-v1-v1-1-f452d4bb1b1f@gmail.com

Previously included in the DMA cancellation series v4:
https://lore.kernel.org/r/20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com

Changes in DMA cancellation v4:
- Keep DesignWare's BUSY-safe divisor setter after fractional-divisor
  discovery, writing DLF and DLL/DLH only after confirming DLAB.
- Link to v3: https://patch.msgid.link/20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com
---
 drivers/tty/serial/8250/8250_dw.c    |  5 ++++-
 drivers/tty/serial/8250/8250_dwlib.c | 24 +++++++++++++++++++++---
 drivers/tty/serial/8250/8250_dwlib.h |  2 ++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index eca02e8bd6d1..9cbe076463e0 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -201,6 +201,7 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 	if (!(serial_port_in(p, UART_LCR) & UART_LCR_DLAB))
 		goto idle_failed;
 
+	dw8250_set_divisor_dlf(p, quot_frac);
 	serial_dl_write(up, quot);
 	serial_port_out(p, UART_LCR, up->lcr);
 
@@ -651,7 +652,6 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
-	p->set_divisor	= dw8250_set_divisor;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -768,6 +768,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
 
+	/* Use the BUSY-safe sequence for both integer and fractional divisors. */
+	p->set_divisor = dw8250_set_divisor;
+
 	/* If we have a valid fifosize, try hooking up DMA */
 	if (p->fifosize) {
 		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 9bb02a4ab11f..91b3607b64e6 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -23,8 +23,8 @@
  * we have: div(F) * (16 * baud) = rem
  * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) / (16 * baud)
  */
-static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
-				       unsigned int *frac)
+unsigned int dw8250_get_divisor_dlf(struct uart_port *p, unsigned int baud,
+				    unsigned int *frac)
 {
 	unsigned int quot, rem, base_baud = baud * 16;
 	struct dw8250_port_data *d = p->private_data;
@@ -35,11 +35,29 @@ static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
 
 	return quot;
 }
+EXPORT_SYMBOL_GPL(dw8250_get_divisor_dlf);
+
+static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
+				       unsigned int *frac)
+{
+	return dw8250_get_divisor_dlf(p, baud, frac);
+}
+
+void dw8250_set_divisor_dlf(struct uart_port *p, unsigned int quot_frac)
+{
+	struct dw8250_port_data *pd = p->private_data;
+
+	if (!pd->dlf_size)
+		return;
+
+	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
+}
+EXPORT_SYMBOL_GPL(dw8250_set_divisor_dlf);
 
 static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 			       unsigned int quot, unsigned int quot_frac)
 {
-	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
+	dw8250_set_divisor_dlf(p, quot_frac);
 	serial8250_do_set_divisor(p, baud, quot);
 }
 
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 39fcb1b323ad..7191cabfb086 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -97,6 +97,8 @@ struct dw8250_port_data {
 	int		srbr;
 };
 
+unsigned int dw8250_get_divisor_dlf(struct uart_port *p, unsigned int baud, unsigned int *frac);
+void dw8250_set_divisor_dlf(struct uart_port *p, unsigned int quot_frac);
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
 void dw8250_setup_port(struct uart_port *p);
 

---
base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
change-id: 20261023-submit-serial-8250-dw-divisor-v1-5f1689ed05a8

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

