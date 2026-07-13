Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AF34CFCA
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965470; cv=none; b=U/BUMvIUB5yy025B4eRLr1RY1a+MwFUD+oFoBduu26PToWwFZgeYaBZuKyRgg5nNDfXX/ccsR7rslwqLQuE2wEl/g/5sMBgPXFJgjMwMKUI6qAAmRt/7V9/WenFKKma7KlK+hgbNER3I5hAKj/eBxcnpjsUsSs/dCoHf0asjUAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965470; c=relaxed/simple;
	bh=nvgz8S/G4xOdrauZEYeH2t5Dk7LmnQ1Ehp6VPAXOSwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RePBAve48Lj8q9B6tnv/EdN9jaAqMl4aNCQEBY7qJmJdP5CRVWt+CIJ4lXuu2eaGxokxoIjNW3GhKtvua26ZKNR8U9fUqkCB1PWnA3dOfqaXtkDywp2OkFztkYGYgYdMrD8dCSZWvlqesxiQ1tA8JQqbkQ5VJrv8smAb/VcHTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyVvTjrj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyVvTjrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1B31F000E9;
	Mon, 13 Jul 2026 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783965468;
	bh=vSteEKYmc5eOugLiHW+eDmg4kcFWdCcEVkfvQGQ+QvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HyVvTjrjlFiQUPhuRDzuLPmCzkcgfs7N+I3SpMPxkJaIOfMlq4/VWNM/VY+T4+IfC
	 1wPqEDIdqT5stN7k2ph7W4bYl61Yc3EBseybVwXIFzPcH2Bv+2A/RNCLU+XBv25Adh
	 AOQ2ozAuZujoI+6F6mVMfNaqwcINs7XR8c8yaS79ydbKVvag5y2KnyhXnjDQJzGsgo
	 6FFMFkD82PhcZbYuomVf0HD8VFtIlHs1cUb18PKcUUwnmcLzmnPLnuu4GME030YYY7
	 MAP2OJeQchCjtzx0cFS0f79lsSTK7GFKAY8tPoAR2kcjRQOvuUVgtevSozDyL0h9Z1
	 G2Sr0qXwCNQEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ
Date: Mon, 13 Jul 2026 13:57:46 -0400
Message-ID: <20260713175746.1907755-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071351-smashup-frighten-8514@gregkh>
References: <2026071351-smashup-frighten-8514@gregkh>
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
index f890bf842db86b..7e18b31f9d7770 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -79,7 +79,7 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 
 	ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
 			       &iio_trigger_generic_data_rdy_poll,
-			       adis->irq_flag,
+			       adis->irq_flag | IRQF_NO_THREAD,
 			       indio_dev->name,
 			       adis->trig);
 	if (ret)
-- 
2.53.0

