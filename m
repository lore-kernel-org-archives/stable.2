Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5C5226B4;
	Wed, 14 Oct 2026 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987172; cv=none; b=KCSyzQWvRA1uzfSVXe3wYlJN9yqhTWh/tPNCIXxFjYGFvijLIUwjD0IjH+YZ362mlC3W+Iix+GLjN+o1FP0peW/vdObZQRqn8MjVL3FB8xEjBP3N1r02V8YxnqJwcq/SNTWqMK0yCc5uLQNqy1hY8ORPMVhHkEdI6XGPCRyTql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987172; c=relaxed/simple;
	bh=GpTQHn014kHtDu9Cy1gih2Gb2pgk5YYmJNst75WE+B8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e3S4++Go6RUm+xMxQdPzxUTzeBk3Ht67BM/czeC7ffyW/TtddQQWLS7ygs9jsL9m2LkcdnFKVU3XiYYGLjoE830zfvi0S/Qs/qR8dMbm4q2QwO0ziQddVXtemh5q2nNUoDbKpXRaJ0XJ+c0QAXWyCY1UhpM16py1tNzjF7Gg2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=A8K0Oxfy; arc=none smtp.client-ip=115.124.28.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="A8K0Oxfy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1791987159; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	bh=0k0CCSxZ3VQVXJcesjA69DqyGFy5bOLaWZHNcm970DM=;
	b=A8K0OxfyB8TqPJhAKrkAMESMEp7bJ9EWur3zW07fAIsZRlAOqxq8qLy7DvC4FQ+QvS2OHHWBIzEuDDnpg6KUOMKg3ZQbfl1T38+QcBfsHdrxHdsLHHnGQaEzT4Htr/GH8m8BYqDpqii+9WMQXd3PNGKDKFuLirHpL32tHzmncKY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436963|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00535965-0.00100108-0.993639;FP=11520330393198407248|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jdGYq.v_1791987157;
Received: from 127.0.0.1(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jdGYq.v_1791987157 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 14 Oct 2026 22:12:38 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Wed, 14 Oct 2026 22:12:38 +0800
Subject: [PATCH] spi: topcliff-pch: clamp DMA bpw_len by bytes not words
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-spi-pch-bpw-clamp-v1-1-3e04b3ac5106@xiaopeng.com>
X-B4-Tracking: v=1; b=H4sIANWNz2oC/x3MSwqAMAwA0atI1gbaUBW8irioNWrAT2hBBfHuF
 pdvMfNA4iicoC0eiHxKkmPPsGUBYfH7zChjNpCh2hrrMKmghgUHvTCsflNsArnBU9UY8pA7jTz
 J/T+7/n0/kS/V1mMAAAA=
X-Change-ID: 20261014-spi-pch-bpw-clamp-7c24ba25702a
To: broonie@kernel.org, linux-spi@vger.kernel.org
Cc: grant.likely@secretlab.ca, linux-kernel@vger.kernel.org, 
 tomoya.rohm@gmail.com, Liu Chao <liuc63@xiaopeng.com>, 
 stable@vger.kernel.org, Weibin Liu <liuwb@xiaopeng.com>
X-Mailer: b4 0.14.3

pch_spi_handle_dma() computes data->bpw_len as a word count
(cur_trans->len / (bpw / 8)) and then clamps it to PCH_BUF_SIZE.
The DMA coherent buffers tx_buf_virt/rx_buf_virt are allocated by
pch_alloc_dma_buf() with dma_alloc_coherent(..., PCH_BUF_SIZE, ...),
i.e. PCH_BUF_SIZE bytes.

With bits_per_word = 16 the copy loops handle bpw_len u16 elements,
so up to PCH_BUF_SIZE * 2 bytes are written into the PCH_BUF_SIZE
byte tx_buf_virt and read back from rx_buf_virt, overflowing the
coherent allocations by up to PCH_BUF_SIZE bytes.

Clamp bpw_len to PCH_BUF_SIZE / (bpw / 8) words and subtract the
corresponding byte count from cur_trans->len so the remaining
transfer length stays consistent.

Reproduced with a user-space replica of the length arithmetic: with
bits_per_word = 16 and len = 8192, bpw_len = 4096 words pass the
existing clamp and the copy loop addresses 8192 bytes of the
4096-byte buffer; with the clamp it addresses exactly 4096. No EG20T
platform hardware was available.

Reviewed-by: Liu Chao <liuc63@xiaopeng.com>
Fixes: 7d05b3e868ee0f ("spi-topcliff-pch: Fix issue for transmitting over 4KByte")
Cc: stable@vger.kernel.org # 3.4+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
 drivers/spi/spi-topcliff-pch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 98723042c16f..1603a5f1e00b 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -934,9 +934,10 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 	}
 	data->bpw_len = data->cur_trans->len / (*bpw / 8);
 
-	if (data->bpw_len > PCH_BUF_SIZE) {
-		data->bpw_len = PCH_BUF_SIZE;
-		data->cur_trans->len -= PCH_BUF_SIZE;
+	/* DMA buffers are PCH_BUF_SIZE bytes, bpw_len is in words */
+	if (data->bpw_len > PCH_BUF_SIZE / (*bpw / 8)) {
+		data->bpw_len = PCH_BUF_SIZE / (*bpw / 8);
+		data->cur_trans->len -= data->bpw_len * (*bpw / 8);
 	}
 
 	/* copy Tx Data */

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261014-spi-pch-bpw-clamp-7c24ba25702a

Best regards,
-- 
Weibin Liu <liuwb@xiaopeng.com>

