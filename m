Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435033;
	b=rScnUXfaCO+c2GzWl4zIoP4Y+fhg/MHlREDvXT5FPgqY7oPSlHkxVKd5ownhADIQS7p6
	 Ap1Iqmote/Oeztl6xrX6/KT8gR4mfFQ+8iWp0yEJyzwMEqiaPtAXkekZOXneDt83p7LMz
	 C8nNxS2oYGUwnHIoj1My5J/B/BLk5jbmHgIlgV4zMfkZ0AT4YlNfl6Algvv8dRkOmQenT
	 EeBohK3OiUIURx5Psb/PciEKSWrTqPL72JFWc/H/Cycb7/v0iN7yBjVZAgi/nT+CX9xHA
	 jx3Iv4DxP0pxb/tEk1Q5gL9hctGFyDt/NKV8Y0igxM6wPZrnyLRV2FQ/qk2yuTQPU4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435033;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XeYtU7evxFmoujUqbxGKy+XN/ElLZ+enBlozjkshd0E=;
	b=2dXm/5jkg7N/s+4dFKG0dospveG1r6PMtQSL2Q2sLhQzv+ESRHaN/Pag75pw15ad6ksQ
	 sJGj/fxD/q1IJp13kbwYERzjCjNT53GvBwt1AGRZqKViW490s/28XthAOAJmfJ3vW5mCN
	 EAQs438ODKIGC2NPii3X4mcI6EeKvSOzvhg5KkJk1nZXxb+UJUBcG8RXT/MHQC3epVbb9
	 1bCRi8RSmyItayevauoHRprgBop/Rj3OKBadcq7kuRNSraH6iJycMXAUfkmcfFIbwrS9J
	 7pQae03HB8/SDlcvZJe0EJZqBhL4ol1b8NHLUT9z9BjzLMjY1n9FwJybahMi76eh8Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7KM9o9C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4F606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7KM9o9C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0731F00A06;
	Wed, 11 Nov 2026 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435033;
	bh=XeYtU7evxFmoujUqbxGKy+XN/ElLZ+enBlozjkshd0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z7KM9o9C7EOMiD+VhwRCA4y65RNEzazj70K9pxwRzzWHvBxwF+lcsovsDBVT42qTh
	 X1X3d2iIJHatW7n7LGXRnhFF0TCrE/2V65TdKSX78Ae2sIDvawL0QZU7ppM0SuPOVg
	 Yun6t0ZMc8ym9KzktJ7j0Usm1s+wnNJgFcYpdGsQVC/ExVimDASaexJ4lev6PMHuzs
	 165KSQQlOMz4AHh2eWHhbdxUyuxEDHNSpfsBzmcp87ZK2FVb/TzgEutOr2IS8dSFbC
	 MT5uJ8n5FhHB4gHwgYc+W7D7Va7/Ie8o4Ic2NnfoiNfadenu/fd2u06a8rLVXONGE3
	 tr3Lme8mB/jEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: compress: fix buffer leak on failed SET_PARAMS
Date: Wed, 11 Nov 2026 17:10:31 -0500
Message-ID: <20261111221003.4126162-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062525-failed-5.10-fbc74ca9fbf7@kernel.org>
References: <20261107062525-failed-5.10-fbc74ca9fbf7@kernel.org>
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
[ sashal: adapted the error exit from return retval to goto out to use the existing cleanup path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/compress_offload.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index d43bfe5623e99..bd1031bf987eb 100644
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

