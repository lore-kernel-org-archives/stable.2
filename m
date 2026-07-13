Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B65352010
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965816; cv=none; b=rutKZvpNshvl7kUshl+jGRhb5EVS3rczJecEBLadMmD9b323emSbfVIDOr2mARxm1kCzEKRulzv2z8Bax4DsKyKCtSFPQI+1r3xxlFl2wJpYS9ErWJHaKQh4hM1C9c0vYGp5qyqVCaz6kJXLILqfafI4HsMl+lwmJ13AiRo6crI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965816; c=relaxed/simple;
	bh=nvgz8S/G4xOdrauZEYeH2t5Dk7LmnQ1Ehp6VPAXOSwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSCTAceKVntMp3BrZ/7cORGUe5n2q0q+mO8mR4E3WYdFOTEfo7uNe9RxgAV0XP/fNYiiEKHegCD/ear7TR+qgQsdB6WKV3yTsnwrZk+nsQwEfOWZif4Nf9V/h85K1gIRs/v8lGUPMXUBNKdiec1E8uSjEIjyJhP7AYXs92+7EkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+hoBfM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+hoBfM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933831F00A3E;
	Mon, 13 Jul 2026 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783965811;
	bh=vSteEKYmc5eOugLiHW+eDmg4kcFWdCcEVkfvQGQ+QvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m+hoBfM1L2Kg5h3zJtfRjT5eDW/EmMoEZRl/GJvDpaMcMDDlM0bc0wFiyLy09vxp5
	 7r2m8HITVaNAhHFF8K3ZMtgdMr38K4aouFWGvJN1rH+G7Tw1cVX57GIUJ9RwZ6Ky/+
	 UqkBS1jr8CaBpGdkO7I1osX4ZAex3aAmPPpG6LPK3ZwY2lQGd5rO0zh6T3mZh80BC0
	 rpt3s5hyWPq1ZiK7ryWCWKghrBjvklczqG+FIyjCM3iDTp53b5AuBF0nZPV7kkKfFK
	 J9euRFf2PHp7aCsT//qm8ILeg9b8Agn0gZQk7btUaTVB11NUh0xmVRZ3OYgqE20NNx
	 gf08dOvDo5Eew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ
Date: Mon, 13 Jul 2026 14:03:29 -0400
Message-ID: <20260713180329.1923595-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071352-yanking-dealer-b803@gregkh>
References: <2026071352-yanking-dealer-b803@gregkh>
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

