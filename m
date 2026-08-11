Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262FE37F74A
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410637; cv=none; b=KPaLjN7mgS+62cZZIuBpIhXjMJPU+P3jD6oczf3KZg1j+uXXWvW7sGg3hTQl2801jUiIVshx6h36It9dl/NX/wdZTkNUpdPSyJ/OUqa0Fz9k/G+lPmmAkLPdJNZSfv1fy7OK3XuaO3CT5fKj+9PXLRiDEKVHkzwQciH1S5xudIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410637; c=relaxed/simple;
	bh=ubDopEVppPeL5YXYyYnJDVM1Uqqss/gNCeyMBKo4rF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrKaf0ELcLzjrAINetpxmbB7KGz+BtXyE69n3tvOMAj2jd8P0B7zUdD5r3lucZLW/K3xI8D7naCVS9rxAyMS2TVkgDar/Um9DY71JTlTX+CoVwRdT/9SCJDf9OLe6JC5+l0ZfAQyN4pX5RvK2kTQtFlLhooJhFgCwjfVKojlwk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4POmOII; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4POmOII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888171F000E9;
	Tue, 11 Aug 2026 01:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786410636;
	bh=7zUMKO3c46h1oMB/+5dTxSDi2FWNyudmMEbaq69n9lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T4POmOIIKlR7TYhxwmAzEeVddOHXJg3gDFhrpiwtx05PHWyCZwHe+n35w7dCwOw2f
	 0qWAM7poaCjV7Dj4rwRsHtOfPoFeXLDTevyzR0T6Qrgm6MYgnQmptpUnGSAN9d8DSL
	 TKpVjJ3CdYrerlaSZbDl/SbsA3eCD0fIwqvfh2WDiieWY7Yv3KO74heTpB3gl9aZ7g
	 FezJJcLMLPb1ykqNXVrq3sfDIyRqNozPfFgyCfLDOp3uzD0e2TZBxP8hwo2U1zHKJH
	 w0fS/FvjF4DjHq1ytnzyjQ9iAv0fnxqVwsxy6mRQznC+jvDFDtkbqmZA0GhspnCd8r
	 1HxsLpn6jhY2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ASoC: tas2562: Validate values for volume writes
Date: Mon, 10 Aug 2026 21:10:33 -0400
Message-ID: <20260811011033.3739957-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080558-implement-huskiness-3dc7@gregkh>
References: <2026080558-implement-huskiness-3dc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 8fb41964f7e4e4207c8999af2056894caa7a252a ]

tas2562_volume_control_put() does not do any validation of the control
value written by userspace, it uses it to look up a value in a fixed
size array which can easily be overflowed and then writes whatever value
it gets back to the device.  Add validation that we are loading a value
we have in the array.

Cc: stable@vger.kernel.org
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://patch.msgid.link/20260715-asoc-tas2562-put-retval-v1-1-97bf467c924e@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2562.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 6051027c8266a..a725b026509a4 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -472,10 +472,15 @@ static int tas2562_volume_control_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct tas2562_data *tas2562 = snd_soc_component_get_drvdata(component);
-	int ret;
+	int ret, index;
 	u32 reg_val;
 
-	reg_val = float_vol_db_lookup[ucontrol->value.integer.value[0]/2];
+	index = ucontrol->value.integer.value[0] / 2;
+	if (index < 0 || index >= ARRAY_SIZE(float_vol_db_lookup))
+		return -EINVAL;
+
+	reg_val = float_vol_db_lookup[index];
+
 	/*
 	 * The device applies the 32-bit coefficient to the playback path on
 	 * the write to DVC_CFG4 (the LSB, book 0 page 2 reg 0x0F), so the
-- 
2.53.0

