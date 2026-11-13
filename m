Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531928;
	b=usksVqn7nrVpx6+FvPL30GByVeyDH7Cmd6E7vy4ov81dQIJvSBFg6q0/nC+N2aHhfkhO
	 ZnQU+LsdV3fRKcu/CN+MM6ibdJKjlectyit4bZIEcxgBXDnzTn5+QMI2UneDYUPjnsswk
	 SIH0fkGo50SIgglHker14/cu11s/7HiX8o/mIcdatNTbT6YbUnKSFUZEIHfXeWlw7zELE
	 jZvI4f7P0jw2zhZS0SvygXATvwXiR5ipdao7UFbrWVagmgVhxol0QMJw+0exTA+TZUol/
	 GgGtg+RQkhNb40WzRrysmpZ8hkcKhtjxX7V/IPhFTgC7h/t2+UqPd54zlUmdvx7/UiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531928;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=E4pxTlYNe4FOw5zIS67s+OTJ1HGhM5o+TyW2EmrtRhg=;
	b=hcmrufwlaB19OqxAEnPR/0DMKeiz3BL5W1LCvOvAFAuOXvuXAocGxpQeFm9s1vdiodDx
	 wXlP+5tGTfJk+Jovw/iEbDE6H0GD20tF3MKwuOz2/nT2LnkzlnO9A1UG9IlMLDwcEXiYy
	 qAaNtfPE5bekKsTz5Vko2U4+k4MY56K+GpdmTOkG/GqZxo7l+VJRJ1m1TJZAMG0xIVinJ
	 iy1ZJjMJnPOLPbS8pJHBNU+dmSp8y3KcUteC3f7tXE7pyN817wdyFF0PdGTshRB+8qXWP
	 OYmkL2IC93NCpHV9YN5FdajQGh4FFvwOQ0y5DFX9XR7F4ZSEJMNGwGv5v+iGDYVdhgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DpJERctY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D84606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DpJERctY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979A61F000C5;
	Fri, 13 Nov 2026 01:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531928;
	bh=E4pxTlYNe4FOw5zIS67s+OTJ1HGhM5o+TyW2EmrtRhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DpJERctYjOtINFDpBSu4HIsJqZOgBGQ/fzprxzB0e7iq4wDqEqAUGcy+bJzoYwjxe
	 Ci9aoGOr/QH1mR7HeYAiSuHK/P52g3H3+yFkB18PW8vajLo3KUjnb7NfFbH49O5GNr
	 Brzuf1pYL9voDGd1PS/57D41P88ScBylCranG4QMAh8cVRaeH++w1mSdbaGTZX1/JZ
	 UFocC03G6fo3dq4mkRHIWKigEbYISIvT1ibj7puwC+iQNO2/GeM9ngB+FP31Fq6W02
	 EVRVyoqhMQR8p6p93mm5dwvHEWrEXZkm8RQcgk4cxeewHVJL0F5qncJAoKQDNBzhDI
	 g3mCWSoEcOIIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Bo Cao <treebacker@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ALSA: pcm: Prevent O_APPEND open on OSS streams
Date: Thu, 12 Nov 2026 20:05:25 -0500
Message-ID: <20261113010516.541619-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113010516.541619-1-sashal@kernel.org>
References: <20261109200554-failed-6.18-9017bc3d13da@kernel.org>
 <20261113010516.541619-1-sashal@kernel.org>
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
index 0b512085eb63f..a723b1e566077 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -921,6 +921,8 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
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
index 7dab7ba130c0b..79b49d8e6a87c 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -745,12 +745,6 @@ int snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime)
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

