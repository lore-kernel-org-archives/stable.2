Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374020;
	b=naIi58iQe07M7F9pucInKbwL5GkyMk0HQmJWIhvs2nlJO+PgIRHFY7iW3/bgPo8elh8Z
	 GAHN+gmcQuXDEm8oSQ9EQeOAwgUlF4d2xo2Sta4WGFNlHFUyhCo2svE9TWSZrXwQGOkgt
	 iF5JrLub0zXRu5kUFFSfiFi1+7rrr2XqgcM2XR1XPLROepWoK09bN+e5tOBEQyuMM+5Cs
	 n/Tzu/m1++r5BxgrLhEcZmOcagWYwO74OJfF5iEuGppv9kotYXyqq67btNONZdF03UOXG
	 0UIQZcfoNvtAmx8m0K5lfjWdZSsAogROec8rMFtrVynWynVRFtvL3dqJCMhoR55SBUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374020;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7iFD0qncTC0ObyIyI6/2q9e+J9LPe8z4LG3n4KPmA24=;
	b=CELDSRcnFOvsaCBY4+yTbO9wZvGphNCSqMPiMzRF7wNn3ju74y5Yc3p0xQABpUTNgy2s
	 KNdHsTG4nV4BW53VfjuAovrV6ieV0GZddCsKPWDRTW9K9Y6h3TO6RV3AsIfKKnw0v/9WJ
	 JEznEW39oWx0DxFNYeC77vURCrTZhWTGdFwbVexA9TSqeys9vjg7Ze65HnuQXCreIbS9v
	 FaB1bO3YAR8ZwswM+OSgig25FyUdJjsKHaAYbMgJz3La6e9nSH6oc10AcL5/CQpBvC6AR
	 PRJ475Dgay7PIUFKcZ13qRJqrwAe2xfHzfWnWdmZ+VnmNZyNPVi3XJ/bKc7u2NOTzBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQo4vUeN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0030A606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQo4vUeN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75C71F0089F;
	Wed, 11 Nov 2026 05:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794374019;
	bh=7iFD0qncTC0ObyIyI6/2q9e+J9LPe8z4LG3n4KPmA24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eQo4vUeNOZcrSGIBkn/vSZhG/N/IltgqEy4FlPrlv7xaWuE8K5o4qCSETeK12PWJ1
	 ULDlWSHLLCnKqDtSBvbbsEstx8AyDdG5rkujDid/cc9X4rGEW6IehLn5mPf/YZbDPS
	 2h83WV1MqKsWvgjQD2sFqT1mjCRr6NNlPa4iKHfeagqW1TiWQxDu3eB3WoralttswE
	 XTmc4MlKB0WzBl5j2T1nlPOaP4bUEBwcov3qkWiX5aAxNRRlkVMxQKSOt1ojyf7c2t
	 rbby8dU/mp5/q6U3AivFIYKAkW/KI8lHDVTmJVcs7unud6BdW74shsHSzzbz8CA1el
	 J2NqST7cziIFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] ASoC: SOF: Intel: hda-codec: simplify SND_SOC_SOF_HDA_AUDIO_CODEC handling
Date: Wed, 11 Nov 2026 00:13:33 -0500
Message-ID: <20261111051038.1204227-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111051038.1204227-1-sashal@kernel.org>
References: <20261107055548-failed-6.1-08a44bde821d@kernel.org>
 <20261111051038.1204227-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit dc1d964a44dd9eb236f4e98b7b1eaa776093ca8b ]

Now that we have removed the dependency on SND_SOC_HDAC_HDMI, we can
simplify the code and make the code conditional on a single #ifdef.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20221027193540.259520-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 08a44bde821d ("ASoC: hdac_hda: Restore the codec device type on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 37 +++++++++++----------------------
 sound/soc/sof/intel/hda.h       | 10 +++++++--
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index a95b04d420279..8603694710e0a 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -16,13 +16,12 @@
 #include <sound/sof.h>
 #include "../ops.h"
 #include "hda.h"
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 #include "../../codecs/hdac_hda.h"
-#endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
 
 #define CODEC_PROBE_RETRIES	3
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 #define IDISP_VID_INTEL	0x80860000
 
 /* load the legacy HDA codec driver */
@@ -88,6 +87,7 @@ void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev, bool enable)
 
 	snd_hdac_chip_updatew(bus, WAKEEN, STATESTS_INT_MASK, mask);
 }
