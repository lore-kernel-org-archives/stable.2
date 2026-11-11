Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374017;
	b=oNdEp7qA4d3u2+XeVoN9EuoCWQzymHEc9s5r/xTqTaBrO5dB6aEMlLTPnlMsFTmGjceF
	 sV8IoPOQq2EGXCT6I51ggLBe7/XUufjfcUw0NcwinX7qK7xfXg8mA7FjnVgV7+YgBVjjG
	 SDnM11Kpm3Bw+wTVsg8eQxZ3DW8kn1f+ojSjGirPNJAkFLHsah+3ywBVN6c/B5rftqeOg
	 /YQAcp8ELMyPhN8t2I8s2+N34P33V+nhqhQDnUvZ+Hc1cdYa6WjYvDeobcaDZru4PaBaB
	 2Ebx7RU/gKIVn6jUaO2F/yT2kDCjDBBQvDk1YcMzslPlYKAkq8/5HYJDbkL7ZL94lKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374017;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VOSrKoLUcifzP6IR30TbhfvoHliCPDV3wNhekHJL+Sg=;
	b=kxrTMLO0kuXPZC12HGF5fIjleEXaEzEAQHTZ/EtC7WUAjZCSzYajERYLKXiUPZF292FJ
	 8oX0nXHai3MBkVrSNv87MQoYU28oKZfGdH+pK9wgt1hJueWoWYV5GMEJgBKSG5EoOCe3M
	 tBVBee6HoY18yEIG3YnuS9n9TLl/n1a+4ku20XwQJhl5MiZ/U7BZgFBhFSkQYoZkIUJBi
	 MdD1Zcuodsd8B0AfU7/LLrvTCprSUJhY4yWfr7BpUFauZzl6ECwsBPvZujdhZFyvVo5mp
	 uqmixNEsi32YCWFK5QGfiGfSUI08gUCAeC8JOvLkDf1sm0a4b3Vw92CpqvIHHGL3Bmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/o8ZFVg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42CB606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/o8ZFVg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E7B1F0093C;
	Wed, 11 Nov 2026 05:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794374017;
	bh=VOSrKoLUcifzP6IR30TbhfvoHliCPDV3wNhekHJL+Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U/o8ZFVg/RxKVJWZCAP1WrrsGQ3QY46eWgTfFK4F/qsQL6xY7o+DGOPLrenmTaJa3
	 vk0TNjia1Oz+aWzqomDu/tw1a7Z4rmxVQV1voRYSoGOiGPfqySeE0cDnVm4GqqrQ1V
	 T+ey2Ngd+z316HRDswP+L3iCE0HsshnG0LiocOtFEabIYTlQQuHdMrZgfv+OSumBEO
	 bdhq6bXDxalkxFB+e5jaggc+TyuCenR/bzcStewnsauRt/VWKUViJf2lg1pBrnrCo2
	 5FRTjQdoYaFQg4bFhTj7q8q8ob+EPPdSyIdPtJkZJpYQgmJQvbXigrclN6THP+qSnh
	 77mTCxhpIQ1KQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] ASoC: SOF: Intel: remove option to disable the common_hdmi handling
Date: Wed, 11 Nov 2026 00:13:31 -0500
Message-ID: <20261111051038.1204227-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055548-failed-6.1-08a44bde821d@kernel.org>
References: <20261107055548-failed-6.1-08a44bde821d@kernel.org>
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

[ Upstream commit 834c69d3b849625d5c5bb81a3425fc8deef5f16d ]

We've been using the same option for quite some time now, it's time to
remove the kernel parameter to disable the common HDaudio codec
handling.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20221027193540.259520-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 08a44bde821d ("ASoC: hdac_hda: Restore the codec device type on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 12 +++---------
 sound/soc/sof/intel/hda.c       | 10 ++--------
 sound/soc/sof/intel/hda.h       |  6 ++----
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index a75f81116643b..5827747cce2ae 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -133,8 +133,7 @@ static struct hda_codec *hda_codec_device_init(struct hdac_bus *bus, int addr, i
 }
 
 /* probe individual codec */
-static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
-			   bool hda_codec_use_common_hdmi)
+static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 	struct hdac_hda_priv *hda_priv;
@@ -164,10 +163,6 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
 	if (!hda_priv)
 		return -ENOMEM;
 
