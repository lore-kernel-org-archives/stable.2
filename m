Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757816;
	b=4g1vAIGRSvECC46FenANWjDyM0v56o1FNila6X7rGcaJQPsh+2SxLQST3cFWFsDAQgB3
	 uElfGjmIc3CMSiKr8Vs7KuiLwZLgZHvWMQxRtqVXr+pvyBDO5HXa5I7i1zLIk5Fkf61yn
	 gx6L2sxAnEhveucc53hKma5ZPlxz1NeSVoouHuiCEa0oumDxgePFN+J3RKkiRpYMaVQnN
	 Z2TE7ODDFdJRTyRRquqGMjWYs2g9V4KuU8c6c05Lo+7NLuGeBq86jNlShPppOvbGRWSEd
	 XtVgcvVy22JPyJbypLSVtkckmQn5kCF0Sm4SPEx4YyFbgYEM9OQiUScWlwrF4Aa81eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757816;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rjIx7JOak3tuVU8eJ7uL4I47PTIJAC3Bbjzb+Yi4NpM=;
	b=ghAE3Y5uFfd/aoYwimUHJCQD7PjQGZkVno7wYzh3W7X7kemeSWl6IebMM/d4dW18GAke
	 R21Q8hGWE3IW8dCYbPxrHNUxvAoRY0mAPqWkYvzGUFAyV5efIEqtjcMQA/dZTlXTEywUW
	 Ros3slpEHbK5MgL0hlAvnv4Unmuqp2UtG2KE0ipQH6y9zt+V9hAKyCmmYXbCbYL6DvOeZ
	 rtFiWEFYV9mWV7znz9b5QviJ5FfYxCBxIXPtPqmURvOPcjK6v7HYNUVg3a8TQeJ8vwS4j
	 gCVrRF+FTPx6Fae3Tn5rVqv+diqu3m43ZoP/xZ07xFimdJS4kYdQyMTL/+IJtIHfaGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gEbJAR//";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73BD606A31F;
	Fri, 23 Oct 2026 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEbJAR//
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B6A1F01828;
	Fri, 23 Oct 2026 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792757815;
	bh=rjIx7JOak3tuVU8eJ7uL4I47PTIJAC3Bbjzb+Yi4NpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gEbJAR///F9hBzdVMl0D/cnlGIjue3VPDnPzS58LRLneVZqPT1MK5a9ONZisNDUmC
	 iLdCWHYQLQ/4M/NnS8terT645XR/7cDlFArMQ8OjnrDPtv5Jsg31DH7CSmPJq6PYTQ
	 sqSWvEtjNWH7OSTn9x6PQvaeRm5QWEcaNntnHPPv6F0EGZK0zMX1LyA3L44IJXSY6f
	 vycbK1bHWRsAYDSo63Nix2MXsd1yRU6WAAsTiR5uqVSE2DL+e7RvzCjLQh3PuCDcbz
	 5ThC0svZnQCRQKARmYkeAm5b4WKOl8YdjnXlEO80aJBLUAX9NF7rVhtnDhwBPnHBqp
	 niK6JJHWtteKw==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xKECb-00000000mZW-0Wan;
	Fri, 23 Oct 2026 14:16:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 05/12] USB: serial: io_edgeport: fix potential fifo corruption
Date: Fri, 23 Oct 2026 14:15:23 +0200
Message-ID: <20261023121530.186541-6-johan@kernel.org>
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

The device buffer size is determined during open() and the driver
allocates a TX FIFO of corresponding size.

Add the missing sanity check to prevent memory corruption in case a
malicious device sends a second open response with a different buffer
size.

This issue was flagged by Sashiko when reviewing a related fix.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260714101316.823942-1-shpark061104%40gmail.com?part=1
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_edgeport.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index cdcff02c435b..b8fbcc8908d1 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -877,13 +877,17 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 	}
 
 	/* initialize our port settings */
+	spin_lock_irq(&edge_port->ep_lock);
 	edge_port->txCredits = 0;	/* Can't send any data yet */
+	edge_port->maxTxCredits = 0;
+	edge_port->openPending = true;
+	spin_unlock_irq(&edge_port->ep_lock);
+
 	/* Must always set this bit to enable ints! */
 	edge_port->shadowMCR = MCR_MASTER_IE;
 	edge_port->chaseResponsePending = false;
 
 	/* send a open port command */
-	edge_port->openPending = true;
 	response = send_iosp_ext_cmd(edge_port, IOSP_CMD_OPEN_PORT, 0);
 	if (response < 0) {
 		dev_err(dev, "%s - error sending open port command\n", __func__);
@@ -1736,6 +1740,7 @@ static void process_rcvd_status(struct edgeport_serial *edge_serial,
 	struct edgeport_port *edge_port;
 	struct device *dev;
 	__u8 code = edge_serial->rxStatusCode;
+	unsigned long flags;
 
 	/* switch the port pointer to the one being currently talked about */
 	if (edge_serial->rxPort >= edge_serial->serial->num_ports)
@@ -1779,6 +1784,12 @@ static void process_rcvd_status(struct edgeport_serial *edge_serial,
 	}
 
 	if (code == IOSP_STATUS_OPEN_RSP) {
+		spin_lock_irqsave(&edge_port->ep_lock, flags);
+		/* reject stray open responses to avoid FIFO corruption */
+		if (!edge_port->openPending) {
+			spin_unlock_irqrestore(&edge_port->ep_lock, flags);
+			return;
+		}
 		edge_port->txCredits = GET_TX_BUFFER_SIZE(byte3);
 		edge_port->maxTxCredits = edge_port->txCredits;
 		dev_dbg(dev, "%s - Port %u Open Response Initial MSR = %02x TxBufferSize = %d\n",
@@ -1787,6 +1798,8 @@ static void process_rcvd_status(struct edgeport_serial *edge_serial,
 
 		/* we have completed the open */
 		edge_port->openPending = false;
+		spin_unlock_irqrestore(&edge_port->ep_lock, flags);
+
 		wake_up(&edge_port->wait_open);
 		return;
 	}
-- 
2.55.0

