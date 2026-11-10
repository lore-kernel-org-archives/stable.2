Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352784;
	b=bhsPNSOlrAxKNuGgO7AQ1P8AWHCy01439Lz3e026NQKq8/mcd5kYE8rE4oeOXKFRbfuy
	 xXs5WH1qzIU5SN7uFKhREsXzHisgJ9u1ZsxS2wy7BD3evLTuKcPUfhflj1/4z8zOcVzT5
	 g/UDCeSdzsv6FLKdqA8QkhiW8JFNBt5vhV00797ccQBlZBxePdUiIPaTy24FrW7CXRzMj
	 ay4i0YEv8rSxyveqo6ACRa+fb/3N1fS+zDCla2oxJtF38yZNKWtpqBrW9FhZqTlZcEXJ+
	 T2YueuCop4Sz/jETvc4sr1AlxMje38LuU1YH1C4kxNik/YF8smMy3MYnuG5M3eQsw1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352784;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=miifCy1UTLJbj+2tD6jzMVuMoWbJnDyLuY6FFlrrnhw=;
	b=sYnVllDNnvObGbAEjNEhgecUwvJFpEKnL76+dGJrUc4uA/7iCuNYamu0nHzV20WNw3zG
	 SE8E0XbTGUP7jGjt8oeTl1ZfRr6GVYbZQIQXiscAK1mJTe4fFF5KUWr7f2EXy3jMGjScQ
	 e8ExXF01PYE35hU3pOE0/CVd6abw3ekCjU60dLx9NLu0iqpqzGk8YWXH59M0BT1hW/UlQ
	 lbNrN80X8SkFHDwH7oELtGfty5azTTOwtzC9RY10q8Y8ZJpmrraEnRWkAKCpkfKvWT5km
	 XZTZ6Heo26FhjHt3fAdRcymq5RNXYM0sr2X58v2AaDx7WcdrbXaq7VGuAHUc60b669w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q65llCqo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64978606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q65llCqo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF48C1F00A03;
	Tue, 10 Nov 2026 23:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352784;
	bh=miifCy1UTLJbj+2tD6jzMVuMoWbJnDyLuY6FFlrrnhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q65llCqoZEpKqz65pzbR06+E5ENt+CmLBJ6huUuDiwE15Gsb08S7gawD8ZWAsgm08
	 0uk0x5gotJn0xJCn+yFNg3Leh56SdsYPkdAxZ3QLK3zgBfLx0vsbTncrArFpYgDvkF
	 25SK4IIctYgcYKXrHQ8sUzAB8iMqx6rA1/PwQBVrzFKjxcepxoNZGiw+JE/lvg63de
	 h6FMMT5TjOKfb6nv52ctBXmIm9wK6ilZTLFBKCWzRbQCClsGC/xG9P7PjuWsh95fAZ
	 bZND4WnfHnh7dQr0i08RhJVjCh/3lNxFncFCCT8zjDpk8RgbDuWhnuWXBUHIx3hcxf
	 TCxtUJIAWzmYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] ALSA: emux: fix validation of snd_emux.num_ports
Date: Tue, 10 Nov 2026 18:19:39 -0500
Message-ID: <20261110231659.106262-2-sashal@kernel.org>
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

