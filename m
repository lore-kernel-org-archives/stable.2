Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B83E2AB6
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792039960; cv=none; b=pcENg1JmpKCQchmF0RsY83ZskE3Wi64O4eMhNc0+CXF6x8yJ5awt5oRfUUBAYOfjAtFVI31RTNp4IuVTTSlkDdFyYVPpExLVyGZ33J0ZIQ+lOop/hLb6Bi54jHNmHdFNH/P9MoenLHLN5oqkTF0gkRzJOBR7nHn67mxdZzEDhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792039960; c=relaxed/simple;
	bh=kiM6u0W/hsmshBfNmT71PePxEzLKAzCU7ISAde3J8oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmALmTr1ekeTXyXSlr8B/EjDsnZlV6/VgrH1uDjwa8YKTrjENj5aJ2nx51QlVCrCwOXhJPImXgcD9L/Cz8O1EM54g0zHXk9LsuJjvwdLUGmrphQFT9eBUf/2l0HhHStLysHJ/xRp2eXSwHu3FjYhWgM8I2blX2aMQOKNS9lxq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=k7EIbpDj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="k7EIbpDj"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd633ef819bso342886a12.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792039958; x=1792644758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nK6+12BDaJSc6Zv5ydKjvBfAWgujcnGE1f71j9SWy/Y=;
        b=k7EIbpDj7LIcP2VR3ZNBWMZC5x0qPcMXEzcxHhOUAwgPJGIfY4ekmduRst54+Onqik
         q97sKdUIOnA/Jr/bWJQryTcHupVWKnaoygFtIWzbmRalg3zfhCAn4S244qBKcXQo2lsM
         w+/fwrkjChTVCw3Xy6Bt7lqR2MUkemaQPwgV4cPyk2OdMlLtzEDsXPUAk9MI8a34YUbo
         IZIItOqMdA68iyg2aAaR1DcilvIBMLf138mI8p1CcxEeR5Y4HLc/FAFgTqzvodOJCKqI
         ktG0uSdH3ME3Xp3NsBmZTDE59h5Bel1FG39OYUUd5Evhw2e4t32O7wlKU0vQ1JPBrruQ
         v9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792039958; x=1792644758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nK6+12BDaJSc6Zv5ydKjvBfAWgujcnGE1f71j9SWy/Y=;
        b=SIzrOxlSBfFCElPn5PrrDsJK2IUUF3FGmue6WIgwowSPiQslbyND3U1MQkL5FcZ6pe
         xhvKV9sdF09FXjBS+8QlpwVjxezG91XsdmpVk1bqoqAheLDk/+3CvWNkv9zXFLJFubtM
         6Fj/A/scD2V4Njz0EO5LyzmK7HlvbwMGqRPY567DZQWQu3tOiF3ZV4kCnP20ro+Nd4ft
         kQ987YYfqunhTr0KgB4OI5r5oDdJjsgYjlJGyERClKJJuKAPSjEZNYFEcv8GOsddma6V
         BfcbkaJVAhaSnayqFn/w75Vg/0eC83WLMrAjVjOJIqbIiD8ktAkPgK1wpJMHB+fF0uv/
         +OUg==
X-Forwarded-Encrypted: i=1; AKwUvBxOFyVKttjpHk6OBCooFyAtqRVwhpdenSdfJLS0etolgr90z9wwrPsK756JOwTILhyMln9plsM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrByEa+tIXcWWIp70cqmEeBQRAD2M0P98kyhAUxgGQc0D+zCV1
	NTEAdOplBHKmhvrSOwPDL37174V8GVbUcVpBfox1Abr5s/dM5L3JHRZGCBXTtCAg7ww=
X-Gm-Gg: AYBFou30WgmtUn5Aes1BxPdynn4CK1YEkFCYm0QtJC1cheLe7e4PN/xcXOOahIKnWs7
	gNU5XYTaq2x1hJECzHFfwJBBBgWRoLiIdJL/mKPCye6PYh3uW2/p6ingf6nPHsPzYQwXdH/qBzt
	pJPG3KotjIkVoP8sI/gHER3F0SgF3WidWcLt+4tyDCwn4RdkYksLddgqtFZBaYhH7VW2VOQkU0X
	5kIFgahOOpuLgwXhwOi6Uivwv2doFp56EQCNFmIHKrrwmXulHwoM0bOa++olL9J6XpvEtq8Goz2
	f+59yBR86O34ol3xZmHtQnpWjA5dEAf8wjZz5E8qmw6ijJqd7e+m6683gC+a7tFWBBYIxH82nhl
	C5xaaHAjSYY5XCVAy6ahh9Tu1O9se8oxvm5W1qXPBUF4L8nHkqizcGyJtE7yHz007PTG7g4GazQ
	H1qW06m3sNBZ3NzViq9Yk6iTpZ5qI3WIhYbFdp59hcxw2aIWYdgt4vd8I+ux+2hVsaaJnnPU0fK
	Ay8xVTVIs5Dveqf
X-Received: by 2002:a17:903:2987:b0:2e2:b557:aa56 with SMTP id d9443c01a7336-2e842dfb377mr145527345ad.57.1792039958534;
        Wed, 14 Oct 2026 21:52:38 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e962a4dfbbsm1615915ad.58.2026.10.14.21.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 21:52:38 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v9 7/9] scsi: mvumi: free the internal command buffer by what was allocated
