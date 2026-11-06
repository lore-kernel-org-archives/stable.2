Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976357;
	b=P0AgE6BHJkKdIBIhbgtMh77T66Tz76ZoKD4rnd/e5vWWxAcWtSvcnQHfYS2xKcfOVROx
	 9jeVIOKeBkebo9Vxtd8Y9fvn5JLzTKRBH3mOEm4QSxKj/pbeqspiNIkEHzDqlGXWQJnBM
	 UAQQDOyOZrfANUoQs3G68Lz2xXbg+iqnKOwuAJTps1wkbNTKCtu6vLuEqecAsIYdprJPY
	 fd4IkVfbXWIjTpHf4wEx52iAZjgqxU4+n/fZNkbs/lbPTKg8JDt0EEGwhN8jcKvz60MqC
	 qOGuJUoIMa1w8Hh4S2dF50lRCDdF9c8/cakzF1YUTq8DHHFAzVJOH1PP0EzbvZVEn5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976357;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9TS2JBQB/04hlFmEYypV1L6oXgwgf4IiLVUY9vF3/LU=;
	b=b1JSTkiOd1wT3NOFtwNHvNFDlB+Kc5Zr33IwQAmLBeSnUzdNI6CcF/C7LZNi7mO6sUQh
	 V9yv9sHVumUkQLd2A5gWkiHzx/Wj5fOJ4jmevh/3ybvnhPvsLe+0U7ctgRqnK2i6wJEhN
	 c88bKIC4Lsb6kms4vjGpTVjnkJmCaPCYrv73A5bdHyObn0drl63OHA9JmINYnTwm/P1GQ
	 P+ZxmrlcDDiOLXlpG5wiYWWbCxfxc3U+iRTRPgdQNkM5hWlmpPU+eD9zoUFB5/QW24oDl
	 27XKAQS1kQ8+W1D2saWHNW3268oUukvdIpNUtf3UTjuc+VyPJABG1mbhoEgNDcOuftQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLjlmLpG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D6606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLjlmLpG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D341F0089F;
	Fri,  6 Nov 2026 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976357;
	bh=9TS2JBQB/04hlFmEYypV1L6oXgwgf4IiLVUY9vF3/LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MLjlmLpGBReQThpaTNUtlbmfTYTPNvqyQGEtEvL6B2KY3Dr1v59EiqG+VbtsAi8hh
	 u5gTMkeNHh9TLGTHoGpKfgn9Nhx+dh4+LCIkYnhAPXBJqn+T76FHfLcfjS1B9RqsTO
	 wKAb6p+p5SXMEi1nwbt+KJqc5oiNw2sertTgvN/ka7+0lOChQbqSRivM+1QaJ+kaXw
	 dOsYEGBVvthR14w7dhOmpsSAEcJ9eZjSBpD70KlkSuawPl3ck6rrmwmPvgCecGnW8m
	 ENKvr6+3mIXl2qy7iSMymHaN2TRv1jUKgrir4u9MIBabY2X+F1f0M7HDTRirGARoOu
	 loGAXueuyF2BA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: x86: hdmi: fix chmap array missing terminator entry
Date: Fri,  6 Nov 2026 09:45:55 -0500
Message-ID: <20261106144334.360069-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110403-postbox-magenta-0986@gregkh>
References: <2026110403-postbox-magenta-0986@gregkh>
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
[ sashal: replaced kzalloc_objs(*chmap, 2) with kcalloc(2, sizeof(*chmap), GFP_KERNEL) ]
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

