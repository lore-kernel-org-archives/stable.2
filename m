Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344B36A36C;
	Tue, 15 Sep 2026 05:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449344; cv=none; b=nymyeQfzxUYLcYVxjrKkyRfYvaYn51h+SCskgbbTsZHIko2pA9MhL5bUX+5hLmBRxVOWv22EhYf99D8MOSKdJXx6BJq32h+qsuNiAt/hfgwCsPHFk3t/zoZwElmGp8Hd4QEvI4njC0ibn1wXLs5yS4DCAFQY8vU9Pa2ffC3H/fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449344; c=relaxed/simple;
	bh=Nbmp2JDyoUViPq1n+5+A0voJuww7yh2jah0XM10O2fw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oNYsNBkI2TpXqD3w+/OJfdUBRuX6H9NA8ZAnJAGGneioiN4m9pPTarLNfNHZtZUaWD9FaB4b+aY+KGHvqFChYQIfQGBsl4uvNFDDpIbjIfibdkvlSQxUtZR8gaI3oqlf4MiSYxdlK+O4kSg0rTAWy5I3hj/lHcRduIZ72XBrojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADnu+931KhqNooJCA--.40089S2;
	Tue, 15 Sep 2026 13:15:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: bcm-kernel-feedback-list@broadcom.com
Cc: daniel.lezcano@kernel.org,
	florian.fainelli@broadcom.com,
	linux-kernel@vger.kernel.org,
	markus.mayer@linaro.org,
	matt.porter@linaro.org,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	tglx@kernel.org,
	tim.kryger@linaro.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/6] clocksource/drivers/bcm_kona: Fix clock reference leak in kona_timer_init
Date: Tue, 15 Sep 2026 05:15:07 +0000
Message-Id: <20260915051507.1727578-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnu+931KhqNooJCA--.40089S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyUGFyfAry3GFW7uw1kGrg_yoW8GF4kpr
	Z7G3WYyF1UZrWj9a1DtF1vyFyvya12yFy7Krn3CasFvw43ta47JFWUXFyDXF4jyFWkZwnr
	t3WrJFs7AF1UZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUwFApDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgkLA2qowR1GowAAs8

kona_timer_init() looks up the timer clock with of_clk_get_by_name(),
which takes a reference on the clock. On success the driver only reads
the rate and prepares/enables the clock, and the clock is meant to stay
enabled for the lifetime of the timer, but the pointer is a local
variable that is lost when the function returns and clk_put() is never
called, leaking the consumer reference on every boot.

Drop the reference with clk_put() right after the clock has been
prepared and enabled; this keeps the clock running while releasing the
reference.

Fixes: ad037c1f4ae6 ("clocksource: Kona: Print warning rather than panic")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/bcm_kona_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
index 39f172d7e29e..9768b62725ba 100644
--- a/drivers/clocksource/bcm_kona_timer.c
+++ b/drivers/clocksource/bcm_kona_timer.c
@@ -160,6 +160,7 @@ static int __init kona_timer_init(struct device_node *node)
 	if (!IS_ERR(external_clk)) {
 		arch_timer_rate = clk_get_rate(external_clk);
 		clk_prepare_enable(external_clk);
+		clk_put(external_clk);
 	} else if (!of_property_read_u32(node, "clock-frequency", &freq)) {
 		arch_timer_rate = freq;
 	} else {
-- 
2.34.1

