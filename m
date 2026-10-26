Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030371;
	b=R/mILi/yt1/vG1k0Vme0hu5J+gSPH0KZ7ILIcDN2+M7O2kHQxD+FXWNySuvH+txq/wzm
	 O+QAPxWW1wctJR/xpMo8AmxlI/Yh9jcL7JTKsKnYNK8gfSxkI4rPTYUKNuJkl/uGBq8le
	 Gt4FnL8o+4cUv2377dOYX2usmdi7h3npPiFwK8i3wlXrKjSuX9zW6tL5fhV++GbtetUo/
	 Baw7lCCfY4ZXFiO7fbS13A7dBX2pbuN1EFq3V8zqvbiBOYT5L005splYYAYBHxxrUAQtT
	 bsG6Hxckq7eW4NjShN/v1UI8+A3k0mxyut/VYrqsNBQ6KXsbJub6yn3tQvj4LC34QpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=e98ochL+TXdfYlmwIPCFq67QlaEOT0xXDlADytWKVy4=;
	b=j6AV3CK6WzQy4XrldC18cLB9q/uTWXP4o4Ttp32zCOYI8AFB2AiItUVJES6BbhVLrKdk
	 yILRXHRQJ4HMSwwvTiHBiYhc6KRspWGsRBeRqr+IA3+PzWjMiYj9KtF7NO9+6c4HgW28w
	 g6D+wFGho9zh9u4g/6CpfWSvzBLMnTRFzyI5eCjrfYFf3PiQbCJ7DQHIHiJo5K79rfyo6
	 Crm4goiZardIvsQ9Qjg57xpIAeS4jwNdwNYvCEpAE3yZdz+mOJHTxBk72v55fJZjR0UB5
	 iVJt//1IBklV7F4hTFlmkHGVPqB+qpfWqKrtGuk3Q14GB745ibx2iaA1oWxvQPUu7pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KTH5o0sN;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE73606A321
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BE73606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KTH5o0sN
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-49e1251674cso1093562fac.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793030370; x=1793635170; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e98ochL+TXdfYlmwIPCFq67QlaEOT0xXDlADytWKVy4=;
        b=KTH5o0sNl925ss0FIwV3xUH3DYKlR4GR7wR4MWQ/PkcWOUKyBBNnWhOz1ocjVfrWbb
         iLy5cXsy2sthyYlcFRVAQ+at1Va/gV86LSC1k12D0QG7FhuhHkg17MQqCxz0dFPeXxfX
         Mjvlc0Cu1CIRg7WQZSpbgy8a38r38IUJWxl93RgocB/sl7k3xrn9a6RoyIskqb70Cfqu
         lyE18al8g0MwditSAVrppXT0gDy8htiEP/xw3D+Adn30iTnWHwySm0OnvElzvjrG2VIq
         R3jGEgFMgYV0T3tw2jbnWAxDvclXNa3QMCRrjS7Gi+pu95r1wrvmSjpP45pDFxXeK/0b
         4NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030370; x=1793635170;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e98ochL+TXdfYlmwIPCFq67QlaEOT0xXDlADytWKVy4=;
        b=hf6gC1hpIODt4KvVSqoOU1Rpc4JWfDsWFCGAYJhFPTcFXUvoq9ZkAC8NBregjpIIq5
         Zy/pEjY1OEsoY4NDR4B7t2Ap0Sf+1qruHaNE1AFFWXcPXM+6zY9XCFF7qrWBauhhVnam
         sZLJpL3TGvvLH4cW2vfqeZSRb4I/Ncw5FsWBPtkN6rdPK8xWmbYxwJwO9p88QiKAd3l3
         au3jUHld/F7/eio2T3H+uxVU0K7/LYkToTynkfV9lbwsbRlGZ7HWBpJM2p6S27+gunmV
         AAZkkEKxGv8CoAfv75t4QUbYZeQj6C3uuMCwCydA1LNtcXyFnQxSvmEa4PXYs6PBDMs2
         TsGg==
X-Forwarded-Encrypted: i=1; AKwUvByxN4kXcwPFKtPVmNGQlqJBN3G1DKRACVCdhx2FpXrfNHEvBK7aIPoMUhycSYY1qEZwFMCP2nE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4zixutPHpX/1grsPtCMyBMaTtwo8G64dLfyDEP7ByWLLNeeMw
	47nH6txTGh7XxHh3xnhglwMzskvzq7jVwLclAWax/yhgocs6/12VjuP9
