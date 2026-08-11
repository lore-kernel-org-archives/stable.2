Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F8342669E
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448699; cv=none; b=HLPGdHZBUYqPY7gFgNQb5/GrPEM6r7hwJ4gFa9w5eEGsfpp/16k9U4Fq3U30FXEeyagR7yltr976K9E/EHY3F5RLytfcMGwcB9r+ey5t7Hf/bv4Nh2XlzdK0DWdaJKg40MWKHQ7ddyIqfcwIodzV8gesO0MRVZFBtTaYy4eLrmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448699; c=relaxed/simple;
	bh=neYv43qA2sSItT3q42S9O9IUYpGW7IEQoZ0wCyDgJyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hH5gP72fQ11MV2yffVVp28CuWbDBusEyzqkRnlx/jFz0DqswAhp1AD7X/CYcz7OgWq9ipAcc0SlIiHWdKzlB2l2mCpGEudxgopm0ryyreafA2crjJp7fKiJlhYutIApoOQNlesK6Y6Hrw71JCSsj0OJ2puHibW1sT/gCCRbN25M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlrgrVyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlrgrVyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4341F000E9;
	Tue, 11 Aug 2026 11:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786448698;
	bh=qGPcNDZsbOP+S3YQfrt6WG2vNudSCdZUzEHcYpqq+ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LlrgrVyfK+HkW/q3F1FzvBWsj722YdMxUWcoAltFKske6pqSUDxJ9yMSApefV74IJ
	 kDSRc2LQ2Y9FNJ6wqtFCt9XSlaE9RsPf6C27TjvJ506iRKgjQU7c5PFfTrqh8DC9nB
	 REYUb3VRXY6lk/NzTZ3/IGJYOulBGiikUgBXmrfHYIDeXCpB3qlsiV0lK4JsPWKFXW
	 z6Yf8eZwUeyA3nRTwkX840GTDdVd2KinNjTEzi/QCY0epLqPhQTQszzwEp3n1KiwpR
	 v5Ojn2xHkSN8Qw7QM0KvQBs3XbSapy5CcXYQ72Kr+TpxhNn7VV+owpY46ANhWUzSjY
	 aBUvHxxrNgTYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ASoC: tas2562: Validate values for volume writes
Date: Tue, 11 Aug 2026 07:44:55 -0400
Message-ID: <20260811114455.2312744-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080559-trickery-canned-cde6@gregkh>
References: <2026080559-trickery-canned-cde6@gregkh>
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
index f1ff204e3ad05..f48f39ba62c7a 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -504,10 +504,14 @@ static int tas2562_volume_control_put(struct snd_kcontrol *kcontrol,
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

