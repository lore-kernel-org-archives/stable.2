Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371003;
	b=MF/BXl8RjmyobH9epnDdxYeqc/BE7NPkjwShsw+zMARHEWGUVlDgavidFlYOBrxFeuML
	 ZbqSquVZFi2T0Hq/MFWRuB1VOBvhOBdwljzDegubtjJgDZWF3pvlv2rUQ/ckTWXHd/rno
	 f9Ny1ELBblFIebHoLWCZYQx9PhTCM6t0lLCD8X0sZ3cZOpfgnT2CQgGxC4Uf6YvH6YnVc
	 8stbRcRpHEnGx61Abp5ybYVFsZFWnx6xujlLp3nSQww8KYCpF908W127FfjhCxyj6AngF
	 4CQwor/Ke3ACArKxf2HePjle1keot5sL25yQyLgKWfZQ4gWsSTSn1R76lPfM3l9O7Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371003;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vyjrwoV3vsZnHVQCpETiKi3SBR/X0Gy+dDn9wNX8PY8=;
	b=Cb3pYNVgJG35TGCsEni1FAdVUyDi2lvGGZaIaBnLfjgmTyLIMsCTXAH9AIQnJooIjTjv
	 EHkqVeIoIORi+L7czqycEWJ9rCmFiZ7k+fTlLbSa3yBEusRUsx5sU+h+U2MH4wkMmBkTy
	 rjiiUny2D75ZtQc4DvSWFNSWza0q30JLYGwLqAvKTjLkSFQ6TJA6HO6TBrS6TyQkzz7W+
	 Qwpdp9s0NCwAcufidUC1VYTPWUV3C81hTHbR5Y+Zn4LAtfXQq6clxWT2W+FmkfRNJGLK+
	 77Rsw67ym+HOYU/gb95bv4jWPCMy3DS6VQhyqacJawygmw5+lWGaQYFgtwEk0/9D0Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlQe7fdb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F338606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlQe7fdb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12051F0089F;
	Wed, 11 Nov 2026 04:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371003;
	bh=vyjrwoV3vsZnHVQCpETiKi3SBR/X0Gy+dDn9wNX8PY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hlQe7fdbI8y1/SBznd0cdb2hSUq5y9uRCvqaVl0yysaMSCLJ999jE+llm7h/eMklM
	 Z3xcPifYjH3jvqZlcnC4Cux0+4JV5Axp1nLQZ+0R1H26uDgCK79O0ileQBQcDOmAJw
	 0AvedEKnYorVS7s1FR5zhRZfSKvoVGKwn0zPWOuUhqq3W1X5bfwTwqvxIp+Jc7yBmE
	 gZNiyIC4At02+qUYtlv+M+NifsU7FZVvsWK/GVD09tZOIz3wLdXSg8kM/K+V3PEF4j
	 2rOUHjpt36nHwCAp4gSHpnbC/0zhGdG+B+TIcOOq8yX/QVcjSJZ3wVmEntozNKhC6U
	 ZyJgidg6fmvNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] ASoC: hdac_hda: Allocate the private data at codec driver bind
Date: Tue, 10 Nov 2026 23:23:20 -0500
Message-ID: <20261111042315.1087116-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050552-failed-7.3-08a44bde821d@kernel.org>
References: <20261107050552-failed-7.3-08a44bde821d@kernel.org>
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
Stable-dep-of: 08a44bde821d ("ASoC: hdac_hda: Restore the codec device type on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hda.c     | 13 ++++++++++++-
 sound/soc/sof/intel/hda-codec.c | 23 ++++-------------------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 40d602f79314a..0604315a1f0f3 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -635,10 +635,21 @@ static const struct snd_soc_component_driver hdac_hda_hdmi_codec = {
 
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
+	hda_pvt->dev_index = hdev->addr;
+	/* Intel iDisp (HDMI/DP) codec */
+	if (((hdev->vendor_id >> 16) & 0xFFFF) == 0x8086)
+		hda_pvt->need_display_power = true;
+	dev_set_drvdata(&hdev->dev, hda_pvt);
+
 	/* hold the ref while we probe */
 	hlink = snd_hdac_ext_bus_get_hlink_by_name(hdev->bus, dev_name(&hdev->dev));
 	if (!hlink) {
diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index fd371850b0d69..32fcc1cd3f923 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -15,8 +15,6 @@
 #include "hda.h"
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
-#include "../../codecs/hdac_hda.h"
-
 #define CODEC_PROBE_RETRIES	3
 
 #define IDISP_VID_INTEL	0x80860000
@@ -148,7 +146,6 @@ static struct hda_codec *hda_codec_device_init(struct hdac_bus *bus, int addr, i
 /* probe individual codec */
 static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 {
-	struct hdac_hda_priv *hda_priv;
 	struct hda_bus *hbus = sof_to_hbus(sdev);
 	struct hda_codec *codec;
 	u32 hda_cmd = (address << 28) | (AC_NODE_ROOT << 20) |
@@ -168,27 +165,15 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
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
-	hda_priv->dev_index = address;
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

