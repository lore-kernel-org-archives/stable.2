Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318625;
	b=a9OcW0qGcOmi7WvLuZFcUsq4undSO7+infjh2rZk+EhSwH8Pyk0ZzakYEJX5rEq/jYfH
	 xU1vPsqIK59Uf5bKXRjEFeda7eAnFAEjrYPQihPnpFTdIDxa6PjB2gJZSf2Z5Ht3flABw
	 aaIgY2MPM8MfcK5423Zoj28Q3eVRsENtACsNVrLzKJ13HVjBf2qJElb8uppGnQTsQRBPV
	 57Y9hoWm/a01ixDDucfodkgXVJ68bORyyVLRxJwaXzxcsHEP50EBnx7hgGMzaIgEzFsoq
	 vf2x/HPGII3xkhWnPu58NYKZ3Umu//JZkfb8+F+7yupHiaXBJt2oMQPVJcM4xBVCsyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318625;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MtBwxwQ0bMjn1bT0IiMa/3+YGKopMT28vROWbS0S8jw=;
	b=LcPd5s0PRSuLCFoWiMPznZPcQtr4XiCpJtzZgMKEHclA+KtI+8RCP+UqdwQs9WUqsfJl
	 bFTBZaQSUyvjtf6hR4XtFFQaV7YOMLhBguEa0ym+KJcIM5vqGdwb/Any5HC6+gRQ+MUNF
	 cK37Wn2CjWW/jnNstJdFH999lqJ1sJvQsFHh+QsKKmRdZrdDApYJURQFIHNyA+fxkpWKG
	 zM5pWMD0qsd9XFm6Fr57bt0rPynbz4ExnDYyPcPwvtzx9DF7Ev75N0bCwv3UFPanFXHaB
	 kdSR8f52Ift34BQgZ01od2726qOBUjzhYt+/d5nUKYRF3dwUuKtT0KCVtmMBJpkY2Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QoVHg+km;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48810606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QoVHg+km
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974871F0089F;
	Tue, 10 Nov 2026 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318625;
	bh=MtBwxwQ0bMjn1bT0IiMa/3+YGKopMT28vROWbS0S8jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QoVHg+kmujbZVAlyawgukxVgI6Yf1e4HcWFit9aIBdV7hgqp9BA3sp7HwjeXVcCQ7
	 EDpNi+o5ukgSnOPMdpOjIu4+KpMwYj1MnVmDOskHuXvqJ4o7/LxZmVwxwtXjBgP+pb
	 bYmBCMtevSDbuyPEKvV0HgKUom7zyyJseYK3vTDA1IOEGNMqfeNF8SMyCZ+jIKiofi
	 86PDX045lIjs//K9aaF9B3GluKnisuR8T7aCZgtRChAEsMH3aI3FlpYxQIqYw998s1
	 t08DpgMfegSDzDUFnJwpVT5xUNNu7H/927loxv2wqnx3osADdoLisFwc+WHEccuk+4
	 aGHf3Vt+qmxXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cryolitia PukNgae <cryolitia@uniontech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] ALSA: usb-audio: rename QUIRK_FLAG_MIXER_MIN_MUTE to QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE
Date: Tue, 10 Nov 2026 08:50:21 -0500
Message-ID: <20261110134954.1794308-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053308-failed-6.6-874323b68c93@kernel.org>
References: <20261107053308-failed-6.6-874323b68c93@kernel.org>
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

From: Cryolitia PukNgae <cryolitia@uniontech.com>

[ Upstream commit ace1817ab49b3f92b3e965caa63b4a78e69266cd ]

As a preparation of introduction QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE

Also make it printing an info while applying

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250903-sound-v1-1-d4ca777b8512@uniontech.com
Stable-dep-of: 874323b68c93 ("ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_quirks.c |  7 +++++--
 sound/usb/quirks.c       | 20 ++++++++++----------
 sound/usb/usbaudio.h     |  4 ++--
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 90de8ae32eb62..e3fda32bac1cb 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -3921,9 +3921,12 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 	}
 
 	/* lowest playback value is muted on some devices */
-	if (mixer->chip->quirk_flags & QUIRK_FLAG_MIXER_MIN_MUTE)
-		if (strstr(kctl->id.name, "Playback"))
+	if (mixer->chip->quirk_flags & QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE)
+		if (strstr(kctl->id.name, "Playback")) {
+			usb_audio_info(mixer->chip,
+				       "applying playback min mute quirk\n");
 			cval->min_mute = 1;
+		}
 
 	/* ALSA-ify some Plantronics headset control names */
 	if (USB_ID_VENDOR(mixer->chip->usb_id) == 0x047f &&
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 5ae20ef3c6232..6f999315cca1c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2102,9 +2102,9 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x0556, 0x0014, /* Phoenix Audio TMX320VC */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0572, 0x1b08, /* Conexant Systems (Rockwell), Inc. */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x0572, 0x1b09, /* Conexant Systems (Rockwell), Inc. */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x05a3, 0x9420, /* ELP HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x05a7, 0x1020, /* Bose Companion 5 */
@@ -2154,15 +2154,15 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0bda, 0x498a, /* Realtek Semiconductor Corp. */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0c45, 0x636b, /* Microdia JP001 USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0d8c, 0x000c, /* C-Media */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x0d8c, 0x0014, /* C-Media */
-		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2125, /* JBL Quantum650 Wireless */
@@ -2174,7 +2174,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x1101, 0x0003, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x12d1, 0x3a07, /* Huawei Technologies Co., Ltd. */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
@@ -2220,7 +2220,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x1901, 0x0191, /* GE B850V3 CP2114 audio interface */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x19f7, 0x0003, /* RODE NT-USB */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1bcf, 0x2281, /* HD Webcam */
@@ -2278,7 +2278,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x2a70, 0x1881, /* OnePlus Technology (Shenzhen) Co., Ltd. BE02T */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x2b53, 0x0023, /* Fiero SC-01 (firmware v1.0.0 @ 48 kHz) */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x2b53, 0x0024, /* Fiero SC-01 (firmware v1.0.0 @ 96 kHz) */
@@ -2290,7 +2290,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x2d95, 0x8021, /* VIVO USB-C-XE710 HEADSET */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x2d99, 0x0026, /* HECATE G2 GAMING HEADSET */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x2fc6, 0xf0b7, /* iBasso DC07 Pro */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
@@ -2298,7 +2298,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x3255, 0x0000, /* Luxman D-10X */
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x339b, 0x3a07, /* Synaptics HONOR USB-C HEADSET */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x413c, 0xa506, /* Dell AE515 sound bar */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x534d, 0x0021, /* MacroSilicon MS2100/MS2106 */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 3c927316bc992..b1ac6e727dc9a 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -184,7 +184,7 @@ extern bool snd_usb_skip_validation;
  *  for the given endpoint.
  * QUIRK_FLAG_MIC_RES_16 and QUIRK_FLAG_MIC_RES_384
  *  Set the fixed resolution for Mic Capture Volume (mostly for webcams)
- * QUIRK_FLAG_MIXER_MIN_MUTE
+ * QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE
  *  Set minimum volume control value as mute for devices where the lowest
  *  playback value represents muted state instead of minimum audible volume
  */
@@ -213,6 +213,6 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_FIXED_RATE		(1U << 21)
 #define QUIRK_FLAG_MIC_RES_16		(1U << 22)
 #define QUIRK_FLAG_MIC_RES_384		(1U << 23)
-#define QUIRK_FLAG_MIXER_MIN_MUTE	(1U << 24)
+#define QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE	(1U << 24)
 
 #endif /* __USBAUDIO_H */
-- 
2.53.0

