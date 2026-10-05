Received: from mailgw1.uni-kl.de (mailgw1.uni-kl.de [131.246.120.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01047429037
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.246.120.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203841; cv=none; b=W8qkYNzQdcJYBZzsZRE/o9gj4SOz1qtydTYiKk1TW7tHTo6XCwDpO98YYF4jRoYvG7azvlE2BRd/dSZUnK0+Tl3zHdea3flMOpK3SuecbA4OgTjeeWDX75OtnAO8FMQNaMJ5y4eCxSo/jkQiSwKg+JSI1o/POoWE+gVvutOAvsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203841; c=relaxed/simple;
	bh=yDdqInFk3YpdDUiRGSXuiC/zzCHwu67hYsiL6JTzZlI=;
	h=Subject:MIME-Version:Cc:From:To:Date:Message-ID:Content-Type; b=GKzRj/G33MeSJ3X1LZjs0UgbkEJ1qCuPkEaEILaHVmvaETtbeKGVfcQ5G4yzr6WmgE76a3aB7jGK5hyhy4iVWHoiohxiq/ClLB3MoypAS/IDxkJXtbhOn1wvnUOXi7kEQpnp6o/phehXPwU6ZOVb0mcx9hCyJfUH7/e3hrzRQFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rptu.de; spf=pass smtp.mailfrom=rptu.de; dkim=pass (2048-bit key) header.d=rptu.de header.i=@rptu.de header.b=HMkk8ytz; arc=none smtp.client-ip=131.246.120.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rptu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rptu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rptu.de header.i=@rptu.de header.b="HMkk8ytz"
Received: from uni-kl.de (mail.uni-kl.de [131.246.120.212])
	by mailgw1.uni-kl.de (8.18.1/8.18.1/Debian-6) with ESMTPS id 695CZPBU1272841
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 5 Oct 2026 14:35:25 +0200
Received: from [2003:f6:2713:f52:6111:977:9049:d446] (account fyw21nur@rptu.de)
  by rptu.de (CommuniGate Pro XIMSS 6.3.11)
  with HTTPU id 325891654; Mon, 05 Oct 2026 14:35:25 +0200
X-Mailer: Samoware HTML5 6.3.6509139
Subject: [PATCH] ALSA: hda/realtek: Add quirk for LG gram 16 (16Z90SP)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc:  tiwai@suse.de, stable@vger.kernel.org
From:  "Prateek Yadav" <fyw21nur@rptu.de>
To:  alsa-devel@alsa-project.org
Date: Mon, 05 Oct 2026 14:35:25 +0200
Message-ID: <ximss-325891667@mail1.uni-kl.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=rptu.de; h=subject:mime-version:cc:from:to:date:message-id:content-type:content-transfer-encoding; s=rptu2026; bh=yDdqInFk3YpdDUiRGSXuiC/zzCHwu67hYsiL6JTzZlI=; b=HMkk8ytzlzH/3i9a46OPWDcjCpHbFFXV0GCrddbdDFOteY1TPNbb3RLsf2fTDRT++U2z3NyWhMUYFh6AdZZXEsCppM9cAxZzMOYDylHy3UrjPyevj+ej2t5682Iuw/sA0UCZpISUnlRBqKmjIvReVUSfP8m9/Qd/VcgKu2gxKhQh+5kbRY/RQEa/qE+Gqs2f169OdH4Uf/aUxoXsg+XP19qGSZ943L9/CHx3LvjO8RrcPdf3KfwKkI3zNMHehK/EwzL0h56k/FMN4bVEjMViticfHiiW0OLiAWqCfHOb6ZHDMEb7UTDHNTtxXtcRVfRqTEYTb6SDg8FB1UXvSo4xSg==
X-Spam-ID: 155943::1791203730-D99F8827-93CC9F59/0/0
X-Spam-Score:  (-1.92)
X-Spam-Flag: NO

The LG gram 16 (16Z90SP, SSID 1854:053b) drives its internal speakers
through Samsung-style smart amplifiers on an ALC298. Nothing
initialises them, so the internal speakers are silent after a cold
boot, while headphones, HDMI and the microphones work. A warm reboot
masks the problem, as the amps stay initialised.

Evidence (kernel 7.2.5-3-omarchy, sof-firmware 2025.12.2-1,
PipeWire 1.6.8):
- aplay -D plughw:0,0 completes with exit 0 but no audible output.
- During playback the codec shows Node 0x03 Converter stream=1,
   Amp-Out vals [0x69 0x69] unmuted, and Pin 0x17 OUT with EAPD on —
   the digital path is correct, the amps simply never start.
- Headphone Jack reports off, Speaker Phantom Jack reports on.
- Running the known 4-amp hda-verb init sequence
   (amps 0x38/0x39/0x3C/0x3D, cf. joshuagrisham/galaxy-book2-pro-linux
   necessary-verbs.sh) restores speaker output immediately.
- Machine dual-boots Windows, which explains cold-boot-only silence.

This mirrors the 16Z90TR (1854:0554) case fixed with
ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS, and the 16" 16Z90R-A (1854:0489)
which uses the 4-amp variant. I verified the 4-amp init works on this
machine; please adjust to _2_AMPS if COEF 0x22 indicates two amps.

  sound/hda/codecs/realtek/alc269.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c 
b/sound/hda/codecs/realtek/alc269.c
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -8114,6 +8114,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
      SND_PCI_QUIRK(0x1854, 0x0489, "LG gram 16 (16Z90R-A)", 
ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
      SND_PCI_QUIRK(0x1854, 0x048a, "LG gram 17 (17ZD90R)", 
ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
      SND_PCI_QUIRK(0x1854, 0x0490, "LG Gram Style 14 (14Z90RS)", 
ALC298_FIXUP_LG_GRAM_STYLE_14),
+    SND_PCI_QUIRK(0x1854, 0x053b, "LG gram 16 (16Z90SP)", 
ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
      SND_PCI_QUIRK(0x1854, 0x0554, "LG gram 16 (16Z90TR)", 
ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS),

Hardware: LG 16Z90SP-A.AD7BG, Intel Meteor Lake-P HD Audio [8086:7e28],
Realtek ALC298 [10ec:0298] rev 0x100103, SSID 1854:053b.
ALSA info: 
https://alsa-project.org/db/?f=7e8c49270f1b902ebb9fa76a4695f8301db040cf


Signed-off-by: Prateek prateek.yadav@edu.rptu.de
