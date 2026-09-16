Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A9517BB0;
	Wed, 16 Sep 2026 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575483; cv=none; b=uLlOICCZSfPDRZ0FCKhgvTx23IhaOPo+rWegXVt4o/nGCm+Zb9jv2Wb/O9rZ3FFXtO/jzMKZBzv+wB2T8ebZHRadNnkBaAOT3CONxOk6dbVKOtU8P9wOUlPNnIquun4oCmbDWuujhanY4mFc3vdPxoLZIBNN+Opq/DZqAlNMkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575483; c=relaxed/simple;
	bh=ZQo4teqj0tpx+QGjxrK1+1XsUp6+lfcjVd5H7buu+4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UwQNhdR9kmFkoDvtLHjoh3vOqh539Doj/prdYjfy2yIElK3zJCW/ZaKXeQ9iIZ1GxsATbmYQmMujyCriMPTAvYqHW4hD2xGGtOlxvisQ21ol5yXfmWd8X5DDH75VYIBMWWEwVuXFZ39S+vqdRAauXG4ocYGeMraZJb6GoFOenWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3J0IywapqV4NtCA--.22108S2;
	Thu, 17 Sep 2026 00:17:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Michael.Hennerich@analog.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	stefan.popa@analog.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: adc: ad7768-1: Fix trigger reference leak in ad7768_triggered_buffer_alloc()
Date: Wed, 16 Sep 2026 16:17:26 +0000
Message-Id: <20260916161726.2082904-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3J0IywapqV4NtCA--.22108S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47GryDAF1DGw1rJryfXrb_yoW8GF4UpF
	sa9F4jyFZ8Xr1fJa1UZ3WDCF9IyanxtrW5CFW8uas7u3y5Ar1F9r1Y9FnIqr18AFWv9ryU
	JryfJw4kuF47ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgEMA2qqok9NWgADsx

The reference taken with iio_trigger_get() is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
devm_iio_triggered_buffer_setup() fails before setting that mode, the
reference acquired for indio_dev->trig leaks. Move the
iio_trigger_get() after the buffer setup succeeds.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/adc/ad7768-1.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 73fb734d06b2..94e746c78cd8 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -1505,12 +1505,16 @@ static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &ad7768_trigger_handler,
+					      &ad7768_buffer_ops);
+	if (ret)
+		return ret;
+
 	indio_dev->trig = iio_trigger_get(st->trig);
 
-	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
-					       &iio_pollfunc_store_time,
-					       &ad7768_trigger_handler,
-					       &ad7768_buffer_ops);
+	return 0;
 }
 
 static int ad7768_vcm_enable(struct regulator_dev *rdev)
-- 
2.34.1

