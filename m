Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050766;
	b=H9hOLQAkUbArJna/9fTJyDvjM8SUTZd5y/RiKL9i550SIMQjGzRwWgpCjgi1/5EaHXVr
	 P9HVPIqSy4vIC5FPX2VFcSB/VwlYMQ4qFeczIkq95tMQyAyNKz7D2vHcXwXC81rWUuzRk
	 Wyl4BwrXk4RN7/CYrX/XnViIZtubfaHhfZ+wNV9xXN38cd8SRGoDOz5VqsRztJf79txbZ
	 1ZBrW0qSF1Fvwwxdq6TutN2BXmd+M0nzVJGQAfghfwphHzBL5a28hrYDXVSfGa0xtIKAy
	 e1ZMP4cu//Tc76AfVG185QDKMSEnBLZSferZ/VrLCzUyxcmbYLzZQtsEAwOmb1BlV0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050766;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IWePE4JMCus67RWtKY5ACWlAqw9oVSa3hG7vF92tx7g=;
	b=YbqumVEml1bLkNsfrTzQ4qfsRrZvsG3L21KC5dNCVRzUAL9s7QgAyZjByooCfhhZtD0X
	 Kt9wgO2kJ2JiLYijyZqRSkFQE7sfyphxrXJjeTHAD/EkYaGpRfyOu4xTWNkeVvCwgBphS
	 CoXW3Ep0viTkuNZlgh5/jNPnLqBx0bInrvU68dcpS/I5F+p9e0JMQB1Z2VsriNnrWHLFE
	 aMjqYoD4OmvrsKObXfPLR+ZwZJY+02ILH0p0XT7Tl0G1ZcNRksO4BUVbSYYx4yGOmrhW8
	 As1XsMWNpgtKJyh4Dc+bNVeahN5Q1QUGbkGkh8rb4+b3vAh66Oq5jWsZXyn4cve8yZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ppz1yW8D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5691D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ppz1yW8D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C372D1F0089F;
	Sat,  7 Nov 2026 11:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050766;
	bh=IWePE4JMCus67RWtKY5ACWlAqw9oVSa3hG7vF92tx7g=;
	h=From:To:Cc:Subject:Date;
	b=Ppz1yW8DgtVJ/iGyrMpHmCK2H5pbnuIJgoA2UqESV6dvg36n16+WbtIX5Ix1Yy5Bs
	 JVRp3PUM+CBn2QHnB1VvqV5p0hfaB7kPwowO9R4EnHWe6zdmV5ScNUd3+h3WvJ4Z/s
	 k99nBSz8SWPFmoTfKjt7MQc1XVg6L46jF5q4k/GkwTqbe6UvMYHc4GZ4umN4ck3rAb
	 pWs55i7q0aOFJr6GfyCY3xZo+aDK0NHUzDD5byR5gZ26jSbTD6u3LMBK1E9d+mcAop
	 1PfR2WGYyucUhlUWX2WUkU8npysPfL2UcCkIGcx7LazsESCYJACzfwHnqnehcik4Lm
	 TV9hBQyec+Caw==
From: Sasha Levin <sashal@kernel.org>
To: tiwai@suse.de,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: emux: Fix UAF of soundfont zones at note-on" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:26:04 -0500
Message-ID: <20261107062604-failed-5.10-34e3e04b8a17@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 34e3e04b8a1731a773797542f0781e99ce7cd755
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062604-failed-5.10-34e3e04b8a17@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 34e3e04b8a1731a773797542f0781e99ce7cd755 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 20 Oct 2026 12:16:20 +0200
Subject: [PATCH] ALSA: emux: Fix UAF of soundfont zones at note-on

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
---
 sound/synth/emux/emux_synth.c | 3 +++
 sound/synth/emux/soundfont.c  | 9 ++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/synth/emux/emux_synth.c b/sound/synth/emux/emux_synth.c
index 6982e1317da5e..2cbf12364a1e5 100644
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
index c172b53b17a4f..039357d96e07a 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -1225,6 +1225,9 @@ delete_preset(struct snd_sf_list *sflist, struct snd_sf_zone *zp)
  * The found zones are stored on 'table' array.  max_layers defines
  * the maximum number of elements in this array.
  * This function returns the number of found zones.  0 if not found.
+ *
+ * The caller must hold sflist->lock, and keep holding it as long as
+ * the returned zones are accessed.
  */
 int
 snd_soundfont_search_zone(struct snd_sf_list *sflist, int *notep, int vel,
@@ -1234,11 +1237,11 @@ snd_soundfont_search_zone(struct snd_sf_list *sflist, int *notep, int vel,
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




