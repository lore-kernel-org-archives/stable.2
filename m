Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047743;
	b=xRBcvYPSp1RnajbtKWUgwAKtkjxSd8KMKUbGzrMNHxu48ZN2ukWHOyogAMGvLHsd/foK
	 gaNVyP8b8FkKRAzrU/q+4ZhOX0USXXFIBk7Xtft3BBmjZaJzHyuEJOMq21dGyQDnCSAdV
	 NNJSOJqifZv5brdnsSX1zR2jSUkLilfwM5ax06sg3Cjr42La8/PiLPgJ7Rfw6IVJgDEzD
	 Kzm9KzUjX8amlctHGI3a3Gip9pDHD7F7so+Im24DWZEAAn0GKMrC4fG0KX4dY7vI9l32d
	 u8RPysTMqxxwmA4RLuY3Axj/abtVk6V2AhhXaE42VlFHJBKI4eC2w/HF7gW8TQXnWXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047743;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=E0i7oK9cTJuFQb3XzwlCFxvHGT05VY+77JT0sHGvog4=;
	b=5oT85fo/0EtPtU2zuEvlWmENqouFgebDL3aKgxqUzEsBQnGU8+xnRHvSYUP1V8HuDV1Z
	 Gz62z62cuWXy83SccpZMtA9fXdUuIGXFSZzdL3dT/+T+rmjK0vk8NSgPIGd16rZ6RfNLL
	 67KioHLG29QyZo3YWauOxBgpCN9EYOXroRtB0kb1/1jxo7aXg/OPTlhBhGKaNXbNljQ2J
	 i1mDX+oa1XPOLBzfpPCifyJekrnvZEWE5F/2YmeApp6BglHah78+b4Le+rsor4e+AmTha
	 zC1nMdNPmssK4MSppLkDItAHbh/VwQL6bfLSsSJpk9dAGHtEgQ4z4W9qNj9iKHIQBSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSuhJEjH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE122606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSuhJEjH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133521F0089F;
	Sat,  7 Nov 2026 10:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047742;
	bh=E0i7oK9cTJuFQb3XzwlCFxvHGT05VY+77JT0sHGvog4=;
	h=From:To:Cc:Subject:Date;
	b=KSuhJEjHHsnb0nlvCCcE9rpVCwt/IV03SePi+sVnDEo6lkfptAaIk5+cdjJRaQhk5
	 Ag+wTNN315799jyr0jK9ae33Cb3GsXjyFjpuO4MRe1lrLyOqhV8Hd2u4lP9/22v3Bf
	 Urv0G79HeaA9J9f6la5W9jugNKEZX+skhYjv4nWRDIoArN9Lm4jHp3pERoEbuLIJaN
	 fm5uCI6MljOnTeInH1mTvzQ1kfpXfzB4psaml4C8ZACE6ee8ZYjjC7vgnF7dnWMUBS
	 e7+YymR7fG0pna89kqEJ5xo/0pDKZ8+fYmN3PRuCVFRKkEuhS30/06itzczjrkrK9O
	 AA8r4GZfJt+iA==
From: Sasha Levin <sashal@kernel.org>
To: liuwb@xiaopeng.com,
	zhugl3@xiaopeng.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:40 -0500
Message-ID: <20261107053540-failed-6.6-9e44f0df3fff@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9e44f0df3fff215d9033089e85980048c3ac132a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053540-failed-6.6-9e44f0df3fff@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




