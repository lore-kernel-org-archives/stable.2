Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792989095;
	b=Y6HYLR64EI+9D0nSfMf3eE2Bh8uV69F83xaiXKSwEGfoMd0Zbjf8KVtFFGLkhSSCTPAq
	 Vp04GrD/HhtVSu0Hx6fGRAK/Ou4ctu/kF9rjpqhXC2QdiQor6Dcad4cjFazpb46vJAnAd
	 iBWKiFTiET9iUs03RjYS76th0ntSVhm02FmYZhrFpHvLVwuY7a3GR+VowRV7XLd8MzRUV
	 H5KHvqOP/IOQJq+RF7NZoTI5/fIBSyhRS4vST/hHsVSw+YgwDiuJ7hFlxstv3rpUHxwW7
	 XuyhNSVH0LKYJk09xMyQ7Hx1wrjXSP56PgCXH7tJKbvss8TAMY56bQKsuas0UualN8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792989095;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=5AfIWjNSRqfmtJIhw7tDuUxfIA/f9Zyu9yDESLH9HVk=;
	b=1viy8SgUzcftgU7x1seDby747POy4OcA/i/rHvYcdrur6SwAmk9qRC8rrWebUJFkXbb7
	 Eew9zsOALB9DLa8JwgEJ/s6bO5E+5Jc0oiGdpJp6TumCnQMUF6gsaFuFLRRPfaaEG/etz
	 YKOkKoBatGRX/R2JwQxTOUIrG0LjbWLUMrV8te9ySVfHOvc/i++t81TeNPqAGoa1p9Xc9
	 6KdDolxukfw4fuXxysewuzG/kfFf7CCmoKd+nM2jZgEhpH6aF++QZzVQDMNSPTidrYEhP
	 mWjLI1OkffQN7BoFWbAN1JrperWAXlGdKELAEMN5coMeHyiaYFicB5rvvo4DzLC/HGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE4B606A31D;
	Mon, 26 Oct 2026 04:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FE4B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8CxKvCj195qcF0ZAA--.7991S3;
	Mon, 26 Oct 2026 12:31:31 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAxlMyh195qoTgwAA--.8141S3;
	Mon, 26 Oct 2026 12:31:31 +0800 (CST)
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
Subject: [PATCH 1/4] dmaengine: loongson: loongson2-apb-cmc-dma: Fix cyclic residue wrap NULL dereference
Date: Mon, 26 Oct 2026 12:31:20 +0800
Message-ID: <e094c8dc1d01af2f296457f6c18b5d85ae76905f.1792988985.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAxlMyh195qoTgwAA--.8141S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEMCGretPgwGAAAsU
X-Coremail-Antispam: 1Uk129KBj93XoW7ur43Aw43Ww1DCryfuFWUZFc_yoW8tF48pF
	W3Jan5KFyrG3yfuanxAry0qF15AFW5JFW2vay7W347Cr95W3W29w1fCF9YgFsrAr98ZF1j
	qFWru39rGF4UG3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOb18UUUUU=

loongson2_cmc_dma_desc_residue()'s cyclic wrap special case checks
lchan->desc->cyclic instead of desc->cyclic.

When tx_status() is called for a queued descriptor while no descriptor
is active, it reaches the "else if (vdesc)" branch with lchan->desc ==
NULL and passes the queued descriptor to this helper. The helper then
dereferences lchan->desc->cyclic and oopses.

Even when lchan->desc is non-NULL, keying the check on lchan->desc is
semantically wrong: the wrap decision belongs to the descriptor being
queried, not to whatever descriptor happens to be active.

Use desc->cyclic. This fixes the NULL dereference and makes the helper
self-contained.

Cc: stable@vger.kernel.org
Fixes: 1c0028e725f1 ("dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/dma/loongson/loongson2-apb-cmc-dma.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
index 2037120b23ca..f090fbe0b8a1 100644
--- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
@@ -484,7 +484,19 @@ static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cmc_dma_chan *lcha
 	ndtr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id);
 	residue = ndtr << width;
 
-	if (lchan->desc->cyclic && next_sg == 0)
+	/*
+	 * For a cyclic descriptor that has wrapped (next_sg == 0), the
+	 * current period only has the in-flight entry left; the entries
+	 * from sg[0] onwards belong to the next period. Adding them would
+	 * make residue exceed one period.
+	 *
+	 * Use desc->cyclic, not lchan->desc->cyclic: this helper is also
+	 * reachable with a descriptor that is not lchan->desc, and only
+	 * the active-descriptor branch passes lchan->desc today. Keying
+	 * the wrap decision on the descriptor being queried keeps the
+	 * result correct and avoids depending on lchan->desc being set.
+	 */
+	if (desc->cyclic && next_sg == 0)
 		return residue;
 
 	for (i = next_sg; i < desc->num_sgs; i++)
-- 
2.52.0

