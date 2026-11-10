Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347164;
	b=Ypiz3hj2QuS/cR8qL8SEokVs2nIw+pmFqehR+tJ1HO2YweQa8vWN/cbfHf3dPrUM5EgI
	 Qrcb/nBdRclVVFcY1GZgIVVSbkBcDDzrE7heCpuUEz0XH7CeUp6dOeZ0GRWQHdiVXu96I
	 PUcbisG6KTJL79k/R5V3xQR0NCx+MLVHk8bYQQbQvQc98+VIr2vkf9vZiOtIAeVYNzPSF
	 AsqSWJfAywU/BqhFCCah3aKu8HFxw/Ilpz1FrRgnICeYfKT73xdxfjEK9j8j9fz87zxhd
	 XVwVJhxH1o8DYl+a7Ttv1tWSzYDWK1QZlT2s+8sgjET73LWLz039e9t5c2HCEzX3lIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347164;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nduWT/CThWOdZ15t1shOVGT23Pdbq3QEhq8epJfEEXw=;
	b=p52Mi12nu5pA7wj+dSw1/diqv4evoIUt8etDwGuR0Uzkbd3mvuCKuB463NKlr0JgQFza
	 Ul6QCIz4PLcRGGE2jHZwnJOQvQfqolTkVsAKw7bBfIs5nhxnX9fuqPbRdVhwX8Ws0Qt46
	 odsdIrCF4GPbku46oqOyWqDMK2/cePtsVS3pamoIPx0aeNArOlbZTp8aPY3kTAGHJrfmT
	 2afgD5zRB6WEIynzrhv1J2w7vsJlnYa68VAU6zeekJ3S41xNSGpAnJkKqW0od+fXEqPV7
	 iBqPOXlXqb6AX3IL3SjrZtDVSJyIDm062ROb0og5HtoG2DG3mv8STGj6lXa2vGO2gYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4DJRYLD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E2C606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4DJRYLD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68A31F0089F;
	Tue, 10 Nov 2026 21:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347163;
	bh=nduWT/CThWOdZ15t1shOVGT23Pdbq3QEhq8epJfEEXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I4DJRYLDZNaWCmCwsYKkXFHoKzu1YFzI0RRIV2iQvlZ5tWvJ/XoW+isSGPUBRVex6
	 G2FzfhG7UG4hNj0o6xgmcoNPjOKdv30p6i68CG3FxiZDCWuMwIB2abeP9fCoi9Ji5j
	 rAJHkTRYGd/ZD1D6mD8DDI16jfZL1cTpZpLQ9DBKI6ArDOzaVyBOMJtPLJh3WI+CiH
	 19+8KvDjmReMBNoIFDTwptXT9y9oHDL51eZgbjFejZQFRnd9sZ86jsRsjyLc0m4BCY
	 JwfJVE8WngLU85ho57P2FEnh3B9C+UskqkJUHY8e2onzA5wM8Bc2wYm8+v2+G/4sbb
	 /JkZUd0rM4jCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hasun Park <hasunpark@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] ASoC: amd: acp: add DMI override for ACP70 flag
Date: Tue, 10 Nov 2026 16:45:57 -0500
Message-ID: <20261110214345.3938361-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051216-failed-6.18-38cb2ef26b64@kernel.org>
References: <20261107051216-failed-6.18-38cb2ef26b64@kernel.org>
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

