Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352358;
	b=vv1hhlfgJJb2l0Vc2IXI6WeMg3ep+mVSBgfJNpE9/9U+9EEml9Ir9+YOuakcr+hMk5vI
	 Bz6g9DVvmUgzIRgNgoGTrf1E1Po6rRYQcnPAPdstCLD79IZyH9cNkeXXU9Bj2D0omCtoJ
	 QBG0XfX8fc8FWWk5AQJrLNB0qotqCluJZ+rpU9ZF+YlwTeHoGGYpueuxI+myqLH0EUA5U
	 5STzzav3IGgKfWWfUbpvmY6eIR4IDJ9FPU8MyYpkob6wI4aorPb7DqSYJ7xBQNuPDU8Sj
	 ASFwAv55U9WaBNYTkZxqgxjez95Zjqdz8yi3UNf6VEht6DKgbh/Wsdon7DEhPb7aEYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=miifCy1UTLJbj+2tD6jzMVuMoWbJnDyLuY6FFlrrnhw=;
	b=OGcm2lJK6+fxsgHG9dBUvzJvpLL1V5A4NUQI/rOCnVUy9D9uyJdWoKr1SAR80OzK/88J
	 2UCZvH+zMvUkUVTMt0nZ9iT9m1mJbayGhCM307wbnWiUt8Duwx3ViWEwmDttsnl4oDgKJ
	 4Gsw9HzwjkN40H6CBzy7aioCtdl3528ORlKcXybzKtJTtKKQgfwEPd8JhCmcIQ5M7gGR/
	 mE32ibftqeYLrOmD5GIsU/h69nak0AMqvQqmQo+pb7c1w26hkS3uCoBlNTTPdufCBieEB
	 z2Fo8bGWPyoHe0UXKItRgToaCmmk5A47MhNQmQBlBHfS6ffOTjI3kQCxHDBmEsETB0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWnzpXuP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12536606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWnzpXuP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E871F0093E;
	Tue, 10 Nov 2026 23:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352357;
	bh=miifCy1UTLJbj+2tD6jzMVuMoWbJnDyLuY6FFlrrnhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PWnzpXuPjQeNQy9StsmhB1eoPWo0W7cxIRg9yCUrjdvHqUotqM5Cfhc6V6hXJwgu3
	 OfDxbMPG8+4T/o6Nl6r/ca5/g6NTf3M2wpgLENBBQWK2DUV0yw5ybDxvtTAKV9NwMt
	 Y78YpqfU9EgFeMSgA3ItxhTLwJ2NhGPCFAX6+c4bpDI4Rm1S4aMpEM1zArVs5Asuxx
	 ymvJ6S6hsLJ/+SbKOG30GyvqPnjHUW0dIupCCqtrAnAPE/tMcrMRjoIDJlfQ0Zi11T
	 sk7IFg/TDyFtSIDWvfjNtacB4ANo6yS1EeIgBRYz74kJVxjRwB6wu7rTd16wnA/1Dp
	 uuEuUxkFw3shA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] ALSA: emux: fix validation of snd_emux.num_ports
Date: Tue, 10 Nov 2026 18:12:32 -0500
Message-ID: <20261110231146.73238-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110231146.73238-1-sashal@kernel.org>
References: <20261107053717-failed-6.6-34e3e04b8a17@kernel.org>
 <20261110231146.73238-1-sashal@kernel.org>
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

From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

[ Upstream commit 19061f35b3eaf4925960be44d870244b99df8d1d ]

Both bounds had off-by-one errors.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Message-ID: <20240406064830.1029573-4-oswald.buddenhagen@gmx.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 34e3e04b8a17 ("ALSA: emux: Fix UAF of soundfont zones at note-on")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/synth/emux/emux_seq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/synth/emux/emux_seq.c b/sound/synth/emux/emux_seq.c
index b227c7e0bc2ac..1adaa75df2f6a 100644
--- a/sound/synth/emux/emux_seq.c
+++ b/sound/synth/emux/emux_seq.c
@@ -65,11 +65,11 @@ snd_emux_init_seq(struct snd_emux *emu, struct snd_card *card, int index)
 		return -ENODEV;
 	}
 
-	if (emu->num_ports < 0) {
+	if (emu->num_ports <= 0) {
 		snd_printk(KERN_WARNING "seqports must be greater than zero\n");
 		emu->num_ports = 1;
-	} else if (emu->num_ports >= SNDRV_EMUX_MAX_PORTS) {
-		snd_printk(KERN_WARNING "too many ports."
+	} else if (emu->num_ports > SNDRV_EMUX_MAX_PORTS) {
+		snd_printk(KERN_WARNING "too many ports. "
 			   "limited max. ports %d\n", SNDRV_EMUX_MAX_PORTS);
 		emu->num_ports = SNDRV_EMUX_MAX_PORTS;
 	}
-- 
2.53.0

