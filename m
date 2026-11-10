Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794283006;
	b=hu0gEMtjfUJEvhJ0ZQr3r9gb8kUO2ZcbSflja5kMmkNjNeMRv8fbDY1aOnhBAQAnTOrX
	 omc+v4xHUzCfh1dypt2U0P55eB+FHPIMUYnAU5ejT4ZqYvYKhqSV12xjROzkVGhdlK432
	 RV3qE1DbjHS2f5Jwt8/im1TJIZfMBUHwxqaWpNxF1vAvyTY9PO6oRM1Yy2QO9u2Yw00oj
	 k88mYCH29QEKT30+rWO2Hpx/zjFNp2vdk3x2io6TyVOS9q4G+y8tmmA0ja3j5QCYYMUjX
	 JIOkQD667As6DHYUa08OaqCWnRXOhqxLEpH0n6HQgaohQttkY29/21thkkITo+JHIvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283006;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4k093y5/yFR6nFNSoFAD4QE4dU16QnihF4r5DnoFO+w=;
	b=WQM8KP5L2iA8uaLef5zTypLbB03FXdOczRA1mmegyBPBm57YUvnXz+XJh2F3/Z8qHQSj
	 5OeLCxGwIU0NKZr8vEQYze8mu2fNBGprmZM1qs5nsx6Iepwvb+sudwQ6uy1vNCxfNQ7bd
	 UToDUSU7usbEBHEKAwZsN3OWwrgMGDBtcimy+afyyxrywlQVdbg4UXqFrMrDtstNPkAA9
	 pnG6FdTNrMXdpDj1zWSj+gW8sQVdmKJ/c/4QTHZ0Xqf0RcOZtVEqZzCR6O16QovNeJrfa
	 bOmNDZrB1doFPf7vgobqK1r5OdLFKgu2MVEDfyMW/Bi5g4blS4TaOn+HJVxCizLkn9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b426adgh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F860A262A;
	Tue, 10 Nov 2026 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b426adgh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794283006;
	b=xa3dkffS6e00hAKVXdWSbBPxEALvOisD1lZ2rLiZ5Ysni1KlIVGkTSu8x+5oZub8zDbc
	 R87R/4JtBDSssR8H4w8tOWO9r/WnROcr7JiLWrUTYSgGoS99L9FHzq1Zq5tofNUBJjOXC
	 xhWuSF//lX0LayA6JGhCiSp8OMzeUodnyG6qZ/qsxY2iD5waJlmsS1hZ7GzR0vp1KIEYN
	 p7fOwkHNT8PbFaymYm931DPaDg9A9ozmzvX+mIhRRSbbYIy+FqyuSgVrNStZWO8uY+Srf
	 3eE9UA0w1G6qs3ZRWge2G3jypvUwCCtr2x+aooxe/RmAbF9taA+ACBJTnImmExFFv2w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794283006;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=4k093y5/yFR6nFNSoFAD4QE4dU16QnihF4r5DnoFO+w=;
	b=LOhkKjPLWK61QyOH79T2eNhfozihsMNn9ZWX8PO7oI3ByCqgIRDBoAas3I0CYbEkT0VZ
	 rmVH5PWlZ3udXcPPWfXJbCGzpXnTYn7NOL06Z84pkrGdKidr9PTueOGoHP5fpxadbTexM
	 8kxf8uCGv98KEiXJ5OaGPmUxUkKtVC8Gr675TlDbWugR3tbwKfbKYDWor+SVxCKaQuxHB
	 tGnR4yXPycbhNn0VJyz4s6a5Xm7VgSLDspVOExS4f8j9QLGU4K4j/WAyoz/jrANq1iakJ
	 Fg4xt2eb0MBlBmSH9sxLn9UzJ0YjHWLWs0OzSP+f4i5cDN+jwc29n7TvIrwXizCvOFg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8B4A51F008A6;
	Tue, 10 Nov 2026 03:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283006;
	bh=4k093y5/yFR6nFNSoFAD4QE4dU16QnihF4r5DnoFO+w=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=b426adghyB11o6+OcPpPOH49zlvfQjX0eaBeuRwx0PG9oDNAtIgeAOnieej3DsGxR
	 w7UnoZVJDfICIZVLbTdgK1KW8yjS7MedObvEfHgIWJopKioTrBhJioZ7jHJDwKasJw
	 OBsl80tuqEarR9zgE07uYQHt+0QNUcMAqqNz4/lutSZFUy7at7G4oRvmB4nF1CWAPh
	 qlj3vY+wlWzcf6A/er36+m6iAd2oyYOz4mj9YdMsgiUO4VMF1aoqQcGsNRibbYtm1q
	 eO4Odg6QppEOcVYSr+9yKRJVBeXa6SBJWT1mN6y1mers3WiLS3hWMbE1lU526ffBQn
	 BbmyaeVpZ+A7A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 18B76487D7;
	Tue, 10 Nov 2026 03:56:45 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 03:56:44 +0000
