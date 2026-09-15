Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA363AA9E2;
	Tue, 15 Sep 2026 04:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447934; cv=none; b=dz9aG53IRIMdauo2hFOyTeUb6hFtEf7gb6HzTNMi+NVGiNz9pjgi1HWA9UDdpyzrJVLkDWJGavZ8wtnXcK/yR3gs/rtw4a1jZuwdt+dWzp0aFtE20OfySenMXNSxZoi5f46JvyzK1H151Vp28/F1ojkgsCRpCU81IQq9WOjwGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447934; c=relaxed/simple;
	bh=ruTOlUWRjC+XHH5P8xlcScCD8eqQ3g3XNdzFW2uRuKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mqsyNWCUF4ZAgTctPPqcEYExuZBfG7rK7IQi/XV3pNW3xpDOGsaL8sA0G387iWOWSxjM29FRYy8Gl8mpsnGaeFN8bPPgOizSlRNpS9e6rJ8ykh2/UviiXPvcgN0FP5SgvBfntOm5EzpPZBdArkM+ppyD/5fBuKSsU4Nuoj9Q0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADnvPDxzqhqoRoJCA--.51839S2;
	Tue, 15 Sep 2026 12:52:01 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexandre.belloni@bootlin.com
Cc: claudiu.beznea@tuxon.dev,
	daniel.lezcano@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nicolas.ferre@microchip.com,
	tglx@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clocksource/drivers/atmel-st: Fix sclk reference leak in error paths
Date: Tue, 15 Sep 2026 04:51:32 +0000
Message-Id: <20260915045132.1726602-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnvPDxzqhqoRoJCA--.51839S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWktF1kAFW8Jr43AF1xAFb_yoW8Zw1xp3
	yxK3yayr1kWayIgrsFvFWDJF9Yya9FkFyUGFWrKas7ZrsxJryUtFWfJr9FqFWUAF97Zw47
	try8tFn8uF18ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU19Xo7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAILA2qowzMrUAABsO

atmel_st_timer_init() obtains the slow clock with of_clk_get() but never
releases the reference on error. If clk_prepare_enable() fails the
reference is leaked directly, and if the clock rate is invalid or
clocksource_register_hz() fails the error paths return without disabling
or putting the already enabled clock.

Add the missing cleanup to the three error paths: clk_put() when
prepare+enable fails, and clk_disable_unprepare() followed by clk_put()
when aborting after the clock has been enabled. The success path keeps
the slow clock enabled for the lifetime of the system timer and is left
untouched.

Fixes: adbaf5254152 ("clocksource/drivers/atmel-st: Convert init function to return error")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/timer-atmel-st.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index 73e8aee445da..e333916f8236 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -222,12 +222,15 @@ static int __init atmel_st_timer_init(struct device_node *node)
 	ret = clk_prepare_enable(sclk);
 	if (ret) {
 		pr_err("Could not enable slow clock\n");
+		clk_put(sclk);
 		return ret;
 	}
 
 	sclk_rate = clk_get_rate(sclk);
 	if (!sclk_rate) {
 		pr_err("Invalid slow clock rate\n");
+		clk_disable_unprepare(sclk);
+		clk_put(sclk);
 		return -EINVAL;
 	}
 	timer_latch = (sclk_rate + HZ / 2) / HZ;
@@ -244,7 +247,14 @@ static int __init atmel_st_timer_init(struct device_node *node)
 					2, AT91_ST_ALMV);
 
 	/* register clocksource */
-	return clocksource_register_hz(&clk32k, sclk_rate);
+	ret = clocksource_register_hz(&clk32k, sclk_rate);
+	if (ret) {
+		clk_disable_unprepare(sclk);
+		clk_put(sclk);
+		return ret;
+	}
+
+	return 0;
 }
 TIMER_OF_DECLARE(atmel_st_timer, "atmel,at91rm9200-st",
 		       atmel_st_timer_init);
-- 
2.34.1

