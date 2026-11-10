Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318341;
	b=hvhnwzy/re7I0AiLn1pkbCGBYlscDaKHcSr19YH+hYLzgISgPd2Q+Ku2TQCTt3XJMjHf
	 geRma6y1veEZVu8iX5aPN1USQwJxqGwJLdojV8YzAmQXHqazs68hvvixLtRj5QAMWXu7i
	 9oQkPTHUOoS9YNH8CyF5Dw5DRQMuE/P7rcu5sTKvqh1WtJJntpuufWXC6OZKKpq4YAIQa
	 KQ4FIvfCyZoLTWct2Ir9931Gyh9O6WuWqIU6QjXVCl5VNc2kjQHKKov0FhRzk9Vp2D6EQ
	 p6yTkCoV8v3X45iRbsx+NkWSsvb6V+abfSW1NVrVIKK0qLEuXJsJRT866m8wNvyVxJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318341;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2hygaD0SVtvEHcKUgS4a7dhStPe1ypTUf1uXJYGdGEE=;
	b=Qf51gStPe0qFQsaLc6E3CqV3xOm2dObqApmF6gh04U4pxOHVQA7kK9ZK/gxqWjAiZDQR
	 6e/VxLeN1/zZMumAlgZ87vdscRsY4x+acIoGvIOGNJcBa1oF7tF4YNEcIJJFKg7A/M9Qm
	 p31agOVkS30URFov7UXBMB6c1XMzLOfNbzf9CTOikHCewflhHrgG4JF1Aze5TI9mpddAt
	 tRGFcwunG5eCXNZijeEc03DRF8C/1vH98WG66jxkeRAir8k3HiHeI2w/+GiiU9HUOv/yq
	 LW2/vrS2je1wDgImS/6sIx4Cv9UCoYobs3vsmulDxY9QPlwQBYSjZPAT02SNZVSPNog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYR2sigU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339D60A3801
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYR2sigU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE081F008A5;
	Tue, 10 Nov 2026 13:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318340;
	bh=2hygaD0SVtvEHcKUgS4a7dhStPe1ypTUf1uXJYGdGEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYR2sigUn9+30f8cRoxYY/WdWKVlrhDQVLzNljkBKhdVzQ8B/7XziZS04pgyVstTa
	 rTpJ8JAbN6VLSocZa7Eab6lxF5XsEXY9HrLtSeKgJL98xH9Yvso4KytoBhyL7YtF9N
	 VuWb/xBVApRmioGm3pvebaBqXZAfMok5MO3kpIWT91hcvyJdTFc/SAxt49dCaCStPX
	 wDE4qg0q/H0M/8OTqcXoGynpwv+yDV0t7ZaNM6rgk379/BldkMi7/fCP0Tx35bnW/W
	 vrh2dyOn26qR5AabO0OUEqZ1pcQ1q1bXiK+tlVEm9jv4aqUbhKRy1UEWAne2CB0mGv
	 Kq9k07hfKQ5gQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] ALSA: usb-audio: add volume quirks for MS LifeChat LX-3000
Date: Tue, 10 Nov 2026 08:45:36 -0500
Message-ID: <20261110134505.1778565-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110134505.1778565-1-sashal@kernel.org>
References: <20261107052042-failed-6.12-874323b68c93@kernel.org>
 <20261110134505.1778565-1-sashal@kernel.org>
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
index 82c8596264047..45145ef7db7c5 100644
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
index 70026525972b0..cfcf9f845ee36 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2158,6 +2158,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
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

