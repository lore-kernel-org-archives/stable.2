Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145EB466B75;
	Fri, 16 Oct 2026 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142977; cv=none; b=lkixPmVarDVNSoILJdpN4cETw84Ooovel59u0EJtndjcp2dPxYU1L8dVFK+x8BLYz8XXLMEPGTl9VerLihuKnsMPNY5X0+44i8E2GJG/fGHKH8MZF47n0T7S3CAm7lS3i3V6Y7UZQvINyR3fhq5OFozfA3NZkKQovT79x0DA1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142977; c=relaxed/simple;
	bh=Jq0wR6uioeZnYDwXSO4FapwcaGBTjsw23+YN7lrHGa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BJM39h3MzX4oPSs2cAf8SuHEaRWLhg1wMF/bvblE/76xyKaGH2Mtf2Hid9RkCUDJ2ht4XMXrPYtYANBU8WTizLQZqbWoJ7GivxypYCIfUOSoQJw8GArKm+ZNMQDN9LfPe7XyVb00QOPGP/gQ41ijLXPtHT3FnvrvkX32HqdF10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUkYBvm1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUkYBvm1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68E71C2BCF4;
	Fri, 16 Oct 2026 09:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792142976;
	bh=Jq0wR6uioeZnYDwXSO4FapwcaGBTjsw23+YN7lrHGa8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=hUkYBvm1bwZuxnw4OnwX6UFELPiEksOUBi4Y6D6hijOqfReQ1uUh6veBiMfttWn23
	 TJt8zUPiVAKAeBfyW7mmGUTUmm9D8LY5Cpd5t42NcuOiwO2QCByjMqGTAfEhDvFN9P
	 kQ5nBTTA1fxesrWV+L6CURZFz3GGebhKJBfL+Z1UggBZ0rBZOugHDVSPRWn3ZuruD/
	 yDKpR7bEncGGOQ7FoB9LtZ2wJQ21lhaqbUmCcNXnQYWHRtHxYjAsHkWBAlcBpmDDND
	 5FyW9f5dnw1c48pbGcelH7Ll1IYS8QbJVt1ORt4Y2Ww1eAbvzhnz3HMnhC2gT1lle1
	 yP2N8nWn2ZTUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D27CCA462;
	Fri, 16 Oct 2026 09:29:36 +0000 (UTC)
From: Art O Cathain via B4 Relay <devnull+art.home.gmail.com@kernel.org>
Date: Fri, 16 Oct 2026 11:29:30 +0200
Subject: [PATCH] ASoC: amd: acp-config: force SoundWire probe on Dell 14S
 DS14265
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-dell-14s-acp-v1-1-89b40d95720c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHnu0WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Mz3ZTUnBxdQ5Ni3cTkAl0zMyMLY0ODlBRjU0sloJaCotS0zAqwcdG
 xtbUAVvD49F4AAAA=
X-Change-ID: 20261016-dell-14s-acp-6628310dd359
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, stable@vger.kernel.org, 
 Art O Cathain <art.home@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792142975; l=2499;
 i=art.home@gmail.com; s=20261016; h=from:subject:message-id;
 bh=Uy4P/oTHFWMDG4MmVvevQSElgPkBookxrCgnp+ENKTM=;
 b=E5V4d2UVc/bWxFlyv36kMqhRjqtkQFlHnQ3pY+XQlBs7ky/RVQr/ebnngESqHg3/xJACmtXjG
 qKhWiV4jxJCD8be3VVMJ0M0Uq8vtOGRAWZYgBu6H9nqlW3QSRptloG7
X-Developer-Key: i=art.home@gmail.com; a=ed25519;
 pk=gCdw1OQ+x92kQb5KLzhJL2+HO6kYhoAHJCwvVXVOLio=
X-Endpoint-Received: by B4 Relay for art.home@gmail.com/20261016 with
 auth_id=1208
X-Original-From: Art O Cathain <art.home@gmail.com>
Reply-To: art.home@gmail.com

From: Art O Cathain <art.home@gmail.com>

The BIOS on the Dell 14S DS14265 (ACP PCI revision 0x72) reports
acp-audio-config-flag = FLAG_AMD_LEGACY_ONLY_DMIC. As a result
snd_pci_ps returns early and the SoundWire links are never scanned,
while the legacy snd_acp_pci driver probes the device, finds no
matching machine driver ("No matching ASoC machine driver found") and
no internal sound card is created. The CS42L45 headset codec on link 0
and the two CS35L63 speaker amplifiers on link 1 never enumerate.

Add a DMI entry for the model to the ACP70 ACPI flag override table so
the firmware-provided flag is overridden and snd_pci_ps probes instead.
Match on the product name rather than the board name, as the same
symptom has been reported on several boards of this model (09PVND,
0M0J65, 0C7F12).

Tested on a DS14265 (board 09PVND, BIOS 1.5.3) with Debian's 7.2.6
kernel, with and without this entry. With it, snd_pci_ps binds, both
SoundWire links come up, the CS42L45 and both CS35L63 enumerate, the
existing CS42L45 + 2x CS35L63 machine entry matches, the amplifiers
load their firmware and calibration, and the amd-soundwire card plays
through both the internal speakers and the headphone jack. Also
build-tested on asoc-next with W=1.

Developed with AI assistance. Claude read the ACP driver source,
identified the BIOS flag as the cause and the override table as the
fix, wrote the DMI entry and the out-of-tree test module, and drafted
this changelog. All hardware testing was done by the submitter, who
has reviewed the change, understands it and takes responsibility for
it.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Art O Cathain <art.home@gmail.com>
---
 sound/soc/amd/acp-config.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 30e01bc47ee0c2b28f369358cd3ea18897ff0c5c..2fb9789cac0ace8365b2c98c21f2ef1a18b6093f 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -98,6 +98,13 @@ static const struct dmi_system_id acp70_acpi_flag_override_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8EA2"),
 		},
 	},
+	{
+		/* Dell 14S DS14265 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell 14S DS14265"),
+		},
+	},
 	{}
 };
 

---
base-commit: 0f8bc3b93b76d16682a4d4999f9559b1e18016f9
change-id: 20261016-dell-14s-acp-6628310dd359

Best regards,
-- 
Art O Cathain <art.home@gmail.com>


