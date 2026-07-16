Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BBE400982
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211846; cv=none; b=c3z0a7TmqafFh+PZtuCiLOTW2RgO0Isf0uxK5DGw92MrRnAePPwaw689flf53DJuTDnTdK9ABXZtT3Nf3mgD/rG+fqdVZAz4cIMfKatLkXmMGB+x9nkvwrHFB8v/StfsxIVmhul4qtFjWxE8v9cFAwrGG4PbWQZTkdq+PxvEQPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211846; c=relaxed/simple;
	bh=NoYERio/mf4DLekWv4MCy7+mB4/+mSN3HNuFTWNN6Mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NQOEjlk12RXOuG+nkh3QI4C0EVVc434gYdMtvWaXfDEhzlE++t26m/+bkt9/bHirjXeA++tNUf1NZoRwc2XaJdRtlztF5KGQ8dZUvFFJGvbwkWRzydwM5Hspu9gZjk0lRmKIOg8EfyBnRUp0xWvSyyjVTlcJcmyVTEyvL76T6z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqi/9Vnr; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqi/9Vnr"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e53581361so495836985a.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784211843; x=1784816643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lMekRXzh3ZMunw4GPDw9aK7U0CvdM1LOGZ4vytcNb5w=;
        b=Hqi/9VnrwjIePqI4WJUS3e8sp3WN4+OLk0id10ywVTgCTW4aghiClcsh3ocPGf0Urn
         i+z7+Vm3TGhfN6JFpVBwWa5vbjUV7eA/ak8i+eqh/sfhp16dnRb6O71jqQ/FMd680Z5y
         4J93rDclWQUyPoX3+Nqtypa2Vv6ocbUXxC2eizH4TkLof/7rb9Fb8DGGiWIvkDP4Ao+0
         sigamZJJf/9s223fushXetzywAe95V1ODs3G6WQCKNhAS0xTw9dl1llRb10+58jyEt6h
         qCZKF/pLEkbbiz2W39+wmcz0bCJAyoiTQ/LNhBqNjMtGyb96pXziXiUtAZ0BCKc/jrJU
         cdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784211843; x=1784816643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lMekRXzh3ZMunw4GPDw9aK7U0CvdM1LOGZ4vytcNb5w=;
        b=kC0Tf/cLedP/7U9SW/Fi2MWwuJ2/OWluBYswW65subiuTYl1U6q/j2vZkD8kZouXsC
         IyKRS9KeXYFgWBKGPYR/HKrZmV36eU7u4VegFPCa0NtwoEMs1DshhNPl1M7m3CszWIwJ
         6CCRVI9CObBoyPgMheJYQRCzV427zlwv4pavPnsmllD7Ny6p4vredafWsRmlcmPacv97
         yvTqioro9kduSzju3Us5Bsb9zxMzAKgYWr1r9YhofvnqMA8vktZyU+Sya+VzQjllr5Ga
         NNkzGQcAhfeN0qZgOmPWND6f2A2489HR6kKLoRI9x3cmN9UIaruq19Ujjcq+6uOOrxOw
         j7vw==
X-Forwarded-Encrypted: i=1; AHgh+RoZD+GbK7GpmhSE4W8CBDXJ/5pde5LvMhq1DpcKii4gsYcutDQ4uSwBmkA8Ssg9mKCtv1cp5Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXah0bL9STm6ezrl38ZJV/8FZKDSC6sWdjLIGKr0o5KIOj+DW8
	9W1SvDEoWpvh/jCL1Xq59oY84T/GDrGI2vMUZGC7uBJi1ueNo2FMPkU=
