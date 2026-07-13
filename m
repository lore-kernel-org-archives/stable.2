Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5379D335BB4
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967616; cv=none; b=s5T/VmAh91vv+i9ad3DCxet/ht+PGz0PASYB2jM+UPExkpS9rbc+w1zGWtQoCF6WOO2toygbgOB2Z5mymK+YSBGXQbtsw6pOdJVJ/zJjXv+0OgsZUqRuDFeb21/YvAqKcJdWOmLTeSEo0AnWTPn85m+LEWvMaTEYOK1vadLOaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967616; c=relaxed/simple;
	bh=NmVZTOFq7i7MSKXWLG2T7agLlAhMU4/H04Ysk2Z2MII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+kanxmpDMgtocFxX4AUz6zn62s+9413OlzSGyVgKKQrYfABZ+fo7BPr/0Q1jk94lTlM1KGmkE65yQKEATZWqZPybFkz9cMzH3KYsoA0kvFUPUBBouGLaZRuUOW227C/Sq9+V6UWa9DxyZOo44FJdPmD2AbGa65D3m4/lJU/VF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwAoS7Ar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwAoS7Ar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DB71F000E9;
	Mon, 13 Jul 2026 18:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783967615;
	bh=Sf6b9nGxR+QDtlZwXLDsoYJ2GLoi3vmiWQHB5CoOCDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kwAoS7ArJ2TqG9/B/vFNl+mWXnfkQpwdAoz/2Rs1d7FjBQ0Nmj20gDwKV3nnKan3G
	 P9AHL9jI/XaBSzzvKamVhZ783Ox8J/eXHcM1TSaxumU4fGXmhpOr93TO2Wm8f2lMq7
	 VQPXZai9qgwMPyINS44O8ihrcqrF6X13drijrsfc7xNbCFIjObAhhctHDAWPRnsyyq
	 n5DyH1yYPSUA4o+b1ePx7IXST6qFQYZsiyEG7AHceQ8ah0hMZRE9pxVNbYusVl+Iew
	 XwRD5T0pfj/ENeXf3Ub61p7i3zUAyXMM/iU2lFdNxIx3YeW6I3s8Mjn6UQQO1NmQvo
	 H9EP1t+/PlojA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ
Date: Mon, 13 Jul 2026 14:33:32 -0400
Message-ID: <20260713183332.1950471-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071353-jackpot-overcrowd-9420@gregkh>
References: <2026071353-jackpot-overcrowd-9420@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 6e1b9bff1202da55c464e36bd34a2b6863d7fe30 ]

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

Fixes: fec86c6b8369 ("iio: imu: adis: Add Managed device functions")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/adis_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index 80adfa58e50cb3..985bb7d6b8452a 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -84,7 +84,7 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 
 	ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
 			       &iio_trigger_generic_data_rdy_poll,
-			       adis->irq_flag,
+			       adis->irq_flag | IRQF_NO_THREAD,
 			       indio_dev->name,
 			       adis->trig);
 	if (ret)
-- 
2.53.0

