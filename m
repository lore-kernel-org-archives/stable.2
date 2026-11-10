Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318341;
	b=lqCiwDUjSIhMpm7khozI4BTnA9OLVALLYEkYYJcaBtT63aJ3fbEtnPv63oyoEhtKze3O
	 VbyCtqJhE8mby8WUOh5k72q0kXP/ePNJRmjuizAnisTV1B1TwTrhRuC/DOlxKRSzSXa47
	 c3XD20ThZQe4A8HC4yJ9d+McLekfyDsjxgZwLZaR0R/4tX85p0hfpzLvIdzjh/3GJrJsK
	 rhbHd6KsdT0DqnuyeoPe43nMF23W9A7g4tp9I7AzwNLHxWP5U0HDigHRbj16G3qNrm8LH
	 geXzqoUa8ZcoR6njZf03Uhrmk1rhiM9TmdkC2mX92rswS32gkfqHzsAvnsmZkMSu1iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318341;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ycYvR3vVfarx8mdA622tJE/2QomwViUUX8J1OZevYLo=;
	b=M1JrDCslWyGHTV0spfl0dyVek6hgBwJGZviM2QIFWQxhcu24RnUZyVMcBzuieYUDZhbC
	 5N9fg9xJZMwARqQaCBnUWPZkHu7E+9W3A5eKeK66FXJRF2t7laLx9YRI4+9w2yOjoaUf7
	 Uly2u9C45yynlki+9tQ/xXw1OEpHdk5+kjTZBmcXCaRtWVjgGgBXcRUtm/C6cnC+gUQ2O
	 3foXZQS1KKZhnWV5awlSxJ/t9P+hYmeag/rvqgiOQhJrbPVqgJklfFB5BYkiNGcjwuMbQ
	 SDFdp1vODunTnELBGe9By8QGa0k50nPYKukHxvc/q8EvJVN8niXbrunSELy9osdqITw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmcSe54S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23160A3804
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmcSe54S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89BC1F0089F;
	Tue, 10 Nov 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318341;
	bh=ycYvR3vVfarx8mdA622tJE/2QomwViUUX8J1OZevYLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LmcSe54Ss1clYYEM6Glo493NmVvC1Y//ItbprOVimLbi57FImO/4Hfkxgbht/QSY8
	 y/6jCuGjj8riBhNRz0yLjaomSM6dloxHQOHuhAHRIV6zRAlpcft7e/A67xSVVVLEBv
	 Ld9NdBiripD0+bZMyIPjAuHwj5R22o7C4CGV1NRCCa2t+E+tvpwBK3x0mzA60UeXEW
	 LRAakOi88qAutn2uUDs2LUzSmiv9LpkgkTTF8WnGihhf5x7sNPy4n5aSLKZq+SQX+x
	 ew52crz+dUBSBf9KPnQxe42QlT3xTBoyVmuHSHif7tK2qymW9XyMXyWc/aBRIhlLxN
	 Xcjw6SO07PDiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200
Date: Tue, 10 Nov 2026 08:45:37 -0500
Message-ID: <20261110134505.1778565-3-sashal@kernel.org>
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
index cfcf9f845ee36..5a69bd87628a9 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2160,6 +2160,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
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

