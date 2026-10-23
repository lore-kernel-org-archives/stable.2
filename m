Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757816;
	b=0wl8dKbpALnUC/Fdjq1u6pnSjd1/bqpCVS8O8pPgEKKSs7rYa5FP9fS25lRU9MOQadxf
	 /swE9BKhfb5WoN3dQO68X80xybh62GgskVJ+1tbYtIrge1OrfrmItzU056ve0sIC6VQtA
	 /kf6GNzzjTAlpuzi553PvmkyKh2J+7MulSpWipeZ1pLIfuSEXAt7vub2LywpfhioTtwAk
	 Yy3BeuJuEJExxkBe6AvffYd6b72EapMrDhF7/lk740UaRddQ3OBqf643C4OXbEWXutUPw
	 DBCeGC+y/878542KKofAvgo8/N7cK53uSYAde1YNkonA92HhxCu5vj+Kw8/NBG4lCGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757816;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nwZnGbbvU5uI4Cu02ozANLp9s4gIt3FWpCQg5Wjikf4=;
	b=z/pMB/QyM2T81I1sijYAwxozH8OaIrZKAlU/hEA+sGcm/+NNCbND5iswM8UIPrKdTZQl
	 5HDcfrJXYrbzYQU8CbH7UEdpUagZbckF7CDt20YCg6LDXMJK5GfiLW/z6/UsW/uuZkMmC
	 46cIq+G+r3loDSy8yoV4FotsiD+6mXPDggOg69PKpF+TNFYj0kc/XDh5Zt/+Vlj+eW4di
	 0HFq5OBztJX2a2L2/Pt6InDSKHPezAB9gBHZKcFetVzgPMe8Hck2u+sMt5WSBlDusXH8U
	 IeyuvfkM1sfTaNxAOjQeZYYRcvBFvTdEoSORVXOEZCknQV6313nUDMURlMYaGCk/P8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BH+vE9ae;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7274606A31D;
	Fri, 23 Oct 2026 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BH+vE9ae
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8231F031E1;
	Fri, 23 Oct 2026 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792757815;
	bh=nwZnGbbvU5uI4Cu02ozANLp9s4gIt3FWpCQg5Wjikf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BH+vE9aeH4LYGhWrxr1p+XJjxLv80CVVm7xUBRe3zcZ+G1af+LWVUiXnj48FyOCk3
	 CwCzZATQM5lksmCi6xp6zSWonsyCeIhnDXAroldeCdRlgfqDOeeicvnsW8FB2UftE8
	 KLyyRYc+ujKiXBYZSHgbPBnS5hBMJwnYCzNyMiGxdNTXEyw3biKmh1CaelGjtVcAM9
	 th2OZ2TgAqKk2KqohNLjMmeJWuHNYH8+mWUj58W8z2nBmEuzcJ3Ydm187oq8cPWgah
	 HlI4ReBRt1k/ZccJrx7+2TQpPGXJBLt9XWOgba76u/xjfW7aCLNlVo8uT01yszMC5L
	 6I2VWYXk/W69Q==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xKECb-00000000mZS-0PBV;
	Fri, 23 Oct 2026 14:16:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 03/12] USB: serial: io_edgeport: fix potential NULL-deref at open
Date: Fri, 23 Oct 2026 14:15:21 +0200
Message-ID: <20261023121530.186541-4-johan@kernel.org>
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

Do not mark the port as open until after the write FIFO has been
allocated and initialised to prevent a racing interrupt completion from
attempting to send stale data and dereference the FIFO buffer pointer.

Note that the open flag defaults to false and is cleared on close() so
there is no need to reinitialise it on every open().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_edgeport.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index a5011fa91ee7..e8e641e9a197 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -885,9 +885,7 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 
 	/* send a open port command */
 	edge_port->openPending = true;
-	edge_port->open        = false;
 	response = send_iosp_ext_cmd(edge_port, IOSP_CMD_OPEN_PORT, 0);
-
 	if (response < 0) {
 		dev_err(dev, "%s - error sending open port command\n", __func__);
 		edge_port->openPending = false;
@@ -897,8 +895,7 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 	/* now wait for the port to be completely opened */
 	wait_event_timeout(edge_port->wait_open, !edge_port->openPending,
 								OPEN_TIMEOUT);
-
-	if (!edge_port->open) {
+	if (edge_port->openPending) {
 		/* open timed out */
 		dev_dbg(dev, "%s - open timeout\n", __func__);
 		edge_port->openPending = false;
@@ -926,6 +923,10 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 		return -ENOMEM;
 	}
 
+	spin_lock_irq(&edge_port->ep_lock);
+	edge_port->open = true;
+	spin_unlock_irq(&edge_port->ep_lock);
+
 	dev_dbg(dev, "%s - Initialize TX fifo to %d bytes\n",
 		__func__, edge_port->maxTxCredits);
 
@@ -1818,7 +1819,6 @@ static void process_rcvd_status(struct edgeport_serial *edge_serial,
 
 		/* we have completed the open */
 		edge_port->openPending = false;
-		edge_port->open = true;
 		wake_up(&edge_port->wait_open);
 		return;
 	}
-- 
2.55.0

