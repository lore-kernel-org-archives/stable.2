Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF113E1D17;
	Tue,  2 Jun 2026 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406923; cv=none; b=Itwetw+tL6st2tukGWRlYwK3eshQNCCA4+aXhbNuGEuD8d17fpue+NOHEzXXxLklIJPOtZ2WwxXXKODL/cN/UB2ZfGOF6hdHRtxEi57HFH9+GTV8t4kWhqXJLgrtjhVlcBcK+K0lQ1FLAxm3n45wkUKIg6L2tRTm1yE+DNVC5zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406923; c=relaxed/simple;
	bh=46GrvLvuc3Abquq1ngoYfLCfFgAigrm6D87Q7GpT2zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQWPu0nPf6bMjT0W72c3ztwpOj9leFvUsyNH5e6OAxptNFV53d+LlHaecsAgjdixMPGxGasPSj0poAPPbS5Pv1B8TSSrvoAXXbbmBMQ+YsS2EAAbOBu5JCgB/VpnBAhfe9uqaj/5i9XJS1On7NfeP4HWE1efrMPMpTa36CIk2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3FbB+7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3FbB+7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886F31F00899;
	Tue,  2 Jun 2026 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406922;
	bh=tigAzvPOAhkM1zZ1LjDTmzJC8sEde+ltVFI35MgB/YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o3FbB+7rt0/09v/va6NQq+tvGHT4C9GUbpGxPniRWEgRF4uz5hXMBVFooEnYrguLZ
	 qqBN5Q8S88ZAmLCKW0sKo2wkBXKJ0c3rWvVqSUyNOcbq0cO9bmx+x7u/rVpc846lpk
	 irNk6NxVIg/dkfTK0QhmdbLh2bZ+u4CI7Wq8yw9kez+Gv825umfpnrPLrpYQ1kZiM6
	 dRGE4OYlOFhOOXyucJzciWOFTa1/D4ZKhqvMNjYGSAgNICowe5PbME5eAaFAJw3o4Y
	 5BtvhFjPaQzClqjGuzSNplRHaRQXP0M0lPoFweRftl0tNngdUs5oXiyxcAdFX3EiBt
	 KJFVeQal/Zl9Q==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/17] i3c: renesas: Check that the transfer is valid before accessing it
Date: Tue,  2 Jun 2026 16:28:08 +0300
Message-ID: <20260602132824.3541151-2-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
References: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas I3C driver uses an asynchronous model to transfer data. It
prepares a struct renesas_i3c_xfer, enqueues it, and waits for completion.
The interrupt handler dequeues the transfer, updates/uses it, and signals
the waiting thread.

If the completion times out, the waiting thread dequeues the transfer and
free it. If an interrupt fires after that, the handler may access freed
memory, leading to crashes.

Check that the transfer is still valid before accessing it in the
interrupt handler. Along with it, clear any status flag to avoid
triggering the same interrupts again.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- clean the IRQ status bits before returning IRQ_HANDLED and adjusted the
  patch description to reflect this change
- collected Frank's tag. Frank, please let me know if you consider
  I should drop your tag. Thanks!


 drivers/i3c/master/renesas-i3c.c | 44 +++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index f39c449922ca..6e7ece2e0b4e 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -1014,6 +1014,12 @@ static irqreturn_t renesas_i3c_tx_isr(int irq, void *data)
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer = i3c->xferqueue.cur;
+		if (!xfer) {
+			/* Clear the Transmit Buffer Empty status flag. */
+			renesas_clear_bit(i3c->regs, NTST, NTST_TDBEF0);
+			return IRQ_HANDLED;
+		}
+
 		cmd = xfer->cmds;
 
 		if (xfer->is_i2c_xfer) {
@@ -1053,11 +1059,18 @@ static irqreturn_t renesas_i3c_resp_isr(int irq, void *data)
 	int ret = 0;
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
+		/* Clear the Respone Queue Full status flag */
+		renesas_clear_bit(i3c->regs, NTST, NTST_RSPQFF);
+
 		xfer = i3c->xferqueue.cur;
-		cmd = xfer->cmds;
+		if (!xfer) {
+			/* Clear any error flags. */
+			renesas_clear_bit(i3c->regs, BCTL, BCTL_ABT);
+			renesas_clear_bit(i3c->regs, NTST, NTST_TEF | NTST_TABTF);
+			return IRQ_HANDLED;
+		}
 
-		/* Clear the Respone Queue Full status flag*/
-		renesas_clear_bit(i3c->regs, NTST, NTST_RSPQFF);
+		cmd = xfer->cmds;
 
 		data_len = NRSPQP_DATA_LEN(resp_descriptor);
 
@@ -1138,6 +1151,12 @@ static irqreturn_t renesas_i3c_tend_isr(int irq, void *data)
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer = i3c->xferqueue.cur;
+		if (!xfer) {
+			/* Clear any status flag. */
+			renesas_clear_bit(i3c->regs, BST, BST_NACKDF | BST_TENDF);
+			return IRQ_HANDLED;
+		}
+
 		cmd = xfer->cmds;
 
 		if (xfer->is_i2c_xfer) {
@@ -1184,6 +1203,14 @@ static irqreturn_t renesas_i3c_rx_isr(int irq, void *data)
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer = i3c->xferqueue.cur;
+		if (!xfer) {
+			/* Clear any status registers. */
+			renesas_clear_bit(i3c->regs, BST, BST_SPCNDDF);
+			/* Clear the Read Buffer Full status flag. */
+			renesas_clear_bit(i3c->regs, NTST, NTST_RDBFF0);
+			return IRQ_HANDLED;
+		}
+
 		cmd = xfer->cmds;
 
 		if (xfer->is_i2c_xfer) {
@@ -1235,6 +1262,11 @@ static irqreturn_t renesas_i3c_stop_isr(int irq, void *data)
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer = i3c->xferqueue.cur;
+		if (!xfer) {
+			/* Clear the RX/TX Data Buffer Full status flag. */
+			renesas_clear_bit(i3c->regs, NTST, NTST_TDBEF0 | NTST_RDBFF0);
+			return IRQ_HANDLED;
+		}
 
 		/* read back registers to confirm writes have fully propagated */
 		renesas_writel(i3c->regs, BST, 0);
@@ -1259,6 +1291,12 @@ static irqreturn_t renesas_i3c_start_isr(int irq, void *data)
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer = i3c->xferqueue.cur;
+		if (!xfer) {
+			/* Clear any status registers. */
+			renesas_clear_bit(i3c->regs, BST, BST_STCNDDF);
+			return IRQ_HANDLED;
+		}
+
 		cmd = xfer->cmds;
 
 		if (xfer->is_i2c_xfer) {
-- 
2.43.0

