Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919698;
	b=b6vrZBp3HBh3o6JGWzRzE+l3yn3T5jEJLKjwkjXcRtioo+a2BwyW87C/BqWSgremYgHm
	 Yaw9e8910/yXjrFoeyDcsYM53wg9iyvRvT0sX/D4QPgUZ+zZOCTlIWck0+ooUBLrn8GmF
	 17G0oL3VjzboxB3tcncgtjbkpyF8AkE/XiO12OurwA9AchN9vgf4YocqRz3EzQeS8e0g3
	 dbVSodYvDy0SfLmgugaC2L1dcFnlHClBnCe9PqNXvq3rnbcezdISKhjcEHAvXQjl8fKV3
	 ck4QoDZxLj0mRcbJT0Q43Y26QaKT+OZG7LihVg3lY6oXZVj8oc2tSv40idEFKP5wXTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2UZ4KDs27ccMSIJ05qxi98qMn453KRwTQ3SPpAtEY/Q=;
	b=vkBhfoywsch3wZUkrSJZmiyJm4FabYeQnH5a+TxpUzr44yr9pX50Xbxl+SmEucao9+Ax
	 HJzfhOu8zSk3dXM+4hB6uTBvf3bFn1H0RrxtZWJ/iFQHmhvhXUKh6aEaTFn9XQScLQ3OA
	 4d4yJWpRpxcL5pMfhnKUFHzQXWDIv1ew7LdXx4jJ9qoyVvGzehCWUmuH9M4egYwfOAWc6
	 eaT52gz4z59CB6Gzos8y4cvtN4/7zb14M1TTwqW90Xu0oEv6HK8oBvxOEyV9Ug2YNJACz
	 paybEfv8/3+k3luMSVLqsq4NI+mDMOYDRmiv/QYrNAxZWBBRh7Qc5UG5zky0DlSDfUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=BvEtF63N;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780D606A899
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 12:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C780D606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=BvEtF63N
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so20787235e9.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 04:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794919696; x=1795524496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UZ4KDs27ccMSIJ05qxi98qMn453KRwTQ3SPpAtEY/Q=;
        b=BvEtF63N5fmFZW/Le7YGJ2Wf6gX52ILIGV3jphIVCOJrKptLFhQJPhFoaimdJotho8
         SiT5Lq/DLcr8c8SyqyTlqxA0W/8CCbeg1eXRvInDR/H4DHjQ4rI87RxPlJLZTXHuvHJa
         b0ZZsLwP2eog+8LdjhUMxEvUVn7QSxw1GNk94w6uGHVnxdWrk//Kgwueg4kTigKHOaw3
         XlSriOotJWHlImnSoDMr1uY45mUpvmSdpk+6L9xAgWmGIQbSHjOQ/VGF9cbz5l0hJWNU
         zQKFvM0TqsJw9cAZSlISutzIC1QnvLKVF06M44l8XXH8K9dWkquv7yVValkJoW28DU08
         5lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919696; x=1795524496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UZ4KDs27ccMSIJ05qxi98qMn453KRwTQ3SPpAtEY/Q=;
        b=u9g/RSPCUU1IIPX09+ecYzyP2mxeI5m504LnUi+7b9UIHXc8gxx0lyinquGEpdYXhK
         pCf8DPdIcR0IgN8kdMU1d6Wmfvb5L3VwxM+Esq0t9XUt4h9ceTeBjE3h2hs8nBNU9Nb0
         HlarmfsSvhcvNbLciRo8LiD+mQZw9qAXOILkIqDvFCmtdMmA8nP7cA9o2LqowUzh9t/n
         A5Ep+wB1bjC02J6n9X2JSqnmQkIZuBCMYjMkpoPlwv5UF+nfW9dGKqzCub9b0hPZegD8
         xyr+W+2Fi4WtVaZA+3kqjb09+HWGm8Ytg+Oh7ZVZGNLQqfKWUS65oHHE5u7Y0y/WnRhR
         8C8w==
X-Forwarded-Encrypted: i=1; AL+hErHY6iCwd6OLMbKLuPeCXfa5xpgCOf9HB6rOYZ45OauHr6u5v+MxZQ9OzGN/q0Ta7vC+5JoKAtA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/V7xnBA3nNQkAYPUMOnSIM+tQtlVu/5Xdz46paf9ad7eybHbpr
	NnnuR0NxkfbEh+5Dwrca4Ewekro/aphj3V1gacXiKG6AzO6RtZe+JP6PRpn6FXbBmOE=
