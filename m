Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31753D525F;
	Tue, 15 Sep 2026 05:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789451058; cv=none; b=PKB/w149FIgPBJOIvxcB6VJ1ZY7dhHxlSKM0lP5lSbdct29yyVEM8VoIORnv1woIg44+44uVAPojn6mI5o74Jdaxuog61gf+LGjEQVlGwWjVxU6fQfZYGLwqrQ+npr2cUcqyB9nux3R2BIPnlP3WhgwtLfV4rvhYjpbIBHZnv6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789451058; c=relaxed/simple;
	bh=JxEGlL2Fe4sOoBlicNb9mbOHCZrVz3d/Ivv2x7t83n4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BON3uiYRdKGcJVMWghXNl2wD2otDgNCBhmffolMkl3FvnkqRjSydQLhocRxzo9y25hhgX1XmwEvaq5aytwtFTDOcc9RxSjRdTNOoxVEo1HdAuZ0P+PvQunC0SyZtSSP4zNp+IKVXpYd0oaJxD3RVHVu0d+Ug/kqWzQXoRFkyEk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowACneu4u26hq_QgKCA--.60433S2;
	Tue, 15 Sep 2026 13:44:14 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: daniel.lezcano@kernel.org
Cc: linux-kernel@vger.kernel.org,
	robert.jarzmik@free.fr,
	tglx@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clocksource/drivers/timer-pxa: Fix clock reference leak
Date: Tue, 15 Sep 2026 05:43:45 +0000
Message-Id: <20260915054345.1729471-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACneu4u26hq_QgKCA--.60433S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW3ur1kZFWfXw48ZrWxXrb_yoW8Wr18pr
	Z5CayYyr13Wr4Igw48tF4DJF9Ikw1xCFy7G3yFkF929rs3CryUAFW2vFyjvF4YkFs7uw43
	tr4Fy3WkuFyUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmhF3
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgALA2qowR1bvgAAs1

pxa_timer_dt_init() obtains the timer clock with of_clk_get() but never
releases the consumer reference: the clk_prepare_enable() failure path,
the irq_of_parse_and_map() failure path and the success path all return
without clk_put(), leaking the reference on each init attempt.

Call clk_put() on all three paths. The clock is left prepared and
enabled, so the timer behaviour is unchanged.

Fixes: ab5354c48d58 ("clocksource: pxa: Add device-tree support for PXA timer")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/timer-pxa.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-pxa.c b/drivers/clocksource/timer-pxa.c
index 7ad0e5adb2ff..8bb473b75b48 100644
--- a/drivers/clocksource/timer-pxa.c
+++ b/drivers/clocksource/timer-pxa.c
@@ -195,6 +195,7 @@ static int __init pxa_timer_dt_init(struct device_node *np)
 	ret = clk_prepare_enable(clk);
 	if (ret) {
 		pr_crit("Failed to prepare clock\n");
+		clk_put(clk);
 		return ret;
 	}
 
@@ -202,10 +203,14 @@ static int __init pxa_timer_dt_init(struct device_node *np)
 	irq = irq_of_parse_and_map(np, 0);
 	if (irq <= 0) {
 		pr_crit("%pOFn: unable to parse OS-timer0 irq\n", np);
+		clk_put(clk);
 		return -EINVAL;
 	}
 
-	return pxa_timer_common_init(irq, clk_get_rate(clk));
+	ret = pxa_timer_common_init(irq, clk_get_rate(clk));
+	clk_put(clk);
+
+	return ret;
 }
 TIMER_OF_DECLARE(pxa_timer, "marvell,pxa-timer", pxa_timer_dt_init);
 
-- 
2.34.1

