Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352360;
	b=H2HbSOyW18Us0c2jaPNoo9Ffwrgc38n6ryuUNPVlpjOih/MQOoXz4KClWYxJ6/fBJTSR
	 oNacz2EUgsMdYz+8aU8SgQBMgH+b5jbbuiVpS8AvKU2FXvrxXPIFxEvLeclNl3ox9fe0H
	 Uor7tub2DIhky4MlsQvW7mDEBrf5AG9U882A8ZC7MJ4Vpptyht7Aiprr4bZVNd09VlcWD
	 RbR4ixJ47FOyqmhObWdPR9D/ZYTZRb+kiAPRJLbW12NTI0bRe3uQeqDr1hur5A7CshsTd
	 B/jU9VLo8zIDEGkACZSSGKICmXC/IVoYG6pbhlBO7F3vgmgMvAq6YxXy1pG+czpxQaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352360;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3ZQe4SsxNRyaxWVn414RghY+JpIn3P/gHGA5fOfmeGU=;
	b=N/NB6zAGvWJ3U+3TvT6ZgmqCgamKylMRfjbOk0KKrFe87dlx5Z902GMC5vxcNtm4iBOL
	 21EmTkqgHidieb+Xpwhj9IvSMu2+ug1M3dPmZOVuBmk3yryqFAyesx6DgxzaXuW4eRS0v
	 PP80Xc3FaPszks0fyq51caxG4mmXw+AKts//YI8RFheHcwk9XcIWeqWqxFft2JvBO43yD
	 LosSt85agDU75r2JspwU1AeG7rZA9iqkKlI3821eRlsndSk4lrq7Bs++3R9agL8su9SZy
	 52jB7NeTkscv5Iv/z8Vm5AJtdCEE8ztK9yDL5Di6Ga+EJbehF12aSWI/rI5MY0/XODA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bsoZlk/c";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA85606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsoZlk/c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBAC1F00A03;
	Tue, 10 Nov 2026 23:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352360;
	bh=3ZQe4SsxNRyaxWVn414RghY+JpIn3P/gHGA5fOfmeGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bsoZlk/cg4P0HnJeMgDkNNqMB5pfqtfZw0M2rIUmhyLso4jaDXZylI0mimxq/GhM3
	 R1/UTDAW1D41Xab1EPvL3lCGxfcKZh7dgxdlYSTmmFT6b3cn42FFowAO0u82BDuEHw
	 DjugXTpgWfWgL4UKVxhHTZtOvHri+UGSB4wAkBUxJmqNkDgUusnV6Sn7evdMotgE0L
	 YUeArRyRo82vI2hqEzY9/A0qHcMtiSGSNGseEMNblr+KxpnswNBGPEBplTI/fUiyeq
	 Y6TX1E7TVHsvIRLT5nSi4p7zC4i6a7vveK3SvjK8LiB4wa0BfiIjGguOnDI4gmTJ2I
	 iUb9J7yzHVHiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] ALSA: emux: Fix UAF of soundfont zones at note-on
Date: Tue, 10 Nov 2026 18:12:35 -0500
Message-ID: <20261110231146.73238-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110231146.73238-1-sashal@kernel.org>
References: <20261107053717-failed-6.6-34e3e04b8a17@kernel.org>
 <20261110231146.73238-1-sashal@kernel.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 34e3e04b8a1731a773797542f0781e99ce7cd755 ]

snd_emux_note_on() looks up the matching zones via
snd_soundfont_search_zone(), which takes sflist->lock only during the
lookup and returns the raw zone pointers after releasing it.  The
caller then stores them in vp->zone without any protection.
Meanwhile, a concurrent SNDRV_EMUX_IOCTL_REMOVE_LAST_SAMPLES ioctl may
unlink and free those zones in snd_soundfont_remove_unlocked(); this
leads to a use-after-free in snd_emux_note_on(), and later at
accessing the cached vp->zone, e.g. in snd_emux_send_effect().

Fix it by holding sflist->lock in snd_emux_note_on() over the whole
zone lookup and voice setup, and let snd_soundfont_search_zone()
require the caller to hold the lock, instead.
snd_soundfont_lock_preset() takes sflist->lock for setting
presets_locked, so the removal path now syncs with the note-on finish.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-697212bb-a434-4ff5-8778-25a84f5dad89
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020101624.205638-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/synth/emux/emux_synth.c | 3 +++
 sound/synth/emux/soundfont.c  | 9 ++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/synth/emux/emux_synth.c b/sound/synth/emux/emux_synth.c
index b3c8296840a56..537a7c47ef475 100644
--- a/sound/synth/emux/emux_synth.c
+++ b/sound/synth/emux/emux_synth.c
@@ -60,6 +60,9 @@ snd_emux_note_on(void *p, int note, int vel, struct snd_midi_channel *chan)
 		return;
 
 	key = note; /* remember the original note */
+
+	/* hold sflist->lock for protecting against concurrent free */
+	guard(spinlock_irqsave)(&emu->sflist->lock);
 	nvoices = get_zone(emu, port, &note, vel, chan, table);
 	if (! nvoices)
 		return;
diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
index c124d6c27a945..2e37d91153a05 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -1220,6 +1220,9 @@ delete_preset(struct snd_sf_list *sflist, struct snd_sf_zone *zp)
  * The found zones are stored on 'table' array.  max_layers defines
  * the maximum number of elements in this array.
  * This function returns the number of found zones.  0 if not found.
+ *
+ * The caller must hold sflist->lock, and keep holding it as long as
+ * the returned zones are accessed.
  */
 int
 snd_soundfont_search_zone(struct snd_sf_list *sflist, int *notep, int vel,
@@ -1229,11 +1232,11 @@ snd_soundfont_search_zone(struct snd_sf_list *sflist, int *notep, int vel,
 {
 	int nvoices;
 
-	/* this function is supposed to be called atomically,
-	 * so we check the lock.  if it's busy, just returns 0 to
+	lockdep_assert_held(&sflist->lock);
+
+	/* if the presets are being modified, just returns 0 to
 	 * tell the caller the busy state
 	 */
-	guard(spinlock_irqsave)(&sflist->lock);
 	if (sflist->presets_locked)
 		return 0;
 	nvoices = search_zones(sflist, notep, vel, preset, bank,
-- 
2.53.0

