Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440414;
	b=4drEmJ4tav6/L+z9iR3HjrXe5spItL/HKvy412kBek4GFP5eKJZ6FK9i5ZlfuNkAFMCC
	 y0RdeyfOA1bYvc7c+XUS5bvziMy9PjUjFGLW1Qu1KjhGc9fpWNxUKYUUi1vnrcKDaizqX
	 ThpHbt33lD1Ad273O8SGyaQdTWSV5ojCsG2u1Hop/p+VcNZ1cPaOB9bI/DVSYq7FGRYFT
	 juCmeIOBR9CMBJVIR+hf4o6YqWkrBp7DxQvCeevq8mEDFbdXJC01tGmgfMS4TutJWXiSj
	 SHAi2mdrywUF6AMLZmTnHp1bXBR0WMCFJtnWQVgiBC5C8ywzdfbJddco9HKtc76S6DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bFBNSvs3JDos8tPW/MP3a/GFNwGRHv00G3UEulH7lLI=;
	b=ATSoR6nu10ssK0GiWIeur3v74TvgxJDHM7acOe7WHuckPlMa5EkXOLs4Fog5BOUOq3Cq
	 o4hvzGTrLIxD6RpVq0+jtAzjpaF/bWn42UfBdVqvFAeb4VFGEoDstHugGWm4lVxOwZkpH
	 vFv1kqqSUu1/At7e51Ktsvxa/OKoGl0go2z3cavSLlfkBei2KfCreoiH2dc6Mlgrwj1E5
	 7xFniBcRfxuhZadBWT8Jw4pEZOZ8lqTNdcy9KVZQxshfbwC5xHracrdEvIskrblxFNHmw
	 rcF6E6/vfA/VJeriwI1wFDkTS2k5UxmgpDQBFEYus+9aoK4haPD/rtsSZ1xaTchJ7UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k+ReZMKd;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98C606A324
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C98C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k+ReZMKd
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ead32bc7d8so693130e0c.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792440413; x=1793045213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bFBNSvs3JDos8tPW/MP3a/GFNwGRHv00G3UEulH7lLI=;
        b=k+ReZMKdSageNNAFjvrEadRNGjsGPh+Xmau7wqs8rZ2ffw4znW1ZG3ruaIGAiKnr3k
         QYPljWbMks7XN124ne1Vfq7CFlVC1B7J60Q7LVufloBuonm7c03YUX4ksw2uQ1DrPcln
         i7qtPXw1PPqlMPyYyA1do4CsBAwRlRFEE3ZcP1CGfL9cBnr0b89u8vSnOBWjQte1Czeq
         lq4djU4PWBh5deuZpR16ZUrH7rqTaZFEqMFWz2BengDZ/wnaW9yanookAqhxJc7ab2RV
         02fFg9OOxXlHShMQLKAdRCuJZqAXPi3QLJBtlZapPnxZ4LEjZYQUlue5pIGJDq8vKMLm
         jmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440413; x=1793045213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bFBNSvs3JDos8tPW/MP3a/GFNwGRHv00G3UEulH7lLI=;
        b=FJKdjSLt9/kdf4sExSWxCSMn9XTA29gedJXgUCOTBvUDD1jQL6RWNVFWjdbFsTXClu
         8mYpDTYfeGHhDeXSgMUKYU6tcHn6thz/xdCvGhCoMKSZSDw+NezdYhH6XhhWSxLOMXYq
         0apFMjYEMe4jwrPA8DdwOdiXMueZ32YI52I2Cyg2+26N+t56xa3ZKE/6B7I1ZiQJnaEa
         LIaA932/KJkp9C7FygCePa+Urvs3kDq4nwiGEQfAdEl3PfsrPvPqz5SQaKa7LoWEdyZJ
         wb4qqnZKyTDc4En088B5lHDk3JTXffh2yWThOjus0eDLZ4gHUlXrJNYp8pWVwcieJ/jb
         UAIw==
X-Forwarded-Encrypted: i=1; AKwUvBw7wRMm2v5G+vD0wLTqVNPDCW+mMZn3K7Gv1Heveg5mSdTbHtv8ylsqKGNgyOMsQjSmyZHFnfI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWNK/Idtxrs+u9ueOrZOx3mziIIrJSSoLL28XXd2xnwopVHb6L
	STKANGGPw9prNwQ0Z/Yy9+pn/7hf0pfeHrF2cYXrsvZiP0a3T1GckTNw
