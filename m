Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362868;
	b=vMK1cVn7JaK9JFJh1px3jbgfY0hv2Mt7C1sME5KiQmnKK9yk2oJwtW8ipt9QqZs3l5SI
	 Syt7RmDZ/En5cSKgHD3G1TwI0nrQakxpNDZ+f6hVZgytPAKb9WgOtLynd8gUf37cEZMuH
	 CiKADCeOqTTIawqfMSoVSi+T43wTIcV3cTpTlzjTLbRhY/6hVBzX14VYqprhLRtH9wEGY
	 CbFAnQad/fw6iTIGDwrRYIRmeh6OTvuXNs4TabaqQQiB+ha2ABPGtUUTSREqY58hYDbT0
	 L/v8P6x3Wlf0EvuG/6kxumEdmSsavHj1TZ7pJMdAVhAnmK6xso9kgIzUNszXktz2ygA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362868;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=re1nwLZfEOZeN5xVZlD8EQntEHOz9K9vOE9tO4am2Vg=;
	b=lRIiLjTx1rXqe/07jzz4rQDOJ/LxmpJfsfhZxf1lAR9iBzdpuYiMr9mcj4INeEfQ4pg6
	 hNKp8fx8DLi4dmf4haLRuXoIpKgFoG3gjTza6I293V4BNZX2BuF9C+xEbXC8lA5Vssy+L
	 YSEPZCjrAoIoxkGvZILyCgr928l4/3eNs0OPvxWzdB0ibLZhEV9bss4swEcAori1amS2e
	 sm1YnIRmE4wPxkuDgPXQ6AVd3F+00cJpi1h0nRs4pRcjAcW3opo90Aa1axKaVbQwx5S2/
	 QRz4rHns1bAbrSJHkoR9adTp10ZIBzib+mluOLDZerr27EMI9v1UYnUVIeXBEyWM6gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUqanZz0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057E606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUqanZz0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5891F1F0089F;
	Wed, 11 Nov 2026 02:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362867;
	bh=re1nwLZfEOZeN5xVZlD8EQntEHOz9K9vOE9tO4am2Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EUqanZz0+zpkwliJMf7L9R9mY0aXObvsD6dEJV4aHSrbqS7ud3QPmbKyCn214JKKg
	 lHGXhWe8gjRZNe3F7gTclkOH+ZSohI7mwypNOZjxhjLg8KIWKnRMgx158nDfcnvpGh
	 4z3ivYqnCknRQQbrJWTfJHd7t11Dt89VDEzBv1iCsXsHIF9eAEhry+3B1gMceF/isY
	 4uKu1s+LkZNrO1agzbVjEMCwqovsYBUB2MhscTRzSZtA9B42PExkIpNTBpyeewCWu/
	 gayQaaionziwtEtqob657GBvq6z2DjT788J2hblnNCw23AZ5RkMxWc0StHCBeSrdgo
	 V61pzxOSJZHJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] ALSA: emux: simplify snd_sf_list.callback handling
Date: Tue, 10 Nov 2026 21:07:43 -0500
Message-ID: <20261111020723.548248-3-sashal@kernel.org>
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
index c60ff81390a44..8e080a4bcd16f 100644
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
index 469aa974f8fe0..0a981b636537b 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -1044,7 +1044,7 @@ load_guspatch(struct snd_sf_list *sflist, const char __user *data,
 	/*
 	 * load wave data
 	 */
-	if (smp->v.size > 0 && sflist->callback.sample_new) {
+	if (smp->v.size > 0) {
 		rc = sflist->callback.sample_new
 			(sflist->callback.private_data, smp, sflist->memhdr,
 			 data, count);
@@ -1406,9 +1406,8 @@ snd_sf_clear(struct snd_sf_list *sflist)
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
@@ -1509,9 +1508,8 @@ snd_soundfont_remove_unlocked(struct snd_sf_list *sflist)
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

