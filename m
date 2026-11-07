Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045821;
	b=XfifqC6ApVuogMwYKMw+okLVhlKohbWbH64EqvIMVEq6MXMtmRkq9mBuecEzdIegI6NK
	 W9Su7sS/t8p3bcxkWsbkUgxfsxaZbnjPwkKxDzE4WxMA9o58xdHvOm147I6FuyHSAN1RI
	 OFqQRBGAfTszuGAXJO1kmxrTkFOqXHE4Y0lJLRPowgk6w6kAUgZa02RCCZhpop+HuVy6R
	 lM8FSHdNCaUe6RNjro3x1t1QmqrRvmKFI5sJrCAIblby8Uoijn0sdjhjhb7Y8yoOJNuHI
	 jywyLHhNa1BfDh2lGSOPlY7UxLHVfYJW3u/O8Og/Okb+Oj/lpbcZ1q7lSo4yGdxx0SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045821;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nXDgaU0zfK0wy1Q7lAKdGe7WyXLCPBT6YDfHoqZwJbQ=;
	b=31AR8y1UMpxe78Bl6blBXGD7hTyVVcuVI71KQGvvBNqcoUobT9OcEouH78hjqqUzhlY1
	 Gg8Dm1PhlTboLETDR2EClAQx4CnLcP8xSIEx6KNL+/wofe/wWUXjbB2pK70drAUV2AWr2
	 KSEd/vfmpv79A7OMIjQaHg1gjcAL7EmGLoGg7O421WdUSsxzX/HnLa4WVPzsDoOmFwf1M
	 gejd6sqShlvGTLIH0G7gkul5+f9GEEnSjUZWNnw+uLixccoPYJQJE5yL+F8MlqMW5P+mJ
	 dguGNIP5BqOJZ4GZLW6IqeH6P4iO3qet3LHkDGYX1QmpVAPzCJvEJYejrcFIUAIr0JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfkYCOO7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A5606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfkYCOO7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44351F0089F;
	Sat,  7 Nov 2026 10:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045821;
	bh=nXDgaU0zfK0wy1Q7lAKdGe7WyXLCPBT6YDfHoqZwJbQ=;
	h=From:To:Cc:Subject:Date;
	b=RfkYCOO7bnIhzCaSCn1nuYqowu/hbgHLzYRnU9IUaWSaJOEVTJintSJARa3pjmLq6
	 fXXA/JXoaXXEtEyf/LcKTvLGg3eEKFm6kGQZxYFZKvlT9jZ3NTcmijQGPFG1pg2knG
	 BTAeoZRT7fZVFCVg850nhQDiwbzRwDb2tI9INq8HnHRgzyObP2AShx9lumHqrBuaRe
	 4vXrpcyaWh4AOvdvc1DjlBlMNuCCvwY3oCvm0pH1UAkvAEQx/3Bp8y510kWCJYnCub
	 2rwOHGYEnVCHnNUqR8lgGrobt51GZCJ2qMV7K/ZxQsvKm1YjqZsxXXCuCUY9J6I3Rd
	 X/vaNd5qy8KRQ==
From: Sasha Levin <sashal@kernel.org>
To: jwuerz@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Fix internal mic on Minisforum V3 and V3 SE" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:39 -0500
Message-ID: <20261107050339-failed-7.3-72107104d4f5@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 72107104d4f522405c9dfdfbaeb230e371c295ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050339-failed-7.3-72107104d4f5@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 72107104d4f522405c9dfdfbaeb230e371c295ee Mon Sep 17 00:00:00 2001
From: Jared Wuerzburger <jwuerz@gmail.com>
Date: Mon, 28 Sep 2026 10:29:25 -0500
Subject: [PATCH] ALSA: hda/realtek: Fix internal mic on Minisforum V3 and V3
 SE

