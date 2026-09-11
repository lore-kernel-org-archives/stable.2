Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1CD42E8DC
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123297; cv=none; b=dFQkyY4UOfRXiwOsxk4xGISaikzDROEoRCPRxMjuWga58Bqpg9FhtNVLWqa+VOsoYdawfhhbbtAxxlEeHjY1aj35TIfEyd3FUZ3aj+YEhFPw9J6AhjRfYeN/1wJefncH4U3VsxGRMjUV+UFhJkOL3AIpfQiHl9hjV01Y9XibE/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123297; c=relaxed/simple;
	bh=x09UrOk8QvjTC2uI7lS+JTdDu16lk0zf99/ya6K5w8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6Zt4vm3yszWHG1IQoSnzGbg1nY1TDJu6eIX8q5rozformBHn83C6YeuDHbDwZYjylKbtxhe6owR6e2+b7V6bfjApSaj94Dqc+3wCe3gyrW9gGvNEiE87VCgjwHRuTbA9TuZjRcKNfOWiPsfwZNq9oJdLP5rg7SBDSd48nZB0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK9p6FUd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK9p6FUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29D81F0089C;
	Fri, 11 Sep 2026 10:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123294;
	bh=ZU30oOrW3U1WGXGMqZhcnc3v5SKSUo/rCLOWYSRp4mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IK9p6FUdAQzEbEufjiwAHEtn/M4W/YEaObXtcXhHmi6x1hI+6BoHF5m9kHCifBo4e
	 hX/gbCnGo1oH8zeGEAm1Z1+aX3/IkoGpx3WauiA3NId40U5TajWuf3VOZICWawYPTZ
	 mPrn5U346o/b1TqdBZeg++WelG223LFa5QSFLMTr6SzyeLqSnb1p2WjvjbRr6sgfE2
	 Ddozw3glwkM7kDaZnTU3e6y5FditDMAAsN+wdHHyKaQnZY5ih0hMFpewuMPWVvS6+Z
	 tRtYKerdNgPFES5oCcLNbnNKJAalhUTf3Q3CaEBAthLHjzLjvD3LLN+/iDfW94XxHR
	 pdUTIfqXrQ+8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] ASoC: SOF: Intel: Introduce HDA codec init and exit routines
Date: Fri, 11 Sep 2026 06:41:28 -0400
Message-ID: <20260911104130.193213-3-sashal@kernel.org>
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

[ Upstream commit 829c67319806009abfe3b0b82b3b8b153a2c5e32 ]

Preliminary step in making snd_hda_codec_device_init() the only
constructor for struct hda_codec instances. To do that, existing usage
of hdac_ext equivalents has to be dropped.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220816111727.3218543-3-cezary.rojewski@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 6ad4892c4f5c ("ASoC: hdac_hda: Fix hlink refcount leak on component registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 0449e7a2669ff..4a4bcc8223caf 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -107,6 +107,36 @@ EXPORT_SYMBOL_NS(hda_codec_jack_check, SND_SOC_SOF_HDA_AUDIO_CODEC);
 #define is_generic_config(x)	0
 #endif
 
+static void hda_codec_device_exit(struct device *dev)
+{
+	snd_hdac_device_exit(dev_to_hdac_dev(dev));
+}
+
+static __maybe_unused struct hda_codec *
+hda_codec_device_init(struct hdac_bus *bus, int addr, int type)
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
+	codec->core.type = type;
+	codec->core.dev.release = hda_codec_device_exit;
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
 /* probe individual codec */
 static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
 			   bool hda_codec_use_common_hdmi)
-- 
2.53.0

