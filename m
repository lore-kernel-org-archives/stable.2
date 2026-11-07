Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046515;
	b=tDKk6PChaUdRbskSx8xvUFTBM3atRA4KKLt6MOMI0o9gjjpFks4ll6aFj9qn7McYAGBk
	 gW0UOrpFJf6vBfFaE6hkJ8sFHMwpcTmBmzSHdQ0DuxAwaQFotvRtBbg6hxrTi6tuclL5/
	 T3nNSymDwDTJ60vbNLRqeoR0Q42+1w5OFNthyVQUOJ2IDt2LuIy7cO4vGEc0TZh2KuC6E
	 0qRa52LyjBM92YWUWVoAVNyerSTfJzI4y4KggcJtVf1qgeVJxGw6SW9UfD30pHDxWhgzr
	 f2Sf5Gvy99HFqAceEOQ641rZxaRkSc22kt/QfPfZEWbN/0NpyX7M/EO3WEztQ9lmAaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046515;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mJAjfS6H5u+LUwXhhLIJqbnsVUwI5kl+dRywpG2duyU=;
	b=pfC9i+MI38HFBz7R199nSVSdPnDEwPhSKDSklg+L0bm49jYDTrNOj6DXiEW4RFE9d6dh
	 RcK1dD6SqzdPIBPXTb7WCobmimFFqBjkzrXLSJUvKzuiZoQmdhS+LwPhjkxI62P09GPRY
	 Fxf4f4xNS5F/10pUlkzloybrxXbFe93PtSizLTDLJG2YhY5nQvE/bc2KVPRP4hS2uBjX2
	 vfsqafNLfeTrz4PwE6Yiok06IHlUJzRdpZPbydl9b0UKtK2BcQb4H+ZGBwEqbpR0KF5LA
	 mDRC5kjhbe6Q2B+lZBQABYYPNiptLfSmBpaAt+GwuxHEeQYpa7ZPf02oT+ZM5rKqmEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqmc0rfo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqmc0rfo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B09A1F0089F;
	Sat,  7 Nov 2026 10:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046515;
	bh=mJAjfS6H5u+LUwXhhLIJqbnsVUwI5kl+dRywpG2duyU=;
	h=From:To:Cc:Subject:Date;
	b=dqmc0rfo0fLDHXW3jg2gcNDdGhkBaTVIveZJCni3SPoTjIyc7ipahPD53iJHGMiQm
	 y6SEisQVnX0i6Jg8RD5+NlrWL7fvHWRADSH/62oA4DdtE8txdQhMBFLvXBcPa0Vr11
	 JVIKDs28QTOOjUFHrEOfSD2yJhtQrMMxksW5qPOXL8w0NdosqsGcIsAtK8UyCoyRjW
	 Poyf/ov8HqMjzt1i0Cvl+ZzmJco5kuULzA/flt5QqF+aRJ12VasvhXrkOrj2OW3Zbu
	 Ndr9zxwfSi4pY1VzwMjjSc83rI6jG6kIJXQi4gQiXWEC2S9Dggsack//fZA+Rl0McF
	 lIephaePdOqGg==
From: Sasha Levin <sashal@kernel.org>
To: enscrpt@pm.me,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: ua101: Bound packet copies by the PCM buffer size" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:15:13 -0500
Message-ID: <20261107051513-failed-6.18-493a77a9f20f@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 493a77a9f20fca07ca5654f61c1b03bef035df25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051513-failed-6.18-493a77a9f20f@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




