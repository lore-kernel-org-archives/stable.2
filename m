Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504476;
	b=iipd8ejwAppv34fJQ/35bJnPpuVvPENdM9LY8UWeBJ09pCx7QNh0cF3PPs/F/TLWFgTp
	 ONvBaBcbhF8heBwZWGEVZE0PYCQU/t7sYulg0V4/+PrjPvxQCXBpsEWzUKxd/Ho0682I+
	 qYFdPNeYR/G9EiGgZIvIcVlK23LyhnFjRZhzmqqVL+vAvCBk6GzXrj3uZUwYI20tAz71y
	 Ipznpvv51ShK9ASf/8MQj0cWFFlhAWzmhEdb+a3C3dkW+3i6GiQqTLfemO0nbhKofFCAo
	 +shVYITbgB63CZPVWqhaccSQlr+2YR8LksNi1fXqPeryAPFHhql6yaujiH0igkqKGVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504476;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FQRPAOczeChNohAnaECEMnatXU5EQobFRvNRBtV70cc=;
	b=gAZU8AzPOVu7zwjFtKL80qf4LAa8Th28DPOiZ6ky/ktIM5xa2vGxabfAMZORhzClcVZX
	 e/gYhL+dBuXiXKNlPO5cOapKOC2rB21lo7te8hn9SN8867JynPrkK9MwoqGDbFx8L1Wir
	 1Y5qX77APUIhKHDbScJrcIGS6vd+4qTY5wSuUoRmq1owSlBZNYPrh/dF+uOUpz60cq2P+
	 R+5JwGCt9clFBOUFAAAlOrxE9D8DrSPiK7rh8Ud/WJcmg7O8PLAzNJFmCE7ZYWtjKBE3m
	 cycNtAd0UZT8g1LZlLEL3ZeeGNS7RMpOU1o2QX1Dfg26T3QqsgBUtmeFnJYHjU8j37g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ge0n0eNg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCF8606A89C;
	Thu, 12 Nov 2026 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ge0n0eNg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794504476;
	b=qduKTI2WCWq68UTTvHHAtm8P8R999UWNGtPKsyj3fX9gBim9xKTIQ3j6mLDKihggXjd7
	 +MvNEZ//jivUdn4MIHPADXdi+zE0sl+3puJr3p8BqUO5vPI8o7vtO5m6zlLzMlGyymZJc
	 +aP0yZ3fHOtDFsflGb7zgazknmKqsfC6vF2IA5XZXHRS83oniK+ZyBoLNLMl1nrblbbak
	 rFSiZZpOl1x5gH9lJmI9xvsRez5h6nT7Ap9aNxPwD81xbSPbExxxupGS59A6D+rOVJxGI
	 F1wPfvI5AnEId0WfNQTwyFMyrmxBtghBosKf+vmsHPZUzQPj3hPgnHI2dIlPtFIyN9w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794504476;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FQRPAOczeChNohAnaECEMnatXU5EQobFRvNRBtV70cc=;
	b=Zq7OYqf+lvdd/IOxbV1+qhyIHdLJ4/bSQnur8yzRLil/ahz5fM2/heMfnpx8INjrjsF8
	 DwAVza5xCp2Zec0EEs+5gW2LCzg0njEiMx7kjHnVsQJF0KuxAgNmuF3r5UvG00mqNjYKC
	 WTlGKf39Zm/yjsmKzBr0eYD4nhcp8hHR//nHP5VN1j5mgv8IKWfSwmd0bpCDKqvazQlNU
	 KoUNbUzzZ6/MK3HWqVAz1cECRCHl4VXkec7uO8ikIxO/fVT3o6GFAqfICkZDnod/yaUNU
	 KiF+buhQGsWgs0yQB4wkq9ZHaHS2Ua1I+Sw0EbD3xYCsa9wLfPCf2uSUU2pA1a4G7Dw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DB8E81F000C7;
	Thu, 12 Nov 2026 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504476;
	bh=FQRPAOczeChNohAnaECEMnatXU5EQobFRvNRBtV70cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ge0n0eNg1KgJYvTqgfRMoSR1JPCmn5oV5ubIULSq5jOrLFx/4l3HgeYf0IJBDly3O
	 6evaInpa5cz2s5ru9bDvwqknOs98Fx64SLWDK9UmgFpR6GbbmPmagh2aohkvHSjIil
	 J19upDhnOciZZzR7+2vqoBJZqYdaFUaAKL/U6hvadLsM3F7GVRXo1z7K11El+PA3hB
	 Qti2ezP2IPsAhn3h34LO8qdEi6A+EolF/sVH3g7AHUfRUdWKNqjyB35SgraSdCBhJ7
	 sJ7/wb8I2r1xZLtQGz+cMrEYmR4CP9qZQU9Msk8NBj7htFBuXTxQKSep54VmZKAXMH
	 x+k3FG/dJ2rbQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 69D9D45A88;
	Thu, 12 Nov 2026 17:27:55 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 17:27:56 +0000
Subject: [PATCH v3 2/4] can: kvaser_usb: reject devices reporting zero max
 outstanding tx
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
Message-Id: <20261112-kvaser-usb-validate-v3-2-61587f639508@gmail.com>
References: <20261112-kvaser-usb-validate-v3-0-61587f639508@gmail.com>
In-Reply-To: <20261112-kvaser-usb-validate-v3-0-61587f639508@gmail.com>
To: mkl@pengutronix.de, mailhol@kernel.org, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794504474; l=1920;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=CWXGNrvsTmGzERh91MhkIoNvIPE1iZLcRy1k5EnUGBw=;
 b=eWhwCB2ec+u2+vusPuOzFD336EmcdeHrufYk+hYi+V49i8qBMBj0YB8sF2wOTzoKwP/LwzN41
 SR+dSnTOsbuBz6Zxch7pFjc28hPvlebD1NxQ/Py2Sgr/HnVDovpNSeR
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

The number of tx contexts is taken from the max_outstanding_tx field of
the software info reply sent by the device.  The leaf driver uses the
value as is and the hydra driver only limits it to
KVASER_USB_MAX_TX_URBS, so a device can report zero.

dev->max_tx_urbs is then used as a divisor when a tx acknowledge is
received:

  kvaser_usb_leaf_tx_acknowledge()
	context = &priv->tx_contexts[tid % dev->max_tx_urbs];

  kvaser_usb_hydra_tx_acknowledge()
	context = &priv->tx_contexts[transid % dev->max_tx_urbs];

With max_tx_urbs == 0 a tx acknowledge sent by the device while the
interface is up is a division by zero in the URB completion handler on
architectures that trap on it.  On architectures that do not
trap, the index is not reduced at all and tx_contexts[], which was
allocated with zero elements, is accessed out of bounds.

A device that cannot accept any outstanding tx frame is not usable, so
fail the probe when it reports zero.

Found by LLM-assisted source review.

Fixes: 082d70b6142f ("can: kvaser_usb: Comply with firmware max tx URBs value")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index d0a2a2a33c1c..a915e529290b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -977,6 +977,12 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 		goto free_devlink;
 	}
 
+	if (!dev->max_tx_urbs) {
+		dev_err(&intf->dev, "Invalid max outstanding tx (0)\n");
+		err = -ENODEV;
+		goto free_devlink;
+	}
+
 	if (ops->dev_get_software_details) {
 		err = ops->dev_get_software_details(dev);
 		if (err) {

-- 
2.43.0


