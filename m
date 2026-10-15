Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D3F3D6493;
	Thu, 15 Oct 2026 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030578; cv=none; b=PKSeW/5GCZ1BkcyJrN2eOw0Zetu4R1AzquCVGCkH7TwONNAvd+a0EtYwyV6AYauhqjbTeUuZirNYnKKViJeu8LnRpZIIhEKJW/bbzvJA1ta9aKbbPbuJPk2qUtAGcE4qZOB4vaJf7FP5P+Tb47NJXExHLY/A1OgX+BOxLkrOKgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030578; c=relaxed/simple;
	bh=S9RXAbD1fxV+7Phdfo8s75tVyogVk4lHoqpw7lldOLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BZuMkyTv4Vs1MT1Mxe9OxxrmBMF8NBzhGdQUUshxoii7rLeJSaqaEwR5i1OTy/gqS+abYPokaD+Hj04thQv1Mx13eYZInooemgWHN1vJUtjIIDqasPGzNK+1XTP8LvhjLFxZWKWhMwMGMxmEGWx2h9134ywhd8ye6rMCkaT5s7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=dpjtKx96; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="dpjtKx96"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792030573; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	bh=PTQkozKG32/AbWZq2CRTfF+dUEjqexBrAzBB3XdgWek=;
	b=dpjtKx96kZVnkYjAHIaejsQYSp9b8vW1LDT8MTxH9VuqYHW6P1TIIrS2IUT2VjvVczz2uqAG+Kse8bP2jABaM3lADO9xBX94W/D+ZXYwHHOnV7/Eg4hJVTdbiEr53eKxr4eZghwGSMoiPmV5egGzlCTWTXu3Kj6yanhH6dFOJJg=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07703851|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00137365-7.81913e-05-0.998548;FP=16420817573073407434|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.je6x72n_1792030572;
Received: from 127.0.0.1(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.je6x72n_1792030572 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 15 Oct 2026 10:16:13 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Thu, 15 Oct 2026 10:16:12 +0800
Subject: [PATCH] spi: bcm-qspi: reject oversized dummy bytes in mspi
 exec_mem_op
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bcm-qspi-dummy-bytes-v1-1-c319da3c2497@xiaopeng.com>
X-B4-Tracking: v=1; b=H4sIAGs30GoC/x2Myw5AMBAAf0X2bBMtmvAr4oAu9lCPLqIR/65xn
 ExmHhDyTAJ18oCni4XXJYJKExjmbpkI2UYGnWmjMlViPzjcZWO0p3MB+3CQIEVrRl3ZIjcQ083
 TyPe/bdr3/QBwYXX1ZgAAAA==
X-Change-ID: 20261015-bcm-qspi-dummy-bytes-e0266f29d436
To: linux-spi@vger.kernel.org, kamal.dasu@broadcom.com, broonie@kernel.org
Cc: bbrezillon@kernel.org, bcm-kernel-feedback-list@broadcom.com, 
 linux-kernel@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>, 
 stable@vger.kernel.org, Weibin Liu <liuwb@xiaopeng.com>
X-Mailer: b4 0.14.3

bcm_qspi_mspi_exec_mem_op() builds a local command buffer cmd[6]
holding one opcode byte, up to four address bytes and one spare
byte, and sets t[0].len = op->addr.nbytes + op->dummy.nbytes + 1.
bcm_qspi_exec_mem_op() only validates op->addr.nbytes <= 4 and never
bounds op->dummy.nbytes, which spi_mem_check_op() also leaves
unrestricted. With addr.nbytes = 4 and dummy.nbytes >= 2 the length
becomes 7 or more, so write_to_hw() reads past cmd[] on the kernel
stack and pushes the leaked bytes into the hardware TXRAM.

Reject operations whose dummy phase does not fit the remaining byte
of cmd[] by requiring op->dummy.nbytes <= 1, so such transfers fall
back to the generic SPI path instead of overrunning the buffer.

Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Fixes: 5f195ee7d830c ("spi: bcm-qspi: Implement the spi_mem interface")
Cc: stable@vger.kernel.org # 4.18+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
 drivers/spi/spi-bcm-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 0f96ac59da11..5031b2142479 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1197,8 +1197,9 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 	u32 addr = 0, len;
 	u_char *buf;
 
+	/* cmd[] holds 1 opcode + 4 address + 1 dummy byte at most */
 	if (!op->data.nbytes || !op->addr.nbytes || op->addr.nbytes > 4 ||
-	    op->data.dir != SPI_MEM_DATA_IN)
+	    op->dummy.nbytes > 1 || op->data.dir != SPI_MEM_DATA_IN)
 		return -EOPNOTSUPP;
 
 	buf = op->data.buf.in;

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261015-bcm-qspi-dummy-bytes-e0266f29d436

Best regards,
-- 
Weibin Liu <liuwb@xiaopeng.com>

