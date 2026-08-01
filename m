Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C3345CBC;
	Sat,  1 Aug 2026 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785561122; cv=none; b=CrSvuB3dcZOXV9+2i5mtIRVJVoWMIRo/ZG0OZhdgRh4HkJ3K0QTtBre6elzlPL3RvY/sKHYzX4+WcqkNpyPxTB6K86IgKqsL5BTT2sWwYeeVXz9OZi+Zkz9evnRHSOp8q0c3yQDBXV7ndf0TkEOiZOyu8xeY+TGto7FOeaLHlFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785561122; c=relaxed/simple;
	bh=tIR0WkLI1LxokdvhXnje5FI83cJbHry72ShTYHLpf18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjL76Sh5kikBSeIYCaKF8cyS9CBqUHy+VjTMUh4PxsCG9UwYb6PjI3cJB4eF52U3Z64gRvwqp9KjwTxugCb+dAN6BxVTuhbRpWaWjyKU2erRDHL5jVRtBzAa21SGnsV3mPUP8PsQfxKpl2449C8U6YtvkYhATJ7ly/V1Nmtd1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wB3RSkcgG1qYSpWAA--.6816S3;
	Sat, 01 Aug 2026 13:11:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgAX_DQZgG1q8hjIAg--.52348S3;
	Sat, 01 Aug 2026 13:11:55 +0800 (CST)
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
Subject: [PATCH net v3 1/2] nfc: trf7970a: set up lock and timeout work before requesting IRQ
Date: Sat,  1 Aug 2026 05:10:57 +0000
Message-Id: <20260801051058.354165-2-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260801051058.354165-1-fanwu01@zju.edu.cn>
References: <20260801051058.354165-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgAX_DQZgG1q8hjIAg--.52348S3
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?MqxcPgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZzpNezyqMq3CUm7nMdX514fL2gcCEq3jlm1XGvHysDteFjp
	ArTWxRvCnrkXPZc1OWGp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxXryxCr15tw17Xr4DtFyxZwc_yoW5Xr13pr
	45WrZF9rWkCFW0yrW7AF4Iq3WFvw48G3y7C3yj9a93Z3W5AFn7JF1qqFW0vFy8JrWkAw1Y
	yFWUZr4rAF10v3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zc_3UUUUU==

trf7970a_probe() registers the threaded IRQ handler before it
initialises the lock the handler takes on entry and the delayed work it
can queue. An interrupt arriving in that window can use either object
before it has been initialised.

Set up both before registering the IRQ, and use devm_mutex_init() for
the lock. This makes the mutex teardown part of the devres lifetime: the
IRQ is released before the mutex is destroyed, and both precede freeing
trf. It also retains CONFIG_DEBUG_MUTEXES lifetime checking.

The explicit mutex_destroy() calls and the now-empty err_destroy_lock
label are removed.

This issue was found by an in-house static analysis tool.

Fixes: 165063f1dac4 ("NFC: trf7970a: Add driver with ISO/IEC 14443 Type 2 Tag Support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/nfc/trf7970a.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index f22e091..9c6f8db 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -2124,6 +2124,12 @@ static int trf7970a_probe(struct spi_device *spi)
 		}
 	}
 
+	ret = devm_mutex_init(trf->dev, &trf->lock);
+	if (ret)
+		return ret;
+
+	INIT_DELAYED_WORK(&trf->timeout_work, trf7970a_timeout_work_handler);
+
 	ret = devm_request_threaded_irq(trf->dev, spi->irq, NULL,
 					trf7970a_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -2133,20 +2139,17 @@ static int trf7970a_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	mutex_init(&trf->lock);
-	INIT_DELAYED_WORK(&trf->timeout_work, trf7970a_timeout_work_handler);
-
 	trf->vin_regulator = devm_regulator_get(&spi->dev, "vin");
 	if (IS_ERR(trf->vin_regulator)) {
 		ret = PTR_ERR(trf->vin_regulator);
 		dev_err(trf->dev, "Can't get VIN regulator: %d\n", ret);
-		goto err_destroy_lock;
+		return ret;
 	}
 
 	ret = regulator_enable(trf->vin_regulator);
 	if (ret) {
 		dev_err(trf->dev, "Can't enable VIN: %d\n", ret);
-		goto err_destroy_lock;
+		return ret;
 	}
 
 	uvolts = regulator_get_voltage(trf->vin_regulator);
@@ -2212,8 +2215,6 @@ err_disable_vddio_regulator:
 	regulator_disable(trf->vddio_regulator);
 err_disable_vin_regulator:
 	regulator_disable(trf->vin_regulator);
-err_destroy_lock:
-	mutex_destroy(&trf->lock);
 	return ret;
 }
 
@@ -2232,8 +2233,6 @@ static void trf7970a_remove(struct spi_device *spi)
 
 	regulator_disable(trf->vddio_regulator);
 	regulator_disable(trf->vin_regulator);
-
-	mutex_destroy(&trf->lock);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.34.1

