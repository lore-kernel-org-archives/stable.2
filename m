Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC523911D5;
	Tue, 15 Sep 2026 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449887; cv=none; b=N2X9xAd62/+evUC7bNJhiVK3ZZKj0Bp/Cim5zF43MbWIlLzIKBZJL7zngnOXLn9KhjofJd1yiHW43tjd+7cXoiwbGRJCSdIeAiwJwquNJ2+2IkousmnWgpLQm+ZmsfoIHJmQNnBpv5TJjf327KgOOs7m0NsSCVnZEi/EVj8brwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449887; c=relaxed/simple;
	bh=giTRg5eqA8WY0f9RYZoUFP/OVlQXn8c5ArDoHAP4x9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TLCoycSNF/gPyFdlipFCumJ6y/Ud+zxd1ffzBvBQOe/qr4tThZO2Qcj297Mb9FTDNyVdIAMiddbmYq6OIy4S23i8J85nGyHwAWhg80FPiAIGCu81d+uL6Ov/BHzcy8hSoNOfxJljiasRH8GIgJSjdkC/BYGxsBJNTfHwS1bAH+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADnu++X1qhqYrYJCA--.40195S2;
	Tue, 15 Sep 2026 13:24:39 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: daniel.lezcano@kernel.org
Cc: ezequiel.garcia@imgtec.com,
	govindraj.raja@imgtec.com,
	linux-kernel@vger.kernel.org,
	tglx@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 6/6] clocksource/drivers/pistachio: Fix clock reference leaks in pistachio_clksrc_of_init
Date: Tue, 15 Sep 2026 05:24:10 +0000
Message-Id: <20260915052410.1728134-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnu++X1qhqYrYJCA--.40195S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW7ur45Ww4rJFy7Xr4xJFb_yoW5Cr47pr
	Z3Jw4Fvr4IqrWI9Fsxtr4kAr9Yyw4vyFy3WrWfG3WkurnxAry8AFW0vFyUZF4Ykrs3Cwsr
	Z3WrGFykCF45uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	LiSJUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgLA2qowpBHGgAAsK

pistachio_clksrc_of_init() looks up the sys and fast clocks with
of_clk_get_by_name(), which takes a reference on each clock, but no
clk_put() exists anywhere in the driver. Both references are leaked on
several paths:

- if the "fast" clock lookup fails, the reference on the already
  obtained "sys" clock is leaked;
- if clk_prepare_enable() fails for the "sys" clock, its reference is
  leaked;
- if clk_prepare_enable() fails for the "fast" clock, the "sys" clock is
  disabled and unprepared but neither reference is dropped;
- if clocksource_register_hz() fails, both clocks stay prepared and
  enabled and both references are leaked;
- on success both clocks stay enabled but the local pointers are lost
  and both references are leaked.

Add proper error unwinding with clk_disable_unprepare() plus clk_put()
where the clocks were enabled, clk_put() where they were not, and on
success drop both references while keeping the clocks enabled for the
clocksource.

Fixes: 84583983c319 ("CLOCKSOURCE: Add Pistachio clocksource-only driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/timer-pistachio.c | 28 ++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-pistachio.c b/drivers/clocksource/timer-pistachio.c
index 57b2197a0b67..8749230453f8 100644
--- a/drivers/clocksource/timer-pistachio.c
+++ b/drivers/clocksource/timer-pistachio.c
@@ -181,20 +181,22 @@ static int __init pistachio_clksrc_of_init(struct device_node *node)
 	fast_clk = of_clk_get_by_name(node, "fast");
 	if (IS_ERR(fast_clk)) {
 		pr_err("clock get failed (%lu)\n", PTR_ERR(fast_clk));
+		clk_put(sys_clk);
 		return PTR_ERR(fast_clk);
 	}
 
 	ret = clk_prepare_enable(sys_clk);
 	if (ret < 0) {
 		pr_err("failed to enable clock (%d)\n", ret);
+		clk_put(sys_clk);
 		return ret;
 	}
 
 	ret = clk_prepare_enable(fast_clk);
 	if (ret < 0) {
 		pr_err("failed to enable clock (%d)\n", ret);
-		clk_disable_unprepare(sys_clk);
-		return ret;
+		clk_put(fast_clk);
+		goto disable_sys_clk;
 	}
 
 	rate = clk_get_rate(fast_clk);
@@ -210,7 +212,27 @@ static int __init pistachio_clksrc_of_init(struct device_node *node)
 
 	raw_spin_lock_init(&pcs_gpt.lock);
 	sched_clock_register(pistachio_read_sched_clock, 32, rate);
-	return clocksource_register_hz(&pcs_gpt.cs, rate);
+	ret = clocksource_register_hz(&pcs_gpt.cs, rate);
+	if (ret)
+		goto disable_clks;
+
+	/*
+	 * Both clocks are intentionally left enabled for the clocksource;
+	 * only drop the consumer references taken by of_clk_get_by_name().
+	 */
+	clk_put(fast_clk);
+	clk_put(sys_clk);
+
+	return 0;
+
+disable_clks:
+	clk_disable_unprepare(fast_clk);
+	clk_put(fast_clk);
+disable_sys_clk:
+	clk_disable_unprepare(sys_clk);
+	clk_put(sys_clk);
+
+	return ret;
 }
 TIMER_OF_DECLARE(pistachio_gptimer, "img,pistachio-gptimer",
 		       pistachio_clksrc_of_init);
-- 
2.34.1

