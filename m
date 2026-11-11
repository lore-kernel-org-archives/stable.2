Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372734;
	b=FnjQ4qRX8s8icB+w/SnUJUVqmZcCdz8IMBMJdmMAb2SrHkCCC7CfurK7wfKofQDR/b5Y
	 7A+9Cpb57Dk0kMTYi8c+INAEj3MwfFPB8AALNjCUIBIODzk7tF2tqR7aXXkzwHYE1T9Ws
	 PjWnXbKDUrGmOsMTlf6aycWcbsU5hKEygCMJTNC2gANc4t7nvFUnYof6ZHDM0P0JhzEhA
	 CdD8lHVRPI39WkRPgXR7la2y1QlqVkYWqZBRPDaVDbnDclAMSZNPsuGtlZ9LyTqEHJje2
	 hIP/5ghwv2NVc67DLrZptCtSPVmf2BYGwTxqwowHdDsAmw58caO1RidX9Ntwito5bHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372734;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nyb4Q4LZEhp+uC8X35Si7vYml4whZpMSjqzv7dl7JAM=;
	b=b/hVu/8tzOoCp7IsMTp2kievlwwNUnoMirmpou1n5rGbRdfpQaGcqTOgrNgKu0zCAzpO
	 FWK6lpSicsneWqvSikR+2swZ3raiyTDg4AvdhvrqD9UXfghhnIChahCuKFDeXMtiyo2Ue
	 yMVIOa5Ou3jQtvNHW3aPMXUz2+uHtgsTFocuIx4TfiOqggio0sspXjNJMoRRpKZxLc0Gt
	 vMiM3BWm5dhxpOCL2K4FNJFQeBisRJzVp7ecxOnAc08EbFFwMvUeBz0gyj+WUFex/6Umw
	 Tlcz3Dcx0pYAv5B3yzt1y+lwljL/nkc1h5Ll0vgw9AVw+LiW3cw2p2ysJ0ttbwQ9ZZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHPPeYMd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BA6606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHPPeYMd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9281F0089F;
	Wed, 11 Nov 2026 04:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372734;
	bh=nyb4Q4LZEhp+uC8X35Si7vYml4whZpMSjqzv7dl7JAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jHPPeYMd0FbO4eU+2GppATRwYzfLERi7Vgtm3GGGOvpv/reybTyWpDZNcfFPUYWut
	 ao1BIQezI+0Bn9t3RMdyiIBjPqLMZ0oDBRizr2Gcfm6spCai4So+je1ZLpTDH5RniI
	 qEgCZQWXdVjtipZve1mwqLJ0p+7srloXZWskk7eBT0+EdoeTk53d1g0nMk/7UsVTND
	 m91L1B+aXXT31Jd6OclYlxIBQCAu6NYZM4BOz/N5Nd/ImM7M9nHOEQhhBCRGlwLGDn
	 JjI0noWDklSM/KkcHTfL8AXAv1ZA7DJlJk6OYIlZQyAz9Mk49F+9fDcg5maBLxxVWM
	 JMetYfYwyM4Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ASoC: hdac_hda: Allocate the private data at codec driver bind
Date: Tue, 10 Nov 2026 23:52:11 -0500
Message-ID: <20261111044945.1160231-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053955-failed-6.6-08a44bde821d@kernel.org>
References: <20261107053955-failed-6.6-08a44bde821d@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 7d357eae973a1e1933f81f55aa1b3b4e3064570f ]

The SOF HDA code allocates struct hdac_hda_priv and stores it as drvdata
of the codec device before the codec driver is bound. The driver core
clears drvdata on unbind, so after unbinding the codec driver via sysfs
a subsequent bind dereferences a NULL pointer in hdac_hda_dev_probe().

All information in the private data can be derived from the codec
device itself, so allocate and set it up in hdac_hda_dev_probe() as a
device managed resource, which is released on unbind.

