Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6F38B158;
	Thu, 20 Aug 2026 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208861; cv=none; b=SUEE/b3t4yOVr0/4DP6/TVKeA40054kC1ILH9KZsEmMUpPYHwab5RjXutNGBYHmKynWRuvgS9WpLZovy6F7upHrMjdOldIdGOnY3mxBGGi2MnnRtmOhF0WFDcyJb78YysUNzMGS9zmODkokyW08U4cEbiZmV/hrOi37t2fDX5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208861; c=relaxed/simple;
	bh=IUMkFxnXgh5EJTSL2ooSAbpI5+meJp6qxhvkk9c9pGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nws5IoQfsUyr59ufsChpG7zvpmoOh+LmmU0rUEyvlaGvjcSAiRecSMIi4q4KTA7+oUlflt1qXZxU/0rhjpd02PN1S/NG8Njgc6dvbObkrbIFprG/7tpPic4lxregcOvdukFAj71yG4E0R3SZ/fV25WAJrQmkmmB1xWzWrQXfRFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f2c233b09c6311f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b9780b3d-5e7d-42fb-9092-b36d87beaf5d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:f21861d1efb1226bc0d257ed0eddec7f,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898|915,TC:nil,Content:0|15|50,EDM:5,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f2c233b09c6311f19a56ed5b684f684d-20260820
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1439272982; Thu, 20 Aug 2026 14:54:11 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Eric Anholt <eric@anholt.net>,
	linux-input@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	gonglinkai@kylinos.cn
Subject: [PATCH] Input: raspberrypi-ts - reject out-of-range point counts and slot IDs
Date: Thu, 20 Aug 2026 14:53:40 +0800
Message-Id: <20260820065340.3765457-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rpi_ts_poll() copies a firmware snapshot and walks regs.point[] using
num_points. The array has RPI_TS_MAX_SUPPORTED_POINTS entries, and the
GPU is documented to report 0-10 points (99 invalidates the copy).

A corrupted count would index past that snapshot. Slot IDs are a 4-bit
field (0-15) while only 10 MT slots are allocated. Drop the whole frame
instead of clamping, so a bad report cannot update a subset of contacts.

Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driver")
Cc: stable@vger.kernel.org
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/input/touchscreen/raspberrypi-ts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
index 841d39a449b3..bd63d95c094b 100644
--- a/drivers/input/touchscreen/raspberrypi-ts.c
+++ b/drivers/input/touchscreen/raspberrypi-ts.c
@@ -78,6 +78,7 @@ static void rpi_ts_poll(struct input_dev *input)
 		 ts->fw_regs_va + offsetof(struct rpi_ts_regs, num_points));
 
 	if (regs.num_points == RPI_TS_NPOINTS_REG_INVALIDATE ||
+	    regs.num_points > RPI_TS_MAX_SUPPORTED_POINTS ||
 	    (regs.num_points == 0 && ts->known_ids == 0))
 		return;
 
@@ -87,6 +88,9 @@ static void rpi_ts_poll(struct input_dev *input)
 		touchid = (regs.point[i].yh >> 4) & 0xf;
 		event_type = (regs.point[i].xh >> 6) & 0x03;
 
+		if (touchid >= RPI_TS_MAX_SUPPORTED_POINTS)
+			return;
+
 		modified_ids |= BIT(touchid);
 
 		if (event_type == RPI_TS_FTS_TOUCH_DOWN ||
-- 
2.25.1

