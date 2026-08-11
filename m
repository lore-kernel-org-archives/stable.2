Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AAB23EAB4
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407761; cv=none; b=W/FNGKuRMjAgXSrVJ9iys6i3IQ/EDgZv+lfuZX0BNs4zvPDND+ePtYDuCTrZ+eOrQGBbRpGRE/AMvl5oS6Tsg9I7VGu/Yk9wtZP2K7VeSolbEIYC+dRqgpPWLx63Bse28ZrIRB7jeGJOeAtTeaFBCQ8GTb+Ipt0ifJWVvu8lhoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407761; c=relaxed/simple;
	bh=zqCeavq+YToKNlEFWtzRwNTHbXRTSgnGWnTTMKw0skg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8RCslTOUy1G32/KRy+d5LulGQOAn3CxpTrl0PTzVEjgqq40sQvFaRabLDpqrPic4+6rwbyr1W51kM2y8iHqSawGhSmXSOVMLxYP6byqnoVzq4fsD5g8DlG8hAXGXuxjdvCPJVhxnyTHk03YaiPaTW3pSAKDfK/iyr8Ec9rIx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMY7BbSL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMY7BbSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076101F000E9;
	Tue, 11 Aug 2026 00:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786407759;
	bh=PxehEUcP5o6LE8ZK9M1u/NkUMGCiFgsel1kHfFUlfu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XMY7BbSLVxkFKXVSfHiCxiRJxLSZ6UrDlitFroJ6DHyYeq0DR14YJZfBIvS5mn9mM
	 8gfXTMaFozONb4VhuLrmE3gedz6SNgBnIW0yHjzV4NUWZvkopKUWugAmzJqe+H3OrP
	 aoyOmsfA5GFDh08ZzrhgXi08igWlRAdHBpw0SJlk1sWJKQPxfJLi8Gw/eQlWuSg1ne
	 5I1UPHPAg2M3qqvBtLmLYNH66QGh6np3skyBwWRoeMszGWTc1fkg83YCH0WRFynIFQ
	 o/jw0FPIq84zrYDp7RkIERlS73PXSkSp9zHnFCdIZk6WTtFa8C28ZGzbiJ4ATMj06+
	 Wquwb+mSydVRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ASoC: tas2562: Validate values for volume writes
Date: Mon, 10 Aug 2026 20:22:37 -0400
Message-ID: <20260811002237.3404390-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080558-cure-reselect-5290@gregkh>
References: <2026080558-cure-reselect-5290@gregkh>
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
index ec1c8d077efcd..118984e30d7b9 100644
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

