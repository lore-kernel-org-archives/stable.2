Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097380;
	b=In1kbue+US35+Ge1OZGtq7TiETEbIYBE9/JTQ5J2b2WX4L/hHNgSpJu3nNrB1Y6zkf9B
	 oPaXiz+fEymGa1hd7CRpxIHFUXk7rVy83esomXvlEdUaGSuncqHmPkdk5KZ3tlagJgH5x
	 zKDvdWuzJ9vNTMqCxrUUM2jcn9AbWLfkFXIO4KRjBvlcKeWHB3IKAFOW4+EYyjPCW1BtY
	 rq+OYFFkDsdJHrkxHoaOA2Y4oDxF5Vo/BILZjxxuXpdr6Dl2RcS6nAjPi73ez30aq3NQY
	 6Ik6WAE+k90GtrqTxQgJybryd8EKppBbPOR30ktY2HUrajABYWRLLILWokfbcT5KTLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097380;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XiCgJsO8LmsZTRb5BzEFtXMEim83LHNC/CQTmm3N2Ho=;
	b=kbRdd3QotJz7zFJfVL153Hb2VheIH4TrSbpOtw11zILaU1JVmr6pltwLK6Ug0S72md8J
	 MXvyPh5LZUT40N+td7oJqS6X0CfF96HGdJXWHQXGTXzshXFAdORxIFG8HX/iygUESEBpB
	 Atu+AsnwF86ppcxHtDN7LdPwAcoKX0Hj4e6Ps+x0Y74JCOAMBwh+wdJZOvCJXvGe5LlZv
	 QPq79yalCw60O38G+QVCGIRfi0Oq/SC0mi0uDEydkhTFQhTidJLbOVGKDhEKIcyOvHzHm
	 uNQu8NwM/9P/Y3w19+f2omL3IZgWj5RdIwZjeXa1PiY7XSZ4raaLG0tb+V9P7fI9ByA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpDvYQSv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A2606A321;
	Tue, 27 Oct 2026 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpDvYQSv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5567F1F01825;
	Tue, 27 Oct 2026 10:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097379;
	bh=XiCgJsO8LmsZTRb5BzEFtXMEim83LHNC/CQTmm3N2Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lpDvYQSvRyB2mynqVHSbFLqhAWPA6GDEsmVyIPznYAYBTw+NtOK/2+FdmG41TgcNr
	 wasNLET1h2uojohhBG7CN5kKujWeqD/iRwKQno9mkeqZns9LWSphP0j37diz9zburx
	 nyj9GZ2K0go5yRerVyoHaN2FDHmV/4Au9ywUfRSu+EKbZ++cq+FoF6OZrZ2IkXIihm
	 4N6FIU9t1UXUA/eJM7e/4T22V1gejUnvaZvMTCgsZPpPG1h25zhT83+a/nWx9qtnTC
	 9Cq5yFI7SjSe8FUqdRsBuyk69XxXeA+NTAEGEgsxvndczw5Z5sgbC7AScAb691WRRR
	 RePHiIOQ9WEdg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ming Yu <tmyu0@nuvoton.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 01/27] mfd: nct6694: Allocate USB DMA buffers with kzalloc_obj()
Date: Tue, 27 Oct 2026 09:30:30 +0000
Message-ID: <20261027093306.2812695-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027093306.2812695-1-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
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
2.56.0.307.g5fe7bd680c-goog

