Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FEC2C026C;
	Sun, 30 Aug 2026 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788056107; cv=none; b=QMGZhXdN2cg7xo0qrh3IWbVkZ9MBkkYwmi/zGX7O3onkZhpnShyzDugf2aWgD+Pxa+kMkDv0FHVzOQ4buaKCdiuOjwkhTYwRkQ5BhzPlcXSk6U9KWRTgksG0K1tKE9btwPoGuZMYfVJU4hK+t8+Lrd423CcBLOh1ZepCIWN6AT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788056107; c=relaxed/simple;
	bh=dVr4SRrJGXWGcKqScSgx3QNpuF5QSXV96o7UGwftkWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OxGlTTU7rX73QKVU0GLdyshDc2UPzWBQ5cXI38wS5+atCOjWyG9T8jr181Ng0xJcJXm34mc9NYdv/ONbpWscaKS0fRfGhSxKkVaoDQGy1XGG+43M7Rm3+Y/Hj+6ftGca1kiXCuyrOEmxhaZDxJOkxohDk4p9pGPxT5f+67j9cJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=QrQ9XwBA; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="QrQ9XwBA"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd1b64d1;
	Sun, 30 Aug 2026 10:14:58 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: gregkh@linuxfoundation.org
Cc: runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: pch_udc: Initialize spinlock before registering IRQ
Date: Sun, 30 Aug 2026 10:14:29 +0800
Message-Id: <20260830021429.2050000-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa05072d56e03a1kunm66846047e8ea4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZS0pJVkNLGh9PSE8fSx8fTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QrQ9XwBAYyQ5XpE61ycxILXdQq+X8OHNwTRB4BN6sVRKBXaG+8VsyZI5f/+i4c6sKLs82gCCiPRNhd6cdY2eXaJGmZKKeQ4poncTTvxi+jnH3KjO4O7KgNwd5nes8/1X8EC6ArM9kRybjJ4QljYSTpWmiOlBWoxMWd2BWGYOcCI=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=k3HQbXxWKDtB+7XHpRo+nHhHKJvF0k5IK1s24iOHcnc=;
	h=date:mime-version:subject:message-id:from;

pch_udc_probe() initializes dev->lock after pch_udc_pcd_init()
registers the optional VBUS GPIO IRQ. It also requests the PCI IRQ before
initializing the lock. Both interrupt paths can run during probe, and the
controller interrupt handler takes dev->lock.

Initialize the lock before pch_udc_pcd_init() so every registered callback
observes an initialized lock.

Fixes: f646cf94520e ("USB device driver of Topcliff PCH")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Assisted-by: Codex:GPT-5
---
 drivers/usb/gadget/udc/pch_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 99b3ce282..e5321d0dd 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -3067,6 +3067,7 @@ static int pch_udc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return retval;
 
 	dev->base_addr = pcim_iomap_table(pdev)[dev->bar];
+	spin_lock_init(&dev->lock);
 
 	/* initialize the hardware */
 	retval = pch_udc_pcd_init(dev);
@@ -3087,7 +3088,6 @@ static int pch_udc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_try_set_mwi(pdev);
 
 	/* device struct setup */
-	spin_lock_init(&dev->lock);
 	dev->gadget.ops = &pch_udc_ops;
 
 	retval = init_dma_pools(dev);
-- 
2.34.1

