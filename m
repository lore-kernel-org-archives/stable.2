Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A53550DB8;
	Thu, 17 Sep 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653077; cv=none; b=p06ci6ECgQPdvRDHlMNC5Hu8Yu+bOG2DIjeZoafqKbwShddWKm3BIKlyxMCcqKCHTjRiSP+etXWgQkD0s9hjcVX0Al/AJ7a2YvPN7SS1yxTsG5BlcIApmt2rXucEHcKPA4ew+V41KQ1Q0zYF06UPYTU/Xdv3G9Soo/d1AyR69Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653077; c=relaxed/simple;
	bh=2J5bZxukR9tbNyaJCwh8S4sqVN91J9aLphwIb/SiwuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G1PuEs2m+dw3rtq0F0d02vyxI1KU8CBeX9UsdH4ZSuIVA22UH2g8tlJylQSdfjA5lkJYirfT2oDS3JPm+0HJUm1sv9YzvHduhZWXH2V0WVgLrapzkVroNUpjQ1/qcqwkHwkDgdcI/JQNWMqLuDWvfN9bIizmujEh+cUniAeTWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3pkBA8Ktq19GBCA--.3971S2;
	Thu, 17 Sep 2026 21:50:56 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexandre.torgue@foss.st.com
Cc: antonio.borneo@foss.st.com,
	jiashengjiangcool@gmail.com,
	linusw@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	zmw12306@gmail.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] pinctrl: stm32: Fix clock reference leak in stm32_pctl_probe()
Date: Thu, 17 Sep 2026 13:50:56 +0000
Message-Id: <20260917135056.2153959-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3pkBA8Ktq19GBCA--.3971S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyxuF1UJF4rXF48tr47Arb_yoW8Cr18pF
	ZxtFWYkw4DG3yFk34DJw1UXF9aga1IyFyDGa95Ka4xWF1YyF9rtw4rJ34avFs0kFZ5X3s8
	tF47tFy5Aa18ZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMx
	AIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x
	07UZSdgUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYNA2qrq3bUxAAAsC

stm32_pctl_probe() obtains one clock per bank with
of_clk_get_by_name(), but none of the error paths drop those
references: the loop returns directly when a later clock lookup fails,
and both the clk_bulk_prepare_enable() failure and the err_register
path return without calling clk_bulk_put().  clk_bulk_disable_unprepare()
only disables the clocks, it does not release them.

Release the references on these paths; the success path keeps them as
the driver needs them for suspend/resume.

Fixes: 451bc9aea9a1 ("pinctrl: stm32: Add check for clk_enable()")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 6a99708a5a23..587dbf1512dc 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1976,6 +1976,7 @@ int stm32_pctl_probe(struct platform_device *pdev)
 		pctl->clks[i].clk = of_clk_get_by_name(np, NULL);
 		if (IS_ERR(pctl->clks[i].clk)) {
 			fwnode_handle_put(child);
+			clk_bulk_put(i, pctl->clks);
 			return dev_err_probe(dev, PTR_ERR(pctl->clks[i].clk),
 					     "failed to get clk\n");
 		}
@@ -1986,6 +1987,7 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	ret = clk_bulk_prepare_enable(banks, pctl->clks);
 	if (ret) {
 		dev_err(dev, "failed to prepare_enable clk (%d)\n", ret);
+		clk_bulk_put(banks, pctl->clks);
 		return ret;
 	}
 
@@ -2010,6 +2012,7 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	}
 
 	clk_bulk_disable_unprepare(banks, pctl->clks);
+	clk_bulk_put(banks, pctl->clks);
 	return ret;
 }
 EXPORT_SYMBOL(stm32_pctl_probe);
-- 
2.34.1

