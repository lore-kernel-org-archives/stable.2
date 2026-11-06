Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987633;
	b=imS1gjIGqL8tB7XLteERScUQ6grSLfel28KxKr0nAdUbQQJGo/V8odLFmrb07ceegXWS
	 AFhOJWLMJ1U9oNPRUMpmBrMm09eyKwvblWnX7YBG+GKCUZxHpw8SCQafV5M32q/E5GcDE
	 ajyhcQs7X7CAAjfODBMYMZ2YuKDqUqr3GYruxgb9Zzb5bR9Z1RP6U5CBnqsTz8wySjx/N
	 MEKKMpA9VUmeJHTip6GPMizPg7B7m+ivHn4b7HWWuoMNGPoD3oLSo9kkbPHMpIlzDmOhN
	 V/ZRBeYGolSs4m5BswwCiABqreRxIdL6fEWK/5dMlYYcmCod2FsK/Fiw7scyIL+H4lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987633;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nIRRaxr6c78JfmX57gzDduG8ByWqww/HI4yYn5Vy6ME=;
	b=uAEv8stWjLuKAijNchvJquvGqbUGR2tTlcjfr70GELfv84ICYqT3FQUyShiVZ8Z8xTCP
	 69vRle+3Lnyk02GtEbvK24RQzLIt0Ndc+d4c540YtVtUao4yC2iUaWwdUtii0prv3falM
	 KXOIJRRlX11HV5jnw722p6BA+nflXu+qOB2oZ/nNHFdsyDmFf67J1Q8EhAvd6EausfmRH
	 W8andOYUv1v4GKUZeW5yXa0VrgupHnvoRghwOwZdFbuorptlsNlt2H7mdSO3S55kNyJvs
	 cdul/qPw8yH89dx9XnGYs51zCrhDrWOwrFbrD7OZGNzshl7Tlfej0luKw7ma9lnB+Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqxkMtWr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB405606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqxkMtWr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6F41F0089F;
	Fri,  6 Nov 2026 17:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987632;
	bh=nIRRaxr6c78JfmX57gzDduG8ByWqww/HI4yYn5Vy6ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PqxkMtWr+qzMQlOG+198zM5kvwm71fXneQOiG0w2WL5r9LHmxcOWumsTk7s8HdTb/
	 YemVCHp5q12zJo3RjX+AAfNcEq53rDYvRwdleqVvFCGQjTXTa7fRQQ+ttrogvxI5ZB
	 rcM0/v7HW2lDVHLi3acTdCQ74/HP/ho7dR3g85PeHUoVmFB3oK9rSLCdTqGlGnJEPs
	 dQOY5V1/XB+q8CpGOUxFdObJ/hFVj7jXYYk+FJ+vTeZAJSEga4W72UpIgSUikSFYbr
	 L9zt3C90UJ6nWbuWewK6fUVB9sqIY5hIZvq2V9zs7cfjL1zvLUOosf9j4acLqIgyhK
	 iD6vW4TGufHgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: x86: hdmi: fix chmap array missing terminator entry
Date: Fri,  6 Nov 2026 12:53:50 -0500
Message-ID: <20261106175313.451723-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110407-contour-racing-fa1a@gregkh>
References: <2026110407-contour-racing-fa1a@gregkh>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit f5e1a9a3fddab8421416b68bb132ae9626d07156 ]

had_build_channel_allocation_map() allocates a single struct
snd_pcm_chmap_elem via kzalloc() and stores it as
intelhaddata->chmap->chmap. struct snd_pcm_chmap.chmap is expected to
be a zero-terminated array (see snd_pcm_std_chmaps[]), but
had_register_chmap_ctls() never overrides the TLV callback installed
by snd_pcm_add_chmap_ctls(), so the generic pcm_chmap_ctl_tlv() from
ALSA core is left in place.

pcm_chmap_ctl_tlv() is reachable by any local user via
SNDRV_CTL_IOCTL_TLV_READ on the "Playback Channel Map" control and
walks the array with "for (map = info->chmap; map->channels; map++)".
Since the driver's single element is never terminated, this walks
past the allocation. The same pointer is also freed on hot-unplug and
rebuilt on hot-plug under intelhaddata->mutex, while the TLV callback
runs under card->controls_rwsem without that mutex, so the walk can
also race a concurrent free of the array.

Fix this by allocating a second, zeroed element so the array is
properly terminated, and by dropping the inherited TLV callback
entirely at registration time, since the driver never implements one
of its own.

Fixes: 5dab11d89777 ("ALSA: x86: hdmi: Add audio support for BYT and CHT")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20261008085411.13742-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ sashal: Replaced kzalloc_objs() with kcalloc() using an explicit element size and GFP_KERNEL. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/x86/intel_hdmi_audio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index dbaa43ffbbd2d..81ce6d8f5058c 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -476,7 +476,8 @@ static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 	kfree(intelhaddata->chmap->chmap);
 	intelhaddata->chmap->chmap = NULL;
 
-	chmap = kzalloc(sizeof(*chmap), GFP_KERNEL);
+	/* info->chmap must be zero-terminated; allocate a spare terminator entry */
+	chmap = kcalloc(2, sizeof(*chmap), GFP_KERNEL);
 	if (!chmap)
 		return;
 
@@ -579,6 +580,12 @@ static int had_register_chmap_ctls(struct snd_intelhad *intelhaddata,
 	intelhaddata->chmap->kctl->info = had_chmap_ctl_info;
 	intelhaddata->chmap->kctl->get = had_chmap_ctl_get;
 	intelhaddata->chmap->chmap = NULL;
+
+	/* drop the inherited TLV read: it walks chmap without our mutex */
+	intelhaddata->chmap->kctl->tlv.c = NULL;
+	intelhaddata->chmap->kctl->vd[0].access &=
+		~(SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK);
+
 	return 0;
 }
 
-- 
2.53.0

