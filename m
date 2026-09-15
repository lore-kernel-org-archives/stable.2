Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6651E47A882;
	Tue, 15 Sep 2026 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461189; cv=none; b=XWGekEN9QUnvqVHyr1XUUxmS9G2s1t5M8qz0xPYDOVD60vzRsl3S4e16g3TC1Y6C8Ac5BS3WPuOd9ja2d3sYXjXFtb2f8LOaOTyOvszkXYYnb2zQwD/LlFX70V7nlLxIaa0Rnq/qCHjAWPXILIqQt9qY+R73kdE/td26PXtLqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461189; c=relaxed/simple;
	bh=Za8UtDCRpcoLldjKGS5+rPnf9qprec85BjwFh0wyNAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sA8JJxEu/H2fgrRhV58kTeKfvQho6F3ylzdJu/dVKxDVDt7DudGMwgxvhZIYZDaa2wmTEgOXMhrWwf/VDWHGWNY4wabWrG2PE3gQoI575QFW4EMiXeaMrME7CE3bxM0TEn58t6/0v75iGFBG5V0sX28RFz5fwn5qn8Sn948gbgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=I0mvEOmB; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=pYcarSRL; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="I0mvEOmB";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="pYcarSRL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461186; bh=Za8UtDCRpcoLldjKGS5+rPnf9qprec85BjwFh0wyNAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0mvEOmB7mGobLOKOQCnqhwjwKDXVhyrdyiN7/CRe/pKSVpIEC4Y/JBFV/Bt2LqlG
	 gObVAusXm76Mjlb69wGiOREpQMo5htg5KyRcdbk3qS8obv2rQjBJpyzlcMWmP9dcfU
	 wCKCsJT3nlbY/IPX2afYwX32e9bsEyzCOjcKOI/OYWbhQ6kAvUr+kqZ+yfIAxhu04m
	 U4UbQVhNHROUJIaSIpgNEEAqI2kUD1R8n3HVqPxII8irHNdY6WSnwa86YHA/gxvEvK
	 ZtGQEYfKKo7QsD3T3C+MH/k+lOao1SWjgvuDsU2hNf1INZOIGXP3ONb1H0OZOoYW1P
	 Dktct+yGSDEcw==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 0AD0440BA7; Tue, 15 Sep 2026 09:33:06 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461185; bh=Za8UtDCRpcoLldjKGS5+rPnf9qprec85BjwFh0wyNAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYcarSRLvr3C7I9mNCESy8WYR/lLoBTUDFXzAsqFYr8+0T/IA0P9A8SriV1Hs4bqE
	 siUGWxzxq4i/UsT91DFLdpbjp7EMfS4kzXD0VVwQjjxuAhyDmOL3HLD7nFBKaLwWpG
	 ee4hqnyzvnoaMXFvFFAJokQr6rwiEexKtOjOqu+p67feQe/J1rCMgPLIhVWfVG2PRB
	 W8OEi3hxClsCZBC5vz3IKqFaGkKf5mGDPM2gqwnc1Mxq+jMg/78nALa8cppemBdMCj
	 Ir1IzA5RplvR3BW51+fhqjI9nB1pZs2s23If4M3vdASLFMV9JTnq7nCnF/gvOV4LP4
	 ftP4gEkmC3h0A==
Received: from maru.home (host81-158-254-226.range81-158.btcentralplus.com [81.158.254.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 438D440B71;
	Tue, 15 Sep 2026 09:33:05 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/20] media: rc: mce_kbd: Fix inconsistent locking of keylock
Date: Tue, 15 Sep 2026 09:32:17 +0100
Message-ID: <4f56b84535b67c38bdf1dc7858ef60197c059b97.1789460680.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789460680.git.sean@mess.org>
References: <cover.1789460680.git.sean@mess.org>
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

