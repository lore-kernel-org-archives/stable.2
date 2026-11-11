Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362866;
	b=v+YKC/iX9ocijRDSkpPfnqxTXf0c1m++gBNJKXiIXJo5yehe7oCWoUUCzzHCC38YZbU1
	 2CbQvh16pTKapjZrUAFbqFKj+W2/fxW1oMm5NdYs9iTsJwvJSEhRRofzQKp05fVMA3yk2
	 8L2HAMOde2WHpIIrlBGK7ubpwBrrYxOfy42IadCUfT8kqMk+CDRWjYR7PJZLqG88O0xpE
	 eAKaiuFKdE00e+r5HnpzRwxiKBCQ73IvuvN7KE5RqsQZMDqJg5X9PHDDeb3POfnN7IYtN
	 Msss2EjuVm+Mg7BLjCjkQSIHrNrijb6zriw2RTpNAEmvJi5gGLv0vHwwZqcPW6XFN0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362866;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eJQRWMgBraZChFUfl0wBOVyZe96i91WA49Js/szFzPE=;
	b=5JRmISI369ln13x68vruK4zHaV05V64Fz44lUKTbt9YKlKRaQbjb8QnZE0NIbXPA7usw
	 c/80cPIGjK6rQv8inE+zoP3++ZhBDj7aJPcwrgS4dAZYWz9PV68E0UqWTp3md2m+dmWG+
	 86gERbJrpKKmgwex8rJahRRPaFyd+Uz4rm6Wmk1JMOJGMEVvgCSLm5GwFy0i/2WHwzTje
	 0yHQcKJJZ17mXe8IIdPsdfa2tNvE+kyW2peWJuRWoiXl0m/iBKWN9QChClJaRcdJW63Xd
	 /wZqZ0uF12e1FowPRcrqs+xishDSQFCk+3o8m7LXS8BMVDGvoIkoVSFTJTa8FrGABcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtuOT1eD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF633606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtuOT1eD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D014E1F0089F;
	Wed, 11 Nov 2026 02:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362866;
	bh=eJQRWMgBraZChFUfl0wBOVyZe96i91WA49Js/szFzPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EtuOT1eDrcXcvBAl1ydMrc7jDvMoKsYkf9r5EBAjcW0RCW9UG5YpnHyAjTsQVbFMz
	 dZ/JiDeGXVtjx1wThKrjtP74p0O2wgjdF5sdaWf9taUQH7FcPLC70UJaN+Ni52GY6o
	 1KDxTjqX1pqp3bGyFQWgYSDJfbDTW52tAJxkSZzHiD+Y5VgfrkPyFgbL8M+eSPEwfE
	 MVghP0tO045m4F2Vt6IHxn1sVZbxrU4YoKT5eijtpdpldTmpHtmnUCF6f/hlUEVMah
	 yzxEoaJYBWMTfsvgYCnwCoZTglNJcNc/yG/9KVfpVqCeulLFzVQWLzMCQ+SHUQ983k
	 XPnf/yUFU/Sfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] ALSA: emu10k1: prune vestiges of SNDRV_SFNT_SAMPLE_{BIDIR,REVERSE}_LOOP support
Date: Tue, 10 Nov 2026 21:07:41 -0500
Message-ID: <20261111020723.548248-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062607-failed-5.10-8a5d87c2ba30@kernel.org>
References: <20261107062607-failed-5.10-8a5d87c2ba30@kernel.org>
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

