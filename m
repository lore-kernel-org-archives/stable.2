Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592156;
	b=2TzLRHk1A7isPclMTFOZ09QG88pa5HI7NvMiIs6cTsBXsaiChaOUj3aNgFSfOwXGOAEY
	 YBf/7BR4Z1sIt+/VOdxx4vRCKV8o5BzUK8J3ZnJD8c8kcD1REVgg3XVFAkoxMpTOaTWQj
	 PBncGqx8AOlqeQu6T5r7LbgmukEIqgQXIQoYmJpidrbdecUEK0FlzzulOgu1K7AMRvVRj
	 pHSj2Mv8gnyGAf2DLaOP6erA/EQht0OQDfyJSAlZ+5fOZbQ3O7wzCCgNurt8SdtJSl1l3
	 MSmPY0XnkwMWfvVCcrg48/n10nej0dlfceLuAOR81mPbNn+w8b+7K//ouMOZWr15drw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592156;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V6OicTVbtcTLzSS+UWGSsMNxNz1ZsX9m5t8h/aO5CmY=;
	b=Sj1E1+nkckxJyq1hQGf+bTQbcA5c+Yau7EL7jP2If+8PMrg+fL+KGhOuhpB5d5lFQqLP
	 zo3hnFVApOlSiAebp8ctoippal+SN4qqyZmEfe3wTEm8Z0r/93YmGjDoa+eEgtaXPO2xO
	 D8C1e8KOFkuWCR55aTN82r8OZLhA6kZxcGl40EEdYVDB9KsIU+CTVvZMqLz39zayBOZyq
	 V429C7Tma60o+JQ/+TmrUNwNLTK0/K9gZDEw5kV5K8Bri9TZoMlvVCNH5/Q/m8zT+EnhV
	 Sn7l0e++iiHhGHElVh7Gj38gU+kNHK6CxbiSG8LYd1lQ97nGX68VrcJCVPKBSwNV/LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYn2KVjo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A152606A33B;
	Wed, 21 Oct 2026 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYn2KVjo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F4D1F000D3;
	Wed, 21 Oct 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792592150;
	bh=V6OicTVbtcTLzSS+UWGSsMNxNz1ZsX9m5t8h/aO5CmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jYn2KVjo7Z4y7FW3CtnSMVUkvWYq6S8KFPsgWkh2tLQSgKGhgofFfSRxou2It7VkE
	 QiwYzAj/5Ob+k8X9rEZlFyVkDC6DiBkFJX1eFKnuESThD8ZxArYmCWIJM1XlPOWX4K
	 I9+wVac09GCaZbENfFZKpqDVwbRYnvZwEjS+snU86S1/Y7SHz4cPK1cKVmWNn+8NDY
	 0ba2K+HCNRwQqn/LQiR/p3Mkp3xPeLMHIOEN2gYR5uzHrvb0UttV7sQmaym9GI6nrR
	 8FXFR8/s67vNtnrQs9dbCPwPUg12EEJmuh82R55AqcZZoRPM3hqICeN3no6HKNj8Eu
	 r46kRMHL5Yk+w==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xJX6Z-00000009kqB-2L13;
	Wed, 21 Oct 2026 16:15:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 02/11] USB: serial: io_edgeport: fix potential fifo corruption
Date: Wed, 21 Oct 2026 16:11:45 +0200
Message-ID: <20261021141154.2324793-3-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021141154.2324793-1-johan@kernel.org>
References: <20261021141154.2324793-1-johan@kernel.org>
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
 drivers/usb/serial/io_edgeport.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index cdf41e86ba44..0cc4f41299e0 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -878,7 +878,11 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 	}
 
 	/* initialize our port settings */
+	spin_lock_irq(&edge_port->ep_lock);
 	edge_port->txCredits = 0;	/* Can't send any data yet */
+	edge_port->maxTxCredits = 0;
+	spin_unlock_irq(&edge_port->ep_lock);
+
 	/* Must always set this bit to enable ints! */
 	edge_port->shadowMCR = MCR_MASTER_IE;
 	edge_port->chaseResponsePending = false;
@@ -1750,6 +1754,7 @@ static void process_rcvd_status(struct edgeport_serial *edge_serial,
 	struct tty_struct *tty;
 	struct device *dev;
 	__u8 code = edge_serial->rxStatusCode;
+	unsigned long flags;
 
 	/* switch the port pointer to the one being currently talked about */
 	if (edge_serial->rxPort >= edge_serial->serial->num_ports)
@@ -1793,10 +1798,17 @@ static void process_rcvd_status(struct edgeport_serial *edge_serial,
 	}
 
 	if (code == IOSP_STATUS_OPEN_RSP) {
+		spin_lock_irqsave(&edge_port->ep_lock, flags);
+		/* reject stray open responses to avoid FIFO corruption */
+		if (edge_port->maxTxCredits != 0) {
+			spin_unlock_irqrestore(&edge_port->ep_lock, flags);
+			return;
+		}
 		edge_port->txCredits = GET_TX_BUFFER_SIZE(byte3);
 		edge_port->maxTxCredits = edge_port->txCredits;
 		dev_dbg(dev, "%s - Port %u Open Response Initial MSR = %02x TxBufferSize = %d\n",
 			__func__, edge_serial->rxPort, byte2, edge_port->txCredits);
+		spin_unlock_irqrestore(&edge_port->ep_lock, flags);
 		handle_new_msr(edge_port, byte2);
 
 		/* send the current line settings to the port so we are
-- 
2.55.0

