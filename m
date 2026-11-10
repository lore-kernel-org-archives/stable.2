Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313947;
	b=ECRyp6jtXMGD7fEQBHmb7zZvzEVzF7Rnd4sGFQC3+NZv59Ys4V8HBq57n/rbUCeI1/HD
	 5OycZqw7sbeyj6Jw9+Z5cy5HeE49RMdJGYcMYAzXdqO8E2mphazJUfpPIMJQMKRk4KZ3B
	 nxZ8trQJ5oX+rnUpzSZYqz1mC/Agu+P6qbun6U264wUbu+DPzV42pXD32qSAOnexb4fMX
	 V2vRaJfqef2r7r6PDRyJanjOaAlOwltI2+W0i8Ykob/A4Mfok7QnHfFsrsXbltmG8egk3
	 F6yNLM78/sFG47w5A3rg6uec3bof5FkhXr5RXi19L3yOOiM/BPHbq0YjrTThrlNU0rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313947;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D/zWUjZ2a/dzeN0buP9oJO6wZGyjadhDK0Zkfhjem5c=;
	b=RWAdYZrMoJfm2y5dXNQ+wFhLzWQVfDcnKvIOz654Wsk/nX7CEKs4PbXglOuPosJKgx0A
	 XduYpZXtzr8ZOff1fdcCuBrslTapTIWKIWKA2j7cRUXbeB1r3ImzRrZ6J0HwjqjBp4LCg
	 GUqArLCWo5ECCxJdvRBn8tNbelVfKFbsxVGbQPQgn5PcEVAFPcwbkqm6FYomISZi6kDt7
	 gqkq6QTPUg9twHIJx8LLFP6v6HmJ4hzhsAWbIRo5Df6uZCDPWxxpEbcNQMJotxTutVc8A
	 DA4SLB4k67chhv9E++yWYptV5NctAnakI3Yihv3qI1sYuflxK8q9hVgIG02BdsBb9tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSLI2X8S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AE606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSLI2X8S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B141F008A1;
	Tue, 10 Nov 2026 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313947;
	bh=D/zWUjZ2a/dzeN0buP9oJO6wZGyjadhDK0Zkfhjem5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PSLI2X8Smcxo8US4NOCJMgtFe3I2uHcHbCN70IKe4srEEon2bNhf+bp40H2wyCt8R
	 OJheoEPMPr4MTIF+FteqWuy+iFQhOzSCHnuZjtw+gVV9RbvZFGLIq0Jkp1Ru5maOYn
	 aWaYz8bmHkPbzeJYUd0Kvj/d2wOfPw959F2zGF1PyuMOsQ+yE7lQIfbEThXOYlpLTK
	 UX3QAymBhti24E9/C40H54WH3VnVoBwzxHfyZTLcqDSY+sdg7AQLZoTkWSOmdId/6M
	 tdMPqW8w2VfLmYmkWvnFvLixoNCmVixPcMIo8OBvEcR5zmK5MLzAsaFsdANGuLgwjK
	 V2sstKiP1doCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ALSA: usb-audio: Protect Roland control activation
Date: Tue, 10 Nov 2026 07:32:24 -0500
Message-ID: <20261110123217.1265796-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110123217.1265796-1-sashal@kernel.org>
References: <20261107050744-failed-6.18-19b42c1fff7f@kernel.org>
 <20261110123217.1265796-1-sashal@kernel.org>
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
index 30d0684920319..c404412ae53b9 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1146,41 +1146,42 @@ static int substream_open(struct snd_rawmidi_substream *substream, int dir,
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

