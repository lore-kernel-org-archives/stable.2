Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047227;
	b=rPfpWcTcvtOacYeJu134PpqsOV40xpwIQr5y+VISqB4IsRV6Q4PEW8nflsELgCb1WsCI
	 0J+p4Ti5+vopmqSGA/tlu6ILTDYOjUSOI0wePmfEE8uR6reBqgMOcVyEXP4+l0I6cKw09
	 3X0ECPeM0Boj0RDDLjFrL3y6+BVtdNsWdGmIi3JTkCVaedCPceQwHs2i7igTxICUfERVB
	 AKVKReoToykIy8VIGRdhGdd75OWWRDcYN6/p/kYR8L0gCf97eooye7mmSYH8he0GNGMaS
	 tPG5TRqW+pzTa5MntrTBtTyZiPursQLZe8U+HXXFD84LIUsGG3RWgbTIktPQOkPmpvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047227;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4KorWnTwP/msbEuuzc0dbDOl41YIEdts92mQTwpA3qg=;
	b=bVjBjLhMCR93664Z1lLxiXld1Zedpf2unbiL7Rw3WjVhIpbO/2T4nUEdDwhgh6Zix495
	 HRalAyLtg0q/EumiOXHEmZfZmwb1crksgiEu+H4w54Ij+MUNvmp/j4W7cOUQ7v55w1YPZ
	 oQ/5Vd8BA8RLbfwTLhv3Ac/a/TOZhXDXvSpC7nPEk3MftUFYU9SruKjHyAI1QYBE0/Pt7
	 gh/aBjbNUZ/zSzIThyPnuSUo4UZyhVg3hGV5h0bH2bn2PISG+uhzpF685YaBVRgTQCpBV
	 T3WuPzcBayQ67P3oR67fnhePuwHIygSjAd/seBQ2pvbNIXLweu5kz8ExdHJbFX2NKxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbbaY1g8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85650606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbbaY1g8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010721F008A1;
	Sat,  7 Nov 2026 10:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047227;
	bh=4KorWnTwP/msbEuuzc0dbDOl41YIEdts92mQTwpA3qg=;
	h=From:To:Cc:Subject:Date;
	b=nbbaY1g85cfqRjUPQ6x1hyN9kgaiE5X2kxg9HblF4g3iog0WI7coQ1tahym1Mxsnx
	 xLZeMB1C9q9o62eb1HUppFnPeiCwOudeVcKooUE6mib3LO6hZA9A+X9N9H3m8/5gYC
	 BvT7pE+X7TaBzohUVaJKtljpQhplPhAbYPq5KW3DM8xE6QitvX6+lLbb4/iSxnI7JQ
	 l4HhqyT0xpY0U+kOI1YdEBvyAIyAb+wABipwdlD2LhATaMCTR146qXxSfKl+2J9GS4
	 cAuKH8fIgACxcxkpqkhJbqxJZ39sOEDE8tj3QZ92RreLnEta04tqeDsu1joEpT6XYR
	 6xLVb9/iBOFAQ==
From: Sasha Levin <sashal@kernel.org>
To: enscrpt@pm.me,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: ua101: Bound packet copies by the PCM buffer size" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:05 -0500
Message-ID: <20261107052705-failed-6.12-493a77a9f20f@kernel.org>
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
git cherry-pick -x 493a77a9f20fca07ca5654f61c1b03bef035df25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052705-failed-6.12-493a77a9f20f@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 493a77a9f20fca07ca5654f61c1b03bef035df25 Mon Sep 17 00:00:00 2001
From: Sinan Turunc <enscrpt@pm.me>
Date: Mon, 26 Oct 2026 22:36:47 +0000
Subject: [PATCH] ALSA: ua101: Bound packet copies by the PCM buffer size

