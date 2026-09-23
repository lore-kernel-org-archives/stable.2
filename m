Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29916475324;
	Wed, 23 Sep 2026 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153698; cv=none; b=Rf0n0XSkvABUk0u8SkW5nhob4+icSBpK8OKlYczIGogX/MD5b2wzKyhU0p/AK48nVGP8m8s3x1edbS8b2Tp3XLnZacUbxSyu4hKsGFqlvWOkF81xaIlJI/PNx3vWbIAhQHEURPm5fe2/WTTzBAASolrZVe2RTX/nzT+XgrIm+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153698; c=relaxed/simple;
	bh=SpI95p3FXYAUYKBkSzyrmk5qySayfT9zX1AUBpYiSIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gEnOraIClJvElr+ngq9xDiI3W1vapAAf2msbDu6fmKd4t1fzbGqpUrdg+Zjbt5JjnA90EmRNNKTm6kOT/bAdXOGNXys4L7sDXWEAH78epLt/DD7Kw/R7R/CO6SS/Qy1M+K5vqxwd2uUOkTFsbbvnHgRvTqc6DYSwt+JaaZWVI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBXUH_Lk7NqlyoxAQ--.6727S3;
	Wed, 23 Sep 2026 16:54:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgAXY8fLk7NqW12WBA--.34014S2;
	Wed, 23 Sep 2026 16:54:35 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] i3c: master: adi: free the IRQ before unregistering the master
Date: Wed, 23 Sep 2026 08:53:40 +0000
Message-Id: <20260923085340.490776-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgAXY8fLk7NqW12WBA--.34014S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?8KVjTwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI1FG/lD/lmE44/TuyE2gfu15RhSvlRqdn5iLMsVzzySkL90
	jme45YJaF+aFbzuszpKp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7CFWrWFy3tr4DWr1DJr1fAFc_yoW8ZFWrpa
	18K34Y9FWkJF4UAa1UGa15ZFy5Jw1a9ry7Kw43t3sFgr98JasYyryrJry8AF1fGrWkCF1Y
	yry5tw4Uu398ArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Xo7JUUUUU==

adi_i3c_master_irq() is requested with devm_request_irq(), so it stays
registered when adi_i3c_master_remove() runs, and the writes masking the
controller IRQ sources do not synchronize with a handler that is already
running on another CPU. i3c_master_unregister() then frees the
struct i3c_dev_desc objects that master->ibi.slots[] still point to, so
the IBI path in adi_i3c_master_handle_ibi() can dereference freed memory.

Fix this by storing the IRQ number in the private structure and calling
devm_free_irq() after the IRQ sources are masked, so a running handler
is finished before the master is torn down.

This issue was found by an in-house static analysis tool.

Fixes: a79ac2cdc91d ("i3c: master: Add driver for Analog Devices I3C Controller IP")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/i3c/master/adi-i3c-master.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i3c/master/adi-i3c-master.c b/drivers/i3c/master/adi-i3c-master.c
index 6380a38..9b0ee4e 100644
--- a/drivers/i3c/master/adi-i3c-master.c
+++ b/drivers/i3c/master/adi-i3c-master.c
@@ -115,6 +115,7 @@ struct adi_i3c_master {
 		spinlock_t lock; /* Protect transfer */
 	} xferqueue;
 	void __iomem *regs;
+	int irq;
 	struct clk *clk;
 	unsigned long i3c_scl_lim;
 	struct {
@@ -954,6 +955,7 @@ static int adi_i3c_master_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
+	master->irq = irq;
 
 	version = readl(master->regs + ADI_AXI_REG_VERSION);
 	if (ADI_AXI_PCORE_VER_MAJOR(version) != 1)
@@ -999,6 +1001,8 @@ static void adi_i3c_master_remove(struct platform_device *pdev)
 	writel(0x00, master->regs + REG_IRQ_MASK);
 	writel(0x01, master->regs + REG_ENABLE);
 
+	devm_free_irq(&pdev->dev, master->irq, master);
+
 	i3c_master_unregister(&master->base);
 }
 

