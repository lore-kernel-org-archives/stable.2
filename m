Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6274BD785;
	Thu, 17 Sep 2026 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640583; cv=none; b=D+Cdj+IO1GjDpbtHS6mgjMWLRonpyB9kmZZw2GGNaLlPYlpKJzBGWGx/HqLjxMFDKz1pEfYOLCYy2pgaOrZf1uFE4PYv2JRk2Y7OlVskV7dXR9RXvjT74V5oO/A30fbIeFkP1cVdJ2wQzMaXrBjXwHYrHQoYIrnQ676JE8aylZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640583; c=relaxed/simple;
	bh=c1vgiiMikaJOFrMWdY5sHyDJa3KbO+8P/c+WsFR0Itw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mJl++y3SKmjDPfJzP1ZGIwdKSZNOn/y1/zKXuC1m1CY/MOahDnE7lDaV3aLEPRQThqR8jin3dtt8zCvOLGUrNHjn7lSJAdySCE0+m9qyCKdToyYP9DVL/wlmviry4+rBh1zippkr8XrZwK1/IhO+uK1Cu8zonkWiJXF2a3opXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXADt0v6tqe4h+CA--.483S2;
	Thu, 17 Sep 2026 18:22:44 +0800 (CST)
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
Subject: [PATCH] mtd: maps: l440gx: Fix double put of the ISA bridge in init_l440gx()
Date: Thu, 17 Sep 2026 10:22:44 +0000
Message-Id: <20260917102244.2146654-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXADt0v6tqe4h+CA--.483S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyUAr45JF1xCFy7Gw4rXwb_yoWkWrgEga
	4j9rnru3yUXr18Cw1rtr4furyayryqgryxGan7ta9akrWYvF1qqrWDZr95Jw18ua1YyrZx
	X3WDCrsxZrZF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRINA2qrq01N0gAAst

init_l440gx() takes a single reference on the PIIX4 ISA bridge with
pci_get_device() and drops it again right after the lookups, before
the flash window is set up.  The pci_assign_resource() failure path
then calls pci_dev_put() on the same device a second time, releasing a
reference that is no longer owned and underflowing the reference count.

Remove the extra pci_dev_put().

Fixes: dd8e9ed6ed54 ("[MTD] Switch to pci_get_device and do ref counting")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/mtd/maps/l440gx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/maps/l440gx.c b/drivers/mtd/maps/l440gx.c
index 832b880d1aaf..85cd273ce065 100644
--- a/drivers/mtd/maps/l440gx.c
+++ b/drivers/mtd/maps/l440gx.c
@@ -110,7 +110,6 @@ static int __init init_l440gx(void)
 
 		/* Allocate the resource region */
 		if (pci_assign_resource(pm_dev, PIIXE_IOBASE_RESOURCE) != 0) {
-			pci_dev_put(dev);
 			pci_dev_put(pm_dev);
 			printk(KERN_WARNING "Could not allocate pm iobase resource\n");
 			iounmap(l440gx_map.virt);
-- 
2.34.1

