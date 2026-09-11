Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBDD3AAF7B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123809; cv=none; b=RN+KyyH308byx38Hf286VK04PDvsC/ejwNJtlNemuk1hijBVTvOgGvayLxOXjvu3Fd9JktophB5Bf+FJAc/cV33kj9zfKdmn8AQHqcF3LUs3JDqw2kG8ZrA/W0AYmCX7uooUCkcoMibsI8Btfb3nmEtRH4UeDay/CTvWi+XIonQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123809; c=relaxed/simple;
	bh=BwwodYJ7BjB/DVTaKY11QGv2wAQaNknrzCEwRkYhe+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBEVOBaOW8w1yTg/BYYBmhcaXiUX6F0FrHtaXiM7NJYQfNs/gg3BI6VqLqilk6WaTFez5N/HTfqbp5PYsKGeTlaPUtcYI+h9ZVZJgLFQR5uMlOc4H6fdbxcP1IjvRuGXQP12YJYoe+FFBLLxbIIlQmDu6VyxfGl/TKGdebJ9iOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsZhGSsJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsZhGSsJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3279F1F000FF;
	Fri, 11 Sep 2026 10:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123807;
	bh=L+E9PV38BVLYYG+zEIQyCkcmPTCn7hqDtuZAw44nhdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZsZhGSsJYtu6A8gr7dAKRAONnJM+6Uers9fYlYSmVNiJyovhu7+cHO+niLbtt2uhp
	 2VMLUzea58uiRZLkiAJJItE9T5eQ7nTNc1W4nejtE4qntb4IAVkh58jNNnr7P773VW
	 VYPGPDiCVk79D4J5q1pssHbAinM8yF7ejOozDHIA+XM0bF3krowQH6PUMSv4cyxfnB
	 +V3XqkFexoPW1+8NQQxfnA29aU5GOSOztOs3nrmXKYJ/rEww4Kr9UYWL0ofARQAeTe
	 GX25fgAms/RqxvlKVh8zHvLp+inzS7hoXp8fcQSO1+kL8DUm/di0m6SSHohvvuzLAw
	 VPzRLAHV61JiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] ASoC: Intel: Drop hdac_ext usage for codec device creation
Date: Fri, 11 Sep 2026 06:50:01 -0400
Message-ID: <20260911105003.268248-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911105003.268248-1-sashal@kernel.org>
References: <2026090904-payphone-halved-2f01@gregkh>
 <20260911105003.268248-1-sashal@kernel.org>
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

