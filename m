Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CD353A6B;
	Tue, 15 Sep 2026 05:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449621; cv=none; b=FttNv+9tDIU5pfllD/5JIO9Bm10VDJpVD3/RQED+6xp0YZTdeET4mUc2z6ufkDrGVGKyueptNVUWqZMIXnA6g4czeu/ECryxMFGLEl1DzQTZu44L2+nlOy0rCJxJIIxrAjSR2F+k/qXhIRIpjijloNyZ/mV99hnefoUNLD7dyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449621; c=relaxed/simple;
	bh=A/2Hh+XeVuRUQJ1Y/ryhFrna8+0yxL4UDZs1Mj9d27M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NEFrYf/8BCCaH9yoP0+4pvWA31cFpU5aT/ReU7hkzxOPc4ncqTdmMO7RplXX9ZNOTRdjt9pOWTPfLR8PAmBl1TW0xKuwztpPWcKuvJEhfjWoGycfVN1rtmvgwKwex9ltu8jTbDvaA/xnuDTmwxq97jdbfPQ7gzpne+Y+qp7X8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAAn_O+R1ahqpZ4JCA--.33311S2;
	Tue, 15 Sep 2026 13:20:17 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: brgl@kernel.org
Cc: daniel.lezcano@kernel.org,
	linux-kernel@vger.kernel.org,
	tglx@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 4/6] clocksource/drivers/davinci: Fix clock reference leak in of_davinci_timer_register
Date: Tue, 15 Sep 2026 05:19:48 +0000
Message-Id: <20260915051948.1727882-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAn_O+R1ahqpZ4JCA--.33311S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyUGFyUGr13uF4UZr4fZrb_yoW8Wr43pr
	s5Cw13tr1DXr42vr4vyF98AF93Kw42yry3CryxC3s2vrs8JryrtFW5XFyDuFW7ZF4kAw1f
	ta1rJan5ZryDZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUow
	IDDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQLA2qowd1GBwAAsK

of_davinci_timer_register() looks up the timer clock with of_clk_get(),
which takes a reference on the clock, and passes it to
davinci_timer_register(). That function enables the clock and keeps it
enabled for the lifetime of the timer, but it never takes ownership of
the reference and never calls clk_put(); only the error paths of
of_davinci_timer_register() dropped the reference, so on success the
reference obtained by of_clk_get() leaked.

Drop the reference unconditionally after davinci_timer_register()
returns: on failure the clock has already been disabled and unprepared
by davinci_timer_register(), and on success the clock stays enabled
while the consumer reference is released.

Fixes: 721154f972aa ("clocksource/drivers/davinci: Add support for clockevents")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/timer-davinci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index 16ee0687ef31..54700738fcd4 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -376,8 +376,11 @@ static int __init of_davinci_timer_register(struct device_node *np)
 	}
 
 	rv = davinci_timer_register(clk, &timer_cfg);
-	if (rv)
-		clk_put(clk);
+	/*
+	 * The clock is left enabled on success, but the consumer reference
+	 * taken by of_clk_get() is not needed anymore in either case.
+	 */
+	clk_put(clk);
 
 	return rv;
 }
-- 
2.34.1

