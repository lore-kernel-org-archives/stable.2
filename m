Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795844906;
	b=hzCrTEpO389Qb6YD4VSv49o7jyhwi5A8c7jiFULLE5N77eGJFjYH73DWWwjstnv2mAkX
	 hFadcYNb8N8HEMpB/CI/gb47C+KWoNPV+2dIaBQBYjG1B6JR77RhwYGWGH+OlKIQmaWg3
	 erMb8n6JNaH+I0Da3kSVx+c1zF1UKIJOZaglUxXUeMjiWxMbHharWVCWsSKluLVGJUYBg
	 hxQytIMQneOYZyQg+HC52oZEad88hxmUutxnKf8vk1Cz85S78JpeSQe//o64HGfgs8Yjb
	 synUfjBgZ90IoGXH9XLTJAVxi5FrEgkj3/cX8USamFD2oS5UigBGFRgw7X/e709lsJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795844906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4XfJznNp2/IANpIblGifYLm4G1OI7fa8TLw1ASBwm1k=;
	b=HnSw9w8cLA0qBrVUeXQubQPtMiHn+GXPcYulwGXy8MVxm5YTPSp4uozBxZMpEE/GlGIw
	 YCvbzuRI/Dxlt62eo+9lA85g7neHasMhN6wS0ycLKntSTkDgGSeV+TQvYJjCzGs5WzTh9
	 BdrKpCeSPq6kvy/K0Aioulx8CCm4G5vG4f42iq3zgu0REsRERdGOigDbQg/YlKVck8u/3
	 aw9ApxohoMTwK/KgwtH6ws/8vJW+fDGCfJDwHFAleGv7hRKmm9xuC1PGqe5OVeqOnteHZ
	 /KZ09wtk/QmEsjajNLQ/bfjhyue49pDSnod1mCElznRMJ3654sjV9e/npAN+bzg1kCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqU8DS0S;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E028606A31E
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 05:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E028606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqU8DS0S
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b4a93d0814so3186756a91.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 21:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795844905; x=1796449705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XfJznNp2/IANpIblGifYLm4G1OI7fa8TLw1ASBwm1k=;
        b=KqU8DS0S4DZvJyh8dSHw3tuF0854WLWZ48rhGH9X2melzvusLZSvJjqZwIOq6hfqoB
         UgwS9RP/Roik9xZWkodaJYrJjl68AU7CGgiimVasmSZ57H39quCjhyIZzAXs08utSIQ3
         aTBLW6o7RQMhPhHQkdHjeps6xwVxmYzujj/xkDdOnHBSU77uv29pQl8yF8hsCQO7m1WW
         QBPHq36ImPTZbMVMynu/bOCSRdYOeQxC9L6xUdWInrewf4KCcBO6gGjqJM35sYZC6qJE
         Plg55KLmw5C7Irflyz5Vvw+JFt+Lmze1+GKIU69NDfI84KQWmU0o0HbYGvK4FtwWdG+n
         lqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795844905; x=1796449705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XfJznNp2/IANpIblGifYLm4G1OI7fa8TLw1ASBwm1k=;
        b=rQZtQuUYiYt+CYuQZaefpM+nmG+4UiJCB+Ba/J7j7YbU9PkehE02ok2qD/47cR36W9
         DLXamHFjqUK6Tp4jcLS9bdy2wFjkvCyntWceae8E2tShWDEQCC+Xm1VlA9wLlMeWTkwT
         mjGW+ZEuSCZsM+BaZjCFLl5Of/BdPSFrtWBUf/NNZv9TEEyRPJGo07RpfmhCYt/ouyui
         nmJK6ZM0u1v9B4AJIM+WGvTg7y8xQEiIwLf3DKr7QomssHDFkQ3G72z42WEPJrbTswya
         JCZFJqtdvdeapWi7RxuXCmi5ORb8ANAMaqN5Bdr11O+d5RiMpb/Are9h3AiGZa+V0vAw
         op0A==
X-Forwarded-Encrypted: i=1; AL+hErEqBycTCF5HZU6wWMxLoyMSq2VFkOIHwR2PICQrk3yUeKElfgx9QQhMdRDzUkcEM/U1Qhl5bUw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fM04DmkJz94b5t9EgZ6/PJGaBPgKoxo+4S3ao25LWWBTP/avg
	EovjHJEHO847dRJdife8/BRhpCv/+gDj+rWkLGE+fNQbTZseTvgAS0M=
