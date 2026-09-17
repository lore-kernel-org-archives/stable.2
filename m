Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027B5947EF;
	Thu, 17 Sep 2026 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655457; cv=none; b=JLLcR+/a40pi40rsDAzUqleMyUn/5B9KhuqpEbafTgB1HHEY+RZEpUgk+uC2IM1JgS6eyB9T7so2bcfGkGttmZ9CrqW/g69cYEbjea3r5Eii83xqQSlOwGml7v5KCFpYBcJuBqUA1Kh8meV01TQA1fjQH9zpTOwqW2d/+aocFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655457; c=relaxed/simple;
	bh=fZGkuAg+SHTorKzoWSifMKn+uVb3LimxRWweJKuKwyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eOoEOGyvuvI+xMv4wfcr4cZwz5APo0nH/UtTH0W7LMMIq/q7/bFIi1occFqgVSCaQh0ZWFVm7Qua7JvbRH2lS6Z4OBDWAJzd7njQG+Smkz/49pjs2Gi7HxrCEtRov3362krQbDrt5ZauUb1bMU9SaY4HzvvmGutFvujsJiank+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACH7zmc+atqkoCCCA--.4742S2;
	Thu, 17 Sep 2026 22:30:52 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	m.purski@samsung.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] regulator: core: Fix coupled regulators reference leak on removal
Date: Thu, 17 Sep 2026 14:30:52 +0000
Message-Id: <20260917143052.2156903-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACH7zmc+atqkoCCCA--.4742S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFWUGw18KF1DtF43uw1rWFg_yoWDtFX_Gr
	1rJFyxG393ZF48Cr1xWF1q9r9xZF1DKa93X3ykKFW3GFW7ZF1UZ347Ary3Cw47XwsrJF9r
	Xr17Wr4UZwnxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7IU1mLvtUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAANA2qr9nAG4wABsh

of_parse_coupled_regulator() returns the coupled regulator with its
device reference incremented and regulator_resolve_coupling() stores it
in coupling_desc.coupled_rdevs[]. regulator_remove_coupling() clears
those pointers without dropping the references, so they are leaked when
the couple is torn down.

Release the reference of each coupled regulator while removing the
coupling.

Fixes: d3d64537c339 ("regulator: core: Resolve coupled regulators")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/regulator/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 31893c7decd5..59506547458e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5891,6 +5891,8 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
 
 		c_desc->coupled_rdevs[i] = NULL;
 		c_desc->n_resolved--;
+
+		put_device(&c_rdev->dev);
 	}
 
 	if (coupler && coupler->detach_regulator) {
-- 
2.34.1

