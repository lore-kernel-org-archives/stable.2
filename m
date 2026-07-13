Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D18414DCE
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947954; cv=none; b=XHQA3/eAr4+3oVuFOBLEkB350i4K/IJznaEYq+dVaAMRNY5m+fL9YKejA5pQU0sQn3TgVDh/eb/ii/HuqYt44TSfexciQN2PNhY1ac+T1nS+fcP59SUKdJEw/U/Pi8BtK6kWTZTkqGTK0pOL61XEz3fVmHy7BGUuonlmv3C8FU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947954; c=relaxed/simple;
	bh=vpQtCTf9lK6ZUysGw0BojPKDiQ0w5G9QuaCqYXbcuJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdXW0cQtO2SFNPfiqMpQdqmw3YBT/vou5sUU9WOwi+sINEDHEoZ4pB03oraU7ikh8BaOo0DapomWFYjuhhmM38P3THQq7N3/ebFFXnWGKOlPXyuitHX6THQz2+Lwg01nQ3xC+oXqiJPhWWMnCOxcvHsMrk1HAUSIngnd+SpAgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kVcUtVWq; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kVcUtVWq"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4629051c9d1so1696980f8f.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1783947951; x=1784552751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vIEzViZhXjAraDf7Ayi3/ThvikdI1szu91oMmQWBOX0=;
        b=kVcUtVWqz4+2IYUTZRLOGopB2MOTMQJPnoo5pwatZXPEny6WksWCXuDWM9aurECGwr
         4SVCXoMD61wDQwd7KyTwQoFm79BQ2AULGwVr29FajrFUNCJJK+e8Rw+IeuHcYiWdcjuW
         McwUVRrE1mfjgwgqigAdN2kZdweCtmxYxhbCSzHXAo/G0NEqJcy8fW3blJ4v2tJLf46f
         y7DTdguH+8h8QZrvLjOe5wZRoUEp60DEsTMSsOIWMKWNamw3IrS1PBbl2WCaFk/gtc2i
         gmdyU/AFhvNOHoG31bpBOs5Qp0VIf99Nby4+0D7HjeoeADP7mz9geU4wuCWdBk6LC1Sw
         k45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947951; x=1784552751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vIEzViZhXjAraDf7Ayi3/ThvikdI1szu91oMmQWBOX0=;
        b=CYfnv+aFwnJeZIMz1IL6gqd6wcy5OcRL8JyjqVlnmWGsBrgaScfqpeVsoDmdNhlHFf
         8/lB7CZxFXeyBAMNl7s41S9jlTQJ8hBLS2MnVSCTsD6UOrBYfFJty0c1BVT/xZb1HMd6
         YN44PRVtM9KtcyuuzKvktcdaffFLR575Vq/t+FQ2uTpFYdLiEJ9e/p6HNiZs3W8ltnqo
         L6brZpoNc/L85ezrV+8uJ0pdv4c80rNNkrTn6hkzlo1Ax53P954JNeptnAreTmjEJi3G
         DTAZfX5Lh5CrhswAMxR+r5U4sViZxkT456jSF56c1FAHHdCHP/d6J/R4U4VlfHiG0FPt
         JZ4g==
X-Forwarded-Encrypted: i=1; AHgh+Rrj3eMmb2l9z585KlJK428NRrlZplkS1smdGi0LI+Oo1/dpuJ3jcL1S3whxsDAOyVRRO4ycCnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuwlRP708y3urJ3GH769WgqGA3QfDEi3+jGflgnNQfC+oxHVz2
	iRAjPAWwlPcpOiI1XDgt98ZzWd4ZdP4de/WUFUlddKmMpIe6vqhnd+liH1ENkguwsac=
X-Gm-Gg: AfdE7cmRm82+p4R32NmaAJW+0NjHreeKt4mN4x8n4VJNLEEhEFkT/efsuh3zTpJ4VX0
	vSuEz09Le5exXxm+C7sdznX3Xy+tcTKPxTQSNJP4TeD5lzw60b4KQmA/ebseDNdCTgNYHrkfQGm
	AdLgIeCMoNyCCId4TLAxpaHrOYMjyT2mSGEQKmsI1YlEUbbe6qN4vQlnUxxDnkifwIithgm7bo6
	AXfkPUpSAGhoy1OsVetxpNNHRS0V6ASIbU39FfcJ276nSkfVUPkbVikY/w4Ne2oYny2iW0NiL0P
	eUdO/tFfwtc3KqPxLz3QRye6wxenP7w9qHWzjIl/2fNL/7Zk9mIJV9J6UD2EON3uIYI+iPxmARP
	ADErc27LJxJ4M3RNXbKfjH0E+y2LWDik+2NlKlDUlyUJvP+yUvus0HlXOxMy4CKsPUlQtbBlGhS
	gIcuLLH+TUhQZAe518PwVL4DyqNlo0CczaLy3tYbF1zf6x68USgUAEDYksa5lWdR7zXIOqbzQ=
