Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313947;
	b=ZR1Vn7l81OZa9eMnWtRmN9bA15RmUXMBxtEUx7QFTF9SzAI1MLyzc5STwW+KdMBdguB+
	 s1FQd5dA5KR1WEa5qrb+vBMKm8QRIAQXNwmcoZenQN6t2ZnlcafPjc9dcyWrTiMfMfBOS
	 Dsn9u4X5CsTtynQXWFu232fRhLNiQ9Vs7GYhlGskJn+OxplQz2SG7eWS0gHi7uwIxVzk/
	 hZyQW/hKXwoLWKlnWE2Em23H1adcrCFrHdYXpDIplk1SaHCRlYzEADc62+8sGLGQvyB8a
	 18JbtBp7gaDiqDV+gGaBejQonDVRqPN/5KjHG8YKyctpq01uX5+0E3MUXLEjGqq1fYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313947;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=f9B/Xow4vvH5tof2ioRNBZqfvIMarAsslv7GTMaadmY=;
	b=rT8I2fUDc0ODxX0BLTDa0QMMrETriTTXf8QF9SC9tktEFfYUO46WZlQSjFDbBXygseAi
	 y54dfVfgo9Rg4ntd8RtHr3TGhJGzqD02IAusqAskS/3E+DFpTVr3ZZKaJ+FCBWvpaMVwM
	 GYFiYODiwPiMGqjDSKcWvfaZvS+pwdAECgYvRhIfVq6BiflUnUczDlw3hjXYorGTQS/uR
	 0fm429KpLkM5tG1mqeVr3qqPPFvOnEbijIpGh0v7jOvSbKOig3CakLfaTswMtGAqkbxCT
	 5s/XV67pZ0lITgHuq/dPL/q12rcQS9fz6zOWJG3Nz0opUUT9u0GzMnyHJSl4gt+zLMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JR0jL4ca;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D50606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JR0jL4ca
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4251F0089F;
	Tue, 10 Nov 2026 12:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313946;
	bh=f9B/Xow4vvH5tof2ioRNBZqfvIMarAsslv7GTMaadmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JR0jL4caMclVpMvD/G6gJNuV9FEpkS2G6tNQCZkCAbfF8zCcSWagR6dgsCgGAocS6
	 otuyUQJK/9pgtfS1M1C/h6hDv5GjPCvRPdnZ5/LLD2zs5U2hxl4YGeix+KiTaLgbIt
	 ElYpqotXol7sq+GCrvsChc9OQvjiUN6qtXZEch9AC0vJHc8yeTy5yPSJu2jSHV/i/C
	 EUVCAmW6WF6PVCnWo3uercxj+Lhae14YiPLkNMnWGbs7gaLSQtMpSzczwRDEWHe3If
	 K7pSbdbSqVSeKqvwRz5wo23uMvL2knNu8TJ3DUmAz+OhBBGYkkRnjLAktTP6HpDGaD
	 VFDDDqyLKzesA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicholas Hobson <nicholas.hobson@outlook.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ALSA: usb-audio: keep MIDI input running for Roland TD-11
Date: Tue, 10 Nov 2026 07:32:23 -0500
Message-ID: <20261110123217.1265796-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050744-failed-6.18-19b42c1fff7f@kernel.org>
References: <20261107050744-failed-6.18-19b42c1fff7f@kernel.org>
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
index 787956252e800..30d0684920319 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -113,6 +113,7 @@ struct snd_usb_midi {
 	unsigned int opened[2];
 	unsigned char disconnected;
 	unsigned char input_running;
+	unsigned char keep_input_running;
 
 	struct snd_kcontrol *roland_load_ctl;
 };
@@ -1168,7 +1169,7 @@ static int substream_open(struct snd_rawmidi_substream *substream, int dir,
 			snd_usbmidi_input_start(&umidi->list);
 	} else {
 		umidi->opened[dir]--;
-		if (!umidi->opened[1])
+		if (!umidi->opened[1] && !umidi->keep_input_running)
 			snd_usbmidi_input_stop(&umidi->list);
 		if (!umidi->opened[0] && !umidi->opened[1]) {
 			if (umidi->roland_load_ctl) {
@@ -2258,6 +2259,10 @@ static int snd_usbmidi_detect_roland(struct snd_usb_midi *umidi,
 	struct usb_host_interface *hostif;
 	u8 *cs_desc;
 
+	/* TD-11 becomes unusable if input isn't serviced continuously */
+	if (umidi->usb_id == USB_ID(0x0582, 0x0151))
+		umidi->keep_input_running = 1;
+
 	intf = umidi->iface;
 	if (!intf)
 		return -ENOENT;
@@ -2465,7 +2470,7 @@ void snd_usbmidi_input_start(struct list_head *p)
 	int i;
 
 	umidi = list_entry(p, struct snd_usb_midi, list);
-	if (umidi->input_running || !umidi->opened[1])
+	if (umidi->input_running || (!umidi->opened[1] && !umidi->keep_input_running))
 		return;
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
 		snd_usbmidi_input_start_ep(umidi, umidi->endpoints[i].in);
@@ -2640,6 +2645,10 @@ int __snd_usbmidi_create(struct snd_card *card,
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

