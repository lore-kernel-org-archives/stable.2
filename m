Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353513;
	b=wog8c7rB62buWOI5MA29ZBTLCpvr0Nqs6/FqMguyFev0zTeCfztm2eUdE2KwURPS3N8u
	 TiWv6anqYEs858254fDK/Ldme9p3RyccXoKo90SRVFVXUFlSjUpgNUFMoC+qWAELltqw1
	 L3q2NEhwSErjFOg3DICgHeClRxbnwJgRgDvMEoUVolJTbFZYdS1tm338GSOtiTeKPUufp
	 HvLwkLxkM2+tSUPEtdvLVRFN1n7Ya9CYUa/CcigmrtNbc6RCTp1fo7MzYBkB87zgIK8xe
	 Qe+n/3q5iJ9oPsuaUuYhWziode7pPjGzrM7F4OAemDz1eEQ1iprz5orven4ivIx1OHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353513;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1eJbvmIwPNaUQfAx///XZfvA4g45rOIfE3G2WKjM6ls=;
	b=BtVmlL8LspqTFqr5pLFnRrBMBTckiMjoD3k36Wc//+BW8fkMpnjG3Q67LxxubGc8XXOl
	 khKDQ4638Cs9lFrrcXz6FoSXLUXFiqjBXWwz0sp4Ym6F2MxhGDrmf3AE4A4rSAW0HmoYp
	 wS4IM6hCclSmusErBW1vD2pN/ordxO9AhRirg4MxLtmR7Hqbhy/aNc9QhaVB+u9asOm16
	 WIE9juVwYECZtARx5GGAHjGQR0vGVRqyHaoOKUF48oEFUlv5jHsgXRa2QcU85wr2Jbnat
	 WXME0TT4R2jRgfEo1chB83/reEmukl8D6xpe2fk7jgBHPpkoJ+fNNzt1bMzCrK/roeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5MW63Hk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346C606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5MW63Hk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F771F0093C;
	Tue, 10 Nov 2026 23:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353513;
	bh=1eJbvmIwPNaUQfAx///XZfvA4g45rOIfE3G2WKjM6ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g5MW63HkkpmOxUSFmID8e9M2/7600Q5lzg0Mc6IpK6hBMcEoiRxKfcee/DeXsL03R
	 3NyeyyZkCxnf9wPzJD5hfn5CZ/q6KlP2HQ7yQl8mt+ruQhz7Re75p8OUJBt0NXCo3p
	 ouhKdRp+Ve7/VHruVQHBUyTlxhVkA9nEuHUjoxopUyBL37CAjobzvJvBLIvxj9hCy/
	 QzndF/gMYjaJn8Stz7HIplABP+/R4a4v3/ECmyHZl+a41JLdZhXnCyUYFqmSFuJ8ls
	 0FOEmbrjESiLQYwj0sY1o4XUAQQNh6ZOXrsHrqrMsFCx98NnRB1hPBzgHjYyqUwoU1
	 bRtvHCuBII88g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: emux: Fix UAF of soundfont zones at note-on
Date: Tue, 10 Nov 2026 18:31:51 -0500
Message-ID: <20261110233132.129145-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060910-failed-5.15-34e3e04b8a17@kernel.org>
References: <20261107060910-failed-5.15-34e3e04b8a17@kernel.org>
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
[ sashal: replaced the scoped spinlock guard with explicit lock/unlock calls using a shared unlock path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/synth/emux/emux_synth.c |  9 +++++++--
 sound/synth/emux/soundfont.c  | 15 +++++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/sound/synth/emux/emux_synth.c b/sound/synth/emux/emux_synth.c
index a5385efcedb6c..195cb58fd428f 100644
--- a/sound/synth/emux/emux_synth.c
+++ b/sound/synth/emux/emux_synth.c
@@ -49,7 +49,7 @@ snd_emux_note_on(void *p, int note, int vel, struct snd_midi_channel *chan)
 	int i, key, nvoices;
 	struct snd_emux_voice *vp;
 	struct snd_sf_zone *table[SNDRV_EMUX_MAX_MULTI_VOICES];
-	unsigned long flags;
+	unsigned long flags, sf_flags;
 	struct snd_emux_port *port;
 
 	port = p;
@@ -61,9 +61,12 @@ snd_emux_note_on(void *p, int note, int vel, struct snd_midi_channel *chan)
 		return;
 
 	key = note; /* remember the original note */
+
+	/* hold sflist->lock for protecting against concurrent free */
+	spin_lock_irqsave(&emu->sflist->lock, sf_flags);
 	nvoices = get_zone(emu, port, &note, vel, chan, table);
 	if (! nvoices)
-		return;
+		goto unlock;
 
 	/* exclusive note off */
 	for (i = 0; i < nvoices; i++) {
@@ -136,6 +139,8 @@ snd_emux_note_on(void *p, int note, int vel, struct snd_midi_channel *chan)
 		}
 	}
 #endif
+unlock:
+	spin_unlock_irqrestore(&emu->sflist->lock, sf_flags);
 }
 
 /*
diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
index eed47e4830248..0a788fe8bb8e0 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -1231,6 +1231,9 @@ delete_preset(struct snd_sf_list *sflist, struct snd_sf_zone *zp)
  * The found zones are stored on 'table' array.  max_layers defines
  * the maximum number of elements in this array.
  * This function returns the number of found zones.  0 if not found.
+ *
+ * The caller must hold sflist->lock, and keep holding it as long as
+ * the returned zones are accessed.
  */
 int
 snd_soundfont_search_zone(struct snd_sf_list *sflist, int *notep, int vel,
@@ -1239,17 +1242,14 @@ snd_soundfont_search_zone(struct snd_sf_list *sflist, int *notep, int vel,
 			  struct snd_sf_zone **table, int max_layers)
 {
 	int nvoices;
-	unsigned long flags;
 
-	/* this function is supposed to be called atomically,
-	 * so we check the lock.  if it's busy, just returns 0 to
+	lockdep_assert_held(&sflist->lock);
+
+	/* if the presets are being modified, just returns 0 to
 	 * tell the caller the busy state
 	 */
-	spin_lock_irqsave(&sflist->lock, flags);
-	if (sflist->presets_locked) {
-		spin_unlock_irqrestore(&sflist->lock, flags);
+	if (sflist->presets_locked)
 		return 0;
-	}
 	nvoices = search_zones(sflist, notep, vel, preset, bank,
 			       table, max_layers, 0);
 	if (! nvoices) {
@@ -1258,7 +1258,6 @@ snd_soundfont_search_zone(struct snd_sf_list *sflist, int *notep, int vel,
 					       def_preset, def_bank,
 					       table, max_layers, 0);
 	}
-	spin_unlock_irqrestore(&sflist->lock, flags);
 	return nvoices;
 }
 
-- 
2.53.0

