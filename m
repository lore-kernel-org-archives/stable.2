Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666758;
	b=MNHZae1LJuFvphBYgrwguEQ2qZSMy58dfusnb8XEtTInyifAaFxg20/IU/AKKA2h6cOz
	 n3iugAzel/RZmSYBCmlBJ4leBhidic4agjfK4GD4EINMRmoZwUoOBSVIGLVbWOCLzWYLK
	 UuNZckTs0/UtxAmNBehFFOfIWUeAuAbCInojewY4eO4HZkRdXTSo0i69p/Rzop/yNCoGD
	 /CUCz5+tckmqm6P031CtWJDyDPXupHCnuipKu+kdvJMa4fbGKl4O/iDrOvdC463wBisqc
	 nA92rIyM10UvGfo2L/93beCkgHBKbaXUwWI2bvpIzVOZwJrBf6Um910nU7XVZ2CSbXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666758;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=Qh08jk/PJhsSv4Yt2hotCKM2HZnXbfdYfd+51/xCAvs=;
	b=WyzaySwBWF6WqKDyHAv9pXrbwhOc/i2kgtD1YOp7LO+qKePhQfEbRRKHMnCcuMJ/sQd0
	 gl2GX/UduWmPoC6Z9HRsRvLHeIKj6QF7OoEOFjTHsLBsu0Q8g/Q7c6E131hHm4LMtmT50
	 VWItWyY8FT8KG/tJh+itaRFEEogCyFnCso8YJR8qInMSfrs7tSVn6EcKI3qwzYyOuyK50
	 mdr32eYeiWxqGg5UVhFuck4zy5zpoSu4tmSoyRko735GTAWA9UpriybkFY1VHAmHEac+Z
	 edvTaL0IX1u1v+s3E93yJxsSbWEqBbGv5IOCXqxglVjHVVwKFz3cR/8a3davTVFd+Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Uriw+5+K;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3B606A33B;
	Tue,  3 Nov 2026 00:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CB3B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Uriw+5+K
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 533e14b19;
	Tue, 3 Nov 2026 08:45:54 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	stable@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>,
	Scott Branden <scott.branden@broadcom.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mailbox: bcm-flexrm: Fix potential use-after-free during removal
Date: Tue,  3 Nov 2026 08:45:51 +0800
Message-ID: <20261103-cmc-mailbox-bcm-1-a00b3f7aa9@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa19edea78f03a1kunm5eb36721118238
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTxhOVk1NGB5LHU5MSEIfSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=Uriw+5+Kip9OIObdrOG4SA6WAAvDpO5AF0/hxg6O2vVWPN0IlIks4LKomoX99vfcCailVUVCrQ2lWFhqbS0vNBN5kjO/Ay/KBa3ZZMPDc/qRDUuwyJEPKOWFRTvEriVOCOHUiu0q929PmUeZKrCmMHxoCgTBcICQlyHDalvmj4E=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=Qh08jk/PJhsSv4Yt2hotCKM2HZnXbfdYfd+51/xCAvs=;
	h=date:mime-version:subject:message-id:from;

Device-managed controller removal runs after the remove callback has
destroyed the DMA pools and MSI mappings. Shutting down a requested
channel then frees its rings through the destroyed pools.

Unregister the controller explicitly before releasing these resources.

This issue was found by our static analysis tool under development.

Fixes: 0cafc12ab9cc ("mailbox: bcm-flexrm: Use device-managed registration API")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested the affected object for arm64 with LLVM (W=1).
No hardware or fault-injection testing was performed.

 drivers/mailbox/bcm-flexrm-mailbox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 04c47eadf950..e14f49f534d2 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1619,7 +1619,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 		mbox->controller.chans[index].con_priv = &mbox->rings[index];
 
 	/* Register mailbox controller */
-	ret = devm_mbox_controller_register(dev, &mbox->controller);
+	ret = mbox_controller_register(&mbox->controller);
 	if (ret)
 		goto fail_free_debugfs_root;
 
@@ -1644,6 +1644,8 @@ static void flexrm_mbox_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct flexrm_mbox *mbox = platform_get_drvdata(pdev);
 
+	mbox_controller_unregister(&mbox->controller);
+
 	debugfs_remove_recursive(mbox->root);
 
 	platform_device_msi_free_irqs_all(dev);
-- 
2.43.0

