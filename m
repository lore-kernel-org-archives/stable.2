Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273882;
	b=PI1L6AKLLnYyVy94IsQxriWA7b/hqoQHTT5Yk3o/qAFhG0h/0fgIM3cIRE5diZQcFnXa
	 I2lOucXEJhHQIDDk27fXKsNyBPsZ2H1LgDRwKpAf7YpYMxZsabBA6efVRS0bJwaD329sn
	 3qpFN3uiyAbKl+PAPtCIldPCLPp/s6I+fIaLc+ih8AVqdKEGuineKQLcnCpLQ4uD++MqU
	 DKS1tU0hXwaJFGDSou4XnNrWJxuBVpxJ8ZWka7vKv0+qVZwro5cN8TU1sLCnON2rpiJ5D
	 QLyUxRtNissHVF+CP0jfK5q4HkCbDpM0gLpfXmbL2XEqvtHUJBOoZYy/x7aj5BT0IAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273882;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ty5tx/K9Q/s7PVdzP9o2mG81iENXEQuWJXJB7zs1eYA=;
	b=oRWIUCxiTdrddV/ObF8fjdqcsvBAr5rwORmpktpKkYTjBWf1001Tn5GTPcz/ecWTRES6
	 1gj6pLK+v2s1SZMFJE7jqIeHHddv02C29O4Ur9uKKmBbhqyjCWo7wiclPhK1WZeXr8LMZ
	 tW6ewRyng1HkMJxLLLaTwPwea3M7ssYx6Gh+VrFcoadLbKyQJ3v09uuL74ngoGZ+pljVO
	 FovsghCM51/oXEAS9BVS2fGGRgay48yZqYXUNfxfwnIq6/h2A+eu20g4qkKOikRG/Z9Wr
	 G8uzfsQWrCDE5mEpJeQO7VGSE4l9pZi+yGoe3hrrUG1Plv2+Nv5OlJNwmvaPYCSsCUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pl6EabAg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8466860A382C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pl6EabAg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3B71F0089F;
	Tue, 10 Nov 2026 01:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273882;
	bh=ty5tx/K9Q/s7PVdzP9o2mG81iENXEQuWJXJB7zs1eYA=;
	h=From:To:Cc:Subject:Date;
	b=Pl6EabAg0kR9NhqgxVIC4VnuHgg7ZLwnB9k9tx1CVPRiL81MIQEHmJ3ea0mU/JQqB
	 PGXUl3AS5MDP8ThxZxNJGNuRTfP37vAVLuh+flxgeX5Xl52/eIfU2CAgLAY5/8J0QW
	 uwn6yrvIxPAokluwslu09VUR7esap746U8r+PH2cizzWy0xr7oP0Q6q/h9rby1NqKP
	 u44wHCfmVyx0jAgV8wRNw/lSwHJUeVLXo8PuXOCe8Z+xupHWMqsT6tq4chJHUi2sc2
	 lEpZkLaCjyEsx3jRnaK0HaPzhtDkWKFPz1+WjQ0VSrk7/JOaMqq7M9VEsuScBq080o
	 bessOzJZeqTew==
From: Sasha Levin <sashal@kernel.org>
To: 25031212351@stu.xidian.edu.cn,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:40 -0500
Message-ID: <20261109202440-failed-5.15-f6c7bb1f0799@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f6c7bb1f0799591a62be75b9bcf84245b4f208b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202440-failed-5.15-f6c7bb1f0799@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f6c7bb1f0799591a62be75b9bcf84245b4f208b7 Mon Sep 17 00:00:00 2001
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Date: Sun, 1 Nov 2026 03:09:36 +0800
Subject: [PATCH] ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close

bcd2000_disconnect() calls snd_card_disconnect(), which only prevents
new opens, and then frees the MIDI URBs.  A rawmidi file that was
already open can still be closed afterwards, and its close callback,
bcd2000_midi_output_close(), calls usb_kill_urb() on midi_out_urb.

The URB pointers are cleared on disconnect and their accesses are
serialized with midi_lock, but bcd2000_midi_output_close() reads
midi_out_urb without that lock.  The check can therefore pass just
before the pointer is cleared, and usb_kill_urb() then runs on the URB
that has already been freed:

  BUG: KASAN: slab-use-after-free in usb_kill_urb+0x74/0x80
  Read of size 8 at addr ffff8880078e7d40
   usb_kill_urb
   bcd2000_midi_output_close
   close_substream
   rawmidi_release_priv
   snd_rawmidi_release

  Allocated by: usb_alloc_urb <- bcd2000_init_midi <- bcd2000_probe
  Freed by:     usb_free_urb <- bcd2000_midi_free
                <- bcd2000_disconnect

Take the lock in bcd2000_midi_output_close() and reference the URB with
usb_get_urb() before releasing it.  The URB then stays valid until
usb_put_urb() after usb_kill_urb() has returned, even if a disconnect
frees it in the meantime.  usb_kill_urb() itself cannot run under
midi_lock, as the completion handler takes the same lock.

Fixes: b47a22290d58 ("ALSA: MIDI driver for Behringer BCD2000 USB device")
Cc: stable@vger.kernel.org
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Link: https://patch.msgid.link/20261031190936.5696-1-25031212351@stu.xidian.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/bcd2000/bcd2000.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index 2bd49bf827489..0fd086cac9552 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -183,10 +183,24 @@ static int bcd2000_midi_output_open(struct snd_rawmidi_substream *substream)
 static int bcd2000_midi_output_close(struct snd_rawmidi_substream *substream)
 {
 	struct bcd2000 *bcd2k = substream->rmidi->private_data;
+	struct urb *urb = NULL;
 
-	if (bcd2k->midi_out_active && bcd2k->midi_out_urb) {
-		usb_kill_urb(bcd2k->midi_out_urb);
-		bcd2k->midi_out_active = 0;
+	/*
+	 * Reference the URB under the lock so that it stays valid until
+	 * usb_kill_urb() returns, even if a disconnect frees it in the
+	 * meantime.  usb_kill_urb() cannot run under the lock, as the
+	 * completion handler takes the same lock.
+	 */
+	scoped_guard(spinlock_irqsave, &bcd2k->midi_lock) {
+		if (bcd2k->midi_out_active && bcd2k->midi_out_urb) {
+			urb = usb_get_urb(bcd2k->midi_out_urb);
+			bcd2k->midi_out_active = 0;
+		}
+	}
+
+	if (urb) {
+		usb_kill_urb(urb);
+		usb_put_urb(urb);
 	}
 
 	return 0;
-- 
2.53.0




