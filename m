Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288531F91F6;
	Tue, 15 Sep 2026 04:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447836; cv=none; b=DVgqe0a4/BfM6Qpkom9Ue99PHptsO3gNG61HJYo5qtfmLNzlRo/gP1TAhAIb88jckJim6d9AAm0mJgpeYDz5VIgxo2TreQfYKHHkEQ+V9+bZv9MhZmpItYb63HzCh919BVAxo2wrTPWolf8AV+OvT0gC7SkXC16pCW7vTXxmvaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447836; c=relaxed/simple;
	bh=2Icb5uM80dKZA+gLNYd5HXR42EUBP0K7T68BBNTxNCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fvylYHv5zW41+dKxVPMSsqwNL+nK+rkk8L1yVE4VeadZAlLL/q0Ojj27HJL2M1xm+OMCF1/c9cMzuXy6TwYBz+mhAiojTp0fpnggr0tqNUCr2SQDPXcjyxiIp3g765oaRT4fHB29gCqoDLVRQYhG0NVoiclEONKZCmXuTMXo1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADHn_OUzqhqCREJCA--.50396S2;
	Tue, 15 Sep 2026 12:50:28 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: daniel.lezcano@kernel.org
Cc: krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rempel-privat.de,
	tglx@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clocksource/drivers/asm9260: Fix clk reference leak in error paths
Date: Tue, 15 Sep 2026 04:49:59 +0000
Message-Id: <20260915044959.1726508-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHn_OUzqhqCREJCA--.50396S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4ktF45WF43Cr13GFW3Jrb_yoW8GFWUpw
	s7GrW5tr1rur4I9F4vqr4vyr95tw4jkFy3Ww4Sk3Z5ZrsxJFyUXayrGry29F4DArs5Zw43
	tFn5AFykZ3WDAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU78u4UU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRULA2qowd0lzwABsh

asm9260_timer_init() obtains a clock reference with of_clk_get() but
never calls clk_put(). If clk_prepare_enable() fails, the reference is
leaked directly, and if request_irq() fails the error path only calls
clk_disable_unprepare(), which releases the prepare/enable state but not
the reference obtained from of_clk_get().

Add the missing clk_put() calls on both error paths so the clock
reference is no longer leaked. The success path keeps the clock enabled
for the lifetime of the timer and is left untouched.

Fixes: 8d8bd7be8bf0 ("ARM: clocksource: Add asm9260_timer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/asm9260_timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/asm9260_timer.c b/drivers/clocksource/asm9260_timer.c
index 8f97ab0b01ec..f0ba19c9e0cf 100644
--- a/drivers/clocksource/asm9260_timer.c
+++ b/drivers/clocksource/asm9260_timer.c
@@ -202,6 +202,7 @@ static int __init asm9260_timer_init(struct device_node *np)
 	ret = clk_prepare_enable(clk);
 	if (ret) {
 		pr_err("Failed to enable clk!\n");
+		clk_put(clk);
 		return ret;
 	}
 
@@ -211,6 +212,7 @@ static int __init asm9260_timer_init(struct device_node *np)
 	if (ret) {
 		pr_err("Failed to setup irq!\n");
 		clk_disable_unprepare(clk);
+		clk_put(clk);
 		return ret;
 	}
 
-- 
2.34.1

