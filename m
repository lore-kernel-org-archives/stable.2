Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000844062D;
	Thu, 20 Aug 2026 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787209345; cv=none; b=BbzM3epq2qnKQV4TcdQKzbn29wNp8hdVikYxk8Nu0aqgkpEpkU78kNfMb+Twrr/eKosPN8dvVgZqnFhv4JyH0kVSgWVm4v6uzJ5BE/XRg+1AU2Bjx5OOZUnbT+QQHD30TwOLsv71e8OU2iXCPcndlWxi8VhcIBTyYilMxa3tSL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787209345; c=relaxed/simple;
	bh=hCMQnA3XOeaQwootN1wJNpDaLzeN6tSQfXTGWgIGwys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R6FUgCbLO+1Sv7KmitFinpIatnd9FDE8Nsd1BvD9g0OgIDHtU1T6AhSOG2iVKPA0FCalltHNS6J2EYfk9sOAPfcoc2liIWXTicDFnNyJGkyNhjJqqTNH+G2NaiA6CcFUG5MiK93zyoOCo8fzASLpD/YBFRxk54Gz517tPDyXb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 11ff703e9c6511f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:461ddc47-c43d-4c46-8b1a-96d32f274e11,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:b3d4658713fc86a06391b527e9200706,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 11ff703e9c6511f19a56ed5b684f684d-20260820
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1915275116; Thu, 20 Aug 2026 15:02:13 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Remi Buisson <remi.buisson@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	gonglinkai@kylinos.cn
Subject: [PATCH] iio: imu: inv_icm45600: clamp FIFO packet count to buffer size
Date: Thu, 20 Aug 2026 15:02:08 +0800
Message-Id: <20260820070208.3891851-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IRQ path calls inv_icm45600_buffer_fifo_read(st, 0), so the raw
16-bit FIFO count sizes the read into st->fifo.data (8K). Cap the
packet count so the transfer cannot exceed that buffer.

Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")
Cc: stable@vger.kernel.org
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
index 2b9ea317385c..62e9e138bc89 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
@@ -419,8 +419,10 @@ int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st,
 	fifo_nb = le16_to_cpup(raw_fifo_count);
 	if (fifo_nb == 0)
 		return 0;
-	if (max > 0 && fifo_nb > max)
-		fifo_nb = max;
+	if (max > 0)
+		fifo_nb = min(fifo_nb, (size_t)max);
+	fifo_nb = min_t(size_t, fifo_nb,
+			INV_ICM45600_FIFO_SIZE_MAX / packet_size);
 
 	/* Try to read all FIFO data in internal buffer. */
 	st->fifo.count = fifo_nb * packet_size;
-- 
2.25.1

