Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046844;
	b=uWj5ngFwHfQPb47mA/23pBTpg+MT2hoXOW7cyIR3sr1AgYZypBWhpC93waq244IIxu8S
	 b7yt31UhcwKT55fBjnymn9vAyaB2IPKArJni+bVhxAvbEyiWBzzCTuNfciqCgmsRYgIqz
	 3sNgyZHY01y0ZRHcQXw9rd64o3K9mv09f//GHH2i2r2t5/7u5qWSQszGtcFdP2nXcl8+q
	 T1qeUSn6jjQqRWQvb7hRB06pGnaldooQ6sZcTHDj1eDs4dPeiTG9Ur2u7SDiSVpVph/vb
	 D1+20w9uiD6LrqfgJPYpcJd9nTo+lIxBsneyvQ/49A4v62qmd3lf0Jb2z+vs5um0fdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046844;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RRb7UGcr65HWo7OKR/XmmW2GPQzM51G21zQqJ+n6tcY=;
	b=AH93mN5M1LMrqf1q0xh3A+FCt4joSLQgX+LGv9om8w07uIORKukKSDV8cM1TobZwg6aQ
	 KpgeH32jRcwKkBTFpbnBNpuyUqW+KqyKriG1HnCZnI/Kcdq0+jXpfzLz124AfX7k3pu1Q
	 bHPnlqvW3RoEzVvHdwpxMgRjNEKWv5OR2Tz7Lz9KB7MF1euWv3ekoLg+PMbXBaShHUaF5
	 9yy7vKjJE9kxLBnCIt/CN4nWTQvuIw+2iCds2qmTNsagXiS4XAQ0FcOonAIXYCQk1aelf
	 PSAmmfULj/yDjNl2rSv2PvH+NN845e5tCSnO0FBfVvXD0AHWOcJxKUPhocZkiARjIAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4QvZioQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB1606A334
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4QvZioQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E581F008A1;
	Sat,  7 Nov 2026 10:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046844;
	bh=RRb7UGcr65HWo7OKR/XmmW2GPQzM51G21zQqJ+n6tcY=;
	h=From:To:Cc:Subject:Date;
	b=I4QvZioQErjlRoIboHnTZ2j14A2XwxdZVFj7LybBy4gUK8uGYzycDwjnukAc5kDxy
	 mWgrO3mc2gQLo8J3Wl0zTCuW/kuLrB2G30HydXcjvp6Qa1uFxASkLlrx1TJ0/mX34v
	 isnIHc7zv7s5TghxGlD8W6aJuTdVYaG3oeshrq/9TheIUkTvq7neX7RIrpbnldoyBa
	 E57zda78rNgrBBqpkcBYKNVxdpA1uMxvUj4KO3HaZPDjSGZ8nFfdU0n8TQC78gf9Gk
	 huSz+IyTWJ5UP0QzM3U/RX+HdvWsAvH5ciuqaFF9+d63pRQQdaF8y0v9MVyEu7Cgz9
	 y5Llsk+A1ivnw==
From: Sasha Levin <sashal@kernel.org>
To: olivier.kaloudoff@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:42 -0500
Message-ID: <20261107052042-failed-6.12-874323b68c93@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 874323b68c93c6808e034dc0113681e822e6fb42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052042-failed-6.12-874323b68c93@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




