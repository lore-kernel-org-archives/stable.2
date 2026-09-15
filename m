Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F8E3C13E5;
	Tue, 15 Sep 2026 05:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789448612; cv=none; b=BlBw4lStgAgf3FBVP9TE6boE1JstFIIl40WhfZUS9D1MxVvf6A7nVhc1YJMku72D8kVZa9URwWKvZoEHzfxgfO/25iiaHjvstUwYp/VMcW4Ua5SGiSb1iuORefM2wJKkpM6F9Fm4SjxsmhiwzJvuCc/k9OAW24R9NIN5MG2BrQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789448612; c=relaxed/simple;
	bh=KPSAoiFMaDBr4il6tnjSVlW6fQ31q9gr8sV29+pyb8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bxdrq4XLbb0SFfRodYFU1NPT0USMU7gd68wdA82K3YF5w8TyXl9LfULm6Tl6L8oQqlPg6rxQ5MGBTGaC+WrNdBnEB8/KQFiJdDvlBXhkfgsLgvneH4JcTfQ++QXHwAMWYjSIH+Bxi/q8CD2apigGxaW4T0UPBGlk0T2czfycMoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowACnfPCf0ahqS1QJCA--.60131S2;
	Tue, 15 Sep 2026 13:03:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Li.Xiubo@freescale.com
Cc: daniel.lezcano@kernel.org,
	linux-kernel@vger.kernel.org,
	tglx@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clocksource/drivers/timer-fsl-ftm: Fix clk reference leak in error paths
Date: Tue, 15 Sep 2026 05:02:58 +0000
Message-Id: <20260915050258.1727196-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnfPCf0ahqS1QJCA--.60131S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4xJF4ktw4rGw4kKFy3urg_yoW5GrWrpr
	4fGw45tFW8G3ykKFn3tFWDAF9akrWIkFy7G3yfGas7Cws3ZFy3JF48Jry8uF4Yyr97X3yS
	qFWUAFyDuF1UurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOM
	KuUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAILA2qowzM1XgAAsf

__ftm_clk_init() obtains clock references with of_clk_get_by_name() but
never releases them on the error paths. If clk_prepare_enable() fails on
the counter clock, the reference is leaked. The second of_clk_get_by_name()
also overwrites the first clk pointer, so a failure to get or prepare the
ftm clock loses the counter clock reference as well; on the get failure
path the counter clock is left enabled and unreferenced.

Release the references on the error paths: clk_put() when prepare+enable
fails, and clk_disable_unprepare() followed by clk_put() when aborting
after the counter clock has been enabled. The clocks intentionally stay
enabled on the success path, so those are left untouched.

Fixes: 2529c3a33079 ("clocksource: Add Freescale FlexTimer Module (FTM) timer support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/timer-fsl-ftm.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
index 4eed6cb46132..8ada0c3e088a 100644
--- a/drivers/clocksource/timer-fsl-ftm.c
+++ b/drivers/clocksource/timer-fsl-ftm.c
@@ -230,7 +230,8 @@ static int __init ftm_clocksource_init(unsigned long freq)
 static int __init __ftm_clk_init(struct device_node *np, char *cnt_name,
 				 char *ftm_name)
 {
-	struct clk *clk;
+	struct clk *clk, *ftm_clk;
+	unsigned long rate;
 	int err;
 
 	clk = of_clk_get_by_name(np, cnt_name);
@@ -242,20 +243,28 @@ static int __init __ftm_clk_init(struct device_node *np, char *cnt_name,
 	if (err) {
 		pr_err("ftm: clock failed to prepare+enable \"%s\": %d\n",
 			cnt_name, err);
+		clk_put(clk);
 		return err;
 	}
 
-	clk = of_clk_get_by_name(np, ftm_name);
-	if (IS_ERR(clk)) {
-		pr_err("ftm: Cannot get \"%s\": %ld\n", ftm_name, PTR_ERR(clk));
-		return PTR_ERR(clk);
+	ftm_clk = of_clk_get_by_name(np, ftm_name);
+	if (IS_ERR(ftm_clk)) {
+		pr_err("ftm: Cannot get \"%s\": %ld\n", ftm_name,
+			PTR_ERR(ftm_clk));
+		clk_disable_unprepare(clk);
+		clk_put(clk);
+		return PTR_ERR(ftm_clk);
 	}
-	err = clk_prepare_enable(clk);
-	if (err)
+	err = clk_prepare_enable(ftm_clk);
+	if (err) {
 		pr_err("ftm: clock failed to prepare+enable \"%s\": %d\n",
 			ftm_name, err);
+		rate = clk_get_rate(ftm_clk);
+		clk_put(ftm_clk);
+		return rate;
+	}
 
-	return clk_get_rate(clk);
+	return clk_get_rate(ftm_clk);
 }
 
 static unsigned long __init ftm_clk_init(struct device_node *np)
-- 
2.34.1

