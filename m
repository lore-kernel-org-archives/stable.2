Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504477;
	b=ocZCm4IXAdfvRkE8jP7+p2LOPUKyc8gxCkSfPwdZZBwruM55Ju7FA5PcxD0wmV4yuRF3
	 X6OA4ajPHkwtXaeiEb3vUOro4WHO8FD4+l2Wv/DTuwyEPM+k4vXJVAzwH/r4pjWdkSMYl
	 9FNy6uVKtOFSau4d1VvadjEhdoYICcC2fbwxwAJjUpG0AmLzJVa2MeX2e72Y2T10E4hBk
	 5g4Ew8QGYGHOc+t9smk3DWC1hR5WRnasEEnK0YpZngDjZCJxvuuglMG7/v/vqptyprRAF
	 N0YCAOUVEibBfrz9ihrGmtspBEzf8ly70qnMQxzEOh97BM2czyo7h3CgPS4Hzkg86OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504477;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NIR3SCDVa+aPvQoJSU2zFB5//h037Ynmq3fKFGsGMb4=;
	b=MMhLqv1qMZ2L1RRzEy2Hd5ia4N+EjRUcgmUSzFDHsdPgXmRpEaqe5bRA5bKDW5BF8cgS
	 A/nyYxW6dbR9y3hiXfQSTse36bQu7oLYeUcsDh4b63gQwZoKkO1vRwY+2HUCRfwckkL+E
	 woDk9iF/HgSvySQpU+3XXmCziSpn0zON1icJZ6ghgtVoDhSJScpUfIIOCUwFVUJ2EJQTG
	 Cs8Drh0UOHwLWqfQcNPOUzyDKOHpaLEO0LoruhYclQQcMluo/ULa2sgecF+8NKbEbWIdB
	 jik4z88PI+vnQGF4d+bug+M0ZmNcl7YHmszldenIEFXZnEJJ0fHOHtafgSssL2gMaZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBfQwiDr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B733606A8AD;
	Thu, 12 Nov 2026 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBfQwiDr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794504477;
	b=GiLMJsUjZPAtqhSWVmKbFkS5ICyPKSy35OHxngHvIh56cbDhyZHZYLng0AXQm/aRIYMp
	 eNsscrTeMKoP3jm/W24ShVte8HgDWG2L2HneIXAsLICqnfKgzAS7zyBN2W2n+nOhWmtMN
	 K0CC99J7sZOGMoYvm1xZiht9U41zSizm57KR9EpEhvSItYffBAPMDuHvPg2GCoqjoY+NV
	 BgFI77Lbp4XsInQDt2W0xyG+tHqTJ7i5vur4M7MQ+ZWf+wK41ecO0THUTl4MVdbxc2tqm
	 0b8T7S03yDLZLWxOirVgrC46bczBpCykthBLLS3nikuOw+vYfvvxNIryx/GK+NoF73Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794504477;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NIR3SCDVa+aPvQoJSU2zFB5//h037Ynmq3fKFGsGMb4=;
	b=rtlTD0lUE5v5HDdNdaEwA8St/MCt9qKHzPl6F/Uh8EUXB+izixeIp2Q8NbB6n/EFt/ts
	 zLjBrsAf7zI1+keMyjpZN4mtR891ni1PTM3rNH/wUckksLpQq6GJuzSBQo9KOO5XoTTAs
	 YlD3sbSmNa2QwjUB0i5l0I+jmZjhVqxL1V8ZHR0zao113cfJqEoqKHZT8jRZTptJ/NiwC
	 LU4Aq/JOFI+TslaJN+nwQ+mCZF3DIi+vccAqGaaNMoO60nEUAF/kjFDK+fHmCeWvd0xbl
	 vYy2FSrYg9Rnl32heePfCq1+XEPAtDkRCdINde/oDpSw5I/iIPwC5PV1+vRm572QwXg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F10901F000C9;
	Thu, 12 Nov 2026 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504477;
	bh=NIR3SCDVa+aPvQoJSU2zFB5//h037Ynmq3fKFGsGMb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CBfQwiDrjupZbhi/ln87p5UA/VmdqsQaWtLj4b+vxuUV0S0VgxOFpc7p9XBUISp59
	 nYFN+5XW7MYxXQdLEauJ8dtclfiKjkRp2yf6XVmNvFP9OOIUjVH1gGS44uHNTyCEg4
	 hZO3D/iuA1UeBOYvMwGmirpneCpd1+ZNmMvxoOIfYDoEavh+iBJwfRrwxys6t8IbQ5
	 GgIXjlTgqXrJaD7PXEvy6zE+ZK3uoO9aQFi2D0AVtY5djV/f8REwFPCZzdWRYqcPta
	 Hswiz7q71uKvyHlVZbJvYd7vZWOJXcmehxhIGjdCXgqoy9ekrfEZzUopDpnpN3GBEP
	 7qn1bsu4Lelzg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7F00B45A8C;
	Thu, 12 Nov 2026 17:27:55 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 17:27:57 +0000
Subject: [PATCH v3 3/4] can: kvaser_usb: hydra: do not read the command
 length before it is received
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-kvaser-usb-validate-v3-3-61587f639508@gmail.com>
References: <20261112-kvaser-usb-validate-v3-0-61587f639508@gmail.com>
In-Reply-To: <20261112-kvaser-usb-validate-v3-0-61587f639508@gmail.com>
To: mkl@pengutronix.de, mailhol@kernel.org, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794504474; l=5600;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=ldTeBoZ4+jKNL/lgU1zjcXXFBzkpZLGiDFqOc5o2sd8=;
 b=tjmqatAi7KoDMsGfT5wYv8qtwO3VXSMIW1OgNLCISJQYHPBes7/187rbjUv6PT2v+LDI3ZIB5
 VSbCXDvLC50BzmnXI7MHPYnRQuRAzC0Qc6VUAavl4CATHBTEXlDQdVJ
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

