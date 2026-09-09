Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73FF55409C;
	Wed,  9 Sep 2026 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967685; cv=none; b=clDMbyLzY39XQ8peGGHeUVsvI7+WG+WE9koDi0y1NJVciwzTYuklAoS9MieRQYyD+yzUHcXIc5sFp6iFRc0Ph9QExZm1gMRS8Q+tRbVyfXXqDBqkvfXdwhypKRejiNxPTWVhgZz45JvTpVejLMikAjKwxoYa0cJeOtQlXd8OxRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967685; c=relaxed/simple;
	bh=GbQE/C5EL3goLl9+Xf5dk6SfdFav9LFstn5nK7k2Z0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BTr+jDWOKs0m0at+o4TCYNjWEfVCXmf1P0bdD/Zfj8Fl2enxuBCOHBnjcS2Tc+2hTLm8b995J+dkz2PNDWGdZourl564uWTlcvXZ4OhUxUu1+LlCPryX7z68eQv3KYxllsrhVYLH+NIrP30kfkrsOa4iVQ9Wqr7jA4LUOuGm3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDn7zf5eqFqsqUDAQ--.35929S3;
	Wed, 09 Sep 2026 23:27:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgCHUXX5eqFqcvgLBQ--.14715S2;
	Wed, 09 Sep 2026 23:27:53 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: alexandre.belloni@bootlin.com,
	cl634@andestech.com
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] rtc: atcrtc100: cancel alarm work on remove
Date: Wed,  9 Sep 2026 15:26:51 +0000
Message-Id: <20260909152651.712614-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCHUXX5eqFqcvgLBQ--.14715S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?1GNiTgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WPkJOV2rqO1KNC8oE4y/Lr6IwZ8o0fuNPjhcAwmE/jJ3xxa
	GkfmUcmsO0hiCFspzh+p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxWw17ArW7Ar45Cr45KFy8JFc_yoW5XFyfpF
	WfXF98WrWDKr4aqw42vr4jvF1UCw1Sq3y5GF1xZwna93s5JF9xZFyrZFW8W398JrZ5Ga1a
	yFWjy3y5CFWUCFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUcXo2UUUUU

The alarm interrupt handler atcrtc_alarm_isr() queues rtc_work on the
system workqueue to clear the alarm. The handler atcrtc_alarm_clear()
dereferences the devm-managed atcrtc_dev through container_of(), takes
rtc_lock() on the RTC device and writes the regmap.

The driver has no remove callback, and the devres cleanup only frees
the interrupt before the remaining resources. free_irq() waits for the
interrupt handler, but it does not cancel work the handler already
queued. A pending atcrtc_alarm_clear() can therefore run after the
regmap, the I/O mapping and finally the device structure have been
released, and dereference freed memory.

Add a remove callback that frees the interrupt first, so no new work
can be queued, and then cancels the alarm work, following the same
pattern as rtc-ds1374 and rtc-ds1305.

It also clears the wake IRQ and disables the wakeup source configured
in probe. These are not devres-managed, and the driver core only
releases them when the device itself is removed, not on unbind.
Without this cleanup, a later bind would fail probe with -EEXIST:
device_wakeup_attach() rejects a second wakeup source for the same
device, and the leftover wake IRQ would make dev_pm_set_wake_irq()
fail with -EEXIST and a WARN as well.

This issue was found by an in-house static analysis tool.

Fixes: 7adca706fe16 ("rtc: atcrtc100: Add ATCRTC100 RTC driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/rtc/rtc-atcrtc100.c | 11 +++++++++++
 1 file changed, 11 insertions(+)
diff --git a/drivers/rtc/rtc-atcrtc100.c b/drivers/rtc/rtc-atcrtc100.c
index 9808fc2c5a49..3c7313218da5 100644
--- a/drivers/rtc/rtc-atcrtc100.c
+++ b/drivers/rtc/rtc-atcrtc100.c
@@ -337,6 +337,16 @@ static int atcrtc_probe(struct platform_device *pdev)
 	return devm_rtc_register_device(atcrtc_dev->rtc_dev);
 }
 
+static void atcrtc_remove(struct platform_device *pdev)
+{
+	struct atcrtc_dev *atcrtc_dev = platform_get_drvdata(pdev);
+
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+	devm_free_irq(&pdev->dev, atcrtc_dev->alarm_irq, atcrtc_dev);
+	cancel_work_sync(&atcrtc_dev->rtc_work);
+}
+
 static int atcrtc_resume(struct device *dev)
 {
 	struct atcrtc_dev *rtc = dev_get_drvdata(dev);
@@ -372,6 +382,7 @@ static struct platform_driver atcrtc_platform_driver = {
 		.pm = pm_sleep_ptr(&atcrtc_pm_ops),
 	},
 	.probe = atcrtc_probe,
+	.remove = atcrtc_remove,
 };
 
 module_platform_driver(atcrtc_platform_driver);

