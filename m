Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049410;
	b=K+NfWsBDRs2XbzMakgT2YoO6f99lBLS2+GvqxXrf6ac2tvM2PmVrjbi6vNJh6QXb3BKW
	 5U5Rh7osEVmrZT/2Bn8UtJyBIJUvZrymoS8hP/ReLFyajZil67XSyLGKDm6rkgH7a+hMp
	 7Jc+EYsoFPG+5NGHfqLmLw+tPpOpnwhUqsZJVorsh3BfoeduNin4EMEXolqq2plFm1KOA
	 MGIDG+yjLQgtTarkyEijvh6RCeIM2oAjAShB/djQBQHtI7nwueppHbrEC5EEbw4VRzdvU
	 /QWVzK1ARpPDppKQ2TgZZThxMP3zGkX+8dK7bqXiVOFMMRSYWYfcX0yI0/YUjO3hrbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049410;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jCfYE6XLmISefJn3qacWqN39Vc845XaUXRFvEFUyikc=;
	b=NpsHRK8K4YFUvDznXmOsoCsqYB3GFIy8CPEjIXvRlCudUFe50yJbXyllhCcyANLUvA9P
	 ubNaumj0UVO4yKV5WqEPCkSVbGHqfyJQJ4pDVFI0v4BfOexWof5QtCQsz9wsc591UE8iz
	 V4ZU3u5MQyHCvfZjtX0yR3fpU+IZfcrfIMBKqBKebIwHR/hQL19lLE1Oq0+Wts7yOTYTC
	 zC661JbjhfcNl0KdieYJbAW7m5pRCqIesYfg5ytQuo4AhKzG87eGnnPpVOFoBsisgbxlB
	 Kbjb4P54Bsrf958gbnRESKvbdLzvEjCttifMfJjbjj3oRAsyoiXOTKNBmudWMRMQvow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MvJW9/5N";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF164606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvJW9/5N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC371F0089F;
	Sat,  7 Nov 2026 11:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049409;
	bh=jCfYE6XLmISefJn3qacWqN39Vc845XaUXRFvEFUyikc=;
	h=From:To:Cc:Subject:Date;
	b=MvJW9/5NmrYIbVx9oqszfgUBcEq4SSn3UTm57QrwRA1I3ZivwHf56whvDfg1lWxrg
	 sPSU/0YaxccsU574GLmySCuwbYT2aurtbJw/bZzMHZ1APNiAIN3ENZD/eYl17NbWsd
	 lh7ko7l3y9rwu24IvhRugI0seodymtTWjJhwf3jmkQvhIIxrrbhZINheUDwmtPQerd
	 LTJCbQst1R+3vnDc0JNGY9626ja16U51BwkEAxx6SFXAhI5bGJ5hFpdWcwE6x6IH4H
	 lHspdaJLjdu4QQTn+fqJ4J+5cvEQVKJcVS//9Ib/UBTc0WIH0KyRTtKNTBFxq/EPYQ
	 UF5NO5+ya4lmw==
From: Sasha Levin <sashal@kernel.org>
To: olivier.kaloudoff@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:03:28 -0500
Message-ID: <20261107060327-failed-5.15-874323b68c93@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 874323b68c93c6808e034dc0113681e822e6fb42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060327-failed-5.15-874323b68c93@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 874323b68c93c6808e034dc0113681e822e6fb42 Mon Sep 17 00:00:00 2001
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Date: Fri, 9 Oct 2026 01:08:44 +0200
Subject: [PATCH] ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam
 C200

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
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 170f68db74fa4..7a5c95de86ceb 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2494,6 +2494,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
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




