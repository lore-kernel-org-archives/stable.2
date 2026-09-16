Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B54A64FD;
	Wed, 16 Sep 2026 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575090; cv=none; b=u/QK/cCOGLwPLqMr1ak4F7GLrKOyeR8n620B/hBT+M/0E2BhBPrYXntvupptzTA67J3m7RsMOD8Xvnaxha1ny6PijUFAVSXuPdk9tdbFaEJad7xqkpaVwByAP6AlHKR0Jj8qER+LLlpyHql9i9Z1hrBDk+0Mb/oniQ8S6Hf6cuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575090; c=relaxed/simple;
	bh=DakHawUkpRYbkkPUyivANrdDdVOy47ZYjthhRbVCbSc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HftLimywQxCfQAG5gYJC/H1CoFsqit2O8tPEjzKjSRgQjUsAx75xZfp4EO4I+gMXJUNbe2V9YF4Hgqhkzsh2qb3yXfn3P3WqGYr5Qp52o7zwpikTOOxCGGAw/CMh9kA2SU/NvmNNQKzkcEaBSEV+2DQF73JKtHvTgTruFckJbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXAj2pv6pqMG1tCA--.21106S2;
	Thu, 17 Sep 2026 00:11:22 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy@kernel.org
Cc: dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: accel: kxcjk-1013: Fix trigger reference leak in kxcjk1013_probe()
Date: Wed, 16 Sep 2026 16:10:54 +0000
Message-Id: <20260916161054.2082486-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXAj2pv6pqMG1tCA--.21106S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4rJr4kWr17ur1fGF48WFg_yoW8XFy7pF
	s2kFy5tFW7XrsrJF4kZF4v9Fy3tF43KrWUurW8C3W7Z3yYqrnYgw1Y9w4Sq348JrW8ur4U
	XFyftF95urW7ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUblAp5
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcMA2qqok9KdgACsd

The reference acquired for indio_dev->trig is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Move the
iio_trigger_get() after iio_triggered_buffer_setup() succeeds so that
failure of motion trigger registration or buffer setup, which return
before the mode is set, no longer leak the trigger reference.

Fixes: c1288b833881 ("iio: accel: kxcjk-1013: Increment ref counter for indio_dev->trig")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/accel/kxcjk-1013.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 2823ddde4bf2..dbaa829a98c2 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1488,10 +1488,6 @@ static int kxcjk1013_probe(struct i2c_client *client)
 		if (ret)
 			goto err_poweroff;
 
-		indio_dev->trig = iio_trigger_get(data->dready_trig);
-
-		data->motion_trig->ops = &kxcjk1013_trigger_ops;
-		iio_trigger_set_drvdata(data->motion_trig, indio_dev);
 		ret = iio_trigger_register(data->motion_trig);
 		if (ret) {
 			data->motion_trig = NULL;
@@ -1508,6 +1504,9 @@ static int kxcjk1013_probe(struct i2c_client *client)
 		goto err_trigger_unregister;
 	}
 
+	if (data->dready_trig)
+		indio_dev->trig = iio_trigger_get(data->dready_trig);
+
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret)
 		goto err_buffer_cleanup;
-- 
2.34.1

