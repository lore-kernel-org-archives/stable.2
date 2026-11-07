Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048727;
	b=TQT+Cgwal9QLiXKS91BYPU/tGI5vihVIX8x0CLqco1MAltzeZDENrf5YXWpq4Fl6+EGD
	 t7kEl5f/of77wu6pjC1mBemZxnkkGs0loCUbdXS8oaFlS/sRHfdeLOeu9WPfE9AIxz2T2
	 U+12908khhe8NYXaUkwN+zjLOAIMdmd12MFJHuKB1uBxDvc0MDx3a6zzU8W2uoFYFCLg6
	 v4h/PHvHHcmb0j4XqnTTzJ5DnA2tLe0mn+u+GOC9b1GKiZZ+uk6ZR1PAJSATab9L+XIFr
	 hTT3F+4GG4tXhmoMYBwRLsSNZyf+kxmHrTCsIvLEquhr4pN0nUD+r43Qa/svvGyiGYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048727;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nRKiPVqEcMNKwuortOlhNyMRhDpFRv7sfEs0uCfp2jc=;
	b=44gbHGmIi7CzagUqcmvDo07LuNu0RrFIyte8dlUAWgeY290wB41AR//A8HuvMbuY8ATT
	 pFL3ecS6gmbjxzqvpi6EE2vyApACScrPXibwKl6rskAqd2jdWXC/4udLCRWAhJyAWV4fa
	 l767igeUAYqV1wZPqoBEwRGir8o/rQ+08lX0ACpsQbDIP1zaBoR44xFGbwg3c6wFxMoJB
	 F6DrifNgrBKrjvdtfd8ql72aO5t29uQcacSUcW02lfrPC3PdIak6JYrpQ9L+Q1LIlOyj3
	 HzJBVVTee1c1Oep5XavUVkoMM74hCKU1IWjluj/nGBOatRLOD3Lb0RPKX9U1c2nTFaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2mqYMrI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051A606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2mqYMrI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED181F0089F;
	Sat,  7 Nov 2026 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048726;
	bh=nRKiPVqEcMNKwuortOlhNyMRhDpFRv7sfEs0uCfp2jc=;
	h=From:To:Cc:Subject:Date;
	b=G2mqYMrICs6WA7DzKrUe2vggiNXFuH3g7/DO04WMZ+rGNtMCzn8qMyTbKnZUUVgke
	 2fFuCvJKRUWdHMw2SXxS00AuyYlS7Bo617MMbyKSrn60l7kf3P4wf7T01EnqDERFjr
	 HXnirTORTDRf54Wxg3nUKhp8JbX4eCj7K5e+aHZrgXvvjs5K+IbI6O6OuD6/QBVuSv
	 eEzsT4ZKREmg7D/VnAfR0JAEXnmsd8O4XZz1x9TQp/ECN9sjHAQmc/GV/DH754ZBuH
	 U4k0SvLsW7FuWrCR2vN6t1FN8uruCduRe5eR72qfBe1OC6IUcfmwvF3uO9b/Vs2QuN
	 UAw5X07HXzUWw==
From: Sasha Levin <sashal@kernel.org>
To: tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: emux: Stop voices before freeing zones in all cases" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:52:05 -0500
Message-ID: <20261107055205-failed-6.1-8a5d87c2ba30@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8a5d87c2ba30e8de31cfbe888fd4d95f43c63db9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055205-failed-6.1-8a5d87c2ba30@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8a5d87c2ba30e8de31cfbe888fd4d95f43c63db9 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 20 Oct 2026 12:16:21 +0200
Subject: [PATCH] ALSA: emux: Stop voices before freeing zones in all cases

The emux voice caches the soundfont zone pointer in vp->zone, which
is referred to later, e.g. in snd_emux_send_effect().  For avoiding
dangling pointers, the soundfont code calls the sample_reset callback
to stop all voices before freeing zones.  However, in a few cases
(e.g. emu10k1's missing sample_reset or the call path via
remove_info()), the sample reset isn't called properly, leaving the
playing voices.

Fix it by always registering the sample_reset callback, falling back
to snd_emux_terminate_all() when the driver has no own ops, and by
calling sample_reset in remove_info() before freeing the zones.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020101624.205638-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/synth/emux/emux.c      | 10 +++++++---
 sound/synth/emux/soundfont.c |  9 +++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index 450147b1abed5..2a42d041e1da0 100644
--- a/sound/synth/emux/emux.c
+++ b/sound/synth/emux/emux.c
@@ -71,7 +71,12 @@ static int sf_sample_free(void *private_data, struct snd_sf_sample *sp,
 static void sf_sample_reset(void *private_data)
 {
 	struct snd_emux *emu = private_data;
-	emu->ops.sample_reset(emu);
+
+	/* stop all voices that might refer to zones and samples to be freed */
+	if (emu->ops.sample_reset)
+		emu->ops.sample_reset(emu);
+	else
+		snd_emux_terminate_all(emu);
 }
 
 int snd_emux_register(struct snd_emux *emu, struct snd_card *card, int index, char *name)
@@ -95,8 +100,7 @@ int snd_emux_register(struct snd_emux *emu, struct snd_card *card, int index, ch
 	sf_cb.private_data = emu;
 	sf_cb.sample_new = sf_sample_new;
 	sf_cb.sample_free = sf_sample_free;
-	if (emu->ops.sample_reset)
-		sf_cb.sample_reset = sf_sample_reset;
+	sf_cb.sample_reset = sf_sample_reset;
 	emu->sflist = snd_sf_new(&sf_cb, emu->memhdr);
 	if (emu->sflist == NULL)
 		return -ENOMEM;
diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
index 039357d96e07a..42d1f33fb2b50 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -443,6 +443,15 @@ remove_info(struct snd_sf_list *sflist, struct snd_soundfont *sf,
 	struct snd_sf_zone *prev, *next, *p;
 	int removed = 0;
 
+	/* stop voices before freeing the zones they might refer to */
+	for (p = sf->zones; p; p = p->next) {
+		if (!p->mapped && p->bank == bank && p->instr == instr) {
+			if (sflist->callback.sample_reset)
+				sflist->callback.sample_reset(sflist->callback.private_data);
+			break;
+		}
+	}
+
 	prev = NULL;
 	for (p = sf->zones; p; p = next) {
 		next = p->next;
-- 
2.53.0




