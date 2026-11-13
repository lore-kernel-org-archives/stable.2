Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531633;
	b=5Gu2WaYw3xAM+EQUsig4Fv921DIRx30Z9vX3VwO6bU0GPdvshFYpi6215mNMY2jcF4DA
	 ixMKsRAwHJDYRH7D4hQJvS8U/ipzpXw56wjG8lCxr9VNlixmc7lJIj+G0ES6S1XVBdloP
	 YnyD4nGrwjQIbxPCigUMVrlLYBDpQYtSEEYNSEMh3PzC5mITouKaT1BKhRn+aJMwtesoM
	 /Bi4dSKpfhpIviqtrzIBqnBVWQpoc0eZpklVRWmEtnm5rMhXYoJfmudN/kH9vyeN+NPzI
	 thzXTvpiHbM201VUSo2bd3K0Dn4wq4Y1pF1xmIWcqgYTzI8pNedo0BtJPnI2vqdcc4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531633;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ydDpOSxjA4tWoSTUf1TI7QTPVhi68XGb9joV1qVbcl4=;
	b=fSdjiW8CEvu0pVbU1S9etKf/dAsXo7OJ6aFqrNdr2mGgE58TeliiuEblt6vNKBTfo+Vb
	 j1ogyyLleJluCdH0oF1cu8+oEzVWOtbrcf7hwN/rIt3A/6zjH5wO4QUa1mTBoTZUU6hM1
	 IBOTQJmHfIcFGjshktuIgO5bq0jhEKh8Y/jYwKvrq0mO+5xWVJtLfGeZj32LWyBgH0ICE
	 9TFw4rsfvAhhKbcCVq6DL9iTocrLvXjibtFoiL8P0Xd7OMZWsjT1jmOC0Ah+k0onf0sVt
	 s0uzuFG3ax+oGr8rW/pgz2O46Frmxv3oi/kS0b6qG9Zhwgzrcl2GFFZ6ZFkss+oNlfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=np4uRedw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8825606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=np4uRedw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA9C1F000C6;
	Fri, 13 Nov 2026 01:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531633;
	bh=ydDpOSxjA4tWoSTUf1TI7QTPVhi68XGb9joV1qVbcl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=np4uRedw3CHsxTDmcF5LOhT3Zh3+00763G1XYYME5thOf9Uh6g0pte2UYiw0ZNU81
	 ywSG9i+hHr7sI2/DT+BhlekPTQkn+xUkEvSZlHAzErDV2xRN/sdPoDyk3eL0DX3lTp
	 uTrQCo5MPFtdxZuDsjKDfMi/RT10ZPkqy0jpo1w2M40gmmNMKMWxhccxlXTaKw9GME
	 bzk3JE3j5dY69/FTAEWxpz+YivJXH+GzlGjLo+9Y3GLmpJVDvmMBo01seqHOrHIw9K
	 yrrUhec2TYz63M6PRtWvWvljuKZVEI3yKCevuNplwF2tiOd2j1F0AnIvO++dydKniC
	 O0IVlG9HkdWFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Bo Cao <treebacker@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] ALSA: pcm: Prevent O_APPEND open on OSS streams
Date: Thu, 12 Nov 2026 20:00:31 -0500
Message-ID: <20261113010023.438195-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113010023.438195-1-sashal@kernel.org>
References: <20261109200206-failed-7.3-9017bc3d13da@kernel.org>
 <20261113010023.438195-1-sashal@kernel.org>
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
index 41c2cab7a52c4..6aad7a1fbf1a9 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -919,6 +919,8 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
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
index c9e80617f508b..1164ee7f14f07 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -772,12 +772,6 @@ int snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime)
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

