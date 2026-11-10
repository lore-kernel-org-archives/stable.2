Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347167;
	b=UeZt4evoUnGtPic3nyDv3DHNEJPt2jaw7Sbzwc8lV1t0czOiUBiqxBwYh+BU6KGno3Vn
	 lphpv/ydT/NWhGMNdKz95bnBKk9hX80O2QRFV8FgUTCEQKjDCSf7KVLGz1/GR7RiNxuXK
	 rUUGGRH5mST2DWjgrlZqP+esMPxV5jLrGSodXsqh1NP9sGmripAL++SN+hZZ7ZQFOaZla
	 kzj1LEMbI3iRF3VLyr5ukZZDuAOvfdTzv9Pl941ZGOBxQhHos7WR8B7yfPouVuBo9Crb+
	 8qRRA3TT57yCN4TB+zAS7cgsbuCHwM3UEdjs+KNkZ+mSl2JtSecgvuznUbfmS9KKVQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347167;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LVtGOIGGScjsaLBHqJ2K/YKXB/dbXSzSrzxmm7PS9ro=;
	b=r1uuZwEJIHVUcj/jXt5IZ6b5ULwzW8t31ets/i9bBvfW5n2uij+Q3b3vldN1/3uTEsIu
	 PIBYaOEkwOhI5nuQYmB6mhSq+7WCzcm8l32WPDh0erf4CCa0rApe/ljQGds6f9IAj6U00
	 gewidqcbGqOwp8D+4Qf/ard8nSG0lo+3vhgSe8YrcvCa17s/znlhR+lWnjlYK+6d98pUz
	 5/RGyH5zh1GQmkCSvQe4kwHcO8IrT+J2wqqINWzQEv2J4mWwsiKK+hMnbqUKOMsUwrEbM
	 mX3xMia4Vkw8WW7VJCOKyVoy2g4ASJGwJdtQ+ZOeaBR3Hp9Uxk9cdYbyBSRBtSX20+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KV6qQNnR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011DE606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KV6qQNnR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3E31F0089F;
	Tue, 10 Nov 2026 21:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347166;
	bh=LVtGOIGGScjsaLBHqJ2K/YKXB/dbXSzSrzxmm7PS9ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KV6qQNnRkkQaTX2EqJJ3KPKLbv1LjDL5iSjr9dMU/tPavfvjCpjxWM8KhZADvYJRN
	 1h6scnuLXh++ghbz2HF06qh/5Ge3kLixMwp3CAmgupLfkLkRYqpEJ531YSI7LS1Kxi
	 pF13GkGOu0xSoq6sFUbOSgdvFH6YHbgqUm4ANNsgcfmIksNhmTQzTWadLEGrx5wOdp
	 SFH5AhLNpzN//ZcS4VRakPYALJcAWwB4Td62iaN6PoTy5xBUsr1fMUfc49r2Vu3Isc
	 xsXvBHJj7HUL3RIRhhp+93F4VBkdVGazl2WcQNIWNHDjRS7yyqcQ9Uv2V0vnRXLSsi
	 QwecL6OqPfCjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Art O Cathain <art.home@gmail.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265
Date: Tue, 10 Nov 2026 16:46:01 -0500
Message-ID: <20261110214345.3938361-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110214345.3938361-1-sashal@kernel.org>
References: <20261107051216-failed-6.18-38cb2ef26b64@kernel.org>
 <20261110214345.3938361-1-sashal@kernel.org>
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

From: Art O Cathain <art.home@gmail.com>

[ Upstream commit 38cb2ef26b6411277826da54c6bcf94523541058 ]

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
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20261016-dell-14s-acp-v1-1-89b40d95720c@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp-config.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index d73059f400d57..7ed461c1d5192 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -51,6 +51,13 @@ static const struct dmi_system_id acp70_acpi_flag_override_table[] = {
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
 
-- 
2.53.0

