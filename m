Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272528;
	b=WGvq/KlHenMJoaE2Ekn6ApSPFZHwz86YwxsIXlMPjhQXoMAbJfap/aJIO1RQ/fqrqKZk
	 2IKdQT/SjjzwNznzeY0E4xEPAUC2npRMCBtWdFtHblFDUTpbnR1whS5glTAUS2zZaXpa9
	 MvvlV9FTTJZiGyAD2A0yTzK3KL2DLNSnmX8+ZobOvVpo5WEGv7a3A0gz6V4lBWMz8IxVP
	 vsqLNN1fSpNRPPDJE7jDrk8IdOuCQ5YHoNrBZocUemH0HOflwu3Q9g1NZglCpAK06e36c
	 30uRNaamrwHoOp8PSY5C57JpXhqfC/S6j8RWwZskeElJ0mv9uB/0QBhl0df1t8C05PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272528;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UVYrMZS1ex0AyvvOVzH17P3eLYMqgNElRlnfPTXwjAM=;
	b=uwx2qoXY0DK5ORnniir84xFi80htF4VqrJziWOl4v0WNd2yaJG/+FC+fMStvEUnecQfN
	 mBw3aIKeIs1aec0Q7w5u2PxmBTVuH16z33Xy9b1pDnDuWt60MGkgG+Gu9lLhzK2MTkwom
	 5hQ2+mYHIPPDazFngG+esbXrBN3EHWqMHd1spEWkAFpku9Rj7zEJt5HjIqXYpGlizwUEG
	 Pi+Y9zzaglD3YlbRZ8ihni3mthrU8VZQ3eb8Y7UjLVgcV8sGgmVaWBmAWOAoYUrzsaXgI
	 QdvjUSFBqWUfshNp/A4p/Ou0YGArjuzYeu+yuhvjcHFALNCoClIT5ArAr6iO6FHTDvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIgrWGtN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIgrWGtN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D38E1F0089F;
	Tue, 10 Nov 2026 01:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272527;
	bh=UVYrMZS1ex0AyvvOVzH17P3eLYMqgNElRlnfPTXwjAM=;
	h=From:To:Cc:Subject:Date;
	b=gIgrWGtNfXGBpANDTgpK4WeJ0OxnQRRq1xML+4DYPi5i1MxFqFbCsbNGtYGbwux7G
	 HDlKSwG3O6+bjku7ddO4mJHOW2Hgmc2d7ATiWij4iQT5Qh8aE82nRbsMsAwMD9AfWF
	 sAPpkNnhlo5klkVTB8hdMm/9tNzNgEvaP/cbOYnj0cjP817nzdKN4a8hTH4VZlpJ2z
	 pxNuaVQwr4viw78Sg7UDBHs40rlMos5jI4IDTaKKJUPVlKJIoVlE5fl26yo5/46NuU
	 f2KSDwTeFCqt6ejm7wmpDwswJdk2rP2VyuoScxaT8ChJKAZcCkrulvXYjipQzud0OE
	 5+wQBBvH1C+1A==
From: Sasha Levin <sashal@kernel.org>
To: tiwai@suse.de,
	treebacker@foxmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: pcm: Prevent O_APPEND open on OSS streams" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:02:06 -0500
Message-ID: <20261109200206-failed-7.3-9017bc3d13da@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 9017bc3d13da0ea4e63be618c87143a7b69185e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200206-failed-7.3-9017bc3d13da@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9017bc3d13da0ea4e63be618c87143a7b69185e6 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 3 Nov 2026 16:58:40 +0100
Subject: [PATCH] ALSA: pcm: Prevent O_APPEND open on OSS streams

ALSA PCM core accepts to re-use the existing stream when O_APPEND is
passed, and it's been used for dmix, etc.  However, this mode isn't
supposed to be used for OSS: the OSS stream allows re-configuration
via its hw_params/hw_refine procedure even while it's being mmapped,
so it implies the usage of only a single stream.  Because of this
assumption, the sanity check is skipped for OSS streams, and if user
may attach to an existing OSS stream with O_APPEND, it may result in a
UAF of the mapped pages which could be used as a privilege escalation
exploit.

For addressing it, this patch simply prohibits the O_APPEND behavior
on the OSS stream.  O_APPEND is never used for OSS layer itself, so
this can't break for the right applications.

Fixes: 0df63e44c3e3 ("[ALSA] Add O_APPEND flag support to PCM")
Cc: stable@vger.kernel.org
Reported-by: Bo Cao <treebacker@foxmail.com>
Link: https://lore.kernel.org/tencent_E90BB4F086165FAA3313723567A5C675EA06@qq.com
Link: https://patch.msgid.link/20261103155844.120838-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm.c        | 2 ++
 sound/core/pcm_local.h  | 6 ++++++
 sound/core/pcm_native.c | 6 ------
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 064df4cd3b50e..6c8274414c226 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -929,6 +929,8 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 			return -ENODEV;
 		if (! SUBSTREAM_BUSY(substream))
 			return -EBADFD;
+		if (is_oss_stream(substream))
+			return -EINVAL;
 		substream->ref_count++;
 		*rsubstream = substream;
 		return 0;
diff --git a/sound/core/pcm_local.h b/sound/core/pcm_local.h
index ecb21697ae3a4..4b134d435c24f 100644
--- a/sound/core/pcm_local.h
+++ b/sound/core/pcm_local.h
@@ -80,4 +80,10 @@ static inline void snd_pcm_dma_buffer_sync(struct snd_pcm_substream *substream,
 		snd_dma_buffer_sync(snd_pcm_get_dma_buf(substream), mode);
 }
 
+#if IS_ENABLED(CONFIG_SND_PCM_OSS)
+#define is_oss_stream(substream)	((substream)->oss.oss)
+#else
+#define is_oss_stream(substream)	false
+#endif
+
 #endif	/* __SOUND_CORE_PCM_LOCAL_H */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 35152fae74ca2..bec797398acf7 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -749,12 +749,6 @@ int snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime)
 }
 EXPORT_SYMBOL_GPL(snd_pcm_runtime_buffer_set_silence);
 
-#if IS_ENABLED(CONFIG_SND_PCM_OSS)
-#define is_oss_stream(substream)	((substream)->oss.oss)
-#else
-#define is_oss_stream(substream)	false
-#endif
-
 static void pcm_qos_req_clear(struct snd_pcm_substream *substream)
 {
 	if (cpu_latency_qos_request_active(&substream->latency_pm_qos_req))
-- 
2.53.0




