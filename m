Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5A1FB1;
	Tue, 15 Sep 2026 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449471; cv=none; b=C0YVf6oUBiai5Kbru9RkIkKAvtj+bHweKvl1ID5ZDyUus6RrFEOW7aYBE44z3MWNvCPz+ifYiYRksUZEtzgb8PZrzSSjFeECLA9FeOE3V5gBbyXmUG2Cm8in1Up9TOXzzs5FCYxGW4j95ri9lDw2YU6DQDQuv/s22OapuerrtIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449471; c=relaxed/simple;
	bh=V8uNPjis5PZWGe1w2pE64AvMTB3Dg2s0V6cgJK1APLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HmBx0RYOzak24P4RG8B/wI2NjkRd9o/FbgLh1KoxKcstu9x0AJDMrh4Jl9hpWmu1C/x/CezifGzVLPnONMnUPM5iFJtFoznAQiGF4m9IaZBHet95J4wpVuexVvehzWN8WB2wC4YVEW1pIzV1eeRie6gYdjG29GTJJ/6ySakbwSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAB3Su7z1KhqhJMJCA--.51114S2;
	Tue, 15 Sep 2026 13:17:40 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Frank.Li@nxp.com
Cc: daniel.lezcano@kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	s.hauer@pengutronix.de,
	shawn.guo@linaro.org,
	tglx@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/6] clocksource/drivers/mxs_timer: Fix clock reference leak in mxs_timer_init
Date: Tue, 15 Sep 2026 05:17:11 +0000
Message-Id: <20260915051711.1727701-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3Su7z1KhqhJMJCA--.51114S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyUGFyUJw43ur17GFWkXrb_yoW5JF43pw
	s7W3y5tr1UXr4Sg3Wftr1qqF9xKayIkF9rGr1fG3Z7Ar43A34jyFyUJFyqq3WakrWkAw43
	Za1rJrs5CFyUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUr6wZDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAILA2qowzNBSAAAs9

mxs_timer_init() looks up the timer clock with of_clk_get(), which takes
a reference on the clock, but no clk_put() exists anywhere in the
driver. The reference is leaked on every return path after the clock
has been obtained:

- clk_prepare_enable() failure,
- mxs_clocksource_init() failure,
- mxs_clockevent_init() failure,
- irq_of_parse_and_map() failure,
- request_irq() failure,
- and on success, where the clock is intentionally left enabled for the
  timer but the local timer_clk pointer is lost.

Add proper error unwinding: on failure of clk_prepare_enable() only the
reference is dropped, on the later error paths the clock is disabled and
unprepared before the reference is dropped, and on success the reference
is dropped while keeping the clock enabled.

Fixes: 2efb950465e9 ("ARM: mxs: look up timrot clock from device tree")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/mxs_timer.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
index e52e12d27d2a..dd58d7505797 100644
--- a/drivers/clocksource/mxs_timer.c
+++ b/drivers/clocksource/mxs_timer.c
@@ -215,8 +215,10 @@ static int __init mxs_timer_init(struct device_node *np)
 	}
 
 	ret = clk_prepare_enable(timer_clk);
-	if (ret)
+	if (ret) {
+		clk_put(timer_clk);
 		return ret;
+	}
 
 	/*
 	 * Initialize timers to a known state
@@ -256,18 +258,32 @@ static int __init mxs_timer_init(struct device_node *np)
 	/* init and register the timer to the framework */
 	ret = mxs_clocksource_init(timer_clk);
 	if (ret)
-		return ret;
+		goto err_clk_disable;
 
 	ret = mxs_clockevent_init(timer_clk);
 	if (ret)
-		return ret;
+		goto err_clk_disable;
 
 	/* Make irqs happen */
 	irq = irq_of_parse_and_map(np, 0);
-	if (irq <= 0)
-		return -EINVAL;
+	if (irq <= 0) {
+		ret = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	ret = request_irq(irq, mxs_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			  "MXS Timer Tick", &mxs_clockevent_device);
+	if (ret)
+		goto err_clk_disable;
+
+	clk_put(timer_clk);
+
+	return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(timer_clk);
+	clk_put(timer_clk);
 
-	return request_irq(irq, mxs_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			   "MXS Timer Tick", &mxs_clockevent_device);
+	return ret;
 }
 TIMER_OF_DECLARE(mxs, "fsl,timrot", mxs_timer_init);
-- 
2.34.1

