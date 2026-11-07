Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047590;
	b=PD5n6XMZG9in1x8EBdVdktPJP2h3FdQQ69C+mRLAgH7N0yJR6QWTLqAsfm255ieTN1VH
	 rwW2p/8W4RhKCLL9dcom20OYzprC4Bf8g6d6uiVF6uuLUTNUd/xwwFZwm/lu4/GzWJYDQ
	 Qm0yRdEwMzkFJkRUu1Mlk0/AeFaaCvryyRSDKeVMEq5a9ZjS1aA1sHvQUj/dKy3R0MNzT
	 d7nuSUHZ7jBx36VtobwgvyTjf5DOh3519jMQfN9pEvHhjRSn8RRiK12ccmky3tVSavf0E
	 iHiFWu1a+uf4j8kScH5yI87zmNqod9hskIogo5EKMjUNoDMXOXgaMtaZaw4fPVUy2mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047590;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=H1pc50CLvy9CRuGISxdUiJVME5NFLsvJQa4EMyP6FYA=;
	b=4N4WPS4QdvjpdjRCYJ4MYBVJmz/p5WaF/m6NPuhLf5MD2S5HIyHGbvPIGhOFVn9oxhdQ
	 U57jT3SUBCw+jRie+JEgJZ9FHaCo8uEVxIJTMmr2bdMq+Z4BSHUZz4Ok01EoOZ2cdC62a
	 nJqWxbwk7tKMqoAaAvFmlFjY4zLk3HLA5vdEdizwNTmj8EaR6oXajZzO7q7qYBq1iROxQ
	 GWFqVgaM8SKGF9q3KLZ4xeFdIkgHHQGiBtxiuUWrB+YeT8iPiekNI9G8zTGjg57Qz+MQg
	 xOIM71LaI8pvkx8jY14Gq2h/rsmJnJj5BAgq8kyeQFbY/9y5jxJ7UP4u0D6XMmF11/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K1t+lk/3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83121606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1t+lk/3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11181F0089F;
	Sat,  7 Nov 2026 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047590;
	bh=H1pc50CLvy9CRuGISxdUiJVME5NFLsvJQa4EMyP6FYA=;
	h=From:To:Cc:Subject:Date;
	b=K1t+lk/3JDatok/A2UbByJNO/wPEkY7fU3WSDekpb6xadDzLsvu/95FX/AvRK/P/j
	 SU80QxKnGQ9yEBXffrEkmJucdsi36ykjt+pRfCLYLKvqnQ4pSiAC+I/t3tbzAYVF4+
	 jXUKt15tZ8Cp8/4700SusHzo+9BYGditTfi8rcAHYHvY/ueQf60j9GvmR3hz6HzKQs
	 +eSOarrRr1LVsrmL+wKGmMQYzl3LfQ80outTtrEMbrCOh8ZQNTJSK1ff7Uf+tIr18Y
	 IA2VepExnfXVO1Cj5kUTLyHrBSCSgB+cqKWezUHkmReYOh/UVKivEZjC46aqskCPNc
	 qjakLNaT+PPUA==
From: Sasha Levin <sashal@kernel.org>
To: olivier.kaloudoff@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:33:08 -0500
Message-ID: <20261107053308-failed-6.6-874323b68c93@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 874323b68c93c6808e034dc0113681e822e6fb42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053308-failed-6.6-874323b68c93@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




