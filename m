Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362040;
	b=kq4pvPHsrNZ1bbpOlBAXXJaTfLYXC4EX10dPkCPRT+mphO0lPrBJTdxluGGOI8WTJg4K
	 py9jZC/fFHZNJ0NAXy6vvz+Z/5IDDzDbRlNxPx0S1+n2w7haGADZIvUt9bVsQBI0evVkv
	 5l/4WO5G0WQ2LeUoMacYKUJb1UsQWJ4MlIagG4rQzWgqv1oY+yNZRuEX0wZa8c9vbagwj
	 X+Lu+v4wqLLan6R7tWgevSq6TbG7f+ISX1RmnihxZzADFOl0+mlQ4Zz0636ddtpp++UBs
	 MRUMTk87ydCAtYPpwe0hTTE55sdZi5J2o0RrT/TQEg+F/9vmDspjy9Ov11Xak3VinXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362040;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wkysfnGSQ64wgej+x2Wcn8wpvF1A0GWzt50mAUlrv8w=;
	b=gm9GQPD+/4y3N+NJ+iSzvWcgzfi7CxKUNVLWZQ2a5e8ldHPJXFLf/KNoUVaDe0iQ5+PH
	 c7OaEzBpSy7eY070Es4C963i1ehjFQiLWMnMxC4CL7fq6xWN3zJOqwE8+eRJlCjg+UTUY
	 ILMCoQGTNPato+JSyMcW7eNhp5BewAlXo99+l+BTeZkxbyz/nT4KgCeJ2GWIKC6AyKGDA
	 a1IN5qlnIziqQq5xUPOxuD/IEZo9xH0pLhOyVd4adfmhlDf8UKcILmeTu4jZOfDkxzapb
	 ZPYbq8JChPae67h9LP89WYcofQL+r6XE5bzDb96P4uy+ccTiXjmwealXGTH0LMUwoTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbAE0JJn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A300606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbAE0JJn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635891F0093C;
	Wed, 11 Nov 2026 01:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362039;
	bh=wkysfnGSQ64wgej+x2Wcn8wpvF1A0GWzt50mAUlrv8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QbAE0JJnFGTLUkAUsDEmViifQNvIicgyTRT6UcpOeuqvdK1mfij54+Unr8iZQGQVH
	 WHPwch03xuXW1yNJ4VYpU6vRsN3wm9/6O5WuLIgRneenSEo6HkzgPQC2amdavulkaN
	 H62fv3cz3EB7kUzzv4pjMq0ElVCZM9SWUtwq+AKixAIkhFiBQioQQbEuTUc/JTVwTa
	 OsnCdZ7tBNcL6qX6ltYGBCvw1E7XssejKY16Hry6sfQev1BuWSlKNlUZGUnT+hLFsV
	 QQRZEV0VliJAEq8tcS5cBZKX343ml+Ml96+erJpBjROSTLdHx0OTwSdrcodbjHBRP4
	 5PIZNL/3rPMMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] ALSA: emux: centralize & improve patch info validation
Date: Tue, 10 Nov 2026 20:53:55 -0500
Message-ID: <20261111015344.441072-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111015344.441072-1-sashal@kernel.org>
References: <20261107055205-failed-6.1-8a5d87c2ba30@kernel.org>
 <20261111015344.441072-1-sashal@kernel.org>
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
index 8c1e7f2bfc34a..ab4f988f080dc 100644
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
index eed47e4830248..c8775c21bc6f2 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -689,6 +689,21 @@ find_sample(struct snd_soundfont *sf, int sample_id)
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
@@ -730,6 +745,21 @@ load_data(struct snd_sf_list *sflist, const void __user *data, long count)
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
 	sp = sf_sample_new(sflist, sf);
 	if (!sp)
@@ -980,6 +1010,11 @@ load_guspatch(struct snd_sf_list *sflist, const char __user *data,
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
@@ -1017,7 +1052,7 @@ load_guspatch(struct snd_sf_list *sflist, const char __user *data,
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

