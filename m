Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097391;
	b=e7dJ3vB8bAIRkMUj3tfMhwcP+pSXaGmFpytcPcEgTFIaCFXhwVeN673HMGrR80syx4fW
	 4c1ZqlOFTZ4Rlxn+a/YUe1Dxdsv+pVBGrHaXmnrw63rmPBVQRrChqc+3/yuSh6sTz0OVc
	 qlQRHYJIXhMr2UEui4N+2geYTwHVour56ExtuJETDH71gIrapRY1+qTFqqcmTPMrFHIUX
	 SYLnagilOJ6fqdb7QvvQfI5sH2bfpVfBQImZgbR5VFI0Kg7m+Pi9nN9Q481kVQG3jl9hM
	 P8Mh46F8KAkvVZ20fa24w2VuQ7q3uyHy8/c1lKqKngVImLWK7fHamPW7EUYP2qmETjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097391;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XK28uNsYnR2yFi3mVI+5oVuaCmk2yFzJ0DXrrVLzrR8=;
	b=w7Pvc6lKhQHvS1DcBYDrrUkLqv/jeX9pf1M7Fcg19r+CgpauuZKBvEO9YmT3EkrnGX+w
	 473i5APcf5bGV/w4xTLZfUc/K9eT43gYDfqFXoJU+X21vBrW3J8Wo/8RwvLvjUR4+0MYN
	 M7aIvdl1RsOZLWDud93cIulvXD6ee0mS2/W61KsFRWQPudXVtEz6n7wy8LeWBMQPiNLIO
	 QZ8oLGjmtx+nSV46O6VAo5wzstjPJ/7bVk4eqP/Ib3WWbZtSJGv+6S8PSIEqnd+BdmUgy
	 vVtkuRSdJJ04SEmodq1bUe3hk8L5xpZ3yN9+lz3O48BsOus3jyT/bm2FfYqh/vzIt9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAz9nvvu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5D4606A323;
	Tue, 27 Oct 2026 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAz9nvvu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC961F01829;
	Tue, 27 Oct 2026 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097390;
	bh=XK28uNsYnR2yFi3mVI+5oVuaCmk2yFzJ0DXrrVLzrR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BAz9nvvuG3xf5XBPHlxXYSc8glY0kc/4AuQgl6t8XZT4b0MDYEGUQkcwdoFblWp7K
	 Op2Ir8JqPlhqlVYZU96THJEbmpJFJuCRZYjvXNqoEa1PZshZ6XGHigzoWN6k2bMOVH
	 7ubbxHVGRI0Xo5LIf4oIYIc/L1lEAUKW+C+twDP+l6VKQoSb9/ZCMdi3N49nqdkxoC
	 MKovN1hPctCwuUWOKye0ZMgfJBSP4GXqpsGYjFEUg2ITjPp4j70y2lnlR1vLV5b7ht
	 Vc6M1ky+b0c9GdU4o2C+FQoffyTpZVLgXmuFqjiFfqPPsrKuDYuWH1384qVUrBRzv9
	 w52Ov87b85oZA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Corey Minyard <corey@minyard.net>,
	Huacai Chen <chenhuacai@kernel.org>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 03/27] mfd: ls2kbmc: Cancel reset work on teardown via devm_work_autocancel()
Date: Tue, 27 Oct 2026 09:30:32 +0000
Message-ID: <20261027093306.2812695-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027093306.2812695-1-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Binbin Zhou <zhoubinbin@loongson.cn>
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
2.56.0.307.g5fe7bd680c-goog

