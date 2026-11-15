Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743277;
	b=ZGkiyul0TziKoO6wI+DAyzaKfp8ETxR/XYvJA+Uu+Ylf6hOAi+trGw0sJMbQt09Hcgit
	 vjM8QNfX+fmi3ppo6z6FlJCYmLHWjc/74zlGfhNVM0qPmoSgSlIZzBa0D60715L5L7u5K
	 b/rjnsy7s5D4xVisJCxTLEkPyvbSYaJhVC9D7+X/Z2/WJPt4i8FMPDzs+HlmALGB/vFll
	 TTDqDst4YcGOsGAybAVTb8xRtVf7YJPg8f3+Eg5axyXOMTIhLUUlNlLI+DHdH7MtCBjT0
	 ntBMO6pgbB+ledrIjiQaO7FAPxkCG1VW8JpQK5vaf2VeTVYu/khtjt3c8drt//PV7PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743277;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=cNveIAVpkhVpbi7+FYZP8+iE4eKe75P5j/gqWh+mb7A=;
	b=B7vlmzJYys2KCPx3gCrh+cOiJE2zZo0Jsbms4wHrmU6uGgkf48YzQvHQrztik67KGHMk
	 Gxb9qL4CM1UCAMfL3NDrtkTezWjmnSi0m6xz7NIG1/U04zqYZjYFGlE9iMLHTD/fKAc55
	 b6vlh+zpCF8uApMtOtgpP1Z7vLhf5I/Hr4U5+lhCnwfeFeeIg/exDTJDP9Ot92/1G4mnz
	 4TBsyFkfVbaGDsCKkeqtx7U3/cjIhRJMOUtp08A07D7ANGyNREqfv+chC/3Qn2u+prwgI
	 gionG4qRKnx18vSTWLXsxTZ8See2Dmp41MstdiovByrvP50RoZrYNhBZxzjpIseGk8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=bTY7rP6H;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FFF606A33E;
	Sun, 15 Nov 2026 11:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48FFF606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=bTY7rP6H
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04df;
	Sun, 15 Nov 2026 19:47:52 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vladimir Zapolskiy <vz@mleia.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject:
 [PATCH v2] usb: gadget: lpc32xx_udc: drain pullup work before teardown
Date: Sun, 15 Nov 2026 19:47:49 +0800
Message-ID: <179474326988.103840.10326852247134349070@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df09040203a1kunmbac61c98bf783
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGElIVklKTEkZSEhJGUIYSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	JKVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=bTY7rP6HcMLSIs4lgrtWO7hXVznAuMLnG7V2RqvKxnJbGIQuJij5+oo+P9IjAswYmFwcb1EypOZ4DTFOXd5cMopo35EF97kCPrt8HBjqTA1qAAuz1lsy4wP8Jg2sRL/fsYaPhdpHBT/gWWkYdAKfQLiKn6RrOjrT9joX5rY7BSY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=cNveIAVpkhVpbi7+FYZP8+iE4eKe75P5j/gqWh+mb7A=;
	h=date:mime-version:subject:message-id:from;

The pullup worker accesses the transceiver I2C client and UDC
state. IRQs can leave it pending when remove or a late probe
failure releases those resources. Cancelling the final pullup
work would also discard the requested disconnect.

After the gadget core has stopped its callbacks, explicitly free
and synchronize the registered UDC IRQs. Request pullup-off and
flush its worker while the transceiver client is still retained.
The worker needs no UDC IRQ to finish its I2C transaction.

Track successful IRQ registrations during probe so late failure
also stops all acquired producers and drains pullup work before
destroying DMA resources and dropping the I2C client.

Found by the author's in-house static analysis tool.

Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
Cc: stable@vger.kernel.org
Suggested-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Link: https://lore.kernel.org/all/20260928134158.117-1-getshell@seu.edu.cn/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/usb/gadget/udc/lpc32xx_udc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 94355d3..d627a2a 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -2978,10 +2978,17 @@ static struct lpc32xx_usbd_cfg lpc32xx_usbddata = {
 
 static u64 lpc32xx_usbd_dmamask = ~(u32) 0x7F;
 
+static void lpc32xx_udc_free_irqs(struct lpc32xx_udc *udc, unsigned int count)
+{
+	while (count--)
+		devm_free_irq(udc->dev, udc->udp_irq[count], udc);
+}
+
 static int lpc32xx_udc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct lpc32xx_udc *udc;
+	int irq_count = 0;
 	int retval, i;
 	dma_addr_t dma_handle;
 	struct device_node *isp1301_node;
@@ -3112,6 +3119,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 			udc->udp_irq[IRQ_USB_LP]);
 		goto err_destroy_pool;
 	}
+	irq_count++;
 	retval = devm_request_irq(dev, udc->udp_irq[IRQ_USB_HP],
 				  lpc32xx_usb_hp_irq, 0, "udc_hp", udc);
 	if (retval < 0) {
@@ -3120,6 +3128,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 		goto err_destroy_pool;
 	}
 
+	irq_count++;
 	retval = devm_request_irq(dev, udc->udp_irq[IRQ_USB_DEVDMA],
 				  lpc32xx_usb_devdma_irq, 0, "udc_dma", udc);
 	if (retval < 0) {
@@ -3128,6 +3137,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 		goto err_destroy_pool;
 	}
 
+	irq_count++;
 	/* The transceiver interrupt is used for VBUS detection and will
 	   kick off the VBUS handler function */
 	retval = devm_request_threaded_irq(dev, udc->udp_irq[IRQ_USB_ATX], NULL,
@@ -3139,6 +3149,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 		goto err_destroy_pool;
 	}
 
+	irq_count++;
 	/* Initialize wait queue */
 	init_waitqueue_head(&udc->ep_disable_wait_queue);
 	atomic_set(&udc->enabled_ep_cnt, 0);
@@ -3158,6 +3169,8 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	return 0;
 
 err_destroy_pool:
+	lpc32xx_udc_free_irqs(udc, irq_count);
+	flush_work(&udc->pullup_job);
 	dma_pool_destroy(udc->dd_cache);
 err_free_dma:
 	dma_free_coherent(&pdev->dev, UDCA_BUFF_SIZE,
@@ -3183,9 +3196,12 @@ static void lpc32xx_udc_remove(struct platform_device *pdev)
 		return;
 	}
 
+	lpc32xx_udc_free_irqs(udc, ARRAY_SIZE(udc->udp_irq));
+
 	udc_clk_set(udc, 1);
 	udc_disable(udc);
 	pullup(udc, 0);
+	flush_work(&udc->pullup_job);
 
 	device_init_wakeup(&pdev->dev, 0);
 	remove_debug_file(udc);
-- 
2.50.1.windows.1
