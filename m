Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696814;
	b=fFdy11JVjPOzev8/eSKEk8dATFeEJ37DWsHoWzAqUid3RxYUH6ZMsYtY0b7dYTZOhO5e
	 73VCf41K5S+1BmJ6DNohbAVuiWXZlVxaF7PM0vEimhwVQ3XblXFto/+WkRF+qsLkHCxQV
	 HsaYaziPapCO8zbrj7flQOdrZsrVy7OdgtUGpZCx72zmyDvHndvZ4U0LUMxFg2O0ZyRx1
	 Wfup80N4nk8L6LowKkfwrhI+ZKUpQGXiWeplFeK7baRX6W7YeJs3WCke1WceFRg4Wa9Ip
	 JA2Sr+oThQX6C7jubeKY2G1rHnf2QJeFSwSqKjHTZBt4QIh5dElQSyyval2fo19Sbsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696814;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=XOEYJGmIGDL8E6PA4Nkpk9qtz9s8zhGdrWi/akM3QSI=;
	b=ZLMkKYTslzhAAM+j4clAXJHDh8CyD+SeVW6W32PnnenoEZJZj8hps/28yjDYnHkSVI19
	 AkzcuLR+E6iUERwjlL8EpEsxxwGwii9NWLczWXQrGypgywALwFhiVPmzUfvlit0qH4F+X
	 ZGb87z5mA+2rFVIzFbsZ6LEpvXQfD8ndQXi0cN2sMP5HD3yMy5qWUzncuX9DuCTWUMnRb
	 PxWyTvIDFFQk4lu/FkewsNAnop7u9rw/dmXJFk/XVqm7NY3JcLVt/TMExviQOKzb0fuq+
	 6w6ewtM2A465n9211nxoMMw/zLdutgJ2yly8jt47MGS9Qi0usv/GWntahSIFr5HfuBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA973606A324;
	Tue,  3 Nov 2026 09:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA973606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHGJkkpOlq2+k6AA--.1851S2;
	Tue, 03 Nov 2026 17:06:44 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: exynos4-is: Release clocks if enabling the bus clock fails
Date: Tue,  3 Nov 2026 09:06:53 +0000
Message-Id: <20261103090653.1208652-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHGJkkpOlq2+k6AA--.1851S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr48Zry8Aw1DCF1DJr43ZFb_yoW8WF1kpF
	Z7JFZ3AFy5Xw1vq34Ut3W5ZF90y3WfJFy7urZxC34rZwn8ta9rA348Ca4UZFWqyFWIyay5
	Zry8tFZ7AFWYvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwAAA2rpnO4nhgAAsU

fimc_clk_get() acquires and prepares all of the FIMC clocks.  If the
subsequent clk_set_rate() or clk_enable() call on the bus clock fails,
fimc_probe() returns immediately without calling fimc_clk_put(), leaking
the clock references and leaving the clocks prepared.

Jump to a common cleanup label that releases the clocks on both failures.

Fixes: b71b56b264ae ("[media] s5p-fimc: Check return value of clk_enable/clk_set_rate")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/platform/samsung/exynos4-is/fimc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.c b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
index 57e573949e54..b36812ad25c0 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
@@ -977,11 +977,11 @@ static int fimc_probe(struct platform_device *pdev)
 
 	ret = clk_set_rate(fimc->clock[CLK_BUS], lclk_freq);
 	if (ret < 0)
-		return ret;
+		goto err_clk_put;
 
 	ret = clk_enable(fimc->clock[CLK_BUS]);
 	if (ret < 0)
-		return ret;
+		goto err_clk_put;
 
 	ret = devm_request_irq(dev, irq, fimc_irq_handler,
 			       0, dev_name(dev), fimc);
@@ -1012,6 +1012,7 @@ static int fimc_probe(struct platform_device *pdev)
 	fimc_unregister_capture_subdev(fimc);
 err_sclk:
 	clk_disable(fimc->clock[CLK_BUS]);
+err_clk_put:
 	fimc_clk_put(fimc);
 	return ret;
 }
-- 
2.34.1

