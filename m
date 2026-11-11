Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362868;
	b=vEsY6dN6rhKp10ojnGWM4AyzxJB1qH0N/n/l1w1ACr2M/7QH/WBGxJyc2QhhWiCfHkDr
	 AKjHdC/nvMLjfyoX7yx104TimBvgi+9lufSnKfkDyVBUFcAXzBxKfJG7WWEfBmCfM0kMn
	 3sE7wViJIhblTA38z88ekHebQ5jCBfJHgw1DzJq700vHR6YcMw+uNBArwt754I/p1jMAb
	 kv+PJT+1GtZMQBuNhT1wpjlv8kVXszhrgLZf94ciHuJIjloY+Ezpe20hteSiaq2JuiRnp
	 /KlOhioyWjxd0gRkGLV1Ea5g9K80wMZ9rI6g9HBFxo+TE2sWTWrruJqr/dTZtQJSqLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362868;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=THjyRb+90bVUwuUOWa9WoHIUX8NyjA4REQ4b5nzSygQ=;
	b=4u1It++pgUcoXFw6RVJrE4LFqyBHlS5/QmPWBhnphOI1MezAIIQKZBoX/vpwylV/+LaH
	 2AGpeLEyRyhbLedJYJWMbUmhEs/R2aS6o+MOPSQSNeDnSSVUASI5e/W/mlItmCbMX7S/2
	 87c5UAZIFUUnT/CD7dV2l4mdfvAym0JUmbEBGm/m41zYW/9kTL9mRCXyeE9N+d5cr7UH2
	 /2q5qg2FLx5jqPDM5IVxGfB0r/voHEiAufWYXMSgkHzGw9fvBP8WQIXoAqesKrhKOONsT
	 8YbFaHupNnmaTevPyPb0p/OOv+byAkZgaa3P2k/8jkmNH1LL7bQ5lCtw6YusTeHAlBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYyiwZ6A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3640606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYyiwZ6A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D73E1F0093C;
	Wed, 11 Nov 2026 02:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362868;
	bh=THjyRb+90bVUwuUOWa9WoHIUX8NyjA4REQ4b5nzSygQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eYyiwZ6AlxyyMeFQGCJRvSiNzjMwiOTI1V1zEaKug07wMGbs4/yzkCDGqaSJOD0k0
	 Z2GhzHVKwJev7Umn3Ok85dLLgPDnYEsBlLZ4dxbVqCzjSGBongnRGeQV3KSwUQa/Jw
	 prlPDlOYIsFFoJSUPPVTt+sjkffops4Ldve85YdpelOKcXJgGp/VD5/V/lXO/S4Xk1
	 5EeUFkuM7POI/vzS4meIoOPler8BHWm40NFdZyOxi7b6ZN4Hl+5sc+UWHJDpdfXzBI
	 6bLQFIz4xQ6oRvJhRPYM8xo74XTnUd1HnfJfhBfbFUJMgG/90XnssyTnap4NFbRl++
	 WqFQDmULDMIPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] ALSA: emux: Stop voices before freeing zones in all cases
Date: Tue, 10 Nov 2026 21:07:44 -0500
Message-ID: <20261111020723.548248-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111020723.548248-1-sashal@kernel.org>
References: <20261107062607-failed-5.10-8a5d87c2ba30@kernel.org>
 <20261111020723.548248-1-sashal@kernel.org>
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

[ Upstream commit 8a5d87c2ba30e8de31cfbe888fd4d95f43c63db9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/synth/emux/emux.c      | 10 +++++++---
 sound/synth/emux/soundfont.c |  9 +++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index 8e080a4bcd16f..cfd472effe88d 100644
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
@@ -96,8 +101,7 @@ int snd_emux_register(struct snd_emux *emu, struct snd_card *card, int index, ch
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
index 0a981b636537b..163008b2ee14a 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -480,6 +480,15 @@ remove_info(struct snd_sf_list *sflist, struct snd_soundfont *sf,
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

