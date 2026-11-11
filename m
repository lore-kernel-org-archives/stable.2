Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435179;
	b=eS34ycmNuG84QQqmvsvhbM+JiDbd2WiGFe8ZpWJl2gTI2wlOYizKZPoSeW6maFB+Fwb3
	 jaj81kzw7Sl6QvIycNaGraX0/yCePjpZyalHtBirAoLkl9RHrkLUjyGM2BWz3zdKOPTbD
	 XWGbgiRGOvWu2SG/CtN0gQuE5a92LRlIxjT5HIrymoQ6QpY1FXNDw8Q/HltDeT9Z5Tt/C
	 2LJGva/wJf1niTWwdY172hk+IdhI1dq/BAWsH19oUIZkcNr0a6c2kTqYdl4SirPl+XCJL
	 mEmLxILE0n2rTW0Giw1ZhHKF/y7NqjEm5BFgoQxfU4QeRgZw50ulwTUQNgISXYV2Y6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435179;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yFZS9hfeeJk2dBAeNVmBLRGK7HrjmaceUodw6OnqY7g=;
	b=c4CtsmFxLocGrTSSXnCQeDq4MWndJ46eIKEkUOsjZ4ukLum9RNgQLBYNuizYCGXcRQCq
	 iBj5nsVbb6TVUwBdhvJX6UOKvvmE5lYyhzhFaJgobB3OAkkmhkz5wvKNO88o9ZQcn91H/
	 vNvJKOtuUs1DFww4DWhPCf63cFPcfUO8TzGgyVmkGr1SZZAqNYTIUUBR1a87ZcrbvHyPh
	 JFF7ZXRZK10aAZicqK/AsG/n6a+8z3n/ahBwYlJIJL1IAb+C7xkYctsyAjiRJPSL2fl5i
	 mk6kFnTrd1KuJEzX8t0gL9jhwqpCYn9Y9I+v2xZJ3tKvoqaV5vCQoxhfMByqb2T+GKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HH4ZufH9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51C606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HH4ZufH9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3071F00A05;
	Wed, 11 Nov 2026 22:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435179;
	bh=yFZS9hfeeJk2dBAeNVmBLRGK7HrjmaceUodw6OnqY7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HH4ZufH9NF3R2Oi+jro4EmOGO8ouwZ3HiUZRrs1DPv9aMCvyWy8y36xnpXraJ32Zy
	 Q5V8epee86ZQ4H2Vri15A/PgZc03nX+ROykAWhg4WE2g7CoIycE2zwHAuxxv+ThBH/
	 5Pl8UvJolObCCKf1I7+Ytrl/jXVWMefUfYh/D/1bSGMuJZpSiqX6nk8EAnzf5hFKXL
	 bF/CWgFoomgBH/pcJRE7aVQB/TesKI10VuP6MOHSRlBqsuobqRhwN770tiBkkp+ZzD
	 J8npgBPpbtMd+4LmwA2C2IOYj/h0XyNLCA4ifODzdPPSbqfDpLQEduqhRhEWHi3nh7
	 yfGWhAaFerxjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: compress: fix buffer leak on failed SET_PARAMS
Date: Wed, 11 Nov 2026 17:12:57 -0500
Message-ID: <20261111221216.4110920-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060836-failed-5.15-fbc74ca9fbf7@kernel.org>
References: <20261107060836-failed-5.15-fbc74ca9fbf7@kernel.org>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit fbc74ca9fbf7e0b8f6872ccac62f9f4a1f3b5e53 ]

When the driver has neither ops->copy nor a preallocated dma_buffer_p,
snd_compr_allocate_buffer() kmallocs runtime->buffer. If
ops->set_params() then rejects the parameters, SET_PARAMS fails, the
stream stays in the OPEN state and keeps the buffer. The next
SET_PARAMS allocates a new buffer and overwrites the pointer, so
repeated SET_PARAMS calls with parameters that the driver rejects leak
one buffer per call.

Release the framework-owned buffer when ops->set_params() fails on an
OPEN stream, so that a failed SET_PARAMS leaves no buffer behind and
the buffer is allocated only once per successful setup. Use the same
ownership check as snd_compr_free().

Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20261019144533.30665-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ sashal: retained goto out instead of return retval to preserve explicit params cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/compress_offload.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 6b7e51e8f663c..2d7567810029e 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -602,8 +602,15 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 		}
 
 		retval = stream->ops->set_params(stream, params);
-		if (retval)
+		if (retval) {
+			/* the stream stays OPEN: drop the buffer of the rejected setup */
+			if (stream->runtime->state == SNDRV_PCM_STATE_OPEN &&
+			    !stream->runtime->dma_buffer_p) {
+				kfree(stream->runtime->buffer);
+				stream->runtime->buffer = NULL;
+			}
 			goto out;
+		}
 
 		stream->metadata_set = false;
 		stream->next_track = false;
-- 
2.53.0

