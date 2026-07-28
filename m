Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9DF3AA1B5;
	Tue, 28 Jul 2026 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244663; cv=none; b=KdIyyTYTe2qFctxdjJ2xGQ8r0zwCShSSB4KgMQvou5mLvKEu18zre0j2ZLO8OVNNwziAk5kPGdSmDoyhE5Gn2bW8dVQ3eX4RXZrofQWtF1FVt7W2xmXM3kHA7i22rTKfiRmQlo/JTmUzr7+SXcWsR0ARYfka3Z0E3vOREjXqOHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244663; c=relaxed/simple;
	bh=KFjj8KAFf2OD2VMZxH1bHDsTsWIyWvRvkJUX7RF2bQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h3I98aKkOKQJUJNeeOaPsPu5Jn9UrBHbfYx29Mitzrefq5eG4xpwPJHtVbk38qn8PB7t8c9xvoQI5TfkRBerrdi0ePl/9ZSW2SFTuHdcFRjXaJZEIQyuEuOO6HwYI63//k5yrn73ra/YIisdRqd1TsRjNcaOG0daBHV1RxAx2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b12e60988a8611f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6c7af154-a39d-4163-a241-a3d33acb1cc5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:24ab3b3ccffc1222e57884e278795d59,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b12e60988a8611f1aa26b74ffac11d73-20260728
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1403975229; Tue, 28 Jul 2026 21:17:32 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: gupt21@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: hamish.martin@alliedtelesis.co.nz,
	sashal@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] HID: mcp2221: stop device IO before hid_hw_stop
Date: Tue, 28 Jul 2026 21:14:40 +0800
Message-Id: <20260728131442.834604-2-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260728131442.834604-1-yijiangshan@kylinos.cn>
References: <20260728131442.834604-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Quiesce device IO at the start of the devm cleanup callback
mcp2221_hid_unregister() so that incoming HID reports cannot race with
hardware teardown during probe failure or device removal, addressing a
potential use-after-free.

Guard the call to hid_device_io_stop() with io_started. On normal
removal hid_device_remove() has already cleared io_started before the
devres group is released, so an unconditional call would otherwise hit
the !io_started path and emit a spurious "io already stopped" warning
on every removal. The guard preserves the probe-failure balancing,
where io_started is still set after hid_device_io_start(), while
staying silent on the normal removal path.

Fixes: d4b50ac06ea6 ("HID: mcp2221: Allow IO to start during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
Changes in v2:
- Guard hid_device_io_stop() with io_started to avoid a spurious
  "io already stopped" warning on normal device removal, as flagged by
  the Sashiko AI review of v1.

v1: https://lore.kernel.org/r/20260728061919.310367-1-yijiangshan@kylinos.cn

 drivers/hid/hid-mcp2221.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index e4ddd8e..5c7fc56 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -1049,6 +1049,8 @@ static void mcp2221_hid_unregister(void *ptr)
 {
 	struct hid_device *hdev = ptr;

+	if (hdev->io_started)
+		hid_device_io_stop(hdev);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 }
--
2.25.1