X-Gm-Gg: AZFdTZf6sVMYzuOToWrwpSDhUQljrkY5ioH31ZRvXW2/AFLQoUdpLIXppoFJk+22kCv
	MKlrTAlhBeRVWO1fR6I7epshBHS2JRcmo6vOUOSKwWVnm9jXC78DIh5yNTomH+3GRr4fbJvkbV6
	+qydaCB9F2t+Npd8uHMHCvZOem3k/6mnKFVLemkPUrWgx2lSdSsB3gRby95yWIyZEehOyd0b66C
	zbN2opsyXS0gO5Q30FXnDq49Up15LhPYd17J0h9CJ6yuS8AkubxoVE+guLQnrPcZzDsp0Njgf4l
	WQvvmXIJ8dFHs/KXXSXayrU4dASRgklvI6zxDzGqt7iyjkpL1nMkh+FCuN+/QTzzhUU8y245gH+
	orpAaGLEjGBONMus4MNG2eeY9Z1SSzsMCAraYrAzmJra5xcEVKeFH9XTmWlFr6f+2qnP5PZxVB8
	sl+t8Two0sP6L9xclbEPBiejsLayx+nAhLSRcLLXltLtZ83UfXyjLGLUXzcX7DL3Dso/mc76uvH
	8qkxE+xC6AWfwjgMQl67yP6tLNXlWXh1zUDnrQ9Az5filSmZGnmGMrSLNiMS7ZVgkxvZSHoXtcy
	390r8SSq01TWnVII96Qy4mhoiKkmB0laHmJeQCY+
X-Received: by 2002:a17:90b:3d92:b0:3b3:a74d:f848 with SMTP id 98e67ed59e1d1-3b41c8e1711mr21086372a91.15.1795844905354;
        Fri, 27 Nov 2026 21:48:25 -0800 (PST)
