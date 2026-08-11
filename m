Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696AC37A85D
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786414558; cv=none; b=VTeiADUBy5s0rs0C4MVuDvgcLGVZsFVWAFtf8CgqrRUAleVRUVoievPN8nW1Jv8+f3XTL/wQKpw+4+gpD3KSBCc/ezRvh1/tKWVeqxvgPL9QEmgUQRoMUb7RdvVaXR6iqjM5AWcLhZP1pT2A+kaOJbJiNnvfzcFO+JTFxLMVNcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786414558; c=relaxed/simple;
	bh=bnu66Rh3u7VIcRCkScvtELIeFMLbizoVtVKOKG8h3Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bU1pSHKkOzheUSkCzzMEO9bBRssVwP0ZyrorOA0djX/bGSE2uCrUHVtQQ6NJP81j5fpyJG4Q7OOWWWIdublnOL1YbHfagrJDd9iL4h4g4YRdqy6HERl46FM7J/nBITMFL6SDkyTsagJeKTDuGlR1O/PDvr9lvpVPcgo67nMHhxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfZ7Tv7h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfZ7Tv7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18061F000E9;
	Tue, 11 Aug 2026 02:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786414557;
	bh=ij33ehK4UUa+uJcGEYIH2vL5+vTGVm0jqr2CBb6F9tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FfZ7Tv7hpGK1NVhAqvPsqJFIvjrrGDVR+S07Q0N+d8V/ekZtzpF2qXBuycV2FX7iN
	 NN+1M2FRGpJnPVEXTBdg3ZoLD9WQ1XLlDXUL4TrN+sOHDnh/6vqyH3ghZ28IS8jJXj
	 q8dqbFNo6zdJgLNmqC8BRzR24WyPe1yWwBXlt5Z/BJqy4340ldW/oXU42ia+zrseoS
	 kwoGZ4bdxlbFgD7p870c4VqfeDkBHLzeWGptu0xz1Okvc9U/D+1X3rwrg7QPpTusD4
	 eqPsghiKVHO8sm2Riq3LPFZIA9o5amn/pYUJ8AYVcualwxK6ND+aL/1ihJaE5Nq7Dz
	 dL08SOfyY47AA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ASoC: tas2562: Validate values for volume writes
Date: Mon, 10 Aug 2026 22:15:54 -0400
Message-ID: <20260811021554.113809-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080559-motto-posture-14cd@gregkh>
References: <2026080559-motto-posture-14cd@gregkh>
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
index a1cb2d723ea57..ae351bb3c66f8 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -473,10 +473,15 @@ static int tas2562_volume_control_put(struct snd_kcontrol *kcontrol,
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

