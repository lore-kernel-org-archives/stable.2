Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C31632E7;
	Wed,  8 Jul 2026 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475255; cv=none; b=ooTuFCn9IzYoKptkiNG8soJkKd2KeRj4QiV+f3g/BPZ2RX1ghldNahSJcEji/NJhWmHaSM+eY7eY/J5bkIXuOgrKSzK8TCTFGLwPUFBDL8UKcugL9LnGy5pBsGudJB+bnMfVZkgMET99bEe7SbEQYWoM9UH7sU3vcrGUtMrIB9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475255; c=relaxed/simple;
	bh=Pc+X5zWYO6UcLm5BxRPyhzGCj1n5sIoRhMG4FPAA9qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZPupebPBblzkCOgFV3TF4FkT0fPPaqpmTTt5D/amJy09Mcoq4TQQckNMDj5jEvxgZ74qp9pNx8W6S/diWUO2zHoynAqw6QCJvGyL5kEMln5J8fd2318zfzeV08tD0HSiTgz49VEoUrbxxDa5FN8/YmB+j5KtxRMlRT0vto/gcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAB3l94hrE1q2XkiFw--.46091S2;
	Wed, 08 Jul 2026 09:47:13 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 RESEND] mtd: nand: realtek-ecc: add missing MODULE_DEVICE_TABLE()
Date: Wed,  8 Jul 2026 09:47:12 +0800
Message-ID: <20260708014712.99760-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3l94hrE1q2XkiFw--.46091S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JFyxCF1fXF1fCw1fWr4xXrb_yoW8JF1fpF
	WUu34Fy3y3Wr4YganI9w1UuFy5Cas3trWvkr13t34Fqw1UZry5CayUKrWjvr1UJa1kGaya
	vrn8tFWDCF4DArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQo7
	NUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The Realtek external ECC engine driver has an OF match table wired into
its platform driver, but the table is not exported with
MODULE_DEVICE_TABLE().

When the driver is built as a module, the missing OF module alias
prevents automatic module loading from the compatible string.

Add the missing MODULE_DEVICE_TABLE() entry.

Fixes: 3148d0e5b1c5 ("mtd: nand: realtek-ecc: Add Realtek external ECC engine support")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1:
- v1: https://lore.kernel.org/r/20260704123044.31740-1-pengpeng@iscas.ac.cn/
- add Fixes and Cc stable tags
- align the subject with the driver name

Resend note:
- resend with the complete Cc list; no patch changes

 drivers/mtd/nand/ecc-realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/ecc-realtek.c b/drivers/mtd/nand/ecc-realtek.c
index 0046da37ea3e..e2153b1789be 100644
--- a/drivers/mtd/nand/ecc-realtek.c
+++ b/drivers/mtd/nand/ecc-realtek.c
@@ -448,6 +448,7 @@ static const struct of_device_id rtl_ecc_of_ids[] = {
 	},
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, rtl_ecc_of_ids);
 
 static struct platform_driver rtl_ecc_driver = {
 	.driver	= {
-- 
2.53.0

