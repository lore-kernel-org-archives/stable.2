Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049626;
	b=eO/uLECs+jauo1F9MztF1cGH78lJK3aE2TdBC38fufis+j4WJSDb5ADCHjmFhcXGP+JD
	 e718CZJzavmHe0ueX7Ww+UsECj6V35DwORekcUh/hsChJsvLkAjMKw+bienqP3DqhIvnm
	 zR9W7xGbsEHgKw9iq7fDdI9NN/hqf9X3twLYOui3mttIa9RdN5m0tLr8r6WiZS0PqMo24
	 CpbazmjSn6KSqheuXQZh0xfXg9v3Q74kyAjlxLskkY3KODlrY77Lm6odODLvC3awS2MeM
	 ff2BQLgN/nMxQZvAcVHhYaIcViNnBSo4QFYn2jfUlhozMH4X7e911+9osDP3pm0k1Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qjO9YOnYMa6bPiKqnZyHKOMOJojZIu3hTmgxtwqbyP4=;
	b=yftu/r2rmUmxsW6Sh6mi3L/9CVAaPaZBbRVu4I2JyRFrHfhw/dUJEM6QXdarB4th17Yr
	 gC4VvMnlv/aAhVR5zw+2xFkvDqsttSAK8yIkIWUDaAiM1fUjKQZMyQi+ej8O8T87ZSLlu
	 mlBCJyQTPca+WVOL2ncNVTdALskal7CMGeR9WxC776unOlbK71+0wBpOvVFE+sYtibGcf
	 CqnhuMWwuteGD07cz6zy2eGY5dGUs30j+BVdK2AIJGWc0BgQv0eyWKLWtnI9c75vhwIsD
	 fxWsFM9SQGNacXLSF1w62wl4zVHZQvtAqLB3n+v48LuB5fv0ZtlEUPT2joWO1STAyfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVRTz5mV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D96606A33F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVRTz5mV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13E81F0089F;
	Sat,  7 Nov 2026 11:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049626;
	bh=qjO9YOnYMa6bPiKqnZyHKOMOJojZIu3hTmgxtwqbyP4=;
	h=From:To:Cc:Subject:Date;
	b=SVRTz5mVQt0NYz3OmBDZKlr3LyIzBvUYxNNyRAlSfm4SWikTKOfVi+axREdBT/Qyn
	 SF+aQHkTXR//5YGY7Gv8FRbYXbEIAJmCtocizJh0trKWG8Vm8ZLpgOMNEz7Ng/BXkg
	 Ts5NBSJqwcg1tYiz/mlokyiaEJh11fFvp3EiXeLHy2f54lKCI6ye1YUN0NZ7PRi8S7
	 qRW+QiUBA8axrt3nYwmfTBivNqpja/lDkqmgsJRr/Q5BvBkxlkH2ibk8eMlZ+YbFaX
	 utjrDVTQKRzr70EP2+I4Lp/N+igOzq06Db7InQWdLvTEoK9nBdggRhWvi6YlDidDLD
	 LZgtYpr5L+hZQ==
From: Sasha Levin <sashal@kernel.org>
To: liuwb@xiaopeng.com,
	zhugl3@xiaopeng.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:04 -0500
Message-ID: <20261107060704-failed-5.15-9e44f0df3fff@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9e44f0df3fff215d9033089e85980048c3ac132a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060704-failed-5.15-9e44f0df3fff@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




