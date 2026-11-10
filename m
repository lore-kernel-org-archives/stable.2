Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315008;
	b=2dfExTN+TaJBq6uKqWmEwZHTLRWBwC7vVbH1k6yfaPhG6QRfdDolfdtJrNAPyhXtDQuy
	 aWZRTe/OAgho+L882y2kRzY5h6ctPYezJ6YZ7bsvJxyVEqvUeFxqCrT4Ea9eevzPprRaH
	 iJtcZla2BjZ/1a1L7OfROSwAQ1qA+L0SswVQZE3MY7pXzSf+joPmZ3yUkNdaQ2HVkixV/
	 aKhWLPWQid4BS2iQiZaIocllLGLyWrY4dSoPLiNDEIz+atWgtkuljEXSevs6NTDBVNQ2D
	 W5Ad1htx9DvH+LH7CeEDC3VsPmkj/GZRBqlWMSUy0CK2uE0og/0FBqpd/OW4NuKFwoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315008;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ObptOhF1YteLB1ITxAE02v8W/v0n/YAm5Ci+rgmT2ck=;
	b=1Z2i9bZzJAvErfRIDJLyXXJREy5NhuOOdeP/KdgCoc2VVpya9Fit8VkCg67ZAhNHEJCd
	 yVNtI0PvY4jaGVB5yDS9VRhjEHc6bphcRQ7oUgMZ8LtNORKCJLrWoaHFdiphv20apjGXK
	 vGuKZevQtm7Q+Nd/LhPqTzEqq70+Vv7d6n5xTl9S4uYUlZxDloP3r5lQUqS+CPX/J2mOX
	 lUfPFJWi+0lYadLIGYQfsduRFfrPvC9SdqC3+QHwyBJldbh9eSW7ryWNhWcM0H53Bdpmu
	 SydFVIsCvxYpOSGECbNOKeqNei/ojGaOWxVWOFCBY2d/E8r08yjpkNV8K3nd7AXkKYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvXckPty;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D0606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvXckPty
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7531F0089F;
	Tue, 10 Nov 2026 12:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315007;
	bh=ObptOhF1YteLB1ITxAE02v8W/v0n/YAm5Ci+rgmT2ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FvXckPtyfZx74Bbs6MjqHYcCer3wr/hpaDP+1X5gWePhH0iQf8MpUQZBwZOA7d4Id
	 C2NWMpuPWEV0VTYTb5sJZ9p0ZEiT/AlSvwRQwcA8ek+eHjK++RRKtb6lUfvlMzolnO
	 Tft+BvIgrjpRQpmxWr9NiLBg1vkP7tMa/pPjcGNJoE1FKm/NpiNQWREPADTsXvMPCW
	 wEcU3wXbYO7KzPmwk31oZ7C41/cdRbpulDueHYVLVrxHvXz9ME+9zoDX6chb07TDdd
	 /nOjy17KVqnEii6n7Q7D+FiZVcErL6DCsBhiY1e6OiiJrxxB9m9SvI5NuQJOSy/sPn
	 B5nGwEK8SP7bQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: usb-audio: Protect Roland control activation
Date: Tue, 10 Nov 2026 07:50:05 -0500
Message-ID: <20261110124946.1530212-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054323-failed-6.1-19b42c1fff7f@kernel.org>
References: <20261107054323-failed-6.1-19b42c1fff7f@kernel.org>
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

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 19b42c1fff7f220a6346c614d79ce1bda6d95b40 ]

The USB MIDI driver changes the Roland MIDI Input Mode control's access
flags directly from the rawmidi open and close paths.  These changes are
not protected by the ALSA control core and the corresponding notifications
can race with control access.

Use snd_ctl_activate_id() so that the control core updates the access flags
and sends the notification under its lock.  Release the USB MIDI mutex
before calling it because the control write path holds controls_rwsem while
roland_load_put() takes the USB MIDI mutex.

Keep the state transition and alternate-setting change under the USB MIDI
mutex; rawmidi's open mutex serializes the enclosing open and close paths.

Fixes: 96f61d9ade82 ("sound: usb-audio: allow switching altsetting on Roland USB MIDI devices")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260929141726.2166899-1-runyu.xiao@seu.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ sashal: used explicit mutex and rwsem lock/unlock calls instead of scoped guards ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/midi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index b883d50509b75..e0020956a100f 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1152,7 +1152,9 @@ static int substream_open(struct snd_rawmidi_substream *substream, int dir,
 			  int open)
 {
 	struct snd_usb_midi *umidi = substream->rmidi->private_data;
-	struct snd_kcontrol *ctl;
+	struct snd_ctl_elem_id ctl_id;
+	bool activate_ctl = false;
+	bool active;
 
 	down_read(&umidi->disc_rwsem);
 	if (umidi->disconnected) {
@@ -1164,11 +1166,9 @@ static int substream_open(struct snd_rawmidi_substream *substream, int dir,
 	if (open) {
 		if (!umidi->opened[0] && !umidi->opened[1]) {
 			if (umidi->roland_load_ctl) {
-				ctl = umidi->roland_load_ctl;
-				ctl->vd[0].access |=
-					SNDRV_CTL_ELEM_ACCESS_INACTIVE;
-				snd_ctl_notify(umidi->card,
-				       SNDRV_CTL_EVENT_MASK_INFO, &ctl->id);
+				ctl_id = umidi->roland_load_ctl->id;
+				activate_ctl = true;
+				active = false;
 				update_roland_altsetting(umidi);
 			}
 		}
@@ -1181,15 +1181,15 @@ static int substream_open(struct snd_rawmidi_substream *substream, int dir,
 			snd_usbmidi_input_stop(&umidi->list);
 		if (!umidi->opened[0] && !umidi->opened[1]) {
 			if (umidi->roland_load_ctl) {
-				ctl = umidi->roland_load_ctl;
-				ctl->vd[0].access &=
-					~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
-				snd_ctl_notify(umidi->card,
-				       SNDRV_CTL_EVENT_MASK_INFO, &ctl->id);
+				ctl_id = umidi->roland_load_ctl->id;
+				activate_ctl = true;
+				active = true;
 			}
 		}
 	}
 	mutex_unlock(&umidi->mutex);
+	if (activate_ctl)
+		snd_ctl_activate_id(umidi->card, &ctl_id, active);
 	up_read(&umidi->disc_rwsem);
 	return 0;
 }
-- 
2.53.0

