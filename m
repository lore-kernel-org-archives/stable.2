Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370483;
	b=g5OVw8VvfVJX7bFFUY23G5HMtL+jM0haB0JEAqj1C3xhmEFy1c8mknZBZEGa2DoNcZhy
	 ZawsLXxaR8D58rfcDxMi+f/4dla0Wyvpz7luxaR2SXUzyuB+TiRh+Pd3Ie9GPUbB+MLy+
	 gfbZNB+q/wyYl6p8KedJsix2xyWPWeojh4iMWZtjqnyctauX0Vbp9MQ5wJaY0oLAhL/8c
	 8Gi6UdBznHFph3ZfS1Z6n17VY4U3ok/9TGGvItjwX8eBLBA5eB1/ITWCO94aA0UkzQhcb
	 b8QA4f2p8eZDDCP0pZpJ8P7UlZkDPY2ZFMoOedyCXRHwA6xXwCXiV9b1J//p0qcN3dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370483;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wBjk+nfF44wjTbUE/FnokHdumY3TmR9a4WES24etNCM=;
	b=j7yFn+l/Jh8bSXRLVKsKjTY+2MUlUG1aUToVNU6jFQlRyjU5MCgftFgvRBs9RNduh/ve
	 ylM54lw9k0k9NcaXy0HAu2IXNHgtLzqi+BpFcNoE5Xk3MN99OZys1yhBQY40ZP8C4MzdW
	 mocQySc+yc1mHVfZsA6VNNrXNu6kQTRLGICMXelM93MsOJ2nM9bzgM4ZVEMbM0eduXxGM
	 G23jQ+5UVIHzHRWth3u+auIkbI0vnQIV696YnZl7UfUhbwM2i0ayI4jPyNVZk+W3pF/kH
	 9zWyQBMHEVvjj8C9raO55y4QsAULg6BIiT8gl0IDtQkyQ+sDg+dFCMHuABghhkzHXrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRBleGai;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC98606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRBleGai
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37BF1F0089F;
	Wed, 11 Nov 2026 04:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370483;
	bh=wBjk+nfF44wjTbUE/FnokHdumY3TmR9a4WES24etNCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kRBleGaikD5ehqFZHs7ExgKNDTUKrUUbxdtNYn4bgyUcpU5/Rq0zC0t6/bzT3Km3C
	 vXBfJnvieTMUGz2ukSVqL1CZif0SdRrT0613OsgiISwedLR6qpvj0bm0GCE6CNYNPa
	 uhOL+NOld8vOnTijydbLs9uU8yB7TXoJLSg7PS49RlZQG16XEyKNtu9S+vbzJbBj9S
	 FD3DKYqv2swMeCA+ZlgHk9rLlC0HP05Kw6XJAnb6y6KA+2rcxwdrciXQ8lFjjc+ezK
	 rZlEZ+PxFYmSdFdnYrUQ+x5zuhAC8y5fKju0mdVLSGG5yEE4rY9fshzP+NlPypiL9I
	 I72Yu6NHlH8Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sinan Turunc <enscrpt@pm.me>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: usb-audio: Bound packet copies by the PCM buffer size
Date: Tue, 10 Nov 2026 23:14:41 -0500
Message-ID: <20261111041410.1055810-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062947-failed-5.10-06be918062ad@kernel.org>
References: <20261107062947-failed-5.10-06be918062ad@kernel.org>
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
[ sashal: replaced missing subs->buffer_bytes with runtime->buffer_size * stride ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/pcm.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 802ed1dbd23b0..82cfa3f75d530 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1438,6 +1438,18 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
 			bytes -= adj;
 			subs->stream_offset_adj -= adj;
 		}
+		/*
+		 * A packet can be as large as the endpoint's maxpacksize, which
+		 * the device chooses, while the ring buffer can be as small as
+		 * two 64-byte periods. The hwptr_done wrap below handles one
+		 * wrap only, so never take more than one buffer from a packet.
+		 */
+		if (unlikely(bytes > runtime->buffer_size * stride)) {
+			dev_warn_ratelimited(&subs->dev->dev,
+					     "%u-byte packet exceeds %lu-byte buffer, truncating\n",
+					     bytes, runtime->buffer_size * stride);
+			bytes = runtime->buffer_size * stride;
+		}
 		frames = bytes / stride;
 		if (!subs->txfr_quirk)
 			bytes = frames * stride;
@@ -1614,6 +1626,14 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 		else
 			counts = snd_usb_endpoint_next_packet_size(ep);
 
+		/*
+		 * Bound by the ring buffer as well as by the URB:
+		 * copy_to_urb() wraps hwptr_done once, so one URB must
+		 * never carry more than the whole buffer.
+		 */
+		if ((frames + counts) * ep->stride > ctx->buffer_size ||
+		    (frames + counts) * ep->stride > runtime->buffer_size * stride)
+			break;
 		/* set up descriptor */
 		urb->iso_frame_desc[i].offset = frames * ep->stride;
 		urb->iso_frame_desc[i].length = counts * ep->stride;
-- 
2.53.0

