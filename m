Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362867;
	b=nEp67f7v882O9uvLuFNUtezWkDBwOR/0eU9zfTIBvC6NupSJ350Ctm4w90lGwQW3KwrJ
	 XHWh/e6mx4CggL+RkvVAUViwADmbuX6AANGuXKYMXUOpFQF56K0kk1ru4AayBVBo+7pc5
	 82NpyhmmxKihoz5Fg5Rh/TcQ8cIAidBWn37bX6gxQSQf0oW+vSP0FCYBlg4Bxd13jz7+L
	 YP9vjxBFC88jZMlaTjdPQ8MyhEje9ZFDJgJ/xMuYsIexa35umIYKdGEodTPjhV13jH79q
	 KSlukrar8e0xDiwmdCAQwrjBk470pppnBCcZ3l2XkbjcL6MtppxDTsNSCkh7AyePASw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362867;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WpPpVTG/Xvv534Kyndwt0ad2UtNDp6S36RBAMzKb9cg=;
	b=WuvknfIb/0fpwzsjduVr2QDlz7HMI/Z8YWHzTq1Qb7BK40Biczf+X5+sga7IdmlVO5UL
	 ahVsU8obX42aXE0Y6WF4Zy6lPcP1o/VzAjxrKP318eL8t+rsXOMrMmj8mV59BoPqkuG1+
	 NWc1eaqTWNmlKcVYgd/yUd1ibkDwd1p9znsd4RrDRgyZkG3Bil1hateeuKFzkRxT8ZfEL
	 L0f2zOM8+UlySN1bT5DaW5NRJJrS5iwfyyw/sBvcjouGNKv8IfEenuqEobraAgZ0EtOAs
	 jd/JZO7js4CapVaPZ1zS7A0Fhy/SafcLO9huVXXloV9XbgiK7SJSrTRhh1JZ21JLRLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldK6qlsz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A751606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldK6qlsz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9334D1F0093C;
	Wed, 11 Nov 2026 02:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362867;
	bh=WpPpVTG/Xvv534Kyndwt0ad2UtNDp6S36RBAMzKb9cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ldK6qlszNlmTmwzVl3/lRsw0/SKPT3BOCVh1+v5Rt71yYkYImoAfMfnUhLG3Z9REr
	 DBSeLQC9zgmRTx9m9uvzgciAR8ttj5U59NMKPeNa/bW+3RAk8Id0XPSBPXzhVk1R61
	 N05fCaD0klUVUOWXYsXMJiQ4XpmbOREmNLiuF/VYUWetpWU1d2dcxY71C0hGhZ+Zfh
	 amRDfV3TYleqjkiqp7OE74gEw6ED4OitHwImjZAqpj/Qq5H84DzRTPE4mk/UZ4s6Re
	 C4vViwsC4La7TlYRgMKKgWW7lAIoS7HIWkra6feX7QbgqtUwRhJa5112qFoHwhUaox
	 p87Rb0vC7qV2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] ALSA: emux: centralize & improve patch info validation
Date: Tue, 10 Nov 2026 21:07:42 -0500
Message-ID: <20261111020723.548248-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111020723.548248-1-sashal@kernel.org>
References: <20261107062607-failed-5.10-8a5d87c2ba30@kernel.org>
 <20261111020723.548248-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

[ Upstream commit de67aab120d4d5ba7d9e94ee5b25464ae0d1bd0e ]

This does several closely related things:
- Move the code from the drivers into the SoundFont loader, which
  de-duplicates it.
- Sort of explain the weird "recalculate address offset" feature. Note
  that I don't think it actually makes any sense - the calling user
  space code should do that. The background is certainly that the source
  data (the SoundFont format) uses pointers into a single wave block
  (and the API allows doing the same for on-board ROM), but the API
  expects the wave data from user space to be pre-chopped into
  individual patches anyway.
- Make sure that the specified offsets actually lie within the supplied
  wave data. Note that we don't validate ROM offsets, so one can play
  back anything within the sound card's address space.
- In load_guspatch(), don't call the sample_new callback anymore when
  the patch size is zero, as was already the case in load_data(). The
  callbacks would instantly return in that case anyway; these checks are
  now removed.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Message-ID: <20240406064830.1029573-7-oswald.buddenhagen@gmx.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 8a5d87c2ba30 ("ALSA: emux: Stop voices before freeing zones in all cases")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/sb/emu8000_patch.c      | 13 -----------
 sound/pci/emu10k1/emu10k1_patch.c | 16 -------------
 sound/synth/emux/soundfont.c      | 37 ++++++++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/sound/isa/sb/emu8000_patch.c b/sound/isa/sb/emu8000_patch.c
index 0cb94cafb4c9b..b8b9edd98ac6a 100644
--- a/sound/isa/sb/emu8000_patch.c
+++ b/sound/isa/sb/emu8000_patch.c
@@ -148,13 +148,6 @@ snd_emu8000_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 	if (snd_BUG_ON(!sp))
 		return -EINVAL;
 
