Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532267;
	b=LHcweJ9dkcuijdRSxT1AudcvmFAcj9P/DwFVGwZ8j0TwuA+kz+eXbjvSQtiWy7m4Qt0P
	 +MklnllGclY/aS88weZvMBipSshvrsBoG4BRpHAl7VZjhZ/X4WcTeknArGGUZ6R4vt42d
	 0+DsmpmL6sbGoj6AGPkMVWqPbivkrUztMZ1/uulIf4ORi40ogEzBGEUOknXuyXgvc6n2h
	 BcGJAdZfeZHkh5GJLMTrJwHcjnp2bKr93B345DOuKiUUgkgx/pU0OrjipCXESv5fYIZD0
	 40xUZe7o8zNASiKNiY5nsBoFR5DWDsl2cRzb3e0qC4CKwv1QJ4dfDhDpKKFnZQn4+EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532267;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8Gn0m0E/X22IuLoSl4exbuKUJmUWUuLBd4XdNpIBu+Y=;
	b=abBaf5VHPGfhQBg+L1NLiRgZGhPjpB/WvOmEiMTUyyIilQOLYio5KwaFNYWpXr0983AL
	 dV9tu8Z2NKYsUw6dlCXrWtSFiS3glM03sxyO2HlPba/6JqyLfA1cTHb1b6mn6PE+owlU7
	 s3hvqbSgkhwsPVESZvssXNprXhgOxVnK0DK55fwmZMY6Gk8D4W2Qa8jlWEiwwzRA8xqGs
	 SVeRPW1ekaBpVVwBDD2LXHRUYFBxbm7LH9gHn52gGOrl45iYvmgaVtDuzmX8nkLQ73F3A
	 t3eIKDKq+FPCttGe8ikk1AGe24LWrxYMvAu06BghuejKkk6R7czb1n1Wvk15pozvILw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fy07+AOA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1850606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fy07+AOA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C24B1F000C5;
	Fri, 13 Nov 2026 01:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794532267;
	bh=8Gn0m0E/X22IuLoSl4exbuKUJmUWUuLBd4XdNpIBu+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fy07+AOAm0+LDlpFxgIvTGcIa2584vW1EAMypDN+MgPR0E2Vf0QdMYXNPoT6w1fuw
	 Jyns2cL5TdkFoukpwXAsHgWs5eIasEtZetj19vuWkwakxZgM116SgRXodroeilxkkM
	 Icq17Lifh+5P9pNmpS99B5VIlKXtdTPzoNfTx1XdEfn5c/CHggqpJnGqNFA1LAzMsG
	 C63tQ/zf/mQjY1GR4i+tPoxwCZfJkMS3HZuflrMNDJoFZ1cjqM1MvvEBOVEoT901DP
	 rWBTwELaH2nOBTWdxezy4Rta+0pqmzYdib4H/ADEp/Kvou3zGX/XYU/oswb9jnyfxc
	 cAAYXZ3iHvEHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Bo Cao <treebacker@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ALSA: pcm: Prevent O_APPEND open on OSS streams
Date: Thu, 12 Nov 2026 20:11:05 -0500
Message-ID: <20261113011054.553203-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113011054.553203-1-sashal@kernel.org>
References: <20261109201011-failed-6.12-9017bc3d13da@kernel.org>
 <20261113011054.553203-1-sashal@kernel.org>
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
index ff1e9f8c1ecae..18979f88f7159 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -923,6 +923,8 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
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
index f3b17ec2f1778..24b923aabc9a2 100644
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