X-Gm-Gg: AYBFou1AHl27en5N1SP14Dicyq6bunvQCfFA6GAssmErEda8W2+8fwaZg4kBH+V9xTk
	DSfDK2utGzGnftB+ki+hnljeVWkY37qDsSexzOJCSc+wwcISz9srjjcVTxDCUQMoX4oI1lz5mpD
	yJHLh3Pfme44FpnoeUf6wWfEF5k8ybRvXhSAFh7urqZi76C4Ih1Drh6uZui76kF1mJ8cxBe7W6F
	xkVyQ5/+HN9zIG6yJRLIvxZ8LjoEYYCq8Edru3AGEipJgOwoX2XVCs1eSG7/aXD8rs/VuWuUe/J
	yrUKcnGXdqom745NNzJ0UiDSc4fZIz1ozxZ7LUKxCUvaPi+/j/TeXcWxnCBdX5X4qF9Z2ZT0qS+
	9BITeJ3O9REGBRTf0RNZue50ESBSOQgt6QTEjJ5KAgAyI3NaaMHIi1aUVZcpSFEqVl8597am8sX
	1R25sNfBiezS0uDw+PXtzq6oTTUevpdGMtN4hUIxZ8W4LIUZK4HJi/ANag6cv9RCAWXN1Yd/b6c
	KP4PrE+OnOD3aZgwMBs/zcQZiGG7A16EdoNCNZXuJvSRZfsv1DXlSGezZu11JhK9I170XSMKrfB
	gprfdTX1QnrPfuA7Zjf+0+KP2iK3I3zbEu49bwtnlRgm2ZHTdaYAVFIoDe+rGCGTRo0fOmCGtAH
	h9rO/GeIRWcx57FFxhPaFEHopJPKXouQ=
X-Received: by 2002:a05:600c:6089:b0:4bb:76d9:f81a with SMTP id 5b1f17b1804b1-4bb76d9f83amr77248575e9.34.1794919696039;
        Tue, 17 Nov 2026 04:48:16 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5f350d51sm124029135e9.4.2026.11.17.04.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:48:15 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 17 Nov 2026 16:48:07 +0400
Subject: [PATCH v3 1/3] usb: gadget: udc: Clear a pending connection when
 starting the UDC
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-udc-connect-v3-1-9413b491d213@flipper.net>
References: <20261117-udc-connect-v3-0-9413b491d213@flipper.net>
In-Reply-To: <20261117-udc-connect-v3-0-9413b491d213@flipper.net>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Xu Yang <xu.yang_2@nxp.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044; i=alchark@flipper.net;
 h=from:subject:message-id; bh=52B6NtpvqPp1v/6zvOd5T1p3lDIt9y6MOcV/446fH1E=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT98eWOuhAQefuhmuGtvc8j9ZcGMP6VFWwW5Ml1PBxSH
 JB8RUaqYyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKn+vZ/hf2H4Q/cbe7ndb+meuRmbfsV7GhNr50r+tg8Z+wt3afWW8TIyvHj+4c2
 shFiL3y3bbhr9jlJMf9BYlPZBNvK2zk4lrqi3DAA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Since commit 62911bc82b03 ("usb: gadget: udc: skip pullup() if already
connected"), usb_gadget_connect_locked() returns early when
gadget->connected is set. A connection requested while the UDC is
stopped sets that flag too, without enabling the pullup. A later
gadget_bind_driver() or soft_connect "connect" then finds it set and
never enables the pullup, so the host doesn't see the gadget until it is
unbound and bound again.

This happens whenever a UDC driver reports VBUS through
usb_udc_vbus_handler() while no gadget driver is bound, e.g. when a
Type-C port controller switches the controller to the device role at
boot, seconds before userspace binds a configfs gadget.

The pullup is never enabled while the UDC is stopped, so clear
gadget->connected once it starts. The bind connects according to the
VBUS state that the core tracks anyway, and a function that deactivates
the gadget during bind still has the connection recorded for
usb_gadget_activate().

Fixes: 62911bc82b03 ("usb: gadget: udc: skip pullup() if already connected")
Cc: stable@vger.kernel.org
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/gadget/udc/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d5844384c368..577bc15f61a1 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1236,8 +1236,16 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
 	}
 
 	ret = udc->gadget->ops->udc_start(udc->gadget, udc->driver);
-	if (!ret)
+	if (!ret) {
 		udc->started = true;
+		/*
+		 * The pullup is never enabled while the UDC is stopped, so any
+		 * connection recorded meanwhile was only a request. Forget it,
+		 * so that the next usb_gadget_connect_locked() enables the
+		 * pullup rather than returning early.
+		 */
+		udc->gadget->connected = false;
+	}
 
 	return ret;
 }

-- 
2.56.0

