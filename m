Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532576;
	b=q8fZLZ+MWTFWcGFCfcI1Hyidh8J1MeDpgzlEYpebVVPcv4zDzalERnCwFatcrXN2LXmA
	 ZTcQzzfAdRMRpSYU+TfjbUF72SHSrCXMH02V7xuvIK1VHPUqIGZ901RjzobDQaek2LyyK
	 BxgXUUs7v04sjpo5VEwcp+97pMVykMBbGy2L2dCVZsu7BzyHIARG5Xa2Z7mLI/W9sQfHk
	 CICZDgy4uXm3e41+yw92Q4rM8pouCO60I6xs+QW853X+SJb+lhrJw9VLWqkoaIouqPPtk
	 sqGEocO7bweiP8BGA4/7C2CDvYzPrQ6Wt7Sy0XtvDsPsjgI1YOluwBZWErUqlqsEoDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532576;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sgAwX9+IhmpneZ5BSBMTXN49tVh9L9lifbJ4zuEPejI=;
	b=qgSepLbWxXr+gCXsb10Tknv/nKjRC16EUkY4EUfRAXP33KVT7GkVULLmo0XVyLGUA6rT
	 w/n49NOBtDIdngJof75e6aWNKzMaBGr8/Z0zGpfmh6K4VH0LnYlx03vOAga/2Eba5vSKP
	 3bzwP3F5kMHMDzRjPEaH3kYeE+nGw+rHRBbEhuLZXGM8oSu0IYxq8hWaaOpDFcYAexOKM
	 x/3X3VhmwvRlHUMi18F83IK+qg+eVO6ZkX0Lsf+et+XEHIExcixXTTjZTDX92za0mhYMW
	 wzZ7glldyMzhUQXr8o5niSYulYXxebKBFVsSgHNhLiQ6xQ+CqY+RcX6EoEF6kMgvbsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEG8pXCg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2B606A88D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEG8pXCg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9AA1F000C6;
	Fri, 13 Nov 2026 01:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794532576;
	bh=sgAwX9+IhmpneZ5BSBMTXN49tVh9L9lifbJ4zuEPejI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GEG8pXCgGNUS3RpoHmkJhL7VimPr7RzQK8AqsdJqQb2cShy4GYKpChGcrl5ALyuu4
	 Ik1fMevei9nGwGYysdFBoTNCp3dXtVnOMCuMcYsXsNCfTgiU/0AGzuKEJ/eojH0joQ
	 KDgfSrDduFx/E7gMGlTkDJvHd5VZhEl+++US8ttqmUqooa7yPdPl8oI1BuPN9TPbkZ
	 +NTEPPHi4mp51Yg19WftggrJ3QwCuGnux+mtEMMIT2YDACIt/7ZYJRQfuuMs8Cgwuo
	 WsKyOlpOy6TId1BwvN8shHeM3SyCHkDTTVTtnGU/c7gm6h1TgHfy0JQQyjU05y391l
	 WT92rz4dFR/Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Bo Cao <treebacker@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ALSA: pcm: Prevent O_APPEND open on OSS streams
Date: Thu, 12 Nov 2026 20:16:13 -0500
Message-ID: <20261113011600.592705-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113011600.592705-1-sashal@kernel.org>
References: <20261109201441-failed-6.6-9017bc3d13da@kernel.org>
 <20261113011600.592705-1-sashal@kernel.org>
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
index 6d0c9c37796c2..af5bfb86656fd 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -933,6 +933,8 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
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
index 989e822c1059c..42570787e815d 100644
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

