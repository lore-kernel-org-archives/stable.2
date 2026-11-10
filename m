Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318958;
	b=xMRolIjCe9L53/ESGCcFLFOPvzdT/kFqOLBr8A1TNQzWZVvKYEKWUFDY3y2Z5puyxAcs
	 Zzf5TfwCg4pts312F+BopswnITHpsTDaxopL/gzQnSPEwuivRbEIwr+jCsgsnbV4KEdc5
	 gUFeFg9VF4TUAMCK9qIrQ8qB287xr65qGNN3WkqpITrhwA9hJzhTCIASU80pk/FJgf5rF
	 yym3zSeilklB3B911CjselUAhgehDlOSN+IuHZBBe/8LI5XwhdH9RmfN4avlqO8hsMryR
	 D2gYUbcLEJZhBdkSSR7l4YmJntJyl5ts+yXcjauQBKKNSqvgwHr95WORtrSFi3JFAoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318958;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=byqush+IEW+9+DMVVxm2rdgYYJNGdTV2+2ojCRhY9mw=;
	b=ffjSDKSUAdbLbYqcBMUtH3Y8v0+BWrDmwFom9QagE+2gUFDN+yrrrHkMaJrmDcwvV5rU
	 vUvP4W/OpcGO+QprudHB8pzaRxhFsoJNh4V32MZoQ5DPt7JBuxVzEN4RPtUZHIGuygJCk
	 qsAzM07FYf6ekHkRSOJc/oYOsFU4i4gFtSNVHCUOoST2emT/OOXyuxNEsgGDosqZlRIID
	 QglwElblojmOQ/5W0dOluIhrVNWhKLOiE5tFc6Uhomx/avHlxx4rlbzWqGJiB3nZKP6/C
	 MYQVPmMAEbnvBydtPCJTwRE7nz2PuUxoh/dxHWcYmDGewYupa0/ARv+7d6Hsn16jB8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTUO5CVs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E44606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTUO5CVs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C421F008A1;
	Tue, 10 Nov 2026 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318957;
	bh=byqush+IEW+9+DMVVxm2rdgYYJNGdTV2+2ojCRhY9mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DTUO5CVsJlK24UM/EkTHktfbcS9nYfe2IGoFb2vh++1L22+qvgYAVCNWKnJO6Kw9z
	 VRTLx1lOwvEnsOGPGUPEMGQD+GoCl2n1UyeFPxT6xi08kNl10gK5FURQF8V0HPsxjq
	 PMCamFyWY1WdFtvqOm+ggr8frK/ksIu5YVylm3N4JUcqnEYyeousUkSFMi//TSwT47
	 eBFErKECtS7Sck5kQV7Gh67FcaskhUMNA+z1oe8uX8Mmiv20YyrJdmzLWF4rGo2AUg
	 IU2UxoXgMxJW/JjAYrvsCqC7wRuqZRkR24V0ozNOM6AUZDPmbn13VzTkRe8YlXqrKe
	 bACXfdVQdLnFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] ALSA: usb-audio: add volume quirks for MS LifeChat LX-3000
Date: Tue, 10 Nov 2026 08:55:54 -0500
Message-ID: <20261110135524.1805283-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110135524.1805283-1-sashal@kernel.org>
References: <20261107054605-failed-6.1-874323b68c93@kernel.org>
 <20261110135524.1805283-1-sashal@kernel.org>
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

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit 9af61fc91486c7ba93cf1ec3bd381978cac8308c ]

ID 045e:070f Microsoft Corp. LifeChat LX-3000 Headset
has muted minimum Speaker Playback Volume, and 4 amixer steps were
observed to produce 1 actual volume step.

Apply min_mute quirk and correct res=48 -> 4*48.
Tested with the device.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 874323b68c93 ("ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c  | 8 ++++++++
 sound/usb/quirks.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 45a4a8c7a697d..9d54998634094 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1156,6 +1156,14 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 		}
 		break;
 
+	case USB_ID(0x045e, 0x070f): /* MS LifeChat LX-3000 Headset */
+		if (!strcmp(kctl->id.name, "Speaker Playback Volume")) {
+			usb_audio_info(chip,
+				"set volume quirk for MS LifeChat LX-3000\n");
+			cval->res = 192;
+		}
+		break;
+
 	case USB_ID(0x0471, 0x0101):
 	case USB_ID(0x0471, 0x0104):
 	case USB_ID(0x0471, 0x0105):
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 55453873524be..52164ae35250c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2056,6 +2056,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x045e, 0x083c, /* MS USB Link headset */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_CTL_MSG_DELAY |
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
+	DEVICE_FLG(0x045e, 0x070f, /* MS LifeChat LX-3000 Headset */
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x046d, 0x0807, /* Logitech Webcam C500 */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x0808, /* Logitech Webcam C600 */
-- 
2.53.0

