Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361578;
	b=KdohBl1R00xucHu0MGyyIfsFZt6EX9YQY06qyJaZJB4TaTYAkjKvuRf/gamZG73CU27D
	 fsAlr7tV/zFwQVubyEIiyK7zlCXF+5E2R3Yw+xnjBUFjgRYukHTlAvulsTKixCgRia+RJ
	 yw4bm2vV4zNJIKBYIeRxp6EPLyy4RgxmNHjhnRlW43dkCydWPerJ9mgmyVZ4KgJixStOw
	 /x9VpB/z2aJ28ZLdUjatlo7igZS4cGgPBq2365g3Aq+VQ0z3zDFRV7I59GBrtVwbMLchc
	 ui/eWFfkUmOw5sI5ccCIyQ8ZPGfYsmbWdtTZe1dw5lbBQysu22nKJZsnwU5eb/azadw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361578;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eJQRWMgBraZChFUfl0wBOVyZe96i91WA49Js/szFzPE=;
	b=m1Mtm3HbpgGRSCtw5azb7BlCvMU1mfvOH5Iz+ORC8ACr+XLbAaI4iXCRnfnS6++TK97c
	 l2247gLhK++tOzZDvi23T+LnPX3uzee7aGiBs8hZUfWXEJxoBwoahaaomvvMySc2gp1Pk
	 O8vriCX2wo4/wZ0iNBG1s9uMIqe70RViUW/h8jOWW8UKSYHGSEJBNx/H8TcJx3Sq0uP37
	 va2tS+LifaHqfdpftFVE9eqLhpiL5QNsvg9q7EMBQXvWN3fGxQswMirz9c9Naty7Qaspv
	 eiL7Tg3+cNPwY3WVvOg/Ru4MENh4gdabsHFdFGAoXVcMWqYcc0fPX/nsNfrzoEOP2pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAGh0+hr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C242606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAGh0+hr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB89E1F0089F;
	Wed, 11 Nov 2026 01:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361578;
	bh=eJQRWMgBraZChFUfl0wBOVyZe96i91WA49Js/szFzPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MAGh0+hrvTtEGuzh56qZw2jXuSi7TM9X/xbuIilS4kf+tx9uXGrrgav1LseITSgoc
	 kN2eoAGQfmZSWJ8Pb0UBiPbiFK1oCAn77eKaLTEinThcaIE/SDxiyPylSQl/hcFpm7
	 brmBJ+rv4AFxbQTnfkr/6WqYo0YjlnxxS80TwKhGvnkCUiuPLwcXtQT03hxs/Ehh3F
	 L/c2LKHG7+7Kgg4Pwyr/4G4Cc6JwO0rVXztyUlqVvPy3L0iLMGsBF86mJr45Psw2OL
	 2QIT0tQSFsvNSNkKy+OYwY2z0jMtYCfHBaaVBN7ziZvkqP9SJg9WTECn+ALGdvEVki
	 Y8jyaZLaxZeXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] ALSA: emu10k1: prune vestiges of SNDRV_SFNT_SAMPLE_{BIDIR,REVERSE}_LOOP support
Date: Tue, 10 Nov 2026 20:46:13 -0500
Message-ID: <20261111014442.403245-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053715-failed-6.6-8a5d87c2ba30@kernel.org>
References: <20261107053715-failed-6.6-8a5d87c2ba30@kernel.org>
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

[ Upstream commit 1edeac6555e9df008b1729ca445868c1177baa8b ]

This is required only to implement WAVE_BIDIR_LOOP and WAVE_LOOP_BACK in
the GUS patch loader. It has not worked on emu10k1 since before ALSA hit
mainline, yet nobody appears to have complained. And as it isn't super
easy to implement, just admit defeat and clean up the code.

If somebody wanted to resurrect the feature, the emu8k driver could
serve as a template, but the code would be quite different. But
arguably, this should be done in user space in the first place, as this
doesn't represent a hardware feature (somewhat ironically, the actual
GUS driver has no synth support, and therefore no GUS patch loader).

Note that instead of properly rejecting affected samples, we continue to
just pretend that the feature wasn't requested. This is extremely
questionable behavior, but avoids that possibly unused instruments
suddenly prevent loading the entire file, which would break backwards
compatibility. But at least we log a warning now.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Message-ID: <20240406064830.1029573-6-oswald.buddenhagen@gmx.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 8a5d87c2ba30 ("ALSA: emux: Stop voices before freeing zones in all cases")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/emu10k1/emu10k1_patch.c | 73 ++++---------------------------
 1 file changed, 8 insertions(+), 65 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_patch.c b/sound/pci/emu10k1/emu10k1_patch.c
