Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE76C42377B
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214398; cv=none; b=ZYNV2AQLHzroiYsDRBW0dbtoqBLlZFCxmDuB2eq1CCZCcoATUAbE1EcxsstpWYiLDEKW/3/X0eilZxuVST5xps9Nn8TSTZ1n25czUn/eu5RqjbW5UBPO0MicFnT7GGBPm//lEZiRAt25IOKUQwO61rsiGjtAENwf9+21Q+s5S5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214398; c=relaxed/simple;
	bh=NoYERio/mf4DLekWv4MCy7+mB4/+mSN3HNuFTWNN6Mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sw060WKRTz/1I0etuL93DO/PUp0Um0X3cQGEdA2xkcIdSkGg8enxEdMJBJjP2a1XqqbSfXY7JhkqtMw9atDZ8P3qTGteWBEh9Jd3kFMXZpazZear9RjCgX/V4O8HJVQi2yzxfEG1eKJKRAa3wIJjfKYrMnnmJ06d0v0SzFquivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPR421Ru; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPR421Ru"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c2a818fc4so55005711cf.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784214394; x=1784819194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lMekRXzh3ZMunw4GPDw9aK7U0CvdM1LOGZ4vytcNb5w=;
        b=rPR421RuzIDOQStoEz3uoLcg41HKrcblWi/82QmHtl68F20/CtiAxK+Sug2YTpnZaF
         8m2RBLS3rTLrx5HieyHQ6NpRegsMa7kJVUDo6OqLB+vCB1mf8Bm0pPnbH7yXX2lDjkmx
         EPMpvmRR7H5JFf/eoc3fnBjOZps/ua4zWSeBxdQVNqbFOvKppq7B8xvpIAZakHPBYhYk
         kr8t/KagP6FP/HKk1aEpb4tZNJhCAm453nz9ya3aTu9pzedofwH/QJh40l7KyOxbOxT+
         VdSCUmiUqeIE6D4mfxbdTi0igeLqKQ/bdqCZHtSjRRUiSIVCSX9Gnd6Mrol2BMDi2SrK
         hHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784214394; x=1784819194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lMekRXzh3ZMunw4GPDw9aK7U0CvdM1LOGZ4vytcNb5w=;
        b=fF6y45gZK3mRxPUhcLFxvKne0NhiePFDCE53KNiZZwcr5QkTE/sLF6bgMdmkqZRRN1
         zWn9vwXelOhXpGTFXFCbTpaHD2CUyQXCs+RoVKTwTqg8uhwm1Yi6rRiEHysDh+/l6lrm
         +lO/bnm1mB/swbXhGC5MnwJkHojGtFtgty4lo8MkizbnYB7XzgSszAMfX1f/iI0IcPzM
         GjRLEtpAFS7EyzD9JainNYJYENwCh0PjRGnZkH5GtdyxED7q0vv7qBNkJnGlH1I6j26u
         TFOEOFNIx2mlq9ZnOpO1D7apugUQhLd8XshnIXOpY3GRcB17usrvG4rz9ZVuxVLhLIfA
         k/2A==
X-Forwarded-Encrypted: i=1; AHgh+Rrc/fZIH9/dnbX73sz2d7puGTPf9t4OlIbrQeIx6qh7P35EHHINayEBFNhkdx1sQKKISdxAUVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5z7M6C2ePEjuN4j2vldmenFBMyFDRftM2ARLgB2afOYxBWcpH
	2Vloi5dC9iQRI8HmunwNQvQsVlL8vOkbqwLW0htZrUmNMqLYVdOONgCAFrtGxBw=
X-Gm-Gg: AfdE7ck4kbK9fUWP8d12HrYAZi8FEYZiQYiXxZHIKOaVb3C5vrYsaG+k8vM9SFPFhxU
	0ltbl79UqFPCLx49nof7udQ4RWqmR0ga5rqGE8ceXD/vvcczcFQXDKFIJfGxhezxlS80M/E2U0n
	KiAoa5Wdpycwa9VUmVIr7zjZwB74iOOc8C6dmIbZwK3WGer3mQAU/vY6mXWoZrdLm0g91J0mtIx
	83vKOH26VoJxSaQOHex6Nwq1MRA+CgVQPZn4fhFwSCBlwSIEN5k8x379b9dBbMelfFBdvIHCWx8
	vK79iczft3/S64xJVtO7KOp2ivtxySGRCDJqenq2ZQssw+v47b3oRS+Ih5yGmWGMDuC/Adcm1aN
	BICF5YuddgtoqejS63ECuJ72sC7u14X9R2J5yWoQM2vmGIW3rmEkE5oK/ozmb1XaXthZ8i37z1h
	OLAnZNQJqsGqKMhumYLYybh+epsl2mOSw4HrHHh8RKW9sZvSaII5ZEPiI=
X-Received: by 2002:ac8:6f0f:0:b0:51c:7b12:6005 with SMTP id d75a77b69052e-51e4f22e571mr80144171cf.81.1784214393651;
        Thu, 16 Jul 2026 08:06:33 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5200ec22fa7sm9324611cf.18.2026.07.16.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 08:06:33 -0700 (PDT)
From: Ryan Wilbur <rwilbur633@gmail.com>
To: ryan.wilbur@nautel.com,
	lmorrison@nautel.com,
	jonathan.downing@nautel.com
Cc: Ryan Wilbur <rwilbur633@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] serial: 8250: clear stuck RX-timeout interrupt on LPC32xx (PORT_LPC3220)
Date: Thu, 16 Jul 2026 12:06:23 -0300
Message-Id: <20260716150623.433496-1-rwilbur633@gmail.com>
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