+EXPORT_SYMBOL_NS(hda_codec_jack_wake_enable, SND_SOC_SOF_HDA_AUDIO_CODEC);
 
 /* check jack status after resuming from suspend mode */
 void hda_codec_jack_check(struct snd_sof_dev *sdev)
@@ -103,11 +103,6 @@ void hda_codec_jack_check(struct snd_sof_dev *sdev)
 		if (codec->jacktbl.used)
 			pm_request_resume(&codec->core.dev);
 }
-#else
-void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev, bool enable) {}
-void hda_codec_jack_check(struct snd_sof_dev *sdev) {}
-#endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
-EXPORT_SYMBOL_NS(hda_codec_jack_wake_enable, SND_SOC_SOF_HDA_AUDIO_CODEC);
 EXPORT_SYMBOL_NS(hda_codec_jack_check, SND_SOC_SOF_HDA_AUDIO_CODEC);
 
 #if IS_ENABLED(CONFIG_SND_HDA_GENERIC)
@@ -135,10 +130,7 @@ static struct hda_codec *hda_codec_device_init(struct hdac_bus *bus, int addr, i
 /* probe individual codec */
 static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 {
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 	struct hdac_hda_priv *hda_priv;
-	int type = HDA_DEV_LEGACY;
-#endif
 	struct hda_bus *hbus = sof_to_hbus(sdev);
 	struct hda_codec *codec;
 	u32 hda_cmd = (address << 28) | (AC_NODE_ROOT << 20) |
@@ -158,12 +150,11 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 	dev_dbg(sdev->dev, "HDA codec #%d probed OK: response: %x\n",
 		address, resp);
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 	hda_priv = devm_kzalloc(sdev->dev, sizeof(*hda_priv), GFP_KERNEL);
 	if (!hda_priv)
 		return -ENOMEM;
 
-	codec = hda_codec_device_init(&hbus->core, address, type);
+	codec = hda_codec_device_init(&hbus->core, address, HDA_DEV_LEGACY);
 	ret = PTR_ERR_OR_ZERO(codec);
 	if (ret < 0)
 		return ret;
@@ -186,25 +177,19 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 	else
 		codec->probe_id = 0;
 
-	if (type == HDA_DEV_LEGACY) {
-		ret = hda_codec_load_module(codec);
-		/*
-		 * handle ret==0 (no driver bound) as an error, but pass
-		 * other return codes without modification
-		 */
-		if (ret == 0)
-			ret = -ENOENT;
-	}
+	ret = hda_codec_load_module(codec);
+	/*
+	 * handle ret==0 (no driver bound) as an error, but pass
+	 * other return codes without modification
+	 */
+	if (ret == 0)
+		ret = -ENOENT;
 
 out:
 	if (ret < 0) {
 		snd_hdac_device_unregister(&codec->core);
 		put_device(&codec->core.dev);
 	}
-#else
-	codec = hda_codec_device_init(&hbus->core, address, HDA_DEV_ASOC);
-	ret = PTR_ERR_OR_ZERO(codec);
-#endif
 
 	return ret;
 }
@@ -231,6 +216,8 @@ void hda_codec_probe_bus(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(hda_codec_probe_bus, SND_SOC_SOF_HDA_AUDIO_CODEC);
 
+#endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC) && IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
 
 void hda_codec_i915_display_power(struct snd_sof_dev *sdev, bool enable)
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index b032f4a4e232b..dc6b1a6e9508d 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -701,7 +701,7 @@ void hda_dsp_ctrl_stop_chip(struct snd_sof_dev *sdev);
  */
 void sof_hda_bus_init(struct hdac_bus *bus, struct device *dev);
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 /*
  * HDA Codec operations.
  */
@@ -709,7 +709,13 @@ void hda_codec_probe_bus(struct snd_sof_dev *sdev);
 void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev, bool enable);
 void hda_codec_jack_check(struct snd_sof_dev *sdev);
 
-#endif /* CONFIG_SND_SOC_SOF_HDA */
+#else
+
+static inline void hda_codec_probe_bus(struct snd_sof_dev *sdev) { }
+static inline void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev, bool enable) { }
+static inline void hda_codec_jack_check(struct snd_sof_dev *sdev) { }
+
+#endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC) && IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
 
-- 
2.53.0

