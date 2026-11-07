Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046695;
	b=gPsNoJDck5lxxuNEA0tQsg66o7RDBaaJtxeGBjYLWNLu1onpulMHwtd5pqMvHZ2s4uHr
	 VI0+BW0A1ws+JkAcmbR3/Hy/usj+N8+D3PQBWKI2Dsdx3Rq1jeud9rTZrY+QVWt+FaklO
	 spwDrbVzsc+9oFJ6mITFLYA1dQiaYnavThQYHs1U2MANIvnzXeU+vjT9WtBRZpzJDZViu
	 jh8/gjRftD7f/PzjmmJXYSOMOFt4Bj+/rQLgFox0UT4bjXYcAE0IzwuHaxb2ZhQNMticX
	 V+7tFY6zMXLcHUYr5zcRFH1K2AGIrFeOoyyuvF2WjEVJKl52FKhPghRTFn0/UBtWuLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046695;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jwlyjkVVKHSpETVzW3twWg8adL+IsYc8Sj3G5vNte1c=;
	b=U+41WG5jk7DWXjCtzwPfInDUfwDrJI6u2HtlAkBodeyzT93KOqmGe44zpOy2aLcp+A8J
	 pf8kBMlXJmC1fhyxC+OfPXan3OLr51Udoog3QivngIDwY+iAjdX77YF76pDoA2C72omU4
	 JPR8eGD6xqqXR8T5OGUs/Z7qqJ1YSVCXnDs5DwFc6667mgSDZXLDarlA2lO4Yczo8oExr
	 /K7NlFPqd54+sCDrPFj0KjMtBSg6d9obgvY0Oiuf42YPAtdYd+CDsozgxmO0rwUFUhOOb
	 p9CKfOZnEViUJ5gbzZMBjwIB4vG1QjILjsNUw9FRkead0YcoblO6CmaHAZ4S5vQcBhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aq7VR2dT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC48F606D817
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aq7VR2dT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A0E1F0089F;
	Sat,  7 Nov 2026 10:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046694;
	bh=jwlyjkVVKHSpETVzW3twWg8adL+IsYc8Sj3G5vNte1c=;
	h=From:To:Cc:Subject:Date;
	b=aq7VR2dTcNGOlHy11+uu6JELyQaVKdyPu6IMJLIsNDMZTSprh+XK6Hj1LMAJtpgVz
	 IGX0uP9VhFHr22/iE2ByJ9KI12ItY7hejl/wsl1sLkYomH8zl2dZOJ14T5nC7IE8B9
	 Ajm/u13/LOHJNjDdDlpP+SA+BYr8LhPDfsUh2jbLKoOLmWi2izaW4uTxqdsbCdy1Fx
	 BxaMrRmuYyexJV2jlCIQCsKF/4nKNh09JuVU1PVeYzKmubq5WeA8i7U8Sy0AivpYnN
	 HIXyKwX5nYme7KKTZiKbe3EFDtsgQ/7p42f0+tPRzmUNnhJG8CFuucYXn6k/Bq72rN
	 ItTnmo2nx+1EQ==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Protect Roland control activation" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:13 -0500
Message-ID: <20261107051813-failed-6.12-19b42c1fff7f@kernel.org>
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
git cherry-pick -x 19b42c1fff7f220a6346c614d79ce1bda6d95b40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051813-failed-6.12-19b42c1fff7f@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 19b42c1fff7f220a6346c614d79ce1bda6d95b40 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Tue, 29 Sep 2026 22:17:26 +0800
Subject: [PATCH] ALSA: usb-audio: Protect Roland control activation

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
---
 sound/usb/midi.c | 53 ++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 0480a9b89e8f3..e3d1575540613 100644
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




