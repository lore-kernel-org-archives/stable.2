Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347165;
	b=vsDk9LjyyMYBe/zZPo49uK/vhAaSIyAgobnXSjNfhBcwNlBZCV7a2MBxNSgzCiGb8QoM
	 EQSA7heBxRFj7FwXJa/Urnd73l27ift9bzDd0w63sK5ohsqfeqtwECf7tXwkzT1rBkYp3
	 6oq3gYH0plrX7RHlOcwYcaJ3Mfop0UCwSlFg6FcGMUuY+CjMWe4oINd+HBJnttYXQkq7K
	 PslD93dJLVAo9xJFynJ/GpQXMDE1caOZksSLUey06RlSt1XROhBIAn9P2KWDfGWgZXqfq
	 EFIE7/+RzGXzYf21X0LiJK5keThpoqIsMMzN5F/xj5MABrzU20Nt4/XlUcUmSrSX8kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347165;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UlrOCAUXGDeoDoUwgh1Xj009PR9H41DPxKhztM3Mad8=;
	b=GvNYfEFGOZv7YXqt6h8craoyG99fDsUCDGHuc40qqQsqrEL6TdDlzh/b9qXFVXFw1LTT
	 HOooLpMoCEyf4ZWEMnm+nRgYnGrBGAeM7dTSGv6voSuvbtPtOu/i1xSmfpFJVGqysgiDX
	 WO+u1BLYaoCA77BTuDiK2lYl1CzHFd6hP+/s5ir4fKpuslcyU9AEXCerDCMgzq9PrlYy1
	 OpA+/8paCV8TduMIw8hZSWaeHNum+upfEW8jpAy9AuUjocQfTNAhZ6eL7oU3UEN+504V/
	 cipgbuAZiDK4MXzD4rH0pIuRKvIvx/adQPCAnUkx0N8UrOsa86+q7i7Ts0fHbHa2Yxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GS/524uc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE060A2600
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GS/524uc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E7A1F008A3;
	Tue, 10 Nov 2026 21:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347164;
	bh=UlrOCAUXGDeoDoUwgh1Xj009PR9H41DPxKhztM3Mad8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GS/524uc4cAVRwoijG4slNCfbKUVBMU9wKu2cweKfncYSfG0zC2rAyDEOqJCPDhSu
	 MmaOFrQq+yEVoJUOAIOv9nK7Qemu4Cn6PeaTPP1SeXN0jiIFh//+JQXV1w4qnguA95
	 8WZxUE0elMF5fU8pal0O0SQs/rKVYE0w2ByB5kx+ayJmDVtZpcGG5n9bynfkv7c4Hz
	 nxAfgkoIHWtnWHvNRJxZa+lURmBmYUn3DrSnIO1NvMWBFTsXs5TNdyPIbHNd6rTTUs
	 Aq5q+my7kp0EkrJD/nEdLIEc70Bgq5kl61goFV1u/tnFbuUrfgYNovFh0SoPXYMS7J
	 xl1P83gWIjqAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jackie Dong <xy-jackie@139.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/5] ASoC: amd: acp: Add DMI quirk for Lenovo Yoga Pro 7 15ASH11
Date: Tue, 10 Nov 2026 16:45:59 -0500
Message-ID: <20261110214345.3938361-3-sashal@kernel.org>
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

From: Jackie Dong <xy-jackie@139.com>

[ Upstream commit fc12cf16df9af867e1455b011cdd9310474a612e ]

Lenovo Yoga Pro 7 15ASH11 with AMD RYZEN AI MAX+ 388 (Strix Halo, ACP
7.0) uses Realtek ALC287 series codec and no any DMIC connected by ACP.
All DMICs directly connet with ALC codec.

Without this quirk, Input Device of Gnome Sound settings shows Internal
Stereo Microphone and Digital Microphone by default. In fact, Digital
Microphone of ACP doesn't work due to no connecting with ALC287 codec,
the Internal Stereo Microphone as analog device based on snd_hda_intel
driver can work well.

Add a DMI quirk to override the flag to 0, consistent with the existing
entry for the HN7306EA.

Signed-off-by: Jackie Dong <xy-jackie@139.com>
Link: https://patch.msgid.link/20260527102005.58528-1-xy-jackie@139.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 38cb2ef26b64 ("ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp-config.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index cc3620db62bf1..a46b9a029cbb0 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -37,6 +37,13 @@ static const struct dmi_system_id acp70_acpi_flag_override_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Zenbook S16 UM5606GA"),
 		},
 	},
+	{
+		/* Lenovo Yoga Pro 7 15ASH11 (Strix Halo, ACP 7.0) */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83W5"),
+		},
+	},
 	{}
 };
 
-- 
2.53.0

