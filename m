Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315310;
	b=GfmbYtoulsOoc05KPbFitdVX6O0M+Go7WfS3JryiwuYcZLLnLsSUBJLab3pv0RhAcoKE
	 rZEFPkU7V+sJAuh3kt/8L5nfcphvmQLAZ+ToC6A6R6imKEjfpJAz0av7gXdUC0HL3zZCs
	 ShTKpO5DyaRJZzGTxERPxYgZE9u7wEQsg1DOtDp4r3sQc4RSmS5V9nL/ZpOn4hM9gubR4
	 yg+DEVPEgokDxwHIVHYNOEf4vJRU01KzD5MQBoCpKmoOnefgjtnpKKa5YkeFTAiSt7agV
	 lBvSfbbkx1ENyQ5VvUIEuiE1HKEOM7YnaXS8OF2qzMMWRoQ3hSXRfa2koSSzzQuguFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315310;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VnVgPcvZQYH9Bb2Y06JT8fiCgew8JY0jabFdehxiU8U=;
	b=DOlAXWs1TjCaSohhNP08Q0f3MYgddp/h/EPh4jn8RyqzlcC3auAHJ1nHGMEo53bUmgYv
	 DIQbiS2xmqHDlq0xqxfIKNC2EsKmBKX8rE3/YeIqSzi+EaKnQE384+pzLZcU40Oce7DpE
	 hb2NKdhpF94XFmyzG4joFYiNcC1F/GtuoGShogFy/SqATPZK5cS8wTtJb4g3kkPJwx/c0
	 e9CzWGPAKiWMNoTmVSKHQk27DZOtnjVs88iirX/nPgZt15F42sv6qCNd+aHutJrNFX8FM
	 po2CNRbgk0ygRvm+BGlv5DB0pTOwWfY6AA0Hnhm/wFB5jSmrpQyPy0Tguwo80KCAcpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmKjid2W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7C60A2622
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmKjid2W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A561F008A2;
	Tue, 10 Nov 2026 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315310;
	bh=VnVgPcvZQYH9Bb2Y06JT8fiCgew8JY0jabFdehxiU8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cmKjid2W0fUCwu9k3aI065DM0LwLQkRcZQy4uOzKYAmq5uR2aT49BG96DSH5KRW0r
	 cq9TbbpHfZh/fHwHvyQYY50EipvakwdQp7CH9bAfPLZcUb6zh8AFNLrl0vX+OqU87K
	 EHnCVG4jxK4p6H4wWku7tWYuN9CP6dJf/5vpieuUBFa7bJuNteDk0GRmXNW7HiiUkZ
	 gptE2NFaX8o1ZrXWWregiZHNs69bSYF30x5PNNBJ0BloKPzmgeFz2Rj3D4uYYJO4Bw
	 pO22vpnR7dHLin5FNZZv/PvUsMzNpqlXBd/Hznl4yoNmQBTLptRv8anlhUnuEXJ7U9
	 dK5D4zELWueZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: usb-audio: Protect Roland control activation
Date: Tue, 10 Nov 2026 07:55:07 -0500
Message-ID: <20261110125450.1544189-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060059-failed-5.15-19b42c1fff7f@kernel.org>
References: <20261107060059-failed-5.15-19b42c1fff7f@kernel.org>
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
[ sashal: adapted guard-based locking to explicit mutex and rwsem lock/unlock calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/midi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 4738d70ed75f3..70084be58f0fa 100644
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