X-Gm-Gg: AYBFou1F3rIHIgSeb+vI5kucvZBImkUvIM/gNDsOrFLrXjs5+F7cNe1BKL3DpmwF8mi
	E0SPnhNbWsWS+0Sz8EQ973qb196jE3GqDpJDVLabBOZwXS6kXZx6WRZJZmLH+xed1d9MoKwgpPU
	A05avOq2yoZTKXpNwMS6Y9ryZ69j9LggxcVoFw6uo9dNYPi9pXgqvH+i3mYg1FlkwZenajndBvl
	olLaND9GF13E0uguqD5ovoMXC/SL+n8lpF7vbYJ9OIDwQLfiBHCSuGs34lt2c/ffoSeFfbW/m4M
	4OiJ+hWBRB0Z/SRvIDaJOqO8oRjAD6FkefXxD5/GdkkGv4j7g3vtvdAHS/mLy9NkZG//sVLmrUj
	EmwerUBdF49AJ4HcxxDLVti+RS8a0yHShx9gNgKHqw/9YGyhCzQoWKkri19BnduEEPeV2aU4IAR
	J+k4KDa7XGGuxyNHYLV8uzV0Z6+L3QSJjDcv8GwbCeutwtNWoku/qWpdkqQDIoE2JtJxzDW89ZP
	axAiHdxuSd3+/ilEc5KujC4q5D/o8T3JJhaiqv6cb14T75wbXBeFyQqXNjtadUr5+nNdZUa/633
	lqsdXGbfcIxw5npm1CK5YSkWqlDdkUdR1X9X7DkxfF0tsDHM09UOTAPcm5aax2iszvnpYDJiuhN
	K+14ByrDAiy34piKhqtw6pfKn6PoQawX63e6wlLoOiVxC3kjxUSXpITbu4zMD/NG56x3PxzmCZA
	b1Tw==
X-Received: by 2002:a05:6870:179d:b0:494:b8f4:9a3d with SMTP id 586e51a60fabf-4a83f5d4d98mr4489414fac.40.1793030370021;
        Mon, 26 Oct 2026 08:59:30 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a843231095sm4589608fac.17.2026.10.26.08.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:59:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 09:59:10 -0600
Subject: [PATCH v3] serial: 8250_dw: preserve BUSY-safe fractional divisor
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
Message-Id: <20261026-submit-serial-8250-dw-divisor-v1-v3-1-7dbd194e1f38@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOSw7CMAxEr4KyxpBPgwor7oFY5ONSI9qiJJQi1
 LuTwIYlSPZibM/zPFnEQBjZbvFkAUeKNPRZqOWCudb0JwTyWTPJ5UZwqSDebEcJis1coJaag7+
 Dp2wdAowCdCM29RY916ZmGXMN2ND0fnE4fnRmnNGlwi0X1kQEG0zv2jJK6bHODT1OqaxbimkIj
 3fEURTMH2lyCWgqLX1lrbCi2Z86Q5eVGzpW0ozyG1j9AJQZyJV0RitVK739Bs7z/AIO1wcWUgE
 AAA==
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
for integer-only ports. Keep the check for fractional-divisor support in
the shared DLF setter so callers can use it for either kind of port.

Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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
 drivers/tty/serial/8250/8250_dw.c    |  7 ++++++-
 drivers/tty/serial/8250/8250_dwlib.c | 20 ++++++++++++++++----
 drivers/tty/serial/8250/8250_dwlib.h |  2 ++
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index eca02e8bd6d1..e823c38d381e 100644
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
@@ -768,6 +768,11 @@ static int dw8250_probe(struct platform_device *pdev)
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
index 9bb02a4ab11f..9125ef130a97 100644
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
@@ -35,11 +35,23 @@ static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
 
 	return quot;
 }
+EXPORT_SYMBOL_GPL(dw8250_get_divisor_dlf);
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
 
@@ -217,7 +229,7 @@ void dw8250_setup_port(struct uart_port *p)
 
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
base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
change-id: 20261023-submit-serial-8250-dw-divisor-v1-5f1689ed05a8

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

