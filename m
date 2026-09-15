Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42AD3911D5;
	Tue, 15 Sep 2026 05:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449803; cv=none; b=F33lLW7IeTocTB799l/PxkIukIivM4YN61a8wHW3bdtfrMOiJw/rJd2leOZP7Y/BEgbhpYr3smbaL93FCRY2LCtAAsmFuMyys9AxaSu/xwevpx3BfyxwKV2G9RK9JkWjbeSf8HGYfHZVhuZWqAnxT2kNGbywg0U3c1AEIqwQE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449803; c=relaxed/simple;
	bh=+H0uopGC3BxFryXHJ6Y0a8GI2zRroAW3DgkbzH6TvZg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oe1wh/z08ZbeU2rMxmPJjQLfA3y705dXBhurAd8mjqQ6VyE6nHcUA6yM5WLhhzXnHXt4CKKeiyhXJUo1au7EDuu6BlODb+tYWeWKxPRsI5fhJEybxwZB9vrUPUV8utZv+iy+AsqhnLoQzr2r/ZI9jgbm0wGzXayV481o4xuPwb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADnvPA91qhqN60JCA--.52285S2;
	Tue, 15 Sep 2026 13:23:09 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: afaerber@suse.de
Cc: daniel.lezcano@kernel.org,
	linux-actions@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mani@kernel.org,
	tglx@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 5/6] clocksource/drivers/timer-owl: Fix clock reference leak in owl_timer_init
Date: Tue, 15 Sep 2026 05:22:40 +0000
Message-Id: <20260915052240.1728019-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnvPA91qhqN60JCA--.52285S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4rJw1xZw4kArWxZFW8JFb_yoWkCFX_GF
	yIvF9rXrWrWFn3CanrZwnrZ39IkF1kZr18Wa9Fq343Ka4rtFyUua4Yvr15C3WxCa13KFyD
	ArZrC3y3ZwnrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUrrWFUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwELA2qowpBGEQAAsJ

owl_timer_init() looks up the timer clock with of_clk_get(), which takes
a reference on the clock, and only uses it to read the timer rate. The
pointer is a local variable that is lost on return and clk_put() is
never called, so the reference is leaked on the clocksource_mmio_init()
and request_irq() failure paths as well as on success.

Drop the reference with clk_put() right after the rate has been read,
which covers all the remaining paths since the clock is not used
afterwards.

Fixes: 4be78a86c506 ("clocksource: Add Owl timer")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/timer-owl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-owl.c b/drivers/clocksource/timer-owl.c
index ac97420bfa7c..fa347f430563 100644
--- a/drivers/clocksource/timer-owl.c
+++ b/drivers/clocksource/timer-owl.c
@@ -142,6 +142,7 @@ static int __init owl_timer_init(struct device_node *node)
 	}
 
 	rate = clk_get_rate(clk);
+	clk_put(clk);
 
 	owl_timer_reset(owl_clksrc_base);
 	owl_timer_set_enabled(owl_clksrc_base, true);
-- 
2.34.1

