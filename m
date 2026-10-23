Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757817;
	b=ldX3a3LaLJ3nat7L40NscEr9keZw7ap/Yrhq/wjjdn16Aku+l0ob80Pb+o4wMTDb67C1
	 y0kF/zMiLm1q7HNGO9FPmehmQcbrbI0EJTy6GMjbpJUwDFN8JZeN+Io+h6MrVZtp3rDT4
	 ycEAMj8XwW7f+QENsDb0Q7yjy9I/tMAhW9DSA+j+vGQJPeg41VNmSnBDn4k2UmMrAIfgu
	 8TKEJf9jN8pEclrpuNx2rtbMXbhJLlGvEWQ67uKrC5iP2vgmGXKELbVCjSGBY3mUZHNCs
	 HkHprmduw3eHXnljBcvL/qsePWp0nptEkqudVik5TXvjkooTi3IMoGvhrE2fypATCsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757817;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jBhRB5dUFh9oSjNWafUfPVccMDoYnz39VGsGqSFvwQ4=;
	b=PSo/Crk5ZyRFAdLBAo+V5DdqVfovf05Satyo51Av63TxIGTS0iukh2GLSAnCEqAcEB6i
	 IDCwUC+0Ybwzddnbl3WiyyL7uHAQYh68DnzrDbYA0eJ2VsM92pRy/HsMIMHNVyF6bGJCf
	 4B9X/HFtuENVCoajuIztdwBjOpg7Fgl3OgtL3w6P1KD5rz61d1aJ5Cw0+D72iT1DyOBMd
	 ChAyCkGgaBdea05JTXwxgbv4+RtcOKJNUKhzd65knZHCwvfaYCwIhViPxlsM8Ek++/gkB
	 6/NUk4UOsgbtIJZWBcH93bPL8EycFINfS+3stPsQrxpMsIYR37/OFk5NVWsuhSOTM0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qx7TDB9j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804F1606A330;
	Fri, 23 Oct 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qx7TDB9j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C0C1F031E4;
	Fri, 23 Oct 2026 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792757815;
	bh=jBhRB5dUFh9oSjNWafUfPVccMDoYnz39VGsGqSFvwQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qx7TDB9jZcE9Gd2aMvy6N1DA6zNIQ4LAK8LwO0twSSorUaCSSREPepseYcu/4w93N
	 T98XSHBSJeEUuAKo6lsPjWJi4Z/E3vQak2t3Zw+9XH2Vt/+0yzUkij4dcAYfZ6ta9/
	 tsDJLVJhl7iVnv+vLzmx1qMQdTp0II0tKMhFlU0nFk73Aw4HkEuQRI7iVxLqiWjE2t
	 slPMNj2bWgUEiOQdiPkXDPVlijWUtJM7Oylzx6YQsmmrlzfKVurX/I2AoUvi/bUB0f
	 +4W6ZADRQSnXTRu74tjA5chZNkUPxwTIgPaJMonCMTVcpCCe+0GDhfikWPdBYl2j9J
	 tV87av4F+Id1Q==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xKECb-00000000mZQ-0LbM;
	Fri, 23 Oct 2026 14:16:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 02/12] USB: serial: io_edgeport: fix potential close() use-after-free
Date: Fri, 23 Oct 2026 14:15:20 +0200
Message-ID: <20261023121530.186541-3-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023121530.186541-1-johan@kernel.org>
References: <20261023121530.186541-1-johan@kernel.org>
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

Add the missing open check on write() and locking when updating the port
status during close() to prevent a racing interrupt completion handler
from trying to submit more data for the port while its write URB and
FIFO are being deallocated.

This issue was flagged by Sashiko when reviewing a related fix.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260714101316.823942-1-shpark061104%40gmail.com?part=1
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_edgeport.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index cdf41e86ba44..a5011fa91ee7 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1085,7 +1085,9 @@ static void edge_close(struct usb_serial_port *port)
 
 	/* port->close = true; */
 	edge_port->closePending = false;
+	spin_lock_irq(&edge_port->ep_lock);
 	edge_port->open = false;
+	spin_unlock_irq(&edge_port->ep_lock);
 	edge_port->openPending = false;
 
 	usb_kill_urb(edge_port->write_urb);
@@ -1127,6 +1129,12 @@ static int edge_write(struct tty_struct *tty, struct usb_serial_port *port,
 
 	spin_lock_irqsave(&edge_port->ep_lock, flags);
 
+	/* avoid accessing freed fifo if tty_wakeup() races with close() */
+	if (!edge_port->open) {
+		spin_unlock_irqrestore(&edge_port->ep_lock, flags);
+		return 0;
+	}
+
 	/* calculate number of bytes to put in fifo */
 	copySize = min_t(unsigned int, count,
 				(edge_port->txCredits - fifo->count));
-- 
2.55.0

