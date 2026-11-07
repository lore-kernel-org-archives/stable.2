Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050263;
	b=w4fjLon4qzXBPT54l7KzlDuTOcewFWpjSTTs5h6xr7XDIU6zc/L3Ontonw8D4/bmxFef
	 htoN0TyRykrb18a9AgPRhgHGzd16ZY/7SnWKP3FpzY1f5jC9zoQGUHiNMYZl61agOIVbF
	 +knyP+mURpvAwrpPCIY03gPOO3fArzOUYEBDHmkYBYxd+VX2sPBCgh6eYyqm8jj2z+fBg
	 qEhdKEUM32SzjkFDV3EAIDKqXl0mxoA/Fi2zHu6lvJ86OLQ9GkAtHiXt/2XSVgSlgUuLv
	 p63LDbtRmDvvrslXC+Q1bUTDAalW9kvloREzVw6eBvEZaGvdDU50Ut0+YGJiWYiOhxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050263;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dsc1r8Yk1vRfM/tlvZfaZ1hz50HdfVsUtw4ocFBzNwA=;
	b=jTU4sYRAXJdEVmJVYxZR/wkJhkVs6V86fwF791EL1aupsxS4Foua3ROdquJjzC2cMCCz
	 SUQ2KxOg0W9rhRoFjcZdIYAq9jpdHFeG7EEr8lkX7mi3XA67o3R+uPYKnRe9enF/heooh
	 pStgVmQmZzh6Rx6ZgRtqQfaHs5MoJ6+t3ixk8K8tSajUSKdqiteNqbXVra6X1O+NzsPjz
	 MCNVGIug2YpnhBusdKGV7Q2wL9n9rlpwrY3x6hK8IyCNufvb8xQGMgbc60UgUqH7Duqxy
	 1p3qhKbk6/2BfzB9FfjY8czczjJN/quyGI4Op9H2Yw4ZEhnEQ3c+pR2tlBOdRyp/LaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOjHYwHi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOjHYwHi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928661F0089F;
	Sat,  7 Nov 2026 11:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050263;
	bh=dsc1r8Yk1vRfM/tlvZfaZ1hz50HdfVsUtw4ocFBzNwA=;
	h=From:To:Cc:Subject:Date;
	b=QOjHYwHisBObtquH5H06GpQqaO/JPKtnBwlFB41G1CGcizlLNoNGJjewHVOdQG94g
	 1bAt2n5oQ3PEGhDG8xZZnIFsx1L+050D41R/l6pIpvOyge5bdRsz6Ay6V1x4YdzLuB
	 qYclKCMriHh+s5eLC9bWgOKIrSA7kMp77LXqEeTHkDmuz2S5IzD7JasDUILljEZRqs
	 Di8Yg6t4vvHOEs/K8/uY1LmmR8P02aV8HaoiV03zLwtNaEBf5x3uiGzk9EXuD+FB4c
	 LVh+O18r/lkF/dfNXm28b3oGIMItuZIq/U/6hZcSczkVAVJC9oMgk14jII42hFdmIQ
	 S3f1SN7bc/tyQ==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Protect Roland control activation" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:41 -0500
Message-ID: <20261107061741-failed-5.10-19b42c1fff7f@kernel.org>
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
git cherry-pick -x 19b42c1fff7f220a6346c614d79ce1bda6d95b40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061741-failed-5.10-19b42c1fff7f@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