Received: from CONGTHANH ([2405:4802:703:8c30:8c8c:8484:8444:c4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm42979423a91.1.2026.11.27.21.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 21:48:24 -0800 (PST)
From: Nguyen Cong Thanh <congthanh.ml.2509@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-kernel@vger.kernel.org,
	Nguyen Cong Thanh <congthanh.ml.2509@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] can: mcp251x: deliver the TX echo before RX frames of the same pass
Date: Sat, 28 Nov 2026 12:48:15 +0700
Message-ID: <20261128054815.1586-1-congthanh.ml.2509@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.2
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

mcp251x_can_ist() hands the frames of both receive buffers to the stack
first and returns the echo of a completed transmission only at the end
of the pass. When our frame has completed and the peer's reply is
already in a receive buffer, the reply reaches the stack before the echo
of the frame it answers. The handler returned the echo first until
commit bf66f3736a94 ("can: mcp251x: Move to threaded interrupts instead
of workqueues.") moved the receive buffers to the front of the loop.

Since commit 4b7fe92c0690 ("can: isotp: add local echo tx processing for
consecutive frames") can-isotp enters ISOTP_WAIT_FC only on the echo of
the last consecutive frame of a block, and isotp_rcv_fc() ignores a flow
control frame that arrives while the sender is still in ISOTP_SENDING.
With a non-zero block size and a peer that answers quickly, the transfer
stalls:

  bus                  mcp251x_can_ist()         can-isotp
  CF 8 sent (TXIF)
  FC in RXB0 (RX0IF)
                       read CANINTF
                       RX0: FC to the stack  ->  SENDING, FC ignored
                       TX: echo to the stack ->  WAIT_FC
                                                 FC timeout after 1 s

Seen with an MCP2515 (SPI at 1 MHz, CAN at 500 kbit/s) on an RK3566
board talking to an STM32 bootloader that answers each block of
consecutive frames with a flow control frame (BS 8, STmin 5 ms). In
candump on the gateway the flow control frame came 0.27 ms before the
echo and the UDS download timed out. With this change, in the gateway's
candump captures of 25 downloads, all 5225 flow control frames sent
after a full block came after the echo of the frame they answer.

Return the echo whenever TXIF has been seen, before the receive buffers
that follow: at the start of the pass, and again after the CANINTF
re-read that follows RXB0, before RXB1. In the second case the frame in
RXB0 was there before our frame completed and still goes first, while a
reply that rolled over into RXB1 now comes after the echo. The MCP251x
has no RX timestamps, so the bus order of a completed transmission and
a frame received around the same time is unknown either way. A reply
can only come after our frame; the cost is that an unrelated frame
received just before it may now be delivered after the echo. The TX
block at the end of the pass only wakes the queue.

As a side effect, the echo of a completed frame is now also returned
when the pass ends in bus-off with restart-ms 0, where the loop used to
break out before the TX block.

Fixes: bf66f3736a94 ("can: mcp251x: Move to threaded interrupts instead of workqueues.")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Cong Thanh <congthanh.ml.2509@gmail.com>
---
Tested on the board above with its 6.1.57 based vendor kernel, whose
mcp251x_can_ist() is the same as in v7.4-rc4, by loading the driver
with this patch applied as a module:

- 25 UDS downloads (105 TransferData requests each) to the STM32
  bootloader, all confirmed. In 20 of them, test-only counters in the
  IRQ handler saw 185 passes where TXIF and an RX flag were set in the
  same first CANINTF read, the window this patch is about.
- 30000 frames from cangen while the ECU sent its own frames:
  tx_packets and tx_bytes grew by exactly 30000 and 240000, and 44 of
  the echoes were returned by the call after the CANINTF re-read.

The RXB1 case itself (TXIF and RX1IF only in the re-read) did not occur
on this two-node bench; it comes from reading the code and the RX
rollover of the MCP2515. The bus-off path with restart-ms 0 was not
exercised. Build-tested on linux-can/main (ARCH=i386, W=1); I have not
run it on a mainline kernel. The candump logs are available if useful.

Tools: the failure showed up on my RK3566/STM32 bench, and the tests
above ran there. Claude (Anthropic) helped analyse mcp251x and can-isotp
and drafted the change and this message; an independent review with
Codex (OpenAI) found the RXB1 case, which this version handles. I have
gone through every line, checked each claim against the logs, and am
responsible for the patch.

 drivers/net/can/spi/mcp251x.c | 36 +++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 0d0190ae09..0acdab0cd0 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1067,6 +1067,18 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 	mutex_unlock(&priv->mcp_lock);
 }
 
+static void mcp251x_tx_echo(struct mcp251x_priv *priv)
+{
+	struct net_device *net = priv->net;
+
+	if (!priv->tx_busy)
+		return;
+
+	net->stats.tx_packets++;
+	net->stats.tx_bytes += can_get_echo_skb(net, 0, NULL);
+	priv->tx_busy = false;
+}
+
 static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 {
 	struct mcp251x_priv *priv = dev_id;
@@ -1082,6 +1094,14 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 
 		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
 
+		/* Return the echo of a completed transmission before the
+		 * frames received in this pass. Without RX timestamps their
+		 * bus order is unknown, but a reply to our frame, such as an
+		 * ISO-TP flow control frame, can only follow it.
+		 */
+		if (intf & CANINTF_TX)
+			mcp251x_tx_echo(priv);
+
 		/* receive buffer 0 */
 		if (intf & CANINTF_RX0IF) {
 			mcp251x_hw_rx(spi, 0);
@@ -1105,6 +1125,12 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 			}
 		}
 
+		/* Our frame may have completed while RXB0 was read, with the
+		 * reply rolled over into RXB1.
+		 */
+		if (intf & CANINTF_TX)
+			mcp251x_tx_echo(priv);
+
 		/* receive buffer 1 */
 		if (intf & CANINTF_RX1IF) {
 			mcp251x_hw_rx(spi, 1);
@@ -1196,15 +1222,9 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 		if (intf == 0)
 			break;
 
-		if (intf & CANINTF_TX) {
-			if (priv->tx_busy) {
-				net->stats.tx_packets++;
-				net->stats.tx_bytes += can_get_echo_skb(net, 0,
-									NULL);
-				priv->tx_busy = false;
-			}
+		/* the echo has already been returned above */
+		if (intf & CANINTF_TX)
 			netif_wake_queue(net);
-		}
 	}
 	mutex_unlock(&priv->mcp_lock);
 	return IRQ_HANDLED;

base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
-- 
2.34.1

