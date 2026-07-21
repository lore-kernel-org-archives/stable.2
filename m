Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AE728CF6F;
	Tue, 21 Jul 2026 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641007; cv=none; b=kbsrY8tVnVVnvOwIZebdAl5oHexoqy9VyYBV5qkQvKYTvTweX65WkO/63HG6Us6b8G7mPOJlNk9VrnGTH6w+W+bkoIIMmiZUWjkvZYzy3ThHpb7QOjrxiah7VHu+cCSWP8vC821beHoi54qO9PJq2arbwyTKQr1HmGLavLo0JUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641007; c=relaxed/simple;
	bh=xXWoiA/IMfvo2fW9+qs8oWUF2c8s/TNEzS5/ImXfWMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=evlZpMa6Au4bbbWqDccStfLJBdPt5zxFXV4IoofQP7IKz84K7Anpi8xzgNFpyvVmGSWkZWYXRuj2bXvfJ+D7qBRLhAnWmgMFxFmMfZ//+9bPWhcW0eoMw58M4NBp9mmnMW3Er7IyE96xq6hj3McBgFFZemG9XB0rsudCgh4FSyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAHBCnidV9qG4AjAA--.8678S3;
	Tue, 21 Jul 2026 21:36:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgAH7DTidV9qi7B7Ag--.20377S2;
	Tue, 21 Jul 2026 21:36:34 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: mgreer@animalcreek.com,
	sameo@linux.intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH net] nfc: trf7970a: drain timeout_work and keep trf->lock valid across teardown
Date: Tue, 21 Jul 2026 13:35:39 +0000
Message-Id: <20260721133539.3195899-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgAH7DTidV9qi7B7Ag--.20377S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?u8kamQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZyWPJIMTh2S86tM1FUWwcRMjYzo4cl47poEdWNGrONdVUDq
	RYexNMRr1jkTlqoxcW6p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7WF15WrW8Cr1fKw4rKry3GFX_yoW8CF4rpr
	4fWFyq9ry8uFWUAF4DAFZ2qFyrJw48J3yxC34Uu3y3Xws8JF1xJ34xAa4jvFy8ArykZ3W2
	vrW2vr48WF40vFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

The threaded IRQ handler and timeout work can wait on trf->lock while
teardown destroys it. The timeout handler can also access the digital
device after it has been freed.

Synchronize timeout_work before releasing the digital device, and leave
the embedded mutex alive for devres cleanup to synchronize the IRQ
handler before trf is freed: devm_request_threaded_irq() is registered
after devm_kzalloc(), so devm_free_irq() runs before trf is released.

This issue was found by an in-house static analysis tool.

Fixes: 165063f1dac4 ("NFC: trf7970a: Add driver with ISO/IEC 14443 Type 2 Tag Support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/nfc/trf7970a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index d17c701..fa2f75a 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -2206,13 +2206,13 @@ static int trf7970a_probe(struct spi_device *spi)
 err_shutdown:
 	trf7970a_shutdown(trf);
 err_free_ddev:
+	cancel_delayed_work_sync(&trf->timeout_work);
 	nfc_digital_free_device(trf->ddev);
 err_disable_vddio_regulator:
 	regulator_disable(trf->vddio_regulator);
 err_disable_vin_regulator:
 	regulator_disable(trf->vin_regulator);
 err_destroy_lock:
-	mutex_destroy(&trf->lock);
 	return ret;
 }
 
@@ -2226,13 +2226,13 @@ static void trf7970a_remove(struct spi_device *spi)
 
 	mutex_unlock(&trf->lock);
 
+	cancel_delayed_work_sync(&trf->timeout_work);
+
 	nfc_digital_unregister_device(trf->ddev);
 	nfc_digital_free_device(trf->ddev);
 
 	regulator_disable(trf->vddio_regulator);
 	regulator_disable(trf->vin_regulator);
-
-	mutex_destroy(&trf->lock);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.34.1

