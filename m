Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369684;
	b=xvqqxoeJzTn56uOEC0eLyRmcNy7hPe2nhJrpAkOwp+RJ2qSMFvrv1SIzLsvcPwEV8czg
	 rOC+DHqp25KYBjEKB8NhURUwSJD0dzuD0gFE9h4kpZ6s85LZXVpBIf/VBoiB6Gvdx1J3+
	 5zeBJ0U4vwoNATL00iJ0dbikvmIonBQsPhNVI2gKAUy1gk3/SLCRjLsyjxbhcxGF9+LBA
	 BPmdsBpBXrCBU1NsRMZrmL/qdJIhNmybeXKVX0odezZ9FE3cbLR42I6azbMB/0214T2XO
	 CDDgBCUaibt4OucNuQAcDpl8zWGINBQn6k8ebm92qVThVoZRufSQ9MuoBiZ7mVXkTUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369684;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J07IkmirLsFUQkkNriM2aGVqXZNRX/3/ujBseBrSD+M=;
	b=N17kYZcwSKko/4tWv+nEfJ+4RYKIgORb2Cmn0ABDsez40xYwk9eJhnflaufzFq6TEXrA
	 0fFTHrQhFPgnL5HU9gUOQZPlCV5lL6bWd+miCd3zZQmYu64j+rNjMP99USQ4cI0T40Vom
	 /BgdNh7/Iu1VubUbKz2vltLCaCBWETyaB/Hym9R8JX4Fof5Mv1jCNICqudirX7+YzuQzW
	 3WrmMX/B3vAoGIFt97iFmbXkD2hyqjQJQ6n2V1UcND47UyHrE6RiY1gmUcHomcT2VthFP
	 2mRhnTUNbopk/F25Og3iqji01w5uBuzQ36QCjPzRQfPiOmbYEa74UCMo59whw4Y3L4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccxhw2kV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9B606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccxhw2kV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661C91F0089F;
	Wed, 11 Nov 2026 04:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794369683;
	bh=J07IkmirLsFUQkkNriM2aGVqXZNRX/3/ujBseBrSD+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ccxhw2kVZ9BEtPb17q+2UkpOWUT7kgb30YInrkPUw3JKzmp9YfIh4KjXppdCe5/if
	 nbWd0LHebdBXWIc08BhVItNJVVe1Z0/WURUhbW50+R9PAgPuNx+G0Naz7hN4Vl/VIk
	 PVfyg1561fNtBANtrlcMU9lCBK8+7tAohVXhRGUQymjHmJ7hMsP6nKW6ZyZK8D1/AJ
	 C4lUfpVNQ84cCnNQe81mx1QxiBQlBD040DlM5kYG0eMEf4MR2hqMhHvMHLN0HZa+3c
	 awGem4MVZgsu2XDGXNnw1ExspbaRH+V4H5OIwNeKe2q9X9yu04UCwu/tmxgTOrjsrq
	 tr678mQ8Fqbhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sinan Turunc <enscrpt@pm.me>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: usb-audio: Bound packet copies by the PCM buffer size
Date: Tue, 10 Nov 2026 23:01:22 -0500
Message-ID: <20261111040046.1014701-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061244-failed-5.15-06be918062ad@kernel.org>
References: <20261107061244-failed-5.15-06be918062ad@kernel.org>
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

From: Sinan Turunc <enscrpt@pm.me>

[ Upstream commit 06be918062adc1a5a76dc346803b136b20bdb5ae ]

retire_capture_urb() and prepare_playback_urb() assume that one USB
packet never carries more data than the whole ALSA ring buffer. Nothing
enforces that: the packet size comes from the device (wMaxPacketSize,
and curpacksize == maxpacksize when the class-specific endpoint
descriptor sets MaxPacketsOnly), while the PCM hardware constraints only
require 64-byte periods, two periods and a period time of one data
interval. An 8 kHz mono U8 stream on a 128-byte buffer is legal, and a
full-speed device can send 1023-byte packets into it.

On the first oversized packet hwptr_done is wrapped once and stays
beyond buffer_bytes (895 for 1023 bytes into 128). On the next packet
the wrap arithmetic in the copy path computes

    bytes1 = subs->buffer_bytes - oldptr

with oldptr > buffer_bytes, so bytes1 wraps to about 4 GB and memcpy()
runs off the end of the URB buffer and of the vmalloc'd DMA buffer:

  BUG: KASAN: slab-out-of-bounds in retire_capture_urb+0x251/0x870
  Read of size 4294966529 at addr ffff88800c1e2800 by task vhci_rx/82

and for playback, where copy_to_urb() has the same shape:

  BUG: KASAN: vmalloc-out-of-bounds in copy_to_urb.isra.0+0x188/0x430
  Read of size 4294966529 at addr ffffc9000004537f by task vhci_rx/79
   prepare_playback_urb+0x98a/0x1fc0

Truncate an oversized capture packet to the buffer size, and stop
filling a playback URB once it holds a whole buffer. With bytes <=
buffer_bytes the single wrap of hwptr_done and the two-part memcpy()
in both copy paths stay inside the buffer. A device whose packets do
not fit the buffer at all was never going to play correctly anyway.

Reproduced on 7.3-rc7 with a USB/IP device (dummy_hcd cannot carry
isochronous data) advertising a UAC1 endpoint with MaxPacketsOnly and
wMaxPacketSize 1023, and a PCM client using period_size 64, periods 2.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20261026223543.620-2-enscrpt@pm.me
[ sashal: added the missing ctx->buffer_size check that was already present upstream ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/pcm.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 737302cfede8f..2f3fadeeb3a38 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1228,6 +1228,18 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
 			bytes -= adj;
 			subs->stream_offset_adj -= adj;
 		}
+		/*
+		 * A packet can be as large as the endpoint's maxpacksize, which
+		 * the device chooses, while the ring buffer can be as small as
+		 * two 64-byte periods. The hwptr_done wrap below handles one
+		 * wrap only, so never take more than one buffer from a packet.
+		 */
+		if (unlikely(bytes > subs->buffer_bytes)) {
+			dev_warn_ratelimited(&subs->dev->dev,
+					     "%u-byte packet exceeds %u-byte buffer, truncating\n",
+					     bytes, subs->buffer_bytes);
+			bytes = subs->buffer_bytes;
+		}
 		frames = bytes / stride;
 		if (!subs->txfr_quirk)
 			bytes = frames * stride;
@@ -1441,7 +1453,14 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
 
 	for (i = 0; i < ctx->packets; i++) {
 		counts = snd_usb_endpoint_next_packet_size(ep, ctx, i, avail);
-		if (counts < 0)
+		/*
+		 * Bound by the ring buffer as well as by the URB:
+		 * copy_to_urb() wraps hwptr_done once, so one URB must
+		 * never carry more than the whole buffer.
+		 */
+		if (counts < 0 ||
+		    (frames + counts) * stride > ctx->buffer_size ||
+		    (frames + counts) * stride > subs->buffer_bytes)
 			break;
 		/* set up descriptor */
 		urb->iso_frame_desc[i].offset = frames * stride;
-- 
2.53.0

