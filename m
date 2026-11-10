Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315485;
	b=EtTFf8aEqwKC/md+ZMuJ2+WaycmRvwSPz7CjqHOQz+tMfDbjktMKgQMuLkaY1v8rSWuC
	 YHoQ/MKI/3aADec3Umd71ay937Qhh+wEm/xhg0LVrdquo4kQbUoL5xv1oZd/+2UsaOoVg
	 bwqiDXnTNeD/AV+kBS74r83jCUR8DWh598x+VOhG89cHN+KomFlAW9066MBw/LhKvWRrR
	 vbYQ/YAdsszY9RI8MBjFpwV9oy53J4uC5wMn9XDXrEYBVmXk1XhHFiqeo3lZvxC5cD262
	 ULp/ZFqwD1rC+fD5EOBUqjPiEN8uGAcT6LyRvLDMQOjz4zfl06otHzjQtePxWYLBk8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315485;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B7qDhDvqBSwMjBRLr1ntuAiYuBRtBn9TmkMJjR/9wSw=;
	b=y7PiKMjhMvItS+qBfc1/t8c8/MoMkieO4eyUsEUuewSRrrYOI1Rd79X69CS65dtP40Tz
	 Frd4ufDG/CJQg8mU0rvz5HutBTiNLP3Trx/caX2ro/yHcgaO0PojUTY/0b9/pJ2BlwfDX
	 6h18xE0W8rukrmVeLA5s2ZM1fxOsek/EZSSJWmmnsHyTg4rVX2f7+3ikyLZDrQpvAZ1R3
	 7eSw4pTDUEs8W9/tkNeM2M/yd9mmBJBUmmeOEEZtSS942AA6KxmtU6syPXONsvUXGLEli
	 lXfAHsYNgBDfeGLD753KRRaMNSTSZaiTLuUvR7Eh9AWa6Y/aZbbJRgIzGVXNEXjmfeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6avV1AI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9D606BFC7
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6avV1AI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DF71F008A7;
	Tue, 10 Nov 2026 12:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315484;
	bh=B7qDhDvqBSwMjBRLr1ntuAiYuBRtBn9TmkMJjR/9wSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e6avV1AIYVYjarmY8B+7pYw2/gOFiFus/geSCQ1T+9IxdCujJfdTIVxUXQxvo2KFQ
	 4L7+72U+hJJJFh04rVqCkD7udEuErSB1Dv5v9lR+xIF65qEV6sU/IgfR81eunwBpN+
	 Sdr5rBqrL83rImv0GSEcdBeLvmb4t/s7w1FGuKKasmlsJdGb3VcQ6rVLB71Y1lKqHT
	 FOjdylGrSLV7rq9rLAPdzJU55EwT+zVoixxv4XlM64qJboMq7+6v3cWO/U1UeVqacP
	 /coLvfUr4QuS5KTUDVuGRFRCG0WLWLiQMYuQDQZzvfB4sryS3oUXmZvztvkMRif5vb
	 X7k9iPrBpgrBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: usb-audio: Protect Roland control activation
Date: Tue, 10 Nov 2026 07:58:03 -0500
Message-ID: <20261110125747.1604943-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061741-failed-5.10-19b42c1fff7f@kernel.org>
References: <20261107061741-failed-5.10-19b42c1fff7f@kernel.org>
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
[ sashal: Adapted guard-based locking to the existing explicit mutex and rwsem lock/unlock calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/midi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 2ae37bb2ad645..fc5c640d0a009 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1168,7 +1168,9 @@ static int substream_open(struct snd_rawmidi_substream *substream, int dir,
 			  int open)
 {
 	struct snd_usb_midi *umidi = substream->rmidi->private_data;
-	struct snd_kcontrol *ctl;
+	struct snd_ctl_elem_id ctl_id;
+	bool activate_ctl = false;
+	bool active;
 
 	down_read(&umidi->disc_rwsem);
 	if (umidi->disconnected) {
@@ -1180,11 +1182,9 @@ static int substream_open(struct snd_rawmidi_substream *substream, int dir,
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
@@ -1197,15 +1197,15 @@ static int substream_open(struct snd_rawmidi_substream *substream, int dir,
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

