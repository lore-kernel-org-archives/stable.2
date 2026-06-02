Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC593CB2D5;
	Tue,  2 Jun 2026 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392176; cv=none; b=qN9MFO4OLgnaxwJfIkM943n72tj7K2+jiaK5CpWO+yo/9FN2Py6ZKhCXfYX4QNqCHKRZyarX1Lts9/yIefTz30hZhTiXnDDj1RAE5u4EbOVfgsCqf9W8CM3JTQ1ohRFhmN+cu2FYsIwr8HX+0BTAN42Kcfr3CMF8UcWHsT1Cn4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392176; c=relaxed/simple;
	bh=f7hLJmXwtvM6Tx6T8GUm9IwslgZRI60axDYXHE0vU8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZAkhkVjHI+ponkxGsRAlgLDcuvNzq926XQi1JW2o+ZnzmxsyUXA0eAhhL57OqKYl8fx32HIW1MM9uSY1WTEcO6x0w5Twg/yZCPd7ykayHkk5BXdz+lp1v7pHhHwH82pA7s7VkecHbMFtF8z3b+F9Vvr7vACg3icbjY7EvsMCtHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=besnalRX; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="besnalRX"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40be0f4eb;
	Tue, 2 Jun 2026 17:17:39 +0800 (GMT+08:00)
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
Subject: [PATCH 1/2] iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ
Date: Tue,  2 Jun 2026 17:17:26 +0800
Message-Id: <20260602091727.2406720-2-runyu.xiao@seu.edu.cn>
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
X-HM-Tid: 0a9e879fd4c303a1kunm7cf82aeb184127
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTRgdVk1MHktDSUNKHxpMTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=besnalRXmebGXA435kWNDxcL23uncpbOfCxDsHuaxYmbMi9JY/2QBL6INdgP0jyXNjCtqyBkjza8O8brBo7MMO3z+U1Trc7HQCZkKMWNvR718OAnCO1+oepSyhDyQBiQ2HTQAYdMoO0akGKuPQN84Iw1vJx99mZwN9DgEy48vLk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=2TIJWJd27ymwSuCVs9p+Cqrpo7B5FqOVmlAdS/REayY=;
	h=date:mime-version:subject:message-id:from;

devm_adis_probe_trigger() registers iio_trigger_generic_data_rdy_poll()
through devm_request_irq() on the non-FIFO path, but it does not add
IRQF_NO_THREAD to the IRQ flags.

When the kernel is booted with forced IRQ threading, the parent IRQ can
otherwise be threaded by the IRQ core and the subsequent IIO trigger
child IRQ is then dispatched from irq/... thread context instead of
hardirq context. Because iio_trigger_generic_data_rdy_poll()
immediately drives iio_trigger_poll(), this violates the hardirq-only
IIO trigger helper contract and can push downstream trigger consumers
through the wrong execution context.

Add IRQF_NO_THREAD on top of the existing adis->irq_flag value for the
non-FIFO request_irq() path, while preserving the current trigger
polarity and IRQF_NO_AUTOEN behavior.

Build-tested by compiling adis_trigger.o.

No ADIS hardware was available for end-to-end runtime testing on this
submission branch.

Fixes: fec86c6b8369 ("iio: imu: adis: Add Managed device functions")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/iio/imu/adis_trigger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index d76e13cbac68..ae1506ca85fd 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -94,7 +94,7 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	else
 		ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
 				       &iio_trigger_generic_data_rdy_poll,
-				       adis->irq_flag,
+				       adis->irq_flag | IRQF_NO_THREAD,
 				       indio_dev->name,
 				       adis->trig);
 	if (ret)
@@ -103,4 +103,4 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	return devm_iio_trigger_register(&adis->spi->dev, adis->trig);
 }
 EXPORT_SYMBOL_NS_GPL(devm_adis_probe_trigger, "IIO_ADISLIB");
-- 
2.34.1
