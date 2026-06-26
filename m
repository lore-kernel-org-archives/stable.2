Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ACF165F16;
	Fri, 26 Jun 2026 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475308; cv=none; b=rfrjqt0qU4hIa7AY44JPDUawHg73VN6FELVZJ0VI6Jr534De5QqMWFJQvPsxYmYy2rW8mVRpLDDbaWb9Jlc5cUdzm7SHM24Z1pMzwCIgMCneDRyutfrvoMkDlLftYsl1cR5gJDReMBhzmrlK5D8jHAmTiX/6qlGigfCGFlCds+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475308; c=relaxed/simple;
	bh=mf38q0Ou23iUnjIUG+hZxNzkSfFNlrRSz4KKGcq13Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I72usuHWckhqIftsP9WaAQU8EhMO0za5/zUavsCYCS/4/Z51Dec1hxy2cWbMzGSVhIFkZQQLF3laO5upzWu2Y2Fn4vLUFkO/N4sXkYeQ3RHr79Lzc1k9lu2JZydExg1jHM39wj+GdcLqxO4RAS5sVlekqMV7h61/N3QkCBeNIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowAAngNMgaj5q5xZnFQ--.22291S2;
	Fri, 26 Jun 2026 20:01:39 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: krzk@kernel.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: alim.akhtar@samsung.com,
	bmasney@redhat.com,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: clk/samsung: exynos_clkout_probe: success path leaks parent clock   references from of_clk_get_by_name
Date: Fri, 26 Jun 2026 20:01:35 +0800
Message-Id: <20260626120135.34173-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAngNMgaj5q5xZnFQ--.22291S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWxAFy3JrWkGrW3CF45KFg_yoWkAFg_CF
	1FgFnrCry5GrnrCF1kCry5CFZIkr9a9Fn5XFWIy398A347uF17Zr4F9wnIyw1jgw48XFZ8
	G3Zrur48ur1SvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUoWlkDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCREKA2o+TZNWugAAs3

of_clk_get_by_name() acquires clock references stored in the local
  parents[] array. All error paths correctly release these via the clks_put
  label, but the success path returns 0 without releasing the parent
  references. The references were only needed to obtain clock names for
  registration and are permanently leaked after probe completes.

Cc: stable@vger.kernel.org
Fixes: 9484f2cb8332 ("clk: samsung: exynos-clkout: convert to module driver")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/clk/samsung/clk-exynos-clkout.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index 5b21025338bd..ee3048d36040 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -190,6 +190,10 @@ static int exynos_clkout_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_unreg;
 
+	for (i = 0; i < EXYNOS_CLKOUT_PARENTS; ++i)
+		if (!IS_ERR(parents[i]))
+			clk_put(parents[i]);
+
 	return 0;
 
 err_clk_unreg:
-- 
2.39.5 (Apple Git-154)