X-Gm-Gg: AYBFou3YzQHVGVofuFqfIn8S5coJRJ2CXbenVG498VyizRb/lVomFm+ht6RsH3eaxHL
	X7ponkZSHkWdTAnGUiGotc6Je9X2O7WBGAYxU9uT6SsB+L9AYlYQD7ZFdIDORAg9OAL6PMaHaNt
	Y+cDRQkAaj4PeZQtg1DjTkgjwPywmbAHB/daLzJJEcPHuF8uXxokTX1fbNY11z5B4Feurapkp3S
	GxAaTE+OK/Iwb114vSbG2eLnubEY3jGWCeAWr56eIZHzxPFcLMc+Wh2PMhi8D+tLbj5R0h7ALFK
	pYPp2Hpyl5ViEMZ+R5vtn4dj8tRvHh5eu5g2unZyiO05p5EXZkfP1T03lOvR7phsnr61xDzCBUW
	VYReTyAWmI+Q8Fv9I35/bB/mbghe92JE9NmilgIlzMDtEOuAKOooycj9VZwLlih2lYGZIa+ghtk
	ZOC6MaWxQYnKsnU+uaUXir63RohOCa6crgzB29KLffNS8xWGZkkfUxfuEL4PBBSCdKvneEcgxTx
	awAezuYjIGjrDKhe2yFh+p8LvsqpUYuHgaJz/vAydBqb511tBTh6+RNCHEanfJSty9cJ2nicC5z
	25yyPRw=
X-Received: by 2002:a05:6122:1c02:b0:5de:ee96:75b with SMTP id 71dfb90a1353d-5eaaa68b961mr2904319e0c.12.1792440412948;
        Mon, 19 Oct 2026 13:06:52 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.244.163])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b4776b5sm10451611e0c.3.2026.10.19.13.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:06:52 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
Date: Mon, 19 Oct 2026 17:06:10 -0300
Message-ID: <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dw8250_probe() installs dw8250_set_divisor(), which brackets the
DLAB/DLL/DLH sequence with dw8250_idle_enter() and dw8250_idle_exit()
so a BUSY UART cannot drop the divisor LCR write.

dw8250_setup_port() runs afterwards and replaces that hook with the
dwlib divisor hook whenever it detects DLF. The dwlib hook programs the
divisor through serial8250_do_set_divisor() without entering idle,
leaving the LCR|DLAB write exposed to BUSY.

When termios changes while the UART is transmitting, that LCR|DLAB
write can be ignored and dw8250_check_lcr() retries it between
dw8250_idle_enter() and dw8250_idle_exit(). dw8250_idle_exit() then
restores IER while DLAB is still set, so the value lands in DLH. The
real IER stays at the zero written by dw8250_idle_enter(), and the port
gets no further TX or RX interrupts while up->ier says they're enabled.

Do not replace a divisor hook the driver has already installed. Program
DLF from the BUSY-safe hook, inside the idle section, through a dwlib
helper that checks dlf_size.

Observed on an Allwinner A733 (Radxa Cubie A7Z), where
dw8250_setup_port() mistakes the RS485 control register for DLF (see the
next patch): the first interactive tcsetattr() during console output
left hardware IER at 0 and up->ier at 0x07. The shell never printed its
prompt or read input. With this change alone the same boot reached the
prompt and echoed input, and hardware IER matched up->ier afterwards.

Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
Cc: stable@vger.kernel.org
Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c    |  2 ++
 drivers/tty/serial/8250/8250_dwlib.c | 16 ++++++++++++++--
 drivers/tty/serial/8250/8250_dwlib.h |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index eca02e8bd6d1..4c86aaf9c121 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -197,6 +197,8 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 	if (ret < 0)
 		return;
 
+	__dw8250_set_divisor(p, quot_frac);
+
 	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
 	if (!(serial_port_in(p, UART_LCR) & UART_LCR_DLAB))
 		goto idle_failed;
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 9bb02a4ab11f..325793f20256 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -36,10 +36,20 @@ static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
 	return quot;
 }
 
+/* Program the fractional part of the divisor, if the UART has one */
+void __dw8250_set_divisor(struct uart_port *p, unsigned int quot_frac)
+{
+	struct dw8250_port_data *d = p->private_data;
+
+	if (d->dlf_size)
+		dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
+}
+EXPORT_SYMBOL_GPL(__dw8250_set_divisor);
+
 static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 			       unsigned int quot, unsigned int quot_frac)
 {
-	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
+	__dw8250_set_divisor(p, quot_frac);
 	serial8250_do_set_divisor(p, baud, quot);
 }
 
@@ -218,7 +228,9 @@ void dw8250_setup_port(struct uart_port *p)
 	if (reg) {
 		pd->dlf_size = fls(reg);
 		p->get_divisor = dw8250_get_divisor;
-		p->set_divisor = dw8250_set_divisor;
+		/* Keep a hook the driver has already installed */
+		if (!p->set_divisor)
+			p->set_divisor = dw8250_set_divisor;
 	}
 
 	reg = dw8250_readl_ext(p, DW_UART_UCV);
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 39fcb1b323ad..4bb0ccb3e8ef 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -99,6 +99,7 @@ struct dw8250_port_data {
 
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
 void dw8250_setup_port(struct uart_port *p);
+void __dw8250_set_divisor(struct uart_port *p, unsigned int quot_frac);
 
 static inline u32 dw8250_readl_ext(struct uart_port *p, int offset)
 {
