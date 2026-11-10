Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318959;
	b=W/uluxxHIiMYPCgWCVu1FaKlfwYVjzqSs4niycurW08ogedTvJcfE0Gx9+hIfAjirKr2
	 iHkAXa2uXRdqQXZpZW3o2X/43CVBuiB1m2BTHcgRPXLEfHrXxiXVMyrTP/1A9Ai8ZsMTU
	 iXkNjJ1WGxFV6r3d5v356367GYLV7gOajuhA39lrKJL8rLlfhBcaaiBPtpWnQEVWEisQs
	 wW5OWJ/qcHPrCdCw8BOnAVtUg3sRQpskfFl33XMEw/g0JTpr7Y1Tk2uB2+XWyq2ISjifM
	 8alqY2Z81OaImGFijcGbOASemzftUsSNDLr+jUf1IdR/9uCRPFSdxV+TWEAftlwutiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318959;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hcS3OGPwvmwrrngFYy8jLa3bGHte21mZaEALoMq1m0A=;
	b=mFbJOhW9EaWhuqDUWtziZ3Wbm99gVzzQV6hCf6mUIZIhkvoHcTH0mEVrAIEn1s24Zzc+
	 yKAxWKbSK4Qh+lXdqxHTxa2qCz1vMW7F1+YPsmjwr/+t6Jtjt2vce+1yf7T85AobL8U1x
	 0fopL/N52ti8MpMP3YvxRThIkUl3ZQSmhBTZTDMzTuLWsuwQDIZh4U4+l/BF+JLTzRGLn
	 u3oJqlVvGw079XtyEtDSNziypyCE5/dMRXYxPdbN9A20m3sm3hoGBOinc4HTrBSHbW67B
	 g0E9SCSZjWVIM4kQhFdt9bwrQ3F/Tr6c2KpMyoA+jy32BWducDvhxsP/73PB24K45jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4VLBEkA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CCA606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4VLBEkA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338C81F0089F;
	Tue, 10 Nov 2026 13:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318958;
	bh=hcS3OGPwvmwrrngFYy8jLa3bGHte21mZaEALoMq1m0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n4VLBEkAPSbl4QYbQXgxHhb4Q1CyNtfEFJS0DUJn2tDacGHrN1094TuFXyywHZhUJ
	 tH8BhA92EQNaOkj6flIjPRYVKYp2qxUowbmtVKNGQwlmlvP73D0CYogq30wwXEDGa6
	 8OynU/78GGLVQU9k7aCmCuJJXoYaoqhBM+erQLsGIzBQOCpOlM58GKToch1KNpjk4P
	 1hJ0LgT0Isvbp27TeaBF4vv4LDR0TbynvSsWw/Ur/00c8xWzYwS8/NIEYBfL0F8yeC
	 Eu4L/dVe0k6yGQ5x62GV1JpRrFilIhDK5T1m94+V+TjJR4S9R6RO+Kx+57iD6QD7v+
	 sm3nAypVayRyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200
Date: Tue, 10 Nov 2026 08:55:55 -0500
Message-ID: <20261110135524.1805283-3-sashal@kernel.org>
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
index 52164ae35250c..45a2753d483cf 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2058,6 +2058,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
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

