Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F9E334688;
	Fri,  4 Sep 2026 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527292; cv=none; b=K3VQmK5iAxiWCtDEtr5C8IWsrjXvQt9xZTD59Rh6HjLU8m4pPBK1/VhBUk8H4Ig2SoH2cXAE6TIuW181UN5WavHXq1GxdDwckFzhReZGD2O9PJWVHM6iKoVfe/kOUN30B49FnocTnAu0ubgjwHD8F9qgStaRjwcyI3Nvvrm0Y40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527292; c=relaxed/simple;
	bh=Za8UtDCRpcoLldjKGS5+rPnf9qprec85BjwFh0wyNAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3wwk4+tauXO6Eq2BJ5TxoBjlxPZzx+3J6sNq0Afonl4DW/HA+deApKMZ9F9xfJ4g2C9D4KzXXQ2bWcyhQfSqPWJwuXmgXwNZLaPJCxStTt3vw6QWxry6QgZxd0z8u1veHRGuRCHyHiyS0fqxx7YmYOhfZW8evwxK8BPOnFKOAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=VXDf6MzO; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=ebMJ0lo2; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="VXDf6MzO";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="ebMJ0lo2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527282; bh=Za8UtDCRpcoLldjKGS5+rPnf9qprec85BjwFh0wyNAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXDf6MzOkhlzSCadEJ6yAviTFtR0TzYu97Sq8BI0lByWhuLKsz0JwR7pckN03d4xB
	 BxOrak93sGTGPFlx8VKZ890+dY1ZoUqBxzlQXKlAQjrOmrH+tE5YPMQH83c1djri1P
	 rlKh4rcxoZ2qFmQ/I+1HgLh7KV2xdYeajJbPcTnzcMJV+mTYTaqw0IbTRCqflNqnQq
	 QpO3ET0DiUzC06YE8f8pK9WlU6/9jFfEfaP1ckA3UQzIyq4CnWkJQtxUu1TXTbcZJT
	 X5zci/NdkOJYormjc1K2cjsNXfm8ukrB/xkfpBmAq01w7vENQgKNkflrm0uHYP0kjJ
	 TLJSPehKtz4oA==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id C08F241464; Fri, 04 Sep 2026 14:08:02 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527280; bh=Za8UtDCRpcoLldjKGS5+rPnf9qprec85BjwFh0wyNAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebMJ0lo2ClgIoAc25Gkm4fqdcEmLstwC5qOFmykTcbafzdQjYnav/Shcj5z+DNx1r
	 OMOy+IuSJdYYjpqkDhKM7PZE6bsF/WcCdAjiZFO52hbFvW3T6B4SzFr+hNUydKuIs8
	 FtzK/+yYxgjn9TpU034yRYHFisZ5ezNdsdPJhoMP2y/uHfD4w5FaYTy+KK/N5aGKzR
	 zrF1SltyAlmqaPfx/E7bgHBUZxLCLZd10mUvkgdNyrC/DVlNajK5X9NKDIgOSPIh+I
	 LLaPGTYOUIUMwgoH85sfBrRX3OillH49nV25/2kCVxktckOUjhSmyi15Un+nELY6Uc
	 njcReBVdExftQ==
Received: from maru.mess.org (hephaestus.mess.org [82.68.61.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id F27774144F;
	Fri, 04 Sep 2026 14:07:59 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/17] media: rc: mce_kbd: Fix inconsistent locking of keylock
Date: Fri,  4 Sep 2026 14:07:34 +0100
Message-ID: <1dd7a367cf7b1bd57fed39832b3926570d34a8a5.1788526920.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788526920.git.sean@mess.org>
References: <cover.1788526920.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

data->keylock is taken with spin_lock() in ir_mce_kbd_decode(), which
runs in the raw IR decode kthread with local interrupts enabled, but
with spin_lock_irqsave() in mce_kbd_rx_timeout(), the rx_timeout timer
callback, which runs in softirq context.

If the decode kthread is holding keylock via spin_lock() when a timer
interrupt fires on the same CPU and the softirq runs
mce_kbd_rx_timeout(), the softirq spins forever waiting for a lock
that only the now-preempted kthread can release, while the kthread
cannot run again until the softirq gives up the CPU. This deadlocks
the CPU.

Fixes: 53a62800efb2 ("media: rc: mce_kbd decoder: fix race condition")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/ir-mce_kbd-decoder.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/ir-mce_kbd-decoder.c b/drivers/media/rc/ir-mce_kbd-decoder.c
index bb2d7c37c263..d1c9263511b0 100644
--- a/drivers/media/rc/ir-mce_kbd-decoder.c
+++ b/drivers/media/rc/ir-mce_kbd-decoder.c
@@ -219,6 +219,7 @@ static int ir_mce_kbd_decode(struct rc_dev *dev, struct ir_raw_event ev)
 	struct mce_kbd_dec *data = &dev->raw->mce_kbd;
 	u32 scancode;
 	unsigned long delay;
+	unsigned long flags;
 	struct lirc_scancode lsc = {};
 
 	if (!is_timing_event(ev)) {
@@ -319,7 +320,7 @@ static int ir_mce_kbd_decode(struct rc_dev *dev, struct ir_raw_event ev)
 			scancode = data->body & 0xffffff;
 			dev_dbg(&dev->dev, "keyboard data 0x%08x\n",
 				data->body);
-			spin_lock(&data->keylock);
+			spin_lock_irqsave(&data->keylock, flags);
 			if (scancode) {
 				delay = usecs_to_jiffies(dev->timeout) +
 					msecs_to_jiffies(100);
@@ -329,7 +330,7 @@ static int ir_mce_kbd_decode(struct rc_dev *dev, struct ir_raw_event ev)
 			}
 			/* Pass data to keyboard buffer parser */
 			ir_mce_kbd_process_keyboard_data(dev, scancode);
-			spin_unlock(&data->keylock);
+			spin_unlock_irqrestore(&data->keylock, flags);
 			lsc.rc_proto = RC_PROTO_MCIR2_KBD;
 			break;
 		case MCIR2_MOUSE_NBITS:
-- 
2.55.0

