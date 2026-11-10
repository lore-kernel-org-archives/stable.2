Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352786;
	b=pAnAqd6A64SPoygZxd3/hLHY2RNQhEZPcZ2VEljuY7YCOoUmyGGJ1AAAaplwYoFst9mz
	 6tqAEeonE8kskClzxWuL7zW29pS18Pj3HfGptekS0+xGH45GddTcUKj6A4F6MGmUMe//1
	 aSbKF9a+FNg0gP/3KLKNlfujkozSYGXY8vvqgc+3RKUFj1/O5qXFz+4mmDHmDxrHFR0/R
	 fsaif7vMdAxf4Oj65BMQFCfv/rYSub+ON8SFSoIFjWiZSNJItOisX2XozP3f1FWZeG6Ep
	 CBVAQ2wyMQyITasKBQd2xKdIxmQWS5iu6rX8EmwBq2cLFjqeGRmW/RhTBCc4J/FsPMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352786;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PEp00HEAwGSY+2KMVXNPd5swaX+gFEt0mPenglrvBs4=;
	b=a4bVOAMIIT3ECmVmuZigFQCfTbk4jOT1ugvGwgt+G5HYvMzziRbH7AVk9YdvL5kZPJZR
	 lCoswgeD/LXofSCkP+q/dELHCT+S8ro8mnImf6VCATdyGFPI47CLEA1ntPmzV+9TeHYfw
	 l1YjLMUFmOMrRqSHXXUDp0ZjpOgR9IajSX2vnW5c7DYpibAnq/dCGUOfQzl/7ZB5vd+zL
	 7E0r+EGL+R057aZiqNq8RKAAuYWCZ5q2MP0GNkvm9z1+YKyIZeurUVt0DpL3GkkSa6wUo
	 PNIKbo9brfdKzAnFiZTysduCUtpMz1fBd6nAC7Vahu23LWE6xV5iCjwbjXVLXLvYlZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqwbVtMu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85441606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqwbVtMu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CF31F0093E;
	Tue, 10 Nov 2026 23:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352786;
	bh=PEp00HEAwGSY+2KMVXNPd5swaX+gFEt0mPenglrvBs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TqwbVtMuA7xUUuXkYBRZ/la0lQs5IIswW9fO2gLAUhRb0CEDf6jpT4WeQgMKTmJ5p
	 1zVuwdSUb6uUUNzhaYz1qQuCrqiLQvl+3ZHQLSG2siaaD6fB8aFnS2c+4Q2yG3hAHO
	 f3YZVSKNBGSidwygwYZ1ARa8Jlvj0tbbpcD7LKK7TcnZ5TXFr/vht2T878EytAwCjm
	 KKuRVMNQXoyINm8RcNY+tpq3Pe+scuH0VT0KyQNwdYJgPOB974ChFoOHwjDPxTmmHj
	 wx4tx+bM0iXs3DPgbosHk+nDuTwclXKhQ7Hb480UvXQFNK9mPJZ95LJcNQHAIZ9mvn
	 YgKwUWNvCdz6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] ALSA: emux: Fix UAF of soundfont zones at note-on
Date: Tue, 10 Nov 2026 18:19:42 -0500
Message-ID: <20261110231659.106262-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110231659.106262-1-sashal@kernel.org>
References: <20261107055202-failed-6.1-34e3e04b8a17@kernel.org>
 <20261110231659.106262-1-sashal@kernel.org>
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
index a541be1c41890..2ce6dc4000fc2 100644
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

