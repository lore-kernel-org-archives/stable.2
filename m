Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348747;
	b=jmBrD1fbNcLb2nK5tm9fXiqSMXwjNYZSN1hHcWLZHMfyF2qusPqUPrfqUhyNVxSvPIMw
	 YPNiFLvaK2nfW/y8OEpms8CXzp3yFoMxB43h+r8NhT991YE7t7j4Q3cbaGl/GkwlxEORf
	 y+/gc7ouG9YZsbZJ0RCcAvHxkyizEkKdaSB/iMGfjXRqow94zRiS7ocIfNpYuFutHjgf6
	 JtJvxRgLMvcX+eT8i8KzAdksawAjwvqDWHAt7nxqE1FGA1JG1K9pL0MM3tKCnHJkH+lQa
	 MTIdO4P+/6Y4vEEkA5ZeuYufHI0hb9ltVJVqaoKQ46Rk6GXQvLHg46/RFmQl8i8KlcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348747;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LlWPO3oIGkL3J0OTHmzYeJJI2pBbc8Wz//GRQx9Ftv8=;
	b=g4cEyfHL1lJbChZtkcn8Y0OKjIaxp7zMBYLfkauptqqNTJ1K4mZIPKL3Jrw4OFTaRTeF
	 MnxInSYiNji4ZQ9KxNkcD3GXyDvemJZHd1+h5Pr0gnOZeSzFyL1SMJERDvgjPW0jZhUxt
	 jytewF1ThL6pPlxeRu+1dZjfceMK2668AlzZv3y3FxKxtsM/Zl5HDTl/buHUMORAgS4uz
	 GCg4KVxfXnhO2UzBbV7SFTFOBilPDNQzNMkFl8H4ZomGs0xiwgbQVNHnJjxgJgQ2hX3n+
	 nEF419VcCLNoxgM4pTRsvMNNPqU5D7AUqPHw6dfUaDmJc2p1cDy1PDNilsmpxFVIYBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BY340cGT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71335606A33B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BY340cGT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F411F008A3;
	Tue, 10 Nov 2026 22:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348747;
	bh=LlWPO3oIGkL3J0OTHmzYeJJI2pBbc8Wz//GRQx9Ftv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BY340cGTAgUbEwEWnk91es6mzPFlT8gpX8YuL+g39YX3jSwp8/Hv9t41guTt0ygi4
	 BrWXs6pPtPwc42HBL0s7EckVNMX2PIpwgPK3DhaSzoGV/Euxa8i6EZ4AklqN412Kkc
	 2uk/WrfzhsY1yHnIKBg2l9AKrX0KFHlWHzTcCU03qe3AnNIc/dJIx1RgejT0KPz7BV
	 UDZd+CRMoubprUZpst2eUv/GDCjWTblo3M16PFr25HzuKO5y2VoKwkOuV9xyh42MoL
	 IXrWydk2jkKB20e1G4vPf7sMTtxBNqhcpuM9hPWL5BK298edw5mG/hjau2JBl/W4yh
	 omnSMt9z1e1Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jasper Smet <josbeir@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] ASoC: amd: acp: Add DMI quirk for ASUS Zenbook S16 UM5606GA
Date: Tue, 10 Nov 2026 17:12:21 -0500
Message-ID: <20261110221157.3981579-2-sashal@kernel.org>
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

From: Jasper Smet <josbeir@gmail.com>

[ Upstream commit 6e4bfd9da8851f562f04503d8e43221957f96eeb ]

The ASUS Zenbook S16 (UM5606GA) with AMD Ryzen AI 9 465 (Strix Point,
ACP 7.0) has a BIOS that incorrectly sets the ACPI property
'acp-audio-config-flag' to 0x10 (FLAG_AMD_LEGACY_ONLY_DMIC) for the ACP
device. This prevents snd_pci_ps from probing the SoundWire bus, resulting
in no internal audio (dummy output only).

The hardware uses a Cirrus Logic CS42L43 (headphone/jack) and four CS35L56
smart amplifiers (speakers), all on SoundWire link 1. The corresponding
machine table entry (acp70_cs42l43_l1u0_cs35l56x4_l1u0123) already exists
in amd-acp70-acpi-match.c and correctly describes this topology.

Add a DMI quirk to override the flag to 0, consistent with the existing
entry for the HN7306EA.

Signed-off-by: Jasper Smet <josbeir@gmail.com>
Link: https://patch.msgid.link/20260513052137.56703-1-josbeir@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 38cb2ef26b64 ("ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp-config.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 8d7b968c4402c..cc3620db62bf1 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -30,6 +30,13 @@ static const struct dmi_system_id acp70_acpi_flag_override_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HN7306EA"),
 		},
 	},
+	{
+		/* ASUS Zenbook S16 UM5606GA (Strix Point, ACP 7.0) */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Zenbook S16 UM5606GA"),
+		},
+	},
 	{}
 };
 
-- 
2.53.0

