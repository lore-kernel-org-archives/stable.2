Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318626;
	b=v6jgElHV55RwubF0WJDUz7z4ldbFZAahffC76fqsq7gfyI6pvbQT7i/Sv/rsqZtCDN6n
	 g3Y61Erz3UjeWDZ2OX1IbPYMYkSVN0VHvjdJAOOResJ8HJ+ig+IyfylEtkHtdGzjAAi/v
	 ovKwaccsVFsl9k/FbMhY9qt4JHUeKCHKrV++hAXwC6ujVzr5A+WXOcmpGuEsrlg+bpquo
	 rJfw7qWKbFY3xJNet8bsKJFMUMAwyaQRCLm16aIzcpJBvyHXsj8ifYtezA+K7lYr6rDEm
	 HIk1dM6h99eysMYydmU6aBN7MmGcPdliUo9CRzLl22I8smilZFfOlNLxWPpLpcOROOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mD6LdiPWsWdmFPNcDKvkc2RTAQcXuQcj5M9eLkHCwRk=;
	b=5XVkJmVKQCUSt+XnbcDPf7qoo6FQvs6P+/IEklo0nm8n7jpetDsXq9PH8j1goAQg/nqE
	 jqpgEUP3nK58ZXUSj+0PwbCwZrdnVjPPhx7IQKBfsdxhRFmxicl5SieTnIiYD72V41NJu
	 N3tUogYfCAlpqIddtXVMdRYWAfEzUyBfVkd/23EGqJY984+LyXR1xKyYwIlxfCppBdUEg
	 uFNc7yWyxVaedi6u1IDyzAtbEYWhc7/8c4woreEOft9q6lEhrZ0Mnogv121S/HYuIGtn5
	 DZadXsN2pGof/3hlRUNoi9VxOtFcgTGm9EeOEJJzC9ic2M54wHX4DPA5meKuJubT/pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZmV3gto;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C3606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZmV3gto
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6683C1F008A2;
	Tue, 10 Nov 2026 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318626;
	bh=mD6LdiPWsWdmFPNcDKvkc2RTAQcXuQcj5M9eLkHCwRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cZmV3gtoG5gdZXTQhK2xefDXOR0j0EX/+a3tRYoFzcqQfrQXN4PKBRQz6PFb/HZAF
	 ieYDBdsHq/QvcLBO2G40qV6a9uL1TSD7piKRLYKmahS2VwPo+6ChVSSByWJaOKQg3P
	 YEqQyxCdcRJLjwSviTj5jC7YUXdm1nLH+jPtElxQOPhtPXaoWehIhZ9DAecL5m2tmV
	 V1Q0kHEoc+6TtW8RQTQ3f8tOpwsRSk60dl4WTQLxeZ3ZsULR7pN4liZwJDwo0TT8zP
	 XFvCQy/BrE+LjhXVvBKahL6tPpLIRm+Lk6pIhXSdtI7XOKl1uUjjwRmhp90PE8QtMh
	 1/+S40qkUI3ZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] ALSA: usb-audio: add volume quirks for MS LifeChat LX-3000
Date: Tue, 10 Nov 2026 08:50:22 -0500
Message-ID: <20261110134954.1794308-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110134954.1794308-1-sashal@kernel.org>
References: <20261107053308-failed-6.6-874323b68c93@kernel.org>
 <20261110134954.1794308-1-sashal@kernel.org>
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
index 0a729ec282179..e70853cfec65a 100644
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
index 6f999315cca1c..302736f271932 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2058,6 +2058,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
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

