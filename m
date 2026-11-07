Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046169;
	b=4RjnMsgKdJUP5jOhsNz9F6J429cydQSqF3e2DsRfGjxlh/mI8SOHnFiyd+SF6UyQGlfP
	 GXsUvvVgjmap+iBVWSTQFMzbWWqz2IctyAPyerOrPstZ1y9lRl9SgYImf4IdmZkLIECI5
	 ryh88E09KBqU6zYXfaJQoqHe1NfxmeJHpfPUkJ2CIQVGPQrUeQFCh2Y5t5UteJ6nOzlpR
	 QXBfr0IaOaIp1Zj2pHmTbllEupXqLh/V7hghMpQkGmenWIpJfYfc9hNYCL+ORMeera8Ub
	 u4KT4VfuQBSNGFPxa5kR+vHD4QOA+jutkB4kYYdLO+NIJ+pHZxjZqH47wdyo0Fr14RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046169;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=m4SvpHFD4r0ymSYTUQ9tN3gdqr8TfDTbYcjnMZXYdeA=;
	b=BR+N6jZFT4BKx5zYhPhJ0lXxo3G0cCAas+0ZrPeEr8WsQDh74kXB/chfLpUWiFsmbB9Z
	 QbJCF3SuDzavHqyRDROA1aL1yPZFSJX1qVdCKe6AKlyVDIQHf/6BZprF+VUicyzdxMLGb
	 l6ThI8b8CQyaKd+jdL9FiWhckTGI+EMo8AtbXvNvSwGsks1Tl1fs301Nc0XVk8Tm45y1S
	 UqA8xa2nEgHW/m0A4j7J1Nqf5JU7RDbE63olEclc3dzggs8ADHbrTnR+OyxSdxWL9wesi
	 SazmGF/IQYO+NDWy2IM6KBnhLfr7WVQiEN1Eq0R9gUIpufkKuHDYmgHN54dHrDETH1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/hfol+O";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F4606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/hfol+O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF601F0089F;
	Sat,  7 Nov 2026 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046169;
	bh=m4SvpHFD4r0ymSYTUQ9tN3gdqr8TfDTbYcjnMZXYdeA=;
	h=From:To:Cc:Subject:Date;
	b=Y/hfol+OFDypXflxdESI06dOR1JYcthkOZ3uNpiOIpU4iC9SiZlCuCRqj5yceatL1
	 JQ3u0FKPPFNOmZ1UEWGNLStnNJUqZ3h1U76DlIQ2uW+bOepJZDj+Rmyna4cGb4FuQm
	 jx9IN02EIChaT30Lf/2xbS2nTnvEal7DicHSvntx2KFk9TXn5YtqhbFxQtPFY+UqTa
	 D92cPrdLP1StZk4LteoWzRuIEcE3GvSU9SRsG0kddW8iKgyyGEBt3QzshKTx8vEdhY
	 TxuGwJSp6E9mpScgGfDFNM0FSoQj3wXTowoXbgAHb/0YrMqpyIP4v6V4b+Sf7h8xL+
	 r5kwwrl8E8MCA==
From: Sasha Levin <sashal@kernel.org>
To: matej.sochan@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Fix silent speakers on Lenovo Legion S7 15IMH05" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:09:27 -0500
Message-ID: <20261107050927-failed-6.18-1c36207da794@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1c36207da79455402d981125fa09716991364e66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050927-failed-6.18-1c36207da794@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1c36207da79455402d981125fa09716991364e66 Mon Sep 17 00:00:00 2001
From: Matej Sochan <matej.sochan@gmail.com>
Date: Wed, 7 Oct 2026 22:37:46 +0200
Subject: [PATCH] ALSA: hda/realtek: Fix silent speakers on Lenovo Legion S7
 15IMH05

The speakers on the Legion S7 15IMH05 (PCI SSID 17aa:3811, ALC287) stay
silent after a cold boot with the current quirk, which applies
ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS. They only start working after a
suspend/resume cycle.

The amplifier setup is sent through COEF 0x24/0x26 on NID 0x20. On this
machine the first pass of that sequence appears to only wake the
amplifiers. Sending the identical sequence a second time makes both
speakers work, provided the second write comes a few milliseconds after
the first: back-to-back writes leave the speakers silent, a 7 ms gap
makes only the right speaker work, and 8 ms or more is reliable. A dump
of all COEF registers of NID 0x20 taken before and after the second
write shows no difference.

