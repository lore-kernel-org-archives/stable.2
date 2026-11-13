Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536774;
	b=LcZX2628nPVT+newbAK4+KXjZkfVNUWFMpZkTKhUhftMzMEZauw65ZvuukHFSaPOJpgT
	 h26CBP6dRSyJUCI3qW++ItvLHbW6Yri1wpw0FcuVRKkH8aV2+Mlva6GmICv9Uug61QDQ4
	 XjBwkgeq/U/JL13YsYTJH6bo3lCCLdIT8IAXcoxx4pi+PBIF+EM9s9xZgh4UTAxhjPuYG
	 jT43tvPDhaLfcmcEG/iIUrbzUWAvatGE+SYQC0Lapy0MEeXm9IbNJYLP226Gc+PnjfGp6
	 iZdmWtA4sPt/xQ6j7v8wKkPcak2MB+X+eoNPDWvV66Y7WnU74rtD/HSErIxkJn62nEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536774;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0euMP9yjdY83Tt919DmOIcEdbsDoUMC/mpA3gRkD9UA=;
	b=x4dq4iwRNKasK5gla2GOq+nDRPYRQ+OEOJenzeogGYR7wa20e622aBPj65Cq42q+YUiM
	 j78z2kwpras8miuMScic11sA1cvL7XefLUCf7Vpjn5skvT/9nNsrRKvc0t4qM7qdp6mvy
	 mFVYOawKgkV4fJdohWT+tlgo0+wg7zJiS5/IR14VrmmWb8mWsOwpXXxTQxxq2JM3sNayd
	 JpL3w0OTH8nWartOcFRiW1QxCRas5ou7dE4amjJmFaNhCaCZBIxu0bn8sjg1cVlrT2w9G
	 GSULuq6DohcNU5WUnxmJsPp80qoI7NEA8Xj+LkJ0pI0BcMBvyYeipoaFaQnpZwSaamA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RlStRQQH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D31606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RlStRQQH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A361F000C5;
	Fri, 13 Nov 2026 02:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794536774;
	bh=0euMP9yjdY83Tt919DmOIcEdbsDoUMC/mpA3gRkD9UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RlStRQQHq/PHWSOvynDUQB6dOwfHoDt5kKVtXRfn8AturcG5cjc1Ae+gSfB3z8ezP
	 4BEuFbeRpUTuYFi/dAH0QLVQcqGaouiT6kCYv2virVClRYWA9qELW1BklhhdO7nVgP
	 QDbesANVdzSy/0SPOY6czMhM9HYYhSZdYSgosxTRtTauspCUqBWThS3abqoAgaVJsC
	 siZjiagCERBB2M8bHNt0pko86lYcw33g2L79iW8Pj0AbVAm3dILKsalF+Ps1RoPKQx
	 XirVJDm2AxL9cDqp2JMTf0ECIFRoNnHRV59+bfLFsgidJdfq9/EskRs1A8BnYXdXCM
	 R0mxXMqCK9K6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Bo Cao <treebacker@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] ALSA: pcm: Prevent O_APPEND open on OSS streams
Date: Thu, 12 Nov 2026 21:26:12 -0500
Message-ID: <20261113022215.632821-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113022215.632821-1-sashal@kernel.org>
References: <20261109202443-failed-5.15-9017bc3d13da@kernel.org>
 <20261113022215.632821-1-sashal@kernel.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 9017bc3d13da0ea4e63be618c87143a7b69185e6 ]

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
[ sashal: Adjusted the is_oss_stream insertion context because snd_pcm_dma_buffer_sync() is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm.c        | 2 ++
 sound/core/pcm_local.h  | 6 ++++++
 sound/core/pcm_native.c | 6 ------
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 9df2e819035f2..8bad50bf00e13 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -930,6 +930,8 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 			return -ENODEV;
 		if (! SUBSTREAM_BUSY(substream))
 			return -EBADFD;
+		if (is_oss_stream(substream))
+			return -EINVAL;
 		substream->ref_count++;
 		*rsubstream = substream;
 		return 0;
diff --git a/sound/core/pcm_local.h b/sound/core/pcm_local.h
index fe9689b8a6a64..f43ecb904069c 100644
--- a/sound/core/pcm_local.h
+++ b/sound/core/pcm_local.h
@@ -73,4 +73,10 @@ void snd_pcm_sync_stop(struct snd_pcm_substream *substream, bool sync_irq);
 		for ((subs) = (pcm)->streams[str].substream; (subs); \
 		     (subs) = (subs)->next)
 
+#if IS_ENABLED(CONFIG_SND_PCM_OSS)
+#define is_oss_stream(substream)	((substream)->oss.oss)
+#else
+#define is_oss_stream(substream)	false
+#endif
+
 #endif	/* __SOUND_CORE_PCM_LOCAL_H */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index e861404d393b6..c6ae68f35f2f8 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -720,12 +720,6 @@ int snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime)
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

