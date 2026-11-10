Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348750;
	b=Ggv3g19KCvWMrVnKXsXv6Hh+BfOOIRRFlVjpvnOt+98qh9FSjfqFDhxUAuMJRyXgRe6D
	 wlh5uaVef9/k3x/OmjhY/3WcBoNh9YzGVlqhjbcRq5k+2Ss1KTWULgvyqi7XgAwpyc0p6
	 9cBFOPhGN+SzHAECgi+xVIjjQPaLHzO4OCQ7p78pUmMijdkMdt2lGukMbGMMvb5SX7P/o
	 Jzhe3+CusEofIRQ2R9tjOmoadB1WdoAxVDYA95jKwmF2snFFGEsb7yhodsRS5+nIY9UaH
	 Ns7m2/7gAWv6/0zc7izUQrhlkV12ukMQLw6LKNKDefTrZwnODP/ltuSkPUctzpiKWGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348750;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LVtGOIGGScjsaLBHqJ2K/YKXB/dbXSzSrzxmm7PS9ro=;
	b=5cfDbyEMhjJ/RtNpqsWRPIB1/QBA3SxFwwDyruWWrxj31iyz3yl4i3Rd3bFHUpbRrDZK
	 xPP5+i2PDiVIEJrQDBDLqNGGVJej7aVJYoP92WjnyisVMpDyaVNp2tTBf5SIFCfuHiIj2
	 OwXSGgVy6ymVSyRqlbmPZOuddktRSJkQ+cx55A6IIekJ3e1/BmV3189G1r1YviXoDHcaH
	 JqOsryFwoG+1v0GY/2/VHyzATop6mbTjWQK6iKTTreRhGnh7UNhkG2jz9lCZu5RtMNVSP
	 9f0PzRKYAL6uzZ+1uri6RjC/qc7dKAbo5Av83TjbdLVbt2H/waeMM4Ku0S/DLaVFJWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AI6YhH54;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC304606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AI6YhH54
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FD51F008A3;
	Tue, 10 Nov 2026 22:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348749;
	bh=LVtGOIGGScjsaLBHqJ2K/YKXB/dbXSzSrzxmm7PS9ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AI6YhH5418ORfORRiYR1cJ6K5z5AJ6bBwfUNsyIYugkr7739b/88s7Fmc9Q4nNbKt
	 YfIKOkxyed+2zMIdaDJ9q69JMJzJkfDvvdahMILbgpWo8jWtq5le5tjAgXqWRRaC0K
	 rr/hig50pgLpcVUeNrA+buE/PjeE2LEiRaU6t0x747gd5QYIW6cZTd2+RDCU8Os1oF
	 T5h2lRTZj0/Yzp9U9RGiTBa5gPEjnBUeCTkapIqC91M+vm/RFOpLkPXph+6rwnu2HM
	 qcSelQi4an+1J1guimXuYf0RTfmBqezrtd2a5eB/AXS0pRpc3/CSnGTd6bNGSe52QS
	 nAcZ02ZgxXpwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Art O Cathain <art.home@gmail.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265
Date: Tue, 10 Nov 2026 17:12:24 -0500
Message-ID: <20261110221157.3981579-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110221157.3981579-1-sashal@kernel.org>
References: <20261107052329-failed-6.12-38cb2ef26b64@kernel.org>
 <20261110221157.3981579-1-sashal@kernel.org>
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

