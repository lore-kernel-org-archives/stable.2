Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F764A2076;
	Thu, 17 Sep 2026 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640472; cv=none; b=DKvVcmW4dhqSp3LEqyxB59R1X//w1etq3HNhyTJ3hoUHxbwucj3TDD6nQTMwsXnGIWnn5DE52i/Pcjy/cjO/4RtRJFCB/N3Aqrusb3ySXHzuYp6OAKS2kK+RuORhRuYARKHDHIWPV85CEA4r/+BbHP2lH29XGa8Sw6MsakhvlbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640472; c=relaxed/simple;
	bh=6v1cn39ylOQ4389CEmvCTDuyHYvdTHGkSHSYgNtFoSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FuSI9+BjOweHrTYW2aMz6Hno584l2wnP1kkDgO5G/aUC1QMlCmoxJChW6m30nvODD0+fS+HcllHFE2mr+wz8aRS22SoDzDqN+tRgQiGBIA7peZTwz47zageWYZeLqGxjF7j3H9RpNfmltLZpZ9V1Ed8ZDdYVF+coaPlqMyhKVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXAj0Dv6tqQoF+CA--.460S2;
	Thu, 17 Sep 2026 18:20:51 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: akpm@osdl.org
Cc: dwmw2@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: amd76xrom: Fix PCI device reference leak in amd76xrom_init_one()
Date: Thu, 17 Sep 2026 10:20:51 +0000
Message-Id: <20260917102051.2146567-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXAj0Dv6tqQoF+CA--.460S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy8CF4kKr18JF4rAw1UKFg_yoWkGwb_Cr
	93Zrs7XrnrKF1jkw1qkr13Za4YgFyDWrWvgFsFvrZ5WrZFvF43ZrZ8Gr15XayI9w4rZF98
	Ja1Uuws0q392kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07j1zuXUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAANA2qrrJpCjgABs4

init_amd76xrom() obtains the PCI device with pci_get_device() and
hands the reference over to amd76xrom_init_one(), which stores it in
window->pdev.  When reserving the ROM window fails, that function
returns -EBUSY directly instead of going through amd76xrom_cleanup(),
so the reference is neither released nor cleared.

Drop the reference and clear window->pdev on that path.

Fixes: dd8e9ed6ed54 ("[MTD] Switch to pci_get_device and do ref counting")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/mtd/maps/amd76xrom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/maps/amd76xrom.c b/drivers/mtd/maps/amd76xrom.c
index 95f9b99ce5fc..8c53c8f25d81 100644
--- a/drivers/mtd/maps/amd76xrom.c
+++ b/drivers/mtd/maps/amd76xrom.c
@@ -152,6 +152,8 @@ static int amd76xrom_init_one(struct pci_dev *pdev,
 		printk(KERN_ERR MOD_NAME
 		       " %s(): Unable to register resource %pR - kernel bug?\n",
 		       __func__, &window->rsrc);
+		pci_dev_put(window->pdev);
+		window->pdev = NULL;
 		return -EBUSY;
 	}
 
-- 
2.34.1

