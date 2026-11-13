Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540248;
	b=XGXaEqBfkeHTrsljvhsOltgmbxqgSgIBgWi+K3Lci+2jTaUavQyLvPxs89z4RstOUbSf
	 zJuRRQuS0fHoe6SaTC0kllcO1/FuEuRzV1kwUsSUhyfbzRfWxQco6cP9xlcrlMKkfJYCD
	 AMFWMUixCXxsS4bq3f6Ai8Hlx1/YwQAiKpRd02O9AqiHdWZzhVStYgBXhJoaynRlZRKoL
	 poXOeCza75qLkETajDHAW9RCl+lcTtzOEpPl3l8otHZa0xAjqfCQbyVYr5TXA7El6x8Kq
	 ++Iz83GbpoYWOkjvXCvSoCZnuI2wzpTu2+nRmFXuNpPtyXy0Ia2JnSA1qA6DsZfvREQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540248;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=khiKOGsNMTHDyzx2AtXgc6i62TVk9BvHYX6YqKL10pU=;
	b=bVRPfuImYB7tG1XJPsnRk1gXZtkWnGAN9fPhF+gI+KyZfbcDP08EtpGjMgbHH/0hT5tr
	 uNKf+mbeD43H+8MZJIDYJwVmFrnbQSnRXggbUVX2bl8eUhCluyA7vVSTDprIl+9pUEjVy
	 7UBDWskS8OITQwftnwXweMiaOTgiOErTxg4HbH5KlQm2GelDkecxqYIK4qqq4CWYDqR06
	 MnffZHc/yy71PkCw0hyqbww7+qI1Dc5xbApaHwrTIMWpVVxigJFj17reh4u/GtOjvz5Ee
	 5WSg1rm+0kwf2kCI4ebmzHSoj0hjD3U5FQpMV8ty7I0HlUEduARvg7ghUBQuH5zjqCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6u3TMxb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3F0606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6u3TMxb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9476F1F000C5;
	Fri, 13 Nov 2026 03:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794540248;
	bh=khiKOGsNMTHDyzx2AtXgc6i62TVk9BvHYX6YqKL10pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6u3TMxb8t0xKt+ibA/VhjzrR6P0gfH6yjR5J7EK6nfrNeZRc7A79HCVlgLDFDJ2J
	 BkDajVJGhOlJ0LGkAq6d7nlxIrPnalIKrqpQGib2JoGCnmhSyfFmV6AuwhJWce7iA6
	 tmgo/Ke8H405d+nBNcfDr//mXFpcfULSSJmNlsq96i040Ugd/GEUH9BQa6sRNkY0dr
	 kGwPMgAcgeLl0i6K0mkrWH1h2P2aKYFhfN6gHVY3aF2y8z/nONWQrQx6FB+6cqLsF6
	 Kf2hVKjcioQ0hLVu03dUp4+DEqe0vW3dRY9QT61yJ3x4HdPSiAllyT5rCWfzykwfKx
	 lXxxsih9DIK3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Bo Cao <treebacker@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: pcm: Prevent O_APPEND open on OSS streams
Date: Thu, 12 Nov 2026 22:24:06 -0500
Message-ID: <20261113032342.850566-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202903-failed-5.10-9017bc3d13da@kernel.org>
References: <20261109202903-failed-5.10-9017bc3d13da@kernel.org>
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
[ sashal: Adjusted context for relocating the is_oss_stream macro because surrounding helpers are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm.c        | 2 ++
 sound/core/pcm_local.h  | 6 ++++++
 sound/core/pcm_native.c | 6 ------
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index bec81f6ba6ba5..d4eb842784143 100644
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
index b3e8be5aeafb3..353f675724337 100644
--- a/sound/core/pcm_local.h
+++ b/sound/core/pcm_local.h
@@ -72,4 +72,10 @@ struct page *snd_pcm_sgbuf_ops_page(struct snd_pcm_substream *substream,
 
 #define PCM_RUNTIME_CHECK(sub) snd_BUG_ON(!(sub) || !(sub)->runtime)
 
+#if IS_ENABLED(CONFIG_SND_PCM_OSS)
+#define is_oss_stream(substream)	((substream)->oss.oss)
+#else
+#define is_oss_stream(substream)	false
+#endif
+
 #endif	/* __SOUND_CORE_PCM_LOCAL_H */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 40020c5dceda0..7b6902bf0fd12 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -702,12 +702,6 @@ int snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime)
 }
 EXPORT_SYMBOL_GPL(snd_pcm_runtime_buffer_set_silence);
 
-#if IS_ENABLED(CONFIG_SND_PCM_OSS)
-#define is_oss_stream(substream)	((substream)->oss.oss)
-#else
-#define is_oss_stream(substream)	false
-#endif
-
 static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
-- 
2.53.0

