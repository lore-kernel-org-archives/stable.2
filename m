Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FC2360751;
	Thu,  4 Jun 2026 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566073; cv=none; b=iw4o/G5jUAdAop9ATD6Rkx2B9PnyI2+wWwt/pNkHh5hVyO8Iw3I4wYnEBHuuttjmaYAZS+Zp8ZqQFJFyiikspT40gfles6Y2AgxVZfSlMBKu7RPnKFcoHFYXRgRduibfJLp4byZzxRmoWnbz4Wtl8RF4d/Kh1uu00+k5tHag118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566073; c=relaxed/simple;
	bh=kavclw2XduIwI6zR0r5J0pk+5Tezo+0BlO2YgrWAEXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mA9/opKQiQrWKxMRHda5tWCHEW3q4/rgyXJWoiSPooFAr3p3lXwzlDXeYL5f32uc98DMiVjEVBWBm6mrgHXpfu38qNLXbr7SZkkAZabkWWzxHWwA1JiNiPNjgqMnAYXw90dRPsX6HmqBaXVLawKs7OVpWm/NJ206XXndRI3F5Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3Ov4dSCFqsexSEg--.1109S2;
	Thu, 04 Jun 2026 17:40:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: wbg@kernel.org
Cc: david@lechnology.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] counter: ti-eqep: fix refcount leak in ti_eqep_probe()
Date: Thu,  4 Jun 2026 09:40:36 +0000
Message-Id: <20260604094036.3777747-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Ov4dSCFqsexSEg--.1109S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF13Ary8tw13Wr4ftrykGrg_yoW8JFy8pr
	4v9FyUtFWxXrWIya4DAwnFqF909rW2yFW5GrykW3WkZw15Ja4Yv3WxJa4jqF18ZrZ5uw15
	tw4DWFW3uFWUu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6Hq
	cUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwIA2og-aBxuQABse

After a successful pm_runtime_get_sync(), ti_eqep_probe() can fail
if devm_clk_get_enabled() returns an error.  In that case the
runtime PM reference is never released, causing a refcount leak.

Fix this by adding pm_runtime_put_sync() and pm_runtime_disable()
calls before returning the error in the clock enable failure path.

The same cleanup pattern is already used when counter_add() fails,
so this change makes the error handling consistent.

Cc: stable@vger.kernel.org
Fixes: 0cf81c73e4c6 ("counter: ti-eqep: enable clock at probe")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/counter/ti-eqep.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index d21c157e531a..84fbf500b0f8 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -548,8 +548,11 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
+		pm_runtime_put_sync(dev);
+		pm_runtime_disable(dev);
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+	}
 
 	err = counter_add(counter);
 	if (err < 0) {
-- 
2.34.1

