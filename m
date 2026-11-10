Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313627;
	b=2fN/zP0Ag+4Evir9pZTnbyAojm+QzeHs31rgBOstX2brg/rQUnXZo07ZtxQaOKiLPgJn
	 ip4mj0zrofl9+GTsPwrjYKdOJkv6wwyPxcjzCVDm74IuZmDjRqi5BUWgVZzeFT+9K6eEk
	 gEAYVRS0uQgqrbsWDUAjQtwKuS8XDdOv0CCkkonW41hi8dbbTwH5B+eyL/ivKFDmTx9NE
	 h+U+hpmixVpP+r9POz48aUiGWN+0wZbjI36p5z/JEN9KfLFIx3JuhLpfQ+7aZAFbrp8jU
	 M0r0kJJyBAuqelZwhoo2vKB1dSWp+Kf7RXK85NDuiXIWOFE/v1bKecZWXn7ec5/l0DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313627;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7TZjTcMEF76p3QWqNy49WkN9iKi1DS6tfpVO23ZQ7UE=;
	b=vgNpwtXi7Eier1OdzCby4hBkKQQC6NMvxWf4C0HVAQk95AZ8ax2F5IksnCvu2A2B/wNq
	 2L/L12J1HRboaUQ1RC/R9b+uh+NdhopycKY7ZD/Ysl/1nStaQ0e/7JOw0inIK0fTtYATG
	 BhMARfaHHHZJqHGW7i0e4yhQPlDW7iJOossNVPxw1p873yZABnWaqUD0hdpOqW3HfXrK+
	 6t/LG3PFwrx7cLy6G0tXJHTbvzHmLAgTnKjI3GYdfDlw/6wdqveS8d0nx2Qec2qAbx1im
	 sSLM68Ieo2fRY91OMob750SCCow72jdlWQ3PFrXEOFzJssXh9cp+1+RmetLgNulhdDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZ9PZRrf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE47606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZ9PZRrf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2911F008A2;
	Tue, 10 Nov 2026 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313627;
	bh=7TZjTcMEF76p3QWqNy49WkN9iKi1DS6tfpVO23ZQ7UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KZ9PZRrfIx4VEqfTcSEd4UJuhzTP4hc9GlcPotRlTLICB2KB5AIWwH/kvzHr3qTBk
	 tx0wxNJY1iVbUE1T+uHNAhZVKidUztTv6Fty4F7W/bGRoOwbh3+vBYRF1qmj5rFlNb
	 aLmxPlAL5R+rXr0KI9bhr1o0di+pv6HGliUbwBJjysm8pLFVM4KGKLaLtmx6IQxUDY
	 1p5Pthq947vAc6+/M5HlmVmd8b8KowbsDbljUMTnphDOjRCCRANNseE5g7+L3KMI8L
	 lSGexHC5IPXDLJ2sDb8T1sC2QnOqvb7cRNEEL1YRgi8W+5cd3RPfZEq4DhdyKFpBVI
	 DLLcFY4TgrhKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] ALSA: usb-audio: Protect Roland control activation
Date: Tue, 10 Nov 2026 07:27:04 -0500
Message-ID: <20261110122659.1155489-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110122659.1155489-1-sashal@kernel.org>
References: <20261107050341-failed-7.3-19b42c1fff7f@kernel.org>
 <20261110122659.1155489-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/midi.c | 53 ++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 353217b3629b7..1099e5b814113 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1150,41 +1150,42 @@ static int substream_open(struct snd_rawmidi_substream *substream, int dir,
 			  int open)
 {
 	struct snd_usb_midi *umidi = substream->rmidi->private_data;
-	struct snd_kcontrol *ctl;
+	struct snd_ctl_elem_id ctl_id;
+	bool activate_ctl = false;
+	bool active;
 
 	guard(rwsem_read)(&umidi->disc_rwsem);
 	if (umidi->disconnected)
 		return open ? -ENODEV : 0;
 
-	guard(mutex)(&umidi->mutex);
-	if (open) {
-		if (!umidi->opened[0] && !umidi->opened[1]) {
-			if (umidi->roland_load_ctl) {
-				ctl = umidi->roland_load_ctl;
-				ctl->vd[0].access |=
-					SNDRV_CTL_ELEM_ACCESS_INACTIVE;
-				snd_ctl_notify(umidi->card,
-				       SNDRV_CTL_EVENT_MASK_INFO, &ctl->id);
-				update_roland_altsetting(umidi);
+	scoped_guard(mutex, &umidi->mutex) {
+		if (open) {
+			if (!umidi->opened[0] && !umidi->opened[1]) {
+				if (umidi->roland_load_ctl) {
+					ctl_id = umidi->roland_load_ctl->id;
+					activate_ctl = true;
+					active = false;
+					update_roland_altsetting(umidi);
+				}
 			}
-		}
-		umidi->opened[dir]++;
-		if (umidi->opened[1])
-			snd_usbmidi_input_start(&umidi->list);
-	} else {
-		umidi->opened[dir]--;
-		if (!umidi->opened[1] && !umidi->keep_input_running)
-			snd_usbmidi_input_stop(&umidi->list);
-		if (!umidi->opened[0] && !umidi->opened[1]) {
-			if (umidi->roland_load_ctl) {
-				ctl = umidi->roland_load_ctl;
-				ctl->vd[0].access &=
-					~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
-				snd_ctl_notify(umidi->card,
-				       SNDRV_CTL_EVENT_MASK_INFO, &ctl->id);
+			umidi->opened[dir]++;
+			if (umidi->opened[1])
+				snd_usbmidi_input_start(&umidi->list);
+		} else {
+			umidi->opened[dir]--;
+			if (!umidi->opened[1] && !umidi->keep_input_running)
+				snd_usbmidi_input_stop(&umidi->list);
+			if (!umidi->opened[0] && !umidi->opened[1]) {
+				if (umidi->roland_load_ctl) {
+					ctl_id = umidi->roland_load_ctl->id;
+					activate_ctl = true;
+					active = true;
+				}
 			}
 		}
 	}
+	if (activate_ctl)
+		snd_ctl_activate_id(umidi->card, &ctl_id, active);
 	return 0;
 }
 
-- 
2.53.0

