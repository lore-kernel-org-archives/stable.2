Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978406;
	b=S+8vG5Jca0JkiHjYgjkRqW+JuWbpf+wK+TV5A+aXJK3srlIeZ8SF2eLMCLhn3OcB1z9Z
	 oNXnfgVp51XEmNhTVEn1lldDbFZIXLZArGITCZZfbLGnlonWwCDBmbvyIe+0c9PShC8L6
	 Fwf1KRi//2LXc4w8fM6FZmhHfFTpsvypm87aTwGU0CTnFPPIHmh21JaZVINGw5fHWnjhD
	 71P9+AuX699z7vpA4j8pxh/xpCadIi9GN15+kspLaehlqeMFuCE7iim0lB6FkO2G5e/XK
	 wBolNi2rZfGlFacOl6+A0bg7z8dmh3dUn3XSGBYOZPTG384cFqTlVCHKmGHPtWrv8rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978406;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1zPgQ5RnPHec006OGsQVhFYA7XTWxFr9hmIrm+JvQvk=;
	b=ygkXYcNe4HOyEnEyvg5G43Tn4nJsiueHXBt/1YQgfndwCzDTs7hreAPPrb3IXFexZ/iN
	 qATJhtp2FQ+tr/bmSLaGXWlHTA44FgNpW4sHtLdfLgK5yilhnnUW+4W51wmlNGZXBK6uT
	 ifLZNFJK03nZHNcO2M+tBLve+yeGQ5SB3UOy3v7nDdDiW/kuRKBKl60R90d8W5OPTLnBX
	 3jA1IrMK7FNGtrolGvATHExS1x73cwAbMd1LG+eroSPG/S4Fbsj3+05oqR85pSHRqTZ1D
	 gJOcA3tG9dkfcm1fXgh9Lki+vpz6WhGT2JRF3InlKbjTffppKo2Ou1/JHv1a4yIbStA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FACWn8ap;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8193606EE81
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FACWn8ap
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F181F00901;
	Fri,  6 Nov 2026 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978405;
	bh=1zPgQ5RnPHec006OGsQVhFYA7XTWxFr9hmIrm+JvQvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FACWn8ap8hp520FAoFn/TX7YQXw5cXUuaNNj1onI7RSjqMh5LcRak5cdAx9Iq9K9f
	 UgsF2sVMvVV1Mjg+iEjGfNNdwmZB87q8MMpJBWNAQIXB2sSky/1dm13E0NmjxlUVBS
	 B8q5w7XBNt7x8Ofv1f60E3xJlltylMWgNhRViHywYpX/51KIiGmk1vPH/TFI63whb0
	 edJqFllALmF6jDB6Oi2ozstdG3OFdGYLrByur7q4j5x1E0sJHGVmKmFA1Z/R5i3xvz
	 Z0N/ZyZxLeJIQS+Bw1no8jr/qBZRgcmA3VFKs9YhKxII5CteO/cDonlskvjI51ao5L
	 BR7bAu+gAlE4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: x86: hdmi: fix chmap array missing terminator entry
Date: Fri,  6 Nov 2026 10:20:03 -0500
Message-ID: <20261106151923.401559-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110405-molar-buffalo-85ed@gregkh>
References: <2026110405-molar-buffalo-85ed@gregkh>
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
[ sashal: replaced kzalloc_objs() with kcalloc() using explicit element size and GFP_KERNEL ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/x86/intel_hdmi_audio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index ff80ac3e1cbab..0a6b78cb9c2a8 100644
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