-	if (sp->v.size == 0)
-		return 0;
-
-	/* be sure loop points start < end */
-	if (sp->v.loopstart > sp->v.loopend)
-		swap(sp->v.loopstart, sp->v.loopend);
-
 	/* compute true data size to be loaded */
 	truesize = sp->v.size;
 	if (sp->v.mode_flags & (SNDRV_SFNT_SAMPLE_BIDIR_LOOP|SNDRV_SFNT_SAMPLE_REVERSE_LOOP))
@@ -177,12 +170,6 @@ snd_emu8000_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 			return -EFAULT;
 	}
 
-	/* recalculate address offset */
-	sp->v.end -= sp->v.start;
-	sp->v.loopstart -= sp->v.start;
-	sp->v.loopend -= sp->v.start;
-	sp->v.start = 0;
-
 	/* dram position (in word) -- mem_offset is byte */
 	dram_offset = EMU8000_DRAM_OFFSET + (sp->block->offset >> 1);
 	dram_start = dram_offset;
diff --git a/sound/pci/emu10k1/emu10k1_patch.c b/sound/pci/emu10k1/emu10k1_patch.c
index 49214c2268084..47d69a0e44bc6 100644
--- a/sound/pci/emu10k1/emu10k1_patch.c
+++ b/sound/pci/emu10k1/emu10k1_patch.c
@@ -35,28 +35,12 @@ snd_emu10k1_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 	if (snd_BUG_ON(!sp || !hdr))
 		return -EINVAL;
 
-	if (sp->v.size == 0) {
-		dev_dbg(emu->card->dev,
-			"emu: rom font for sample %d\n", sp->v.sample);
-		return 0;
-	}
-
 	if (sp->v.mode_flags & (SNDRV_SFNT_SAMPLE_BIDIR_LOOP | SNDRV_SFNT_SAMPLE_REVERSE_LOOP)) {
 		/* should instead return -ENOTSUPP; but compatibility */
 		printk(KERN_WARNING "Emu10k1 wavetable patch %d with unsupported loop feature\n",
 		       sp->v.sample);
 	}
 
-	/* recalculate address offset */
-	sp->v.end -= sp->v.start;
-	sp->v.loopstart -= sp->v.start;
-	sp->v.loopend -= sp->v.start;
-	sp->v.start = 0;
-
-	/* be sure loop points start < end */
-	if (sp->v.loopstart >= sp->v.loopend)
-		swap(sp->v.loopstart, sp->v.loopend);
-
 	/* compute true data size to be loaded */
 	truesize = sp->v.size + BLANK_HEAD_SIZE;
 	if (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_NO_BLANK)
diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
index 18b2d84926563..469aa974f8fe0 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -685,6 +685,21 @@ find_sample(struct snd_soundfont *sf, int sample_id)
 }
 
 
+static int
+validate_sample_info(struct soundfont_sample_info *si)
+{
+	if (si->end < 0 || si->end > si->size)
+		return -EINVAL;
+	if (si->loopstart < 0 || si->loopstart > si->end)
+		return -EINVAL;
+	if (si->loopend < 0 || si->loopend > si->end)
+		return -EINVAL;
+	/* be sure loop points start < end */
+	if (si->loopstart > si->loopend)
+		swap(si->loopstart, si->loopend);
+	return 0;
+}
+
 /*
  * Load sample information, this can include data to be loaded onto
  * the soundcard.  It can also just be a pointer into soundcard ROM.
@@ -725,6 +740,21 @@ load_data(struct snd_sf_list *sflist, const void __user *data, long count)
 		return -EINVAL;
 	}
 
+	if (sample_info.size > 0) {
+		if (sample_info.start < 0)
+			return -EINVAL;
+
+		// Here we "rebase out" the start address, because the
+		// real start is the start of the provided sample data.
+		sample_info.end -= sample_info.start;
+		sample_info.loopstart -= sample_info.start;
+		sample_info.loopend -= sample_info.start;
+		sample_info.start = 0;
+
+		if (validate_sample_info(&sample_info) < 0)
+			return -EINVAL;
+	}
+
 	/* Allocate a new sample structure */
 	if ((sp = sf_sample_new(sflist, sf)) == NULL)
 		return -ENOMEM;
@@ -973,6 +1003,11 @@ load_guspatch(struct snd_sf_list *sflist, const char __user *data,
 	smp->v.loopend = patch.loop_end;
 	smp->v.size = patch.len;
 
+	if (validate_sample_info(&smp->v) < 0) {
+		sf_sample_delete(sflist, sf, smp);
+		return -EINVAL;
+	}
+
 	/* set up mode flags */
 	smp->v.mode_flags = 0;
 	if (!(patch.mode & WAVE_16_BITS))
@@ -1009,7 +1044,7 @@ load_guspatch(struct snd_sf_list *sflist, const char __user *data,
 	/*
 	 * load wave data
 	 */
-	if (sflist->callback.sample_new) {
+	if (smp->v.size > 0 && sflist->callback.sample_new) {
 		rc = sflist->callback.sample_new
 			(sflist->callback.private_data, smp, sflist->memhdr,
 			 data, count);
-- 
2.53.0

