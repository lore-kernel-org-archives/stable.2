Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047993;
	b=l1nrPmot9PYSPQIixzW4hNtBABaCg0SJG/t53Kmh37N7VMpR9h5Q/kcEAepn6GJLg+07
	 KnPxyqxQx1KoUPAhydFwauSHlYzSRl2BouLwcRyccAndEwjRpk5bDsvL36Wa2SjFyvlFf
	 t9t7UpijzAWbitpimJZBzLiMV5KP6yRXhx8o/deY2I7zdF4T2odtyF3BwlPsJ/FeJFUsW
	 5+1hbrgANMIk40k017dkCjSizC/TRcFdH96D8ZgWl2HPOna2xuueoMNE/psTmDFgdWkvV
	 rOuRygXy6GIpkGhejjidmUXEwNO9B4m8XltJBXC1DbLeLXzSx+tIaTMB1nn90xoSrZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047993;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KnSPLS7ij/Pg8osu2isDu34JcCiL96k6Dzkfotr+nCU=;
	b=A4o++F4QNY9G6P/Uv8zD7XpmMTRU2XSQ012lakUYiGqQkzP5s6pYkFi8k4gqE1W9saTw
	 CZQ8oMRmuPrdQ156m3yzvCXE+5MTwkyE0H2ICiXgA1ObqqMdqdQztikAREQCfIsH4C2sW
	 f4XQk4bDbt3PIg38qF4LWHIRwkA9Dn2ivfTYvIn+Rg+lANLjCJ0oww9scs2zol1TYTHUe
	 7de6m26PiuxmoFeRd4MXrwF/2S8qWaszCwEYYj6UZ+iNu8If5wDw+21vQK+cVRZXBSMvE
	 9XeOUHBGvT0UMwEpKMIN8hz4kmT4/MRyKtcOBLhKaA9qmAjYFM4fyS7hWQrPxwK5xdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1qG9ac5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1qG9ac5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106A91F0089F;
	Sat,  7 Nov 2026 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047992;
	bh=KnSPLS7ij/Pg8osu2isDu34JcCiL96k6Dzkfotr+nCU=;
	h=From:To:Cc:Subject:Date;
	b=a1qG9ac5Zzm47DNGJvpe7oKQBJo9sc2BnKv/besJS4iuGrj+JUmSVeBcHsexSsF3V
	 hFzkJMpNogcQUKZ66F8wcP0oz0LzzRmL3z8kEu/HMRsmEmvHTJ1nUU59jpz4TlOUQV
	 wtLOoj8VHBzRz5+cZra4H+wbqOWaYmie55OQ1V+SFU5krPqs2HWqeVn2cjuD5/SSQQ
	 5NcFbPkuJrsvIbqjapA7eYd/5Cx/mfXhD6R7ZcAL6mkOB7V5we0TXHHQJgCr6gttQx
	 Dv0kAPkXGUjdlmVUb09HdH63RKzbYgxexV/Zb5JFpJdY3NN9xV5cP7ajl6Sem/GgdV
	 tlbcXJFFZat3A==
From: Sasha Levin <sashal@kernel.org>
To: enscrpt@pm.me,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Bound packet copies by the PCM buffer size" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:51 -0500
Message-ID: <20261107053950-failed-6.6-06be918062ad@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 06be918062adc1a5a76dc346803b136b20bdb5ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053950-failed-6.6-06be918062ad@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




