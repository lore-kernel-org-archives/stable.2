Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01EF283FC4;
	Tue, 18 Aug 2026 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064546; cv=none; b=JnidViMB3v8fg4si8uGAOzLoGWmg1irBbNBx1jiiIPMIYYdAWkT0eYm+guMRMgYihB95NgoNo8kv2dL3Rc5DR5gJM2ZB42D6PkxjcYGmAL+zyojGVmDbz36ays+sHFfwGuKq8kmKowkcUdRJkk9aR4S2Y3UD3hilhhco6WZnnkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064546; c=relaxed/simple;
	bh=abyYGMXMQVbJhue7bJqHhpaIPJzjQr1nPgzrACKCdqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i5uWtARAugYjl7pqAOKPQAQp/5bFpPllgaml27s6GtTjcVDSwFDrdM+CIWvlOHR84W/9Bq157z5xoymwuRJnpBXMj1sBEkpf/dPc6v3vdZFp1VN0iRJDYh9jYs78ornkse4CYDqK9R5eITbWQISd4dj3zd/dScgH6V8yN3d8Emg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=iZuI/w84; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="iZuI/w84"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a6e04cd7;
	Tue, 18 Aug 2026 22:48:50 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] ALSA: pcxhr: initialize mutexes before requesting threaded IRQ
Date: Tue, 18 Aug 2026 22:47:17 +0800
Message-Id: <20260818144717.2269918-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01558b63303a1kunm10a86825114b6e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHh0YVkpCHRpCTUkaShofSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=iZuI/w84KZgRPbHm650rThuqxRw6eVtlM6xOMcbPVUQpNGSkgWvH1WbsgfeoakFKq2usMDFehZHDPWoAxD+VR7NYowKgSPiem0CVTQbOlDVyk6ngD8pEaE53FQjRn9O3W7KovQDHTdv+6I6tzT4+Ttz/2C6S5esqnzO5AD79eyw=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=21lG1nz3gXedQM4708u65RGG2z3e/pmYO1+gfk0/I9M=;
	h=date:mime-version:subject:message-id:from;

pcxhr_probe() requests pcxhr_threaded_irq() before initializing
mgr->lock, even though the threaded handler takes that mutex.

Initialize the manager locks before request_threaded_irq() so an
early interrupt cannot run against uninitialized mutex state during
probe.

Fixes: 9bef72bdb26e ("ALSA: pcxhr: Use nonatomic PCM ops")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 sound/pci/pcxhr/pcxhr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index 83066d08367e..7b37b2aa76a6 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1532,6 +1532,13 @@ static int pcxhr_probe(struct pci_dev *pci,
 	mgr->pci = pci;
 	mgr->irq = -1;
 
+	/* ISR lock  */
+	mutex_init(&mgr->lock);
+	mutex_init(&mgr->msg_lock);
+
+	/* init setup mutex*/
+	mutex_init(&mgr->setup_mutex);
+
 	if (request_threaded_irq(pci->irq, pcxhr_interrupt,
 				 pcxhr_threaded_irq, IRQF_SHARED,
 				 KBUILD_MODNAME, mgr)) {
@@ -1545,13 +1552,6 @@ static int pcxhr_probe(struct pci_dev *pci,
 		 "Digigram at 0x%lx & 0x%lx, 0x%lx irq %i",
 		 mgr->port[0], mgr->port[1], mgr->port[2], mgr->irq);
 
-	/* ISR lock  */
-	mutex_init(&mgr->lock);
-	mutex_init(&mgr->msg_lock);
-
-	/* init setup mutex*/
-	mutex_init(&mgr->setup_mutex);
-
 	mgr->prmh = kmalloc(sizeof(*mgr->prmh) +
 			    sizeof(u32) * (PCXHR_SIZE_MAX_LONG_STATUS -
 					   PCXHR_SIZE_MAX_STATUS),
-- 
2.34.1
