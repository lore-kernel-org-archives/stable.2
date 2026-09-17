Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AAE583ADE;
	Thu, 17 Sep 2026 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655520; cv=none; b=eSc5sO7dyVonkTPR4Z/9RbDu8WswyKSDnLyqTvrS84zZ87mpsGDa3Ow99L3RHi5zWh/+vREePUfldrYTyKcaZpKLTOMCCVBZ8L3CmODQjBzoHa8OV8MI6kFSBlUo+aqN5D2kbh4Tg94p+a/qrev528bIw5ulNWiINbGhiHQAj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655520; c=relaxed/simple;
	bh=3iREv8eYmErGuk6pqVC2ANSpPFGU4rAX2RqCqRmuUs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QGEnhBKUC+obTDT1NhbCCUO44Vt9L+1nX6DADxHj3fz0M75OODsP6gHUcGWQWXZmvlqibXr/v5EuIq7J2GLJPNkEQkAqH3REQsl1bps/jU4NUUSWanHJpQUT6qdJV6VEHWWIMK5pKFFi2OYnltVnR3xMgPYSgHEWY0fZh6gbVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABn0Tvb+atqN4WCCA--.4787S2;
	Thu, 17 Sep 2026 22:31:55 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: eblanc@baylibre.com,
	jneanne@baylibre.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] regulator: tps6594-regulator: Fix np_pmic_parent leak in tps6594_regulator_probe()
Date: Thu, 17 Sep 2026 14:31:55 +0000
Message-Id: <20260917143155.2156974-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn0Tvb+atqN4WCCA--.4787S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr17Jw47AF1xtr4UZry8AFb_yoW8WF1Up3
	98CF9rCrW8Gr4xKanxCrnIya4agF4ay3yxAFyxt3WfZrs8JF13tr1DZrW5AFn5tFykCr4Y
	vrWqvrWxXFyruFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwCY
	1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48Zr
	WUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aV
	CY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxUzJ5rUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUNA2qr9LYL1QAAsP

tps6594_regulator_probe() takes a reference on the PMIC parent node
with of_get_parent(), but never drops it, so the reference leaks on
every loop iteration and on each error return of the probe.

Release the reference after its last use.

Fixes: f17ccc5deb4d ("regulator: tps6594-regulator: Add driver for TI TPS6594 regulators")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/regulator/tps6594-regulator.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index 645e83462c64..e0ae2cac0b66 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -673,8 +673,10 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 		np = of_find_node_by_name(tps->dev->of_node, multi_regs->supply_name);
 		npname = of_node_full_name(np);
 		np_pmic_parent = of_get_parent(of_get_parent(np));
-		if (of_node_cmp(of_node_full_name(np_pmic_parent), tps->dev->of_node->full_name))
+		if (of_node_cmp(of_node_full_name(np_pmic_parent), tps->dev->of_node->full_name)) {
+			of_node_put(np_pmic_parent);
 			continue;
+		}
 		if (strcmp(npname, multi_regs->supply_name) == 0) {
 			switch (multi) {
 			case MULTI_BUCK12:
@@ -706,6 +708,8 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 				break;
 			}
 		}
+
+		of_node_put(np_pmic_parent);
 	}
 
 	reg_irq_nb = desc->num_irq_types * (desc->num_buck_regs + desc->num_ldo_regs);
-- 
2.34.1

