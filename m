Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F63045FFAC
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075872; cv=none; b=f54Qd4Epgc0vrcihJZdBot1X9IxL/UWuJylEiIAWrYFajrIfBmPQqUFFaehuuiOHCUwFUCs6O+ISXkZT5HQ57kv8+wV1AgKXHpe1oldYxjYNR4HmfC1NrWMyDUFNhlPhTADPl+BIbDw2wjq0IjAavFcPZbJ4a1EHTlVSDSjNnFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075872; c=relaxed/simple;
	bh=5a+OcSgC8CuM08Dqbxl+0nsRVXHDfAwi+e6G+IgxVbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvEz+OMwAQruyDRzM4fMgi6tqdZg2K/3AVGdujk1gSDXAAMuvErTKKC50JUAKIHYnVdXogJ96/luLVIIc3SHDOJIc/6+WjiMIMc9dzbR/MG39eQquNHUEFkw582sVH8og32Ry7rJo8CSWwjFU2cdnVuI3aF4t+CFUcNAqt73rgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQmFhTgI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQmFhTgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEAC1F000E9;
	Tue, 18 Aug 2026 17:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787075871;
	bh=ZOwRQOYzjasQvlPZJeqbM8Vb4SCoD3VhyZR88MJjiII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gQmFhTgI5F0uZYs2cksnJCypegyyOjQDbgMmaGQHXyeDn6lPun9ltkwgn2kZ7gd8a
	 lJwdSZvzog11eNJcxBIlXIQM9k8FDzkwgzfgZIaKDifex/YkIw+mcnj041VGnVpgLQ
	 1KfDQBkJnls47XQ+FmLYsj8lmtmWMVzZyycnMikFLKggg5qZik2HAg0vcMbqKnwdwX
	 BuDm8vdz7b5lLWBXI5ysh3MM4iYN8BNeHqm6HViYvsECfczRjeotDoBtOgGD4ui3iv
	 fl/wTTWkOE75sxtNcoIEozeB3LngPBsQe/rbFQIimKI6LV5A+0rL2E24F0O4hdB8c7
	 nADaLUDULwfeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ALSA: usx2y: Fix potential leaks of uninitialized memory
Date: Tue, 18 Aug 2026 13:57:48 -0400
Message-ID: <20260818175749.2748626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081720-deviant-snipping-e432@gregkh>
References: <2026081720-deviant-snipping-e432@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 4e268db74770b454b877ab5260f1868a457d212c ]

usx2y drivers may expose the allocated pages via mmap, but it performs
zero-clear only for the struct size, not aligned with the page size.
This leaves out some uninitialized trailing bytes.

This patch fixes the clearance to cover all memory that are exposed to
user-space.

