Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B414D2ED0;
	Wed, 15 Jul 2026 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784146706; cv=none; b=k2n6vGnVDY3fk0j4OSWti9iAt4v4s0RRb88MmyCiNtEa1PwQE23O2S9XYZ9lpAoRcHUgeQUBZCE1UGTmi3yyXm9phP55MQ8GoMBGvYaFRIAWIryi3nB9DRWoO07/gsRponJQWu1efA7RF0mIPapSoOmsnUkclw30wQ63PPlMBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784146706; c=relaxed/simple;
	bh=CJhV7PGj47iIAspFHu/JLaN2UhNXEyvLQbBS54wp4lE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YK/wXjgE48//Tv/fH+kk8l4qP1/zJqr/NaXN0XnrKKnVwFfHTZywdRmFFcH6aLqc13oYkb5sXuuXTGrjtLiqVocWZsXOEU0KVgt6oitgk5xcwRzit8wDyJ/yYQ+l2PWM4t93n5WYbPuuTK5fAywDMp2pLc8bv+J3v/ETrmcFh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Swp0cKst; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Swp0cKst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B0E1F000E9;
	Wed, 15 Jul 2026 20:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784146705;
	bh=hMHXuZkbXdkLujkt+PsLDj2e6FLgA5od1ICzzv2H3ww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Swp0cKst1yEDIbKLTlu5KOJ7TPOQhi1WF1JzbYymnI1SZXFY42kBsB/AhBPqXHI5B
	 yGsIGVqt86tLjrPi98qQZoIEohx2YvZtZ5d2m+POb00RChZJ6yWWwRXDI+l1v35CHJ
	 awkbiVq6bPR+jMnKACTrVztzmd7BlWFP0swDvPD2K7sV3ACgAVD9D2t1GEYMlGPypH
	 sUJEIi+kFhZ8A8BBSDknQ+6EZGu+yrEHi31p6g9Uqz0fCtSqZM60ZFxV2cL8u74a4K
	 Jbqr+4KYYPkLs5HiRMLJd8VUV1z5wrY3GuNK2Y8XCFLweS7tZN5y1Kh7+LLvjYBDYg
	 5hCdkV1js4BKw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Jul 2026 21:18:09 +0100
Subject: [PATCH 1/3] ASoC: tas2562: Validate values for volume writes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-asoc-tas2562-put-retval-v1-1-97bf467c924e@kernel.org>
References: <20260715-asoc-tas2562-put-retval-v1-0-97bf467c924e@kernel.org>
In-Reply-To: <20260715-asoc-tas2562-put-retval-v1-0-97bf467c924e@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>
Cc: Haidar Lee <haidar.lee@adlinktech.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CJhV7PGj47iIAspFHu/JLaN2UhNXEyvLQbBS54wp4lE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqV+sL1V2V5bL2rzAhAL2BSwhxtsTziV8wanolv
 G2CT2NQoY+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCalfrCwAKCRAk1otyXVSH
 0CxsB/sHsMw/6m6wTOFOZy28Yzk2w2w6UbGVEOgdXFQ+yYc0Xnznv17dTqTeZkRQlxJ0rW/upUr
 lwlG2uDplsBHme1T7LnF2om4d5/xcbI1PBo+kguGgA1LidBYXtnbHYfqDSaljSM50+doU1jPwej
 uWoW2+v7JHwMJhTSrRDSw5wHz4o+ystb0dkuns0YuDNoEtvk3/lpOMUNWHj1Mxg0fVJAfZo/WnB
 fntesOOjUpdZHqnhM/z8hrqOEVdvLgF7bPL6lb7OVcgVde+3Idj2gJpEX2T5fFfV/5bbyLgcOHu
 z3ZdheTxE49mtXHQ9jf/oPZ9LQgojp68Q2ridEJWU2ZWLhBa
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

tas2562_volume_control_put() does not do any validation of the control
value written by userspace, it uses it to look up a value in a fixed
size array which can easily be overflowed and then writes whatever value
it gets back to the device.  Add validation that we are loading a value
we have in the array.

Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/tas2562.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 2f7cfc2be970..82bc0078a5c7 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -471,10 +471,14 @@ static int tas2562_volume_control_put(struct snd_kcontrol *kcontrol,
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
 	ret = snd_soc_component_write(component, TAS2562_DVC_CFG4,
 				      (reg_val & 0xff));
 	if (ret)

-- 
2.47.3