index 89890f24509f0..49214c2268084 100644
--- a/sound/pci/emu10k1/emu10k1_patch.c
+++ b/sound/pci/emu10k1/emu10k1_patch.c
@@ -28,8 +28,6 @@ snd_emu10k1_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 {
 	int offset;
 	int truesize, size, blocksize;
-	__maybe_unused int loopsize;
-	int loopend, sampleend;
 	unsigned int start_addr;
 	struct snd_emu10k1 *emu;
 
@@ -43,32 +41,24 @@ snd_emu10k1_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 		return 0;
 	}
 
+	if (sp->v.mode_flags & (SNDRV_SFNT_SAMPLE_BIDIR_LOOP | SNDRV_SFNT_SAMPLE_REVERSE_LOOP)) {
+		/* should instead return -ENOTSUPP; but compatibility */
+		printk(KERN_WARNING "Emu10k1 wavetable patch %d with unsupported loop feature\n",
+		       sp->v.sample);
+	}
+
 	/* recalculate address offset */
 	sp->v.end -= sp->v.start;
 	sp->v.loopstart -= sp->v.start;
 	sp->v.loopend -= sp->v.start;
 	sp->v.start = 0;
 
-	/* some samples have invalid data.  the addresses are corrected in voice info */
-	sampleend = sp->v.end;
-	if (sampleend > sp->v.size)
-		sampleend = sp->v.size;
-	loopend = sp->v.loopend;
-	if (loopend > sampleend)
-		loopend = sampleend;
-
 	/* be sure loop points start < end */
 	if (sp->v.loopstart >= sp->v.loopend)
 		swap(sp->v.loopstart, sp->v.loopend);
 
 	/* compute true data size to be loaded */
 	truesize = sp->v.size + BLANK_HEAD_SIZE;
-	loopsize = 0;
-#if 0 /* not supported */
-	if (sp->v.mode_flags & (SNDRV_SFNT_SAMPLE_BIDIR_LOOP|SNDRV_SFNT_SAMPLE_REVERSE_LOOP))
-		loopsize = sp->v.loopend - sp->v.loopstart;
-	truesize += loopsize;
-#endif
 	if (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_NO_BLANK)
 		truesize += BLANK_LOOP_SIZE;
 
@@ -96,8 +86,8 @@ snd_emu10k1_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 	snd_emu10k1_synth_bzero(emu, sp->block, offset, size);
 	offset += size;
 
-	/* copy start->loopend */
-	size = loopend;
+	/* copy provided samples */
+	size = sp->v.size;
 	if (! (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS))
 		size *= 2;
 	if (offset + size > blocksize)
@@ -108,53 +98,6 @@ snd_emu10k1_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 		return -EFAULT;
 	}
 	offset += size;
-	data += size;
-
-#if 0 /* not supported yet */
-	/* handle reverse (or bidirectional) loop */
-	if (sp->v.mode_flags & (SNDRV_SFNT_SAMPLE_BIDIR_LOOP|SNDRV_SFNT_SAMPLE_REVERSE_LOOP)) {
-		/* copy loop in reverse */
-		if (! (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS)) {
-			int woffset;
-			unsigned short *wblock = (unsigned short*)block;
-			woffset = offset / 2;
-			if (offset + loopsize * 2 > blocksize)
-				return -EINVAL;
-			for (i = 0; i < loopsize; i++)
-				wblock[woffset + i] = wblock[woffset - i -1];
-			offset += loopsize * 2;
-		} else {
-			if (offset + loopsize > blocksize)
-				return -EINVAL;
-			for (i = 0; i < loopsize; i++)
-				block[offset + i] = block[offset - i -1];
-			offset += loopsize;
-		}
-
-		/* modify loop pointers */
-		if (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_BIDIR_LOOP) {
-			sp->v.loopend += loopsize;
-		} else {
-			sp->v.loopstart += loopsize;
-			sp->v.loopend += loopsize;
-		}
-		/* add sample pointer */
-		sp->v.end += loopsize;
-	}
-#endif
-
-	/* loopend -> sample end */
-	size = sp->v.size - loopend;
-	if (size < 0)
-		return -EINVAL;
-	if (! (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS))
-		size *= 2;
-	if (snd_emu10k1_synth_copy_from_user(emu, sp->block, offset, data, size)) {
-		snd_emu10k1_synth_free(emu, sp->block);
-		sp->block = NULL;
-		return -EFAULT;
-	}
-	offset += size;
 
 	/* clear rest of samples (if any) */
 	if (offset < blocksize)
-- 
2.53.0

