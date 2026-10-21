Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584843;
	b=pV3xRE/IRkQnjz0znWovC5H2QgdN6Csw/iM7Pn3DBvWJIMf+f3sEh2BeSnIEAcTRRGbd
	 2k666REYXBbmh5pE05bV5HIAH8zfTEd63W++GmVv2P0uHpvRoIU2E2xJhZJesjQmfvRhl
	 iApaKGY6nx4bb9+Cq4QCe04qrfzm/I3SKIz9UfWDksZXNbMl2TibrAm78tN1dge/SRhgS
	 O4ETQ4byf+5urlfbhvhlqPmtpfbu6iE+s6OmYroVxjhAt4iFWozbKlCZs3ujXnfdZJD29
	 Y/WUt2dU27bf0xmcT7RhsI8Lh5W+Ptyz6vXARorZ4bJr2ct6H22z/jBxJuylpYEYYQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584843;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pYbff7YL9r4gfyuxiKyz5UCHkFgNrqOk1gWb3l2d508=;
	b=EsIddNja+TMmk9tg5muJHxyEmlK0IJnLQNb+h6fTIXP/xJmPooHONG4YSR8162I1jQbw
	 s7iSYIPgJ6ZsYXdsYWzf42XQaTqogg9wwP1v6C87hj0QYXO/7H+wO7vbSO7p7ZVuVpfUa
	 uyTWm/BQtHb2RO/at36c0WQHmIUjsFYJkVCT5XgmERz+od6qMhQpJhAu1SDz1vUDNRbnL
	 CfRq4cAAJsEHvVfCc3n8hGgl57IQLwbHgk3eXSEXRmuoHXKqpgiwHACzvVMJ4vwEiLGrG
	 YZVBkTT60hnIUzyBaiFXrrt0rWvD4DOMXiMP4ABtNuYrcsXH6/p/ZNeT76/XQvE2FOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+uQ4a4y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C075606A31D;
	Wed, 21 Oct 2026 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+uQ4a4y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41981F000C4;
	Wed, 21 Oct 2026 12:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584842;
	bh=pYbff7YL9r4gfyuxiKyz5UCHkFgNrqOk1gWb3l2d508=;
	h=From:To:Cc:Subject:Date;
	b=T+uQ4a4yeeNWm61J/FEV4BYlT2ASVSdvVpjsd5maVrgEPFUUkFPkowkmFDHn25mcf
	 5qHofvI5fJgV0QNR2w2qmpqSgHRRJqZpmY+Z/rWKRej5dsCz7rUvGOuWwTwZ7J+Mtg
	 fBiI2SxhWfbznc4pkyfkc2YaIMd29jrOL6cdWynZOYPzwijXRJk3xnV2OJt0nM9cFs
	 lL6FW7U9Sf9FWujpbRpAF27vdw9e8KbCr/7OYmzjGxCXfOZUDZk4HigdKvAALRw+yf
	 N5XzHaWUS10yrSf+e7uD7Rc0CeuPC1dILTxcpuoIeJxof7y/Av/N2JRWarJvWNmGJX
	 zhACoOC+q7a3A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ming Yu <tmyu0@nuvoton.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/28] mfd: nct6694: Allocate USB DMA buffers with kzalloc_obj()
Date: Wed, 21 Oct 2026 12:09:23 +0000
Message-ID: <20261021121245.3111563-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
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

nct6694_usb_probe() allocates the USB transfer buffers usb_msg and
int_buffer using devm_kzalloc().  Because devm_kzalloc() prepends
internal devres metadata to the allocation, the returned buffer pointers
are not guaranteed to be ARCH_DMA_MINALIGN cacheline-aligned.  Mapping
these unaligned buffers for USB bulk and interrupt DMA transfers risks
cacheline sharing and memory corruption on non-cache-coherent
architectures.

Allocate usb_msg and int_buffer using kzalloc_obj() to guarantee
DMA-safe alignment, and free them on probe failure and in
nct6694_usb_disconnect().

Fixes: 51dad33ede63 ("mfd: Add core driver for Nuvoton NCT6694")
Closes: https://sashiko.dev/#/bug/linux-6f9e5ba3-714e-41ad-b6cd-3a17c665b87f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/nct6694.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/nct6694.c b/drivers/mfd/nct6694.c
index 308b2fda3055..e2957e587d1b 100644
--- a/drivers/mfd/nct6694.c
+++ b/drivers/mfd/nct6694.c
@@ -284,17 +284,21 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	if (!nct6694)
 		return -ENOMEM;
 
-	nct6694->usb_msg = devm_kzalloc(dev, sizeof(union nct6694_usb_msg), GFP_KERNEL);
+	nct6694->usb_msg = kzalloc_obj(*nct6694->usb_msg);
 	if (!nct6694->usb_msg)
 		return -ENOMEM;
 
-	nct6694->int_buffer = devm_kzalloc(dev, sizeof(*nct6694->int_buffer), GFP_KERNEL);
-	if (!nct6694->int_buffer)
-		return -ENOMEM;
+	nct6694->int_buffer = kzalloc_obj(*nct6694->int_buffer);
+	if (!nct6694->int_buffer) {
+		ret = -ENOMEM;
+		goto err_usb_msg;
+	}
 
 	nct6694->int_in_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!nct6694->int_in_urb)
-		return -ENOMEM;
+	if (!nct6694->int_in_urb) {
+		ret = -ENOMEM;
+		goto err_int_buffer;
+	}
 
 	nct6694->domain = irq_domain_create_simple(NULL, NCT6694_NR_IRQS, 0,
 						   &nct6694_irq_domain_ops,
@@ -352,6 +356,10 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	irq_domain_remove(nct6694->domain);
 err_urb:
 	usb_free_urb(nct6694->int_in_urb);
+err_int_buffer:
+	kfree(nct6694->int_buffer);
+err_usb_msg:
+	kfree(nct6694->usb_msg);
 	return ret;
 }
 
@@ -367,6 +375,8 @@ static void nct6694_usb_disconnect(struct usb_interface *iface)
 	ida_destroy(&nct6694->gpio_ida);
 	irq_domain_remove(nct6694->domain);
 	usb_free_urb(nct6694->int_in_urb);
+	kfree(nct6694->int_buffer);
+	kfree(nct6694->usb_msg);
 }
 
 static const struct usb_device_id nct6694_ids[] = {
-- 
2.56.0.218.g1ec904b173-goog

