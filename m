Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F82C1514F8;
	Sun, 30 Aug 2026 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788071677; cv=none; b=jBO4Mmga9r6dwjw1eAH0m939iD5Yi9Fk2TE6OBIahRbhAhW8XdxaULPM1XiujJ97olY9uSIcrfHeHX0zjXVfbt2vDx/C8yzaVnaLoq+ZGyzffS4JQHJYZpHShVd3V/37l0a/eu6sKqLXMfxCayHHisjAh/zVEuzULs8gpoz9c+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788071677; c=relaxed/simple;
	bh=T9kWFiXKAo+sURiSS6MlgZh09fNUIsoNY1iKh/NhrEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jLl7w7lfz1u5KrlgYfPRJLomLuz0ftdJpi6w4bAP/vbAoi0F3RpNN7MfmDdXz4jOEurv54U2YowQxzEG37GC2LFAgSIJe6qJGp9iuVTyPPKTV4cCkt5IWJxZooKBkIVDjDCDzFvC3zXdtNhuOZS54iS5l1KwaQq9GriFRYDM5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Cs1Z3gfY; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Cs1Z3gfY"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd37c901;
	Sun, 30 Aug 2026 14:34:21 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH] ALSA: harmony: initialize locks before requesting IRQ
Date: Sun, 30 Aug 2026 14:34:11 +0800
Message-Id: <20260830063411.2215691-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa051604e6503a1kunm075e0d95f22aa
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTEkdVk8ZQ0tMSR1OS04dSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Cs1Z3gfYBs0P9K9smAg85CiXOQIOB45+o7/cLbdZwGcXwsLhwwxFIjB2GJFqPDOvwIjeeSET+3qSofaahNsxim5N2I2In5w77AoJIc7BB0D1jEHiCz5y4cuCzL7EmD8uLNUWbp61qyPQXSRGDhWFfJUxomeSluHNo0G0FeaE3wQ=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=zTEaRl9GSNbK1NotzG3+dISpeXtzFmJDoEM07vZ5nTo=;
	h=date:mime-version:subject:message-id:from;

snd_harmony_create() registers the IRQ before initializing h->lock and
h->mixer_lock. A pending interrupt can invoke the handler while these
locks are uninitialized.

Initialize both locks before requesting the IRQ so the handler always
sees valid lock state.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 sound/parisc/harmony.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index fb40476c6..a9625aedf 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -868,6 +868,9 @@ snd_harmony_create(struct snd_card *card,
 		goto free_and_ret;
 	}
 		
+	spin_lock_init(&h->mixer_lock);
+	spin_lock_init(&h->lock);
+
 	err = request_irq(padev->irq, snd_harmony_interrupt, 0,
 			  "harmony", h);
 	if (err) {
@@ -877,9 +880,6 @@ snd_harmony_create(struct snd_card *card,
 	}
 	h->irq = padev->irq;
 
-	spin_lock_init(&h->mixer_lock);
-	spin_lock_init(&h->lock);
-
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, h, &ops);
 	if (err < 0)
 		goto free_and_ret;
-- 
2.34.1
