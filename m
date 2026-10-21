Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584857;
	b=UnEj42w31pdAJAamjT3/9xgKoNIsXmObETxljJ8DILJ6AWiINYLxOopsim9egbkmEZo8
	 ifWlqnCwTHp12k+chJhjpDWmqBTx2GEhBiRmXRIASiBQwDnw26Kenx7xbx3nxw5MHMP3b
	 bDAt+ukCGuYiJqBWHntaxkHrAXehqnB5afNpifWj2tXHqPVtcRvN8s+PpEB6MXXvESH1z
	 2djsnpdaVSO0Bh4WBWhRMVxgrgGFquIdY+g85bdOHz9PF+5J8DmRRmRJgH1OWLDhrJBJ+
	 m+b2uLTrbzITxmbYPxLDj/HiLybHSRBzKKUwOPU31QSbjMtztDB63hu0XalJaD47j6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584857;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fXZbKyN78tMI2DxWZqsQvbob4+WPs6FwF5SfMqI+W40=;
	b=GVOppqANExr7H4GB8YXGWJP92Vep3LtkINFr9fGLI/yCu4vb9sQc4238VYyhfZj064Lv
	 d1XoYQNOqPKIx81NSkGu7Et2cTv8ejNn4HFncdFfiy16iRa4DEGg4gRIbaFX4CGupMtDa
	 vqTV5uMAhkxg/0APPIbhQqzaoZscg2+q350Cz3zQJXlB+ov12pC2dWpqqoqOq9A6LQUM1
	 NKaRCeQuLNQmnBSryeTBbIB+iyE2vxpx/kLXAEpvtGZr1JJMIhZSlGI706zGG4sNVS8zW
	 oEcTEWA13TtmVbWulD6sFtEebVi82Yo8Tc9H34PoZA6Qy0R+3mQB+xjDgpBwp2xStdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9vUtFmi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1B606A32F;
	Wed, 21 Oct 2026 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9vUtFmi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282581F000C4;
	Wed, 21 Oct 2026 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584856;
	bh=fXZbKyN78tMI2DxWZqsQvbob4+WPs6FwF5SfMqI+W40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B9vUtFmiScF/Vq8judAn34biazhbZceLYVKXeC9pN0d7LsjojcFu4TR2zLBqnS5xB
	 Bjqfzo1cOZH/EqIvP/rN5F1a1zqYepTUnws7jxdCO64FCudsdWBtlZvLxg5xa5qOE3
	 cJBgRr/tjNjqOzpojA9XCNrXRneAnwG9UTJLIzwwuOTQdYM1rCcP8ygp19o5dggW2m
	 jzru71wRMYFRRggdV8zE2gJyBUh3mNynq0zVe7WPiSOX3MmBi5sP8XgbKKFtL5mpHC
	 ggUx7kwMv8b6TO1hRNoeOwjxDPAy3u9UUlZ+JSsoRFlVASfFHNTEmEZ35/kyj1EU8Y
	 Q0d4S8IxB4VEw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/28] mfd: ls2kbmc: Cancel reset work on teardown via devm_work_autocancel()
Date: Wed, 21 Oct 2026 12:09:25 +0000
Message-ID: <20261021121245.3111563-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
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

ls2k_bmc_init() initialises bmc_reset_work with INIT_WORK() and
immediately requests the PCIe and GPIO interrupts via devm_request_irq().
If an interrupt fires and schedules bmc_reset_work before a subsequent
step in ls2k_bmc_probe() fails, or when the device is unbound, devres
frees ddata whilst bmc_reset_work remains queued, leading to a
use-after-free in ls2k_bmc_events_fn().

Initialise bmc_reset_work with devm_work_autocancel() before requesting
the interrupts so that devres cancels any pending work after the
interrupts are freed and before ddata is released.

Fixes: d952bba3fbb5 ("mfd: ls2kbmc: Add Loongson-2K BMC reset function support")
Closes: https://sashiko.dev/#/bug/linux-3089d131-9fcf-4753-b183-eebe0a6e020e
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/ls2k-bmc-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
index 23c774a09842..e245bdee8226 100644
--- a/drivers/mfd/ls2k-bmc-core.c
+++ b/drivers/mfd/ls2k-bmc-core.c
@@ -12,6 +12,7 @@
 #include <linux/aperture.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/iopoll.h>
@@ -376,7 +377,9 @@ static int ls2k_bmc_init(struct ls2k_bmc_ddata *ddata)
 
 	ls2k_bmc_save_pci_data(pdev, ddata);
 
-	INIT_WORK(&ddata->bmc_reset_work, ls2k_bmc_events_fn);
+	ret = devm_work_autocancel(ddata->dev, &ddata->bmc_reset_work, ls2k_bmc_events_fn);
+	if (ret)
+		return ret;
 
 	ret = devm_request_irq(&pdev->dev, pdev->irq, ls2k_bmc_interrupt,
 			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc pcie", ddata);
-- 
2.56.0.218.g1ec904b173-goog

