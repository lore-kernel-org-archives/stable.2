Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047226;
	b=KjYIsYBTtx+CYYAZBTZ/h+nI0MGqtx20at4LJI3XreEjT/5LSaWPu59Eb3MYGHJJMdtO
	 SiXrVE79g8pPxS/xKAVPt0oQxg6/mW2WQnjMg5wxINRDvAHEjkUyz3ksokg0McYaJp180
	 UlM/ZnPg73BvbBTrzRQxZe9Q0JoQFHukJH2RIj6p4HcU6pl145G675LwYvDRfWtt0EoLb
	 r2HXYb3hli6RXs0dUm3OfniQIjhbv9qoiA0fUJQdBB9iwPj88oj5oTwnvHtVTnzzEHACg
	 z3ebpbRx11B8PHC2C70MFnATNu+wirEwSbucvmbcEkFtvZwm+uRzsibGpGP8fueiWRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047226;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lxyMBTbAi84bOQYlq/3Z67ixLR4cLdelHC6m4hogwoM=;
	b=1XlvYbOzzonuCriy7BqyCniWYxg4nGa+hwAuB4Tw/uO4T54YVSKHZ2SAhDWfWQSdnjTX
	 9mux+KihbRdN5UahCanxG72/lpWt46LmJCXTZU99v1rmY/pIuPB4WQJiLlMXwRI4AEUhm
	 F58KlfsLTiA5LiELw8NYKryEXgd3kQZmGMYX9/Wd9yXriGRC643wHY5Uj5DMnQAoQipzG
	 wy9YYvzN/hoTJQswRTUsyc1/GmoQzYuGi1avICUN2G7QXsP4Z603FpnG7wsAdtbO4imZE
	 DhMWAFwBBETAL+tCoKj/AVeSLT8I1JdfnNFFP2gLctB0imgs32vxsweqdefoH6YLE4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xvn3jSlW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xvn3jSlW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97291F0089F;
	Sat,  7 Nov 2026 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047225;
	bh=lxyMBTbAi84bOQYlq/3Z67ixLR4cLdelHC6m4hogwoM=;
	h=From:To:Cc:Subject:Date;
	b=Xvn3jSlWBVHaSzfkUgQYwiv+xKgYVr4+cNkrWuJV3Hu4HZ+r0PXIHY79bkSb0WjSi
	 BQnN4UQV4TBEIUyIXQtY8h8PaeNQXnli7mfDQFhafJMVQ7t4QDzh2mrB0xGd+VBxNM
	 DRA2u/qtu2ksqpejK3HN+W2cVDD0NvsSIivWY0zHExzRP1fXW4T13eEcFlwTrIit1B
	 nyl3o6m9JkKZiyF/jkj9ejHv7ZnPdCuM8qw/so+Rz7u/BocHUyHXYS6CRe+aFBI5Cf
	 uhzyf8P3HMUP2e7/3rQgDFxjAT0S33loYDapOzwvLd0inUqHrLikHQ5NB4bBR7pQ4C
	 9J4PmDlYg7/Vw==
From: Sasha Levin <sashal@kernel.org>
To: enscrpt@pm.me,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Bound packet copies by the PCM buffer size" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:03 -0500
Message-ID: <20261107052703-failed-6.12-06be918062ad@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 06be918062adc1a5a76dc346803b136b20bdb5ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052703-failed-6.12-06be918062ad@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 06be918062adc1a5a76dc346803b136b20bdb5ae Mon Sep 17 00:00:00 2001
From: Sinan Turunc <enscrpt@pm.me>
Date: Mon, 26 Oct 2026 22:36:39 +0000
Subject: [PATCH] ALSA: usb-audio: Bound packet copies by the PCM buffer size

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
---
 sound/usb/pcm.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 682b6c1fe76ba..c2f7b08607ac8 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1343,6 +1343,18 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
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
@@ -1553,8 +1565,14 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
 
 		for (i = 0; i < ctx->packets; i++) {
 			counts = snd_usb_endpoint_next_packet_size(ep, ctx, i, avail);
+			/*
+			 * Bound by the ring buffer as well as by the URB:
+			 * copy_to_urb() wraps hwptr_done once, so one URB must
+			 * never carry more than the whole buffer.
+			 */
 			if (counts < 0 ||
-			    (frames + counts) * stride > ctx->buffer_size)
+			    (frames + counts) * stride > ctx->buffer_size ||
+			    (frames + counts) * stride > subs->buffer_bytes)
 				break;
 			/* set up descriptor */
 			urb->iso_frame_desc[i].offset = frames * stride;
-- 
2.53.0




