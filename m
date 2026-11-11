Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374020;
	b=qbU3S5xXWykIuj+E/kp3EtG6NO9elXs4wP3CQu8biRDLIswqEYu3OiSokuSvh87eHX5P
	 kkOpF6iyz116jdhvGrJTlwjD3ALOWdGJwGxWtCbxF0/dAFUI6/jn/SyY1vVrmQnEbPlGD
	 49BnaJzZanttXWjcy+qZDB+dWm/5OOEyzVgezBhScV6qHaRzy/8sBwXdL1YMi442MwzUv
	 Z/f4jBPqLTueApct+f2yTSKbYVqO8Shc9RZufYD3H2VkkOT4rvjsZ7co/7ryEW97y7M8e
	 wyUo30fM2i+DlTW+BTbnTYghZTdgaXYf8WBz0w0kKMVJG/nJWukel/fLH3Ao5stR3Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374020;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=As1VRQ2kV6KaFJ6MvZh133E+S2xVYt6MVQIV7bQiksY=;
	b=yVCL6zACQIs9pOILibA1GNQxiHsO2GNZ/mjNCNoXz6af05639SCAQg7i2vKVbd9++KbW
	 VpkLpaTKz/llq4MiJhydeFS+MIVsl79Q2JgHfmlfecZQpNsifTVu0xaPOWfHC9N03iTdD
	 MPdabdejRSJizzR5KX/vvmIlk3wEHukSXWS4Qxzd2xnzO2YEtURK4vATxoiAZeSK8vsPo
	 NcjBSon5UOX59Z7FCuSTLlKHCx87ZHdRA+gmI7bgxnC4atXomt5RZqPOnLUT00YpkPDBn
	 zOMVjo2QaF2xtVOUBzyHliqlJJ2TyGO0P5J3nHFE8cuelp4dTZ2OSDJ6786AHqxwflg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QyjtWHhK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C912D606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QyjtWHhK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3081F00A00;
	Wed, 11 Nov 2026 05:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794374020;
	bh=As1VRQ2kV6KaFJ6MvZh133E+S2xVYt6MVQIV7bQiksY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QyjtWHhK47aIF0YfcTvTF14HJ8qKEXK8AxJoAQmK18oVtA+mDnXROsQDwn8677VQT
	 EdzqJl8TekTGfGyu0NFs+L9KeaLpFbQIV6IjwPAc1iNG5uYSQCTMPWnQZOFgRxpvFq
	 uJk9OYaDlc/9zU5KCu+Z1b8tRc55ovUkM1hPxYJF5lXSEWSt4L4q4AeLjoPJpgUQhl
	 4PwCF0QC6mt3Bkyul0JJrv6j+TNYSWvum42+1ll6n4VD7cm0+oZ7q8KO8pBM6msCtu
	 ukPC786YTbYkzhlJl3/o1NdwWvBxZPtyn8q77+Xvhx0fzny9IdBxIUEm/eiLqIHd8j
	 dV3Uf4GNwT4pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] ASoC: hdac_hda: Allocate the private data at codec driver bind
Date: Wed, 11 Nov 2026 00:13:34 -0500
Message-ID: <20261111051038.1204227-4-sashal@kernel.org>
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
 sound/soc/codecs/hdac_hda.c     | 12 +++++++++++-
 sound/soc/sof/intel/hda-codec.c | 22 ++++------------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 2ca9104853970..e1f53e8fb8295 100644
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
 	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
 	if (!hlink) {
diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 8603694710e0a..d156d0264a2c7 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -18,8 +18,6 @@
 #include "hda.h"
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
-#include "../../codecs/hdac_hda.h"
-
 #define CODEC_PROBE_RETRIES	3
 
 #define IDISP_VID_INTEL	0x80860000
@@ -130,7 +128,6 @@ static struct hda_codec *hda_codec_device_init(struct hdac_bus *bus, int addr, i
 /* probe individual codec */
 static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 {
-	struct hdac_hda_priv *hda_priv;
 	struct hda_bus *hbus = sof_to_hbus(sdev);
 	struct hda_codec *codec;
 	u32 hda_cmd = (address << 28) | (AC_NODE_ROOT << 20) |
@@ -150,26 +147,15 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
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

