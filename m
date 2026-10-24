Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792867522;
	b=Qv9LEnOAFtHC6mtrQKzQ/dfLYdn/H/xOvp/eqgkslVgDgPpf9iENRbs2swSGfC4yM1vc
	 Vh3Z0i5lMwBdPR7D13W8DD4G6BT42Rh4uxKE9NAEDpZA5qc0DWjAmEFDY8hl3+dOSQpQy
	 M37cXFJGUCj7DcKBnMQou1BNLqwfyxYfcjs0O6EAhsiTemkrWRIpzlGzIQqmHa/lM1DEL
	 6ZWnlcz4xsmHinIqjfQTke2owreKcZygXPaJjQkiczrByJF+s2AeNZIFmuo59ZONSXSEy
	 jzK5g7rt8WdDm6jH0bi252n1tbZV3MesDupJpDovU8fAglk80S0VjwSmPdJVfQ/NaZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792867522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=yY5UXFYpbU9bup1uqrZFIbo3hCy719yJ98Mgxjg26z4=;
	b=hkohluIRbVa554+eXW53mER7lXk+0Z8kpJ1Aazc9kSLk8sGvZQYpWvDTdIWQq5iKpksP
	 /moJx83V4gO+hoKmrgnUakJlS5wDSXZglfk9y5XXn/uBFRXjO65TYqxfM1dhM3+pMzu8u
	 0/VnYht0VFqa0d36UUKyOeYVs+fX+TSyc9WZtqYcQ33wmqjMH88fEQDbKteb9xPULMYAQ
	 NMO4yHdx6CL9zJ7a8rofJQ+M8KCX8TAeSwZ8o4+cxxHHlo9zQkjkRKWzSdM6wrLG3kS5t
	 J2YkLGhe9cJrKB1gZhuPwkHF7f6nnpgRyD/QSq7/pg5pb0onIy3e+rJe8QSppUt3K8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Ve/5r0+s";
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C6606A31E
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 18:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A72C6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ve/5r0+s
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8470d7d430fso713936a34.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792867521; x=1793472321; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yY5UXFYpbU9bup1uqrZFIbo3hCy719yJ98Mgxjg26z4=;
        b=Ve/5r0+s4HTSaPMV+Kcd0hHLM4mvn30baQ0K+5/cDnRd1/q4ZAdyzOH8Qx8XwZdUwG
         iZEHx/mZKCNTq/+KL7IxQjvkMqJYCgHm3Kp/lLMDPoEgVWPZ2R5DiHK5PEs4g2ADKAVi
         yYuK0EEVEDQkZFg48hcb+xwu5JiftUyGemWFaAKWc/rH/yqNbngOsY17MPtClvNH5fJ9
         wMQDKJDpzDWoXJ0Gl/lkNpqllyH2b4B3pSR9fRZ0VodECxwUfjl8+D+2C41wxGu8Jijr
         wPlELm44jX8sz8L4RAXqw3Jvdt5/Bx+DpMl+kezbTZtGxNzcgWbPeHF/eZhTAOQoqEwb
         4e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792867521; x=1793472321;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yY5UXFYpbU9bup1uqrZFIbo3hCy719yJ98Mgxjg26z4=;
        b=nRa/AbWQA38W8Y8sqQvxpd2VHV54zZp+6AVlcs/FyVkH1IKGAoBjY4kAZ2AN6EpYE1
         DJZwDTZf8lZaLxPtJHzB5dNX3r18h6FWx1YOS3cKg9/iFOpl1xSF4V/PMLfMiOa9wdgU
         A1DUGJr5oioUYB/a0+4ENJ89mEp9FYZSjn+FzSTUS6fCOjgY1C2MF5STUvfUdDETvsgR
         am7xKN7eWcpwXUYdQAOfUPiVAOqEWaF7woH9WM54dsEfpsvHe9zw0arLovrX72YJRH/m
         1u1P7QkV0FWIOwjwLqInlcPpnpDTWdRtfD5Oz70HlNfXxRCvsa8gGn5kmpQaB3rJTcFy
         W3hg==
X-Forwarded-Encrypted: i=1; AKwUvBw2N4jtvkLblPIo2vz9UtpWEBxzbnyZj7542ZsYBH+PzpObhBBmz2p6t3gUOG0v3E/OOEkvfTY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxMNqQ0Yq10q6FzUODo+iIYKhhIq9g8ZftJKxaT9BUZsYQEihX
	xwuwX39jg06WaSUtcsVIAye4TgyLWe40ZEGSUKT2k/TEZ+pD4GfUPtKJ
