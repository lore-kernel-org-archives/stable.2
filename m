Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1955431AABF;
	Tue,  4 Aug 2026 06:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823936; cv=none; b=j1HOCoN4BAfpMmWZnq/8gPX9AkjfNLpDU1MZeMw6hSEdXflC//kmQNFvLUZduSZaZrBfuXAlY/22+P3xdmRZ2db9/VV4dO3grLOcBfXz+bqwriIInEUm+I7fXdMqb68LP+FCqV3tFSLiJ42H3AjGCJOShwy7q5u25kRmfi6MT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823936; c=relaxed/simple;
	bh=QZ7HU7TVrJI/Ym28cZCoeeJ5FDQt6B/2QCuH1EV1tYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXZ/fh0Ge1h72ujQJDbGDcfDfUlgENxhU8pucglK6p0nOMaxf2qmernvwaBmauIDo3RygrQZBNSiQQBga/Wsu+xqucdVo6DMbbhUZSDk/afyjznwXLcButKO6ycojiv8gfD5m/14HKjL5AN9RARPgLwEskhs51nsfRZjFSt5uOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.205])
	by gateway (Coremail) with SMTP id _____8BxXZu6gnFqQy4KAA--.10106S3;
	Tue, 04 Aug 2026 14:12:10 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.205])
	by front1 (Coremail) with SMTP id qMiowJDxPcW5gnFqnxAjAA--.57941S2;
	Tue, 04 Aug 2026 14:12:09 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: loongson2: Fix sg iteration in data reorder functions
Date: Tue,  4 Aug 2026 14:12:00 +0800
Message-ID: <20260804061200.3897779-1-zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxPcW5gnFqnxAjAA--.57941S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEJCGpxaFEBDwAAst
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrykuF47Cw1xJF48Kw4kuFX_yoW8Cry5pa
	4fAw1a9F4UtF4Yvr98X3y7ury5ua4aga42gF4DGwn5uFWkXr1Uur1UK3WFqF129FWYkFyI
	qr4qgrZxW3Z5GFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUUU

In ls2k0500_mmc_reorder_cmd_data() and ls2k2000_mmc_reorder_cmd_data(),
the for_each_sg() macro already iterates over the scatterlist entries,
with 'sg' pointing to the current entry. However, the code incorrectly
uses '&sg[i]' and 'sg_dma_len(&sg[i])' inside the loop, which treats
'sg' as an array base and indexes it again, leading to access of
wrong sg entries (or out-of-bounds if the list is not an array).

Cc: stable@vger.kernel.org
Fixes: d0f8e961deae ("mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC controller driver")
Fixes: 2115772014bd ("mmc: loongson2: Add Loongson-2K SD/SDIO controller driver")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/loongson2-mmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
index f553e92fd9e5..118eccbaf8cd 100644
--- a/drivers/mmc/host/loongson2-mmc.c
+++ b/drivers/mmc/host/loongson2-mmc.c
@@ -641,8 +641,8 @@ static void ls2k0500_mmc_reorder_cmd_data(struct loongson2_mmc_host *host,
 		return;
 
 	for_each_sg(cmd->data->sg, sg, cmd->data->sg_len, i) {
-		data = sg_virt(&sg[i]);
-		for (j = 0; j < (sg_dma_len(&sg[i]) / 4); j++)
+		data = sg_virt(sg);
+		for (j = 0; j < (sg_dma_len(sg) / 4); j++)
 			if (cmd->opcode == SD_SWITCH)
 				data[j] = bitrev8x4(data[j]);
 			else
@@ -758,8 +758,8 @@ static void ls2k2000_mmc_reorder_cmd_data(struct loongson2_mmc_host *host,
 		return;
 
 	for_each_sg(cmd->data->sg, sg, cmd->data->sg_len, i) {
-		data = sg_virt(&sg[i]);
-		for (j = 0; j < (sg_dma_len(&sg[i]) / 4); j++)
+		data = sg_virt(sg);
+		for (j = 0; j < (sg_dma_len(sg) / 4); j++)
 			data[j] = bitrev8x4(data[j]);
 	}
 }

base-commit: e27c946b589c53520409a0956b33d52ef7a0898f
-- 
2.52.0

