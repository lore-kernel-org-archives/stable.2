Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F74BE458
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067317; cv=none; b=tYKo1jthHbZck2WKKqIx/Ft2pCHcw1U8o7qz4Xz7kXYA+p5mKpmdiEH56mMIElAw/+wIcExsPI0VNb9vdJEh52ha9hF4+KCvtk/JqrEdWqu1yKM/wQPsNuHFBnl99XTW7RF1ukV3NCr2SzkvJM9M4Ac++uvNBxypT0FMQyULMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067317; c=relaxed/simple;
	bh=sqyG/KNceo/wr5qB13q9rdbDTAscoFUOOWjnKOsQRUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYySavkAIxNGew/2hYJ5K8GkG0/JPQC/OeX10AxKY8AnGLPIyjmFlSKnVf1DMMd209eTnIaARQkvdva64GbpgJsG4g6nM6HvtjIZjMczH7LE3BxWx1BPknmnN2CN6lfY3xQfjtyq+bz/E0I1OzFvvPYhNAw30wUXunD0suzqf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqpqutQq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqpqutQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8B11F00893;
	Thu, 10 Sep 2026 19:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067315;
	bh=t4xivgo4dch78Ogc4FwQL8DE1qNJlu5W9ljGfnUArdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DqpqutQqfZ/rlB7sX3gOVrecbp+LEs39qXfvodsYJMr5Q+lwwB+i13vkcIu9pSoLK
	 u1B7KXWkk7bqnaeU+8cvFjiBkyFYHaq6Kr3pR1C5RLEje47I16ndynD7LvSKvKKehO
	 14UXoBRQ2pBIUwusAIr1tj+eR4c3wDtd+nF0EZD4kKSnx2GOoumKO9w4QuyDOGn6yc
	 H4SbK0NvAfCbZgrFMbhhyDogIPQiUMIZcXYVyBpt0CiVlYmI3E63E9KM68k/0HWvfS
	 zGycvYPPMTKNqDJOOCnPS9QuS+zuNoOoQkHGLAD/hog4SnUf30rltDdo4fqrftpLOl
	 VLIEghCLSbIBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] ALSA: harmony: initialize locks before requesting IRQ
Date: Thu, 10 Sep 2026 15:08:33 -0400
Message-ID: <20260910190833.1452894-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910190833.1452894-1-sashal@kernel.org>
References: <2026090915-crucial-humpback-b546@gregkh>
 <20260910190833.1452894-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 33abb7491e89285a41565670945293dda841afc4 ]

snd_harmony_create() registers the IRQ before initializing h->lock and
h->mixer_lock. A pending interrupt can invoke the handler while these
locks are uninitialized.

Initialize both locks before requesting the IRQ so the handler always
sees valid lock state.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260830063411.2215691-1-runyu.xiao@seu.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/parisc/harmony.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index 1440db8b4177f..f5cbcf7a7469a 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -903,6 +903,9 @@ snd_harmony_create(struct snd_card *card,
 		goto free_and_ret;
 	}
 		
+	spin_lock_init(&h->mixer_lock);
+	spin_lock_init(&h->lock);
+
 	err = request_irq(padev->irq, snd_harmony_interrupt, 0,
 			  "harmony", h);
 	if (err) {
@@ -912,9 +915,6 @@ snd_harmony_create(struct snd_card *card,
 	}
 	h->irq = padev->irq;
 
-	spin_lock_init(&h->mixer_lock);
-	spin_lock_init(&h->lock);
-
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, h, &ops);
 	if (err < 0)
 		goto free_and_ret;
-- 
2.53.0

