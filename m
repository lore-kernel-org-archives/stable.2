Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049857;
	b=Q61XUiOQr3tW5yL9hxAhabgSpf2rviR2U/M4vkPPtAzK3H3KeSfPw4uhitFmRfZZbRBn
	 FENRyaz4JPKyiDdjmBmmjmCw3WIk5+R6EUt681nnb6Rid+9uiVW2P2vAKJtoaAP+lQcCi
	 I9PJihisdgW9Psl2vbWoDZB88XSrSPEfjiQ821AvWik/kONOfpPcgp/dnbDb86y1AOf74
	 tJAgMs+y8+sD+q/PIMCACbzQbmGkWRcVIgNhB9zElp6wO0kHelRBxDEBfCjVZgcbYheXJ
	 RD9LHTMFRCbkdNyVZL/Riwp40UJEbha+V8nG8oOuMbfuV3hnrrOustiZySQfOn752JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049857;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nM/cnVc3CLuot/k94U0/r3DXHN/aWGrm5v1Sn4oASBE=;
	b=EBN4dFqIDegis3cAu/Udoe0fq8oD2Adr2k0SKnruSRt3a8rRKTHbdHM3HR010ivtwq8o
	 YmlhmOb3/l77VpyFP4buUfeaKhoP6wW2Zir+Ad3ewSi/E0qeL/8RWhnCGF8XOTg+uwfJ/
	 oEQzsKPX420GyLcHfCHolnzArygNIfsK7oSi53qPdbcNEZGdtDfpEKMD4K0L9NhGsOdKz
	 wlWdproyV8LwAmghRojPMDBpOzRVmroJRHqGUDG3ct3S5l/vb7Y944ghBBBaVmqOy2RPX
	 yFK9lpr7MBWzoVOxA2J4zzRqqFHCHNn3nlg6x/3ZUaymmDOiRa4gcWP83xOleb6yp9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpWwukvA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpWwukvA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA48D1F008A1;
	Sat,  7 Nov 2026 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049857;
	bh=nM/cnVc3CLuot/k94U0/r3DXHN/aWGrm5v1Sn4oASBE=;
	h=From:To:Cc:Subject:Date;
	b=bpWwukvAknoNm+LjJXVo9Qz9UgahjbvhrzCtoWqADuuqAReb2kczbHA+ORfenHjfK
	 x1mGnE1MfovKvSWKnAyidOZsVOQg4iyFZgcmLNGclRd1ESCOl/kwK8jdQ3Niu+zx9Y
	 TC7tqq80oGuIKOFb17PQLwJ3QjIM3HkRVlaAFfH0S2tAJLkIp1x7PCq4tqNQ0Ne3G0
	 yj8SyF5rlMJJqSmqfRbC/t5Fs7U983lub2ZDFOwoOMGZjNWqcvgHEuc3wbxI1WVXSi
	 uJKws7oGeZtCwiiFl4G6GhYSUktyN8pKI5s27F5yKPORyRdeuM7SBVIeXkPvjOb3Xy
	 dsTNniRjCch1g==
From: Sasha Levin <sashal@kernel.org>
To: cyan2254650260@gmail.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] spi: zynq-qspi: fix address buffer corruption and support 4-byte address" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:55 -0500
Message-ID: <20261107061055-failed-5.15-dc5ca34f5e8d@kernel.org>
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
git cherry-pick -x dc5ca34f5e8dc10c566ef39aa3b1a201a17ca734
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061055-failed-5.15-dc5ca34f5e8d@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From dc5ca34f5e8dc10c566ef39aa3b1a201a17ca734 Mon Sep 17 00:00:00 2001
From: Pufan Jin <cyan2254650260@gmail.com>
Date: Fri, 16 Oct 2026 21:08:12 +0800
Subject: [PATCH] spi: zynq-qspi: fix address buffer corruption and support
 4-byte address

In zynq_qspi_exec_mem_op(), when transmitting address bytes, the driver
iterates over op->addr.nbytes and populates xqspi->txbuf[i]. However,
xqspi->txbuf is never re-assigned before populating the address, meaning
it still points to (u8 *)&op->cmd.opcode from the command phase.

This causes two severe issues:
1. Memory corruption: Writing into xqspi->txbuf writes past the opcode
   buffer on the stack (which was passed as const struct spi_mem_op *).
   If opcode is zero, xqspi->txbuf is uninitialized.
2. In zynq_qspi_supports_op(), operations with op->addr.nbytes > 3 are
   rejected. When paired with SPI NOR flashes larger than 16MB (such as
   Winbond W25Q256), spi_nor_spimem_check_read_pp_op() tests 4-byte address
   support, which fails and causes spi_nor_select_read() to drop all read
   capabilities, failing probe with -EINVAL (-22).

The Zynq-7000 QSPI controller hardware in manual I/O mode natively supports
transmitting 1 to 4 address bytes via its TXD FIFO registers
(ZYNQ_QSPI_TXD_00_00_OFFSET).

Fix this by introducing a local opaddr[4] buffer in zynq_qspi_exec_mem_op()
and explicitly setting xqspi->txbuf = opaddr before populating address
bytes. Also allow up to 4 address bytes in zynq_qspi_supports_op().

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Cc: stable@vger.kernel.org
Signed-off-by: Pufan Jin <cyan2254650260@gmail.com>
Link: https://patch.msgid.link/20261016130812.282624-1-cyan2254650260@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index d762aaf452afd..bfcbcfe85b918 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -229,11 +229,10 @@ static bool zynq_qspi_supports_op(struct spi_mem *mem,
 		return false;
 
 	/*
-	 * The number of address bytes should be equal to or less than 3 bytes.
+	 * The number of address bytes should be equal to or less than 4 bytes.
 	 */
-	if (op->addr.nbytes > 3)
+	if (op->addr.nbytes > 4)
 		return false;
-
 	return true;
 }
 
@@ -526,6 +525,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
 	struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->controller);
+	u8 opaddr[4] __aligned(4);
 	int err = 0, i;
 	u8 *tmpbuf;
 
@@ -547,12 +547,13 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 	}
 
 	if (op->addr.nbytes) {
-		for (i = 0; i < op->addr.nbytes; i++) {
-			xqspi->txbuf[i] = op->addr.val >>
+		for (i = 0; i < op->addr.nbytes; i++)
+			opaddr[i] = op->addr.val >>
 					(8 * (op->addr.nbytes - i - 1));
-		}
 
 		reinit_completion(&xqspi->data_completion);
+		xqspi->txbuf = opaddr;
+
 		xqspi->rxbuf = NULL;
 		xqspi->tx_bytes = op->addr.nbytes;
 		xqspi->rx_bytes = op->addr.nbytes;
-- 
2.53.0




