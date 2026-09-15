Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79243CE41;
	Tue, 15 Sep 2026 05:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789451758; cv=none; b=TXBqzwutZH2NzXQHH7g1bxThgusubigjD7VHtCUZpWbhCCxm7e1O3JWrxBc9LAwW5D3xWUQz5jrZYXXOE3m0luW+tvVVUtPD/IYSTUybto6er0YHf1yl9mL13+neWJwNcPqfhbPTar4L9VtuNrziHlheQw5EbSyCh3rj6NAS07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789451758; c=relaxed/simple;
	bh=+SAN+6WURDkBH1aCOPX6Ir2NoWeGrHF5jd7ZaeI1vrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u5eNwbI5BkwYYjS+hX+6fBJZvwJL0x2YSJrQAxUGwCNTo2CennpU+JWVtR8igvWJG3xpflwOWd7VcJlnyz0yPyP3gvBBaRdP/3Qq++VW6O9xfTvPsUX1myW37l5jM7ttsHjmmsrst+AOGkZZtpMPy6pfPHQWM+h1MT7N6v7RjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowACXau7g3ahq_UsKCA--.60407S2;
	Tue, 15 Sep 2026 13:55:44 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Frank.Li@nxp.com
Cc: abelvesa@kernel.org,
	aisheng.dong@nxp.com,
	bmasney@redhat.com,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mturquette@baylibre.com,
	peng.fan@nxp.com,
	s.hauer@pengutronix.de,
	sboyd@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clk: imx: Fix clock reference leak in imx_get_clk_hw_by_name()
Date: Tue, 15 Sep 2026 05:55:15 +0000
Message-Id: <20260915055515.1730145-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXau7g3ahq_UsKCA--.60407S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1UZFWkGFyruFW8ZF4DXFb_yoWkKwc_Gr
	WrWr92gF18GF1fJF1kCF17Za4SywsrZF10qayIv3y7JayY9FWUAr42qrn8JrW3WrWrKFyD
	urnrurZrCrZrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JULo7NUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRILA2qowd1hTgAAsi

imx_get_clk_hw_by_name() obtains a consumer clock with
of_clk_get_by_name(), extracts the hardware pointer with __clk_get_hw()
and returns it without ever calling clk_put(), leaking the consumer
reference on both return paths.

Extract the hardware pointer first and drop the clock reference with
clk_put() before returning.

Fixes: 3b315214e091 ("clk: imx: implement new clk_hw based APIs")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clk/imx/clk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index f38506830ccf..e113e30514fa 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -119,12 +119,16 @@ struct clk_hw *imx_obtain_fixed_of_clock(struct device_node *np,
 struct clk_hw *imx_get_clk_hw_by_name(struct device_node *np, const char *name)
 {
 	struct clk *clk;
+	struct clk_hw *hw;
 
 	clk = of_clk_get_by_name(np, name);
 	if (IS_ERR(clk))
 		return ERR_PTR(-ENOENT);
 
-	return __clk_get_hw(clk);
+	hw = __clk_get_hw(clk);
+	clk_put(clk);
+
+	return hw;
 }
 EXPORT_SYMBOL_GPL(imx_get_clk_hw_by_name);
 
-- 
2.34.1

