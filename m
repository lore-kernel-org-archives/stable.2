Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608349;
	b=HmOazgf+WwQI5kHBiCIykn8l0suCC71tszQIGrpKb5gxPwc5TbabIVHkd9ZqLFGqiWlq
	 h5u1Rimrl0tYBJu9hQrzXV6Ipx+uelTGRecDNV+THsp9mfcj6oD9X4TvpJcSx76I7dmfz
	 9VcuOmbUaSb8M0688x6lFwcF1j0EYpnr1WqVpQU4ZX3j8GkMIdF4YlodFPLgoG4Jg7Ox8
	 qoHTu4VhViya02DTE5aguaU6EXlAFgzR7KmNWFGnY1Czjvjkf5SoD6s7KEkidjc+VsxOf
	 D9hwFxkVZSxe1Ws8A5h8QpONEotgS+MMIjoNyeMPIHz9IXAVxGGeYg1jHh4RKJpmrHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608349;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3CSevr4FJxTTv4ipFPeRrJigF1pfCqrwjZo8BsmHP2c=;
	b=ZKKAo9dxrTD8WTU7vZwGyn/C2oXZqHSzkH3rr+H8hx31yUphrsBnUTxfQbowGU75uzdN
	 CFH/F31b8GEX/rlOOHnAKdpUI0UekgV8MkY+bmYcGb9qO5DtWKRfwgpa6+BuoTdOyQhhC
	 Dwfn16Q4UG8wNzXilY/uEbN6cz5USMXcVdyvSZQPoXgPYsFo0WTs8glUNGxiex9SGOBbH
	 cRAhvRISkb4Roh3B5lJJZ9330RHv84koN5FdXqZZRiaxjPWCY0Cpk70PF0a9HRpVW6fKD
	 w9SodB6ag22GbrflfVKY4ZIIGYy7srzJwM9ifJJIhp12Yhk9J7fi+EGkVWLwC39tXvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pAgY3IA7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0792C606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pAgY3IA7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E79C1F000CF;
	Wed, 25 Nov 2026 12:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608348;
	bh=3CSevr4FJxTTv4ipFPeRrJigF1pfCqrwjZo8BsmHP2c=;
	h=Subject:To:Cc:From:Date;
	b=pAgY3IA7TXy3WdSGhVyk3XduEO9Y9wMlXsbv5Q1HPZ4+CHQcOUrAjh57pTRJ8X//R
	 390flV+jPIOa6LFsycefyb591tABtCbQkdqXDLyT34kHKvsgtZYQxQF4U6NBM6hWNB
	 ahATFgPq+LfV89e3x5cRKVQEFb78Hul+Cp8e8xHs=
Subject: FAILED: patch "[PATCH] serial: rda: free the interrupt on shutdown" failed to apply to 6.1-stable tree
To: josef@toxicpanda.com,afaerber@suse.de,arnd@arndb.de,gregkh@linuxfoundation.org,jirislaby@kernel.org,manivannan.sadhasivam@oss.qualcomm.com,olof@lixom.net,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:32:40 +0100
Message-ID: <2026112540-patio-outwit-bcef@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 859f7c56709b161a72b629b6f2f1384dcd374404
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112540-patio-outwit-bcef@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