On the Minisforum V3 and V3 SE (ALC245, PCI SSID 1f4c:e001) the
internal digital microphone array never produces any audio. The DMIC
pin 0x12 is parsed correctly ("Internal Mic=0x12"), but the headset mic
jack pin 0x19 (BIOS pin config 0x04a19050, jack detect enabled) has no
presence detect wired on these boards: reading GET_PIN_SENSE on 0x19
always returns "present" (as it does on the unused, unconnected pin
0x18), while the headphone jack 0x21 reports correctly.

The generic parser therefore sets up auto-mic switching and, believing
an external mic is always plugged in, permanently routes the ADC to the
empty jack (mixer 0x23 input 0x19 unmuted, input 0x12 muted). The
"Mic Jack" kcontrol reports "on" with nothing plugged in.

Mark pin 0x19 as having no presence detect. The parser then stops
auto-switching and exposes a normal "Capture Source" (Internal Mic /
Mic) control, which desktop audio stacks drive from their Internal
Microphone / Microphone ports. The existing bass speaker DAC routing is
kept by chaining to ALC245_FIXUP_BASS_HP_DAC.

Tested on both models with the same pin config applied through a
snd-hda-intel patch firmware ([pincfg] 0x19 0x04a19150):
 - V3 SE (Ryzen 7 7735U, BIOS 1.03), kernel 7.2.6
 - V3 (Ryzen 7 8840U, BIOS 1.06), kernel 7.2.7
Both boards report the same codec SSID and the same 0x19 default. On
both, the internal mic records at a normal level, headphone jack
detection on 0x21 still switches output, and the bass routing is
retained (DAC1/DAC2 Playback Volume controls present). A headset mic
on the combo jack was not tested (none available); with this change it
has to be selected manually. V3 users already report that the jack mic
gets no input [1], which is the other symptom of the same broken
presence detect.

The patched alc269.c was build-tested with W=1 on tiwai/sound.git
for-linus (7.3-rc3) without new warnings.

The diagnosis, the fixup and this changelog were written with the help
of an AI coding assistant; I reviewed them and tested the change on the
hardware listed above.

Fixes: e34743018249 ("ALSA: hda/realtek: Add quirk for Minisforum V3 SE")
Link: https://github.com/mudkipme/awesome-minisforum-v3/issues/14 [1]
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
Link: https://patch.msgid.link/20260928152925.69032-1-jwuerz@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/realtek/alc269.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 075dc1aa326bb..13bc741907522 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4464,6 +4464,7 @@ enum {
 	ALC287_FIXUP_YOGA9_SPEAKER2_TO_DAC1,
 	ALC256_FIXUP_IPASON_SMARTBOOK_S1,
 	ALC256_FIXUP_ASUS_SPEAKER_COEFS,
+	ALC245_FIXUP_MINISFORUM_V3_MIC_NO_PRESENCE,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -7257,6 +7258,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 	},
+	[ALC245_FIXUP_MINISFORUM_V3_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x04a19150 }, /* headset mic jack, no presence detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC245_FIXUP_BASS_HP_DAC
+	},
 };
 
 static const struct hda_quirk alc269_fixup_tbl[] = {
@@ -8479,7 +8489,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1ee7, 0x2081, "HONOR MRB-XXX M1020", ALC256_FIXUP_HONOR_MRB_XXX_M1020_AUDIO),
 	SND_PCI_QUIRK(0x1f4c, 0xb020, "Minisforum AI X1 Pro",
 		      ALC245_FIXUP_MINISFORUM_JACK_DETECT),
-	SND_PCI_QUIRK(0x1f4c, 0xe001, "Minisforum V3 (SE)", ALC245_FIXUP_BASS_HP_DAC),
+	SND_PCI_QUIRK(0x1f4c, 0xe001, "Minisforum V3 (SE)",
+		      ALC245_FIXUP_MINISFORUM_V3_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x2014, 0x800a, "Positivo ARN50", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2039, 0x0001, "Inspur S14-G1", ALC295_FIXUP_CHROME_BOOK),
-- 
2.53.0




