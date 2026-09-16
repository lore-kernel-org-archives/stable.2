Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9CD35CB91;
	Wed, 16 Sep 2026 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577241; cv=none; b=pjr/pi5oMv2bZeWGplak/3WjwlPshKjJA8wemjbr3Y+Ckm+e13IIB4vWwNZhd/j01AcnMt5OVVrrveEGtCdR9dhaRiDFGWbLmyQK8T9F32e1SfM13U17T8M9QJEGABM74ZifN86dEuYe8jjNfjcEVjTr7GUlTuKng05oZPC0j4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577241; c=relaxed/simple;
	bh=wVTeB5YgyU2bpiGFqRsAVuk8J1XzlyJVwnWZoxbu07I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FfPT0odOxZiNl3gp6lh1Vrbs3In86ObsvIUMnoy1i1248pPOMphWbgUe27m7ahUMxwBDz3/Iivvjg5mWViDGyExz3UJErkD4wy9bt4MOOkvanJEPhuqfv87ST6OKIMf+w2+o6tzFTN5J0Hu/R90Li9F7quINyunUQ4RBih0KEpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHsTsOyKpq1+ttCA--.21855S2;
	Thu, 17 Sep 2026 00:47:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: daniel@zonque.org
Cc: krzk@kernel.org,
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] w1: Fix of_node reference leak in __w1_attach_slave_device()
Date: Wed, 16 Sep 2026 16:46:42 +0000
Message-Id: <20260916164642.2084964-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHsTsOyKpq1+ttCA--.21855S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW7WrWUtr18Cr17Aw47Jwb_yoW8Gw4rpF
	45WFWayry5Cr4xKw4av347WF90kFWjy3yrCFy7Gw1akFs8X345AryjqFWYqwn5JFZ5CF4Y
	vayjyr4kXr4rC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj
	nmRUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIMA2qqozVZswAAso

__w1_attach_slave_device() stores the device node returned by
of_find_matching_node() in sl->dev.of_node, but nothing drops that
reference when the slave device is released: w1_slave_release() never
calls of_node_put() and the device core does not free dev->of_node
either.  The node reference taken on every successful slave
registration is therefore leaked.

Drop the reference in w1_slave_release() and remove the explicit
of_node_put() from the device_register() failure path, which now
releases the node through put_device().

Fixes: fae68031f7fb ("w1: core: match sub-nodes of bus masters in devicetree")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/w1/w1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 486f321eadc8..909f0ac6eafe 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -78,6 +78,7 @@ static void w1_slave_release(struct device *dev)
 
 	dev_dbg(dev, "%s: Releasing %s [%p]\n", __func__, sl->name, sl);
 
+	of_node_put(dev->of_node);
 	w1_family_put(sl->family);
 	sl->master->slave_count--;
 }
@@ -692,7 +693,6 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
 		dev_err(&sl->dev,
 			"Device registration [%s] failed. err=%d\n",
 			dev_name(&sl->dev), err);
-		of_node_put(sl->dev.of_node);
 		put_device(&sl->dev);
 		return err;
 	}
-- 
2.34.1

