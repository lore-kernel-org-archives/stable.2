Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434859;
	b=HfdP/CKtZbiaj+LAgKKRDhNBNJyo0Zfd9kSHgXKPtXSsAPM81gmL79Z2EFKrqYI8HQ3u
	 A2M6m/8u1gI9B+Q+wM4vNuPNY/S4DEd3JKVX4oQ0sz4m2AsM7YGPkAB9v1ceS+yqLdHOF
	 GCehiY4y9LansiUQUes5iL+D/vPbwMF0IBZqfBfTr9azJ9fhGAgUveL5jHTdqRhMjXdY6
	 a5ztu7nmlzC6AVRAZwgWr5lWIS+7kSd2OS+pn8NIBeyxw23oi2XCMV7ULzLe7mfzNq2Kz
	 zXVTIXAjTv8WyyqLN6KuUB+3j4AOH7GhahhqsAf6xp7NA8Ke/rQEHMwEPlx/j0xT5pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434859;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3qDGkW2OjJFIOcxWFACkjDYLdGgX5aKdiQkAl6PJNA0=;
	b=PC/QfThiigsLVlffSaEUvBvwUIhaNZutfZkRqyaTp5jdltHnpkt3olJEzgIc2L81ZC6l
	 OLE1FKqJQEyp1z7D0e+gfzQP+OhdLWgzmofnJu6DnMK6ohbZHf6M1l7403bl86ktWfLgA
	 a7PGheNZxImBKFbM/FeFuaiIyXBC3aW1RYek7v6tZI+CQB3S14tVwDxcxcwcJAUdx9rOP
	 9YmPNydRYUtIp4d97lq84FNduYER7ezevh2FgYa4rCfJlgckijQkfya8ysc8vkHTKaoGI
	 nhuBzLEj8aStYGGbVBJly2KWbf69OrIOYcES6EwZOP0PWc1zEMSI+HBuWQlghi8Pk8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJa2caZP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116B606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJa2caZP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81D61F00A05;
	Wed, 11 Nov 2026 22:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434858;
	bh=3qDGkW2OjJFIOcxWFACkjDYLdGgX5aKdiQkAl6PJNA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJa2caZP3gHyUZq8pKT4KdADzJtBKA+w4pdp1/IOmRcPukDOTmi7/1YYJGt0z5vwb
	 mQ6H2bvXzeG+krWp8GGznl1S8tuJeFQpRry+D4aVRP3iD7iNCIxiL5JseXp8H+gbrn
	 h3afqmEwW6/2qv4GhgRV/khRqL8DiVoOkswLyyoH3M+krik1sD8qBk99iAdc9kF9mq
	 AvlSu+FTHUuRgdqjVNFoJ8uCxyzHL6HWvi8jriuqoKIL6aC3P9/FZguJQkwC22tKKp
	 SJO6XOLKoxCjLtJz6t6D7Ynfvj0q2aivy09LgtP51v0BdyPgYASZQKJ+ytyCpRr0PB
	 jm642cmdT44TA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: compress: fix buffer leak on failed SET_PARAMS
Date: Wed, 11 Nov 2026 17:07:36 -0500
Message-ID: <20261111220710.4083903-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055123-failed-6.1-fbc74ca9fbf7@kernel.org>
References: <20261107055123-failed-6.1-fbc74ca9fbf7@kernel.org>
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
[ sashal: Retained goto out instead of a direct return to preserve explicit params cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/compress_offload.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index e961d79f076bb..08289fe8d5519 100644
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

