Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351741;
	b=ykzWoIbnssxf2toTTo+1fQBtFC3CP34Be/SYxbq1rNdsLkKSZJkLnKKZ/M4/EEbK3XmF
	 PP+RVrayCSbcarkZbKY4GPAfO4ghIHcLbOofsTd1oAovwp+SdKz/Ah6AHLuHSxSH1PCNf
	 wENmBdELXDQ1lPuks2n9nSmOWYOAjPSsuaUhbCwu1BEGVwzjGqQ7avjUGeBvNRjACxsk5
	 Rs8yQpPUoBQmHE5aXHvA3aAQVjJET1eH7xYHz6LoqVNAWEu6juYq3VPGSd80pIv9tGDUF
	 x7mltz+Ba31RaoLqKhYj4yEix/J6VsmYl7FhvfIa+yA9H4uvKNX+TkdNy13UfLKF8GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351741;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZmKhBYfbKiBNBKlAMsAEOEb5jmA3VB8XJTykPnR5WaA=;
	b=PFBhKDZcSs39At/fgqrX0daPmgk/tJbml0QM8LJ1uCBBJt+2oC5ZnU/vmNAFFr0wiT3k
	 EpJcgxZFw4uDBo6WGis88zr7dYt2zCWkW6RxyzvAUv4KXugWuPxzMc9L1COX0V9MA20Je
	 QrZxoeB70N8D6MAuzgq9ELVBdcSLQW111K14T9MyDOinPKlsrMw4DuhNZgP0GpeKWTaKE
	 a7YkXsMLHWUaAqS69ov0KHL19xuuEOMaoPzoevTQ5D6kWu743bgQNuvh2kSu/O4qkyU45
	 Apbw38avETtFztk4BJShj9YRST9BlXc7cbxPFJcsukrRj6tVmH5Qqv39SjNEJIxXKjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Htu4iFJX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8482606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Htu4iFJX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2941F0093D;
	Tue, 10 Nov 2026 23:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351740;
	bh=ZmKhBYfbKiBNBKlAMsAEOEb5jmA3VB8XJTykPnR5WaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Htu4iFJXv/kZ8PmwoD/Dh8do0g7C12bPj4FpH03dwIe81HF5kQtdvn5xKVALdsfGp
	 fO7p5aM6QryJ5wHueKbeB9241D5nmzwJ2GUBI5nz6c+yCyi1NBZ9eX6pZLNh/ra20d
	 w7wKQWzYTqSF9IISS9J84TzC1vxmvMBjNckAmvtLl7FexEX/bV7hjg1cXzsLTdjz7i
	 X9lzfpefElrmTjdVQl7hMcLQ9mj2QI5DjKzYT7KYfglMYmnhQiG/EpELAhNLXRbdEX
	 nfC3dWLl5NtTPnWU4NBZj30ryxLAvwt9h5mM9TjE0ZOCAO5zufSbHxdILeTso/OyuI
	 kv9YdWN5dcUEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ALSA: emux: Fix UAF of soundfont zones at note-on
Date: Tue, 10 Nov 2026 18:02:18 -0500
Message-ID: <20261110230016.15530-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110230016.15530-1-sashal@kernel.org>
References: <20261107052436-failed-6.12-34e3e04b8a17@kernel.org>
 <20261110230016.15530-1-sashal@kernel.org>
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
index 18a919d1cdb64..ad4a0f262afa5 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -1264,6 +1264,9 @@ delete_preset(struct snd_sf_list *sflist, struct snd_sf_zone *zp)
  * The found zones are stored on 'table' array.  max_layers defines
  * the maximum number of elements in this array.
  * This function returns the number of found zones.  0 if not found.
+ *
+ * The caller must hold sflist->lock, and keep holding it as long as
+ * the returned zones are accessed.
  */
 int
 snd_soundfont_search_zone(struct snd_sf_list *sflist, int *notep, int vel,
@@ -1273,11 +1276,11 @@ snd_soundfont_search_zone(struct snd_sf_list *sflist, int *notep, int vel,
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

