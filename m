Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819763;
	b=ttb/i97Wk/iEguJ7HwH0Ytas2T+KOVWsMdyNeZGOmtIZiVaIsQfL3fPmy5rRMcAPvxOI
	 vPYFfFgR57OogCe1BKiZmBmX10R0ySP9h4jFqtAdXGDCwbKXYO3XPZ/PrPwJD2ILeogyn
	 h7LoOfWZP8Am57IYPMwWTLgj5GZ80nHHOTwRjhF4ZiA0mezkiH7PtuJ6Gg9ENPiCpo2LU
	 XyxbT5xrIXKV6jC45HRQSRZJPaYg4MJgIxDJq/1c2SZut1FSbLaincB/tNloK3tEmt07M
	 2sN8Y18ic7QBIx3Njl91TNsuoDiE/aihiFG4qVc6Uh3i7562xvHqalMjo37Cai6e83w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819763;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1mTD4EO0wR/rewXIa6NCGX6KdOrUdylbqvxrfsQrgJE=;
	b=gFDlXFRoymsIYrJJPLt541t+Bmwdl+ZiwNdDMq2ht2r+0NevF7lxqzq+KxaYoYIODoOt
	 WCLpzZRI3yhJamVJNpXL6659W5Ir5o3PW7WIl4d/TajGzwMl+mr4QdzBDCGedm6Ml77zZ
	 LRR9q4RJ9EoDL9Cqc+pdEZpwgZlAvpBMh1MnxXhPNbyhd2STq09ejpxtR8poGbrjDIh3C
	 3Fa45ggyPlUTbp6vJV3qg/lTiQhqF768PwI4cbZQd9LLjhaIJVPs6AyAQYdQKxxIFRs8j
	 uRdbDNhn1xtxfhGZ1EXisOW8gwLp2PiBBsJWUtOP68kzIObHz1CCXBlYB7X/o8ZEyYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1eCMRQUv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8166B606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1eCMRQUv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EDD1F00919;
	Wed,  4 Nov 2026 19:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819763;
	bh=1mTD4EO0wR/rewXIa6NCGX6KdOrUdylbqvxrfsQrgJE=;
	h=Subject:To:Cc:From:Date;
	b=1eCMRQUvJCNnZrXmLBaOo3jxv/XFcGPZd1Hv2CBHx00PgUtDhwBVIZocwArSNC9Xj
	 alCTsftasn/fR4/KVxQ+dLNHvis3EMSU7cgwpWQQUtw006j+nfEpPxcWg6sE3YOTYx
	 i8Mfn5FxrxWTEXMEvDV9NIcKfK2ajfWnZJnVQP6I=
Subject: FAILED: patch "[PATCH] ALSA: x86: hdmi: fix chmap array missing terminator entry" failed to apply to 6.6-stable tree
To: peter.ujfalusi@linux.intel.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:16:01 -0500
Message-ID: <2026110401-reverence-patriarch-006f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f5e1a9a3fddab8421416b68bb132ae9626d07156
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110401-reverence-patriarch-006f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5e1a9a3fddab8421416b68bb132ae9626d07156 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Thu, 8 Oct 2026 11:54:11 +0300
Subject: [PATCH] ALSA: x86: hdmi: fix chmap array missing terminator entry

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

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 9f67244d4946..542fc35ec9b7 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -475,7 +475,8 @@ static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 	kfree(intelhaddata->chmap->chmap);
 	intelhaddata->chmap->chmap = NULL;
 
-	chmap = kzalloc_obj(*chmap);
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
 

