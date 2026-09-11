Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E743BDA9
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123297; cv=none; b=OXifMd+JwDBncvSOpZEJL8+nExStcn9rjQ80OF9wkw5XxiXlcuq3Sedx572sDRJtdkgOgLYIkblYSHUre/I5xgWB0EO1oMQ/HnEGq7Xd4zaT7ZjV/P9LvEt/W0CjjHHmKeGj7DoyXrLvcixfy+vnktOXmlSX56Rkben/ZLR5A98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123297; c=relaxed/simple;
	bh=BwwodYJ7BjB/DVTaKY11QGv2wAQaNknrzCEwRkYhe+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SA8LJg+qfBd/EIYcBqNKtfVlW1ejvpUOEB0BNklOt/4nYuqYD6zmkf8OdFfgNt/q9k4QP6rcQbs95vPpBohJTWFGOVCgP+RNGYiq03yvsdnW1ZC2UO/3Qhl+R+A4FXcLvQ3abs4l+OdaGGM/X7ySX1wgZJisAOAS+d3id6klJ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJkEIJbD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJkEIJbD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27871F00898;
	Fri, 11 Sep 2026 10:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123295;
	bh=L+E9PV38BVLYYG+zEIQyCkcmPTCn7hqDtuZAw44nhdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JJkEIJbDrH2Y6mjWkdi0UUX8Q7U5cx3UHmeKPtt1BOxFQDTK1orMewckDHxvvuKYO
	 7raMBzYCNVebHEBr11m77gwk51aIYge68pWbvmQ5Q34JIRi96ZDlHpMLlZeo7NbsBt
	 A+874+H83U/vOtopOEc080UOuAjhrThcCeDASZ8SrJP6avRt1CLpX8CLsf8l0cs1kN
	 fOQ7YgZAZvqCBgPEJEcaq6No0wDGM9Sjoo5SAX5QUjqxTtwAY1dbcjL3POLAK3+Rft
	 LM19+0S541ZUJyvmhri9bgjyN85/IHCcMfLsIcBkrVCAYQiCOLx9RfX+enpLCiXKWP
	 G+SmtRIY6pbvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/5] ASoC: Intel: Drop hdac_ext usage for codec device creation
Date: Fri, 11 Sep 2026 06:41:29 -0400
Message-ID: <20260911104130.193213-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104130.193213-1-sashal@kernel.org>
References: <2026090904-antiques-gallantly-338c@gregkh>
 <20260911104130.193213-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 3fd63658caed9494cca1d4789a66d3d2def2a0ab ]

To make snd_hda_codec_device_init() the only constructor for struct
hda_codec instances remaining tasks are:

1) no struct may wrap struct hda_codec as its base type
2) bus drivers (skylake and sof) which are the current hdac_ext users
   need to be adjusted to make use of newly added codec init and exit
   routines instead
3) as bus drivers (skylake and sof) are to be responsible for creating
   codec device and assigning it to hdac_hda_priv->codec,
   hdac_hda_dev_probe() has to be freed of that job

To keep git bisect happy, all of these in made in one-go.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220816111727.3218543-4-cezary.rojewski@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

[5.15 dependency adaptation]
Keep the existing embedded codec and hdac_ext allocation model. The
constructor conversion is unnecessary for the target fix and depends on
subsequent codec-release changes absent from this stable tree. Dropping
that conversion also preserves the existing HDAC_DAI_ID_NUM bounds fix
and avoids the upstream SOF fallback's missing constructor argument.

Retain the driver-data ordering needed by 6ad4892c4f5c by moving
dev_set_drvdata() before component registration in hdac_hda_dev_probe(),
rather than moving codec allocation into the bus drivers. This removes
the assignment between registration and link release while ensuring
component probing can access its private data. Match the target's
registration-call context and function-qualified error diagnostic so its
unmodified patch applies cleanly. Leave the link-refcount fix itself to
the target commit. No functions are added.

[ sashal: Reduced backport -- upstream 3fd63658caed9 touches 6 file(s), this
  backport carries 1. Not backported here:
  sound/soc/codecs/hdac_hda.h
  sound/soc/intel/boards/hda_dsp_common.c
  sound/soc/intel/boards/skl_hda_dsp_generic.c
  sound/soc/intel/skylake/skl.c
  sound/soc/sof/intel/hda-codec.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 6ad4892c4f5c ("ASoC: hdac_hda: Fix hlink refcount leak on component registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hda.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index de5955db0a5f0..3cb5ae7fb5269 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -593,16 +593,18 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 	if (!hda_pvt)
 		return -ENOMEM;
 
+	dev_set_drvdata(&hdev->dev, hda_pvt);
+
 	/* ASoC specific initialization */
 	ret = devm_snd_soc_register_component(&hdev->dev,
-					 &hdac_hda_codec, hdac_hda_dais,
-					 ARRAY_SIZE(hdac_hda_dais));
+						&hdac_hda_codec, hdac_hda_dais,
+						ARRAY_SIZE(hdac_hda_dais));
+
 	if (ret < 0) {
-		dev_err(&hdev->dev, "failed to register HDA codec %d\n", ret);
+		dev_err(&hdev->dev, "%s: failed to register HDA codec %d\n", __func__, ret);
 		return ret;
 	}
 
-	dev_set_drvdata(&hdev->dev, hda_pvt);
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
 
 	return ret;
-- 
2.53.0

