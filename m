Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347165;
	b=rwKa65fnj179ay9LcrEn4ijeR7PIl4cJe/znclUp3WE7rFYAaf6DT383shpTOsRwJFJJ
	 rFeGVqmjSSJjbiCnOnlwANZopL4R8H9b7LjgzRpJES1cgph7pGhQ/KUv3LyJN6tZRIg+S
	 SJCybrzlerG2ECYY/BnH2jrYTHftWBqX9BHOAz2k/V3QnSUU97LSNNincSYVZGDI13X6i
	 WlsGH/WTesIcEFE48eJVnNU/Fh/j/prOG/dQ+lRiDOLuF9xW0G0qOO+Va0jWAmfYk60x0
	 Udk8KRNgtOBVlcCz1wGASkkuIwmJHRq7pQZxUfCyp0eTQsYJuelXU61N4TE9f/ifAbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347165;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LlWPO3oIGkL3J0OTHmzYeJJI2pBbc8Wz//GRQx9Ftv8=;
	b=3bJ+YbJGDJbMl5hh9wodrKHIlGmyUGPj5wefcQO6NWv7tO77zusk/NO2cZVlUKae0F9q
	 8a7uK6MfEdTGZZuYemMG+z4lCcPVm/FPi0JIWiBGv/mGwuygkBuINq8U6SBhxNKr//o8z
	 8cNfnYscZ4RPwmmfxyJh+Lw/k6ef80XzcGoe9Jb7fuhdmbXxv5r6diB/mkeDrI/lnCUlo
	 1QevONx5L5mSBTZfYwCKtYnbZegG/6S6c44iNt0m/lxMDa561HJz4dSWk3ZMmPbZdNU0P
	 oKCOtFb+Lrp8u8g0l9II70P14245tK+Gre3xay3ovcP0jnCl7arOR2kJD4DhEjvSsvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIs74qhu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBDE606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIs74qhu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B831F008A1;
	Tue, 10 Nov 2026 21:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347164;
	bh=LlWPO3oIGkL3J0OTHmzYeJJI2pBbc8Wz//GRQx9Ftv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WIs74qhu0m0XHGWRW7kNYRbNJNtrlY+85pMknelYECLTyaoS+s1fg6eWc4teB8JZC
	 y6ohabk1LRw+9umfv2F6WE1x18YtV2WQqDbXXvvtYKwx3mNu5/tp3xwxNcOXLyzHIb
	 qv9oXqqt4LugtRYCBRIuxr9My99xm3r3TEpalwM63+V5Ul0luvgB+APoOmOq2LI9bn
	 J+wSdxC/8/nbsaXNIlNT+yC1/YyUPPD0jEVJNvV7OkMmI4rRrnXdqtMtaSA6GYk5AF
	 3RL8HjRc8I3zGuSzlL8gskuMD4Xrgri9Kd1u5YcHpwdUW49iIk/XGDmGarK7LPEwhC
	 SUcpZ4ghT1sGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jasper Smet <josbeir@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] ASoC: amd: acp: Add DMI quirk for ASUS Zenbook S16 UM5606GA
Date: Tue, 10 Nov 2026 16:45:58 -0500
Message-ID: <20261110214345.3938361-2-sashal@kernel.org>
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

