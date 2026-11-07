Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048599;
	b=DpmxDKJSkmDfO0jyoiMm9yH3MiDboRDynUXtCow/lb/SLasNiR7JF05kT/d262w3ZU5/
	 ulIuk9XIoKFeLDWzeVUTLJGTauV5A3q9lLuKDaAbBWRvReLkIJGcI3S1uBAe8jUtHE0ZV
	 0dYzkq9+84NHyhCPaRMTcCS9kwnH6vLKmTWhL9psnVUMLeQ5+4/XI5T8hseltYTTJeE+Q
	 jdLLEldF5oFyAUZYdqpzSnzm9DJSdRubeEBDLPUSqDSFkXdWRQeC7IdgBUPxepyXEjA0R
	 I37QKpEqPnEii457D0X1bbNSzjVU82yZa5b+TxrW7uMry5YnR6FinXPO7Y92JC7pR1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048599;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XQtWhg9aCs5bId955efwhgX9b+BZv05K4zwlG9MLzvQ=;
	b=13s6j6CDfnUkz4VXtt4k52jQM6Tp+qIcu3ifQ8ilG5VB5bHm8n+nrOOGagB+4csvHjJD
	 DcgAh9VZBhez30Q8lDWC948ox+LfQgEOIu6G83SWK1/pfZ7imrp6hGUrweLWMqviGLgqX
	 +iCo2Sx89WnP46gTVNQLRYsEa/DF9lIWtj5nBV/H21qCULiBB1qh2tp8iaTLj+KruPzLa
	 kzyUdSuw2ZZy1KMFopDwfKC7g8/70jOULhTyGiQ2It/Q1qlMBgv8JPDAP4OoU2Ru9Xp3t
	 NbXBBCJJNsLk2nU+SEiLlzuLN0FmbILFWsCBQycN5ZTzRNCU2FVxnAMFZVWxJtW6xMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCCtIldK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D96606A337
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCCtIldK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D29B1F0089F;
	Sat,  7 Nov 2026 10:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048598;
	bh=XQtWhg9aCs5bId955efwhgX9b+BZv05K4zwlG9MLzvQ=;
	h=From:To:Cc:Subject:Date;
	b=jCCtIldKmRZ27YIymOdUNp2r0f0ziVFZGt1i2P+GjIICxSrbyMA2dRTlivGZ5wltz
	 sFqh+YHz7NcnRYdboIU+D1g8Rebo9S5YGt392onPnqmFcE+9LnnjVW/oUpqGup2VrX
	 fQM3LLYtx5T0ymq86orG6e6F9QkiapDzCYxOCm6vrwER0rz8auoVqDw8g2JP9F+/Yw
	 nK9oAEaSq4z06dslly2ZOYNqMrGGtLh+o0pdpihPjbfO2cS2F0N/fvPOMbnqvHCkft
	 4q/BRs7OGHd2uLgvBL1/GMXtdL7q4pfNpBQW672I9exg09Zm0rbQWFv87hFZ3WX+d0
	 /Z/MbMqIKMr/Q==
From: Sasha Levin <sashal@kernel.org>
To: liuwb@xiaopeng.com,
	zhugl3@xiaopeng.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:49:57 -0500
Message-ID: <20261107054956-failed-6.1-9e44f0df3fff@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9e44f0df3fff215d9033089e85980048c3ac132a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054956-failed-6.1-9e44f0df3fff@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9e44f0df3fff215d9033089e85980048c3ac132a Mon Sep 17 00:00:00 2001
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Thu, 15 Oct 2026 10:16:12 +0800
Subject: [PATCH] spi: bcm-qspi: reject oversized dummy bytes in mspi
 exec_mem_op

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
---
 drivers/spi/spi-bcm-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 0f96ac59da114..5031b21424795 100644
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
-- 
2.53.0




