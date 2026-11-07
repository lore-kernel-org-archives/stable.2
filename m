Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050983;
	b=rQE0sNCTULGi4B2M36HY8tPec/USwG9IVcJxHihv6ZlvjMwnHfmRFAm1ptLIxfRDGSz3
	 DN71vILHiLTBM0gfFJf6vAhjqFYsvyYIOP3GV/jfb6wTTC120KaqV6wbFS6qo4mgv6do4
	 oldRrK/xC7DbgNWU+WDiN1H0+4lbjpunu6RAQwnu/UJF9j2VSG6TUwManqofY9grVfw3P
	 XVHdrh36bphZbZASU3anqbDWYH8ylkguraWQzztVshHKcUVQFZxmF1cpvCg2fzs/TqYME
	 sOxLQncYhrcv40S0T0C3LBvHS0EfPklwp4A/Vy+8yV9WYshsd2U7iEqN0YaAcPIeYMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050983;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+yDURJqPKjbcYRZ9CIh9hWWgNOcs1UaIxql4dv9DPrc=;
	b=3UxFccmseRU9ELoxeuTcs9flna1vlegc17tyDuUq/VI/K2ryHsCy7JQEntU1564jC4mq
	 dKCK+I/0IcbxcxA0AcwOElsN94vt7xFhejzQl0o2wZfb7QvO+w0Nt5gIMOXfBvBvDoX5n
	 z83H1DIumhyWxmdBZ0kvnjnxyhcazMRbBkXYZDxjiLmvoNrA3pNgm2YzZSdCh42AfRmu8
	 2VB9sxTMVfICTRNe1CdY0vrI95uDXbbIaz6eNw6Swk0ntdCAMlYv66hY7PqWyYUkzuuAK
	 Y/F24kifzblWpOPzOkO18fcbY/E6uh4cn9JbNXbQujrCtVuAAVkLZezMaCUcmYCxU5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQO7Rsmf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDCE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQO7Rsmf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4166A1F0089F;
	Sat,  7 Nov 2026 11:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050982;
	bh=+yDURJqPKjbcYRZ9CIh9hWWgNOcs1UaIxql4dv9DPrc=;
	h=From:To:Cc:Subject:Date;
	b=JQO7RsmfxOl4koRT3AcSdr6EqWW8CAduOWkSoonJ7+ZLbsq3yS3SY5Qmpd0YvuwCX
	 gdvse4dqlwyYePFtBdk5iXQeYy83auQhr8cb6VAwqAIx5ffnTcT4UzG+oac8E/BQ00
	 U/Wb2uVKQA37TQDi1QfqO3HVlyDPJbUqRuJNe8vW9fQkdqn4w+Lr0S74NXp15tVDoB
	 t7e5XBHzHuIjfAB12bD9d88YH3TaWauBdAjxwar5oswuJV3ztWDHjSp7VLr5FjUG3H
	 Ocl2y67L22QwnszTPHYNF5wKAKWQG/1zLqfYLALemYaypHdn4JaqmYS6zb5A6JuIaz
	 fqGqhw7Ljt6CA==
From: Sasha Levin <sashal@kernel.org>
To: enscrpt@pm.me,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: ua101: Bound packet copies by the PCM buffer size" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:40 -0500
Message-ID: <20261107062940-failed-5.10-493a77a9f20f@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 493a77a9f20fca07ca5654f61c1b03bef035df25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062940-failed-5.10-493a77a9f20f@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




