Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF245449EB8;
	Wed, 16 Sep 2026 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543586; cv=none; b=ZXLCJtofNqr0Av3Nsd79ZRS3FH5lXHmdFjxYJmG38Dplsr04VRaN/wKpUDauoGuUD1uC6CKD+WCeduyWYPP7GGak+cWl4M6bjxsI+1roPpOu0x336kEqzLLUf49kQ8nkwvzsK8zHt9Sf9i1Yjxyd5argatyzj4l9aqfV7BJz3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543586; c=relaxed/simple;
	bh=Lu8wsMR69TwGFbv0jVCbT8j4mEA51xuopusEo60Iy+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J2ccOlVc4bjptIIMQKRPih6IIYdsax4L6P6prquAzxUyAellL4R7aeiORiJW0tcszFcqWdTP2+cCDj1I8Ynz7w4VwGftEt6UZaxXvfvs/PDvWutRjsPZwRPDyI13xHaOX+ivhtHXlpKNOsl5mc6LylrUn1yWXLtBZ+H81E/99+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHDz2RRKpq7BvfBw--.27351S2;
	Wed, 16 Sep 2026 15:26:09 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: cy_huang@richtek.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] regulator: rt6190: Fix runtime PM imbalance in rt6190_out_enable()
Date: Wed, 16 Sep 2026 07:25:41 +0000
Message-Id: <20260916072541.1968033-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHDz2RRKpq7BvfBw--.27351S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1kGr48tr1fXF4Dtr4DCFg_yoW8Ar4Dpw
	4UuFZYyF1IqFy8J3yjka1Iv3W5Xw47t3sxC3y8Gw1kZw1FyF1fKr15ZFWFvF1kJr97Xr4j
	yayDAFW8CF1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUYZ
	XoUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggMA2qqPpQYEAACsh

In rt6190_out_enable(), pm_runtime_get_sync() is called at the start of
the function. However, if any subsequent regmap or regulator operation
fails, the function returns directly without dropping the runtime PM
reference, causing a runtime PM reference leak.

Add an error handling path with pm_runtime_put() to keep the reference
count balanced on failure.

Fixes: e6999e7cca7e ("regulator: rt6190: Add support for Richtek RT6190 regulator")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/regulator/rt6190-regulator.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/rt6190-regulator.c b/drivers/regulator/rt6190-regulator.c
index 3883440295ed..bf99e18f6d5b 100644
--- a/drivers/regulator/rt6190-regulator.c
+++ b/drivers/regulator/rt6190-regulator.c
@@ -109,19 +109,27 @@ static int rt6190_out_enable(struct regulator_dev *rdev)
 	ret = regmap_raw_read(regmap, RT6190_REG_OUTV, out_cfg,
 			      sizeof(out_cfg));
 	if (ret)
-		return ret;
+		goto err_pm_put;
 
 	ret = regulator_enable_regmap(rdev);
 	if (ret)
-		return ret;
+		goto err_pm_put;
 
 	ret = regmap_raw_write(regmap, RT6190_REG_OUTV, out_cfg,
 			       sizeof(out_cfg));
 	if (ret)
-		return ret;
+		goto err_pm_put;
+
+	ret = regmap_update_bits(regmap, RT6190_REG_SET5, RT6190_ENGCP_MASK,
+				 RT6190_ENGCP_MASK);
+	if (ret)
+		goto err_pm_put;
+
+	return 0;
 
-	return regmap_update_bits(regmap, RT6190_REG_SET5, RT6190_ENGCP_MASK,
-				  RT6190_ENGCP_MASK);
+err_pm_put:
+	pm_runtime_put(data->dev);
+	return ret;
 }
 
 static int rt6190_out_disable(struct regulator_dev *rdev)
-- 
2.34.1

