Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334278;
	b=01+9VSmIPUh61H5WHvWqWXyfo9k4pv2MYYSZlmZzA4F/Yee+6m2qtGRc4evyLMFYCsuo
	 ep8J9d3JdvNVUwYR5XJGB+B5dNq8KEFiKtYPTJZU7LGMwTKBkHf+lPmcJ1d3Rjnru8u/a
	 UI8pBUOf/tXxovthKKnhRSmDAu4TWt4yR3b1yzOYosziIGqFr9+zxTtM00zBlylRBp/kn
	 VgU3w0B9GRkOVdSVD3Qn1R1fMzM1etor12veca+asqRjfdPy1zTgsllJtX8IaG6HcdpmI
	 9cJhN3VibQCfnVWSfQ8hyosmyvOJyOen+judT1chvDChXNSxc9aERFgm0vHIIzR22BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I7iGDY7HzvqWvgo4Vi6jdhUMxBFeh5iiwYhhq3OdEYM=;
	b=yWdobShiM/aP1JHmQnW5SmIKmxeyPR2HrQXKFNI6uMff14WlX+SoZd8gsAQYiNk4UZah
	 ZdxbvFpx4Wag4hI/2zbA6VWzIFPPj6EaAnWSmpSQO0+y761GlrgOplI2UNtovRl8dL2JP
	 Kqx6/szdzaRynhFUmPXoKeGollQJ9KWnYhFiwd4FupMGPLBUsmKT5GbpNusd1Fyws2ABf
	 AGtmu6CFn0IUD68k64u0jia6JoIvjXOig7SAaEqmFQYiF0iFOnacThYQBpW+6guExw1Nb
	 u2aKCEQRdE5ID5hF7P7DcK13DUdLu921tE80sUOWQ9XDDv5UNYYJukC26JdInqK56Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1owJWm3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D8606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1owJWm3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99131F0089F;
	Tue, 10 Nov 2026 18:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334277;
	bh=I7iGDY7HzvqWvgo4Vi6jdhUMxBFeh5iiwYhhq3OdEYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U1owJWm3y8l/ILrCICavqTf+GwaufbTsFz3NqHGqnWkB698TwjAzAAlou8udu7oyE
	 6oFapQrOaWvjfVAZGLo60DddxhtLDESEt9ElRHLPYmmTQ6JPd+19TuX/34ovioGRhK
	 jO0oYhhuH68c974r4aJEhuIBwcbZPz7awOuyWcaAw+GGxV2FwLywxmuHDU6iJ7MsW9
	 jtL/7oGtSkLbN5ka8PpyVHP7uy+s6SR4j71Iizh6Fa13FJBLUbSMefYXb2zfGGb8gb
	 /HglB5VjfcmcnHPHmB7q/57vWFHFA73h2QiF7nlbkJbGQBJX5DnYXCcJcI0uG85OTP
	 P2TEJWYknvuBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sinan Turunc <enscrpt@pm.me>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ALSA: ua101: Bound packet copies by the PCM buffer size
Date: Tue, 10 Nov 2026 13:11:14 -0500
Message-ID: <20261110180056.3027785-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051513-failed-6.18-493a77a9f20f@kernel.org>
References: <20261107051513-failed-6.18-493a77a9f20f@kernel.org>
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

[ Upstream commit 493a77a9f20fca07ca5654f61c1b03bef035df25 ]

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
[ sashal: changed urb->transfer_buffer to urb->urb.transfer_buffer to match the embedded URB representation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/misc/ua101.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 426171aa6dd28..c1d081231d7c8 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -282,13 +282,29 @@ static void playback_work(struct work_struct *work)
 			/* fill packet with data or silence */
 			urb->urb.iso_frame_desc[0].length =
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
 									&urb->urb,
-									frames);
-			else
+									copy_frames);
+				memset(urb->urb.transfer_buffer +
+				       copy_frames * ua->playback.frame_bytes, 0,
+				       (frames - copy_frames) *
+				       ua->playback.frame_bytes);
+			} else {
 				memset(urb->urb.transfer_buffer, 0,
 				       urb->urb.iso_frame_desc[0].length);
+			}
 
 			/* and off you go ... */
 			err = usb_submit_urb(&urb->urb, GFP_ATOMIC);
@@ -317,6 +333,13 @@ static bool copy_capture_data(struct ua101_stream *stream, struct urb *urb,
 
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

