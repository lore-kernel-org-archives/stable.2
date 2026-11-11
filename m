Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368128;
	b=eDoRIKH2v0oYFAAIJXI1GAsrnTepU821NZ/VceixcgTGumYV5blBd3ZeEcnXeTuFhuyW
	 WBygV1NKoPgA3+/k8RleJtplQqeMNhv/A6oMDu9NOiwlOnMPBWhVPOWjlJUObYJy+AUmq
	 dMVeC7MAKS19jEqhj9YVjasXkIy/3aHz1T4tPIhdoBHule6z77qglep/AFk7N/Tzg1GFR
	 0bnVLj1zNTMi4mYbJHNPZrngYUoNjwBxuqmZ/RSg8tesdud+vQlP2LXGFYJMYAOsQt4We
	 JquGT4WXO+d4Q3Tdg7lOf4YGnlwQm8JNb/2C7iRqmaMDm+XSYAuKqq9Q2iJuY7oMXFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2g7SG2smr4pRrP7EXvCRBa6rrf0MPZodJGXQTseuMGQ=;
	b=PSnps0v7Muc3YBai0HxHK+4NF1SvcfRgCMOr6gmYYOTUngurVkIT7zoI6FVioKU1pkNV
	 pC6caIG1FXh42lo0t/Th1JEQBtc3E0WmTUN2xiVtrKsB10CtVz1qdf/DQ+aK5mFZZ9tAs
	 z3/HDb3S0INGhLq2fnEW18N5S91wLA2Q8yIHzNI/fWiM/iwfOjDrNut83BpD2RkAqSznP
	 U9Bwpp0+VXPNZxi+9dIvApryxzjngC7kGDo7vovuLTPip5MsL+kRMhLiCZk4cWy0nD41S
	 zBBJYDU/22Vs/zVnHXQyul1rArd+lKuKBL/8T3qAFywvK2cMNXkATyijUMUPF1IVbRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=do1nVNsy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73586606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=do1nVNsy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817FC1F0089F;
	Wed, 11 Nov 2026 03:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368128;
	bh=2g7SG2smr4pRrP7EXvCRBa6rrf0MPZodJGXQTseuMGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=do1nVNsyVGcZ6MYEYBjtJJyrqXWw55uTNWd1ZytUUA/4xbP8ZrSzXhcPN9jp2S15z
	 HLuXkl9wU3DXKDpm6BFJS5oE34XSiSl2kQ5g9ERmGShXH54LEBy2470dWJmCmti8UU
	 f/yg6PldjYJ5XX0sl6+mjIEUh50DPvGOyFbqVXKvPOH3UezN7khqkwn86lELWRflP8
	 5Z/YEE92i1lXyVMVGYur0GMNR0uWQFqtaUVcFDTNJE2hiZwuSAPRQXQmNJRUztSB0f
	 pz3CUP7JJwaDFRS0nW15h/3JhNBWfdAo5RyOPFih26rIqeiQPqe0VJ0m1X+rPJBRVZ
	 5IXnEXIT/TWSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sinan Turunc <enscrpt@pm.me>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: usb-audio: Bound packet copies by the PCM buffer size
Date: Tue, 10 Nov 2026 22:35:26 -0500
Message-ID: <20261111033447.922894-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052703-failed-6.12-06be918062ad@kernel.org>
References: <20261107052703-failed-6.12-06be918062ad@kernel.org>
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
[ sashal: Adjusted playback hunk indentation to fit existing explicit locking instead of scoped_guard. ]
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

