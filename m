Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE93D413F;
	Wed, 16 Sep 2026 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551255; cv=none; b=SgNxi3x5qzh1htN4d+pxW1oIqSPsDKCpH+KToE20xg/a6ZzKnKRhFQP1tgF/Ac0sb+7jqeyKUCl95nnmHKziPxw5pYim4dVjajYFd8BU4cfTIo22VAnTRkHWSsIfKISuX+VqfFw6d2gYg6cM0CAUJIX04jgymk1KF4adPIhirfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551255; c=relaxed/simple;
	bh=CDYS1ii0lSLxnT/NsEzf3WIIr6y1eB5d9KK/AUQkWd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XKynPW4dsU8WPX3R+1gWgSZcGk5PtNZsFDuz9aRKl0xX1yDOEUGyxPBO5EQcEtBTJbcI9pr4Xqqq8wzkJNJ7KnoC47NGspGXxIqDaw7DRdZeVZoHcXCO5/0ktfK1e5oIetxxTyG19k7Zb/m9Q8eqN7TP6tVqVvfW/qdNHIYr4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHijiIYqpqgWjgBw--.42205S2;
	Wed, 16 Sep 2026 17:34:00 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org,
	george.ge@microchip.com,
	kelvin.cao@microchip.com,
	linux-kernel@vger.kernel.org,
	logang@deltatee.com,
	vkoul@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: switchtec-dma: Fix device reference leak in switchtec_dma_create()
Date: Wed, 16 Sep 2026 09:33:32 +0000
Message-Id: <20260916093332.2003909-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHijiIYqpqgWjgBw--.42205S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr15Cr4DJF47Kr1furW5Awb_yoW8Jry5pr
	W7Wa4akrWUtr17Kw4Uu3WUZFyj9a1av3yY9rW8Aw1fur95Xa4Yvry8X340gry8CrykJF4a
	qa47trykWa48t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUrr
	WFUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEMA2qqP7mR0wAAsG

switchtec_dma_create() takes a reference on the PCI device with
get_device() and stores it in dma->dev. The reference is normally
dropped by switchtec_dma_release(), the device_release() callback,
which only runs after a successful dma_async_device_register(). If
the registration fails, the code frees the dma device directly from
the err_chans_release_exit label without ever dropping that extra
reference, leaking the reference taken on the PCI device.

Drop the reference with put_device() on the error path.

Fixes: d9587042b50f ("dmaengine: switchtec-dma: Introduce Switchtec DMA engine skeleton")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/dma/switchtec_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 3ef928640615..b07bdd0ac540 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1297,6 +1297,7 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 
 err_chans_release_exit:
 	switchtec_dma_chans_release(pdev, swdma_dev);
+	put_device(dma->dev);
 
 err_exit:
 	if (swdma_dev->chan_status_irq)
-- 
2.34.1

