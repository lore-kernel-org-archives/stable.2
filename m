Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794282990;
	b=ijHlE+wvFLYgGh9HgZAnRrlQEI5hxzJBhtVAlxGK/KXlT8IQHxcKzPosjbU8QmucO8FF
	 G+zDnahd/QfAOwGvfgl83jrUZuaDE0q5bU2gfL1mPRZBOP3bJUuwv9P4sC8pHHp1+Au+M
	 tNvDhcsB6CHFVP/PuaU7IGED+hJ6rgYou1EP50le6JjNyPmGZ8Q6MQecEmkMEZ0/hBwyH
	 n29Aoval+BKarw2q305MaQbg08ezz3prSAoaq6PQpZsYug39+6x2NwdgiLq3Wh3oRkvan
	 7chFap5Kn9tLFF8Gb7EzXoEythaVWnLtYNSvA+b7irZeSjgK0iqYdacF+hH4Y9/fgtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282990;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=79rZU/0jTjexPsd5EtiSsu9g/O1vEnK3AeJQuAB1EGw=;
	b=EZkwtRrUaQSJu999zMPNB3Uexuw7JRlscqw5St7ky3Nmis18khSmmsv3R6NP/jCNxAsv
	 vpbRVDesZerd/FuiuuCvvVIjXiMBhMhMkh+k/tpGBZvX2n2pIYJbK59MZ0G3Lcw8B0qPj
	 V8snt10l+uyEwcOHxWi+ftgMirUcMzApS+TOvBSkLoC++5baUD/tCqaOPzGdCGXBE9Y7b
	 zX9vY3Sq4+f/qYWa3yrdA8glO/FehXsvPdor9rMnlRyNvaqIHgATUeHxVNCtJZHgCGPgs
	 h+Se84Ty0qSTWVo75OI+qWoBUQSBCsD1p8metp31fU/+1cS6d/S6wO8+bE++RQ/sFQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCN1j1P0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9B606A31C;
	Tue, 10 Nov 2026 03:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCN1j1P0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794282989;
	b=VSaAu4o0pIKSUg14tHCyjQcgWxCDtecpm6m6MBlRrgoi6qa//yAXkAUfan9TGUMGA4Ya
	 AWCizIeFqYH5o7+gX44UuW5LzFJHiFXqrn+rlw+yMj+qJ8rVI0YT2v7e4Ns0TnCIfqNT5
	 2rl+XE1pHFOTpQoFxs4x8Vyorc49M6xHzdtcIUnXgaorWWnnYRj1Bt3f7kBg3rd03LOjQ
	 82m4XPWyQPEGPuK+OtD7yf6EVwCB0TK8fS5kk9hy5PWJ4NZdI1sm/QmxPjou6xC28blYu
	 e2xgXdllkagzlKEQardR3O7HsxcN1/46KeOpQ4dpwgDWchsNK9PIt+/8JJl5iA88k9g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794282989;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=79rZU/0jTjexPsd5EtiSsu9g/O1vEnK3AeJQuAB1EGw=;
	b=melHlFwchFwFYZx7Cl2EyBtirV38KhClA1T4roLEEU7Yf19heU0KYT62gYbgyJspKPnl
	 oYH5WWx//rPKmI0k99tI9P3JRweUK49KFLDomj7BbeRAR0MhbZ6V2j+mwh2/AOl1jRzkS
	 INWla/TY/cddIL1ZEyTfBC7PEeOEg4cerkqj5zcHo+Ug51fMDzAmO9YtwsVX85xQ1WGH+
	 59mEepTup19L6bgD+rfi4NMNt6K/Rs///tIK2eOmwZWfh9zwPVAJNOLoSx8WiDtfVD+QT
	 Q1sPfdfFrYjwlqzFy24gijFoKThO2lZc7RenvrxDBV4zXAwFHBGkIssiNdsjLxAUuow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EF9F61F008A2;
	Tue, 10 Nov 2026 03:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282989;
	bh=79rZU/0jTjexPsd5EtiSsu9g/O1vEnK3AeJQuAB1EGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SCN1j1P0lFpRSg/lQqrCSp7YysfSljlJIoAUZyrF7+Q3cWTYnEOz/u5uE6j8dUBD7
	 X+Zugpwr0ucfBtVE+GXzLTp4O87tI2aMe1ZZjs8qnQt5F/Si3ZPiesfJ1HWCVwnNIP
	 zvE0dgOQYrLQ6HdOkQCj0ZObyOM5rW4gJ0b1t6gpF37AHjilezfh7jK7BWs0qrJXvL
	 fMN6MR4lMbpZrfQmEZGRZlrvh12mLcmO1GF9UtcXfG04y0/uDSZBimc/tZZ9sbxgdt
	 4l/jxTlNc8WhaYNxHb2uBWJvTvJdKfUEwjdlOnsaV7UtwuHUB1ddlBJARP8YT1P1+i
	 avTFgfQOHfDzg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 76DA7487E8;
	Tue, 10 Nov 2026 03:56:28 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 03:56:29 +0000
