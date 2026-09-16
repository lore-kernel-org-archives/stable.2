Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10863BE636;
	Wed, 16 Sep 2026 07:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542260; cv=none; b=aUILrFmKwPslCWI4YITALcc+ohk0gjHChctRbIPggnRMEF5JTwwbj6sZw3F0X6zReLwv5SGY6i46k6CT9ePsu1dL4Zr3hrs+yA+8+Oa/wjYNAQ9LSb4fzqvCAjMVYVFtAHZw8g/TFYiG7qVhvdlZD+2fXX6uzIqnhym7ztdiZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542260; c=relaxed/simple;
	bh=tYP+ILLBw9ueJSyVg53mQrWsAzkBaWl+zWefcGU3EDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ur0dtdL2e5n5GsnoQ20eM/ujl5v+ussBCT6yyB3mbkT8KTfl3M5J7bmXnKB1Ad2fqfGmfnt8bgWzjRf9lELgViFviRqM2QMrqPjKKTz6YWxs/Oz1EqdKPLHEzXFhj7NNcCc4PWThPM0NJdatEdBVvYr1kPx1Ih0nKgD29Lx8w54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnrTtpP6pqFuXeBw--.40674S2;
	Wed, 16 Sep 2026 15:04:09 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: krzk@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	s.nawrocki@samsung.com,
	tiwai@suse.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 03/20] ASoC: samsung: snow: Fix clock leak in snow_probe()
Date: Wed, 16 Sep 2026 07:03:41 +0000
Message-Id: <20260916070341.1965422-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnrTtpP6pqFuXeBw--.40674S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4ftw18uFyxCrWxtw15XFb_yoWDCwc_K3
	yrWa95Wr9xGrZIg348G3yfAFs2qFs3CFWrCr1FqF17Ary7Xas0v392gFn3u3Z8Zw4fK3s8
	Xr1UZF4xCryakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggMA2qqPpQEjAAAsj

In snow_probe(), priv->clk_i2s_bus is acquired via of_clk_get_by_name().
If devm_snd_soc_register_card() subsequently fails, the acquired clock
is never released, leading to a reference count leak.

Add clk_put() on the error path to release the clock properly.

Fixes: aff8d2bed9e5 ("ASoC: samsung: Add HDMI audio support for Snow")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/samsung/snow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
index 66ef49dff1ba..ad99c153e9f8 100644
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -211,9 +211,11 @@ static int snow_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = devm_snd_soc_register_card(dev, card);
-	if (ret)
+	if (ret) {
+		clk_put(priv->clk_i2s_bus);
 		return dev_err_probe(&pdev->dev, ret,
 				     "snd_soc_register_card failed\n");
+	}
 
 	return 0;
 }
-- 
2.34.1