Date: Thu, 15 Oct 2026 13:52:11 +0900
Message-ID: <20261015045213.3975845-8-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015045213.3975845-1-yhlee@isslab.korea.ac.kr>
References: <20261015045213.3975845-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvumi_internal_cmd_sgl() allocates the internal command's data buffer
with dma_alloc_coherent() and then publishes the address and the length
to the controller by writing them into the command frame: lower_32_bits()
in baseaddr_l, upper_32_bits() in baseaddr_h and the length through
sgd_setsz().

mvumi_delete_internal_cmd() did not keep any of that.  It read the frame
back to work out what to free -- sg_counts to decide whether there was a
buffer at all, sgd_getsz() for the length, baseaddr_h and baseaddr_l for
the address -- and handed the three results to dma_free_coherent().

That rebuild does not say what it means to say:

	phy_addr = (dma_addr_t) m_sg->baseaddr_l |
		(dma_addr_t) ((m_sg->baseaddr_h << 16) << 16);

baseaddr_h is a u32, so both shifts happen in 32-bit arithmetic and the
term is always zero; the upper half is never put back.  That is not
visible today, because the driver never raises this device's coherent DMA
mask above the 32 bits pci_device_add() gives it -- dma_set_mask() moves
only the streaming mask -- so dma_alloc_coherent() cannot hand out an
address with an upper half to lose.  It is still not the address the
expression is written to produce.

Rather than widen the shift, stop reading the frame back.  The driver
already has every value it needs: keep the address and the length in
struct mvumi_cmd next to the virtual address it keeps there now, free by
those, and decide whether there is a buffer from data_buf instead of from
sg_counts.

sgd_getsz() and GET_COMPACT_SGD_SIZE() had no other caller, so they go
too.  sgd_setsz(), which writes the field, is unchanged.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 19 +++++--------------
 drivers/scsi/mvumi.h | 12 ++----------
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 2410d2aa147d9..133e53bc2cb37 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -238,6 +238,8 @@ static int mvumi_internal_cmd_sgl(struct mvumi_hba *mhba, struct mvumi_cmd *cmd,
 	m_sg = (struct mvumi_sgl *) &cmd->frame->payload[0];
 	cmd->frame->sg_counts = 1;
 	cmd->data_buf = virt_addr;
+	cmd->data_buf_phys = phy_addr;
+	cmd->data_buf_size = size;
 
 	m_sg->baseaddr_l = cpu_to_le32(lower_32_bits(phy_addr));
 	m_sg->baseaddr_h = cpu_to_le32(upper_32_bits(phy_addr));
@@ -286,21 +288,10 @@ static struct mvumi_cmd *mvumi_create_internal_cmd(struct mvumi_hba *mhba,
 static void mvumi_delete_internal_cmd(struct mvumi_hba *mhba,
 						struct mvumi_cmd *cmd)
 {
-	struct mvumi_sgl *m_sg;
-	unsigned int size;
-	dma_addr_t phy_addr;
-
 	if (cmd && cmd->frame) {
-		if (cmd->frame->sg_counts) {
-			m_sg = (struct mvumi_sgl *) &cmd->frame->payload[0];
-			sgd_getsz(mhba, m_sg, size);
-
-			phy_addr = (dma_addr_t) m_sg->baseaddr_l |
-				(dma_addr_t) ((m_sg->baseaddr_h << 16) << 16);
-
-			dma_free_coherent(&mhba->pdev->dev, size, cmd->data_buf,
-								phy_addr);
-		}
+		if (cmd->data_buf)
+			dma_free_coherent(&mhba->pdev->dev, cmd->data_buf_size,
+					  cmd->data_buf, cmd->data_buf_phys);
 		dma_free_coherent(&mhba->pdev->dev, mhba->ib_max_size,
 				cmd->frame, cmd->frame_phys);
 		kfree(cmd);
diff --git a/drivers/scsi/mvumi.h b/drivers/scsi/mvumi.h
index d20eea2b61a31..3fc76addbf304 100644
--- a/drivers/scsi/mvumi.h
+++ b/drivers/scsi/mvumi.h
@@ -189,20 +189,10 @@ struct mvumi_compact_sgl {
 	u32	flags;
 };
 
-#define GET_COMPACT_SGD_SIZE(sgd)	\
-	((((struct mvumi_compact_sgl *)(sgd))->flags) & 0x3FFFFFL)
-
 #define SET_COMPACT_SGD_SIZE(sgd, sz) do {			\
 	(((struct mvumi_compact_sgl *)(sgd))->flags) &= ~0x3FFFFFL;	\
 	(((struct mvumi_compact_sgl *)(sgd))->flags) |= (sz);		\
 } while (0)
-#define sgd_getsz(_mhba, sgd, sz) do {				\
-	if (_mhba->hba_capability & HS_CAPABILITY_SUPPORT_COMPACT_SG)	\
-		(sz) = GET_COMPACT_SGD_SIZE(sgd);	\
-	else \
-		(sz) = (sgd)->size;			\
-} while (0)
-
 #define sgd_setsz(_mhba, sgd, sz) do {				\
 	if (_mhba->hba_capability & HS_CAPABILITY_SUPPORT_COMPACT_SG)	\
 		SET_COMPACT_SGD_SIZE(sgd, sz);		\
@@ -259,6 +249,8 @@ struct mvumi_cmd {
 	struct scsi_cmnd *scmd;
 	atomic_t sync_cmd;
 	void *data_buf;
+	dma_addr_t data_buf_phys;
+	unsigned int data_buf_size;
 	unsigned short request_id;
 	unsigned char cmd_status;
 };
-- 
2.43.0

