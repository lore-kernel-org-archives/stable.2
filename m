Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193594;
	b=ADHra0xnXo2S/jhVofwwvtY0w63d7E9W/lwBpcS48TzNtr6jcrzveRMJfAOZQW5aNiPt
	 OxC1Tog3wnlTkwIATHClL/4CeITdwLIGloljAYY4zCEpDlCN/ETUDtDy4hRdLlqhwUM0U
	 LHBqgd6HbY0itiyBrNaPFCj6gtLIoM4//5N59dD0U3i1OogZskcF9WP8NcKsLhEgtFdx+
	 7p3J7N6MhvJ2vVuz4gNUgy16D8QujbIMfXaN2q4OX4uzzkYi+JkOS95PlUODIOKo/N+9n
	 9COpGatboXwUt02AJ0G5f7zHpCK5RB+0Frl8kTxUVwZ3SH5q1rLwxJ3uMU7vCArbHFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193594;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VxlGfS3X6ILOos70Tt59OZFlL3UM7j1W08+hOtiDIFY=;
	b=CtrMWYoOJfoam8mdkTu2NunOvZ2gdTs/0uaiJ/UeT6at/2PAkMF5Fli0yPOS8QUJZgsB
	 iuqlSr3WBWB3JBkKfm3FhFG2SRHn1jF8IvZpHB3Ea0BkRewoxFCLYwHYA1EOrYIzRXBWW
	 9P/RSIGfh6B3P/sKq6x+giN50QM5x4Jwrfoh1hg45qW0mfyzaSSf7nKK3AJ37NYkxQ/fa
	 pqU2RKF/iYJ1i4DZzKmHooFVk+bDx3admb2YmZ4ONXe1f0pSVsMxXbRsUr+7gY01acYsy
	 tk6zwSfSVknCasXeClSGEfS/BwhPuv94OHgoQBqdKIz5Jh/iC/oVsO3yHi1swe5qAkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=XGes44cj;
	arc=none smtp.remote-ip=115.124.28.1
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8B606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83B8B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=XGes44cj
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794193584; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VxlGfS3X6ILOos70Tt59OZFlL3UM7j1W08+hOtiDIFY=;
	b=XGes44cj9bXfBsNSPU+HyY7pUFkRwxl6+h/AlH4RtX99tj7T94plpHJVfYQRtujgyZ9T+KrMvsW5QfDTEnUV9PJ8T2eJmWRBRL8UCpwVAi62D1imCQ6Fx7oWe2PdYf71zkYvmg7zs8+hSIAFdAk6yiierADSt4wnKpGfo76jw+Q=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0746418|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.000764664-5.72168e-05-0.999178;FP=16997243140937108936|5|2|3|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.jzgkbBK_1794193583;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jzgkbBK_1794193583 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 11:06:23 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: liuwb@xiaopeng.com,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.10.y] spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op
Date: Mon,  9 Nov 2026 11:06:22 +0800
Message-ID: <20261109030623.419544-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107062402-failed-5.10-9e44f0df3fff@kernel.org>
References: <20261107062402-failed-5.10-9e44f0df3fff@kernel.org>
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

From: Weibin Liu <liuwb@xiaopeng.com>

[ Upstream commit 9e44f0df3fff215d9033089e85980048c3ac132a ]

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
Link: https://patch.msgid.link/20261015-bcm-qspi-dummy-bytes-v1-1-c319da3c2497@xiaopeng.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ Adapted for 5.10.y: this tree returns -ENOTSUPP instead of -EOPNOTSUPP. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
 drivers/spi/spi-bcm-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 898658a..a01748c 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1024,8 +1024,9 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 	u32 addr = 0, len;
 	u_char *buf;
 
+	/* cmd[] holds 1 opcode + 4 address + 1 dummy byte at most */
 	if (!op->data.nbytes || !op->addr.nbytes || op->addr.nbytes > 4 ||
-	    op->data.dir != SPI_MEM_DATA_IN)
+	    op->dummy.nbytes > 1 || op->data.dir != SPI_MEM_DATA_IN)
 		return -ENOTSUPP;
 
 	buf = op->data.buf.in;
-- 
2.43.0

