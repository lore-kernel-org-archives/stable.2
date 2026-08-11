Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF843B3D9
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448333; cv=none; b=k9CNulaNzuQioV24J02DIoA2k0hVu4vt2qY+XQ/Ai3AGTzZERHVxMGpTUbnEaXiFpL2tpXEzd6FkgcjBxZH/9eXcpDvQuI949+YHnI49Yv5NPoa7xnmFhGxXNbHIp0QM3sCf8vgBBtP8pukMJY70J++F6HExOdZdimstFw5NTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448333; c=relaxed/simple;
	bh=vaRbXpAJwNedKdyM5+iEOPc9DNxbF7laeeWO9xjnQ44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ej6tZBv8hGjP/xz/kE/HOALa+fXlzG8K3qWyGcKUc1PNN/1Oqe+otJxpWdd4xTUAagolRrPvJzZa/KRO+eMvjUiO72+0EhzFliH4GG/Gj1GiYvtO15qE+524dtDzRuUeCLEmgyzuiEAbrwLvFKISDGq8AEc76YmyTbsD7LDfNmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj5+BskB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj5+BskB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6DE1F000E9;
	Tue, 11 Aug 2026 11:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786448331;
	bh=CNhKRyhvXzjZl9Yi5pTSyhQ2Pknq+qnhnV24vlVbOPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yj5+BskBdZHtKZ0NqFpBsSJP4rWvzZhBUJBLymErdsawmY0Mf0PcuKL1ZBu96D7t/
	 d+b5RIzz/5Txx53T955NsbXXmrA2EiazAM9j6r3XOI1G4EHlfDJHy49NzhbJspRzRV
	 rhaFDxc7rDWYhLjr3/QOMT1KBgOwM4kBPQ9P+GVBdLkqbepa7gb+QniiTEcxs7NKnS
	 lvGzoYJ9xMMpvVf4lsrREIgamkXNaLlnrDDUZEX+O3lCpzoJVlGZ4gY4+hTq0X8v20
	 cSXD/nLa31d2ri3BaUYTKIbob82+DTN8u0cf/aO40kHYz7j1djNYzcl52oNiap1TZV
	 m1qYm2lvz/UHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ASoC: tas2562: Validate values for volume writes
Date: Tue, 11 Aug 2026 07:38:49 -0400
Message-ID: <20260811113849.2297458-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080559-decency-ultimate-2e09@gregkh>
References: <2026080559-decency-ultimate-2e09@gregkh>
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
 sound/soc/codecs/tas2562.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 10302552195e1..4dcbfa96c85b6 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -503,10 +503,14 @@ static int tas2562_volume_control_put(struct snd_kcontrol *kcontrol,
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
 	ret = snd_soc_component_write(component, TAS2562_DVC_CFG4,
 				      (reg_val & 0xff));
 	if (ret)
-- 
2.53.0

