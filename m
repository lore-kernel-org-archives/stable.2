Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314439;
	b=Bu3bMlOw+a2cQVu4iY648WsmOEdWefMmPpOnH4mBNHfO1Q8DZZR/Op53VJByXrKCwsZQ
	 eKu8kEegvGWbMt4vsE+jyFGzsvLQJTG1ErOvTeJ58vOwYxVFITo/3ie7ID65p0sK47UA6
	 tOeE5UY7TnBHsxLBU4GG7StZwco3icqLz106jOEN1fOfFr7MAlC/PmovWph1edBNmP4XV
	 zw7VRf+YUW4jw4w2Zlzoz88ZNOq7ZkxxVfduLyUziGuKr2sYEUnJO2E7sHcEVdVUa96DJ
	 un+vq6dRmyttcOwLICGPTt5pR6bRKydECBAKxK3mvuMfiuiCfL8fTeFIUiw04351kJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314439;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Q0Tims6CMLKP1f5MlwYRQFdzeObEjB93jiXnU4XaoAc=;
	b=fpU7wYx25svnwGlati/r1VEN53izzZQh3OdXWFmOW9ejiCEaLhbCWQUv4mbFo3++q1iz
	 fuTMSN55jJDUO2MRGXuLVLCGgMk+iwkKdSAn5PCsb1cvB8qGYR+Zp6oltQ1963+Mq29Mq
	 7l1BgaTB5R73iWARRKe61BgWxVi5GVlugD/cT6+a5YvbZBchIzHNtuCzj/5BAmUrZ87Au
	 0xVEvFgmv4BrwQyJXrIisSlK0CNQ9jThNg+MF3ZXJGWOepjh+mO2Fx9JB7N/TEjEuvJtd
	 woPpUYakxXt05W/tOfVnDsoikfYKAMZgj0UbK7yfkq1n2OH1EbcCIz03+/zTgonBQuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhXYM353;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A6B606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhXYM353
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B341F0089F;
	Tue, 10 Nov 2026 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314438;
	bh=Q0Tims6CMLKP1f5MlwYRQFdzeObEjB93jiXnU4XaoAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UhXYM353QzIbOYrm7OqFyY6wKL1p7qKf5KIyqnbD2aEAhX5dCtj0/DzR7yBO9/DIA
	 poKVhL4eJ3blKBtf6vPDwss6gzlu2z8dWAS4QfJYrHf63ogPmmmwHUzh7MKBJXgqKh
	 Ebkd813MVsQ2dwOCpy9nABZzqcxpymsV7l1Q0I0i51a1NEboQNqlmpGVUT9ywiOo5+
	 ZhX13HOBRaQuBVhtI/ctdutj934/EoB6bm4vAHGa+IwKeSTuRDF5IKQ9shsF1lNbfl
	 iSEWjcRdJJBzrZnSvQp83DH7cynomRZkiwz7sLIv2wo2wZIvdwgeyTMJafE7cb+EBw
	 UEmuOZVN5zlBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: usb-audio: Protect Roland control activation
Date: Tue, 10 Nov 2026 07:40:36 -0500
Message-ID: <20261110124019.1376377-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051813-failed-6.12-19b42c1fff7f@kernel.org>
References: <20261107051813-failed-6.12-19b42c1fff7f@kernel.org>
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
[ sashal: Replaced scoped guards with explicit lock/unlock calls while retaining the input-stop condition without keep_input_running. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/midi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index cb9bcfa22afc9..6ac38297c6c59 100644
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