Link: https://lore.kernel.org/r/20210517131545.27252-5-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 2ca1eea3cd17 ("ALSA: usx2y: bound the hwdep mmap fault offset")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/usx2y/usX2Yhwdep.c      |  8 ++++----
 sound/usb/usx2y/usbus428ctldefs.h |  2 ++
 sound/usb/usx2y/usbusx2y.c        |  2 +-
 sound/usb/usx2y/usx2yhwdeppcm.c   | 13 ++++++++-----
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index 2d4e943be2da..0ed50be89271 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -55,17 +55,17 @@ static int snd_us428ctls_mmap(struct snd_hwdep *hw, struct file *filp, struct vm
 		return -EBUSY;
 
 	/* if userspace tries to mmap beyond end of our buffer, fail */
-	if (size > PAGE_ALIGN(sizeof(struct us428ctls_sharedmem))) {
-		snd_printd("%lu > %lu\n", size, (unsigned long)sizeof(struct us428ctls_sharedmem));
+	if (size > US428_SHAREDMEM_PAGES) {
+		snd_printd("%lu > %lu\n", size, (unsigned long)US428_SHAREDMEM_PAGES);
 		return -EINVAL;
 	}
 
 	if (!us428->us428ctls_sharedmem) {
 		init_waitqueue_head(&us428->us428ctls_wait_queue_head);
-		us428->us428ctls_sharedmem = alloc_pages_exact(sizeof(struct us428ctls_sharedmem), GFP_KERNEL);
+		us428->us428ctls_sharedmem = alloc_pages_exact(US428_SHAREDMEM_PAGES, GFP_KERNEL);
 		if (!us428->us428ctls_sharedmem)
 			return -ENOMEM;
-		memset(us428->us428ctls_sharedmem, -1, sizeof(struct us428ctls_sharedmem));
+		memset(us428->us428ctls_sharedmem, -1, US428_SHAREDMEM_PAGES);
 		us428->us428ctls_sharedmem->ctl_snapshot_last = -2;
 	}
 	area->vm_ops = &us428ctls_vm_ops;
diff --git a/sound/usb/usx2y/usbus428ctldefs.h b/sound/usb/usx2y/usbus428ctldefs.h
index 06b27d23d3c2..9ba15d974e63 100644
--- a/sound/usb/usx2y/usbus428ctldefs.h
+++ b/sound/usb/usx2y/usbus428ctldefs.h
@@ -89,3 +89,5 @@ struct us428ctls_sharedmem {
 	struct us428_p4out	p4out[N_US428_P4OUT_BUFS];
 	int			p4out_last, p4out_sent;
 };
+
+#define US428_SHAREDMEM_PAGES	PAGE_ALIGN(sizeof(struct us428ctls_sharedmem))
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 34d5f5379632..ac584795606c 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -376,7 +376,7 @@ static void snd_usx2y_card_private_free(struct snd_card *card)
 	usb_free_urb(usx2y->in04_urb);
 	if (usx2y->us428ctls_sharedmem)
 		free_pages_exact(usx2y->us428ctls_sharedmem,
-				 sizeof(*usx2y->us428ctls_sharedmem));
+				 US428_SHAREDMEM_PAGES);
 	if (usx2y->card_index >= 0 && usx2y->card_index < SNDRV_CARDS)
 		snd_usx2y_card_used[usx2y->card_index] = 0;
 }
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 9219341d71c7..b988a4870de4 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -485,6 +485,9 @@ static int usx2y_usbpcm_urbs_start(struct snd_usx2y_substream *subs)
 	return err;
 }
 
+#define USX2Y_HWDEP_PCM_PAGES	\
+	PAGE_ALIGN(sizeof(struct snd_usx2y_hwdep_pcm_shm))
+
 /*
  * prepare callback
  *
@@ -501,11 +504,11 @@ static int snd_usx2y_usbpcm_prepare(struct snd_pcm_substream *substream)
 	snd_printdd("snd_usx2y_pcm_prepare(%p)\n", substream);
 
 	if (!usx2y->hwdep_pcm_shm) {
-		usx2y->hwdep_pcm_shm = alloc_pages_exact(sizeof(struct snd_usx2y_hwdep_pcm_shm),
+		usx2y->hwdep_pcm_shm = alloc_pages_exact(USX2Y_HWDEP_PCM_PAGES,
 							 GFP_KERNEL);
 		if (!usx2y->hwdep_pcm_shm)
 			return -ENOMEM;
-		memset(usx2y->hwdep_pcm_shm, 0, sizeof(struct snd_usx2y_hwdep_pcm_shm));
+		memset(usx2y->hwdep_pcm_shm, 0, USX2Y_HWDEP_PCM_PAGES);
 	}
 
 	mutex_lock(&usx2y->pcm_mutex);
@@ -692,8 +695,8 @@ static int snd_usx2y_hwdep_pcm_mmap(struct snd_hwdep *hw, struct file *filp, str
 		return -EBUSY;
 
 	/* if userspace tries to mmap beyond end of our buffer, fail */
-	if (size > PAGE_ALIGN(sizeof(struct snd_usx2y_hwdep_pcm_shm))) {
-		snd_printd("%lu > %lu\n", size, (unsigned long)sizeof(struct snd_usx2y_hwdep_pcm_shm));
+	if (size > USX2Y_HWDEP_PCM_PAGES) {
+		snd_printd("%lu > %lu\n", size, (unsigned long)USX2Y_HWDEP_PCM_PAGES);
 		return -EINVAL;
 	}
 
@@ -711,7 +714,7 @@ static void snd_usx2y_hwdep_pcm_private_free(struct snd_hwdep *hwdep)
 	struct usx2ydev *usx2y = hwdep->private_data;
 
 	if (usx2y->hwdep_pcm_shm)
-		free_pages_exact(usx2y->hwdep_pcm_shm, sizeof(struct snd_usx2y_hwdep_pcm_shm));
+		free_pages_exact(usx2y->hwdep_pcm_shm, USX2Y_HWDEP_PCM_PAGES);
 }
 
 int usx2y_hwdep_pcm_new(struct snd_card *card)
-- 
2.53.0

