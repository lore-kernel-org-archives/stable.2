Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803537E5EB;
	Thu, 15 Oct 2026 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030225; cv=none; b=iw9j1eLNAYe+qnRgl1kDsbJbXBnxSaFcARsikOjDM43UmDjC+SlA+cn3WQeOSCryan26QltKHR90gtgmeJ84DF47WUcwv1Ih+vKokfcnEPtUw/W3cUxpCY4CQ3xBZKprgVOreGw6RFPMz2iBaQsEpFy5Pa/lclbkAK7AyNY2rDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030225; c=relaxed/simple;
	bh=UciLElILb4MREYhywIGPFVAqEkpc2MfPy8vmCW9C5xY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sxwdWBJ6abSpWqBgTBzCqo+Y3Z6RIFYE00zNK9fqVf4ZmBiUPYZ4XzlgCsEA+Tw9F6+7mEuz3Kon/t/avOG2leYpfjJBFj/efjq8dL8TUPBE8ei5K1llwgXCkyKuqJ/zB+E/ZWDQ+Txc4fEuIxzFJH3a073NLJH8FTTyQLtSr18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=YEMbG3jv; arc=none smtp.client-ip=115.124.28.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="YEMbG3jv"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792030214; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	bh=wHwAcuqNgX1w8cGpzkrIWY0kOgSy8n/NTCpBn8jlIEg=;
	b=YEMbG3jv2lnJ1S90yl08yUFEzWZFpaxC9B6k1XmQ7m9Or+bsIw6R+g45NpyJ4tPlN7ySQSttVK9lOL1dK+6MkzsoXFHKqxjv1LE9kleaoan2lPvE6G5UeigMMhNCcfarv1YpnuA9SniBz8kr9TPsDBe0nd5yua5abtMErHrwT0Y=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07574709|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00277256-0.000464609-0.996763;FP=9667071803597065642|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.jdzWobX_1792030212;
Received: from 127.0.0.1(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jdzWobX_1792030212 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 15 Oct 2026 10:10:13 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Thu, 15 Oct 2026 10:10:12 +0800
Subject: [PATCH] spi: npcm-fiu: limit UMA data_size to the 16-byte staging
 buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-npcm-fiu-uma-datasize-v1-1-7dee91cadee6@xiaopeng.com>
X-B4-Tracking: v=1; b=H4sIAAQ20GoC/x3MQQ5AMBBA0avIrE3SimriKmIxajALJS0ipHfXW
 L7F/y9EDsIR2uKFwJdE2XyGLgtwC/mZUcZsqFTVaKUN+t2tOMmJ50o40kFRHsZhYEPGOGtrC7n
 dA09y/9+uT+kD723namcAAAA=
X-Change-ID: 20261015-npcm-fiu-uma-datasize-bbe5a55c7747
To: linux-spi@vger.kernel.org, tmaimon77@gmail.com, broonie@kernel.org
Cc: venture@google.com, andrew@codeconstruct.com.au, yuenn@google.com, 
 tali.perry1@gmail.com, benjaminfair@google.com, avifishman70@gmail.com, 
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
 stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>, 
 Weibin Liu <liuwb@xiaopeng.com>
X-Mailer: b4 0.14.3

npcm_fiu_uma_read() and npcm_fiu_uma_write() use a 16-byte on-stack
staging buffer (u32 data_reg[4]) and move data_size bytes to or from
it. data_size comes straight from op->data.nbytes, which is supplied
by the SPI MEM operation and is not bounded by the driver:
npcm_fiu_exec_op() only validates op->addr.nbytes, and no
adjust_op_size callback truncates the transfer to the controller FIFO
size.

A SPI MEM operation with addr.nbytes == 0 and data.nbytes > 16
therefore overflows data_reg[] on the kernel stack (write path) or
reads past it (read path), corrupting the stack.

Reject data_size larger than the staging buffer in both UMA helpers
by returning -EOPNOTSUPP, so spi_mem falls back to the generic SPI
message path. The chunked path in npcm_fiu_manualwrite() always passes
at most CHUNK_SIZE bytes, so it is unaffected.

Fixes: ace55c411b11 ("spi: npcm-fiu: add NPCM FIU controller driver")
Cc: stable@vger.kernel.org # 5.4+
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
 drivers/spi/spi-npcm-fiu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 96dfef4d9067..9c0a655a54b3 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -343,6 +343,10 @@ static int npcm_fiu_uma_read(struct spi_mem *mem,
 	u32 val;
 	u32 i;
 
+	/* data_reg holds at most 16 bytes */
+	if (data_size > sizeof(data_reg))
+		return -EOPNOTSUPP;
+
 	regmap_update_bits(fiu->regmap, NPCM_FIU_UMA_CTS,
 			   NPCM_FIU_UMA_CTS_DEV_NUM,
 			   (spi_get_chipselect(mem->spi, 0) <<
@@ -398,6 +402,10 @@ static int npcm_fiu_uma_write(struct spi_mem *mem,
 	u32 val;
 	u32 i;
 
+	/* data_reg holds at most 16 bytes */
+	if (data_size > sizeof(data_reg))
+		return -EOPNOTSUPP;
+
 	regmap_update_bits(fiu->regmap, NPCM_FIU_UMA_CTS,
 			   NPCM_FIU_UMA_CTS_DEV_NUM,
 			   (spi_get_chipselect(mem->spi, 0) <<

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261015-npcm-fiu-uma-datasize-bbe5a55c7747

Best regards,
-- 
Weibin Liu <liuwb@xiaopeng.com>

