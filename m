Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792989095;
	b=UY8KbDE2YroKkwyk8nQy3MXWQ3CxZqLNhobwGIZRPjoXpmhzmB2suP88gBzwoGxQOy8h
	 8Gm/fuid4VGYJWc4lPvSIX33JfESIEpBTWuUcg4vbJ95udtkvnAjQEYHhp7rbDNZJob37
	 Xn8GwIPyJN79Jx5EacQkYi3faZ8IsYNrVgivKprCo2e/CgvBRUyODZCGDcfxnvCieXRBH
	 +2/VGhLL8f8jZoVM9kNSyWesTxeUCwE1biCXsixBxLSc4TpbAtT9UjfJjBgwARouEG7YA
	 eA2eaDeQTTNJCXeyGgduCQrALZdaS7pmrKskjKk+Np+23UQUDETOfLdyoBSLUO9ithQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792989095;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=oOIA3tRZyVmZrugavHeyiSBGGloQmcKyysbHi8eIt6I=;
	b=lllQuk5kmfEje8dW7MJTAROC4SP7PaCH/lJXoY3TAQjoGDACXzVtHz2jOPNUG/0gb4hL
	 y5KvUe+d1QQHblC7lsqXncpNlJZXD7C7o+yxuSV2heyDixHhFiLJwajJHwITGtTydCGUu
	 3YeSn01IB92SsDh/RF5+eZfNCHn1fKXPkcNFzTkYlwmOJKoVx6HDVYStU4dP79VoqMeP8
	 uMZos4HQyhdKQ4iHgSDAVJ0K+k8SlCxOEEcC3Qom076FKtvZWcIURzovvMN+1Gv/COIV4
	 sunIZHEOyy7b4SCeA5iJN91MfHpEaPhBYIrpHJIaO2HlMWrra1/IppuQIgPzsHTVvsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E6E606A321;
	Mon, 26 Oct 2026 04:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0E6E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8DxOvCl195qel0ZAA--.8446S3;
	Mon, 26 Oct 2026 12:31:33 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAxlMyh195qoTgwAA--.8141S5;
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
Subject: [PATCH 3/4] dmaengine: loongson: loongson2-apb-cmc-dma: Program CNDTR when advancing sg
Date: Mon, 26 Oct 2026 12:31:22 +0800
Message-ID: <dcb49d67055cc41af3bd68cce01c05e73a7c2787.1792988985.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAxlMyh195qoTgwAA--.8141S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEMCGrexPwu8AAAsV
X-Coremail-Antispam: 1Uk129KBj93XoW7WF4fZr43KF4rGr4UKF4kGrX_yoW8GrW3pF
	ZxZ34UWFZ8tF4av3Z8uFy8WFy5AF9IyFZF9ay2vw1ku3s3Zw1Uuw15CFy8XF4UAryrXFy2
	vFWkurW7GF1DCFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jo
	sjUUUUUU=

When configure_next_sg() moves to the next scatterlist entry it updates
CMAR but leaves CNDTR at the value left over from the previous entry.
The controller therefore keeps using a stale transfer count, so the
hardware does not move the amount of data the descriptor describes.

Program CNDTR together with CMAR so software and hardware progress stay
in sync.

Cc: stable@vger.kernel.org
Fixes: 1c0028e725f1 ("dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/dma/loongson/loongson2-apb-cmc-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
index 8b8d530d60c3..c654e0572902 100644
--- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
@@ -266,6 +266,7 @@ static void loongson2_cmc_dma_configure_next_sg(struct loongson2_cmc_dma_chan *l
 
 	sg_req = &lchan->desc->sg_req[lchan->next_sg];
 	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, id, sg_req->chan_reg.cmar);
+	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CNDTR, id, sg_req->chan_reg.cndtr);
 
 	/* Start transition */
 	ccr |= LOONGSON2_CMCDMA_CCR_EN;
-- 
2.52.0