X-Received: by 2002:a05:6000:2902:b0:473:1ccc:15bf with SMTP id ffacd0b85a97d-47f2dce2fcemr10893103f8f.42.1783947951174;
        Mon, 13 Jul 2026 06:05:51 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6402:500:e91e:fe5e:857b:d0c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f273195d9sm25321609f8f.3.2026.07.13.06.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:05:50 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 01/17] i3c: renesas: Check that the transfer is valid before accessing it
Date: Mon, 13 Jul 2026 16:05:29 +0300
Message-ID: <20260713130545.568657-2-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
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
interrupt handler. With it clear any status flags and disable all
the interrupts to avoid triggering the same interrupts again.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- introduced renesas_i3c_irqs_mask_and_clear_locked() that keeps
  unified the IRQ mask and clean path
- updated the patch description

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

 drivers/i3c/master/renesas-i3c.c | 52 +++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index f39c449922ca..38b8428f464c 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -433,6 +433,21 @@ static void renesas_i3c_enqueue_xfer(struct renesas_i3c *i3c, struct renesas_i3c
 	}
 }
 
+static void renesas_i3c_irqs_mask_and_clear_locked(struct renesas_i3c *i3c)
+{
+	/* Disable all the interrupts. */
+	renesas_writel(i3c->regs, BIE, 0);
+	renesas_writel(i3c->regs, NTIE, 0);
+
+	/* Clear normal transfer status flags. */
+	renesas_writel(i3c->regs, NTST, 0);
+
+	/* Clear bus status flags. */
+	renesas_writel(i3c->regs, BST, 0);
+	/* Read back registers to confirm writes have fully propagated. */
+	renesas_readl(i3c->regs, BST);
+}
+
 static void renesas_i3c_wait_xfer(struct renesas_i3c *i3c, struct renesas_i3c_xfer *xfer)
 {
 	unsigned long time_left;
@@ -1014,6 +1029,11 @@ static irqreturn_t renesas_i3c_tx_isr(int irq, void *data)
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer = i3c->xferqueue.cur;
+		if (!xfer) {
+			renesas_i3c_irqs_mask_and_clear_locked(i3c);
+			return IRQ_HANDLED;
+		}
+
 		cmd = xfer->cmds;
 
 		if (xfer->is_i2c_xfer) {
@@ -1054,6 +1074,11 @@ static irqreturn_t renesas_i3c_resp_isr(int irq, void *data)
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer = i3c->xferqueue.cur;
+		if (!xfer) {
+			renesas_i3c_irqs_mask_and_clear_locked(i3c);
+			return IRQ_HANDLED;
+		}
+
 		cmd = xfer->cmds;
 
 		/* Clear the Respone Queue Full status flag*/
@@ -1138,6 +1163,11 @@ static irqreturn_t renesas_i3c_tend_isr(int irq, void *data)
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer = i3c->xferqueue.cur;
+		if (!xfer) {
+			renesas_i3c_irqs_mask_and_clear_locked(i3c);
+			return IRQ_HANDLED;
+		}
+
 		cmd = xfer->cmds;
 
 		if (xfer->is_i2c_xfer) {
@@ -1184,6 +1214,11 @@ static irqreturn_t renesas_i3c_rx_isr(int irq, void *data)
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer = i3c->xferqueue.cur;
+		if (!xfer) {
+			renesas_i3c_irqs_mask_and_clear_locked(i3c);
+			return IRQ_HANDLED;
+		}
+
 		cmd = xfer->cmds;
 
 		if (xfer->is_i2c_xfer) {
@@ -1234,15 +1269,13 @@ static irqreturn_t renesas_i3c_stop_isr(int irq, void *data)
 	struct renesas_i3c_xfer *xfer;
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
-		xfer = i3c->xferqueue.cur;
-
-		/* read back registers to confirm writes have fully propagated */
-		renesas_writel(i3c->regs, BST, 0);
-		renesas_readl(i3c->regs, BST);
-		renesas_writel(i3c->regs, BIE, 0);
-		renesas_clear_bit(i3c->regs, NTST, NTST_TDBEF0 | NTST_RDBFF0);
+		renesas_i3c_irqs_mask_and_clear_locked(i3c);
 		renesas_clear_bit(i3c->regs, SCSTRCTL, SCSTRCTL_RWE);
 
+		xfer = i3c->xferqueue.cur;
+		if (!xfer)
+			return IRQ_HANDLED;
+
 		xfer->ret = 0;
 		complete(&xfer->comp);
 	}
@@ -1259,6 +1292,11 @@ static irqreturn_t renesas_i3c_start_isr(int irq, void *data)
 
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer = i3c->xferqueue.cur;
+		if (!xfer) {
+			renesas_i3c_irqs_mask_and_clear_locked(i3c);
+			return IRQ_HANDLED;
+		}
+
 		cmd = xfer->cmds;
 
 		if (xfer->is_i2c_xfer) {
-- 
2.43.0

