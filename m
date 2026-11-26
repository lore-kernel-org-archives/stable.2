Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683702;
	b=p4urDXGihzxnv3z8wzJCIXmyjNl+2plm7Cw20NjU5RkSu0cxUtneUhgw/0XsKN37pauA
	 4EaH3bvjTvOabMWBb1p9RY+ByyB15njwVnK1Gp8V2DKeHnKGMw4NSGyLnW7G55I5miw3Y
	 Gu1ET7UgrSvOCW9PyVIjELlZ4H6dAshsP3atUTMoE/lG0VHPFi5zbuJOE7CQMFW6MW3ah
	 oM8mt4FPaLTSEGpampr+pfOKNveh4q+IrXNvzaYuuEws8w2R1NwyFkyFjKp6d0W2DtbgU
	 nilagxaFkmT2n0K3ArOQc4BCFgzrHudQP4Qfzu93iuP0FjqHVf3gK0LZ/SN/M0kJitw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683702;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qpGFs20O+VJsAGXEhzcuewnJqQ+vdDxsF0nI3L03jos=;
	b=vpU+NIgPn1OENjVCYiNqxyJs1UQeZvC+cfxtnXibL0dXERGSYrF8zq2IMCl7s95MPxjJ
	 Uz4rqJ1b8COA69guoMVJJY+LOfpopS/IgPnEVNejOIdV6p4m9gTaduGIgTLOJflUrrjg3
	 pASXRZqkopRwcAtxkRMbPFEfOqNhW2yg6Ym5DQtg3dTMThCc8HjYPZSHUrOaFY1LpgYtv
	 KlQok+mqRHd9Im/eoyX4QAgyOwWJjCAN//m2RiKToZLw61lLQM66dwajoX4Po92bI1bdy
	 gGrDvVa9uKfX5CZKzQd//Cew8UCEVTA19zGtGZg4q1ivKjmW/BVeao8r6QhJyQ4SR0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jp9YZXat;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32187606A329;
	Thu, 26 Nov 2026 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jp9YZXat
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683702;
	b=R5kf9T0tS4YNvd36C621ZakmbIwGpTvCfzYeya6sTOnArkWYjH08BXtpetjLd1lDJK+s
	 +CKOQ9KPZSbwkAujLRLXU8jrdIAdAYW4p/tBDINr2nV6xbp0TCYMSzyGaHOlzuF4Qfkq4
	 w4ubJvq0B7BdJz1cZDsw7j5hWDxEwjmP+JdRHw4OmjtyC41EH3ZVAhdfyZLd3D/P9cCQz
	 AZEeuuP8ps49CgObe7XSlFqGhLUd88MgGCN0dIqqwu3FLQsZjTQZn6YCevrft2dNq6JBA
	 8hs6zBlWwtJfD7mB30QXSXw1VETWku0LANb6UhCE8EmshV6g9X37nENMjadXf74eOlw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683702;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qpGFs20O+VJsAGXEhzcuewnJqQ+vdDxsF0nI3L03jos=;
	b=aw5epT8Ok1LVEcmbgLWP+m8tYoUU9fLWtXqWdQSI3y5dPNXJfwkL1ZhCrXaew9h8B+0L
	 UovWb70bs8XwdUWTbmA6VxOL6ehiIkYp68frdmewA262OcrYnijAuaRjAfGhTQxYGWwfA
	 QMT9HjFyK3ciJyonEOwzIr84gu0MwQiGYdI6DH5LSWwj0XWj+xLGUSHY1F9yC20DXP1z4
	 JkDQWL7OTq3MYbCjLc0Yzk76NHdV+cBLL91jagCPkvWg9ftCqqXZvMJ9OsYY0ZT2kUSF0
	 dih7fMDao2br9T+sPTwC2JheJhGtA5RmQZHK61WkNFpK/3GzXjMP7mBuYPiyjGT/Rrg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A261C1F000E6;
	Thu, 26 Nov 2026 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683702;
	bh=qpGFs20O+VJsAGXEhzcuewnJqQ+vdDxsF0nI3L03jos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Jp9YZXatU3x8NOAqMfkBCNX8ZCc6dFA6aQkwSST7KyFEkb1Czu8ynpSdY+oY2zF5/
	 Mg59NyoU0bMwkPOtdL1qTrEs0sENt+BVErPkEwqA6p1anIYcenFJwhu5y9fqk6vDZ/
	 sL36afcNfvFE3viesDM6mFgS+4cG+Yt3kCX9nka44qDokFzFr+p8AP7tNsN/XteQg+
	 ZqX4Q/D32ZaCLU3dJ7zY1EoFxCqAlJJJ0smXQn7K25MbC4YYC+HSE9fgXUEHg/rycO
	 HLqAhC6gEan9SdmXYjTbpFMGGTDJ4DA7vXbo/1r5k4vxl8yUwsObmgWyKCdtrmpVNc
	 +FwyQPHuVsvaw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B941F4D32E;
	Thu, 26 Nov 2026 09:01:20 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:09 +0100
