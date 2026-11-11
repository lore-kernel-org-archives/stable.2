Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362387;
	b=Z3l+qTRiIIl3wCMWpl2TUPzHHSd2nRwA+tf8bv054jrZeQv7Rsb1So9M+6WGrYFbuu1o
	 dfn8gHVKho8+fXSDxIPJbu/Xq438E7/ZJo+03d7VMJOzX7SChCRlpKqdhpQkNwK9J5CmT
	 KM0zorAswV1CuRJb3eE4qvyFta3oGw8znPAIrQJd6P+8eom73lj9SMuwArr3K6c+aVUz5
	 WpHgjOf8YeO00PSamF7eLQsZyPIwIbw8NNVNOQnBYgt7RLEMKrVdhosD4tPM+oX+K/Rx2
	 aN9fBheYnHqa6O17gOpo1y5Nvn3iTkq4+pVCn/pKYDBwjDnBbToNrN7cR/POm5Jo5+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362387;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zmgzUgrJuBqE70uE/n5kXQPBymErGUYD99yuhdR4Mu8=;
	b=SIktUz40dUw7x/050iA0sEeVuoxXq/5u86ohzEnGGAtnTsdEwI5JziDjFNwKx3eoPbL3
	 bznWAM+iWS7ndPan1ll6Fv5K8tVtGlQY7WWEN/SdY8FqRubHhkSysrAxd4MTl3lkPgskg
	 zSyYaJSgKE6g/y7vgWhzBBo/QrNRr+Wf1y3eLqcQF7Lq1Jyc+5k9KqcMIXQk3FwPdlxXe
	 KaYEy/c1auHvIX0t858Msd5l6NfDqbmYMgbBodq4SF0/rPHFVlfNSgjxkttTo0gOVnw2r
	 M8zZd6icXL1QAPF+oKWu5j4iJfOsBC2l1cSfBargJuQNg9cCl4yZ0nAmvsl8qxYbdgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6migRBA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16EB606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6migRBA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A891F0089F;
	Wed, 11 Nov 2026 01:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362387;
	bh=zmgzUgrJuBqE70uE/n5kXQPBymErGUYD99yuhdR4Mu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z6migRBA9QXb9pWwgCseiWcwyfgcjwhzbF5ngG1iBHxJK0HGPOOCjD2xdnbFOIH8+
	 zbg0/Wpwcd4kpz9VLU3ceuQbyV01KpEEtORNhicVxqFtAaj1wEJO12UXrfrVLDTWrV
	 yooEmNqAD5mah4LgmrpyYBTGhQKDpqqpELtDkEKs57UshrQUqNRyIRwJjbEhYboW4g
	 EDLA/f6WYWIBbcPOAFG+jX3mGdtvZwl8FdsRyOxEYfJMfOijGn4go9s0CbEP4Wgedh
	 kKgCGM/kfpRhRGy4UzeQZY9UPDvR2/mF/NfyBhyhqal/AV4KIoyJRb0IPTUG/cJiGA
	 72cvbpPMHsj0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] ALSA: emux: simplify snd_sf_list.callback handling
Date: Tue, 10 Nov 2026 20:59:43 -0500
Message-ID: <20261111015933.483997-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111015933.483997-1-sashal@kernel.org>
References: <20261107060913-failed-5.15-8a5d87c2ba30@kernel.org>
 <20261111015933.483997-1-sashal@kernel.org>
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
index a870759d179ed..a02f952d74ba2 100644
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

