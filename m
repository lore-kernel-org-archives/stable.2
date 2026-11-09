Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193586;
	b=LxZATOCrhmpyQUU92sKiC+1edDENLo80v54xealaQdLrGhBJxyiKjbml6vE0Z9px7NSX
	 f+POlyGQsZmkKcHeInJbtHsEnZmIsF2bxBX0wL0SBLDeU2twsyBqMIPe8Lk+sLRRR3Ut5
	 709BLo0sYmFrHcuFqLxeimSU9cZvmPbzFr0TtAcb3eOlsXQQkTGRt0rkvlZW5YgL+gzz5
	 RvPAyB1GS/YRniYJ+Rybg24bxuas8cXqDE5JfTSqiJLr7DaA36Rfb4CZNZRrYmsgDH/HF
	 unaEQHjTV5ElrwoH5x+nXIcXDOCvs1hgrxZLcPj7nOuqvFMwrbtnghsEdrWiWKA/buw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193586;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SdY7E+Kl7jCh4LeRWf7UfzZFz2jYdkBFjUFWFjDL6fc=;
	b=O2a+BfITB0gCqNhqg72m63sgwprquPqXhGU+8tBbbHJhdt2wI2yEErCg9etg0/Qr/IIW
	 9dpLjITEw5ln2UoEN1nExeh4Vq0dNXlC+hbJuveDcFOyt0FMuU0ykf9z6eO979znZFNxi
	 p2mcYwpB9D1VZPOybNh+8EIS3B2bJ7RSwAz5Ng4Qz5avGbFS5JAhDlptkjk28u+e4PNQN
	 6eylBOPUjW3c1ififedbZLpfWbOhE9L05m53RCPmG46BG1/Fsjgk/evGkHcnp/rC7OtOP
	 1QceWETOGxWKgeSCLvOLB1gPkJjtT2xzw8fqO2SgmufQR/JLwSMDOdYjHLmiWsEbctw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=tA0xPs1R;
	arc=none smtp.remote-ip=115.124.28.145
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99311606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99311606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=tA0xPs1R
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794193578; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SdY7E+Kl7jCh4LeRWf7UfzZFz2jYdkBFjUFWFjDL6fc=;
	b=tA0xPs1RsWBBREc0SNXMLIvKOIcntj/RsPft/rsd0Cvwmmu+xk2vAZRY5GhhNalNdheMxYtQDZR7OcDfGOy1gBVeHziQ0asDOWYBCewldQl4/OfkgojWNnGMM/ST/HDy+cQxN3lZRfBsBO7fGqrC0EmOgAbo7K3fo1el1hoFJmM=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07465642|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.000859849-6.37942e-05-0.999076;FP=16997243140937108936|3|1|2|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.jzk5.YU_1794193577;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jzk5.YU_1794193577 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 11:06:17 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: liuwb@xiaopeng.com,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6.y] spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op
Date: Mon,  9 Nov 2026 11:06:17 +0800
Message-ID: <20261109030617.419442-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107053540-failed-6.6-9e44f0df3fff@kernel.org>
References: <20261107053540-failed-6.6-9e44f0df3fff@kernel.org>
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
[ Adapted for 6.6.y: this tree returns -ENOTSUPP instead of -EOPNOTSUPP. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
 drivers/spi/spi-bcm-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 0407b91..dd6fbdf 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1197,8 +1197,9 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
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

