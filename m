Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDDB495AC0;
	Wed, 16 Sep 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576516; cv=none; b=ZsmzeAzEulH8WxaVublgINQHgE/mdMnrFlVepBPvvESJZVk9OudYa2ckESpbRrqTdP1fxFE8X3f0xzgMo6HfqSH6i5xveGjesigBuCsJjQqTjNS8FnMdZSyberWRjTpdOTNaegTtZU385nxtskthwcDxpkJGFCUNeGjmX3q8De8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576516; c=relaxed/simple;
	bh=h9aLVBIzXbDahAfOmn1/DsevrfT5vdFtQOrgqwz/PJw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zx+leJHPg7S2OU+yydQbgR9yrvgbsDQ55sANzarOfLPOVDOxLKYtJpwPWBA2jg7aPwLTGX99F2olYmSiTLYUbUb4NH5c8Vk5Z8e2yF9riBxDTgkDT8cg49BYmu4OLPF7Dn9dPC5fbmrGyJFVYaaR/zA7mdNGokC/xIxzX25YOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXAj07xapqpr9tCA--.21498S2;
	Thu, 17 Sep 2026 00:35:08 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy@kernel.org
Cc: dlechner@baylibre.com,
	gwendal@chromium.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: light: acpi-als: Fix trigger reference leak in acpi_als_probe()
Date: Wed, 16 Sep 2026 16:34:40 +0000
Message-Id: <20260916163440.2084089-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXAj07xapqpr9tCA--.21498S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47GryDAry3KF1rAw15twb_yoW8XF13pF
	sakFWSyFyDXryxta1Du3WqkFy7ta9avay8WFW8Z3s3u3y5Jrn0gFy0qFyrX3W8AFyfWrWU
	Xr1kJF18CFW2vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUMA2qqpVhMegAAsG

The reference taken with iio_trigger_get() is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
devm_iio_triggered_buffer_setup() fails before setting that mode, the
reference acquired for indio_dev->trig leaks. Move the
iio_trigger_get() after the buffer setup succeeds.

Fixes: 24b84444eb6f ("iio: acpi_als: Add trigger support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/light/acpi-als.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index ab229318dce9..ad95057d99c2 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -206,11 +206,6 @@ static int acpi_als_probe(struct platform_device *pdev)
 	ret = devm_iio_trigger_register(dev, als->trig);
 	if (ret)
 		return ret;
-	/*
-	 * Set hardware trigger by default to let events flow when
-	 * BIOS support notification.
-	 */
-	indio_dev->trig = iio_trigger_get(als->trig);
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
@@ -219,6 +214,12 @@ static int acpi_als_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Set hardware trigger by default to let events flow when
+	 * BIOS support notification.
+	 */
+	indio_dev->trig = iio_trigger_get(als->trig);
+
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		return ret;
-- 
2.34.1

