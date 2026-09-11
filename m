Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DA13AAF7B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123807; cv=none; b=Agiox7+lCbFMNoeBFaocdp5amYMYCoPQCMC+HqfZC/le7KgNHruPlOXqsjVZ6fXGTTrCIEcfWnI2d+1cjnt3Jiwz/YGSkVWxvSji1Teejej7fyANkZ0BvhwHuPg0Lh0GTVBN8OfeLtSXFvv5DlWZD1MJzvvB6Uah0PCdUSmsvbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123807; c=relaxed/simple;
	bh=LG1QSY9CLjJKF5DKNuwSYFr9DIpzno4shTWgAtMlXHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aulVpembNd2qFtSYtcB3A8uw4BwqRONdwbivdW8BAncFfpUqYxD2dWh0PaUzTQSpa+1RSp6TILrZj45pkOh8qTa05vLWVxyXkgEG+fDbwETpWb5sO7XYJ7kEZZoSOn1srmYmlqcz6o4ODyTQe3BFJXVuLkO0ZhGtIbDxnhrzRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbGgDCTX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbGgDCTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3137F1F00893;
	Fri, 11 Sep 2026 10:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123805;
	bh=ETPqvX22MDs3DagMufetBolanM1QBson5ugUJa8Qw9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FbGgDCTX2yFI8Gr2Tepv6JUhnVdGX46mn2Dq3V6H62yeExz6P3CHVES6uDVdzYqc+
	 LfSEokhUyVfGhujNSj/B9tOQi9Us2J9sC0d4aZY+eX1kDe+Z6f+BhtA2GjZEO7tQMO
	 2pBVuK9GU0h/nzbyvaabqxgqq8eNHFm4HrP4se012aTKi7BLVTB91T6lynx+wtq9Qj
	 8NLS0Hqsbbesc9GK2mRPTXolGG4O4eMiINm054R2YkRBiIbawVoyYluGSOtznhdrqg
	 gvK/oYYA5KGDYhjFsPdQ7BcMQsiaqI//ieeLqcavSOi358ZUobk6fhGL7HqSKVJR/P
	 CUtbpKTzssxaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] ASoC: Intel: Skylake: Introduce HDA codec init and exit routines
Date: Fri, 11 Sep 2026 06:49:59 -0400
Message-ID: <20260911105003.268248-2-sashal@kernel.org>
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

[ Upstream commit e4746d94d00c52918461bc169e009b6784a38e21 ]

Preliminary step in making snd_hda_codec_device_init() the only
constructor for struct hda_codec instances. To do that, existing usage
of hdac_ext equivalents has to be dropped.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220816111727.3218543-2-cezary.rojewski@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 6ad4892c4f5c ("ASoC: hdac_hda: Fix hlink refcount leak on component registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 2085e12dc611b..17c221061cf3f 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -689,6 +689,35 @@ static void load_codec_module(struct hda_codec *codec)
 
 #endif /* CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC */
 
+static void skl_codec_device_exit(struct device *dev)
+{
+	snd_hdac_device_exit(dev_to_hdac_dev(dev));
+}
+
+static __maybe_unused struct hda_codec *skl_codec_device_init(struct hdac_bus *bus, int addr)
+{
+	struct hda_codec *codec;
+	int ret;
+
+	codec = snd_hda_codec_device_init(to_hda_bus(bus), addr, "ehdaudio%dD%d", bus->idx, addr);
+	if (IS_ERR(codec)) {
+		dev_err(bus->dev, "device init failed for hdac device\n");
+		return codec;
+	}
+
+	codec->core.type = HDA_DEV_ASOC;
+	codec->core.dev.release = skl_codec_device_exit;
+
+	ret = snd_hdac_device_register(&codec->core);
+	if (ret) {
+		dev_err(bus->dev, "failed to register hdac device\n");
+		snd_hdac_device_exit(&codec->core);
+		return ERR_PTR(ret);
+	}
+
+	return codec;
+}
+
 /*
  * Probe the given codec address
  */
-- 
2.53.0

