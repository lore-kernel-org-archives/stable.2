Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED4390239;
	Wed,  2 Sep 2026 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358185; cv=none; b=s+qFpmzjh6FwhS/LS961IQ5dQemFJUgqSv+6MVUXqPn2Ep2qHStvlD+7yRdKrfjEpxA7d/1id7gRNwdNX7/nJ+dmivtzLHM7/+4RaUKPN7zIHHswM9MtpSIZ4WmTLSuNtUrwLuZfusMAFh4vlnPBc8EDFElhweJ61lEBAYLbNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358185; c=relaxed/simple;
	bh=hwznEtLz9at2KrCUuawHk7lHioFcA3JjBccZlI0G948=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RVR1f0oEnxYAUMsVXY6BWnnUwMz49Zc7NAPCTWbkUnRiU/xrdw8QeIttjSZhBJ+Ech7Z9sKLpi9IEZNcXOcM0FXFz+m1M9NbJPzJdKYjeoaaBUIVJmyRuufpw/RTnoibHW6YpyRLF6BWJSVzWRwdj2/YSTci9EdVaajtzT/JwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=STnxJlrY; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="STnxJlrY"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c47d4e66;
	Wed, 2 Sep 2026 22:09:34 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] mmc: sh_mmcif: initialize IRQ-thread mutex before requesting interrupt
Date: Wed,  2 Sep 2026 22:09:26 +0800
Message-Id: <20260902140926.3576781-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06274269103a1kunmc427f4561ad27c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0wfVh8aH08fSh0ZQ0JDT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=STnxJlrYaprVQet6E8MpyhvyWvOQRi7r7aEZY5pMAw1sP1Raw/frzxfzu5UWKA6sBE+zY8qiFR2ev/Rvu1TqhN9g9arf6c9yb4kFVn9hPINnTDZN3J+NyqcGG3EggICdQTLS+cuuxbiUDVC20baLnHOxX0c/CfVa0yHphH1xAWM=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=gyRX29A6v4W3vpaMus1y6buRgYO80vg2lKvJYVXDFcE=;
	h=date:mime-version:subject:message-id:from;

The threaded IRQ handler can run before devm_request_threaded_irq()
returns, but thread_lock was initialized afterwards. Initialize it before
requesting either interrupt.

Fixes: 8047310ee984 ("mmc: sh_mmcif: fix a race, causing an Oops on SMP")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/mmc/host/sh_mmcif.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 7706d01b1..8bd9cdeda 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1461,6 +1461,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	host->pd = pdev;
 
 	spin_lock_init(&host->lock);
+	mutex_init(&host->thread_lock);
 
 	mmc->ops = &sh_mmcif_ops;
 	sh_mmcif_init_ocr(host);
@@ -1515,8 +1516,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 			goto err_clk;
 	}
 
-	mutex_init(&host->thread_lock);
-
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
 		goto err_clk;
-- 
2.34.1