Subject: [PATCH] can: peak_usb: pcan_usb_fd: check that the channel has a
 device
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
Message-Id: <20261110-pcan-usb-fd-nodev-v1-1-fc11effbfafa@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPuV8moC/x3MTQqAIBBA4avErBtI7Y+uEi1Mx5qNilIE0t2Tl
 t/ivQKZElOGpSmQ6ObMwVeItgFzan8Qsq0G2clRCNFhNNrjlXd0Fn2wdONs9KSUHOTYK6hdTOT
 4+Z/r9r4fEPs1gWMAAAA=
To: mkl@pengutronix.de, mailhol@kernel.org, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794283003; l=3048;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=Unyy5Y2//kCaARk7Mh5QLhPHaGmOGCPoVXqetVMtAwA=;
 b=jyuCXnde+AGMc0XAGaTNWp5ioRE4QCXdmeIWNWdNHkCnZjjaT7ebhmhjdJUzAzAJmezYst+XO
 6hW0Eu/QegcCeI+B3yEZKMF+YPMIIpc7fBKP+MBe5rr++w4MFI+988J
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

The rx decoders of the pcan_usb_fd driver take the channel index from
the message sent by the device and use it to look up the per-channel
device:

	if (pucan_msg_get_channel(rm) >= ARRAY_SIZE(usb_if->dev))
		return -ENOMEM;

	dev = usb_if->dev[pucan_msg_get_channel(rm)];
	netdev = dev->netdev;

usb_if->dev[] has PCAN_USB_MAX_CHANNEL (2) entries, but an entry is
only set for the channels the adapter really has.  The single channel
adapters (PCAN-USB FD, PCAN-Chip USB) leave usb_if->dev[1] NULL.  A
device that identifies as one of them and sends a CAN rx, status, error
or overrun message for channel 1 while the interface is up passes the
range check and makes the driver dereference a NULL pointer in the URB
completion handler.

Check the looked up device in all four decoders and fail the decoding
of the buffer if the channel does not exist.

Found by LLM-assisted source review.

Fixes: 0a25e1f4f185 ("can: peak_usb: add support for PEAK new CANFD USB adapters")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
This issue was found with the help of an LLM-based code review tool
(Claude).  I checked the code paths by hand against v7.4-rc3 and
reviewed the fix myself.  It is build-tested only (W=1, arm64); I do
not have the hardware to test it at runtime.
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 39f0740421c3..c42cac212640 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -540,6 +540,9 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
 		return -ENOMEM;
 
 	dev = usb_if->dev[pucan_msg_get_channel(rm)];
+	if (!dev)
+		return -ENODEV;
+
 	netdev = dev->netdev;
 
 	if (rx_msg_flags & PUCAN_MSG_EXT_DATA_LEN) {
@@ -609,6 +612,9 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
 		return -ENOMEM;
 
 	dev = usb_if->dev[pucan_stmsg_get_channel(sm)];
+	if (!dev)
+		return -ENODEV;
+
 	pdev = container_of(dev, struct pcan_usb_fd_device, dev);
 	netdev = dev->netdev;
 
@@ -666,6 +672,9 @@ static int pcan_usb_fd_decode_error(struct pcan_usb_fd_if *usb_if,
 		return -EINVAL;
 
 	dev = usb_if->dev[pucan_ermsg_get_channel(er)];
+	if (!dev)
+		return -ENODEV;
+
 	pdev = container_of(dev, struct pcan_usb_fd_device, dev);
 
 	/* keep a trace of tx and rx error counters for later use */
@@ -689,6 +698,9 @@ static int pcan_usb_fd_decode_overrun(struct pcan_usb_fd_if *usb_if,
 		return -EINVAL;
 
 	dev = usb_if->dev[pufd_omsg_get_channel(ov)];
+	if (!dev)
+		return -ENODEV;
+
 	netdev = dev->netdev;
 
 	/* allocate an skb to store the error frame */

---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-pcan-usb-fd-nodev-8ca733252643

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


