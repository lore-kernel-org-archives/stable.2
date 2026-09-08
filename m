Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393DB54CF6F;
	Tue,  8 Sep 2026 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882861; cv=none; b=c0M6itWyfHyQ+8CcYwg4kn60rac2RX74YOwXNopbAbbGy5zHKyMwqNltbCisUvCDlKBt+7i/i48+7txY//BV3Kr0bcTFpRSxG01htjAf+IIO9bNSGRlO/TWYnnOTXqrTJmoL+GjwX3JS9Pfhi53+XnE7h9BWI6B2MirggoL9PIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882861; c=relaxed/simple;
	bh=Za8UtDCRpcoLldjKGS5+rPnf9qprec85BjwFh0wyNAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l94iJCrNhc+5RWxkoFCvHHBN1fwj07Ds4FkAOpJ3BbBadaa6N09ubU1+Jj49xGmFkUE7mzcUFXy0j8jgYXo6FRxxlUNqm4ac4JVdHLjUMgHlGm9GKweyGSOAfZ6/gESez5Ql+Z4X2mb/o0Lx/oT6rEgVXAc97ET4ERooU+Fg36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=dlzq+Hc1; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=CXnIK05f; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="dlzq+Hc1";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="CXnIK05f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882851; bh=Za8UtDCRpcoLldjKGS5+rPnf9qprec85BjwFh0wyNAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlzq+Hc13p51ZjGjRlBlOhtvN8/JrRHvmkfm95RmrI+bfkiQ8win/P5OzQDaqzHpX
	 W1amkh/WKm10C05DEDHTAaoibUR4pU36aCH/ROgXWPVltnP/bGy9NGux7NProHEdJS
	 6HPvh5Q+zYx5Ifnbvi/KUK48fL75VbnVe4dc/IwpN6hPeleA4Y8OTbGrOQAUYHQuIM
	 TsAatozbTLvbMiidC6ixzRuEn8Egh0r2+Zd1cH+3DMijZkiPAFdP5o6bx+24KGnX25
	 MgvoxHfUsZw0M9UUBwXOJqtpHbWlsU6cyqMwesgJWQL7xzx1jDFsPXHmh7zNkutLfW
	 yyBoXZTS9/LFQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id B521D41450; Tue, 08 Sep 2026 16:54:11 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882850; bh=Za8UtDCRpcoLldjKGS5+rPnf9qprec85BjwFh0wyNAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXnIK05fGVkRaPwPSyRgAkkxv4SQNf3lqNGponzMK7rW1cwso4eI46m+ZJedtov4K
	 x1gGHoygyYeZa2/EkEFGA7zmzOEoAfZmDhOBy8u+ENXVyP2+5rdq64vy3e1Wdtj1lW
	 OiFnYnClaSu1xNEi1/qSpcf5CVQPmDGcaAztuwvhdp845mqT5eVFoDYRZItucksxhG
	 ynL3Li+oT7pyQ7oL0OG6AqO5A04v8UFxr8R913RpL99izIIPyeUl89kfYk9VMqy6EG
	 6SemVbrIYs4P/PEy5BMX/E/cNlkuPy0Fl43SZ8LD1xx3rYlmg2GTZgnNdAjqR7zt8K
	 gi2NwB4Y5QkCQ==
Received: from maru.home (host86-150-50-53.range86-150.btcentralplus.com [86.150.50.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 807DA4144E;
	Tue, 08 Sep 2026 16:54:10 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/19] media: rc: mce_kbd: Fix inconsistent locking of keylock
Date: Tue,  8 Sep 2026 16:51:54 +0100
Message-ID: <459aa19b705e1928f8591998e3a5fffa5b7f82b1.1788882189.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788882189.git.sean@mess.org>
References: <cover.1788882189.git.sean@mess.org>
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