X-Gm-Gg: AYBFou0kGPAh9BP/HdBI42IGgYRDG/JPjAqp5U8XQOeBij/5a/h5qVNs1yqBGEi7Zzn
	GTJ/2J60SnWCurNv1RCJZLLHVIzxZwmLb7vycMFo2eI+bnXe/IV7OBetg1J6E+Q1gkClIXbQcvU
	7tpT8VyYkxdHejv8ZRBKX7cYh6Sw7ixZLMyzViaGnHZG0E9k9s1XY7ttdd0AB/NK6rRcFVIRUYE
	Ff0+c8zvX4CJBIsfpE19Mot5Gea6an1nPZl+j05Lk+4q9sZ80k4rvwC59harO9PRejZcMuPu5QJ
	5lG+AMWJyHnoelIJWp9zWxzeWgqQyRNrL8Y4i2vqRX3C1npTTxx+qVD2KMN4xhpnDpWrmgfaVLC
	Epd8Jzv8SF0Ee5i58gUZy5SMyHBtcJPsudFThc+cX8LFrCv1AcF9EbTgmVA2pq43gi7nv+Xqcyi
	K+if/kGUzYJdu0xr7mM8Ultx0iRMGsxfpBZDQZnbjdxloMKhxhOKbTHjjdz9ifujH63atErw0+6
	I6crma4f00vUnNN1adKu6Jut8hEVhtPuY2il8pEXEAYaEPeOUj0VIZooCZXONUKZoLVnV2zQzUR
	WZ7IzgdV88uxNdGKRNk/+xWzwDnABaFwiiiTz6jRpXQEE8IBgPxJcnibY8xQ97DaScvlUvUgCUH
	/WT70B2GDQzfFO090cpnbG6LDDZuW8B6XU5EBnowOUb4FPw6gYd+S7uHCj4zNx4cHKM+Wvamb3Q
	57VTo=
X-Received: by 2002:a05:6871:287:b0:447:4fc:1da1 with SMTP id 586e51a60fabf-4a83f445ec0mr1555289fac.12.1792867520675;
        Sat, 24 Oct 2026 11:45:20 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a843231095sm1477278fac.17.2026.10.24.11.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 11:45:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 12:45:18 -0600
Subject: [PATCH v2] serial: 8250_dw: preserve BUSY-safe fractional divisor
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
Message-Id: <20261024-submit-serial-8250-dw-divisor-v1-v2-1-032ca5338359@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WO3Q6CMAyFX4Xs2iqbjKBXvofhYj8FagTMNhFCe
 Hc3fAKT9uK0PV/Pyjw6Qs+u2cocTuRpHKIQh4yZTg0tAtmomchFyXNxBv/WPQVINvWESsgc7Ac
 sRevoYOIgG15WF7S5VBWLmJfDhub9xb3+6ch4oAmJmy608gjaqcF0aRTCcooNA84hrTvyYXTLH
 nHiCfNHmlgcmkIKW2jNNW9uba/oeTRjz+pt276XvDWCAQEAAA==
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
has been confirmed, alongside DLL and DLH. Select the shared calculator
when fractional divisors are supported, preserving the core calculation
for integer-only ports.

Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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
 drivers/tty/serial/8250/8250_dw.c    |  9 ++++++++-
 drivers/tty/serial/8250/8250_dwlib.c | 15 +++++++++++----
 drivers/tty/serial/8250/8250_dwlib.h |  2 ++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index eca02e8bd6d1..d036a2fe258a 100644
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
+		dw8250_set_divisor_dlf(p, quot_frac);
 	serial_dl_write(up, quot);
 	serial_port_out(p, UART_LCR, up->lcr);
 
@@ -651,7 +654,6 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
-	p->set_divisor	= dw8250_set_divisor;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -768,6 +770,11 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
 
+	/* Use the BUSY-safe sequence for both integer and fractional divisors. */
+	if (data->data.dlf_size)
+		p->get_divisor = dw8250_get_divisor_dlf;
+	p->set_divisor = dw8250_set_divisor;
+
 	/* If we have a valid fifosize, try hooking up DMA */
 	if (p->fifosize) {
 		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 9bb02a4ab11f..88562c8d5d1d 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -23,8 +23,8 @@
  * we have: div(F) * (16 * baud) = rem
  * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) / (16 * baud)
  */
-static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
-				       unsigned int *frac)
+unsigned int dw8250_get_divisor_dlf(struct uart_port *p, unsigned int baud,
+				  unsigned int *frac)
 {
 	unsigned int quot, rem, base_baud = baud * 16;
 	struct dw8250_port_data *d = p->private_data;
@@ -35,11 +35,18 @@ static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
 
 	return quot;
 }
+EXPORT_SYMBOL_GPL(dw8250_get_divisor_dlf);
+
+void dw8250_set_divisor_dlf(struct uart_port *p, unsigned int quot_frac)
+{
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
 
@@ -217,7 +224,7 @@ void dw8250_setup_port(struct uart_port *p)
 
 	if (reg) {
 		pd->dlf_size = fls(reg);
-		p->get_divisor = dw8250_get_divisor;
+		p->get_divisor = dw8250_get_divisor_dlf;
 		p->set_divisor = dw8250_set_divisor;
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
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261023-submit-serial-8250-dw-divisor-v1-5f1689ed05a8

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

