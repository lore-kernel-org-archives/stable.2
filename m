Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320110;
	b=PpPNkPRZK96QfmUtIIvrqbLxNDQhRZ6wf4a794WUD4avmR3TaALlaLfRv44y0Xg07EHx
	 hD9hJ5YDRLk5glrM82Mtt+l8EtAAzeCwPaiQPJrZyymXu40iEfEYEZ8mhp5c1p5FmaV2a
	 ds1HYn+LVZBmnggDg/ow/4Fy4Yt+l1PJkhViiJaZAxAjti8uS+5b9Jnh0en7I7qSCtyxZ
	 1IhI59cDyK9RHpCW8zA6pWjmDij7yqP1998obFB237jdySqMdAGtm9b8ami+KTuGJU/Zw
	 wS6wypJNtH+3d57ZTXfsoHu2a1g7h4n/Y4jbCp5LoBY8zUh3Lbo30AUMv68DgrU2Fhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320110;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qwNIhxoKMxedDvYANt3/+pdM5g9/pz9HdYivGutezJM=;
	b=ZkH7veiODNo8f6y1M6b8EoeTurvCTOWdI6tkDHqB8rVyzRMdttCj6AjX790G0711JqxO
	 aPxZMvmsekF8/desAmKLNSmOj7VnK+D/zKz//+VRFtF1vtwdVu5G68VtlyVPnkQInY3bp
	 4IYdDDgBx10/7m2C+UiMY5UT8p48TbcrCTVN6oQePIG+NzXTjv0gqxWXD/wADnb8O4vmI
	 sE6Aedv5IYdPAZxYl5BK7XYE7Oc+sRD/53FEdKeYdhvBJnvZsVQ3FtnVn6dR4HM5CHLwQ
	 IRHq0uICxfLN/NgdfYzn1OfC/2aRckvbUDyrhw2yP3NZPa2MB57uLmwrXxRX9UHWtmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggqJeKb7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9A2606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggqJeKb7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590551F008A2;
	Tue, 10 Nov 2026 14:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320109;
	bh=qwNIhxoKMxedDvYANt3/+pdM5g9/pz9HdYivGutezJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ggqJeKb7hyKDKZptFqdrEI9HfGLjicheFkD4bI9VGfs7wlt282iN1aTjof+QixQ/B
	 GdCcN/e7GqsFpzbmZY8QeDnO/4RO9th3F2zviAuYLpIYp/1sXkEiojjZ6haoNuqECL
	 AarO6ZsV/IA1spwR5bs5yv7nCSuqzVfBzHfqC4muD25dsXtQM036xZRBlU+5L90wMR
	 GiB6j3UP7akA6SpAaZNT1wlmF2pJO3HTes4ryP3KUHLUH42TaC//4YBTsIad2htf6m
	 xlLSfTVc0ybYW8O/RoSBCBmSyBsMjJNoObnd6q92SatZGQamnkw5sj9tSinbmsZwco
	 1iP9eF3Gf5lYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicholas Bonello <hadobedo@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] ALSA: hda/realtek: Fix Legion 7 16ITHG6 speaker amp binding
Date: Tue, 10 Nov 2026 09:15:05 -0500
Message-ID: <20261110141139.1831137-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110141139.1831137-1-sashal@kernel.org>
References: <20261107050927-failed-6.18-1c36207da794@kernel.org>
 <20261110141139.1831137-1-sashal@kernel.org>
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

From: Nicholas Bonello <hadobedo@gmail.com>

[ Upstream commit dd074f04e04648d89d9d10ae9846cd057c97b385 ]

The Lenovo Legion 7 16ITHG6 uses codec SSID 17aa:3855, but its PCI
SSID is 17aa:3811.  The latter is now also used by the Legion S7 15IMH05
quirk, which is matched before codec SSID fallback and incorrectly
routes Legion 7 16ITHG6 machines to ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS.

That fixup does not bind the CLSA0101 CS35L41 companion amplifiers,
making the built-in speakers silent even though playback appears to be
active.

Add a codec SSID quirk for 17aa:3855 before the conflicting PCI SSID
quirk so that the Legion 7 16ITHG6 uses ALC287_FIXUP_LEGION_16ITHG6.
This restores CS35L41 firmware loading and binds both speaker
amplifiers.

Fixes: 67f4c61a73e9 ("ALSA: hda/realtek: Add quirk for Legion S7 15IMH")
Cc: stable@vger.kernel.org
Tested-by: Nicholas Bonello <hadobedo@gmail.com>
Assisted-by: Codex:GPT-5
Signed-off-by: Nicholas Bonello <hadobedo@gmail.com>
Link: https://patch.msgid.link/20260508225507.47667-1-hadobedo@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 1c36207da794 ("ALSA: hda/realtek: Fix silent speakers on Lenovo Legion S7 15IMH05")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 5bf382eb4646e..ed76281856b1c 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7544,10 +7544,11 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	HDA_CODEC_QUIRK(0x17aa, 0x3802, "DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8", ALC287_FIXUP_TAS2781_I2C),
-	/* Yoga Pro 9 16IMH9 shares PCI SSID 17aa:3811 with Legion S7 15IMH05;
-	 * use codec SSID to distinguish them
+	/* Yoga Pro 9 16IMH9 and Legion 7 16ITHG6 share PCI SSID 17aa:3811
+	 * with Legion S7 15IMH05; use codec SSID to distinguish them
 	 */
 	HDA_CODEC_QUIRK(0x17aa, 0x38d6, "Lenovo Yoga Pro 9 16IMH9", ALC287_FIXUP_TAS2781_I2C),
+	HDA_CODEC_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3811, "Legion S7 15IMH05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
-- 
2.53.0

