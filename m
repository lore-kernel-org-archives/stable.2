Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361579;
	b=BFsmqFqptJRO8NtDdZNeGk2mrV6cgGnOr5ZA4wuTUiFj0deH+BCkcfNMWYD84WbzZuph
	 GLHiDypp/75RQcYDx0bQaDoygc1KLANQVNr6CJmrfyeWNIbdy7//vyWwGFYo+rUFBBUiC
	 ebalTG03//7D9NfkqxznCG/yUHF8rxdID+hWrRdmdqAkdNSFPT1YRgjC2b2HfRDeN399L
	 prRZaOovvJ2OPmjTh2w4DMrLZK3babOsslVYAOTvr695nZ9bBvV6v57md7dEKTiFXDHmx
	 ariAaXpECIorKfdGdIcjt5x2SxaVbGlUk3EyNVEkrpkWtUVNxqIfWbowecAO0MgdYWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361579;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=N97Dz1oUJqXsyGK1ajQWi7mlKkhkhHY7wH3XWXZ9xmw=;
	b=dOKLRKpmkOUpf8LwAQ6eNkAvplwRiMunK4qIF9XLyx8hrasH+8+61f6qFuAdu/hf2CzW
	 TNRyZOk0zYaY6aUMQAjWLJ2cJwydqR+4X30sZ2+PW/+95wN9o/hpM16nw3/nygzpOJFT4
	 wLwLfDzLzJqrfsJ72vKg6VswhCx7UcNk533KUuPhwDl3SAon0FY6R6iW1dNzteymqBw0Z
	 IYKPoZck/bY8/rNcvBg2FNaRseCvLjEbaZSC/zzwAqnoPh6U+URVagK/3mDDch/ZBCu2Q
	 OrqEeMn1pQGfMvlLNZNgaPlDWjp7KC360B2BgY//QzRcj/S8oMRXw3Z9XgLFqUOvVtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fct1QBDj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F47606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fct1QBDj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326DA1F0089F;
	Wed, 11 Nov 2026 01:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361579;
	bh=N97Dz1oUJqXsyGK1ajQWi7mlKkhkhHY7wH3XWXZ9xmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fct1QBDjF+blQsqUVYlWcC/FkFVq2RKCGqcnw45pdDUDHlVBwG1oGSdoOEsttrVyW
	 /Cw80kvvgd3nvlVWCwxVuVmAzvTwIraiOd+phK06awcoQYKeu9aCuy05FgNcU/wYGA
	 ylXxC4aZs4OWqSQIF298G1lEK7dUKvJmazvvNZPuX+ZUELJvmvYgNxyKFowugVsE3r
	 94BVm0RGBoIpFx+mIgoLmKwceknpUpWLDGaoKPPapbYxF41DyswJFJGadr3dVv54lx
	 hWjT48OGoPnzs8hBWTIU5rdhtbIt89tYvfgMmYevX7RpOWofHHsHO7ywl5VFRXzXlF
	 igh8a57Dqz+2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] ALSA: emux: simplify snd_sf_list.callback handling
Date: Tue, 10 Nov 2026 20:46:15 -0500
Message-ID: <20261111014442.403245-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111014442.403245-1-sashal@kernel.org>
References: <20261107053715-failed-6.6-8a5d87c2ba30@kernel.org>
 <20261111014442.403245-1-sashal@kernel.org>
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

[ Upstream commit 4c4cbe66828f185903d2127aed6ac9b7302e9d3a ]

Both drivers provide both sample_new and sample_free, and it makes no
sense to pretend that they could not. In fact, load_data() would already
crash if sample_new was null. So remove the remaining null checks.

Contrary to that, the emu10k1 driver actually has a null sample_reset,
though I'm not convinced that this inconsistency is justified.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Message-ID: <20240406064830.1029573-18-oswald.buddenhagen@gmx.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 8a5d87c2ba30 ("ALSA: emux: Stop voices before freeing zones in all cases")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/synth/emux/emux.c      |  6 ++----
 sound/synth/emux/soundfont.c | 12 +++++-------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index 0006c3ddb51d6..7966590f2edbc 100644
--- a/sound/synth/emux/emux.c
+++ b/sound/synth/emux/emux.c
@@ -94,10 +94,8 @@ int snd_emux_register(struct snd_emux *emu, struct snd_card *card, int index, ch
 	/* create soundfont list */
 	memset(&sf_cb, 0, sizeof(sf_cb));
 	sf_cb.private_data = emu;
-	if (emu->ops.sample_new)
-		sf_cb.sample_new = sf_sample_new;
-	if (emu->ops.sample_free)
-		sf_cb.sample_free = sf_sample_free;
+	sf_cb.sample_new = sf_sample_new;
+	sf_cb.sample_free = sf_sample_free;
 	if (emu->ops.sample_reset)
 		sf_cb.sample_reset = sf_sample_reset;
 	emu->sflist = snd_sf_new(&sf_cb, emu->memhdr);
diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
index c8775c21bc6f2..c803c5c756114 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -1052,7 +1052,7 @@ load_guspatch(struct snd_sf_list *sflist, const char __user *data,
 	/*
 	 * load wave data
 	 */
-	if (smp->v.size > 0 && sflist->callback.sample_new) {
+	if (smp->v.size > 0) {
 		rc = sflist->callback.sample_new
 			(sflist->callback.private_data, smp, sflist->memhdr,
 			 data, count);
@@ -1417,9 +1417,8 @@ snd_sf_clear(struct snd_sf_list *sflist)
 		}
 		for (sp = sf->samples; sp; sp = nextsp) {
 			nextsp = sp->next;
-			if (sflist->callback.sample_free)
-				sflist->callback.sample_free(sflist->callback.private_data,
-							     sp, sflist->memhdr);
+			sflist->callback.sample_free(sflist->callback.private_data,
+						     sp, sflist->memhdr);
 			kfree(sp);
 		}
 		kfree(sf);
@@ -1521,9 +1520,8 @@ snd_soundfont_remove_unlocked(struct snd_sf_list *sflist)
 			nextsp = sp->next;
 			sf->samples = nextsp;
 			sflist->mem_used -= sp->v.truesize;
-			if (sflist->callback.sample_free)
-				sflist->callback.sample_free(sflist->callback.private_data,
-							     sp, sflist->memhdr);
+			sflist->callback.sample_free(sflist->callback.private_data,
+						     sp, sflist->memhdr);
 			kfree(sp);
 		}
 	}
-- 
2.53.0

