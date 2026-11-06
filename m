Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971481;
	b=Rz4z98zRXAz9B00cwkM4xw3KmsIbc7Q7pbv/KR26r7DfntXrcAVmlgbermeiRhxCCfq0
	 MjY9hPDpGO9ia6RnJai7BRrladssclH5ZmU/xmq4QrYHKz/POJJhlCja/9wSwxH2XPj5B
	 j+hPmLrAKz4oyRmmi2hPR9sLAQ2qJLsTJ4B5w8BArQovvjmHrh2xm5CeEfYd8MiN3V59b
	 7VqPfMVWBV/EntjbidyA+jQqhH3Rr2y3+WvNY6hvxjVnejHGfY0f35n1JCal/zyEhtd7H
	 +W+3+WbtLFGk6xgm8MFi1st8mg6dfIGui1mgdekala4DexmGEmIZ6SdhHsNxFp22Z1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971481;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hKpKEIGZkNEV40wUkRon/TI5cez2CWRwc9V8Ae7ZysY=;
	b=eZLRmp6yEV6jF3kxviR1X1fkrPC6z0kc3J+/NYxapgP9wgaD98nT1PTNOMBXTyQtTXjE
	 CmFkwMbsTaSrfBqKM5agabr6UT0kX0j1lvE+P7TDidX1HYdK9EFc46ZwbMlaLLb6d93NM
	 rmW0ho+avK6WVTvTx6CZWkU+WF8JDisp8sYNm5+vkLVqTejm1iiDgloYPoOkzUNolpa18
	 d/txsZhaGsgTslFRH/YHuNG21sr0LoNCKnfC6KI/CveHxQyXGUU9GF1r5gl7dzgRoJMTN
	 /HXsrk7id50NCDQweVGh3M2jJYPsZfk7sid5NRhbJhBj2SqzJOlcgFscBI24CfxnuBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i54Y/ugU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79AC606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i54Y/ugU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F8D1F0089F;
	Fri,  6 Nov 2026 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971480;
	bh=hKpKEIGZkNEV40wUkRon/TI5cez2CWRwc9V8Ae7ZysY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i54Y/ugU9Kx9lnFJShrS84DiEJZsmbyorjsQ0rLYRkj9f2QOjdieMhhjfFCEiIJQA
	 yzz57f/eoKCTgR6qWxt2QeLiCoKJCBrXuWFd99Blu9rzCMZrOOeABwW5cKQM9lOD7V
	 ZXohrmxdVd64OOkNZeUfmxWy8MxXEL5c88hKVE5G60uU5HoGzAOF1tEw5HNYKpY3YQ
	 NgkDk6bEoKlSbIZwvli0I1kuHGLP7pnZ6KEHXI4lbz2++4hxlYZkdbaRPfEDMFCKvP
	 vv5SAImryw70bYaZu564NpTDxnmk/e7/ceTXc/beVLU9pkmU/n+4PYWirvROq5gS/x
	 M6HmbxWmk1dBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ALSA: x86: hdmi: fix chmap array missing terminator entry
Date: Fri,  6 Nov 2026 08:24:38 -0500
Message-ID: <20261106132300.64154-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110457-overhung-helper-62a6@gregkh>
References: <2026110457-overhung-helper-62a6@gregkh>
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
[ sashal: Adapted the allocation hunk to replace kzalloc(sizeof(*chmap), GFP_KERNEL) instead of kzalloc_obj(*chmap). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/x86/intel_hdmi_audio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 8e2a007311d36..21ee9c9154804 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -475,7 +475,8 @@ static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 	kfree(intelhaddata->chmap->chmap);
 	intelhaddata->chmap->chmap = NULL;
 
-	chmap = kzalloc(sizeof(*chmap), GFP_KERNEL);
+	/* info->chmap must be zero-terminated; allocate a spare terminator entry */
+	chmap = kzalloc_objs(*chmap, 2);
 	if (!chmap)
 		return;
 
@@ -575,6 +576,12 @@ static int had_register_chmap_ctls(struct snd_intelhad *intelhaddata,
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

