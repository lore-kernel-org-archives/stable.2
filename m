Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050884;
	b=hfKKU80mPsH6vMx1EbXXALg44GQDx7wrIAYUxgvRXvDalg74+r7A7XYL17XA6NuR4xNT
	 9igs3QsW0F8ERl837Fn6gxNsGN9mvCf4EJiZq4fjknYE8RP0DCiRtOvgV9WUCsZlOBljU
	 2eItsbfSSmr1Zior2k9q/ISyRl+YIma9hbU/4ITWNrRQJSChDzBZ1FBX5h3HSfdPf9jDQ
	 ijerhY4ldT/zs+MkYvEGRzEpAmr889MwJciXwmE03VscJLAyL+TRS59b7sfQtZEiwBYyd
	 N8IWFAGmcY34xemD4eebOpIU645IiNq1WhXa2KVASizFE80jHOLYI+eI5Klle6qeipQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050884;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=55E5CGpfFEkzt1B2ZSEMLJwqcBt/SBqnGF5f01AIJ4w=;
	b=MVk+hUfZsEje1gmk71Kn7yl3sGgYkKDURL5YWckXZldMwqro1ZYpcSTHzJ6EtkqEBkjL
	 poFsXkhcdvyI3JFKk/j9l9EnwOgR2OBzs21b9zwxRThWVc7ZWWqI83c/mK8SZ9AVpoXPq
	 ir/Jpn0TU8sfHpYysniwamBvV8CPevsXi2jdJt66PSvR308wyWCtuwlgCWM9e5wtD5kmu
	 J0UPUUzmntoph2GNm24b3vdfC+ThZxJz66aDXhQPS4pNfS6qKGYSMHrpM+/hgoajdGJXl
	 oATlEfRQgRL0LPIBGBLy/JiEEIrb1WBGoqcxIVf7kbRwsmg10Mg7kxtwuZPA7rTducA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RrNxqqtn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RrNxqqtn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE1C1F0089F;
	Sat,  7 Nov 2026 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050883;
	bh=55E5CGpfFEkzt1B2ZSEMLJwqcBt/SBqnGF5f01AIJ4w=;
	h=From:To:Cc:Subject:Date;
	b=RrNxqqtnQcwI825+dKZMUHr0YzsHXiaJBF3+Qy6st3fhQXl8IvJjFGZuNMC0TM7t6
	 TCMyXVoHmtykMwSdQWioThN5O1amIemdJCm1j1FV1+A3vvVcE1N5wPAmjJfMUefLEC
	 szOKiguc9qZJ/LDj4lScpxfadyliqBXE4hfpxyHG8hGeyO0va0kjRl7lG/sq2HQUx4
	 QRFJDxllMdVVZieaFfLed27RSyRl7AvEzb940FCDWZGRPUKuNPUpvCExBumCAlZY1c
	 9yjBNtFPvVACwassOu7SJK8rvK1iwm4ThBYGgUaJxneoEENn77I6dh7mI2wovY++1G
	 OLN/l+qN2hhaQ==
From: Sasha Levin <sashal@kernel.org>
To: cyan2254650260@gmail.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] spi: zynq-qspi: fix address buffer corruption and support 4-byte address" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:28:02 -0500
Message-ID: <20261107062802-failed-5.10-dc5ca34f5e8d@kernel.org>
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
git cherry-pick -x dc5ca34f5e8dc10c566ef39aa3b1a201a17ca734
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062802-failed-5.10-dc5ca34f5e8d@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




