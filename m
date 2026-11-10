Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348748;
	b=VoaM8TqDXTjYRJXvcnAGX/HteIOel/UNJDyZgCL/LayGMWfafj6VH+OoypUr0pJTcvW/
	 4yNl5aD9214oEfTwHVSnaA8ngm1os/20E0NpqFZIO8MQrtesG/AHwT7oKmKgshKlTndMa
	 XJm5Mc2nR28fScCvr5HCIBZM5GT+vJIDAyXRHUNm0dgUn+6Hy4tMV1fkpUOoKtZlmodQq
	 idhrr0iQlwVDjMQ7B7tPCO5LuUI3ydaxZuLRFQalVONKlr1cgt1gHdJTN1nuQg7Re1Giw
	 JrcGW/vDtAC/ChMLBdYCKKww80xaCn2e8tNVqOPzJDl18B1gThK6i8NDYdTyw8laSuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348748;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UlrOCAUXGDeoDoUwgh1Xj009PR9H41DPxKhztM3Mad8=;
	b=CIUjFhqv00h6/d49cDA9EZXKuupAuGbkJTNXrDYj3B7PIIBRTC5wS9JFFh1Lqq+N722j
	 FCmSNuUXAFKMixKGJDoJLO3x2Qg7MBYBVGdDiNlhwuj9eDK1VxJxb02Mau1EXhBiobuDF
	 aXot0EueoTby6KwIoaIy5TtXHvHxTlZ/15hkAVdZlKuKz9XGXbFHn3RtPfl+Pneke5rzg
	 DV27m+tgg+k1kIQuB+S082df4H/MnniclA1Y0Pr0Hxq2zWO9nebbi8Lb0hif+xlfbE+aJ
	 yT6y/8Hg1WwqzI7OQfQjSNuhbnCttthuhW3BvAE8VH7mkObVwNFnyVWOi7so82wEhbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONcpCBlu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73634606D502
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONcpCBlu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928681F008A2;
	Tue, 10 Nov 2026 22:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348748;
	bh=UlrOCAUXGDeoDoUwgh1Xj009PR9H41DPxKhztM3Mad8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ONcpCBlu6FlVMTATYInEounUR6ehcM4b6ipk+lqtTq2yfo49slbVewz4gx/3M9c3n
	 dqcKBTf+onmC/WW+31B4zILt6T9g+oEfyfQ1di0UpmwV6XsdIg6koRl8Y8SwGut+vE
	 NlapEC8KIgRnPq8WNOEqd/eYPeFEmuc8+gJKKgrDEVBY9ARckLxgLjZ23jIFmLCiSN
	 Juo3UD03JyfEWMJEHx8WsBsSZXZhVmZjuPm8KC7tBzMGY656eK4WVFeYik/Opx/cjP
	 muI6ENOgYGL1ad4BxT4qQ54F/6hUG3S1FcFu99NtS6i+VBCg8p52ARXiOrn0duOnrW
	 Xj3s3Ef1JMASw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jackie Dong <xy-jackie@139.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] ASoC: amd: acp: Add DMI quirk for Lenovo Yoga Pro 7 15ASH11
Date: Tue, 10 Nov 2026 17:12:22 -0500
Message-ID: <20261110221157.3981579-3-sashal@kernel.org>
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

