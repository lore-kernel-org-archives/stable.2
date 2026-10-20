Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521807;
	b=OUp66bA86ACCTFq4rMoNDdaqrsc26uSh3yh5W3iQlmMbNCw+xczHfFxqFIfsf7WmT8+H
	 Qe4Cdr/Xm6uVdcOxcbCBjr7Ldfqs8rWXHwUwDjs3RCLPn13XkcXEqsxZZAEkmIYShICoQ
	 uT9TF3UsXBOSIAkeevF1bvU7ViSC6e3Kl6G8E1NOD2yg2YNNUVvFyzpN6UpLDZbUzlKjp
	 ZvejQR8e9iuG4I+M9jc8qVem4gtaTt2c66mqC1n9xiJzIEjt78OZUC6Uq7LJIG1rDzvFl
	 /ELS6BhJs55KnRXw8MDJG9GAWjScL8e2DIPJFTY6ciihyONyzrg2jtNPLEJI93E0p6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521807;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=WZwvj7ut+USYDUgtwVCO9P11ZllQcMYIU3Z0c/E/KP4=;
	b=g4R9LAKrFf23gfUySUCGTnKiDcX4ehnh/utQwDrwrSA1zZa2N7f7YCVqSyTrexPMWaBI
	 WSbW/bXK8Y2JkGCGFJf/UOpIcE48OIKvXmaJhtaMH86z26J4bUDNqYP8YIDnngspcK8W+
	 oF7sEOMkR8rvRTDs8dvWBUfsK3sJhADPaZuSTTN4jGShAtnIFSMXX/VR+MwvXMt1XU6Cn
	 0OurExRFNnFcR7XnJ6LLOVabpxPfBX5Z0q1d52UgiI5fCMsG+uJpyl7wMOJ8zOlgtwTic
	 tKUprvZQyu3hczaAN5vKRd9OnI7w6vj7Pxb6m7yV0YDQ4bdQx6jq+opgiofgnzdAsaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=cjuQnMjf;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBC5606A320;
	Tue, 20 Oct 2026 18:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EBC5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=cjuQnMjf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=WZwvj7ut+USYDUgtwVCO9P11ZllQcMYIU3Z0c/E/KP4=; b=cjuQnMjfS8juJ1uDt8dtjyCHoi
	v2vk6aBnmafw7NW0a8zGCSQl2e0CBXOGGx+WSFZ4xurZd/EtIM5lVgjDq4m4QzQ1N2fjCusoPIOJ6
	maamZ3dQJbfNnN34JId/Adaa8tvlloXg1anQ1K2EuMTY+BpAcrHTJYdmvwxg/hoU3yok=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xJEo0-000000000nG-1lhU;
	Tue, 20 Oct 2026 14:43:22 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	alan@linux.intel.com
Cc: hugo@hugovil.com,
	gregkh@suse.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH 1/5] serial: core: fix division by zero if old termios is present but has invalid rate
Date: Tue, 20 Oct 2026 14:41:17 -0400
Message-ID: <20261020184131.2893575-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020184131.2893575-1-hugo@hugovil.com>
References: <20261020184131.2893575-1-hugo@hugovil.com>
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
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

If the old baud rate termios is present, it is implicitely assumed to be
valid. However, if base_baud is lowered via TIOCSSERIAL, and the new
max value is lower than the old baud rate, the later will become invalid,
and uart_get_baud_rate() loop will exit, and return a baud rate of zero,
causing this:

  WARNING: drivers/tty/serial/serial_core.c:547 at
    uart_get_baud_rate+0x104/0x180, CPU#0: uart_baud_test/782
  ...
  Division by zero in kernel.
  CPU: 0 UID: 0 PID: 782 Comm: uart_baud_test Tainted... 7.3.0-rc6-...
  Tainted: [W]=WARN
  Hardware name: Freescale i.MX6 Ultralite (Device Tree)
  Call trace:
   unwind_backtrace from show_stack+0x10/0x14
   show_stack from dump_stack_lvl+0x50/0x64
   dump_stack_lvl from Ldiv0_64+0x8/0x18
   Ldiv0_64 from div64_u64+0xb0/0xd4
   div64_u64 from uart_update_timeout+0x3c/0x44
   uart_update_timeout from sc16is7xx_set_termios+0x308/0x428 [sc16is7xx]
   sc16is7xx_set_termios [sc16is7xx] from uart_change_line_settings+0x34/0x1a8
   uart_change_line_settings from uart_set_termios+0x98/0x13c
   uart_set_termios from tty_set_termios+0x154/0x208
   ...

Reproducing scenario:
  set serial port speed to B115200
  set baud_base to 9600 via TIOCSSERIAL:
    this will lower maximum allowed baud rate to 9600
  call tcsetattr() with B57600 (old = B115200)
    uart_get_baud_rate() will return 0

Fix by running the loop an additional iteration, so to always make sure to
return a valid (clipped) baud rate if old is present but invalid.

Update confusing comments about @termios structure update: it will be
updated only if the desired baud rate is invalid, and also if @old
contained B0.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Hui Peng <benquike@gmail.com>
Link: https://lore.kernel.org/all/20260930125901.778868-1-benquike@gmail.com/
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/serial_core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af41..c3c1a1d76405d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -465,12 +465,9 @@ EXPORT_SYMBOL(uart_update_timeout);
  * magic 38400 baud rate (with spd_* flags), and mapping the %B0 rate to 9600
  * baud or min argument, whichever is greater.
  *
- * If the new baud rate is invalid, try the @old termios setting. If it's still
- * invalid, clip to the nearest chip supported rate.
- *
- * The @termios structure is updated to reflect the baud rate we're actually
- * going to be using. Don't do this for the case where B0 is requested ("hang
- * up").
+ * If the desired baud rate is invalid, try the @old termios setting. If @old
+ * termios is absent or if it's still invalid, clip to the nearest chip
+ * supported rate. For these cases, @termios is updated with the fallback rate.
  *
  * Locking: caller dependent
  */
@@ -501,7 +498,7 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		break;
 	}
 
-	for (try = 0; try < 2; try++) {
+	for (try = 0; try < 3; try++) {
 		baud = tty_termios_baud_rate(termios);
 
 		/*
-- 
2.47.3

