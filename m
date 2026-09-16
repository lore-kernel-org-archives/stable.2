Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222264C2253;
	Wed, 16 Sep 2026 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575970; cv=none; b=ByfDE3XSuiNCMYLQPNsEa06/3fiZFtG8MT6Pv8kDp1aMrWyl4A5VvTVmEJDfDMrlRk1n/rJV17j8n3FMtnJrVycM8T8P476vfxim5Jl70hdD1SO1KINbGCaME82vKDJ+k7eRUctweuqmsB2IvMCSRTSk9HhSevGrN+sFzBsbe3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575970; c=relaxed/simple;
	bh=dn9uqVGxzSPoTlfbPQ21ISHGa1+XzQf2anGY+8hQSBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=It8H77rw3RCxkR+D+6q+7Hl6Yj6KPB0PkxAYi2dx9c4uXZNlWaSSCHo4SAudqPFc6rkPfGAwAXsNuWd7U65IzAk1KMewMR5VUSyLkKQC+2iCGmWNJkqWQvK+Y0N9cidf5xsVv4gx+tP71N2n5/JwvNL8knwtMJ3CRMvGNfwsHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnDzoaw6pqwJ9tCA--.44682S2;
	Thu, 17 Sep 2026 00:26:02 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy@kernel.org
Cc: dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	narcisaanamaria12@gmail.com,
	nuno.sa@analog.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: chemical: ccs811: Fix trigger reference leak in ccs811_probe()
Date: Wed, 16 Sep 2026 16:25:34 +0000
Message-Id: <20260916162534.2083446-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnDzoaw6pqwJ9tCA--.44682S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47GryDAr4DCFyDJFWkWFg_yoW8GF1rpw
	sagF45tFyUXr4xJw4Du3WUCry2qanxtrWjkFWUWasF93y5Ar1FgFyj9FWUXw18ZFW8ur47
	Ary8tFWF9rWjyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5d
	gADUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMMA2qqok9QugABsM

The reference taken with iio_trigger_get() is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
iio_triggered_buffer_setup() fails before setting that mode, the
reference acquired for indio_dev->trig leaks. Move the
iio_trigger_get() after the buffer setup succeeds.

Fixes: f1f065d7ac30 ("iio: chemical: ccs811: Add support for data ready trigger")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/chemical/ccs811.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 998c9239c4c7..bbc8284316ab 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -503,8 +503,6 @@ static int ccs811_probe(struct i2c_client *client)
 		ret = iio_trigger_register(data->drdy_trig);
 		if (ret)
 			goto err_poweroff;
-
-		indio_dev->trig = iio_trigger_get(data->drdy_trig);
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
@@ -515,6 +513,9 @@ static int ccs811_probe(struct i2c_client *client)
 		goto err_trigger_unregister;
 	}
 
+	if (data->drdy_trig)
+		indio_dev->trig = iio_trigger_get(data->drdy_trig);
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "unable to register iio device\n");
-- 
2.34.1