-	/* only probe ASoC codec drivers for HDAC-HDMI */
-	if (!hda_codec_use_common_hdmi && (resp & 0xFFFF0000) == IDISP_VID_INTEL)
-		type = HDA_DEV_ASOC;
-
 	codec = hda_codec_device_init(&hbus->core, address, type);
 	ret = PTR_ERR_OR_ZERO(codec);
 	if (ret < 0)
@@ -215,8 +210,7 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
 }
 
 /* Codec initialization */
-void hda_codec_probe_bus(struct snd_sof_dev *sdev,
-			 bool hda_codec_use_common_hdmi)
+void hda_codec_probe_bus(struct snd_sof_dev *sdev)
 {
 	struct hdac_bus *bus = sof_to_bus(sdev);
 	int i, ret;
@@ -227,7 +221,7 @@ void hda_codec_probe_bus(struct snd_sof_dev *sdev,
 		if (!(bus->codec_mask & (1 << i)))
 			continue;
 
-		ret = hda_codec_probe(sdev, i, hda_codec_use_common_hdmi);
+		ret = hda_codec_probe(sdev, i);
 		if (ret < 0) {
 			dev_warn(bus->dev, "codec #%d probe error, ret: %d\n",
 				 i, ret);
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 4ba7c4be670dd..dbbc78d65e46e 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -388,12 +388,6 @@ static int mclk_id_override = -1;
 module_param_named(mclk_id, mclk_id_override, int, 0444);
 MODULE_PARM_DESC(mclk_id, "SOF SSP mclk_id");
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-static bool hda_codec_use_common_hdmi = IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI);
-module_param_named(use_common_hdmi, hda_codec_use_common_hdmi, bool, 0444);
-MODULE_PARM_DESC(use_common_hdmi, "SOF HDA use common HDMI codec driver");
-#endif
-
 static const struct hda_dsp_msg_code hda_dsp_rom_fw_error_texts[] = {
 	{HDA_DSP_ROM_CSE_ERROR, "error: cse error"},
 	{HDA_DSP_ROM_CSE_WRONG_RESPONSE, "error: cse wrong response"},
@@ -924,7 +918,7 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 		snd_hdac_ext_bus_get_ml_capabilities(bus);
 
 	/* create codec instances */
-	hda_codec_probe_bus(sdev, hda_codec_use_common_hdmi);
+	hda_codec_probe_bus(sdev);
 
 	if (!HDA_IDISP_CODEC(bus->codec_mask))
 		hda_codec_i915_display_power(sdev, false);
@@ -1340,7 +1334,7 @@ static void hda_generic_machine_select(struct snd_sof_dev *sdev,
 	if (*mach) {
 		mach_params = &(*mach)->mach_params;
 		mach_params->codec_mask = bus->codec_mask;
-		mach_params->common_hdmi_codec_drv = hda_codec_use_common_hdmi;
+		mach_params->common_hdmi_codec_drv = true;
 	}
 }
 #else
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 773df987d6473..a4737c8e4fcb3 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -705,8 +705,7 @@ void sof_hda_bus_init(struct hdac_bus *bus, struct device *dev);
 /*
  * HDA Codec operations.
  */
-void hda_codec_probe_bus(struct snd_sof_dev *sdev,
-			 bool hda_codec_use_common_hdmi);
+void hda_codec_probe_bus(struct snd_sof_dev *sdev);
 void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev, bool enable);
 void hda_codec_jack_check(struct snd_sof_dev *sdev);
 
@@ -722,8 +721,7 @@ int hda_codec_i915_exit(struct snd_sof_dev *sdev);
 
 #else
 
-static inline void hda_codec_i915_display_power(struct snd_sof_dev *sdev,
-						bool enable) { }
+static inline void hda_codec_i915_display_power(struct snd_sof_dev *sdev, bool enable) { }
 static inline int hda_codec_i915_init(struct snd_sof_dev *sdev) { return 0; }
 static inline int hda_codec_i915_exit(struct snd_sof_dev *sdev) { return 0; }
 
-- 
2.53.0

