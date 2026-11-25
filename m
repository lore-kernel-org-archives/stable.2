Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608358;
	b=WHtMPxi51dVx6kt5eRgZJlk811i9T6bfDb0/kqpu1Lc0mgpF1f2MjmAPVmCMwf2KqIs0
	 OSiBnXJ9tEnwwPX262IBbviSQYe1+lu1o86jeIvmRVcIWHMC1CPY7Hwob7Yq/Kd8nzhKM
	 jk4DsaM+dgv1+N9MPRpP9kz6YrlIZu1rfo4PTGIe1DhstgdnvqUxxB4WkX/GLjmFD0PfZ
	 xmyZD5lI17LuHUte6dz4T8ptY1Vx17x34FRoxeOo5OpMSQ7B5OAuVal4V893N5rCdswOI
	 29c/4nB93A4GGCscXWL+YjMTkIRZKAfk4b2tRTwBmh5IEc1Lt2xumbUZxyqX5sa/zTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608358;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=d6OUJ/FECAkY1Ou64lpwJ4DlUE0jzopiRUmbSx0I5J0=;
	b=vnQ+X/GtTgYsFxEaat39yz4ozNNokvB3GI+hPjuBzVuMsFIHBwHpOf95FggjWJnVLhnW
	 ERHEXfK/sqs4eSus3JErFvT6N18AE07FVxPaXPN7nT69rbsaptZqTiV8us0T67IA4PFh+
	 Yp6YsDvKRgQnXypRk0HP19eRKE6KdVqj/cQItxozLK780yY+CQFLTi34358MG4oeqcVLE
	 yAT74oLkz2UKCZiGbED+/L9ZLcSRWu6Joa21TgE/mxtdy51irqXPDhWK9jxEMs8VRlC9F
	 hcrScHfFyJd7U9f0s6jPhNugANgndFXLBWW7i4miq6PIl8PlCzBYma2fjcP3oBK1j+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TOTp8iGU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA563606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TOTp8iGU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421FF1F000C0;
	Wed, 25 Nov 2026 12:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608357;
	bh=d6OUJ/FECAkY1Ou64lpwJ4DlUE0jzopiRUmbSx0I5J0=;
	h=Subject:To:Cc:From:Date;
	b=TOTp8iGUeXqPqeHXBNpSQ+CFn84GRktYMfhDao+XTTJ7ZVAl9luMVpUY/Yhtwao+u
	 XOOAD/U1asJqqNiR0iRbLDpF8tWO3NZEg04HlT3AU8J8pmyA82XS25dYcXDbwrIz5s
	 V9ymfgqgdWyBst5rjOexntRaz0GS2sPizzcNa8QQ=
Subject: FAILED: patch "[PATCH] serial: rda: free the interrupt on shutdown" failed to apply to 5.10-stable tree
To: josef@toxicpanda.com,afaerber@suse.de,arnd@arndb.de,gregkh@linuxfoundation.org,jirislaby@kernel.org,manivannan.sadhasivam@oss.qualcomm.com,olof@lixom.net,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:32:41 +0100
Message-ID: <2026112541-comfort-tidiness-5bde@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 859f7c56709b161a72b629b6f2f1384dcd374404
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112541-comfort-tidiness-5bde@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

