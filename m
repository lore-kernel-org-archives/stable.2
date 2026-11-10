Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348749;
	b=R7vh3oe6NwgYmVJ6ktyBqx7qFko/V2VEC6VsubyCoEhrXrCnMbllL+UKQ8nM0gwmdyzR
	 E3smq0uGYLs5YZ5nqUuWy9CUm0qMv+YHQW9HBD5jlMmy1yQAn573pnsoTwFSxQW5d1Z/f
	 amhNQyVEuVf/OOjKxi1Ycbrxa+n03VSHx7Q4IeTUkdKEaiJSxSeof2ln80RkMbDS3E6eO
	 gloH5QON4iquRbbot634LQvZY8Hebz9VbRvWBOZJl3baRzcWkskW2WZ0y9G8T8lMwWimn
	 X+90MOT47eBSnW7/QZM15X11un4Ae8m1p/rBoVj6q0U/YPAzS3V5kPVL/j/OQQ6ttLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348749;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IsgA6AOwwD8BYCEBbPK53HYkNp67/BicSduDh5XxnNM=;
	b=YuQIMPyD93tE10SFzHyY0p7fQGkatxjxU89G1ODbpV1dbd/8AZ4SfSUK0h+5KGIpCZ9q
	 1+q6k+UZwvM3D94/abHIU0fQtCmtqlPRha/CZVQlL9IqpkhLDu0HkNzL5gGbxrp0TOT7W
	 1zOKpXUtVmS58OwZvD7taYHM1HVeWiHiYEL3i2/dv8TMLqWfbONzlixHOY19w8znLto7+
	 ek61r/TD8pcx6V2AQCF5/a9WlDGwwqyHp4orc9ExCrUmASygzMrf4QX3SZ+CIEdrpVdFm
	 5muSSfnHCnSMTGEzSGGZr78jIeOhbth1qohKsln+TJuzmQ91Z8A2OFMdC5FIp9/xZXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyYyGOma;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B343606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyYyGOma
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4641F0089F;
	Tue, 10 Nov 2026 22:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348748;
	bh=IsgA6AOwwD8BYCEBbPK53HYkNp67/BicSduDh5XxnNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JyYyGOmaWCo4sUoXR71/JCnrLwJ+bxoFMoLwo6Lhh0WdMWDqo0XcVtwQLfn2KgAS3
	 mipsY9OVyz6qUJT3j/CsJ/wpRBcahGLoHcAjjApBS4TE/U5msOzx8I+H32lP/Pbr37
	 gEsCWRFqLl46ctBJEO8e+Q/iXhpwqQK4dA5nB+FHj30kBARd2oPH+uBcvripTNeX+h
	 8j8Hb3DVjiqXd7w2MCQUydtUC60IRZjz5T0bCw1ju4WFH4gWXAEbJR40DYHxnFxeHH
	 5RI/XtQZuP1Nnv+J4/8LlUq1lSA/kRp9gtC4e+aety+3BLlUfsUfwh+8o5SR6+wRzt
	 gB2yYIQlwHd0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sehat Mahde <hskmahde@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] ASoC: amd: acp-config: force SoundWire probe on HP OmniBook X Flip 16
Date: Tue, 10 Nov 2026 17:12:23 -0500
Message-ID: <20261110221157.3981579-4-sashal@kernel.org>
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

From: Sehat Mahde <hskmahde@gmail.com>

[ Upstream commit 4d6642d64cd00f276549ec2c0b0278aea2f8c1aa ]

The BIOS on the HP OmniBook X Flip 16-cc0xxx (board 8EA2) reports
acp-audio-config-flag = FLAG_AMD_LEGACY_ONLY_DMIC. This binds the
legacy ACP driver and registers a PDM-only card, so the SoundWire
links are never scanned and the two TAS2783 speaker amplifiers and
RT712-VB codec do not enumerate.

Add a DMI entry for board 8EA2 to the ACP70 ACPI flag override table
so the firmware-provided flag is overridden and snd_pci_ps probes
instead.

On the affected system, an otherwise identical upstream kernel
without this entry binds snd_acp_pci, enumerates no SoundWire slave
devices and exposes no internal speaker PCM. With the entry added,
snd_pci_ps binds, both TAS2783 amplifiers and the RT712-VB enumerate
over SoundWire, and the amd-soundwire card exposes the internal
speaker playback PCM.

Developed with AI assistance. ChatGPT helped analyze the ACP and
SoundWire behavior, structure the controlled A/B testing, and draft
the patch changelog. All hardware measurements, kernel builds,
reboots and playback tests were performed by the submitter. The
submitter has reviewed the change, understands it and takes
responsibility for it.

Assisted-by: ChatGPT:GPT-5.6 Sol
Signed-off-by: Sehat Mahde <hskmahde@gmail.com>
Link: https://patch.msgid.link/20260825224640.13662-1-hskmahde@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>

Append the entry after the existing Lenovo quirk because the neighboring
upstream entries are absent. Preserve the HP match unchanged so the
subsequent Dell quirk has its expected insertion context.

Stable-dep-of: 38cb2ef26b64 ("ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp-config.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index a46b9a029cbb0..d73059f400d57 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -44,6 +44,13 @@ static const struct dmi_system_id acp70_acpi_flag_override_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83W5"),
 		},
 	},
+	{
+		/* HP OmniBook X Flip 16-cc0xxx */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8EA2"),
+		},
+	},
 	{}
 };
 
-- 
2.53.0

