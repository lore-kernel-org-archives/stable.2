Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974488;
	b=MIbuY5MoC0e/2DH5vB+1Eg9dEC2RFPE0S1CBpRa0YRyKQKM4ohgxpniTHHZL16sxL2b3
	 liBHi0AoSiQibstvlsGjFTSOl2cLfVdTCHqeEE61oFn85O3toT39EDtwRUeOy8/1Dh0Kn
	 nxQAJ5a1LxzRjabyYdZFX8JxNas898Gn0xDxvlpasM4KJPiKP2ADzTaVb8iSgak1N+6Tj
	 9dM0bm9Eey5G6TzI7RcT+zJ/Dz5C2rQ5NAIL0eUwu3sjdQzwAsGASc3tR+oDU5KWaXYAO
	 wkxXwaNbUOzhjvRq8S0FvolJ7VfzWQita2qJtYcQE5QCX5w+URkPcYtGntHmY2MNKTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974488;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hg/qv4cSR4GK1fnfLKAg4VlnHpxaN1r/opczeazkgJ8=;
	b=J/CwLlkZINVHAAUG91fsIuQdnFRnI7H59Fa2qvk0bmn1nP9Ljx/7GibDEG+z2cIx3Jyc
	 yQdBC3ju8ybvk9mdVyJ0UfnmVkHUvh6CkYG1D78oBrzHlLFvn0+MjkW6lwyTwmmbgr5dr
	 WvkKBslgOcPX6ZyAU6TCKcRSmvW684Q6XsO/fLTl/D2EKV1QoONXH8khbosY/FFYJko6v
	 bZhnkUv4/zaQotVGY9QICLj2gz1mlF0FfLypbIzJ440r2LPF0NzglRGgVePKtIJLGbovv
	 WeV5AkuZuC1pmrQ/5qsxwGWmPxtK1lSK2wVo/l4j+VtWWq+PtPfI/lgBVwGevgUb0Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NqU/cWBO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81A606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqU/cWBO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC7C1F0089F;
	Fri,  6 Nov 2026 14:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974488;
	bh=hg/qv4cSR4GK1fnfLKAg4VlnHpxaN1r/opczeazkgJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NqU/cWBOzdPvpXKPTPr9FdrQ3uwmZbDRBuybL2mvrRgDegoupAUKgUKPKOA8Zs2yD
	 m20VQLOEPj4jBbSRCDQFBB9U508x0WbTzcTPxck2Tes6sSdA7KghicuHNwHGtVK+hj
	 AFdOI3YeTwR3QtDKvaz93nDDlrFJF2mr/AqwB796iYYsV/xyX8ujGJTpMB+cvuFTNh
	 7HnLUBgWOQ+wOZB+rdq/QXHz+oKN4jGFXpAwdxJ6KeMk/OZbgdJA8djDruwHzNYinm
	 nf9MCJ9vq/vfEqWGx5GuTWgcwGn2WbEoJHReFd1W9bb4XS4M8z0VolHiWcFjGlRmNE
	 fboODcPXJVRow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: x86: hdmi: fix chmap array missing terminator entry
Date: Fri,  6 Nov 2026 09:14:46 -0500
Message-ID: <20261106141254.287349-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110401-reverence-patriarch-006f@gregkh>
References: <2026110401-reverence-patriarch-006f@gregkh>
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
[ sashal: Replaced unavailable kzalloc_objs() with kcalloc(2, sizeof(*chmap), GFP_KERNEL). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/x86/intel_hdmi_audio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 7b9292cf839f2..d23dfdd50440a 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -478,7 +478,8 @@ static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 	kfree(intelhaddata->chmap->chmap);
 	intelhaddata->chmap->chmap = NULL;
 
-	chmap = kzalloc(sizeof(*chmap), GFP_KERNEL);
+	/* info->chmap must be zero-terminated; allocate a spare terminator entry */
+	chmap = kcalloc(2, sizeof(*chmap), GFP_KERNEL);
 	if (!chmap)
 		return;
 
@@ -581,6 +582,12 @@ static int had_register_chmap_ctls(struct snd_intelhad *intelhaddata,
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