Remove the allocation from SOF, keeping the check for iDisp codecs
without display audio component.

Fixes: 3fd63658caed ("ASoC: Intel: Drop hdac_ext usage for codec device creation")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20261027083840.28813-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>

Omit the dev_index initialization because the private structure has no
such member and the firmware patch loader that uses it is absent. Keep
the allocation tied to codec driver binding and preserve the existing
iDisp audio-component check.

Stable-dep-of: 08a44bde821d ("ASoC: hdac_hda: Restore the codec device type on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hda.c     | 12 +++++++++++-
 sound/soc/sof/intel/hda-codec.c | 22 ++++------------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index a3229a51eef33..5a196a756aaf4 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -606,10 +606,20 @@ static const struct snd_soc_component_driver hdac_hda_hdmi_codec = {
 
 static int hdac_hda_dev_probe(struct hdac_device *hdev)
 {
-	struct hdac_hda_priv *hda_pvt = dev_get_drvdata(&hdev->dev);
+	struct hdac_hda_priv *hda_pvt;
 	struct hdac_ext_link *hlink;
 	int ret;
 
+	hda_pvt = devm_kzalloc(&hdev->dev, sizeof(*hda_pvt), GFP_KERNEL);
+	if (!hda_pvt)
+		return -ENOMEM;
+
+	hda_pvt->codec = dev_to_hda_codec(&hdev->dev);
+	/* Intel iDisp (HDMI/DP) codec */
+	if (((hdev->vendor_id >> 16) & 0xFFFF) == 0x8086)
+		hda_pvt->need_display_power = true;
+	dev_set_drvdata(&hdev->dev, hda_pvt);
+
 	/* hold the ref while we probe */
 	hlink = snd_hdac_ext_bus_get_hlink_by_name(hdev->bus, dev_name(&hdev->dev));
 	if (!hlink) {
diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 82a6707fb4b80..0bb9e547127ba 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -15,8 +15,6 @@
 #include "hda.h"
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
-#include "../../codecs/hdac_hda.h"
-
 #define CODEC_PROBE_RETRIES	3
 
 #define IDISP_VID_INTEL	0x80860000
@@ -139,7 +137,6 @@ static struct hda_codec *hda_codec_device_init(struct hdac_bus *bus, int addr, i
 /* probe individual codec */
 static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 {
-	struct hdac_hda_priv *hda_priv;
 	struct hda_bus *hbus = sof_to_hbus(sdev);
 	struct hda_codec *codec;
 	u32 hda_cmd = (address << 28) | (AC_NODE_ROOT << 20) |
@@ -159,26 +156,15 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 	dev_dbg(sdev->dev, "HDA codec #%d probed OK: response: %x\n",
 		address, resp);
 
-	hda_priv = devm_kzalloc(sdev->dev, sizeof(*hda_priv), GFP_KERNEL);
-	if (!hda_priv)
-		return -ENOMEM;
-
 	codec = hda_codec_device_init(&hbus->core, address, HDA_DEV_LEGACY);
 	ret = PTR_ERR_OR_ZERO(codec);
 	if (ret < 0)
 		return ret;
 
-	hda_priv->codec = codec;
-	dev_set_drvdata(&codec->core.dev, hda_priv);
-
-	if ((resp & 0xFFFF0000) == IDISP_VID_INTEL) {
-		if (!hbus->core.audio_component) {
-			dev_dbg(sdev->dev,
-				"iDisp hw present but no driver\n");
-			ret = -ENOENT;
-			goto out;
-		}
-		hda_priv->need_display_power = true;
+	if ((resp & 0xFFFF0000) == IDISP_VID_INTEL && !hbus->core.audio_component) {
+		dev_dbg(sdev->dev, "iDisp hw present but no driver\n");
+		ret = -ENOENT;
+		goto out;
 	}
 
 	if (is_generic_config(hbus))
-- 
2.53.0

