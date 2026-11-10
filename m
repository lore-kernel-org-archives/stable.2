Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313626;
	b=jY/DxO1lagwT3ZGsHoswpytFjG07AvYo+kO8xHGrE9RogUV4mCSOabUAmWIAzLdJPd+v
	 JE87+yCCVBP0JEHAuzK6jUHcUPmBlFkS86xjEyuuQYMOcw8zY2zLCoCa7LBZr2kJoL/8o
	 dHoC8ra++JeB6nRQASITCyPOWFRSOXZ4mO485eWZrQJKwfyTxphAu6CZP3cryvYNdQ184
	 qa9gODrCwqdnD2p4Lkd7djajAPrIT3HNT0hpZntL999KSspBbLHvhVw6PuJ2N5sFO5KS2
	 yf8ZNpDgtoppWHWHbWb+sojQff88tIesJCQBEaESgmaj0wK96r7nwSELzu9WQjvFDiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/RxeV+Syp6aOZm3IZ2njKma/GLDU+hNY3cpUfvhjdHc=;
	b=l87O8Mh8tc8UEgI6YbHydAwJbaCkqx1r5KFMXJOhC+BOfoy/pDOe7Bo+iC9xOBU6AfCE
	 Ot76fgZioYaQ4k2/V1XkW6cGTqknM7KCdSUoWhtkyJ7D/VGX1t0v7fggMz/7t030Eo8PF
	 1Js2cjArETC0cLsP0V3VOiPBMZ8itMDOm++VzFO9Fcsz8ECdLJGPxqhgPRz58pKJFnzmj
	 X1kx1BlcoTfZZ8HIemxpfoBXnRpMVLsdVgUoYUH4h2PEh+5+RCU30/3VXuQiI7IseEi4B
	 NHNOO6ZiL85x1ZLxCPJO8V0pDXVZk2mhGcv1PycUgRgrr8l9qWpd/wA4qbPTxN7gTnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USgmbT5s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F874606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USgmbT5s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C2C1F008A1;
	Tue, 10 Nov 2026 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313626;
	bh=/RxeV+Syp6aOZm3IZ2njKma/GLDU+hNY3cpUfvhjdHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=USgmbT5slGbCBBuJnZBB+IDqqrAqdaxCFMjypPw0bVwZpjk6X+5cvp7bAv6OoHuQV
	 MW5wdz/Pzr9L8CeN5+UTpbuJUH3qiErou21Yk1i7aK1yR/2bJ/xh0H6JuLvJ0W2Ghu
	 mTh+OIEcm1FoSyxdEOJe9MNMiiXSLpnTv9zEttl8wpEK2siswUOv3STiibEm5hVq0R
	 Qo1JtNs2dt7DumvUBH22z2lY/WTbRyo0vTFriICqHq4WXSpzFmT1tQn7h6vYcQtmTq
	 ZzBe8zM5dsX0crhoC8wCsbgElkHKkI8PfrTMSIUqndJ73iJP9RBvtrIWQcowvAHMlJ
	 L2Rf6TsM3JerA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicholas Hobson <nicholas.hobson@outlook.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] ALSA: usb-audio: keep MIDI input running for Roland TD-11
Date: Tue, 10 Nov 2026 07:27:03 -0500
Message-ID: <20261110122659.1155489-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050341-failed-7.3-19b42c1fff7f@kernel.org>
References: <20261107050341-failed-7.3-19b42c1fff7f@kernel.org>
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

From: Nicholas Hobson <nicholas.hobson@outlook.com>

[ Upstream commit 2e4c9ab2574eeaa7b893c7d35b4a9f60fd681ddd ]

The TD-11 hands MIDI handling off to the host once connected via
USB. If no MIDI input port is opened on the host, the device itself
becomes unusable as a standalone instrument until its input is
serviced, independent of anything happening on the computer.

Add a per-device keep_input_running flag, set for the TD-11 in
snd_usbmidi_detect_roland(), and check it alongside the existing
opened[1] check in snd_usbmidi_input_start()/snd_usbmidi_input_stop()
so that input is started at device creation and never stopped for
these devices, regardless of whether a client has the input port
open.

Signed-off-by: Nicholas Hobson <nicholas.hobson@outlook.com>
Link: https://patch.msgid.link/MN2PR15MB3472557AF39DC3A4CA9E753FF8BD2@MN2PR15MB3472.namprd15.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 19b42c1fff7f ("ALSA: usb-audio: Protect Roland control activation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/midi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 7e5b1b13360f0..353217b3629b7 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -113,6 +113,7 @@ struct snd_usb_midi {
 	unsigned int opened[2];
 	unsigned char disconnected;
 	unsigned char input_running;
+	unsigned char keep_input_running;
 
 	struct snd_kcontrol *roland_load_ctl;
 };
@@ -1172,7 +1173,7 @@ static int substream_open(struct snd_rawmidi_substream *substream, int dir,
 			snd_usbmidi_input_start(&umidi->list);
 	} else {
 		umidi->opened[dir]--;
-		if (!umidi->opened[1])
+		if (!umidi->opened[1] && !umidi->keep_input_running)
 			snd_usbmidi_input_stop(&umidi->list);
 		if (!umidi->opened[0] && !umidi->opened[1]) {
 			if (umidi->roland_load_ctl) {
@@ -2262,6 +2263,10 @@ static int snd_usbmidi_detect_roland(struct snd_usb_midi *umidi,
 	struct usb_host_interface *hostif;
 	u8 *cs_desc;
 
+	/* TD-11 becomes unusable if input isn't serviced continuously */
+	if (umidi->usb_id == USB_ID(0x0582, 0x0151))
+		umidi->keep_input_running = 1;
+
 	intf = umidi->iface;
 	if (!intf)
 		return -ENOENT;
@@ -2469,7 +2474,7 @@ void snd_usbmidi_input_start(struct list_head *p)
 	int i;
 
 	umidi = list_entry(p, struct snd_usb_midi, list);
-	if (umidi->input_running || !umidi->opened[1])
+	if (umidi->input_running || (!umidi->opened[1] && !umidi->keep_input_running))
 		return;
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
 		snd_usbmidi_input_start_ep(umidi, umidi->endpoints[i].in);
@@ -2644,6 +2649,10 @@ int __snd_usbmidi_create(struct snd_card *card,
 	if (err < 0)
 		goto exit;
 
+	/* start input for devices that need continuous servicing */
+	if (umidi->keep_input_running)
+		snd_usbmidi_input_start(&umidi->list);
+
 	usb_autopm_get_interface_no_resume(umidi->iface);
 
 	list_add_tail(&umidi->list, midi_list);
-- 
2.53.0

