Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B34F3B05B8;
	Mon,  3 Aug 2026 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744300; cv=none; b=mREFzZBljebatPXz18GqwSoJuWiJicCAdS5KyTqrMYsfZrqijfYoSGk5Ve4+sGvKsDIM9xf1QQ6taSocHs6H37kUqvryUYetCkGROCmmKSOHjWDySpHoW+CjWMK+blye/njhJptfLFjhUmf+KG4LWiu9VTT2j0tuyF39CZ4tGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744300; c=relaxed/simple;
	bh=pnB/gC+eLsD8DYcIu6vcdzxcBAOcMUYGo3ZNli6wQDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kiy2gOJD1UrcFCE1HmRljwEIRDR9AU9FFc2fKF3kKxzynW9wGxtDcafMfz8ml6VVBAK68W+xIVG+iPh4bRYKnzplpu/8gaPH/asLh8P90dpyX3Al2IxO+l7Jo8Arv6YVYDMqCwepx3+M3Yc9YTqEEBt7n3X8U6KXfAfRZixgA+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBn0zyXS3BqDx5eAA--.2704S3;
	Mon, 03 Aug 2026 16:04:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgCXezSXS3Bq+6XYAg--.59279S2;
	Mon, 03 Aug 2026 16:04:39 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	michal.simek@amd.com,
	conall.ogriofa@amd.com,
	bgolaszewski@baylibre.com,
	DileepKumar.Nagavarapu@amd.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: adc: xilinx-xadc: free IRQ before cancelling the unmask worker on unbind
Date: Mon,  3 Aug 2026 08:03:43 +0000
Message-Id: <20260803080343.467906-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCXezSXS3Bq+6XYAg--.59279S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?WwJ93QXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZwFwXva0N+AT7Y/+5x3U9MmdVjh2nL0Jr8ZgRhuSJ8FbtH0
	g1icXbAlzBYNLKGt3tXN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww1DWF4rWryDGFyxAr1UJwc_yoW8CFW7pF
	s8GFs8Cr48uFZ2qFy7ZwnFvFyY93ZxJF17Cr4Ig3W3Wwn8Xr4Fva4aqFZ7Za1rXrWxA3Wk
	ZFW2qaykuayDZFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

The ZYNQ XADC alarm IRQ handler queues zynq_unmask_work via
schedule_delayed_work(); that work is cleared by a devm callback.
Register the devm callback before devm_request_irq() so the devres LIFO
teardown frees the IRQ first, ensuring the handler can no longer queue
work by the time the workqueue is cleared. Otherwise the handler could
re-arm the work and run it after the xadc structure has been freed.

This issue was found by an in-house static analysis tool.

Fixes: 2a9685d1a3b7 ("iio: adc: xilinx: use more devres helpers and remove remove()")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---

Changes in v2: shorten the commit message and replace the multi-line code
comment with a one-line note, per review feedback from Jonathan Cameron.
The devm registration reorder (the fix) is unchanged; David Lechner's
Reviewed-by was obtained on v1.

 drivers/iio/adc/xilinx-xadc-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1395,13 +1395,14 @@ static int xadc_probe(struct platform_device *pdev)
 	}

 	if (irq > 0) {
-		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
-				       0, dev_name(dev), indio_dev);
+		/* Clear out any work queued by the interrupt */
+		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
+					       &xadc->zynq_unmask_work);
 		if (ret)
 			return ret;

-		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
-					       &xadc->zynq_unmask_work);
+		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
+				       0, dev_name(dev), indio_dev);
 		if (ret)
 			return ret;
 	}
--
2.43.0

