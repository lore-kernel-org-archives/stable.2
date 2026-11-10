Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273885;
	b=mQDr/KPHVlmNNid/RUrW0FRZHk+yW1W8WQBN8aVE9z4N3cwoxpNoiowz5d8HFspXc0V7
	 WF3xFJlAsUyIkd0SHjhdqER6pFfelGhNAMJRHRCWa11vsT+d3ivHix+O/3FR/lNSg3f/B
	 02Oge+KOfSl3Dg7sXwiK7uVVmFFFeNFdXs611hT+GUQnYHgbTH579XUK5bjz+03xLPrMA
	 kRSRE3sV6zacBZoGkXMZLbWDGO0duRxnSQOxnABYP5+OILstulVsLExpVjBhc0sUW735l
	 N7eVQj13/iDTdgsaBBD+cOBocbgZNz/g2Jr7e+a3R7VvdFr0WDFHgtAFOnmZKI+XMpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273885;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=M6986uQYWz0dOf/Pp98osoxGR29YYCi03fbG/LC3WNg=;
	b=PUBthyJ/snWxER60cADV8IRpVtrlJtWhAO/VBIIVNn8SpKPX1RUMRYLfLApOj9q91zLl
	 NibIyP9WQpiRRDH+caQQz+GjQ8R8X8ozrZDm2ZKuJFiTTaBxpTWamW9ZAF9mSB8svCgcw
	 6FiQ9lV0HtDugpeUuNGovtX3DrpE4wEFp6EdpKsncXjCAyXzaITrU4yDkoJJpo8bX4+23
	 zVdLIUl/P2VJnRfTgJWJzAZvfwJs7wF9o58m+tzF0FX7fVgVOmNdDuR4dqRZCLtLEp+du
	 O1YGXj5xxTdWnqK/qtrQ6uAEtNC4ndq2LSGTHzb3vJo0oIVJ5bB6E4LYel2fDDW9iVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeicRLeT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B377E60A261B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeicRLeT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACFC1F0089F;
	Tue, 10 Nov 2026 01:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273884;
	bh=M6986uQYWz0dOf/Pp98osoxGR29YYCi03fbG/LC3WNg=;
	h=From:To:Cc:Subject:Date;
	b=eeicRLeTLjeKxTScUKK7hjpgsYnUJ+eE7Z6iSWi+69NcuVGk9iW33AV85cUFcDPrL
	 6KgfqhDpul5p+FydOVMRJHH0gQWAfoB/dUh5trYNb69rR+rPjFhhsyetTdRClSFBbG
	 HkSR0XJU8DTndtJ8w724TMEhpddbSSx33+5UevvMUXHqUymHKyfcBmiy3/y7uJXiZw
	 tbzd5n/eUolf3yJ+N7HG9BCCR0kl4qAWZLmgtv5o/l90J0FHVElzK2TDI4KyonG4Z7
	 prvj/HumIZ+2P9tv5aCZ5oKGVJ4pARIADk2yYMPI++7XYppza1FAp096M6tWTL4G4a
	 1whmQZBeXn1iA==
From: Sasha Levin <sashal@kernel.org>
To: tiwai@suse.de,
	treebacker@foxmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: pcm: Prevent O_APPEND open on OSS streams" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:43 -0500
Message-ID: <20261109202443-failed-5.15-9017bc3d13da@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9017bc3d13da0ea4e63be618c87143a7b69185e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202443-failed-5.15-9017bc3d13da@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