Subject: [PATCH v9 08/14] can: peak_usb: validate the data length of
 PCAN-USB Pro CAN records
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
Message-Id: <20261126-canfd_check_channel_idx-v9-8-abe0099b4585@peak-system.fr>
References: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
In-Reply-To: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, 
 Joas Antonio dos Santos <joasantonio108@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=2782;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=SZLgm2Ylh7vlugHZukq1ZlVlY34/e4t5QsQL8k8D2II=;
 b=LsE1POd/Rk3Oy7gnLzhcOr8im+cs+ZW+oQl9UfXt4t0+ktPvmj+25Ff5VDgLmgV6sv2b8hs2O
 kUPs93q1DpkBXCywHYw//WyUMZMVhrXrkkQUUF5mNDHTfX4+t4W/AAJ
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

The PCAN-USB Pro decoder takes the data length of a received CAN frame
from the 4-bit DLC field of the record, i.e. 0 to 15, and copies that
many bytes from the record into can_frame->data. This length is checked
neither against CAN_MAX_DLEN nor against the size of the record, which
depends on its type: RXMSG8, RXMSG4 and RXMSG0/RXRTR records carry 8, 4
and 0 data bytes. pcan_usb_pro_decode_buf() only checks that the record
fits in the URB, according to its type.

A faulty or malicious device can therefore make the driver:
- copy bytes located beyond the record into the frame, i.e. stale bytes
  of the RX buffer or, when the record ends the 1024-byte buffer, bytes
  beyond it, and deliver them to the CAN sockets;
- write up to 7 bytes past can_frame->data[] with a DLC of 9 to 15;
- deliver an RTR frame whose len is greater than CAN_MAX_DLEN.

Convert the DLC with can_cc_dlc2len() and reject a data frame whose
length exceeds the number of data bytes of its record type, as the
other malformed records are.

Found by Sashiko AI review.

Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 9e2f48683a9d..38307d452a5a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -534,6 +534,7 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 				      struct pcan_usb_pro_rxmsg *rx)
 {
 	const unsigned int ctrl_idx = (rx->len >> 4) & 0x0f;
+	const u8 len = can_cc_dlc2len(rx->len & 0x0f);
 	struct peak_usb_device *dev;
 	struct net_device *netdev;
 	struct can_frame *can_frame;
@@ -543,6 +544,12 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
 		return -EINVAL;
 
+	/* the number of data bytes depends on the record type */
+	if (!(rx->flags & PCAN_USBPRO_RTR) &&
+	    len > pcan_usb_pro_sizeof_rec[rx->data_type] -
+		  offsetof(struct pcan_usb_pro_rxmsg, data))
+		return -EINVAL;
+
 	dev = READ_ONCE(usb_if->dev[ctrl_idx]);
 
 	/* reject records for a channel that is not (or no longer) set up */
@@ -556,7 +563,7 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 		return -ENOMEM;
 
 	can_frame->can_id = le32_to_cpu(rx->id);
-	can_frame->len = rx->len & 0x0f;
+	can_frame->len = len;
 
 	if (rx->flags & PCAN_USBPRO_EXT)
 		can_frame->can_id |= CAN_EFF_FLAG;

-- 
2.53.0


