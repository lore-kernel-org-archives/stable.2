Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368722;
	b=tLdRtq2f/Qpn6drY8qWwOAc2+YsPSz7Pugy6EFCS6wdZHuUckOWtJpqiNkYPyya/vVVC
	 r1UptzHY9d5eAXPMEwqpclobjEfZGAaodLqPmsLEkgfc5sMuaSY6nw8tpHECB1i3IOXBv
	 1HRamPte2LtaSXdziuB2QECteWAPVONrjW1HdWcbCX9EVDvQZ/JvZlkF0HZjstakE10S9
	 KYzgiEMLym0jrYhLRsxhhWAbVAEgaOTxgJtInIzroD+oKJUO2XY/F2Z19TYu17MAyqMz0
	 MBMKTN8IRloNU5MG9Atf/3KvGQrEsFEVyJ+hiZA4Eca8qSzEpTWiUJUTYb1HLsxXa3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368722;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hCdFUuKsMdbqI944gaV7REvXuKJMX+pSS6YGKbQ742U=;
	b=I0I0la9/S0gj2/HA7Sw5y5bPMhCLg1P41XRMBRpPvM/cgslOIgAAOdz4gYesNrjNMDfZ
	 Il4l0h2h0NXdtpBEa4cqsg0GRlhPFa4Vc90/E6D0NGjTVCVttTAuMxLYE4ZPhj4b30Y7g
	 xCCVjsDqCKeNYwUYRqBG0u2HlyzY7fIhEQ3dZe6JrzamSYJnebILfvQuJwIyqfDDuGUHy
	 ib9/tg5wSsUjKnmwdGNojvJtDn7bg+cav9JHhkV7gncLCHrotRHH+iLhsJfPrfK1DtR8i
	 62mDbZF6DH3qzEcqtvhEbdjC9PindcdRmlJf247aB6MSclQ0x5lWVJKkjPmECFh4uGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBwjquVd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1A5606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBwjquVd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015D91F0089F;
	Wed, 11 Nov 2026 03:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368722;
	bh=hCdFUuKsMdbqI944gaV7REvXuKJMX+pSS6YGKbQ742U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OBwjquVdvm8khJEJt1kyKRMEE8n9f5oB2oSyE2K7LYapmSpsViQCVK7AvLz6z1vhl
	 63IQXgNUJ+nUPISkANuFltDgkBAr2E/yui8D9+HSQevyyQp0ysr44NZOIKg9quugSe
	 zrJRTxo5xBHZLtkOAOhEDEc7N2m+Ns9aQCe8w+cJtkPDd53SkTX4DQsUae1Py/NozP
	 bT5pYK5LBV3irgKkX3sV5LkPo+vqR6A8MqgQ1OvlbSRr6KtijQ+fmnA0MhiQJ0G0Ec
	 nNDTJCaTMVM20Isur2+/TwsanimGbcswjIEeBRL/8hESGzmMN5cQsuoUXSav4BMDKt
	 4RlrxFlNLwoUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sinan Turunc <enscrpt@pm.me>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: usb-audio: Bound packet copies by the PCM buffer size
Date: Tue, 10 Nov 2026 22:45:20 -0500
Message-ID: <20261111034330.986321-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055545-failed-6.1-06be918062ad@kernel.org>
References: <20261107055545-failed-6.1-06be918062ad@kernel.org>
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
[ sashal: adjusted indentation to match the existing loop in prepare_playback_urb() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/pcm.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 17e539b1fdb4c..771ed7e63a55c 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1248,6 +1248,18 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
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
@@ -1461,8 +1473,14 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
 
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

