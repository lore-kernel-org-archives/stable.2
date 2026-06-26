Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582EB2F3C19;
	Fri, 26 Jun 2026 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488317; cv=none; b=G/dWlv4sc0TSktX8H0htgXjUkbM1dRUK0DwxuIW+xuVEwxzJKQMp9lWWeOYHG7JaG8IBrZ4kGFTtdU9IteUoGCVtc2WVNQpjYRzyesT7Z5REf7yAy+ig2xD7myXjMs5ZeZ1ZF7Q18oV5pI70o0GC3gv5F2tB0XJxfnEgDBnOfIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488317; c=relaxed/simple;
	bh=8t+8L8YqOj3smBBVBMzG41TpGVwWtcfLWldgKyBTrQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J9z7JaJkwq7vweMRrXM/nMx3L+cYPcMhKwmqntuiGovK42kZeAn8gDvdvfwg9L8xT8ou3K4bOVMDg6tFH4P27gZMJuJ7CdGd5zIiByjJlREER7iOgVnIOy97xa1dQHP+5sHZ7R4BATgKx8RZglY/OGdosQ+pgzpNwzdvjJTsZrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowADnjNX1nD5qQI1sAw--.17023S2;
	Fri, 26 Jun 2026 23:38:30 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	linux-ntb@googlegroups.com
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: ntb: ntb_async_rx_submit: fix tx descriptor leak on dmaengine_submit   failure
Date: Fri, 26 Jun 2026 23:38:29 +0800
Message-Id: <20260626153829.53045-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnjNX1nD5qQI1sAw--.17023S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF15tr47WrW5Cr15WryUZFb_yoW8Xw4fpa
	1fX390kr48tF42vrnrGw4UZFyYka15GFy7Aa98KwsxCFs0vr1xGwn3KFyvqr17AFWUGr17
	tr4qya18uw1DArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUJuc
	_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQKA2o+iCg4HAABsF

When dmaengine_submit fails after dma_set_unmap has been called, the
  error path err_set_unmap only calls dmaengine_unmap_put once, but the
  unmap object has two references (one from dmaengine_get_unmap_data and
  one from dma_set_unmap held by the tx descriptor). The tx descriptor
  itself is never freed, so its reference to unmap is never released,
  causing a kref leak and a dangling pointer in the freed descriptor.

Replace dmaengine_unmap_put with dmaengine_desc_put(txd) in the
  err_set_unmap path to properly release the tx descriptor, which will also
  drop the unmap reference it holds.

Cc: stable@vger.kernel.org
Fixes: 282a2feeb9bf ("NTB: Use DMA Engine to Transmit and Receive")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
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

