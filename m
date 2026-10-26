Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792989096;
	b=MgwTtJAybKNclRt64uSDn/erMXi9cAw+Pcurn3SwftRKTVz94XkRXynnXQcNs4e4DAAO
	 HQl8CVfbWORV6Pxgy0NnoecTiZXuwktAYBx5qm4wCycHsNqpNRE8mc9misnEy9jTdMZsw
	 f7kX14jidts7Iu82ZXx+iHUOcbjmfR8Ycc0T8t/+foNk+O7OLSPAb/7GQGKbAZ2nDzN69
	 vFHpLH1DLox6/zr3KjBF6DKQcSuoLLNBq+ssZVn0SOLftZAQO/rZMM+vba26Q/92Zub3M
	 94cgJ8wu0JWkSjur99Iu7v87eJNS/kRudmohwBdy0qcjEtXDd+2C5TvogplpcQG/FWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792989096;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=Tbp7WXoUWrwvQSxD4WsSNQf/TDtZecOrIW9P6AEmN9I=;
	b=YrK6KQxVVVHn2Z5UEtJM/7vZcsQFG83VZxVlhUpJNawNADL7NOXH+y+55OtcrkvqS6Xv
	 TunkD1l4u/74mu5r1e+E9WUtU8DehdnHtOib6K2+gz4kRM9dNJ825d1+4HE+fFVyqOxBd
	 ZmlKNMzyEDmxkypsu2Ca0+5s5zKqGwepRGlNd2OB/iQjuOPoswml4vQeQoMdhS13khBzq
	 qw0piNbrJXozu088KBMLOw94k/UrwTQX38WK2jfEstxu7mP2xRhuQQ7r6chj4qj3dQudl
	 HeSHs3eX2P6Yfak31xdRPfyNzKQXQTmcE+6PCbWyNrc7nyNXz0pF8dD1vyD+D525qSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1BD606A320;
	Mon, 26 Oct 2026 04:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA1BD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8Bx69Gk195qdV0ZAA--.7868S3;
	Mon, 26 Oct 2026 12:31:32 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAxlMyh195qoTgwAA--.8141S4;
	Mon, 26 Oct 2026 12:31:32 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] dmaengine: loongson: loongson2-apb-cmc-dma: Fix residue for queued descriptors
Date: Mon, 26 Oct 2026 12:31:21 +0800
Message-ID: <bd120f2c1ab291645a21b1cf9babdfcc0412cac7.1792988985.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792988985.git.zhoubinbin@loongson.cn>
References: <cover.1792988985.git.zhoubinbin@loongson.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxlMyh195qoTgwAA--.8141S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEMCGretPgwGQAAsV
X-Coremail-Antispam: 1Uk129KBj93XoWxZFW5JF13JrWDAF4UGF18Xrc_yoW5Gr1fpa
	y3AayrWFW5tay3ZFsxWry8WF15AFWfXrZFg3y7Gw13ur1DXw129r1fGFyFqFW7Jas8uFyI
	qFZ5u39xGF4UG3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7
	AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
	67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5
	JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07jFRRiUUUUU=

tx_status() computes residue for both the active and the queued
descriptors through loongson2_cmc_dma_desc_residue(), which reads the
hardware CNDTR register. For a descriptor that has not started yet that
register does not describe its transfer, so clients can observe a
residue that does not match the amount of data still to be moved.

Report residue from the descriptor length for queued transfers, and keep
the hardware-based calculation only for the active descriptor.

Cc: stable@vger.kernel.org
Fixes: 1c0028e725f1 ("dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/dma/loongson/loongson2-apb-cmc-dma.c | 23 ++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
index f090fbe0b8a1..8b8d530d60c3 100644
--- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
@@ -472,6 +472,17 @@ loongson2_cmc_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, si
 	return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
 }
 
+static size_t loongson2_cmc_dma_desc_total_len(struct loongson2_cmc_dma_desc *desc)
+{
+	size_t total = 0;
+	u32 i;
+
+	for (i = 0; i < desc->num_sgs; i++)
+		total += desc->sg_req[i].len;
+
+	return total;
+}
+
 static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cmc_dma_chan *lchan,
 					     struct loongson2_cmc_dma_desc *desc, u32 next_sg)
 {
@@ -518,12 +529,16 @@ static enum dma_status loongson2_cmc_dma_tx_status(struct dma_chan *chan, dma_co
 
 	scoped_guard(spinlock_irqsave, &lchan->vchan.lock) {
 		vdesc = vchan_find_desc(&lchan->vchan, cookie);
-		if (lchan->desc && cookie == lchan->desc->vdesc.tx.cookie)
+		if (lchan->desc && cookie == lchan->desc->vdesc.tx.cookie) {
+			/* Active descriptor: compute residue from hardware progress */
 			state->residue = loongson2_cmc_dma_desc_residue(lchan, lchan->desc,
 									lchan->next_sg);
-		else if (vdesc)
-			state->residue = loongson2_cmc_dma_desc_residue(lchan,
-									to_lmdma_desc(vdesc), 0);
+		} else if (vdesc) {
+			/* Queued descriptor not yet started: residue is the total length */
+			struct loongson2_cmc_dma_desc *ldesc = to_lmdma_desc(vdesc);
+
+			state->residue = loongson2_cmc_dma_desc_total_len(ldesc);
+		}
 	}
 
 	return status;
-- 
2.52.0

