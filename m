Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608355;
	b=IXgaO/2WRWqWKLYOEBAtnbKn8W0LS47TMbnlJq94VlMmQHd6OewbRLwx6NfHYM+FF77a
	 aSuX9uTss5Gf8mTP8OUz1tXIm8l/ljt1yeAeiWBr23xQWJvsqBQCbUNj/INX+fC6X4Q1w
	 wcvwfJ0IOMnYrDtl8ISp7YxqmfHEWojWDoh3IiEqroEDhZfZv9CrdyMcveTxOdf1SI+Gq
	 EtvRf6vns5FmZHCav1uMxM8HeWSb23CjoY/Np7VJzCNqbtTIOKtiwq3Y/rQYB6I9k+QKI
	 UMSTY77B13boxxWEUDP6hYBxsz3S0bW015dRts/Kq44bO6Gw5KTsL4jEqGz6e/LU4yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608355;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ym+lnSe4FoL/GNzNoOGkR/rtAvgpKxsBI0/L3qzLD3c=;
	b=CADwXpzov3hOzrd+Us8YNhAutteREFoLsmO+Z5Ld0WnW5W6NJMLXlfAwezkotDfu4Vl8
	 UVxSIVJBYvaMm/tJlASRw84sNNC0amen2Wqrd5xY0yecbz58Jd5BZFDziDUuAPGJD4Xqu
	 9YgBp10adzBdgrnd3Hq+LnsiEttSa2l8DaTEUw7mw6qS2l5ygYo0ca61Z4SQAyB09bYl7
	 ZgsRqhjhjv2Th1cDi+0coLc27jg/h+ORUPC5HL+KyubeTgiWsRyWnpcxg0bActZPbK/H5
	 hLPVZx64xiSSH+h7Zyi4Ilq8CTTCFHWUp3bJW5oxzFoOV8HTbhchRyzwS/yFC8JBhow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="Qsu8dr/y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012F606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Qsu8dr/y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E371F000C0;
	Wed, 25 Nov 2026 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608354;
	bh=Ym+lnSe4FoL/GNzNoOGkR/rtAvgpKxsBI0/L3qzLD3c=;
	h=Subject:To:Cc:From:Date;
	b=Qsu8dr/yQiADHaAeSt+EaHrp3tmcjdBtWHxy97VIo8XfKNA8tDzH+zc2CDT+IbV+5
	 x5zjE9KW2sTDH5wIQeBX9siVOUpC2D7IJkvFIu5XTNcmlllMOXJQq2PxHadfLmlhnX
	 3seshf5MpE4bqfHnZqIzlqSlhGljZIgO+O+KqG5Y=
Subject: FAILED: patch "[PATCH] serial: rda: free the interrupt on shutdown" failed to apply to 6.6-stable tree
To: josef@toxicpanda.com,afaerber@suse.de,arnd@arndb.de,gregkh@linuxfoundation.org,jirislaby@kernel.org,manivannan.sadhasivam@oss.qualcomm.com,olof@lixom.net,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:32:40 +0100
Message-ID: <2026112540-stoic-jittery-a891@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 859f7c56709b161a72b629b6f2f1384dcd374404
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112540-stoic-jittery-a891@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 859f7c56709b161a72b629b6f2f1384dcd374404 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 27 Oct 2026 12:06:46 +0100
Subject: [PATCH] serial: rda: free the interrupt on shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rda_uart_startup() requests the interrupt, and nothing ever frees it.
It is not shared, so once the port has been closed, the next startup
fails with -EBUSY and the port cannot be opened any more.

Free it in rda_uart_shutdown().

Fixes: c10b13325ced ("tty: serial: Add RDA8810PL UART driver")
Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20261027-tty-llm-v1-20-99b0202ae546@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index 87fa30d68687..9c1785771cbb 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -471,6 +471,8 @@ static void rda_uart_shutdown(struct uart_port *port)
 	rda_uart_write(port, val, RDA_UART_CTRL);
 
 	uart_port_unlock_irqrestore(port, flags);
+
+	free_irq(port->irq, port);
 }
 
 static const char *rda_uart_type(struct uart_port *port)

