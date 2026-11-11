Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434544;
	b=jQ4HcXLgqWBK2ITB/0r7YqZvrdw8ltfXcQ6mf2/ChbE3swZwJLPz3wSRwGfY7T/Jqaw4
	 214wJvmQM0eTPTiqgBYA5t76awtoU8SN2gSqHC5Wt3jI0I6N93Em4XJ8Hv+Pd7Ko4QTHf
	 U8Yk2eHGJOIq+zpknkBa9/JAdbibOSrGnH/MwNq9weWBLDZzt/ZptuA0V8GxYYaQ9bNqS
	 D3Y67yyK2yeoB7q43iA/MqsOAwfaGac6h78JW8oaKW422M0QWMz8KmsU3W0urGXv5H7pG
	 aE0LY4W/mgFJ3pyz/x1kvbe6JkXuAM2nYEYDT3wJhPQNEc0n8s0G9qwxilxUcUvkwPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hOzrtG4q5/tX0w62zqy/BzWbKwpaI1M5E7AykvJMh9c=;
	b=U7YlmN8qSweXWe91wWujSXwBAxv5AOQEyiOfzWO4tb6mk+GGZDqUJoBDiqBBNOlybuHk
	 J1cDnDS10efi8Oaq0gQ1JCKfEsuR9oe3Tf2Az79B/tYFqs+PBsMbcsJ9iICASkIRAT9DE
	 xkwJe2gGJ88//0za7LWWdiByvv3SwOg1ipke4Bdo8dTKlhHAYPcrq3iIywewi1K56oBpp
	 7jImULc8eydyrMaW2MI6Mh6SdDk3YxhGmV+TLnvlSe9al6tWbgICiC832gwm7LOKJyDRo
	 TtYLvskxrCxdU4WvE8fS5wwSxD+A9FhN2AaIbfkFlowe7ax6MGCOs3dxlnwAbm+GPdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MON46sBr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BF606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MON46sBr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567C01F00A05;
	Wed, 11 Nov 2026 22:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434543;
	bh=hOzrtG4q5/tX0w62zqy/BzWbKwpaI1M5E7AykvJMh9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MON46sBrgheAnxGthE2i7NQdTWVv7Jks46L7ibL/f81w3E1PUVlkpv4/VO1vcvxRD
	 RFeVGGOeeYCak8e32lVljZ9vil1k788phJAiTr5vsgXjh+kcWsywSjhwdJGKpbXEzS
	 ZGBRM3mHeJ3HL1iNvWNh+ObenwfhJHdYllICwS2MdpEY/EIfmzulOt8ShVZ91B70jG
	 xO2q65ug9TlSOKY4GxxZ/LGksqdqU5CqqVyBcwn8koeFMPGxadcEUXJHTCMpHbS4+B
	 ERLZZkUMh1w757OdDSHIJbDtpJzKGk+tgLw/DaAPOkCXg6BqzQWzwlgq37FnkiLJSo
	 gdocMBV9StD3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: compress: fix buffer leak on failed SET_PARAMS
Date: Wed, 11 Nov 2026 17:02:22 -0500
Message-ID: <20261111220158.4082507-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053648-failed-6.6-fbc74ca9fbf7@kernel.org>
References: <20261107053648-failed-6.6-fbc74ca9fbf7@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261111011417.365858-1-sashal@kernel.org>

 sound/core/compress_offload.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index b7c0ff1b9b5a1..79a10e258c51b 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -607,8 +607,15 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
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
 			return retval;
+		}
 
 		if (stream->next_track)
 			return retval;
-- 
2.53.0

