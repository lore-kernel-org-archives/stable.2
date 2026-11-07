Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047078;
	b=tfrcJ5mIbr7s0i0ZPmLfgDvkf9TDQVQm3c2KtS+Mnym8mN+G2QmbqwRVBg5CzAp6D3VK
	 sTCC8XPWc++G3HpVFL6QC3zfPwODNGU0yVr3HADe4yztdIZouOHQulY715JDsVVGrIHM7
	 aOXKKxaFM9Krwp5P9hQEtR98VkDPYkUD6VQiZpgvXgNFFPrqnKUa6rNiUfDpoZrTKkzM5
	 7GMONEOVNPtZU6OY0X5LbCqsezIjBLtbulEyiPWw23Mo47THnFo98wXL4qrwBk9Xdf4Ld
	 nAiP1mcBmFyP3CSbitnMnG/5m/GhRF737kY9AJ5B2h+JLI/+ggCQRZJRn8vTdAoIirA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047078;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LUWzOi5hGy7a2Hao+71Nk7kDFOpUoQOL4LhOv4iYFbY=;
	b=B/XBaMbidVBsyH2r/KoAhZIsDLJKGagVxhBu7miDVYc0F2Cw4kuWVphv2BNSj8dKh4VS
	 QNWx9xT7opglMD8trXRpAVZ/kz3iXetLdLYRjOj1j4OlMZQJ/p4IYxlQFjIgokXP3KDA5
	 knjZG/No1G/wU4SR7OQYqOdTwcBvFXuUPr5N0760rIAuvCF8Cj2FDkFflC05eFVD3l/Yr
	 068vdBv7ww22ShipeFCd3bBBgR/Yrjy8F9FwcKUJGS8Y6fMGkPA+NSsRbTXgY+8317/Fi
	 kBpDkq51roRrCFX+F5oSrPz4cAMf4vEeaTtDfnJG7fZ+aXiGEXc0FEGX0MEObAFOz8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgvI4x3y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgvI4x3y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2F71F0089F;
	Sat,  7 Nov 2026 10:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047078;
	bh=LUWzOi5hGy7a2Hao+71Nk7kDFOpUoQOL4LhOv4iYFbY=;
	h=From:To:Cc:Subject:Date;
	b=MgvI4x3yx0JlwooGK4/oFVw/bsXJJDpqUGQSMaIZ2g0EDraJyW+4BUBTyZlg0Bvfl
	 /kVrpQ1BsjsW47QxAf+zW0Slusfbs4nXiw7+V/FTyQ0McZt67W9Xs0ieYlljzp5uRb
	 jFsSfHf8G9759zxGq9FYu1xVg6PVouH00qbifDUMg+CXUWOz5w+L6AmqVFJi8EIgKL
	 WeN/HAt7ktY1uKGTKnrZYpQ8g3eiHSAAg403wkgtfyMxAidwak2R+Yci8SSFF1tTfm
	 wPO53gUdGOWpIJBXraKsoG0Ht0LPINptyXeWSMVCT1CzToTNCN59Tg8VxlJknR8SZ4
	 316+0EJD3T9aw==
From: Sasha Levin <sashal@kernel.org>
To: tiwai@suse.de,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: emux: Fix UAF of soundfont zones at note-on" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:24:36 -0500
Message-ID: <20261107052436-failed-6.12-34e3e04b8a17@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 34e3e04b8a1731a773797542f0781e99ce7cd755
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052436-failed-6.12-34e3e04b8a17@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




