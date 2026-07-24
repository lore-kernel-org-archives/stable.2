Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E336B917;
	Fri, 24 Jul 2026 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870846; cv=none; b=CIiI8GyqJNs+aavnOTMzYqarv0UIFDDmynNEVtnrD4wPoYgzRsaU5X+YRdlY0P6Wc62jgZaL6bXsHhKP2JCt8vUdR+Jv9doGXU63K/3gzzKRICLlX4d4sa5TKnrZa1ku3GpTCzfMDOVtettJ3cHusXu0qe3Hn9Eqvz4HIqbZq1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870846; c=relaxed/simple;
	bh=LiVNmeQsY8IEYZ/VnaLr3j82YaeAMosyppkOqeNoxSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJVnh+qgUDwe5pijid+gycZ6ZBVAi+KyPw3jrtLu3j2BmdTrDhGwD3xIO6kzgvbryCjR40nuUkgOAZxGIz9+3qLCe2chOZbpeXQGr6HTCgj1oT7yzTTih9jFFmlZr/PdQ0qLfc1naU8NOop0Oxe9sHT/nhDLSlljLd1t78XJrtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=BwKYMlCF; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="BwKYMlCF"
Received: from LAPTOP-99KJFSET (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47691a19d;
	Fri, 24 Jul 2026 13:27:13 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: 3chas3@gmail.com,
	stable@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	getshell@seu.edu.cn
Subject: [RFC PATCH 6.6.y] atm: he: kill tasklet before releasing queues
Date: Fri, 24 Jul 2026 13:27:10 +0800
Message-ID: <20260724052710.1126-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f92978a2b03a1kunmb4995d0624371
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSRpKVk5PS0sdHkgfTk1PHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=BwKYMlCFyapMBd/y/zMpf+VVAatWbBOar7c3ddvTp17++dRXO/2Bkr206+cz/ONYURDAvZG80/g0h2aZeYcgZh2hSrTAZ8gmYCkvTnJvuGpKx04qTyLNdQXps6hUVX5RhFhrr/lbqBWPpAlY+AiH7LlKpc40YE6lmqL45ZFfvAk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=5Mfo47OpTKg7riRmU9vv2cyhM4lOeEgh7UycReXtxWc=;
	h=date:mime-version:subject:message-id:from;

The interrupt handler schedules a tasklet which accesses the device queues.
tasklet_disable() waits for a running instance, but leaves a scheduled
instance pending while he_stop() releases those queues and the device.

After masking device interrupts, unregister the IRQ so the handler can no
longer schedule the tasklet, then kill the tasklet before releasing any of
its data.

The affected driver was removed upstream by commit 6deb53595092 ("net:
remove unused ATM protocols and legacy ATM device drivers").  This change
is intended for maintained stable kernels which still carry the driver.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/atm/he.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index 92a041d..6b2c795 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -1536,9 +1536,13 @@ he_stop(struct he_dev *he_dev)
 		pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0);
 		gen_cntl_0 &= ~(INT_PROC_ENBL | INIT_ENB);
 		pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0);
+	}
 
-		tasklet_disable(&he_dev->tasklet);
+	if (he_dev->irq)
+		free_irq(he_dev->irq, he_dev);
+	tasklet_kill(&he_dev->tasklet);
 
+	if (he_dev->membase) {
 		/* disable recv and transmit */
 
 		reg = he_readl_mbox(he_dev, CS_ERCTL0);
@@ -1555,9 +1559,6 @@ he_stop(struct he_dev *he_dev)
 		he_dev->atm_dev->phy->stop(he_dev->atm_dev);
 #endif /* CONFIG_ATM_HE_USE_SUNI */
 
-	if (he_dev->irq)
-		free_irq(he_dev->irq, he_dev);
-
 	if (he_dev->irq_base)
 		dma_free_coherent(&he_dev->pci_dev->dev, (CONFIG_IRQ_SIZE + 1)
 				  * sizeof(struct he_irq), he_dev->irq_base, he_dev->irq_phys);
-- 
2.50.1.windows.1

