Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312168;
	b=RnoY0JPzQ9hgy7WKd4o/RQojdAN/GdPJlJrJjl99nu5z+VQAE8Safgm+zy4QpLe1TBgX
	 9C9Lz3y2DDUkxHWuDcZ6wSp3c7P8Oc5yLqXTSmhAwNAvY1p3k1chnDtNNFE2FjA9/rG5t
	 z2p0yXavoRd79KYvE3/w83TYGISqIOI3AjMvI2rod5DIyl19WFUOj1Hb/7/MuAqHCv89R
	 pIksVDTNZ2lAwOsapCFP2OA3nOdXa9iW1IQmA0qG1/iuSoe06VlMYlz2JhRiEbtlCCBhK
	 jPcXedralm0W5nyprtjQDN5sxyh9fOraxBlPic0CVR88xnvshJpNUVGBScM+SpLYwuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312168;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5l1q2T+ZZgJ465GZqeKwCrV6ITTqS9cr0u7iYLu7XXk=;
	b=reVbcPfS55W2gdnXL2uFqM3Vx1O/+5YsH/Hn+oAmslHns+gx1mo4LY2NM0KkwURIRiiP
	 ilM79d+hFuZzAeXrSyMydaHaZlwzqTNDdp6MzyXbzDDFQ4laWpUiF96v0MbucqibwgHMM
	 QyBznw9h0TWggvd4e/leyepJrFAp+839Ekp8tigpVg1nGtaneSbgL+OXC6etqSfbdzlht
	 D2dvcEXlQCmbZfQJezN3/vMr4TINft1XFuNhJhPwf2At/H77/0byuKfjTs7K51nCSI8an
	 kA9i9xKMTRBGUJq/iJU1jUiliPs4XdPbog5LU3I95x7tG2zm2lHjN70PXXPqck5jllg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BluV4EW+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BluV4EW+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6881F0089F;
	Tue, 10 Nov 2026 12:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312167;
	bh=5l1q2T+ZZgJ465GZqeKwCrV6ITTqS9cr0u7iYLu7XXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BluV4EW+eYKJrzTmtb5Iy194xF4ZRHN3mPhVbU8cyl3+qX7uI1kCjMS0GS5eP+9pt
	 UguWb0Qeo736zI3Zy+dXbSjPJg9FJYUCkDAJArbTUMKoGn85eu/pjTzIh+ErGML8PU
	 SGhcDwUb+y35/qPlQqzKLidIpkXnYawVep9LDXbxrpLdCXsBAWZut70E+p/xdLb6w2
	 Y1N+/7pFlNpM+d9kGTHAPrwLJGFTzghmMgTgmTJ4eDsF00uE3SjC/GJTxTkBnwrnv5
	 1bEaN1USZcOh4LkYT7H+NukU41lSBygwCm9d8RfGsGGQ8kqRuBqOX+FW0OKMrHhUr8
	 xf+DouRj8YoBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Saim Masood <s.m.saim074@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] ALSA: hda/realtek: Fix speakers on ASUS ExpertBook PM3606CHA
Date: Tue, 10 Nov 2026 07:02:45 -0500
Message-ID: <20261110120237.930943-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050339-failed-7.3-72107104d4f5@kernel.org>
References: <20261107050339-failed-7.3-72107104d4f5@kernel.org>
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

From: Saim Masood <s.m.saim074@gmail.com>

[ Upstream commit 556cca74b6ec6f0bc6a3dc27473487de3cc8c8fe ]

The internal speakers of the ASUS ExpertBook PM3606CHA (Realtek ALC256,
PCI SSID 1043:3501) stay silent with the default codec setup, and the
headphone jack is not detected either.  The codec needs COEF values that
differ from its power-on defaults: COEF 0x10, 0x16, 0x35, 0x37 and 0x57
on NID 0x20 have to be set to the values used by the Windows driver.
Toggling the codec GPIOs, and the existing ALC256 fixups alone, make no
difference.

Apply the COEFs from a new fixup at the INIT action, so that they are
restored after resume as well.  Chain to ALC256_FIXUP_ASUS_MIC_NO_PRESENCE
to keep the headset mic and the jack detection working, which the
fallback pin quirk provided before for this machine.

The COEF values were found by the reporter of the Ubuntu bug below, who
compared the codec state against the one under the Windows driver.

Tested on an ASUS ExpertBook PM3606CHA (BIOS PM3606CHA.304) with the
change applied to v7.2.5: with this fixup alone, the speakers, the
headphones with jack detection, and the headset mic all work, also
after suspend and resume.

Link: https://bugs.launchpad.net/bugs/2167288
Signed-off-by: Saim Masood <s.m.saim074@gmail.com>
Link: https://patch.msgid.link/065927dd-cabf-449a-992d-64887eedda01@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 72107104d4f5 ("ALSA: hda/realtek: Fix internal mic on Minisforum V3 and V3 SE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index dd3466c3129d7..03f03080bbeb5 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3537,6 +3537,27 @@ static void alc233_fixup_no_audio_jack(struct hda_codec *codec,
 	alc_process_coef_fw(codec, alc233_fixup_no_audio_jack_coefs);
 }
 
+static const struct coef_fw alc256_asus_speaker_coefs[] = {
+	WRITE_COEF(0x10, 0x7f20), WRITE_COEF(0x16, 0x0c50), WRITE_COEF(0x35, 0x8d6a),
+	WRITE_COEF(0x37, 0xfe06), WRITE_COEF(0x57, 0x7f7f),
+	{}
+};
+
+static void alc256_fixup_asus_speaker_coefs(struct hda_codec *codec,
+					    const struct hda_fixup *fix,
+					    int action)
+{
+	/*
+	 * The internal speakers of the ASUS ExpertBook PM3606CHA stay silent
+	 * with the default COEF values. These are the values set by the
+	 * Windows driver. They are applied on every init so that they are
+	 * restored after resume, too.
+	 */
+	if (action != HDA_FIXUP_ACT_INIT)
+		return;
+	alc_process_coef_fw(codec, alc256_asus_speaker_coefs);
+}
+
 static void alc256_fixup_mic_no_presence_and_resume(struct hda_codec *codec,
 						    const struct hda_fixup *fix,
 						    int action)
@@ -4391,6 +4412,7 @@ enum {
 	ALC285_LENOVO_DAC_RENAME,
 	ALC287_FIXUP_YOGA9_SPEAKER2_TO_DAC1,
 	ALC256_FIXUP_IPASON_SMARTBOOK_S1,
+	ALC256_FIXUP_ASUS_SPEAKER_COEFS,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -7208,6 +7230,12 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		},
 	},
+	[ALC256_FIXUP_ASUS_SPEAKER_COEFS] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc256_fixup_asus_speaker_coefs,
+		.chained = true,
+		.chain_id = ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
+	},
 };
 
 static const struct hda_quirk alc269_fixup_tbl[] = {
@@ -7991,6 +8019,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x31e1, "ASUS B5605CCA", ALC294_FIXUP_ASUS_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x31f1, "ASUS B3605CCA", ALC294_FIXUP_ASUS_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3391, "ASUS PM3606CKA", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x3501, "ASUS PM3606CHA", ALC256_FIXUP_ASUS_SPEAKER_COEFS),
 	SND_PCI_QUIRK(0x1043, 0x3601, "ASUS PM5406CGA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x3611, "ASUS PM5606CGA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x3701, "ASUS P5406CCA", ALC245_FIXUP_CS35L41_SPI_2),
-- 
2.53.0

