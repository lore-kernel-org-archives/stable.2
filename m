Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8E27FD4F;
	Thu,  4 Jun 2026 01:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537715; cv=none; b=dqR0UPB//v9X3LPvWdWdnuZ0icZL2nxl6oBMuzMcXs4dZBLPMP9pX4oT5pQsFn3ACM/oWStZs90SpU3k1PXSSKY1gY6muW5k4rXMzATrKGN+Pm8wJDfHlVPnHWpG1k0Yuf/pZVIYwEvJx9LbSqxLNUNVEm1xb4cDLSLsXOhu4Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537715; c=relaxed/simple;
	bh=lJdrbZMs5a7H/64iWN8BT2PwUMMVs2CCNXwZzReueH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fib39mOyZBLtXAQpzCm7tiLVyt6vtnXLrdPSm1VZCWR26nYeSc8eWslkUuBRu9danAIPUH/K63ikawqp5IT/1BWNZFq38S+tTjqeH6Vy8BCJTlOqodTFIAz2RoKtu4EgjYl3STbJGIHGXd/hg/Kke6yPmWQlbN+q3GIaqTEevQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=OT4eRrqn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="OT4eRrqn"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40fe0c73c;
	Thu, 4 Jun 2026 09:43:21 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	dlechner@baylibre.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] iio: imu: bmi160: add IRQF_NO_THREAD to data-ready trigger IRQ
Date: Thu,  4 Jun 2026 09:42:47 +0800
Message-Id: <20260604014247.124724-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604014247.124724-1-runyu.xiao@seu.edu.cn>
References: <20260604014247.124724-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e904c9f8003a1kunme7d1e7a121c91
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHR4eVkkfSkxJTUxCT0JIQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	5MTlVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=OT4eRrqnN7ytiEAduZEH8abv7Gdh8dqo+ZBAnkjiSskwRTk0CSK032RG9h4YHZ9xeik3hox875YI+7zhid4dAmqh9ednGSjHYvxiXBULM0NEqQI94NTXDpSG7vQ0YWktVAWshHJ421UYI47H/m8lS0O38hXR53UhnpEJLvexbzE=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=k07phwEx4r7qVwzFak4xbHes8w4by+sGjuG81FegXS4=;
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

Fixes: 895bf81e6bbf ("iio:bmi160: add drdy interrupt support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v2:
- move build/runtime validation notes to the cover letter

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
