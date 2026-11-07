Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047837;
	b=KnECFZhH3W9DkKmRy88T+xsVaU3O58XNiOIt68tEZv3sf0zVGh7A0rKE3Ddhpi69sXMg
	 ZFrpZSynSsVYpnS9/KtwH2hc4Wx5jgB95h2rOpNtd0VHAJQ2leGriW6u9fooHCg96S8+E
	 HHz80sa+s0b5Wf/W+14UI2yu7l3f51sE0+HzlX3NxoOgh3CSg7OdlD0LydznKzA8WFouI
	 0ra6v51Tmsje+JjzvzJuWkQN3HbLjnBLenR5h/Q/XQWUozG5HnnEp2CpwLOvtkpIysJgc
	 6XdSLysrCT9Hv2SSyomktJDs1vCcD7X8dprO266MIY35WBuxPnAXkSYNLy2JbImC5tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047837;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tUz3DJB+hSxqGL6y9qwj1TWzi3Je6Q1aZoRA06dTIoI=;
	b=1WJL0I/f9W7nCblJ7EGCFg75Z7faJgOpeux1N2MiNbCacNCjK32+bAG0BRcTz1hSonCr
	 VN0ygHtDJN2aJp5OfLAAP3CrVx9pL21b5vNtd+XT8v19PotonvTqMWKRubVXkZk6aMzSX
	 P9Onzgg08vHQ47LaXfxu2R5YD21phLmxsM3XN3BA4vzRK31H7tjyWpwZm5yiNpZHMJ205
	 Kkg16UteZUCSINnx0t3fTsIYTWJGjc8L2dkAw19u2awwWQfEAhuBuscTgKsWSyVy1RvGe
	 z+9XpzJqVBgcVyudvMRDz/cwQV/JEmxcMAgVqJHPV3RfkJllS6YV7axOD4Bh4HWqUAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oi4/2Mlk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A1606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oi4/2Mlk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D761F0089F;
	Sat,  7 Nov 2026 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047837;
	bh=tUz3DJB+hSxqGL6y9qwj1TWzi3Je6Q1aZoRA06dTIoI=;
	h=From:To:Cc:Subject:Date;
	b=oi4/2MlkTCwqwTA5/VhlwQjD4ojEHXsLgEoP+0by7SeTmazjD8Q4kyPnOXvzIjwo4
	 zOKupmL82Jj79jVeEu52snYpYmi4KsyhqRyTy1ASXcCf7tpMsWC4RkB5guc5tKS7aX
	 gWjgQOfiRzv4kKIxS61ImvDvC8FeggI2ySCvAcFrhG6/qStkThJoz//jyCus1LJWRc
	 V4AqrUw9o/rsbS0zIN3ns4kansOJ6JGC0+qqjV8Rm1oc0hxcBpF6stD8shzPOLbkaw
	 2UwiiFHv/1pwCU7XfTy7dwfGdi0Oac9PFUGuEPA/AW4xCAXwoKxubG+uIHiCUV5C7s
	 WX78GPJoI5Xhg==
From: Sasha Levin <sashal@kernel.org>
To: tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: emux: Stop voices before freeing zones in all cases" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:37:15 -0500
Message-ID: <20261107053715-failed-6.6-8a5d87c2ba30@kernel.org>
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
git cherry-pick -x 8a5d87c2ba30e8de31cfbe888fd4d95f43c63db9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053715-failed-6.6-8a5d87c2ba30@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




