Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050645;
	b=zXO5VtdSpxeG5PX+TxTikSYNk8rPDZn691qsr48YRPPjRa8FFe3NVb921sOchvs84TYI
	 8G/1lrg5fH1UNGafnRr3DIjou9RXjjd1MctsUeMSkSAiyTrSNP2YQLWIewnFVcAl2svQL
	 HbM9yxDn9jusDRjIq8T/oZxuaMthMpXVLmENBnXbGMU58OpEMFT3Hmka6T9DsQbkkXYU3
	 k1rrmvsQ2zOX3zaKXCCo5bTTq8OSg8/dglI0/PmOQken94CYoz7B2Ww1NF6cj4nCS1D76
	 EuJSUFkU1jLtHM+9ZCkSGyLzbobgYjOCLVzt9OF1Mw1ztu6Hk2QZtLX9UCuklKWLOew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050645;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lLYFdPy3YdFkV2f/++/mr6qlRzzpmklS55Slw6x846Y=;
	b=K1y7LFJ/tzzktCmGQf6pQDdvdHU1K19th800xZ+C+Uq2989JUU86oA0mR/J5JTnZZT82
	 kugkt1mGo3tvSpZlK0/boTdBouKL/EwQJljBz6l2kUcuhw9AIxM3Wcd+2bVOsazfZyY95
	 XR5XR1GArAwwJC1KOIcZ/i10ikq6gR7c9DdsFF6/XdlUX04pDsTpTyy4u+px+ZVQq2pOW
	 hA6E3ZQA27fG+c0PQ9wormdIWOQm1MEtg6qLCEc/vEUhi8lUNQEtqC1XoI8JkF75iU5cu
	 0Ns5tItIwBf6cRnjyP5dEVqRkC1zmmrsqr8wg+k62vnmVyD7MXjU6PBaquS27OO7zlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVQUO62P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C9606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVQUO62P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C791F0089F;
	Sat,  7 Nov 2026 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050644;
	bh=lLYFdPy3YdFkV2f/++/mr6qlRzzpmklS55Slw6x846Y=;
	h=From:To:Cc:Subject:Date;
	b=MVQUO62PNXCWN/0kd+VNs54bcqEd8TP4NI0pbesPGrTNfNR9+vsz8n6yOBK0UEQUt
	 BuGlQ6+emrpkKojbIP5xs4F5xyZKaXjoFg5Jnc/Tgi31A4mXNX9vTWL7XfEi//91FX
	 q1eHHhB8NQi0r7HzE0R2/SQ6o5exnWqsGsyeVxOZxsRJ8EJxJw5bMQTTuWOzq8vOpj
	 Y3WVegj4ty/XstJfwVsIMUnvgKVsOklMhHPES+AsB1QWYAPWrCiu+9U1dLXWOlxsVt
	 29j8i3eytsgfCc+9Z1hzif7FYckC1m8CEiwJxZmebaXC22f8r9XgI/naxMfuImErXH
	 ++Bjsmu/Zd+aw==
From: Sasha Levin <sashal@kernel.org>
To: liuwb@xiaopeng.com,
	zhugl3@xiaopeng.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:24:02 -0500
Message-ID: <20261107062402-failed-5.10-9e44f0df3fff@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9e44f0df3fff215d9033089e85980048c3ac132a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062402-failed-5.10-9e44f0df3fff@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




