Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED5E30DECD;
	Sun, 28 Jun 2026 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782635595; cv=none; b=fTXEzSj5fvW3YY0Z++/nOB2SCP1RNRJshIlRF7PLcRDrKf/994Ksvf0ToWv+iMgZ35iQEw00vOQaMtN1n0C+0P1lXZca/OoiXUl/Su4JWi1GFnkL7Rhaa5+jmLCTnIuA3rkzLOi49DtjvTZAQrYrk8ab/OHMs2iPrWpo68rkczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782635595; c=relaxed/simple;
	bh=sgoCOonpn1lhTrr7ANUFu515Pr0BVIJvp2mh27YjJME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t/mZIf0duvcjMK83Va/5wR6nv1LnvKXxD4km8bcGMI1EsGvlmE7VMl4aZRnyuFrdkliaVb2eI9uLMHF3dktH9AQ35ubjQ9/gm8aL5o4tlQywcAiXOOuo644ErRMtntDA6qviX9OsDLJWKVE0r2fTQ9gl/vmqkoF9IaAdKcIfCAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAAXsMhA3EBqPluyAw--.34103S2;
	Sun, 28 Jun 2026 16:33:06 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: ntb@lists.linux.dev
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v2] ntb: fix tx descriptor leak on dmaengine_submit failure
Date: Sun, 28 Jun 2026 16:33:01 +0800
Message-Id: <20260628083301.9781-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAXsMhA3EBqPluyAw--.34103S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF15tr47WrW5Cr1xur4xXrb_yoW8AF43pa
	yfJ390krW8tF47ZrnrGw4UZFyYkF45Gry7Ca98KwsxuFs8Zr1xWw1fKFyvqr17AFWUGr12
	yw4qya18u34DArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIMA2pAiNl58gACsm

When dmaengine_submit fails after dma_set_unmap has been called, the
error path err_set_unmap only calls dmaengine_unmap_put once, but the
unmap object has two references (one from dmaengine_get_unmap_data and
one from dma_set_unmap held by the tx descriptor). The tx descriptor
itself is never freed, so its reference to unmap is never released,
causing a kref leak and a dangling pointer in the freed descriptor.

Replace dmaengine_unmap_put with dmaengine_desc_put(txd) in the
err_set_unmap path to properly release the tx descriptor, which will also
drop the unmap reference it holds.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: 282a2feeb9bf ("NTB: Use DMA Engine to Transmit and Receive")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Changes in v2:
- Fix patch format based on reviewer feedback
- Resend to ntb@lists.linux.dev (remove invalid googlegroups address)
---
 drivers/ntb/ntb_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 7cabc82305d6..28091ec5a74e 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1572,7 +1572,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 	return 0;
 
 err_set_unmap:
-	dmaengine_unmap_put(unmap);
+	dmaengine_desc_put(txd);
 err_get_unmap:
 	dmaengine_unmap_put(unmap);
 err:
@@ -1896,7 +1896,7 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 
 	return 0;
 err_set_unmap:
-	dmaengine_unmap_put(unmap);
+	dmaengine_desc_put(txd);
 err_get_unmap:
 	dmaengine_unmap_put(unmap);
 err:
-- 
2.39.5 (Apple Git-154)