X-Gm-Gg: AfdE7cnJPH8hHy6KF2MQjD2Ka56oyfqR0gO5PFu4friCbf7Dp9w8SCrmXtkzPm6GubB
	7fe+igw9btr19eCmsC3fQKOswWdMjFQEa2dJCMZjDmc+85ZU31PSxHR7E3Q9Iv5vXBroyziMkNE
	s6aLcrQK6zpfpYjTBiV3/yZ4FLcojsiIRCwShsWVbHBVQj4Y2eBJyvNHb1Ux6uagEsMEt8znrPc
	7tVZcp949bKsxB5Tg49wN+fGFqSl0Lkg/THgbrs5zPl3DR5J18PGrO817FXomSZbEZjom2AivJO
	q5IX9r7Sx81Vzm4K0MwiPZT3z53sKgfsZ7+yJprtjXXAyAJ+Q83LBd0KLGV1KcaMVpSkpg1KUYA
	rb423JAhcwJ7Gvlp+uVII73Bu/OFUVY9vi1YNhMoJZZVziy/1zhtdi/JnikhbwsfOfMlR5DAMrv
	TkmN/3+9X1Ovd79EGgVGT80U1c7BPzHyhbRvtx2+9RsKWgegdP22pO2PpdDn//0ImD1XULIEbK7
	b7A
X-Received: by 2002:a05:620a:4008:b0:92f:c78:559e with SMTP id af79cd13be357-930962068c5mr779979085a.35.1784211842868;
        Thu, 16 Jul 2026 07:24:02 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9d9bsm2021169485a.28.2026.07.16.07.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:24:02 -0700 (PDT)
From: Ryan Wilbur <rwilbur633@gmail.com>
To: ryan.wilbur@nautel.com
Cc: Ryan Wilbur <rwilbur633@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] serial: 8250: clear stuck RX-timeout interrupt on LPC32xx (PORT_LPC3220)
Date: Thu, 16 Jul 2026 11:23:57 -0300
Message-Id: <20260716142357.428331-1-rwilbur633@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LPC32xx UART can latch an RX character-timeout interrupt while the
RX FIFO is empty: IIR reports UART_IIR_RX_TIMEOUT (0x0c) but LSR.DR is
clear. A character timeout is only cleared by reading RHR, but
serial8250_rx_chars() reads RHR only when LSR.DR is set, so nothing ever
clears the condition. The interrupt is level-triggered and re-fires
immediately, so on a single-core ARM926 the resulting interrupt
storm livelocks the CPU.

It is reproducible when userspace repeatedly opens the front-panel port
(ttyS1): serial8250_do_set_termios() re-enables interrupts on unlock and
the handler then spins forever with iir=0xcc lsr=0x60 ier=0x05, tripping
the soft-lockup detector in serial8250_handle_irq_locked().

Fix this by doing one throwaway RHR read to clear the timeout. It is gated
on PORT_LPC3220 and only fires when the FIFO is empty (LSR.DR clear), so
no real received data is ever discarded, and it is a no-op on healthy
UARTs which never report a timeout with DR==0.

This is the same class of bug already worked around for other 8250 cores;
see commit 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
which reports the identical iir=0xcc/lsr=0x60. See also
UART_RX_TIMEOUT_QUIRK in 8250_omap, and the note in 8250_bcm7271.

Cc: stable@vger.kernel.org
Signed-off-by: Ryan Wilbur <rwilbur633@gmail.com>
---
 drivers/tty/serial/8250/8250_port.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8c241ec7f4f2..20014f54637b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1803,6 +1803,20 @@ void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE))
 		serial8250_clear_and_reinit_fifos(up);
 
+	/*
+	 * On PORT_LPC3220 the UART can raise an RX character-timeout
+	 * interrupt with an empty RX FIFO (IIR reports RX_TIMEOUT but
+	 * LSR.DR is clear). The timeout is only cleared by reading RHR,
+	 * but the RX path below is skipped when the FIFO is empty, so
+	 * nothing clears it. IRQ then re-fires immediately and livelocks
+	 * this single-core. Do one throwaway RHR read to clear it.
+	 * Same bug worked around for other 8250 cores (8250_dw, 8250_omap, 8250_bcm7271).
+	 */
+	if (port->type == PORT_LPC3220 &&
+	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
+	    !(status & UART_LSR_DR))
+		serial_in(up, UART_RX);
+
 	/*
 	 * If port is stopped and there are no error conditions in the
 	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer

base-commit: da7b5fd4e17f8e44c5590f2d603c01d499f056e6
-- 
2.25.1

