Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00293FF8B6;
	Wed, 23 Sep 2026 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147748; cv=none; b=KQLBYYj3PiEVRo5WNAP91AQClNG2vYfadtblrkyDLIemwadyLzEZAJCC7USAMyHXtZ+dtyjP1SQQkGScK+wKR1iffQFybA9Jxat/XFVqEuIO1gNss/YVqlG+P9yeeG8nLpkj92upiwy8wWlDdlYp/PgO2d2/AiJcSE+lyL9uarw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147748; c=relaxed/simple;
	bh=vZuxlwRpnrfiw2XnOOnbK05Vv1F8TcWxDpr/OMYOFp0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mocflb281tR16KJw67FdqG+0ruMCjrtJGVh+tzFbXJ9JfyOuXAlU0z8FmQ/dvic4pG5xFQXOMRZBsh5Jh5742hmo0lQYwZsdyWx3Bttj07ikv8Oo3un8Im6iVt7Y8x+EHNM8gy3L/9fAFVWpgfe6ytX0iYVpGVW1Y4FBHs7s+2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wA3EX6QfLNqptcwAQ--.6008S3;
	Wed, 23 Sep 2026 15:15:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgAXy9KPfLNq+hSWBA--.44834S2;
	Wed, 23 Sep 2026 15:15:27 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Elie Morisse <syniurge@gmail.com>,
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] i2c: amd-mp2: Synchronize IRQ handler on callback unregister
Date: Wed, 23 Sep 2026 07:14:32 +0000
Message-Id: <20260923071432.487741-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgAXy9KPfLNq+hSWBA--.44834S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?as2ZGQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI1WXnYUE6Iac3H707PoH6LkwsQ8ncJF0C3+57Q5r70gUnGd
	neRwZM6hBr/dGuJHJDfN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyxXFWfGF1DJw13WrykWFX_yoW8tF4fpF
	WfWrsayrs8JFs093WDAa1Fvry5Xws3XayUC34Uu39rZanYyrZ5Cry8tasIvFn8AryxJ3Wj
	yFW5t343CayjyFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8aQ6JUUUUU==

amd_mp2_irq_isr() dereferences the per-bus i2c context stored in
privdata->busses[] and calls its cmd_completion() callback.
i2c_amd_remove() clears that pointer with amd_mp2_unregister_cb()
without any synchronization, so a handler that already loaded the
pointer can still write i2c_common->eventval and call
cmd_completion() after devres frees the struct amd_i2c_dev embedding
the context.

Fix this by calling synchronize_irq() in amd_mp2_unregister_cb()
after the pointer is cleared: handler instances that started earlier
finish before the caller frees the object, and handlers that run
later observe the NULL entry and skip the bus.

The interrupt handler keeps reading the slot without any lock, so the
clear and the handler's read use WRITE_ONCE()/READ_ONCE() to mark
the access as intentionally concurrent.

synchronize_irq() can sleep, but its callers hold only the sleepable
adapter bus lock, which the interrupt handler never takes.

This issue was found by an in-house static analysis tool.

Fixes: 529766e0a011 ("i2c: Add drivers for the AMD PCIe MP2 I2C controller")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/i2c/busses/i2c-amd-mp2-pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd-mp2-pci.c b/drivers/i2c/busses/i2c-amd-mp2-pci.c
index 60edbab..8c81247 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-pci.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-pci.c
@@ -209,7 +209,7 @@ static irqreturn_t amd_mp2_irq_isr(int irq, void *dev)
 	enum irqreturn ret = IRQ_NONE;
 
 	for (bus_id = 0; bus_id < 2; bus_id++) {
-		i2c_common = privdata->busses[bus_id];
+		i2c_common = READ_ONCE(privdata->busses[bus_id]);
 		if (!i2c_common)
 			continue;
 
@@ -268,7 +268,9 @@ int amd_mp2_unregister_cb(struct amd_i2c_common *i2c_common)
 {
 	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
 
-	privdata->busses[i2c_common->bus_id] = NULL;
+	WRITE_ONCE(privdata->busses[i2c_common->bus_id], NULL);
+
+	synchronize_irq(privdata->dev_irq);
 
 	return 0;
 }

