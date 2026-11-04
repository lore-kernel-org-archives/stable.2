Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819768;
	b=R8dqoRSLIUSisQPBAAXD8t4dCrE1vlm8b7eGFK7RmYB1MJccxAWl+ZrHhTrHffD1GlWy
	 BPgDyDZyf/PvCt3RjWMzMbVMS7rXZGKZFTOUqwmpLnrbdaB4+rSKqf+MJ23blryl4KNiP
	 XazautJ2otreuTQa+ySpZuiJMtNROiFlSnxzMTcRxdBe1GAwFBx7ZBMZJfhA5byVu+FAA
	 wZrXp3Ruc8qPeNIxsUjW05mBrJIHMhysSO5G9yHovn2UaLl7M9RMf2Q3tAUYfiZ/4lqwq
	 ffjSdCR5+jcvF2noYOGmgV5MG+4WNxWCRdGrr6EoPEQd8a0R/MiZEpuWWE5+5KIIZ3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819768;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OU7pv/KTNmQWgfSkkD6U0ovT84LNw5hL8Ew1/bxzduI=;
	b=wNy9uFJKMh35/nk/pu/QrRZ3OrNzqGrXQHuoOz1mu+ovJUrdlt6UQbE51hxchfKztChg
	 Kl18W7qyoPshaVMBUfNkfjzOuX7nbxd72A1NhT2ouKSQkFUZphKbdXlhj6vmEGeuTSSfL
	 aBPt7eAO5LemrVSYIU3jUDfBzZoZPEZ9Elp28BDd6GsfUPRwXJ9V7eOyPRq4/twvFT8QH
	 XiWSgfFjcbqbHFoNMDsaIfpmnbg/nPZsCle2jcJo3JJyHmuq/KvTqX7qld7BTVR2eC4u4
	 ztgutDXqUHX8wnmXt9z50JPMdOveI877vNNpfnIEtnEwYg59Tl9hIDgRPDLbZOhg3xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=EA2aZYMj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5384606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=EA2aZYMj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC091F000C1;
	Wed,  4 Nov 2026 19:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819767;
	bh=OU7pv/KTNmQWgfSkkD6U0ovT84LNw5hL8Ew1/bxzduI=;
	h=Subject:To:Cc:From:Date;
	b=EA2aZYMj+fEEfn4cW+CbxO/gKxaUNbFqQzXTgqNheWjjmfXGlw2ls4XJOFO0e9N7Z
	 QrIqGcnztbAbodv/atx7EN6rf9yuh7xKmyVl6+0Kllc68V5YtsSqjCChhjq9oQlY86
	 2787j3852St+NDM8kgJn49LB1OUx/o7JL3uo4zO4=
Subject: FAILED: patch "[PATCH] ALSA: x86: hdmi: fix chmap array missing terminator entry" failed to apply to 5.15-stable tree
To: peter.ujfalusi@linux.intel.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:16:05 -0500
Message-ID: <2026110405-molar-buffalo-85ed@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f5e1a9a3fddab8421416b68bb132ae9626d07156
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110405-molar-buffalo-85ed@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