Subject: [PATCH 2/2] can: esd_usb: validate the message length in the rx
 path
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
Message-Id: <20261110-esd-usb-validate-v1-2-7ee499b4926d@gmail.com>
References: <20261110-esd-usb-validate-v1-0-7ee499b4926d@gmail.com>
In-Reply-To: <20261110-esd-usb-validate-v1-0-7ee499b4926d@gmail.com>
To: mkl@pengutronix.de, mailhol@kernel.org, frank.jungclaus@esd.eu, 
 socketcan@esd.eu, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794282987; l=2262;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=pV/Sdz7aRtptMVVSSDZWKUxUjOppcKrFNiTGGsGPRAM=;
 b=SSGJExKFCETEo3C8HhdXj534u3ZYyx3Iue+QM6jolsbMwZq2EMNVZdAtZoOQLd7C23P1sL087
 C/fyZE3eEbAAyvWaswu2b+TINscMtUJ0jKrU0EyQM6a3pF6Uk5Axo4s
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

esd_usb_read_bulk_callback() walks the messages in a received buffer
using the length byte from each message header:

	pos += msg->hdr.len * sizeof(u32); /* convert to # of bytes */

	if (pos > urb->actual_length) {

The length is supplied by the device and is not checked against zero.
A message with hdr.len == 0 leaves pos unchanged, so the loop never
terminates and keeps handling the same message in the URB completion
handler, which locks up the CPU.

The check that the declared length lies within the received data is
also done only after the message has been handled.

Compute the message length first and reject a message that is empty or
whose declared length does not fit into the remaining data before it is
handled.  The handlers still rely on the fixed layout of the message
they are given; checking the declared length against the layout of each
command is left for a separate change.

Found by LLM-assisted source review.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 drivers/net/can/usb/esd_usb.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index f26a8780686f..67dba118ce9e 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -507,8 +507,15 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 
 	while (pos < urb->actual_length) {
 		union esd_usb_msg *msg;
+		unsigned int msg_len;
 
 		msg = (union esd_usb_msg *)(urb->transfer_buffer + pos);
+		msg_len = msg->hdr.len * sizeof(u32); /* convert to # of bytes */
+
+		if (!msg_len || msg_len > urb->actual_length - pos) {
+			dev_err(dev->udev->dev.parent, "format error\n");
+			break;
+		}
 
 		switch (msg->hdr.cmd) {
 		case ESD_USB_CMD_CAN_RX:
@@ -531,12 +538,7 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 			break;
 		}
 
-		pos += msg->hdr.len * sizeof(u32); /* convert to # of bytes */
-
-		if (pos > urb->actual_length) {
-			dev_err(dev->udev->dev.parent, "format error\n");
-			break;
-		}
+		pos += msg_len;
 	}
 
 resubmit_urb:

-- 
2.43.0


