Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1343E066
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570804; cv=none; b=PwLv65fuN1Cdp+1ysnZFDYKIG9v3g50ulammEw+iFw4kCteACG7OwfgCQi2NOJ8CnOQVY73si6euYR5Wb6PDyCVNsCNLU4aFhOnP+UAXa5GLuaL4FavZLVwPEcmaKTVgEv3WE49YxjhB+1J+QetimgGtS6eFbM9jQURCKPREhyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570804; c=relaxed/simple;
	bh=hSqcpYgm4WpInn7Tyj0s2iZIQZXFzTtCksFKx9ZnDBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFhzeLcJ7hcKgLwGQHe/zBUaQvwwVs09ImvlU9/31XRuAOSJHs9x2/JdtPM3ar7eRVqxEVnOgQvrjvgbETnFWIO7M5s7xf2ZtRkVwjRXw4xlEbS6WHvRGSXRKR8DTIMI/Bp3Z7MXzpU9GIq31PvhSBdKauB2FdHh7s5zoY3nQG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=XrPXA1Mz; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="XrPXA1Mz"
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward200b.mail.yandex.net (postfix) with ESMTPS id C4AA481CC4
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 21:01:30 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:4403:0:640:bf85:0])
	by forward102b.mail.yandex.net (postfix) with ESMTPS id 9667AC0101
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 21:01:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp) with ESMTPSA id H1aNUN5dHeA0-T2mXwFHh;
	Mon, 20 Jul 2026 21:01:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1784570481; bh=0Ndm/hZjXE4FeU5Ck7H/t71L3f7NKMa4XDDfp+Tbg9c=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=XrPXA1Mzo/KntqW4rhkGtTbGtM+M7M/kFh+xWwdDrSy+AKtWPt8pqh09XW18C8ej+
	 aSGoBExi19D8lPoSGh+3OCCdvwufOOKO4pxjmy4M1YGRa2FUeHIvI0iUmhaEEBr6rT
	 ipXcTZX6X8yc/jM/Xj+vnf6nFHYU4vBNDWdyXm20=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Nikita Maksimov <nickstogramm@yandex.ru>
To: nickstogramm@yandex.ru
Cc: stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix speakers on Lunnen Ground 14
Date: Mon, 20 Jul 2026 21:01:12 +0300
Message-ID: <20260720180112.73517-1-nickstogramm@yandex.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware on the Lunnen Ground 14 marks pin 0x1b as unused even
though the internal speakers are connected to it. As a result, the
speakers are not detected.

Add a pin configuration quirk for PCI subsystem ID 2782:a212 to configure
pin 0x1b as an internal speaker.

The pin configuration was tested on a Lunnen Ground 14 (DMI product LL4FA)
with an ALC269VC codec. The internal speakers and microphone work as
expected.

Cc: stable@vger.kernel.org
Signed-off-by: Nikita Maksimov <nickstogramm@yandex.ru>
---
 sound/hda/codecs/realtek/alc269.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 09e724749..97632d2f9 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3906,6 +3906,7 @@ enum {
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
 	ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13,
 	ALC269VC_FIXUP_INFINIX_Y4_MAX,
+	ALC269VC_FIXUP_LUNNEN_GROUND_14,
 	ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO,
 	ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
@@ -4389,6 +4390,13 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
 	},
+	[ALC269VC_FIXUP_LUNNEN_GROUND_14] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1b, 0x90170150 }, /* internal speaker */
+			{ }
+		},
+	},
 	[ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -7974,6 +7982,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x2782, 0x1705, "MEDION E15433", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x2782, 0x4900, "MEDION E15443", ALC233_FIXUP_MEDION_MTL_SPK),
+	SND_PCI_QUIRK(0x2782, 0xa212, "Lunnen Ground 14", ALC269VC_FIXUP_LUNNEN_GROUND_14),
 	SND_PCI_QUIRK(0x7017, 0x2014, "Star Labs StarFighter", ALC233_FIXUP_STARLABS_STARFIGHTER),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),

base-commit: 2d0769387594eb26df33c72c08c6429e4fddf5fd
-- 
2.50.1

