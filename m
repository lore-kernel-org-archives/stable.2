Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046066;
	b=bsgTX/IdkMHj/sjHae4/lydpZMAZ80Fg1x+bxhJTZ3eWs36l0TtVcPMj/uDQ9JPzooYz
	 EODhrGY2EiabftCRRvkWBhOMbOuE7e622fdwX8oewimxpRfbgYnmoA5A+gEvV5sEuM4Zj
	 Pa8CPmJ7ig2Tfr5iw7YkYOmhL1kMZugKhulttZ+ERx8fq7tNWxzi/y7ynU0YM5GcSb46H
	 y+QXQu/LEp1hK6ty6KprTGr4OV2uR6/X7OWSUnyRr0Eny6f/2Dyknx1TD05eu5dGn9dY3
	 icz90Cu8dUuWYi/ugsyeY0rxaNGRmSg2c8Z+qNd1TqIUHS3J1tewneAyC6lAG23MdLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GW0hYIN7+IceEmMSeevV4pIzk2+GIFsu79mR7Humawg=;
	b=ZbXXStVU6TyobPL9IFyrnqcjDo8zd7TVjbrZM66ly4Wd8JO6TAV0IVgv49y1QBYJKE3r
	 YPrjb0Cz6Us1+opLZS91yY+SXFCIcyC9wgKpiXrxV77/53D8INhJqA8dUTaq29U78ndl+
	 VeXKgiroftT9dzf0/5icTJTwArVkSkTuxK273o00s+uOHQvj81BMc6UwGyvtP1KXSHXGv
	 0lK9Pg6fWi6ssxvMOGMMLgqLX9YkCO3rClMRfBbRz7z559XDbNI/iJ9R6TSckZzmszEeh
	 R6nLo9R3FyzTzqL88fZkLxBQgt79lmiug30G3Fn1af83NO/F1/31tSagP7kGmpYZQaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gY5H3FMV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E8606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gY5H3FMV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9491F0089F;
	Sat,  7 Nov 2026 10:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046065;
	bh=GW0hYIN7+IceEmMSeevV4pIzk2+GIFsu79mR7Humawg=;
	h=From:To:Cc:Subject:Date;
	b=gY5H3FMVftRNCxW1bmp6I+afKAqar/xGLhdYhrVhEzt/RHPFbS6zfkGAfJW79hyFS
	 DW846UBegj0FqpK7ozF4lwh56gRsChjmJnVHXt7RDf+zPpuzmqnmRW525hFJQWetwf
	 vcCk3Viug+c1KlVeV1hJ9LNGcBrdT0fi5ldw4CAm1V9ASzxsN69GNYOByRN1tL+FMP
	 xZTz2a6q7BMftgJ6PT8BN26pCp83pq1ylqzUc1u77pylyfPhVIq/nzJKBhBpix+SKk
	 nHrpqcW3cW7dnJxSlii09wBbDTkQre9u4d67QQWfvm2SYqPf7MHoZ9yFUNno7HJjAn
	 OaubZHblOEERg==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Protect Roland control activation" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:44 -0500
Message-ID: <20261107050744-failed-6.18-19b42c1fff7f@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 19b42c1fff7f220a6346c614d79ce1bda6d95b40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050744-failed-6.18-19b42c1fff7f@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




