Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417374;
	b=pJCIgItkuzuV8J+ilA5PBhw0q2LJhldA7a9HVv20DBfR9/IM+AxfwYuQnHUNGhFON1TW
	 v9ToVgsBUv2GyB6KZNuSbHTMJf/kIjsDloGSO6adVL8DqGThVMdZ54YCgJ+IsvF3D6of0
	 2PqXJQXQeS4hJMozJMErXXysDb3Z4a7NakhmXDgus7kHSjRk92URnrsBtWL8rrpLPaStE
	 oK+bstSjs8Kt7FllnjgkK5h6g4adFPxR78z4d5s76RHZoVD76hNDAN0K+9HyXM7zme8Ia
	 dISP2GB5BMfyz10g4dGwmupRDUVixJQQKXGYgwi0CqLgV5xFatFt+r8F+eepfVGUy8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417374;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cH7V5ZpGsL47VaHjuSVEOwdVo5Dv19VpOtcdMjrMrHM=;
	b=DXvJaojtDW4+Zo4u3fcmFTnpy6t8LzPzNuzwFgxgHGZx63tSUBJUBvB1uZv6vIP6XLp5
	 o/FlCdAqYTFr11qAUGu5H5+8To/N8UK8zds4FKSeqp9QSVxldc1JZCDIwEkLg68FPdjNt
	 S+spYKAQQcrcVyxFPcGS6gGKSerxLlpDjyqaSJSmiMBLg3+95nqI6u5n7YBnB1rD1fZew
	 YEZCuKF6X+/yqVWwvYy86VxAd0GgL9K/t7inZei4Ra0Q5rAuzmStyPLBcrxEDpRB9vgpZ
	 uYuwKKWJhu31TrSDRh4sITXcTsW3FeZj6ooXlGTXMQxXEEf1i2dK90w6m9nMEcfh87g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SE5mKWS4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE5606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SE5mKWS4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC1E1F00A05;
	Wed, 11 Nov 2026 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417373;
	bh=cH7V5ZpGsL47VaHjuSVEOwdVo5Dv19VpOtcdMjrMrHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SE5mKWS4h1FsYKja406tiTf4nz4xutIFFkK+ynL+iDhRJU8XSt5p+O5wHFjtGYzww
	 ev6HeGO7LyIY0X5c80l7K+DLo02tk7EcNnslSq9QzH/5hbEFhvxXLsc9Ubvk6SaTy2
	 PE7zn2srn9CF1G5qfuOIMV3yhP/Y2WhAILIiT6uINkZivvRulkuBkBrEPsylTGwCD1
	 Wlt5TraHajUCA5PvEPP3jGTNijrPF8jXL+Dmi4quPOZ0jNBxQvCdJFY095BKrZpFMD
	 FzYPMUuW5Zc0unLdzOY4/wUwUXwZejv885sRet76Xv53JXovotLEKMNpT4A+e81PIx
	 FQ3N0kx0V7jgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gianluca Balboni <gianluca.balboni06@gmail.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx
Date: Wed, 11 Nov 2026 12:16:11 -0500
Message-ID: <20261111171535.3333499-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201535-failed-6.1-1e73257dff33@kernel.org>
References: <20261109201535-failed-6.1-1e73257dff33@kernel.org>
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

From: Gianluca Balboni <gianluca.balboni06@gmail.com>

[ Upstream commit 1e73257dff33ff851af60d5bb00d73893a8b6dc8 ]

The HP OmniBook 3 Laptop 16-by0xxx (board ID 8EE3) has an internal DMIC
connected to the AMD ACP6x audio coprocessor. The BIOS does not set the
AcpDmicConnected _DSD property or the _WOV method, and the board is missing
from yc_acp_quirk_table[], so acp6x_probe() returns -ENODEV and no DMIC
capture device is registered.

Add a DMI quirk entry for this model to enable ACP DMIC support.

Cc: stable@vger.kernel.org
Signed-off-by: Gianluca Balboni <gianluca.balboni06@gmail.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20261031102136.24600-1-gianluca.balboni06@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ sashal: Placed the unchanged entry before HP 8E35 because the upstream HP 8DC2 context entry is missing. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 6cc6dc56b89d3..420c91288019e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -612,6 +612,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "BM1403CDA"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8EE3"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.53.0

