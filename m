Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368319;
	b=gLBJm/8P0TBE7+BBVbhPI9iTEApYXMUE5wsRTxuLFQypuM/f/iZZViiAj56acR+fmB1l
	 TVpVizIX6t5f3VKxpUagvsBqvUDCENTUq2whGgeeRYBFbvAPztWKJupo6PX0WRI4qZwwp
	 0vmCZo1zeoYSWKbJG+1jRWqfWISxJGyqxn+BTwPfl5VCbALf549DP3acd0RkmG7/xJsSU
	 st6kYc77c7zZC2NRePgs64zM8BEaW1iz1wi8+uVBxz8sMbtpQ3aXPhpZUPV87T0qTVIVI
	 y8v4KXY9z+WUkxQTQBg2jENkPrpcfL28UrlYhkM7oe2nfpXMlZwV81z/MeBg/cjmNpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368319;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R49X/VBakl9eEMcXKuWdU+B6IKouU4hHDaEur8Wuv8U=;
	b=E5JCBI35mgZcWm81UhDGrQ0QFJra3zjjb+4jQ2W1CCpT2NrcSkzTdD0OlwQyIi2Ynpte
	 ffFew890ObqafqoEffQtirKTr5tPk1EuQJweRqFqjIns8WNoclx0QIe81TBgGbB7+kgzr
	 UV2lTKzESK6WI82Ke5+0oRm/oZE0rhDbXMDCGJ+OphnDSdrbDgjgsrIuDKICZsplj+uGv
	 cRryJKGlKTW2GDIhpXRBFD9sYQ/6oSCFis1MhUbMTfwIuFCefCxf2gsq0mynapiRTz41i
	 dywFf0FWqc2ypVoAciE07IFuPtZQpt2DeMI0zdKj3H3L6sR3AnML8pSeBTeKAIJxQ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvPFxUL6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D0606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvPFxUL6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98AF1F0089F;
	Wed, 11 Nov 2026 03:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368319;
	bh=R49X/VBakl9eEMcXKuWdU+B6IKouU4hHDaEur8Wuv8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lvPFxUL6dMvGLMYCKScypapiacC2xiZD2EjSu2Fv1V+L7DTqXoTmWfystGQsDq11u
	 VgXfD8D1/Vt2K5eVPf9dLZqPIu+HZZ7nWq48PzyT5hrx18vkjUKOLZsU1wZrQk5ojW
	 q6I1pg1zNFYC0qXx0obt4rY9lO1TgIWgE1AUEcADOhNvOmdKoQVAb1V/MWWy85UfmW
	 XWz0XfnV5QAxGaw7OiXpkmc9+R01xTEp0qz24JO1e8l5ldSiQU8uwGKnA3Jt2RyHbU
	 ufwbn6uTFYBDdS+PAN/Ogafl5/0zW203UCYciopJ33VPd36PBMol1Iin1uVfQvQKGg
	 8Pjda9Lj9GNsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sinan Turunc <enscrpt@pm.me>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: usb-audio: Bound packet copies by the PCM buffer size
Date: Tue, 10 Nov 2026 22:38:37 -0500
Message-ID: <20261111033812.968109-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053950-failed-6.6-06be918062ad@kernel.org>
References: <20261107053950-failed-6.6-06be918062ad@kernel.org>
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
[ sashal: adjusted indentation to match the less-nested packet loop in prepare_playback_urb() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/pcm.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 5aadd1221f725..dd7554cde865d 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1292,6 +1292,18 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
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
@@ -1505,8 +1517,14 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
 
 	for (i = 0; i < ctx->packets; i++) {
 		counts = snd_usb_endpoint_next_packet_size(ep, ctx, i, avail);
+		/*
+		 * Bound by the ring buffer as well as by the URB:
+		 * copy_to_urb() wraps hwptr_done once, so one URB must
+		 * never carry more than the whole buffer.
+		 */
 		if (counts < 0 ||
-		    (frames + counts) * stride > ctx->buffer_size)
+		    (frames + counts) * stride > ctx->buffer_size ||
+		    (frames + counts) * stride > subs->buffer_bytes)
 			break;
 		/* set up descriptor */
 		urb->iso_frame_desc[i].offset = frames * stride;
-- 
2.53.0

