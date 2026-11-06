Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954876;
	b=QujYjPnwHdi74SXyp7AD1RyO3cZPSCd4g+v7Sl5D/tcMDHMuCve6GJ3ypXkpYVrlhJyZ
	 Z960H+0B68il6UJfxWkKVBEAoKrFU5wV/dOGKaf26O7VRM9uHJTsmhnZ4ro0ASx/AbLp8
	 H8KxdTOo4GMgGg4BDzC6tP+fDvYY6cwgIWat1t0F5a9qWTl+1m9vg+OqqhM9fFY3u47TZ
	 REaHAxQk/1LU74sDWQjc7AFhZds8CR5JNbQ6lHpeTJUExO51qzMCbpGmxFscYUtD2Kdk9
	 f/qaHVS3HBqlOceg2aXpHh2oYr9fobvhRGm6QfEYe2/YfaUByOklIT3lU7szPQeN1TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954876;
	h=DMARC-Filter:Received:Subject:From:To:Cc:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=h/4lCx5YHTMucoB1S7Px0zKZz/f5KR98aiYQ/OUQG/Y=;
	b=hC6zugrgIz/E/MverNNM+X6wN///EMqN9Ez+J/37vmr1TAHI+tPL+xAvPNtDUd2FCl3K
	 pGdLhPl2laQBeTVM8EtCB7NDc5i9zhJWuJoKIdcP5GznWBMyMlxJFCDjt3eowQk5HBoIb
	 VpqgF3S3aMiatkoP6tk3yC34X/cSPBeR/gQD7mf7Nq9yMjiIM0cxOXR55dakMXAHulljb
	 BZDgllcAPyAhXXi9fIL4ITnWC6ah0lLfNou4KSREtABePSekLSG5iBl5/EaCZi42PWLbv
	 62r6pYGnFt0eb35Ocf0AFOFhUhI37Q/oO9fue4D+iksFWJLvgQjwd2SWwZMx2NvgKBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95638606A326;
	Fri,  6 Nov 2026 08:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95638606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3kbczlO1qD41uAA--.1707S2;
	Fri, 06 Nov 2026 16:47:47 +0800 (CST)
Subject: [PATCH v2] dmaengine: switchtec-dma: Fix device reference leak in
 switchtec_dma_create()
From: Wentao Liang <vulab@iscas.ac.cn>
To: Logan Gunthorpe <logang@deltatee.com>,
 Kelvin Cao <kelvin.cao@microchip.com>, Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, vulab@iscas.ac.cn
Date: Fri, 06 Nov 2026 08:47:27 -0000
Message-ID: <179395484742.2120950.2917629799587193019@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:zQCowAD3kbczlO1qD41uAA--.1707S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWrCry5Zr1rCFW8Gw4fAFb_yoW8ur1DpF
	W5Was3GrWjyr1UKa1Uu3W7ZFyj9w4Sy3yF9rW8Aw13ur98X345JryxW340qry8CF97GFnI
	qFyYyrykWa40yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUva1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjfUw_-PUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEDA2rtTw36PAABsE

switchtec_dma_create() takes a reference on the PCI device with
get_device() and stores it in dma->dev. The reference is normally
dropped by switchtec_dma_release(), the device_release() callback, which
only runs once dma_async_device_register() has succeeded and the device
is later unregistered. If the registration fails, the error path frees
the dma device directly without ever dropping that extra reference,
leaking the reference taken on the PCI device.

Drop the reference with put_device() on the error path.

Fixes: d9587042b50f ("dmaengine: switchtec-dma: Introduce Switchtec DMA engine skeleton")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Rebase on top of the switchtec-dma fixes from Logan Gunthorpe, which
  are now in mainline. The change itself is unchanged, so the Reviewed-by
  tag is kept.
- Link to v1: https://lore.kernel.org/all/20260916093332.2003909-1-vulab@iscas.ac.cn/
- Sorry for the very late reply; thanks for pointing me at your series.

To Frank's question in the thread: no, switchtec_dma_remove() does not
need put_device() either. switchtec_dma_release() is reached through
dma_device_release() once the registered device gets unregistered, and
that is where the reference taken by get_device() belongs; dropping it in
remove() as well would put the PCI device reference twice.

 drivers/dma/switchtec_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index a386c3a284e6..713ba7ba1125 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1333,6 +1333,7 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 	switchtec_dma_chans_disable(pdev, swdma_dev);
 	switchtec_dma_chans_release(pdev, swdma_dev);
 	switchtec_dma_chans_free(swdma_dev);
+	put_device(dma->dev);
 
 err_exit:
 	if (swdma_dev->chan_status_irq >= 0)
-- 
2.34.1

