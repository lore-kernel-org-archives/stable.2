Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E83F12EC;
	Wed, 16 Sep 2026 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542426; cv=none; b=f4RIAQdJ9FhoLQSu1byczGmv6o4ZskypYt01rMO+O3nVVkNmStMmIKIm/f0Voz0xc6yUZlUg3DbaYipso/xhJfTwRToyLZARMG+K1Aex63aPquPFbCYG2D0cnQ+mJOQGv+Uf0a02T30AdXxQKNrS3k4MT4WXLHaPtkdDXG2TU7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542426; c=relaxed/simple;
	bh=WWORv9Lf0MxC7KuvSpHDDaWShFdtjCAlxf6+OQzVUaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hZwOZ89Im7mNVW6FVOgA/1BFCYh1QNoLrc+2eLKL+tYtoVinbd/3Uw+YSi9aElN6PsS1GOuNHh7z1Uw4Ym49gHkOuxtjwWQWGgBWgZZro+P3MKJMYWK/guE9mg/VsXRsRiAbVai9HiAhvCYuEbqU+XG+c4NuqfScjji9lzzC1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAD3+TcUQKpqxeveBw--.65276S2;
	Wed, 16 Sep 2026 15:07:00 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alchark@gmail.com
Cc: andi.shyti@kernel.org,
	krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@prisktech.co.nz,
	wsa@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 04/20] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()
Date: Wed, 16 Sep 2026 07:06:31 +0000
Message-Id: <20260916070631.1965713-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3+TcUQKpqxeveBw--.65276S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XryDKF17CrWrJF1ktF43Jrb_yoWktrbEkF
	4DC3srZr17GFn5tw1UXr4av3yvkF4ku348Ka10yr4ayryUWwn3G3Wqv3s3ZrsrWw42gFyY
	q3WjqFWfZw13ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUKdgAUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUMA2qqP4cDTwAAsn

In wmt_i2c_probe(), i2c->clk is acquired using of_clk_get(). If any
subsequent operation fails or when the module is unloaded, the clock
reference count is never decremented via clk_put(), leading to a
resource leak.

Switch to devm_clk_get() so that the clock is automatically managed
and released.

Fixes: 560746eb79d3 ("i2c: vt8500: Add support for I2C bus on Wondermedia SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/i2c/busses/i2c-viai2c-wmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-viai2c-wmt.c b/drivers/i2c/busses/i2c-viai2c-wmt.c
index 2cf3cc0165fb..74ca93b44347 100644
--- a/drivers/i2c/busses/i2c-viai2c-wmt.c
+++ b/drivers/i2c/busses/i2c-viai2c-wmt.c
@@ -117,7 +117,7 @@ static int wmt_i2c_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, err,
 				"failed to request irq %i\n", i2c->irq);
 
-	i2c->clk = of_clk_get(np, 0);
+	i2c->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
 				     "unable to request clock\n");
-- 
2.34.1

