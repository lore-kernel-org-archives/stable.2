Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCCB38F24C;
	Fri, 12 Jun 2026 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280308; cv=none; b=fXnGQtsgsb7V6FC/DMg8jM26neOS2ZwULBuDTVMtYakWOfARrItLYzoYPHRm6LodSvWradVQCSrbEgK/vJU0KtNoTJmBayV5nbFu2mosonQ6aUxPOx9mb13nz+aBvhnv7+t+WweE4iX4FUKJrUyBQtuKDiyXP+M2nyYkVIqsB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280308; c=relaxed/simple;
	bh=lWXzycPINz0RonL6meOffzGV1+VeD/30TlNu7FlSvlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ij8NP0CEtAawUrqXRN3hFrpelKiCeydUOnS8tO038fjrlA5JzHR/e5sERCI1FCcEaxQDXWh1ZnFkH6EDnhO8eZKz9NyEoWP55sQSm2kwU19o6i4K7IItZqL6aWbaht8C97+XGXVV/LmyVCRnwNd5KIbLU6AGN5TuXFNWdBjjW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LH1Nna6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LH1Nna6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A3E1F00A3A;
	Fri, 12 Jun 2026 16:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280306;
	bh=DIDYPU6qwnHsyHrpK0bYFeIPHZct1iYHVzrb+y87TkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LH1Nna6O8+pNueDLog1TAMD3dkIPaigLFGh38czFVGhpWJwcjXCBZDEmL77e8OGRt
	 oJ/HpUpHrUwiBkwPR034MsTpn7JAeT8lmPsRGhXsRx84YEpbOwyve4HowkJ8n85Bvy
	 uIAJopOXNZt7jfHt5+GduOCEMro+g1M+KgpjR0joJDkh079Iw/MsK6dWBCO53t4Rsp
	 IR5x2tcwO5f/J08V3yYJ1Mhz0+WTBxg127iV+Bhf2R3ISXrzA2vgoctX5fy92zcL4W
	 JxzbtmoUPF8qaRrnZgl6qKSzAcshSDfsFEj8NbwUNCs2i/9GY6V4nLHzrm1WAO9LH0
	 H4tvMLwry0e8Q==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 01/16] i3c: renesas: Check that the transfer is valid before accessing it
Date: Fri, 12 Jun 2026 19:04:43 +0300
Message-ID: <20260612160458.3102106-2-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612160458.3102106-1-claudiu.beznea@kernel.org>
References: <20260612160458.3102106-1-claudiu.beznea@kernel.org>
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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- disable also the interrupts
- dropped the Rb tag

Changes in v3:
- none

Changes in v2:
- clean the IRQ status bits before returning IRQ_HANDLED and adjusted the
  patch description to reflect this change
- collected Frank's tag. Frank, please let me know if you consider
  I should drop your tag. Thanks!

 drivers/i3c/master/renesas-i3c.c | 50 ++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index f39c449922ca..bc1a0ae1d12d 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -1014,6 +1014,12 @@ static irqreturn_t renesas_i3c_tx_isr(int irq, void *data)
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer = i3c->xferqueue.cur;
+		if (!xfer) {
+			/* Disable interrupts. */
+			renesas_clear_bit(i3c->regs, NTIE, NTIE_TDBEIE0);
+			return IRQ_HANDLED;
+		}
+
 		cmd = xfer->cmds;
 
 		if (xfer->is_i2c_xfer) {
@@ -1053,11 +1059,20 @@ static irqreturn_t renesas_i3c_resp_isr(int irq, void *data)
 	int ret = 0;
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
+		/* Clear the Respone Queue Full status flag */
+		renesas_clear_bit(i3c->regs, NTST, NTST_RSPQFF);
+
 		xfer = i3c->xferqueue.cur;
-		cmd = xfer->cmds;
+		if (!xfer) {
+			/* Disable interrupts. */
+			renesas_clear_bit(i3c->regs, NTIE, NTIE_TDBEIE0 | NTIE_RDBFIE0);
+			/* Clear any error flags. */
+			renesas_clear_bit(i3c->regs, BCTL, BCTL_ABT);
+			renesas_clear_bit(i3c->regs, NTST, NTST_TEF | NTST_TABTF);
+			return IRQ_HANDLED;
+		}
 
-		/* Clear the Respone Queue Full status flag*/
-		renesas_clear_bit(i3c->regs, NTST, NTST_RSPQFF);
+		cmd = xfer->cmds;
 
 		data_len = NRSPQP_DATA_LEN(resp_descriptor);
 
@@ -1138,6 +1153,15 @@ static irqreturn_t renesas_i3c_tend_isr(int irq, void *data)
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer = i3c->xferqueue.cur;
+		if (!xfer) {
+			/* Disable interrupts. */
+			renesas_clear_bit(i3c->regs, BIE, BIE_TENDIE | BIE_TENDIE);
+			renesas_clear_bit(i3c->regs, NTSTE, NTSTE_TDBEE0);
+			/* Clear any status flag. */
+			renesas_clear_bit(i3c->regs, BST, BST_NACKDF | BST_TENDF);
+			return IRQ_HANDLED;
+		}
+
 		cmd = xfer->cmds;
 
 		if (xfer->is_i2c_xfer) {
@@ -1184,6 +1208,14 @@ static irqreturn_t renesas_i3c_rx_isr(int irq, void *data)
 
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
@@ -1234,8 +1266,6 @@ static irqreturn_t renesas_i3c_stop_isr(int irq, void *data)
 	struct renesas_i3c_xfer *xfer;
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
-		xfer = i3c->xferqueue.cur;
-
 		/* read back registers to confirm writes have fully propagated */
 		renesas_writel(i3c->regs, BST, 0);
 		renesas_readl(i3c->regs, BST);
@@ -1243,6 +1273,10 @@ static irqreturn_t renesas_i3c_stop_isr(int irq, void *data)
 		renesas_clear_bit(i3c->regs, NTST, NTST_TDBEF0 | NTST_RDBFF0);
 		renesas_clear_bit(i3c->regs, SCSTRCTL, SCSTRCTL_RWE);
 
+		xfer = i3c->xferqueue.cur;
+		if (!xfer)
+			return IRQ_HANDLED;
+
 		xfer->ret = 0;
 		complete(&xfer->comp);
 	}
@@ -1259,6 +1293,12 @@ static irqreturn_t renesas_i3c_start_isr(int irq, void *data)
 
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

