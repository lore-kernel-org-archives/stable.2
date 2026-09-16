Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D33DB960;
	Wed, 16 Sep 2026 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551078; cv=none; b=EmUC4eCL1rvjWHkMZaEGgCZpohYZ0iSUnwEt/+b+KacJfX1x3OS7uOKo027KJL3nQPx2zLsWxF5REy9TMY3a6aSZfMGprNlbrjoawZL3zzUmOFj6/9OeY4DJDknLZ+OwwWZjQcVztxLtYSyFtJgMM/uw5C+0P/bSGtEIn9nf9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551078; c=relaxed/simple;
	bh=D4/yxHDCi9fKK4WTqUyWO6Tvmy7Pl2foyKhacLVNWvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ssnINvFmQJkacO97pwVtNmZBcC1Vi2jELh7kJGv7FePY3qdHM7wVZ9qv5dXkkp8RmdCBwODmkvL0XMtV+jBk+eaS7u7hT4GRot3DVHSc2UhiPqx4IJWWYG0rjN0ideXTFc9tnF4qlNd/XwHh6O3Yu1iEH9a9xCvrx/4B7TVm1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnKjjUYapqg13gBw--.41217S2;
	Wed, 16 Sep 2026 17:31:01 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Frank.Li@kernel.org
Cc: andy.shevchenko@gmail.com,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	okaya@kernel.org,
	vkoul@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: qcom_hidma: Fix runtime PM leak in hidma_issue_task()
Date: Wed, 16 Sep 2026 09:30:32 +0000
Message-Id: <20260916093032.2003397-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnKjjUYapqg13gBw--.41217S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWxtrW7JF1DJw4UJrWfuFg_yoW8Gw1Up3
	9IqFWFkr90gw1293Wjkw4qqF90939xGFW3KrykK34kurs5XFy2g348ArWjqF10yrWrAanF
	k3W7t3y3uF1xAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUrrWFUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcMA2qqPpSX9QAAsG

hidma_issue_task() bumps the device usage counter with
pm_runtime_get_sync() without checking the return value. The counter
is incremented even when the resume fails, e.g. when runtime PM has
been disabled or the device is suspending, and nothing drops it in
that case, so each failure leaves the device with an elevated usage
count and it can no longer runtime suspend.

Bail out and drop the leaked increment with pm_runtime_put_noidle()
when the resume fails, and only start the transfer when the device is
actually resumed. The counter for a successful resume is still
dropped by hidma_callback() as before.

Fixes: 67a2003e0607 ("dmaengine: add Qualcomm Technologies HIDMA channel driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/dma/qcom/hidma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 5a8dca8db5ce..03a73dc9b066 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -220,7 +220,10 @@ static void hidma_issue_task(struct tasklet_struct *t)
 {
 	struct hidma_dev *dmadev = from_tasklet(dmadev, t, task);
 
-	pm_runtime_get_sync(dmadev->ddev.dev);
+	if (pm_runtime_get_sync(dmadev->ddev.dev) < 0) {
+		pm_runtime_put_noidle(dmadev->ddev.dev);
+		return;
+	}
 	hidma_ll_start(dmadev->lldev);
 }
 
-- 
2.34.1

