Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0706654DADA;
	Thu, 17 Sep 2026 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652904; cv=none; b=qAdU5x5wwpsYoqJBTe+P+6GJXK9QozwGK/DPuxoWAnxUd8iOJyrUz77y1HMDs9ZROtF9gWkIr8Ih0eDLOGvPO3eeHXzhpuyEY2KUsOHMpqsAaHhUkE3boBFv15X9JtsSAr8achdK0406fRM+0eySwFQoDSDEN7xV1Moiq7fQE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652904; c=relaxed/simple;
	bh=FtoDbAwUNEAcVuzYKJWUIZPIEF5psBdBgH5jYE+cz/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lvj/iSlhmugF2A4KZzUzxnENONWczLckdUrJ9rfdd6rJhPm/kn3M4oR/B7mP9+12kPqbEbpenFrf4wMDPiB6ps+NqSeD0eQPToktoLOb12NjAFZWJGIn9Ngx7RXcGCB0WkrdW5xtWaG34o8kaTpjm8AdQsdjgadDqq8gVZeD/+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3pkCb76tqlceBCA--.3932S2;
	Thu, 17 Sep 2026 21:48:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: linusw@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	schung@nuvoton.com,
	ychuang3@nuvoton.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] pinctrl: nuvoton: Fix clock reference leak in ma35_get_bank_data()
Date: Thu, 17 Sep 2026 13:48:11 +0000
Message-Id: <20260917134811.2153902-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3pkCb76tqlceBCA--.3932S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4xtF4xJr1fXF4fKF4Uurg_yoW8XF47pa
	9xKrWYkrW3JFWvy3yDA3yUAFy5Ka1Iyr1UK348Ka4vva13JFyUJFy5Ka48AF4vkrWrCr45
	Jr43AFyq9r45JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07UNTmhUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcNA2qrq3bTQQAAsB

ma35_get_bank_data() obtains the bank clock with of_clk_get() and
stores it in bank->clk, but returns clk_prepare_enable() directly.  If
that call fails, the reference taken by of_clk_get() is never dropped,
and the driver has no other clk_put() for it.

Drop the reference when clk_prepare_enable() fails.

Fixes: f805e356313b ("pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index f01344201628..c94c4adb2125 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -557,6 +557,8 @@ static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinct
 
 static int ma35_get_bank_data(struct ma35_pin_bank *bank)
 {
+	int ret;
+
 	bank->reg_base = fwnode_iomap(bank->fwnode, 0);
 	if (!bank->reg_base)
 		return -ENOMEM;
@@ -569,7 +571,11 @@ static int ma35_get_bank_data(struct ma35_pin_bank *bank)
 	if (IS_ERR(bank->clk))
 		return PTR_ERR(bank->clk);
 
-	return clk_prepare_enable(bank->clk);
+	ret = clk_prepare_enable(bank->clk);
+	if (ret)
+		clk_put(bank->clk);
+
+	return ret;
 }
 
 static int ma35_pinctrl_get_soc_data(struct ma35_pinctrl *pctl, struct platform_device *pdev)
-- 
2.34.1

