Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C448463B75;
	Mon, 28 Sep 2026 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585703; cv=none; b=jAm1AhRJ2c67X+VFUayJneSIGj+Cyu60CPtiAKGq4s95AhDUjaeA2PZvh1GdOn+lUVNVRrGj+k5STLvkWZijZYJfxIWf1p4CwpxW4eemYiMy8zgfN32y6fqHyxzLiaKf3MY9bWf/iFCfyOet/1Hn1YqaELOJALtr8f+qO8ehvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585703; c=relaxed/simple;
	bh=zYS0exigYUq22IQg4QDvpZwkR/5wj8JGezynrWm8eJw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OOq1JeKukb6BjQPdFE5wyG1SFnpZtt6rMXfdLViJyrm6EkFxE3bkGbaqvpZLnI3a/91Jy+x7t0IRa25V54WNDKkslHjAbyhAV10M2cvVH4KsOW4Xouogna25R4AmE5KEvWPCxMQBkNdFVi69ToPUHlfPopLhiB+EOM48xS7hn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 468a8b08bb1a11f19a56ed5b684f684d-20260928
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5f76f905-f272-4885-9897-0866abdea30b,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:8e3653ad3acc1044182440bce4ed7677,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 468a8b08bb1a11f19a56ed5b684f684d-20260928
X-User: huanglu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <huanglu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 89712507; Mon, 28 Sep 2026 16:54:55 +0800
From: Lu Huang <huanglu@kylinos.cn>
To: "Daniel J . Ogorchock" <djogorchock@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martino Fontana <tinozzo123@gmail.com>,
	Lu Huang <huanglu@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] HID: nintendo: fix lost update of player LED state
Date: Mon, 28 Sep 2026 16:54:33 +0800
Message-Id: <20260928085433.1129896-1-huanglu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The player LED subcommand programs all four LEDs with a single
value, so joycon_player_led_brightness_set() must aggregate the
current brightness of all four LEDs and send that snapshot
atomically. Commit 928276075f16 ("HID: nintendo: cleanup LED
code") moved the aggregation loop out of output_mutex: if an
update callback is preempted after reading the four states and
another update sends its own snapshot first, the preempted
callback later sends its stale value and silently reverts the
completed update, leaving the hardware LED state inconsistent
with sysfs brightness.

Move the aggregation loop back under output_mutex so reading
the four LED states and sending the subcommand are serialized.

Fixes: 928276075f16 ("HID: nintendo: cleanup LED code")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Huang <huanglu@kylinos.cn>
---
 drivers/hid/hid-nintendo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 43e0f2aaea3b..b0d7c91490f9 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2264,10 +2264,9 @@ static int joycon_player_led_brightness_set(struct led_classdev *led,
 		return -ENODEV;
 	}
 
+	mutex_lock(&ctlr->output_mutex);
 	for (i = 0; i < JC_NUM_LEDS; i++)
 		val |= ctlr->leds[i].brightness << i;
-
-	mutex_lock(&ctlr->output_mutex);
 	ret = joycon_set_player_leds(ctlr, 0, val);
 	mutex_unlock(&ctlr->output_mutex);
 
-- 
2.25.1

