Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972423;
	b=JWaPlrYivgrFNQYzsydDoQ9V/CtJIgujUap9Vav0XpqUyYPKtw/fVjutDBF7w280V7q+
	 xVPxHBnKlKzd0sxPenX2OwNqrY7/eD+4GbuUu8N1+aNKZgeBZy9qhEDJ+TVbXMyrWhMZ4
	 sctnIJbUtAXdyyVIB3F1VOblEn5Xlj/QM/EY50xvNvRDaiv028eR1X4NL1vMjjFSU1jtr
	 I0ZcWmZ0Vtb5p4GjnP09FmI1evzM5OJDXL9/OkPJWCzqVfOmrWQpmmJik7KNxI19lM8o9
	 t5vS+WtN7yKdfPotau6aLYVBzCW+fNPDflhQ/dsZQkgftztiKWkVtoltBmAeXg79Gfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972423;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=792w9wS54QUKFKfvawm4AfGl4A5og/wwJWcek6OYWIk=;
	b=v8RhzNQH4TCaPMZ6a5kpID1Hds1arD2Zju0U6DnQfVo0ylquXQXHrjAZHWieZENotUPv
	 RUPGw31CyDz68KGGt3HV5BWSYavWBTEcb4aJzId8ABPomba80Rse/YaYY7hwZ3hzMBl+j
	 lalsWLpaIdHMm1sfQP3wyOqkvGXMVjzy236IDb/hXBCQhuUc7SjawqCErlZXEGv5Y0+mV
	 ZmavHLk9GM+9SMbDKJDJth+2H8bMPDkesHTO05S72FE/41CfGjdS0OHjq/AEQC7TFhetD
	 pr756NB1gljRv3UGeQqhuZiZwj+8ckfV7RpfesjI9CbCIjIQvU5lKoW5AIXPI6aXDLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rbh7K6hQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE3606A338
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rbh7K6hQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C731F0089F;
	Fri,  6 Nov 2026 13:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972422;
	bh=792w9wS54QUKFKfvawm4AfGl4A5og/wwJWcek6OYWIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rbh7K6hQ7JjSqFcWqUStwpS9AMyUl96Av21wB+L32MVTs4F4uBfwrx3pQLnbgNNw7
	 fvDo4XoFp5n1ySghLFTnBcMOaUvZ1zmqo61oISF7jGPqiUxYtqe3i+lbDl/LUGpwR9
	 4BnkGCQBpr2XbmrxAKr3urk9PabnBjAR8Q24F86H1IoM6JOFkqUKdQMqRxahYssB7T
	 RYBS/tFuvqfj1ijY7TJcZVdLXIuB818UEALhz5qtbPnzX3wfvFvWB8zFVlhRYvi397
	 TB/nRy2MXz8sz846Nk3je7WrsBKepjhuhSbiNGEH1Hxivt8FvAL9TlaDUi6Jw29CnS
	 0Fx2C9u3eHTFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: x86: hdmi: fix chmap array missing terminator entry
Date: Fri,  6 Nov 2026 08:40:21 -0500
Message-ID: <20261106133925.249030-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110459-dramatize-kettle-6042@gregkh>
References: <2026110459-dramatize-kettle-6042@gregkh>
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
[ sashal: adjusted context for the existing kzalloc(sizeof(*chmap), GFP_KERNEL) call instead of kzalloc_obj() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/x86/intel_hdmi_audio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 571a092b128a2..3c8f1793522ae 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -479,7 +479,8 @@ static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 	kfree(intelhaddata->chmap->chmap);
 	intelhaddata->chmap->chmap = NULL;
 
-	chmap = kzalloc(sizeof(*chmap), GFP_KERNEL);
+	/* info->chmap must be zero-terminated; allocate a spare terminator entry */
+	chmap = kzalloc_objs(*chmap, 2);
 	if (!chmap)
 		return;
 
@@ -582,6 +583,12 @@ static int had_register_chmap_ctls(struct snd_intelhad *intelhaddata,
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

