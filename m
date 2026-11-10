Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314622;
	b=CyQtmD/J0o6kw+EtzAi9mEOUYVpoDdz4hIEQ5s/6OiCHDs/rYa8cpAL/ySvHapVhAjMV
	 B0BRNKjxn0muCNmh4Wk1GKNcK/2eehbtZ2/6fkoIPk6QnY+aYC8vI2e56Ligmq7Pf+0Wb
	 depo5VSEnS59w7KW4tABwWS+ZZRbCpIJx0aAR2JdHF9fzz2gBz0SEOR7H+I+8IRNqfaA4
	 qW0K7AuEum8UrYKDkjPNuTJ+wVTRQXvZcbdcaIYxjSWeFfJr0AoRAbqNM7gwa5mARBqlt
	 ZaYZg2CSyHjhKFgeuB0r9zlSGz/W2qHBTSGxp0paIBlQ05+6HuOkB5MFGAxh0PCrE2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314622;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vyUTx1fuD9qmAGc1vQirKpXhRdg/OykJgCixZ6wtr3Q=;
	b=VnHsNjwnMNMbSqtmBlzfRjMCPFX/C6toyrSRMpLyUXMbRSJpI5EMkWfDkeV5G9ZeuzjG
	 yT4txM48PC7lBfytH1e+D3oqK1ElMJCfDxvKbpGFoABD1HwOtIuN9/XYXYFCduVPGPXG+
	 C8Vb4oy19ATBp0+HrkJpy3wQft2OeGQGROPL1dYgEnVFEASjuzxS3sm4dhaJo927C39M7
	 tSFg99lIR9YNBnugnfaNgJDw4JKetOBUJW2DwpA1hZAjtLvCEJwn+fzecixdt8c12gDwz
	 g7lcFxpKMjvQCTWXw36o4Mc3yARc3KqMfey9mpXiNNKUzqCvgmej2yBPk6bGg7nTWBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTyrBLeJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57080606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTyrBLeJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63B91F008A6;
	Tue, 10 Nov 2026 12:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314622;
	bh=vyUTx1fuD9qmAGc1vQirKpXhRdg/OykJgCixZ6wtr3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cTyrBLeJd+SgjMtwaz40bXQsXd7uiXXISfUXEiQcLNef/8NlBpIEKEDXTGy33nLrW
	 BXtOo8lBFNAcaB03/V6jH2A94AtiBGs1HuDVTDKwTJMH2vYRhuxaT0RydkKYfJ8DY2
	 caD730dZhhfOazHqCl539c9C386JNqAJCXaP49Ai1ST9WGkYmjzdz3L2GUOC8LtBxO
	 xM0eFDj7bMeowyCB/0DFS4vk1eKYZSo1vIiPf4U386h1YTZOsiVNN4WzEtVb2ibb1N
	 SkkNQ8CsQmlx8Djk+VceNbUhRaQLoKw/5hrHggPNp+VFeVROfgyiIzPNtO0rMp3yXi
	 FICGi4VEmQaWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: usb-audio: Protect Roland control activation
Date: Tue, 10 Nov 2026 07:43:40 -0500
Message-ID: <20261110124315.1507464-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053042-failed-6.6-19b42c1fff7f@kernel.org>
References: <20261107053042-failed-6.6-19b42c1fff7f@kernel.org>
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
[ sashal: adapted scoped mutex locking to the existing mutex_lock()/mutex_unlock() sequence ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/midi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 156b16e48373f..0758422e949bd 100644
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