copy_capture_data() and copy_playback_data() wrap the ring buffer
position once and split the memcpy() in two at the buffer end, which is
only correct when one packet holds at most buffer_size frames. The
capture packet size is the device's (actual_length up to wMaxPacketSize,
divided by 3 * bNrChannels from its own descriptor), the playback packet
size is taken from the capture packets, and set_stream_hw() lets the
PCM client pick period_bytes_min 1, periods_min 2 and a period time of
1.5 packet intervals: 9 frames at 44.1 kHz high speed, an 18-frame
buffer. A device sending 672-byte mono 24-bit packets delivers 224
frames per packet.

After the first packet buffer_pos is 206 and stays beyond buffer_size.
On the next packet frames1 = buffer_size - buffer_pos wraps and memcpy()
runs away:

  snd-ua101 2-1:1.0: invalid position: , pos = 206, buffer size = 18,
period size = 9
  BUG: KASAN: slab-out-of-bounds in capture_urb_complete+0x9eb/0xcb0
  Read of size 4294966732 at addr ffff88800d73e7e0 by task vhci_rx/81

and for playback:

  BUG: KASAN: vmalloc-out-of-bounds in playback_work+0x789/0xac0
  Read of size 4294966732 at addr ffffc9000002626a by task kworker/0:1H/80

Clamp the capture copy to buffer_size. On playback, copy at most one
buffer and fill the rest of the packet with silence, so the URB length,
the delay accounting and the data sent stay consistent. With that bound
the single wrap and both memcpy() halves stay inside the buffer. A
device whose packets do not fit the buffer never played correctly
anyway.

Reproduced on 7.3-rc7 with a USB/IP device presenting the UA-101
interface layout and a 672-byte isochronous endpoint.

Fixes: 63978ab3e3e9 ("sound: add Edirol UA-101 support")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20261026223543.620-3-enscrpt@pm.me
---
 sound/usb/misc/ua101.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 58d8a3cdc8b98..bd8e0ed0ba5d6 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -285,13 +285,29 @@ static void playback_work(struct work_struct *work)
 			/* fill packet with data or silence */
 			urb->iso_frame_desc[0].length =
 				frames * ua->playback.frame_bytes;
-			if (test_bit(ALSA_PLAYBACK_RUNNING, &ua->states))
+			if (test_bit(ALSA_PLAYBACK_RUNNING, &ua->states)) {
+				/*
+				 * The packet size comes from the capture stream,
+				 * i.e. from the device, while the ring buffer can
+				 * be as small as two tiny periods. The single wrap
+				 * in copy_playback_data() is only valid for
+				 * frames <= buffer_size, so copy at most one
+				 * buffer and send silence for the rest.
+				 */
+				unsigned int copy_frames = min(frames,
+					ua->playback.substream->runtime->buffer_size);
+
 				do_period_elapsed |= copy_playback_data(&ua->playback,
 									urb,
-									frames);
-			else
+									copy_frames);
+				memset(urb->transfer_buffer +
+				       copy_frames * ua->playback.frame_bytes, 0,
+				       (frames - copy_frames) *
+				       ua->playback.frame_bytes);
+			} else {
 				memset(urb->transfer_buffer, 0,
 				       urb->iso_frame_desc[0].length);
+			}
 
 			/* and off you go ... */
 			err = usb_submit_urb(urb, GFP_ATOMIC);
@@ -320,6 +336,13 @@ static bool copy_capture_data(struct ua101_stream *stream, struct urb *urb,
 
 	runtime = stream->substream->runtime;
 	frame_bytes = stream->frame_bytes;
+	/*
+	 * A packet can carry up to max_packet_bytes, the device's
+	 * wMaxPacketSize, which may exceed the whole ring buffer; keep what
+	 * fits so the single wrap below stays valid.
+	 */
+	if (unlikely(frames > runtime->buffer_size))
+		frames = runtime->buffer_size;
 	dest = runtime->dma_area + stream->buffer_pos * frame_bytes;
 	if (stream->buffer_pos + frames <= runtime->buffer_size) {
 		memcpy(dest, urb->transfer_buffer, frames * frame_bytes);
-- 
2.53.0




