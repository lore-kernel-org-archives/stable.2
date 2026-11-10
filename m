Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348747;
	b=IIEzCmJkwLnAu8vOlq0qBl+O3IaFvFdbpGrJPX6BkEnF7LW42H1ed2XxqlOb7ApXoewT
	 SVdoAAiTZ5FBSHWxMzvW+jbViVDHi14sppGsYDtn7hIxS/MP6cpAG2YMylrJ+1oJkivXP
	 2YOX/YlPPo15jvunRpM0XtLwE+hXcqHIb5RZMmW0iwCN3sAs2YZfg50q2YmwQoKyxGDBB
	 EbX04+e040wvztnqxEpCSgx0ZGa389UgXRoCAQbtZntbqdSQibDx28Hdwrr5BAouinTOs
	 2kxQQqqfmDn62cuVHsiPwhJSDdcSsA2HDjbvndgPyZE3DhPEPfK/FEkjgxuJHwIlxgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348747;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nduWT/CThWOdZ15t1shOVGT23Pdbq3QEhq8epJfEEXw=;
	b=j5trPGtvAm0dnxZEh0LZrMdJH7f9WLd1k1BVxpVZVl2NkrxkxQ3wtnloZJvvSbKt+gTr
	 R0kNnukbkBBgSRmmLZCuoiWbffTOj1wxX9N+ppwPnSucHnJO85vaClS9xehaCUFHvCVdM
	 SEmJnctqAsUMg4aYmArrSMgzVyX3Fiu2ggXGDlk6ZhNw357vmV2M8utb2M/t7QLSkg/QZ
	 cBS8pmLQT4Qz9/Nx/xZpL1BT907akXuzBIdYYtU511JVxTjFSezhg/FJb3foQJz70LntW
	 bxe3htz+AMP5bAhgQRZU2+zK3wWKnGcO/JpWk5BnGgN2yEpmixV6DZu4Z3TFNgZyI1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2jaiqiI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2716606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2jaiqiI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060D21F0089F;
	Tue, 10 Nov 2026 22:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348746;
	bh=nduWT/CThWOdZ15t1shOVGT23Pdbq3QEhq8epJfEEXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2jaiqiI8+02e/FGuI6QFeMf+sLx5TPznE0oFbVd7zHBi3Ef7PLNdL8iOgxSqilRO
	 5UsT7dHGCMu2MbwXWPpOKdcB/kd6bX1oZdRxYA5LhS3oFMz6ma1EjJp9UWCUiocKwP
	 w+aHAVdxmaj0aaN108sYfkhIuLCFcTuZbzOUZaNY0OJ4D6trkX7yXzOXM9JoQFC0xI
	 KBHlOT5Bf+o7DGC2eX9Z5Ws12qLouV6rOG2X2iXAWaxoNMpmZeCKljEKELCZtVS7/q
	 pkbSO8TBLY8OEAXo6RQrgW70B9jIPLaBiuwcptq1mJFE6xRneREeKgoIfVhxCGm1ze
	 nrvNJiOwQw0BA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hasun Park <hasunpark@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] ASoC: amd: acp: add DMI override for ACP70 flag
Date: Tue, 10 Nov 2026 17:12:20 -0500
Message-ID: <20261110221157.3981579-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052329-failed-6.12-38cb2ef26b64@kernel.org>
References: <20261107052329-failed-6.12-38cb2ef26b64@kernel.org>
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

From: Hasun Park <hasunpark@gmail.com>

[ Upstream commit d0426510a9e1fabf074e274ceff26ffc6500980a ]

Some ASUS ProArt PX13 systems expose ACP ACPI config flags that can
select a non-working fallback path.

Add a DMI override in snd_amd_acp_find_config() for ACP70+ boards and
return 0 so ACP ACPI flag-based selection is skipped on this platform.

This keeps machine driver selection on the intended SoundWire path.

Signed-off-by: Hasun Park <hasunpark@gmail.com>
Link: https://patch.msgid.link/20260308151654.29059-2-hasunpark@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 38cb2ef26b64 ("ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp-config.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 653e8ce946082..8d7b968c4402c 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -23,6 +23,16 @@
 
 static int acp_quirk_data;
 
+static const struct dmi_system_id acp70_acpi_flag_override_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HN7306EA"),
+		},
+	},
+	{}
+};
+
 static const struct config_entry config_table[] = {
 	{
 		.flags = FLAG_AMD_SOF,
@@ -200,8 +210,11 @@ int snd_amd_acp_find_config(struct pci_dev *pci)
 	 */
 	if (!pci->revision)
 		return 0;
-	else if (pci->revision >= ACP_7_0_REV)
+	else if (pci->revision >= ACP_7_0_REV) {
+		if (dmi_check_system(acp70_acpi_flag_override_table))
+			return 0;
 		return snd_amd_acp_acpi_find_config(pci);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(config_table); i++, table++) {
 		if (table->device != device)
-- 
2.53.0

