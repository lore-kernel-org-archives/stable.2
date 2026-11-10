Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353775;
	b=1RMxw8Ove/EjY0XzwyrlJbQ+l97ihDOrpD0goMEmn/SSsccc0/87isLuQRGg9+8Y2oGg
	 AfE36BuS4czUAp2ZZHCgn6uPBdFYC6esBGKOujDWrKdT3kL2W2tkZoG8mjGROPhX8QiMC
	 lAoFj8obYJgtYWi+PTQuXoi9JJs6gr2ZjaWfDrCIK2MP9YYhDaaCH/7l5VPOc5IIAeNR2
	 AlxUnwJ7LVso8g2tknQS6r9KGZZe5C64zcCS8qIvcAziQrwh6LDK1n6Ig+TY7rNbp4eav
	 eO/onWjQ0rOlgg8ybMhSVe9sP/jJyJuPtbGK/HuUeOpKJMUFVAX3R+sx39lQ94nPBwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353775;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CxEDJoFJgYoOOJIIps3CujW8ADcaeXl/v5ynt9V2LvI=;
	b=RmEj6MMy7XIc4Y/XiPhITN/Mjso+wkMzs66VzF0vg0jwuYEB576u3Z/HTVRN2cHZVCOc
	 fAaNSsPlJ+KSKvy9PoCN4Au+CCQ/CYFvk1953pmA5Dxgqq7EXbtWULGcoBe+D9k4RhUDK
	 I1C5QnISa9Sh7a8zd2vh0WY6gHElgCZjMmrOizQy/xjcrQ+gRbT4ZXtAvbKwr5IUow4LO
	 oH7i9fpv3mmnV6iJuO69/ju2DYNfDypZ9b3nz48ltt/PVvBGG/yOQW9pMfmxYnvNRoLj+
	 hZKTDm5JeahZVF14ocep5h1pJpsaocoOv02Sz2EjAhkf4PN/GQtFX54dNgYLqHLqAag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4Q3HBRt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B6606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4Q3HBRt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19821F0093C;
	Tue, 10 Nov 2026 23:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353775;
	bh=CxEDJoFJgYoOOJIIps3CujW8ADcaeXl/v5ynt9V2LvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g4Q3HBRtghTciCrkucW9XAJeBfMsF4GQ87ga+iBZYEhyFTH9gF68NqaNzsnfRzFOO
	 53hkDCuak5KJllazIvb9iY/lkBN43Y68HKALjyLscdyH9qaO+Ho3jiMIyqOVblyWC+
	 snvJgpLeS1JL0vOc1ES8e5SVCFRtvoUsZPihBxI4OL1kYODjgJHI/GFRBBd7px3QFu
	 Odz+7XqOc3tzZklTTTe5guDgGVXF0LkbemBoUHZJytVbEJHJA4/yumIuWrxTsK/Q+t
	 DzslwVFq9YzfsqjKeqi7LkzZoDJaRaysYODhHlv6PclT2n2d+gdsglK2YWyfEO7Hec
	 ZxRjE8Dt8WPUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: emux: Fix UAF of soundfont zones at note-on
Date: Tue, 10 Nov 2026 18:36:13 -0500
Message-ID: <20261110233530.168224-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062604-failed-5.10-34e3e04b8a17@kernel.org>
References: <20261107062604-failed-5.10-34e3e04b8a17@kernel.org>
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
[ sashal: replaced guard(spinlock_irqsave) with explicit spin_lock_irqsave()/spin_unlock_irqrestore() and an unlock label ]
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
index 18b2d84926563..ca3e100a637e4 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -1221,6 +1221,9 @@ delete_preset(struct snd_sf_list *sflist, struct snd_sf_zone *zp)
  * The found zones are stored on 'table' array.  max_layers defines
  * the maximum number of elements in this array.
  * This function returns the number of found zones.  0 if not found.
+ *
+ * The caller must hold sflist->lock, and keep holding it as long as
+ * the returned zones are accessed.
  */
 int
 snd_soundfont_search_zone(struct snd_sf_list *sflist, int *notep, int vel,
@@ -1229,17 +1232,14 @@ snd_soundfont_search_zone(struct snd_sf_list *sflist, int *notep, int vel,
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
@@ -1248,7 +1248,6 @@ snd_soundfont_search_zone(struct snd_sf_list *sflist, int *notep, int vel,
 					       def_preset, def_bank,
 					       table, max_layers, 0);
 	}
-	spin_unlock_irqrestore(&sflist->lock, flags);
 	return nvoices;
 }
 
-- 
2.53.0

