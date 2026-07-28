Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [40.65.178.148])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECFB2FF675;
	Tue, 28 Jul 2026 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=40.65.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208291; cv=none; b=SaOHDJmffD88wDh3SSs/hI9sb3fdHhRNlCpBjtVwX8Q4GgFrFAnlhRasCdR9iQ+t/cENm62DnfjoCXYeWBLViPWb0BsKyOz/pt1hr7H8G2qsSKwKFti8ez/kUrbylHsQPJKsMj/S5uOwDFv1HFOuxiPyxkD36zmlfJ4iZ/L7x6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208291; c=relaxed/simple;
	bh=DS4+3AB7AxZeGvi5gfOm+zI8ypTKA6ksvPTZzHVQrqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BigAVJ6uUCBJOIBxH8sAPyCU4FwTDp6UeK/Tb+2HCAte0d4r8j/kPMRkhX8VNsV+u12Og9zogUlC43XaQbDE/PO8YqMiQEswoGzlkBg0haTgI61givgb4iy40KAHjqRmOaYi+4cJtSoWqTY4tmOJUFwV1NSnilOFXg0uDQ4zoZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=40.65.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCnoyjVHWhqsmRGAA--.30886S3;
	Tue, 28 Jul 2026 11:11:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgDHFMnUHWhq9zBHAw--.62812S2;
	Tue, 28 Jul 2026 11:11:16 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	david@ixit.cz,
	mgreer@animalcreek.com,
	oe-linux-nfc@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH net] nfc: trf7970a: initialize lock and timeout_work before requesting the IRQ
Date: Tue, 28 Jul 2026 03:10:21 +0000
Message-Id: <20260728031021.230831-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgDHFMnUHWhq9zBHAw--.62812S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?SNpX/gXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI2ljwtTJtsodX+CbV0a33Py9CptzckDSmBROxD8ytt34lCh
	vnG6Fi0T40569oL4j3qp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww1rZrW8Cry3tw17XF4DWrX_yoW8ury8pr
	sIgw4qvrW8CFWjyF17AFWIqa4F9w18Cr42ka409asxJanYyFs7AF1jqaya9Fy8Ars5Z3WY
	kFWUXr48ZFn0vrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjxU7ID7DUUUU

trf7970a_probe() calls devm_request_threaded_irq() -- which registers the
threaded handler trf7970a_irq() -- before it initializes trf->lock with
mutex_init() and trf->timeout_work with INIT_DELAYED_WORK(). The handler
takes trf->lock at entry and, through the helpers it dispatches to
(fill_fifo/drain_fifo/issue_eof/transmit), can schedule_delayed_work() on
trf->timeout_work. In the window between the IRQ request succeeding and
those two initializations, an IRQ would therefore touch an uninitialized
mutex and/or schedule an uninitialized delayed_work.

Initialize trf->lock and trf->timeout_work before requesting the IRQ. On
IRQ-request failure, destroy the mutex inline and return directly: the
request failed, so no handler is registered and nothing else will touch
the mutex.

This issue was found by an in-house static analysis tool.

Fixes: 165063f1dac4 ("NFC: trf7970a: Add driver with ISO/IEC 14443 Type 2 Tag Support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/nfc/trf7970a.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index f22e091..bc4d974 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -2124,18 +2124,19 @@ static int trf7970a_probe(struct spi_device *spi)
 		}
 	}
 
+	mutex_init(&trf->lock);
+	INIT_DELAYED_WORK(&trf->timeout_work, trf7970a_timeout_work_handler);
+
 	ret = devm_request_threaded_irq(trf->dev, spi->irq, NULL,
 					trf7970a_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"trf7970a", trf);
 	if (ret) {
 		dev_err(trf->dev, "Can't request IRQ#%d: %d\n", spi->irq, ret);
+		mutex_destroy(&trf->lock);
 		return ret;
 	}
 
-	mutex_init(&trf->lock);
-	INIT_DELAYED_WORK(&trf->timeout_work, trf7970a_timeout_work_handler);
-
 	trf->vin_regulator = devm_regulator_get(&spi->dev, "vin");
 	if (IS_ERR(trf->vin_regulator)) {
 		ret = PTR_ERR(trf->vin_regulator);
-- 
2.34.1

