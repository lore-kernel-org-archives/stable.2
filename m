Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC732720C
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447056; cv=none; b=jnKAKuTjzFu534j4a2fLDzCVptes6uWsGZJVrBlSAkjqXmVyEcJKddPzPfR3fNso0uL4gV54KXNSQVlZlwCv2fDmYfLAAJ3tBMcCSCQchp3IGnPWRl6GA7AXkxyw97lO11qCuV3wRtllnGXzSm/7DEQVFbsTUjcFaaVJMrOMzMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447056; c=relaxed/simple;
	bh=YnIMxKz+xz5ENG+IMgurOuLCTESvWaKHXL6fWdQ89rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUQkzE8XZQAi+woGkn/c9vsz+iscVBDaTxcdZm3AM96/qZWXi9/+FRm6LNLLUIv252TzO5nvl2tfS9k5ENJzB2jFyBDaBr9hCfj2fEb7gr5KxN7zQfZIbnX68eb7XpNgn9EBf5Do/NGwss61SnZddPXzJ5MfsjBIsNC4blaRoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4XUJGSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4XUJGSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E965A1F00A3A;
	Tue, 11 Aug 2026 11:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786447055;
	bh=sZBbVg9ts+v6gh+U0sHd35ciiLHsqyXZsijyRPMcYeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C4XUJGSmUqnqd+Piu8SO6RCfg/f67I5/+5OoNizx8UJvtyslIToYqew8DfrVQbIB0
	 Y8gnBbjBjvFJrdxfgapwVI0pEt/NJfTSJh5P8eWTfblYNaNNorz97AKT5qhrM27OB4
	 e5WnxlTMMo7uOSNY6w452B7U6B03tSE1pGNvILIfK5l5nN8KqP4qOIH8jBaRScdAPI
	 JcZHw6r0zRAzcTq7zRrSG66l5fXSDaXe+IpPCBxYSHCvG4z1iu/Rr45PwZkdG/Y1Zr
	 lTYsBEYtxeuWTD/prZiP8KrgLN2qlNYdV2gP+SDbXh37xoEP89JMrZ5mVCO0d9JNsP
	 Gz0Hquf11cuYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ASoC: tas2562: Validate values for volume writes
Date: Tue, 11 Aug 2026 07:17:32 -0400
Message-ID: <20260811111732.2259992-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080559-jury-tapered-d39e@gregkh>
References: <2026080559-jury-tapered-d39e@gregkh>
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
index b486d0bd86c99..7c755e67b3d79 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -473,10 +473,14 @@ static int tas2562_volume_control_put(struct snd_kcontrol *kcontrol,
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

