Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532845;
	b=LnTydAKfp1m6mPH4QWGX0pXWpXloa+Pbpdi7hp9DxUkN+nLU+pOgcBHdPZ9L2XErLK9d
	 xtCJ00b34tnBNKlaEZZKB1N/Dd/lhnNwkxc/onuhmNwcMjBp3LFKIPPseXWO2GhEMPjIB
	 BoBSg+Q4JgPxuG7Ub1m+hId/Fggi1JWqZMk+JgRzo3wcQNQuQu8aeDGEoh/gC2HsYyC00
	 BQVTohl61hNcidVpRlJuz9M/TU72f/RY6XbXG1rJ7N1c980vr9QCY76toQRqZ44KnvhYS
	 Dy/39+snUbsKpp4dqR2ZomEayFeR39pEx9sTAW1RcFcBVU3kGXWnGjJvihLAVLoXyAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532845;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eNsRFqYJH5ye39ruMwzLDQ4ZIBWc7fDtPr4uqABETjE=;
	b=4VbWb70c9WIkoPFV736tHJPS4erTG8rFSzBcn+0J+Q4KYnMk/tQAnon1vR/2qWtCpRrW
	 I7vyc+6LscOPYMB9QVt3FZ5Ut0p1jFZi8qbFux2fLGW6wcNh29cS4Kup4a2ZzWSj60Q+q
	 Ta7k2WyYcSMEoyfw1WD7eLFDLBqh0dc7kUqMb2Byxyo5DgT5H5dBNhCaRWzPCuhtdc+yD
	 Ftqyx5ILi0k+tc8dRiKFXRdVf7Qi8TIGf9pusob5XakXUDfKjZr4IYIWk7wUsnF6KNJxF
	 3Umu6cfYHgb/gnVX+IVfFkL65nkaGLbbCkq/+i1Yn0RjCe5f/YhbfDV1Ft2ecoDmdsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kc/Rihof";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6DB606A32E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kc/Rihof
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79861F000C6;
	Fri, 13 Nov 2026 01:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794532845;
	bh=eNsRFqYJH5ye39ruMwzLDQ4ZIBWc7fDtPr4uqABETjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kc/RihofNdjTdO53MT/gvdKPU+LNDLal4hY4XqXBJNl/nCqftSw7QZUzH1AAhCP7W
	 fawPNEPKiUBRxKSadk/wYDzE0c1U4zEKPooxgWu9czRjxbfOwdEVMbyuXechuWOyf0
	 QNuhhDdsCE5MYNKwN8qxBisO8py7fniB0eOqAcyKDh0x6Pl053i32gsYWFfO0nQSG5
	 AxURgHZJIPJRtZ6HU6ngpRGSKN/FMmDXZMv7kYsNIy/KA6naZ3COECWn9IiWRmSm/d
	 U8OMQtNaYCzIVE+L5YAWwXBJV2L8059SM/+nRCHoaOWnbQPvVBymPr+hkbsfAsh1Jj
	 QhH42vcI2DugA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Bo Cao <treebacker@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ALSA: pcm: Prevent O_APPEND open on OSS streams
Date: Thu, 12 Nov 2026 20:20:42 -0500
Message-ID: <20261113012028.613052-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113012028.613052-1-sashal@kernel.org>
References: <20261109201939-failed-6.1-9017bc3d13da@kernel.org>
 <20261113012028.613052-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm.c        | 2 ++
 sound/core/pcm_local.h  | 6 ++++++
 sound/core/pcm_native.c | 6 ------
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 2415a3c3ac6c9..a8d10a844e51e 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -932,6 +932,8 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
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
index e015f34ce463c..9e87aa2518411 100644
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

