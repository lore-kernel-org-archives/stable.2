Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CC5581F2;
	Wed, 16 Sep 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576227; cv=none; b=rQJ4n1H2RC8Da+spGhTyybctZ84I9IsZ04lrfGui2YZ8QvQ2vZctQ31veLcmHny4BqA5YZuIS7i1PrSZhpRd1L2AiRNdV8hQ2R7FZrqVqiT5c6uqxGHHX7BfJdkVIm+10oEXPlTk43dXBORx86amdTv3fbg9kwvcpqzcXmIO2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576227; c=relaxed/simple;
	bh=dDk6+kVp7i2/7e3H9+Qgr9nD4/ygnU27ul2HOZpHVCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rNiRTC/ZyNUDOe0a1QUtj1M1X7Qn6e2vVKf0lN3r499xYzlRJAb3EbGU26n0b4VpCfZbZwxDFPTiG06qplraE7azEJ3YIU/zxWakCaadLCjVUNgqxKm4VO6+teZBmBqUssr5Gpp8MdlLQ8Kn3sHODAgqiVwbKRyFLdMMUQeO0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXh0EYxKpqB65tCA--.22179S2;
	Thu, 17 Sep 2026 00:30:16 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy@kernel.org
Cc: dlechner@baylibre.com,
	jic23@kernel.org,
	linusw@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: gyro: mpu3050: Fix runtime PM leak in mpu3050_drdy_trigger_set_state()
Date: Wed, 16 Sep 2026 16:29:49 +0000
Message-Id: <20260916162949.2083791-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXh0EYxKpqB65tCA--.22179S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1UGFy5KF48JryDJFW5KFg_yoW8KF4xpr
	4IgF9IkFykXr4ftr4vyF1qqFy5Cr4fJrZ5WrWxK3sava13CF4jkF1jvFWaqF1fZrWkWF1U
	Jr47GFZxuF47taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	o5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQMA2qqozVQtwACsh

The enable path of the trigger state callback called
pm_runtime_get_sync() and returned early on every following register
access failure without releasing the runtime PM reference, leaving
the device powered permanently. Use pm_runtime_resume_and_get() to
propagate resume errors without bumping the usage count, and release
the reference on all error paths before returning.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/gyro/mpu3050-core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b431..aab2984a0c09 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -988,20 +988,23 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 		return 0;
 	} else {
 		/* Else we're enabling the trigger from this point */
-		pm_runtime_get_sync(mpu3050->dev);
+		ret = pm_runtime_resume_and_get(mpu3050->dev);
+		if (ret)
+			return ret;
+
 		mpu3050->hw_irq_trigger = true;
 
 		/* Disable all things in the FIFO */
 		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 
 		/* Reset and enable the FIFO */
 		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
 				      MPU3050_USR_CTRL_FIFO_EN |
 				      MPU3050_USR_CTRL_FIFO_RST);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 
 		mpu3050->pending_fifo_footer = false;
 
@@ -1013,12 +1016,12 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 				   MPU3050_FIFO_EN_GYRO_ZOUT |
 				   MPU3050_FIFO_EN_FOOTER);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 
 		/* Configure the sample engine */
 		ret = mpu3050_start_sampling(mpu3050);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 
 		/* Clear IRQ flag */
 		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
@@ -1037,10 +1040,14 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 
 		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 	}
 
 	return 0;
+
+err_pm_put:
+	pm_runtime_put_autosuspend(mpu3050->dev);
+	return ret;
 }
 
 static const struct iio_trigger_ops mpu3050_trigger_ops = {
-- 
2.34.1