Add a dedicated fixup that writes the sequence, waits 20 ms to keep a
margin over the measured minimum, and writes it again on every codec
init. It chains to the same AUTOMUTE fixup as before. To share the
sequence, move the verbs of ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS into a
named array; this has no functional change for the other users of that
fixup.

Fixes: 67f4c61a73e9 ("ALSA: hda/realtek: Add quirk for Legion S7 15IMH")
Cc: stable@vger.kernel.org
Link: https://github.com/CachyOS/linux-cachyos/issues/792
Signed-off-by: Matej Sochan <matej.sochan@gmail.com>
Link: https://patch.msgid.link/20261007-legion-s7-v1-1-8ea7fb7ee766@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/realtek/alc269.c | 92 +++++++++++++++++++------------
 1 file changed, 56 insertions(+), 36 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 447c0ba358d85..a68b6a9b71aa0 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4377,6 +4377,7 @@ enum {
 	ALC236_FIXUP_HP_LIMIT_INT_MIC_BOOST,
 	ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS,
 	ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
+	ALC287_FIXUP_LEGION_S7_15IMH05_AMP,
 	ALC287_FIXUP_YOGA7_14ITL_SPEAKERS,
 	ALC298_FIXUP_LENOVO_C940_DUET7,
 	ALC287_FIXUP_LENOVO_YOGA_BOOK_9I,
@@ -4529,6 +4530,53 @@ static void alc700_fixup_intel_hades_canyon(struct hda_codec *codec,
 		alc_update_coef_idx(codec, 0x1b, 0x0400, 0x0400);
 }
 
+static const struct hda_verb legion_amp_verbs[] = {
+	/* left speaker */
+	{ 0x20, AC_VERB_SET_COEF_INDEX, 0x24 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x41 },
+	{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0xc },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x1a },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
+	{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x2 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
+
+	/* right speaker */
+	{ 0x20, AC_VERB_SET_COEF_INDEX, 0x24 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x42 },
+	{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0xc },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x2a },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
+	{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x2 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
+	{}
+};
+
+static void alc287_fixup_legion_s7_amp(struct hda_codec *codec,
+				       const struct hda_fixup *fix, int action)
+{
+	if (action != HDA_FIXUP_ACT_INIT)
+		return;
+
+	snd_hda_sequence_write(codec, legion_amp_verbs);
+	/*
+	 * The amplifiers accept the setup only a few ms after the first
+	 * write (8 ms is the measured minimum on the test machine), so
+	 * keep a margin.
+	 */
+	msleep(20);
+	snd_hda_sequence_write(codec, legion_amp_verbs);
+}
+
 static const struct hda_fixup alc269_fixups[] = {
 	[ALC298_FIXUP_RAZER_BLADE16_2025_PINS] = {
 		.type = HDA_FIXUP_PINS,
@@ -6593,41 +6641,13 @@ static const struct hda_fixup alc269_fixups[] = {
 	},
 	[ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS] = {
 		.type = HDA_FIXUP_VERBS,
-		//.v.verbs = legion_15imhg05_coefs,
-		.v.verbs = (const struct hda_verb[]) {
-			 // set left speaker Legion 7i.
-			 { 0x20, AC_VERB_SET_COEF_INDEX, 0x24 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x41 },
-
-			 { 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0xc },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x1a },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
-
-			 { 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x2 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
-
-			 // set right speaker Legion 7i.
-			 { 0x20, AC_VERB_SET_COEF_INDEX, 0x24 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x42 },
-
-			 { 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0xc },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x2a },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
-
-			 { 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x2 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
-			 {}
-		},
+		.v.verbs = legion_amp_verbs,
+		.chained = true,
+		.chain_id = ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
+	},
+	[ALC287_FIXUP_LEGION_S7_15IMH05_AMP] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_legion_s7_amp,
 		.chained = true,
 		.chain_id = ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
 	},
@@ -8348,7 +8368,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	HDA_CODEC_QUIRK(0x17aa, 0x38d5, "Lenovo Yoga Pro 9 16IMH9", ALC287_FIXUP_TAS2781_I2C),
 	HDA_CODEC_QUIRK(0x17aa, 0x38d6, "Lenovo Yoga Pro 9 16IMH9", ALC287_FIXUP_TAS2781_I2C),
 	HDA_CODEC_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
-	SND_PCI_QUIRK(0x17aa, 0x3811, "Legion S7 15IMH05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3811, "Legion S7 15IMH05", ALC287_FIXUP_LEGION_S7_15IMH05_AMP),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
-- 
2.53.0