kvaser_usb_hydra_cmd_size() reads the 16 bit length of an extended
command from bytes 4 and 5 of the command.  The two command parsers call
it without checking that those bytes have been received:

  - kvaser_usb_hydra_wait_cmd() only requires pos < actual_len.  If the
    transfer fills the whole KVASER_USB_RX_BUFFER_SIZE buffer and the
    last command starts in its last five bytes, the length is read from
    beyond the end of the kzalloc()ed buffer.

  - kvaser_usb_hydra_read_bulk_callback() has the same problem at the
    end of the receive buffer.  In addition, an extended command that is
    split so that fewer than six bytes arrive in the first transfer is
    parsed with a length taken from stale buffer content.  That either
    fails the length check or stores the fragment in usb_rx_leftover,
    where the next callback computes the length again before the rest of
    the header has been copied in, and without checking it against
    sizeof(struct kvaser_cmd).

Every command is at least sizeof(struct kvaser_cmd) long and
kvaser_usb_hydra_wait_cmd() does not handle partial commands, so require
that many bytes there before looking at the command.

In kvaser_usb_hydra_read_bulk_callback(), buffer the fragment when the
length field is not complete, and complete the length field in
usb_rx_leftover before using it.  Apply the minimum length check to the
buffered command too.  Drop the buffered fragment when that check or
the existing check against the size of usb_rx_leftover fails; the
latter kept the fragment, so that the same error was hit again on the
following transfers.

Found by the Sashiko AI review of the previous version of this series.

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 50 +++++++++++++++++++----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 9adb4eb36e39..6b68e0714ae3 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -675,6 +675,12 @@ static int kvaser_usb_hydra_wait_cmd(const struct kvaser_usb *dev, u8 cmd_no,
 			size_t cmd_len;
 
 			tmp_cmd = buf + pos;
+			if (actual_len - pos < sizeof(struct kvaser_cmd)) {
+				dev_err_ratelimited(&dev->intf->dev,
+						    "Format error\n");
+				break;
+			}
+
 			cmd_len = kvaser_usb_hydra_cmd_size(tmp_cmd);
 			if (cmd_len < sizeof(struct kvaser_cmd) ||
 			    pos + cmd_len > actual_len) {
@@ -2117,6 +2123,8 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 							&dev->card_data.hydra;
 	int usb_rx_leftover_len;
 	spinlock_t *usb_rx_leftover_lock = &card_data->usb_rx_leftover_lock;
+	/* Number of bytes needed to tell the length of any command */
+	const int len_end = offsetofend(struct kvaser_cmd_ext, len);
 
 	spin_lock_irqsave(usb_rx_leftover_lock, irq_flags);
 	usb_rx_leftover_len = card_data->usb_rx_leftover_len;
@@ -2125,20 +2133,43 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 
 		cmd = (struct kvaser_cmd *)card_data->usb_rx_leftover;
 
+		if (usb_rx_leftover_len < len_end) {
+			/* Get the rest of the length field first */
+			remaining_bytes = min(len,
+					      len_end - usb_rx_leftover_len);
+			memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len,
+			       buf, remaining_bytes);
+			pos += remaining_bytes;
+			usb_rx_leftover_len += remaining_bytes;
+			card_data->usb_rx_leftover_len = usb_rx_leftover_len;
+			if (usb_rx_leftover_len < len_end) {
+				spin_unlock_irqrestore(usb_rx_leftover_lock,
+						       irq_flags);
+				return;
+			}
+		}
+
 		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+		if (cmd_len < sizeof(struct kvaser_cmd)) {
+			dev_err(&dev->intf->dev, "Format error\n");
+			card_data->usb_rx_leftover_len = 0;
+			spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
+			return;
+		}
 
-		remaining_bytes = min_t(unsigned int, len,
+		remaining_bytes = min_t(unsigned int, len - pos,
 					cmd_len - usb_rx_leftover_len);
 		/* Make sure we do not overflow usb_rx_leftover */
 		if (remaining_bytes + usb_rx_leftover_len >
 						KVASER_USB_HYDRA_MAX_CMD_LEN) {
 			dev_err(&dev->intf->dev, "Format error\n");
+			card_data->usb_rx_leftover_len = 0;
 			spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
 			return;
 		}
 
-		memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len, buf,
-		       remaining_bytes);
+		memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len,
+		       buf + pos, remaining_bytes);
 		pos += remaining_bytes;
 
 		if (remaining_bytes + usb_rx_leftover_len == cmd_len) {
@@ -2155,11 +2186,16 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 	while (pos < len) {
 		cmd = buf + pos;
 
-		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+		if (len - pos < len_end) {
+			/* The length is not known yet, buffer what we got */
+			cmd_len = sizeof(struct kvaser_cmd);
+		} else {
+			cmd_len = kvaser_usb_hydra_cmd_size(cmd);
 
-		if (cmd_len < sizeof(struct kvaser_cmd)) {
-			dev_err(&dev->intf->dev, "Format error\n");
-			return;
+			if (cmd_len < sizeof(struct kvaser_cmd)) {
+				dev_err(&dev->intf->dev, "Format error\n");
+				return;
+			}
 		}
 
 		if (pos + cmd_len > len) {

-- 
2.43.0


