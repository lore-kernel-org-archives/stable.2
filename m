Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981135F5E1;
	Tue, 15 Sep 2026 04:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789448000; cv=none; b=aaSqT5dRAv+fd041QpWvHCLLSVdLUNeR416UEdw+O5Dx1bgp7Fa0+C3fK0HxWo0mRE9jR3X6EpFFjJ2CoiZ/ISQ+qz38GS1v3/l8kldP24qcy+xUXOf3NLLVfXR4YypNCyN4wq3Ea+5C8cgppP1t3XcYnysRIeKDMQIQTqbwWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789448000; c=relaxed/simple;
	bh=pXg8i2UaEwwMKzD5/ehVBYWTYFqhSZObxUXbB0d3YuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CytUuF5QI5kBakvPKYgvCdFTP8UylehlZvcIbNjs0b10GucvhaqugdNCCjZiQ/SPe2Rqwq0yGGvWV1KkhTx5Lv1oyD0iNp+2rtS+GFhblL2fEoNrDEiHIEd8xLG7tkz3ly8O9Mp8wKggPxeE51GlDMoCvAmy7CaM32r24gc1cJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAAH3vE3z6hqNCEJCA--.14367S2;
	Tue, 15 Sep 2026 12:53:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: baruch@tkos.co.il
Cc: daniel.lezcano@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tglx@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clocksource/drivers/digicolor: Fix clk reference leak on request_irq failure
Date: Tue, 15 Sep 2026 04:52:42 +0000
Message-Id: <20260915045242.1726702-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAH3vE3z6hqNCEJCA--.14367S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF4rZFyfCF17GFy3Jr4DCFg_yoWkZwc_Cr
	navF97JryrCFs8Gw4DZw13XwsF9Fs7ZFy8GrZ2vF13G348Ar13ur15Zrn5uF17Ww4aqFyD
	W39rCrWxArn7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUowIDDU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgALA2qowR0zwAAAsj

digicolor_timer_init() obtains the timer clock with of_clk_get() and
enables it, but the request_irq() failure path returns without releasing
the clock reference, leaking both the enable/prepare state and the
reference itself.

Disable and put the clock before returning on the request_irq() failure
path. The success path keeps the clock enabled for the lifetime of the
timer and is left untouched.

Fixes: 9b8bb7736b78 ("clocksource: Driver for Conexant Digicolor SoC timer")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/timer-digicolor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
index 559aa96089c3..46e0c329957a 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -190,6 +190,8 @@ static int __init digicolor_timer_init(struct device_node *node)
 			  &dc_timer_dev.ce);
 	if (ret) {
 		pr_warn("request of timer irq %d failed (%d)\n", irq, ret);
+		clk_disable_unprepare(clk);
+		clk_put(clk);
 		return ret;
 	}
 
-- 
2.34.1

