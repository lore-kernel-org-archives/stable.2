Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320109;
	b=zZW3L8CdIGGMMeErczQTELgiYuxqwx0CqT0+ypmtCg5GnuRMk5uvVtVhGxxQAq+6HPGP
	 h+DsKTU5o3YzGDSzFRP5QNSMNrA1Eoffa50v+6r4/AAbIFw97ZpYb34OUhZDerXbBwRyM
	 X8GFGzQa+g9NcgH31ZqzCUrXZGL07sQ7BuB8/jxk2AxbUtLfWs5I6D+GjZW6eojU4PUEz
	 a1+6V8bYERK+5a5yjutZWlyg5oCaxZHNpCK/swqeSjKLu3aXESb6NpyIFgFDTFgZP56Il
	 UtZJLZB+gcRsBIb6cdQ6rLIXIwFSlPxIH4YlKocOltq9D/SA5nDfHwYMo5GqjASd1Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320109;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=t+8LQ9jrPS5+a9xG5gZpe20w6FtZNMl41RO5wwVl16g=;
	b=staAb3cqOnO9Fr7A4tKhlzlCSmjCdpnS5K/Hj5z6JxivF1sTRlR27tKY954f+jquca6Z
	 1acCrxTQm6rQBZDmcV5A+VqIJ1Ul1co0iVze3cBticSfGAw1TaiPOKfQgX8aIK1HW1dfW
	 rG3MDuzkndX4hLw/Npnu90e1ZOfsZex0K2aS+FjoAgVC4oBa2wJ5YYgTspLhiPZZbB5hs
	 01yG+YxWpkB4hARuWU6GO4CT+HSW7U7KLN9DmT4ZPQhVSLGQ8tglAUdhyCSU7GqCVkvnQ
	 KCWirAoo3nJtUVihQ38EK7piM6u6o86IM8q6taL+kTDqGtJjOtvDzjR+RTrIpCKOTxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxea8LzZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5C606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxea8LzZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9491F0089F;
	Tue, 10 Nov 2026 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320109;
	bh=t+8LQ9jrPS5+a9xG5gZpe20w6FtZNMl41RO5wwVl16g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kxea8LzZagnFxyngkkdOpwvY75FA7afxgZEQ+Nlu3IlYLPTKfcZt08pBzPuBiTBY8
	 1I+198QFJOkm7kPJlqj9QOsMVFtUgFeurwTR5ta0jq0CUbI3lRTDm/unSgwESChZo1
	 lHRYo0jKxdCM+IW5r+fMLNykUCWoAaXDF/W4x15qB8IU+auSB1lCKoX42z7w+0QatC
	 f1Wfz7LcN17/5NrBRlnmLRnx7bINKleGu5grjljp5W3UH4hWDPS6bT0Sp0xonoGsL0
	 sA4RqKCbC87R3Nd6mMgyxufjfLoinnS+PTFwfXfc6N70vlmw04Yv7xKe7fARRF8ocC
	 D53kN8bPbFDdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?R=C3=A1mon=20van=20Raaij?= <ramon@vanraaij.eu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] ALSA: hda/realtek: Add codec SSID quirk for Lenovo Yoga Pro 9 16IMH9
Date: Tue, 10 Nov 2026 09:15:04 -0500
Message-ID: <20261110141139.1831137-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050927-failed-6.18-1c36207da794@kernel.org>
References: <20261107050927-failed-6.18-1c36207da794@kernel.org>
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

From: Rámon van Raaij <ramon@vanraaij.eu>

[ Upstream commit 56722cfbb78d7eb41756cd78dc5192d08bd14f3d ]

The Yoga Pro 9 16IMH9 (codec SSID 17aa:38d6) shares PCI audio device
subsystem ID 17aa:3811 with the Legion S7 15IMH05. The existing
SND_PCI_QUIRK entry for the Legion routes both machines to
ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS, which does not bind the TAS2781
smart amplifiers, resulting in near-silent built-in speakers.

Add an HDA_CODEC_QUIRK entry immediately before the conflicting PCI quirk
that matches the Yoga Pro 9's unique codec SSID and routes it to
ALC287_FIXUP_TAS2781_I2C. Codec quirks are evaluated after PCI quirks and
take precedence, leaving the Legion S7 15IMH05 entry unaffected.

This follows the same pattern used to disambiguate PCI SSID 17aa:3847
(shared between Yoga Pro 7 14IMH9 and Legion 7 16ACHG6), where a
HDA_CODEC_QUIRK for codec SSID 17aa:38cf resolves the conflict.

Signed-off-by: Rámon van Raaij <ramon@vanraaij.eu>
Link: https://patch.msgid.link/20260430191224.patch1-ramon@vanraaij.eu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 1c36207da794 ("ALSA: hda/realtek: Fix silent speakers on Lenovo Legion S7 15IMH05")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 99d3fda16f3a2..5bf382eb4646e 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7544,6 +7544,10 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	HDA_CODEC_QUIRK(0x17aa, 0x3802, "DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8", ALC287_FIXUP_TAS2781_I2C),
+	/* Yoga Pro 9 16IMH9 shares PCI SSID 17aa:3811 with Legion S7 15IMH05;
+	 * use codec SSID to distinguish them
+	 */
+	HDA_CODEC_QUIRK(0x17aa, 0x38d6, "Lenovo Yoga Pro 9 16IMH9", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3811, "Legion S7 15IMH05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
-- 
2.53.0

