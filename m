Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33C933938B;
	Tue,  1 Sep 2026 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272734; cv=none; b=kF4iwzbmoHeCeivK3qOFuULOBjiUOeg7gweBIeisim0QPRk36B9iu6sdpooT19bu9qvMr3NrsiekDP6qKDNedFSpXTx4BrFu4E0YVnckRF7JxQimbHQtMen6m1YgYILIq9bqXJgUwUDleQdNyXtbkkjudNcMKnsE02PWiknDa7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272734; c=relaxed/simple;
	bh=Za8UtDCRpcoLldjKGS5+rPnf9qprec85BjwFh0wyNAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rulSAoneDWIPvPWiNWmzIXbBfhAxI2VG9HsFe27KHZ/3d+C++O5QRZVGEXVbmiXcE5zIUVCCFS50HBh6P8ipOZb6Wc9XYCGu7zwdQ3/gbhUVvWFiaPpJFLTubAE0Hd84/rPUXurpyzGi5BLtsv9F81K22LvHd5OX8ryIA6C5iBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=W+5MVj7m; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=FqsoXHAQ; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="W+5MVj7m";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="FqsoXHAQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788272731; bh=Za8UtDCRpcoLldjKGS5+rPnf9qprec85BjwFh0wyNAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+5MVj7mItyc+4kYgbqYgXEAxjoU7IbqOX0KmoO9c5xFT0XECRDB1Yp1SVZA3AAGA
	 h7P1hrUEnFCgGrOMOEq7nGS6VZ8mCR5L00cKK7wN20E3TIuqFJzLISCtLpesh6LFxt
	 e3E35DR+3NJPkuFmIz/gScfnKS/l1PrwaDQ1QY3nMglne+uyO1oP6duaFWaVou9wLZ
	 arbxcWEpSp/viF4Q5VBhUhkGqrCTveO3Pd/YVD7SMZYDIxDgyItEsUP+Ld53bCuOKz
	 6wqyD2MnksViW4RouA6wgENYsKVxqVwExRcZOE8J++wracy73KkYc/sR4bAoeVSVnI
	 70aevdniNPMNA==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 8A35E41451; Tue, 01 Sep 2026 15:25:31 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788272728; bh=Za8UtDCRpcoLldjKGS5+rPnf9qprec85BjwFh0wyNAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FqsoXHAQhgEeELKB1G7zZhpUmOXo652s7TZeWfZ4/lhjGM9NO84KD/5rA1KRZ+wZk
	 am0ATq663eVQa7JsLJ8oWcJqAYucBDw8ImTOR+0C4im5DjuhmBibKNTQd+3Ke+z/xW
	 Ifeh0qlbsGZC+9Xcp8AVuxbuI514T+Sni3IYAHgM0q8053+gry2yUPG9S4mK8pPfDh
	 JdQWzKkyqZTnKkgH/HFRawcARpe6p6IwNnG2vHKC6xTAk2v0llcaTyFlr9eJ3JuEwv
	 b9Y9d1jwSUu78G8uWG4fh058ltslPPotAFuKPpfiTzbpgkEdlLt95XtGIwOEUGM0XH
	 S0muDakF4PdfA==
Received: from maru.home (host86-128-233-22.range86-128.btcentralplus.com [86.128.233.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id AA27E41448;
	Tue, 01 Sep 2026 15:25:28 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] media: rc: mce_kbd: Fix inconsistent locking of keylock
Date: Tue,  1 Sep 2026 15:24:56 +0100
Message-ID: <6945917a0cf699bcf55bba0079d6e5cd96d0c2db.1788272199.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788272198.git.sean@mess.org>
References: <cover.1788272198.git.sean@mess.org>
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

