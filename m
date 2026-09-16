Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C239327442;
	Wed, 16 Sep 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576891; cv=none; b=Vq2cpKu3JReTsZnJZINPnC6lxsTbjZAVDW9U1D96IWHC9e2iWP21ulipeLQIAJ2YJGfT8GbAEu7f8Xo3KB+kBXUOHT4lUXIGZkhBhNJ1JyoNiVd4zbr9nWnEPm3W86WtEmJ/NHrYsUuzSkMPRq0fq0BUyjwVgjs9FIKQNJt2hfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576891; c=relaxed/simple;
	bh=vuid5HPFu0HvA9QmTcinB24UO1+C9roSwlu+ZS61u0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rpAbg1LGWwY051KUqngpwAGL9f3qqEnPpbB6F9f8VnR76P1d248niu+N8q4JMoQIhvTdeRh1+71Ay8F/MffUSD1u3b30Su98KtWG/nJ4XzgXN1rM2EfN12baB31mMyzfJHj7osltNWZg+pub/UbVSXvKD5vU1+a2vz5GlU2zTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADHMTynxqpq+NRtCA--.21805S2;
	Thu, 17 Sep 2026 00:41:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: abhashkumarjha123@gmail.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	songqiang1304521@gmail.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: proximity: vl53l0x: Fix trigger reference leak in vl53l0x_probe()
Date: Wed, 16 Sep 2026 16:40:43 +0000
Message-Id: <20260916164043.2084494-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHMTynxqpq+NRtCA--.21805S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw45ArWfur1xGF4fKFykKrg_yoW8Gry8pF
	s3trW7ta4DXr1xGF4q9Fn09ryaqFZxtrZ5ur4UZ347u3y5Za1Y9F1Yvw1agw1kXFyxCr4U
	XrZ7ta9Yka1jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7VUbo5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIMA2qqpO9NxwAEsE

The reference taken with iio_trigger_get() is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Failure of
vl53l0x_configure_irq() or of triggered buffer setup returns before
that mode is set and leaks the reference acquired for
indio_dev->trig. Move the iio_trigger_get() after those setup steps
succeed.

Fixes: 762186c6e7b1 ("iio: proximity: vl53l0x-i2c: Added continuous mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index ad3e46d47fa8..abef4129e645 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -374,8 +374,6 @@ static int vl53l0x_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
-		indio_dev->trig = iio_trigger_get(data->trig);
-
 		ret = vl53l0x_configure_irq(client, indio_dev);
 		if (ret)
 			return ret;
@@ -387,6 +385,8 @@ static int vl53l0x_probe(struct i2c_client *client)
 					&iio_triggered_buffer_setup_ops);
 		if (ret)
 			return ret;
+
+		indio_dev->trig = iio_trigger_get(data->trig);
 	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
-- 
2.34.1

