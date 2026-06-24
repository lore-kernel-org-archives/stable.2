Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC9F2EA732
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782277479; cv=none; b=fB8ShclDUFht7CKfBREWDhxzL8E6dPG5U6skkn+MeKEWdnXMwocuI6Bf98orDTluJsml1UY+bjGGTiL6bBQDITsJW21JowfmGoZYVODnTsgQO0Vi0y6g2yiFFR875JwEY4Zfzhcfl1hNj6xZEInZNAsYzBLDYb6zmUx53nSMoj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782277479; c=relaxed/simple;
	bh=UJ+6KkVcuHWYpSIQI4GB0BZdywy91MXgLZ2+we5f6Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pwp+76qP92u2SU5x4Kaze1UP8fkJUkYlqHrBgCdGBjrmuJfgGULngIF8qYrHMbR7y/uT4jId5iazosZpU3QcfpqV9vqTNzi/YVlOTqybZai57hyBSa+XXPa855s/pD0bAZwtPUtGl12HAJBH+9//O96FCx5MohV3R2VNUqqGgi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAvz96dJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAvz96dJ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37ce68a54f8so501822a91.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 22:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782277477; x=1782882277; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4StFu5ahPZMOCmpAmf7ZBLUUMy/f7dbOEJjELgNIlkA=;
        b=SAvz96dJxDSWUDNhhMgirQFLMxmSx/AJKo+9MuwxsEHvvh9PUINHdnyN1jhH3qGQTg
         vQjd5VAG66+dK8Lyg18O4JQR++h7d2RSxiTGIIYlDhfSF8H6yNHoxVKrDyDfTxF2brXY
         SKAVxxq88d8yAb3os4jDSf2ViQHkz0yzezC732hhICljOrtG9SAVFsiaflqea82fBiRJ
         3hfWcwJ6pmCEcCcExSoAjxy9M0F8XieImZkq00SqmzC1iW/GdQS/C5UtFvyRVhzq+aR6
         oV0eN5DLqOzLOZSjNCXHwefSqt+OUtjBtUg4bG5c0CyMcO/x6YqF/ahUinl9Dwce7sLp
         dzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782277477; x=1782882277;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4StFu5ahPZMOCmpAmf7ZBLUUMy/f7dbOEJjELgNIlkA=;
        b=hw5yxoLrIR4CJbswy96z/BHPp5HnToSjXRdXPM/t3oeV2KwCwS1K84MBIk4382Fkn+
         4cNsN95cmRAP7/Tj7/VwAUPy0i9UNTg1PcsUXushn34ATie7BSDPw2xc23mcrIgDPvBK
         hVfVAEfkUNfX6IesMj+DgEISvoE25/C6qdL8yfmtpGShAo1I+L0+l1wNBvRkW6TsJl0d
         h/RkMJAArrxii2hbAB4yTmTe/HEwMGAfXq5KvislFka+6CRMkdFubVANeIn5FkMxrpFk
         qHKEvka1tNT82KcHJG1iUNc14h3OsqGjtC0ezYnBaThgNWY04ZeSM0vG8lscDW/yPGHU
         5hdA==
X-Forwarded-Encrypted: i=1; AHgh+RpBK8XlpWaSK6dWsMwM+6V3blyfNaCUYY2Dd2TL2VxKEcHTteIjHYLQA9BstCLV8MmARceziXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyguNQAH87N6NozBpGapHlH3aJiLQ8OVdypdgt4+P6dPeWgY1VD
	equM9pTgHV9HfvMvIJyyrRT1zpL/USIxkXNYbKG0YVmqs5wEersEhXmw
X-Gm-Gg: AfdE7cmlYEdxi1nTtil75hxnHWGh759p7Iv59YcSHDgDcOYtJHlhyT1eJFbIhO8Z3Fa
	+LFoHksTH4yPFgsJSK9Om1+9SJux4qNLG2qSla+g82dlIp60+ZMeLcbFOnA7mdWNAn10FuWkvb4
	EaGb5AwlAssUHGvJT4j+i4Q48pbVFm0PjNPXyPyGn/dvY7zUT6JX9QZ5hmDV0D0jlVUVIK/TnUx
	I+hzLqZGM1yhbPh/r1iZWvyfCbVfW6Gmg85lqBEsuUkkt7wCScQRDwZMVfY1/FJCn/w26KVDQjC
	UobV57LsjYz1ZY0bHLJEwng5xlwOUK9wdbC1W3UiPGSqtlnBY5r9aw8Eg2mlMU8C/8jVMfGQ8oa
	6N/uO52eIO67isGudqHBzFUPPGs2yIfGim8TqqBt2be3QAso9XQp/M4RhXJCdlPs17d8/bVeJK3
	YyE/zSyOcGyzdsr4i6PnyLEm90IHmxgj0h//4izg==
X-Received: by 2002:a17:902:fc50:b0:2c6:9f66:d57e with SMTP id d9443c01a7336-2c7c7745507mr67099365ad.36.1782277477048;
        Tue, 23 Jun 2026 22:04:37 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444a9c5asm117748675ad.74.2026.06.23.22.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 22:04:36 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Kaixuan Li <kaixuan.li@ntu.edu.sg>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] i3c: master: svc: bound IBI payload to the requested
 max_payload_len
Date: Wed, 24 Jun 2026 13:04:33 +0800
Message-ID: <178227747353.2931373.15868718612134648277@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

svc_i3c_master_handle_ibi() reads the IBI payload from the RX FIFO into
the IBI slot. The loop is bounded by the hardware FIFO size
(SVC_I3C_FIFO_SIZE), not by the slot size.

slot->data points into the IBI pool, which i3c_generic_ibi_alloc_pool()
sizes at max_payload_len per slot. svc_i3c_master_request_ibi() only
rejects a max_payload_len larger than SVC_I3C_FIFO_SIZE, so a driver can
request a smaller one. mctp-i3c requests 1. Each readsb() then copies the
controller RXCOUNT bytes (up to 31) with no check against the slot size.
A device that sends more bytes than the slot holds writes past
slot->data, an out-of-bounds write into the IBI pool.

Bound the loop by dev->ibi->max_payload_len and clamp each read to the
space left in the slot, the same way dw-i3c does. A device can still send
more than the requested payload. Flush the leftover bytes from the RX FIFO
so they do not leak into the next transfer.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v2:
- use min() instead of min_t(), the types already match (Frank Li)
- flush the leftover RX FIFO bytes after the bounded read, so an
  oversized IBI does not desync the next transfer (Sashiko AI review)

 drivers/i3c/master/svc-i3c-master.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index e2d99a3ac07d..4eb54f9ee2cd 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -465,14 +465,22 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	buf = slot->data;
 
 	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
-	       slot->len < SVC_I3C_FIFO_SIZE) {
+	       slot->len < dev->ibi->max_payload_len) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
 		count = SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
+		count = min(count, dev->ibi->max_payload_len - slot->len);
 		readsb(master->regs + SVC_I3C_MRDATAB, buf, count);
 		slot->len += count;
 		buf += count;
 	}
 
+	/*
+	 * The device may have sent more than the requested payload. Drop the
+	 * extra bytes so they do not leak into the next transfer.
+	 */
+	if (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS)))
+		writel(SVC_I3C_MDATACTRL_FLUSHRB, master->regs + SVC_I3C_MDATACTRL);
+
 	master->ibi.tbq_slot = slot;
 
 	return 0;
