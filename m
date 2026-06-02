Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512CB2DA75B;
	Tue,  2 Jun 2026 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392175; cv=none; b=Pkmv1gyyGN2J8yFl4rj5TKiPFzORwS8Gav59NTWr6fL7rZVP3QMTsbKlfJ6KYyspqTZk9BkRhVJ1aIbFaIkNWXNt24sPFRW+zawWfbhVsba1OyRXky+jnlsMI2KJZYj2+OXzyhoL1iV8IatSsUyuJsplQCORkJYkg3y0ZJAuZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392175; c=relaxed/simple;
	bh=T4te/s/TVYN+Li7ypIjsKFoukBb0BWzcajcyCCX/iqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uRy5TAK6BXXRMjG9D7LDVIXBqAhVHjfLAVI+XIxknxAdCGqFzTqQs57Jq04jYBG7dxW8zlR+na1W34+ByeN7za9v3d/G7jXdxYeLwq9okF/riAyH0maP6zGSbbPYBMOwg6rs6BT/cdlYHZBtWT8OoPaXdG+7ixbda/7N9RBkVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=U8zUTrXe; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="U8zUTrXe"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40be0f4ec;
	Tue, 2 Jun 2026 17:17:40 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	benato.denis96@gmail.com,
	martin@martingkelly.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH 2/2] iio: imu: bmi160: add IRQF_NO_THREAD to data-ready trigger IRQ
Date: Tue,  2 Jun 2026 17:17:27 +0800
Message-Id: <20260602091727.2406720-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602091727.2406720-1-runyu.xiao@seu.edu.cn>
References: <20260602091727.2406720-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e879fda9c03a1kunm7cf82aeb184128
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHktCVh1KHR9OTRhMHUpCTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=U8zUTrXetx3WdmpplA4pCoz8T1OHbYOUs5Zn7g6vNoQD7txW4nRnl07lGwO5Z4FDM2NeEMl5Y6+egTvA3S3wuPLKnmOCuClSzdbwWqzRC7fa1Ib/FkVrX4ucfQeU0MbGv9EcVD7hs97xviyp631nonG8Qwi/s8yAbv1wVO3KJZQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=LDcoBseSY6+s+YJ9jP0kOTfbtBes05pw9hFuAzU0nGs=;
	h=date:mime-version:subject:message-id:from;

bmi160_probe_trigger() registers iio_trigger_generic_data_rdy_poll()
through devm_request_irq(), but it passes only irq_type and does not add
IRQF_NO_THREAD.

When the kernel is booted with forced IRQ threading, the parent IRQ can
otherwise be threaded by the IRQ core and the subsequent IIO trigger
child IRQ is dispatched from irq/... thread context instead of hardirq
context. Because the handler immediately pushes the event into
iio_trigger_poll(), this violates the hardirq-only IIO trigger helper
contract and can drive downstream trigger consumers through the wrong
execution context.

Add IRQF_NO_THREAD on top of irq_type when registering the BMI160 data-
ready trigger handler.

Build-tested by compiling bmi160_core.o.

No BMI160 hardware was available for end-to-end runtime testing on this
submission branch.

Fixes: 895bf81e6bbf ("iio:bmi160: add drdy interrupt support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 5f47708b4c5d..caee8dfd101e 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -793,7 +793,8 @@ int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
 
 	ret = devm_request_irq(&indio_dev->dev, irq,
 			       &iio_trigger_generic_data_rdy_poll,
-			       irq_type, "bmi160", data->trig);
+			       irq_type | IRQF_NO_THREAD,
+			       "bmi160", data->trig);
 	if (ret)
 		return ret;
 
-- 
2.34.1
