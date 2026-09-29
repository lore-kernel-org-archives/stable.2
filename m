Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABEF515987;
	Tue, 29 Sep 2026 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678341; cv=none; b=IUtvyytho8xNKEfo1MjHrnxF6C/ypF3D5iijnq+ezHW3eTAcqc6heaML51i2dM44VdIQt8FvdNEIQXf8o2/ekP3RXqyioNDVzsxTH49MOXST0xYn2GQxbXnnNwumkyaJecP/lE/98sC8p1WzcrZ/tR6irDaUHGL2G7yyUK5Y6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678341; c=relaxed/simple;
	bh=+OUhlVYZ0jq6CYLj3jCvatmRk5xzGaVmAfrPyhOkY6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AoXJyO0NY4IZbGGbPdAb6uobX8nL8RgzTpDxNOE587DsNAgZxQ2YQ5lyCOQh34RW6rlqSNPUv8b40RaQZhBHNzJsRFAkKPLZ8lO4I+bP/WwAa0Ei/Ab4DgJzFEX0cPgLR9YAXJXGobfIS1GpOY245diESCHrXjh45pYkCJOo26k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=GphxntBf; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="GphxntBf"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f7ead550;
	Tue, 29 Sep 2026 18:38:43 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: usb: as102: Initialize callback locks before DVB registration
Date: Tue, 29 Sep 2026 18:38:15 +0800
Message-Id: <20260929103815.2109376-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0ecbed1aa03a1kunm4d1f998a23813d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTxhOVkpLHxoZHx4aS0seH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=GphxntBfOkc/nvV9UNksOkFtEYEG/ZuU16iPDDuz66Atied3Ln3ypEmJBPMYeKnhxWKXU9bWHfc1rMikZrQaW8FeJOvRQtbbMl6InjUB7DufhCf/VvSA1SvfP4PsFD2iQdTQ5Ac4DhUOVVe1XPyMzJy7tbwa8Y/sdlJRb3510ec=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Uk6UVNkbpeLJaWrzx887ukrH1cneAahKD/1dLIWZl8E=;
	h=date:mime-version:subject:message-id:from;

The AS102 DVB frontend and demux callbacks use bus_adap.lock and sem. DVB
registration publishes the frontend and demux devices before either lock is
initialized, allowing a userspace callback to run before the lock is ready.
Initialize the callback state before registering the adapter.

Fixes: 41b44e041811 ("[media] staging: as102: Initial import from Abilis")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/media/usb/as102/as102_drv.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/as102/as102_drv.c b/drivers/media/usb/as102/as102_drv.c
index 6b1d3528a..f3e2acf8f 100644
--- a/drivers/media/usb/as102/as102_drv.c
+++ b/drivers/media/usb/as102/as102_drv.c
@@ -287,6 +287,10 @@ int as102_dvb_register(struct as102_dev_t *as102_dev)
 	struct device *dev = &as102_dev->bus_adap.usb_dev->dev;
 	int ret;
 
+	/* Initialize callback state before registering the DVB adapter. */
+	mutex_init(&as102_dev->bus_adap.lock);
+	mutex_init(&as102_dev->sem);
+
 	ret = dvb_register_adapter(&as102_dev->dvb_adap,
 			   as102_dev->name, THIS_MODULE,
 			   dev, adapter_nr);
@@ -341,12 +345,6 @@ int as102_dvb_register(struct as102_dev_t *as102_dev)
 		goto efereg;
 	}
 
-	/* init bus mutex for token locking */
-	mutex_init(&as102_dev->bus_adap.lock);
-
-	/* init start / stop stream mutex */
-	mutex_init(&as102_dev->sem);
-
 	/*
 	 * try to load as102 firmware. If firmware upload failed, we'll be
 	 * able to upload it later.
-- 
2.34.1
