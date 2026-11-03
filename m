Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666759;
	b=vVEyXZxeq2yasbTr5XEVf8QlkvDhK8mZDssp4EPDx+eOY8+wxh0mSsnHHVPXmetqrlyN
	 ytnKsYCaqFmsH78XBvyCmV9hop4ZHQi+Yw7YYhOjG8iTvlaCcvxXVZZQq9QXaT8aITre4
	 EIpP97YhDT0FLGxtI3MnVlGNlUKDF64uMlMBBhKYhejaKvqiCSaovE0VD5S9bHAIzGqf/
	 kS/aXwcbeoL8rpu8uL6SnAP2DoigcBUDKxG+rOksSsiwfdlUEiQ7U3LAVCv4N1oTQuAON
	 UHVE7R7dNdZTZ4im8QZr5zWXm+lsJAlzW7Eijob45I/jqA5NKCezhVCZyuuP944TVyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666759;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=Xuo+XnZ4B0PNX5shIuREYCE9/GcSOvns3/xyNK1aQJ0=;
	b=ZRwobawSTm8swHjkVoWFy/Kl8pjjNC1Uhy5xhxfooBxwU7ql+BRKptC7Qaf7SIzxfd/5
	 yV5tNqujpy3zzy7dyoTm5HV5wQ8C8n7GBq1PCe0vZuBhSw9Pvo6kbgdQP5gLu3vbymgdy
	 pLxtVYZjtdlTnJgGgHKEsLUwmDPx5M01ykPTHdDLJyCNetR4IerDbhVkBbQBOmbosV6RJ
	 wbJCWTzrJ0d6BYw869Y/trNINSqp6g0kAx9bOHFakQKGRsLzXZDZYJ8hoYGCUzDrxib0J
	 t48S5RHk6xbMfkFBg8rvhrvykc97p6DrpWh25KviQdmDzcHCFQ7cyX5MnkBXcWkzd7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=XnXFesgj;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5956D606A331;
	Tue,  3 Nov 2026 00:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5956D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=XnXFesgj
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 533e14b1c;
	Tue, 3 Nov 2026 08:45:55 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	stable@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mailbox: bcm-pdc: Fix potential use-after-free during removal
Date: Tue,  3 Nov 2026 08:45:52 +0800
Message-ID: <20261103-cmc-mailbox-bcm-2-dadd0dfe34@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103-cmc-mailbox-bcm-0-a4f6f65a1e@mail.sdu.edu.cn>
References: <20261103-cmc-mailbox-bcm-0-a4f6f65a1e@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa19edeab7203a1kunm5eb3672111823b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSUxNVkhISUNNQhpPT09JGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=XnXFesgjbekP9h/kwyKIO5V3/Gfz4XbD4+/D+1pXdC7vySl8CblErpReNYvz0s5ioratwzqFWGOCaNlqGCjmCXerPIz6ClfUW51+FAxTgTrUYMwLh3HjjWXqor/KLI3Cd7ZTI12hFR672/EpBsMmB1mvtDZ5otRSHTLDgsOMErI=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=Xuo+XnZ4B0PNX5shIuREYCE9/GcSOvns3/xyNK1aQJ0=;
	h=date:mime-version:subject:message-id:from;

The remove callback destroys the DMA pools before device-managed
controller removal shuts down requested channels. The shutdown callback
then passes the destroyed ring pool to dma_pool_free().

Unregister the controller explicitly before destroying the pools.

This issue was found by our static analysis tool under development.

Fixes: 6267ee6afae0 ("mailbox: bcm-pdc: Use device-managed registration API")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested the affected object for arm64 with LLVM (W=1).
No hardware or fault-injection testing was performed.

 drivers/mailbox/bcm-pdc-mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 6fcc4002ad4f..fd30b9b06881 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -1450,7 +1450,7 @@ static int pdc_mb_init(struct pdc_state *pdcs)
 		mbc->chans[chan_index].con_priv = pdcs;
 
 	/* Register mailbox controller */
-	err = devm_mbox_controller_register(dev, mbc);
+	err = mbox_controller_register(mbc);
 	if (err) {
 		dev_crit(dev,
 			 "Failed to register PDC mailbox controller. Error %d.",
@@ -1608,6 +1608,7 @@ static void pdc_remove(struct platform_device *pdev)
 	cancel_work_sync(&pdcs->rx_work);
 
 	pdc_hw_disable(pdcs);
+	mbox_controller_unregister(&pdcs->mbc);
 
 	dma_pool_destroy(pdcs->rx_buf_pool);
 	dma_pool_destroy(pdcs->ring_pool);
-- 
2.43.0

