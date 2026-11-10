Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318627;
	b=fp58VLGtjZF7Fnd0SNA4u2/Rl9GxPNJ0MEXpipL6fWDpIgNfpXpn18skpEZ/q2Vm2W1S
	 bjzDk/QwCDjRkwJEJ9HsTONmN+abftEaHmi4aHPe11cm2UMaZMXelPSPVxwUS/6x2IVJI
	 wk8FdoEVl60JOO8v26Dq+nggY0SKNP0piAQajMUQ+vSByCHubclGMAqvVIXlhEvxVWlUU
	 wKk/SrpLWKTzxHNThWGSv+FGmeI+oqfFuMe8xVz10MwY91czqTuLdJR69Mck6cdAIuldM
	 yhXPe/YZrBenkU3G7zF8D9cuzcWKCCRgekiQ4g45mPzVjaVa3osuZmtAB4CNa1hxqzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318627;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7EesqnqZ7xdGFu8ZvrDBetxENf9joKC8YN/fej4+Csg=;
	b=mXGc1Bfx8jefCP0QhjSQwCbU/TrWK1Q94R4fkBUd4c91cUzia8wsXkx7NsP9MIO3OO5w
	 pgvAY96wqrklW37X+o2BDDz7Sz+uR2Sja6McBxrhVX6MuoqK4XUzFTCfDuUHHKKl2DrDc
	 1Xg2e6eFLmNSg1Vuir0PGeqf00YXRNCaWATiwl6Qfkviq8p4YLmnzrshLr4thXGAE05R5
	 lF12/21ibEG0lPCszozvivA7iZ/pJsbP2zI43xhdiipwIDLIbRbWoKIx0KUEajArDsH/E
	 PJJnTnFD9qZzZQkO9/+MvecIStR9n38DBsqBnW/YZN+pkE1M5CdOYLnC64rI46XXTMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwfb8CVD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91E606A339
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwfb8CVD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396DF1F0089F;
	Tue, 10 Nov 2026 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318626;
	bh=7EesqnqZ7xdGFu8ZvrDBetxENf9joKC8YN/fej4+Csg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kwfb8CVD3t1175V8Qx+8feXkEEe2briQRtWVZwZABRtGCOSmsoH01dipLeYKPZEF5
	 z1S7D2ADnzbAs8qtVd2hoTgPawU4Fn0MlWVkpKniRQb/E7wmH4gaP246LtXVWKXjr5
	 wssGn2xDp4PUAoFbYP19QKantf61SvZpZ6HV0MRbHq8DaaTtSQz1tLuos2svj4ygzR
	 OHlZLYI2Rl+js8Bb97RVwUib5zevzT3Y2ZmaQGngScRyDVOFUvmIq1ZMh5i/2XMG6x
	 oO2bvW+cZ1Bwd4q8m9cDKfKwZcNOtOzE1RgzYWoaHwTJneugxBt/RKZ+1EdrQEs+7t
	 /Dy4BGDxEWs3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200
Date: Tue, 10 Nov 2026 08:50:23 -0500
Message-ID: <20261110134954.1794308-3-sashal@kernel.org>
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

From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>

[ Upstream commit 874323b68c93c6808e034dc0113681e822e6fb42 ]

The C200 (046d:0802) reports a mic capture volume range of
1536..7680 with a resolution of 1 (6144 steps), triggering
"Warning! Unlikely big volume step count (=6144), linear volume or
wrong cval->res?" at probe and exposing a uselessly fine-grained
mixer control.  This is the same firmware behavior as the other
UVC-era Logitech webcams already carrying QUIRK_FLAG_MIC_RES_384
(C500, C600, C210, C270, C310, C510, C525, ...), so apply the same
quirk: CTL_MSG_DELAY_1M (which the Logitech VENDOR_FLG would provide
if the device-specific entry did not short-circuit the lookup) plus
MIC_RES_384.

Verified on real hardware: with the quirk the warning disappears and
the driver logs "set resolution quirk: cval->res = 384".

Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261008230844.11246-1-olivier.kaloudoff@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 302736f271932..321eaaf9fa334 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2060,6 +2060,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
 	DEVICE_FLG(0x045e, 0x070f, /* MS LifeChat LX-3000 Headset */
 		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
+	DEVICE_FLG(0x046d, 0x0802, /* Logitech Webcam C200 */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x0807, /* Logitech Webcam C500 */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x0808, /* Logitech Webcam C600 */
-- 
2.53.0

