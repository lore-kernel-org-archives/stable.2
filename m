Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047839;
	b=iNc58i0tMrY+hMjiKGCvftc8SsBMQ9J4zW/5uE1Vc0UbEI0Nhgg7/H9gL7pkbRexKG/4
	 6IEf1eWOqS0lsEEd1Gf2EHPi/5qYKhguEikahZjGKd2tH0pULXPv0FpgQnrp32ZhxL1M1
	 FoJ6BSS/Nrl4th0NOyAAc4UhByhIMcCwCXOu/M/WaOd1VR9KYNfMpY4OBKnLNujwVVA5X
	 cK7XyXdtg+SAfr5/sNsTWzao+te8lajhPBcO9PJxi5rH3xWiy6VJ6Swtr/qlL1+SHAvWM
	 O/OLuDFMuOJX80bHPJIektplpyiD6ByOBcEtw4E0znBVuEKKVLNVehjAqxBfSTr0qAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047839;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5ZL/a9/oMEC6zxOdqYi6O+megj0G3z8O2shAO37ToUc=;
	b=vlGvwRASHYRLE4ADNt16jmvA4abbZeVBcFCXL7KlmII0/roNgnS/MbSnCA6xGsa8ErCY
	 ZNlYJvcplikdZ/Fe5YuICy1CWfnJf+ljA6j3upn1RsmhsmU+PBdujLlJpGU8Q9urV+n/5
	 iZydN+6zWnhx6uENFTLLHlp3aEcxyNRSExaIeozmKP9BxVBEVVW+WDK0jfqBRklh6gRfk
	 uimIukxCudAXyLy0B0E6SvPGXSFv+8/qgILQdYjtogEkDtDhc7YgcVBmdpdCIV9E4CwSP
	 VpBPXS70JcE2mc/RPDM6mGx4yeNtBjR3bCmFzDP4SgkfpUNkAdCw3WjRiljqa2s8NwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lfxMStAh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709ED606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lfxMStAh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BDF1F0089F;
	Sat,  7 Nov 2026 10:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047839;
	bh=5ZL/a9/oMEC6zxOdqYi6O+megj0G3z8O2shAO37ToUc=;
	h=From:To:Cc:Subject:Date;
	b=lfxMStAh3QSi5UZsWoQQ6A+MvDVpFH1FTj14JxVOh6qV6EalHetcxCZ/UQwTQCPCD
	 KhIgcXT46hu+xW1g4uJDlPOH2Nb3e968gCbJNMwAuHl227SFVWKC7wvGGZqHYyfS3s
	 GEuH7crk8jm8BGX8TjWDETm3TMck2Qq9YewDt+RRhceRPm8JmImTWEncMxQrPO57oK
	 rwlvUhIEC4yL7sQeBgOWn2AnwOh9fQ+8B/F9JVStj0CHCPnSF+yiwJ32fP1a/uCOSp
	 iftdpYnyAmzyTZ9k+2nhor3wSqVbCH91T1GRPVY0krmWJKI/KVoD2QPTNzSzfynU47
	 l2kzqZnGNubfA==
From: Sasha Levin <sashal@kernel.org>
To: tiwai@suse.de,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: emux: Fix UAF of soundfont zones at note-on" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:37:17 -0500
Message-ID: <20261107053717-failed-6.6-34e3e04b8a17@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 34e3e04b8a1731a773797542f0781e99ce7cd755
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053717-failed-6.6-34e3e04b8a17@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




