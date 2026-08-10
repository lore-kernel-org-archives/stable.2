Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236273B0AE6
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405879; cv=none; b=EiVIDlA0Ct2nmDyx5OlVYZXDDuco6gTvUpet3FfFlejohcqpR+q/r4g/PUQMDdPiJuWGL8qseZTDgy12PyU4QwNEuzlIgyQbBtIouVDIWWTUSJ0ilmSc8BxNnKF6liqzHjKDcUyukvBOWoM66ij9Ryj66b0VbUYvphq6KRN2AEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405879; c=relaxed/simple;
	bh=60b2ozNwfESmPaOZx3LaY4V6mScg1E8sZO1Pc/1ZCCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mgds736TuQzYpLb6QWoQnaEBfTo6sePY86isiwYLaxkONAL/lEQaSjH/l4ZjL9px3tK98gdoPNOqfuprlMcl7BePK2TFZJTSaH6A5YQ4w8vq9EmnbkJRIohB50tN0YFSazy8vRW29X/ttfOkvb9QdK/oHXJ8MKmb1njBjAPsxS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCzH2mvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCzH2mvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E464B1F000E9;
	Mon, 10 Aug 2026 23:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405877;
	bh=pfQCKtkioZL7/Uy5kf2YSuUz+ZgiZiZlZaOVoQ9YPyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BCzH2mvp1nOvrQ7qU77sw3uzzZUiwL01MNkVxnezK/HwuMuqbBQOjxyL5QIBHTYAk
	 vIs3auDqbbq0wbBKmARlF73r+5Wnx6HuunJSuPUyLoDGmbtJbRRkUdBwj9a2R7szy4
	 fNxwRipX8OrT1rngtbzUq5D0sKWkWgCXL6RomTzlRLqVjjhzcdGpClH1E9xrlQa+6c
	 C6/xcR+LEP+Xb4zECEpYrTmoXtuFtokJbAmKR40AAwtVbvPOY31INIwGDCEpsRzwSw
	 MrIgpUggZPWm6c0T7+pu2ou+2CrEGFb7Gm79ZUPLDQUzUS38XfV1OK2eelOEE7fUr0
	 6l6uVnCM5CQ4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y] ASoC: tas2562: Validate values for volume writes
Date: Mon, 10 Aug 2026 19:51:11 -0400
Message-ID: <20260810235111.3216665-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080558-morbidly-devouring-518c@gregkh>
References: <2026080558-morbidly-devouring-518c@gregkh>
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
index 1c36c910f47a6..74c4275ef29ce 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -472,10 +472,15 @@ static int tas2562_volume_control_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
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

