Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8FD3876C3;
	Fri, 26 Jun 2026 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489715; cv=none; b=lYQC1w3eZzrTTSkUMq304RAWyk0xtmVtFqTTJu0QV8kgHALtmmVp6r+Mlcg5WjxPMtQXb+0O38D9l6wdL0RSFMpnjW/Jz4pid21+hWKE2nuKMD7AlzNX7YbsLCcYMP2j1f0DVWusTH+DkYwNExx9lgUM2bZd0Ng5f9gETaLVflI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489715; c=relaxed/simple;
	bh=QFGIecKsQZQQK07v8YhETfcedxa9yTcZtT7zwHNdpXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OxiGPhreBnFk9OVqv0IWmBFjhsXif8iuANEgc5T5wkwcRC7qjCLw8I5R6gCWOpVwbVOjidwJtd34UUeBurFnPn3ot4MWcNUhi3xtyAYMM71O9ZWNPQnyK2/xEOkalS5qWqVVTK8G0YA1klxs7R8hvACvwUOx5ig1vB7y7x2RS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAA33NRuoj5qUEVtAw--.19285S2;
	Sat, 27 Jun 2026 00:01:51 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: regulator: as3722_get_regulator_dt_data: fix premature of_node_put   leaving dangling of_node pointer
Date: Sat, 27 Jun 2026 00:01:50 +0800
Message-Id: <20260626160150.54291-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA33NRuoj5qUEVtAw--.19285S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1Dtw1rCw48WF4UGF13CFg_yoWktFc_Kr
	yfXF1xWrsrur4kGr1IgF9Iyr9xAF1qqayfZF4xKFW3A347AF15Jw43Cr9rA3yUZ3y7Gw1k
	Xr17Ar4DAw1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUDpnQUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIKA2o+ids+4AAAsf

In as3722_get_regulator_dt_data(), of_get_child_by_name() acquires a
reference on np, which is then assigned to pdev->dev.of_node. The
function immediately calls of_node_put(np), releasing the reference and
leaving pdev->dev.of_node as a dangling pointer.

Remove the of_node_put(np) call to let the device hold the reference.

Cc: stable@vger.kernel.org
Fixes: bc407334e9a6 ("regulator: as3722: add regulator driver for AMS AS3722")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/regulator/as3722-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/as3722-regulator.c b/drivers/regulator/as3722-regulator.c
index da378bfdba40..85e2aaa1a06b 100644
--- a/drivers/regulator/as3722-regulator.c
+++ b/drivers/regulator/as3722-regulator.c
@@ -600,7 +600,6 @@ static int as3722_get_regulator_dt_data(struct platform_device *pdev,
 
 	ret = of_regulator_match(&pdev->dev, np, as3722_regulator_matches,
 			ARRAY_SIZE(as3722_regulator_matches));
-	of_node_put(np);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Parsing of regulator node failed: %d\n",
 			ret);
-- 
2.39.5 (Apple Git-154)

