Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B558F09E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986577; cv=none; b=mXvJNHOZotbA1mu0zDpDyUMST31Ix0ah4A6mvzuGDx2TUuP491Emq23TlKM2zBxloJAYlNOk5d4W2UZ/lpm+gV6YPmElm6CHX3yacCtNYMV+aeQ9046BWxQukX/3tzt83RKl6OXQVuSd+T/q4YmlACwT1bGAUsd39LD6psDnDSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986577; c=relaxed/simple;
	bh=Ww4+TI9LDrYz1a1IvHQ3B0xBMl5njo8eyQrEQ43oG8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUsNULjbXieHvmDLJs9iCtOYZXdHH9yOJ9N550pzeyaZGZmIhrzZcYAuERJH7ttmYUSdQwlDM0XIrgJVkj7+wKztnx8BXsx91sCFwdvH6gbXz6y43DjPulNH9fj/USnt6huKxFNb/wUVz44j/PQ470XDf4aqTRDpGcRmd8M05wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd3v2HLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd3v2HLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775481F00898;
	Wed,  9 Sep 2026 20:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986545;
	bh=BUUYhJ4do15ssWzGg4a6eBQ4kNNpDLON0M46WPJrCJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xd3v2HLFZCna6WYFJ+5vuxd35qJxY2LXuYlphOFNxFYLPfFXIbcFIVz0eK+Lq32mX
	 O6ZrYJcZS4n0rMAvKCz5HEPdbZl1rUvTxUehL09IIzyFs1N2SOncoSqaHWB2wE0O4F
	 6+lovyLgALZRYiH1T+3rtxhGUwsOjphrD9PenTQ8NdV83Jt4m38OXQWpu4uxZzJvIs
	 0VtymbqGMyuL8NI7Fi9lYYOiAudhdwJuYzb4M5A8l8YIOeLSWC5byLXblinqEtuR+P
	 ojEgWTMpFMLk19EJFHXHa3VN5BxYig4KiZ5WmGUnkG2THACNYMvy8NGNJ+6hig/O0F
	 +Vgf3ziVuV6Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] ALSA: pcxhr: initialize mutexes before requesting threaded IRQ
Date: Wed,  9 Sep 2026 16:42:22 -0400
Message-ID: <20260909204222.3660007-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909204222.3660007-1-sashal@kernel.org>
References: <2026090309-dimly-regulator-21d3@gregkh>
 <20260909204222.3660007-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 6c97817e20598e5473094e0e38d1f51f1cf4dfff ]

pcxhr_probe() requests pcxhr_threaded_irq() before initializing
mgr->lock, even though the threaded handler takes that mutex.

Initialize the manager locks before request_threaded_irq() so an
early interrupt cannot run against uninitialized mutex state during
probe.

Fixes: 9bef72bdb26e ("ALSA: pcxhr: Use nonatomic PCM ops")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260818144717.2269918-1-runyu.xiao@seu.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/pcxhr/pcxhr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index 1fe7e876c7fb4..318289a94ee21 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1548,6 +1548,13 @@ static int pcxhr_probe(struct pci_dev *pci,
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
@@ -1561,13 +1568,6 @@ static int pcxhr_probe(struct pci_dev *pci,
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
2.53.0

