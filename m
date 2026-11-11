Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371518;
	b=Z9MSUCCYUwJU9gF2mis6OA9rg46VDK1f96E2uakMd7KI5P5pqgrWmYTHoUJz3dCDyH3/
	 n0trR6xpG9rEP8fMYeGM7pCzJF6tFgP0GtFsPikmIx/TiuqNCfFhAVKNHo2U0dd9tT3pS
	 pZ84gYebkbQoj4PjZe8Qr2Po6YjSsYa0QUEJfSsvuJ9BNDFahPNmJiMAs2Z10mEIHZMXM
	 BY6w+x3woh99wCm8GEUfdnLcQLkIA3vNDYRbxInBeeh1mHlpj77EdaYnj2440tBVK+ICl
	 79jlHZFbxh+sRebavA41BcKWJO8o16Hgq7/DugFuREeb5ds2c/+yWOWX0tmCUgzaIVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371518;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Q4gbzMe1bO8VHpI/QG2wiMjW8UJfzaAsRSHC85PNg9o=;
	b=e4qpBnYgFyORU0GFSwKRhSYV7klcaiS4HKYqsYI8C008CB2uVvN+2r3A0fRh3tMIgjkv
	 uSDBJa8FRf7sxpGuJWgvTQ1AZRcff1RlNKvGfAMsszaxWWtzWVLEamKf+r9BYwk4yVZMo
	 si8tqMzk+ZppVV5GOthADdf1JETl8LomY+Md1q+MEQN8LiaS82U2LmYScEL3384pa2h1x
	 b0kQELTnRF9k6trReKiuFI3GyboPx9aDw9xr9Z749BKrhU6OJcWjI2NHZkUDEenf26CgH
	 ooZBhLAgq35VUNhrB4WRJwtb+Esw6CVA19FCLbrraqy8xx5sb5rpIGBYc3qH76xIJ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWccukn2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87843606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWccukn2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CE51F0089F;
	Wed, 11 Nov 2026 04:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371518;
	bh=Q4gbzMe1bO8VHpI/QG2wiMjW8UJfzaAsRSHC85PNg9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HWccukn2eeamf2pPDVLGoBUCwOC3D1cqBFUmdgZsIBa8nFUKfVhEjP7Hf+73Lz+Og
	 CbpbF5rPRjRNryYcSEzB1aR1EWO01r9I9F4WflAJw0fS5ISIPLsh46lR1GU/XTRgQO
	 NMz3i6yZ1l768eoLZLeC6UfOTEon2L3mQJni0w/dc1VpVDfeerXBI4vl9vwNBsuUjt
	 SdeJBhjsK2RrwCY3fW0o2RZ5azGcU5WybVLiL+dmbQ+twvEaqJV7myZWHubpsrSyRA
	 MsNpAnJWKzbXNcBH2SMxtCTvbmhkm6euqurIhgO2TsDm/YwuBCPLic/9Ok0bp1gTZ3
	 mJi288vkHEzyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ASoC: hdac_hda: Allocate the private data at codec driver bind
Date: Tue, 10 Nov 2026 23:31:55 -0500
Message-ID: <20261111043037.1105746-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051515-failed-6.18-08a44bde821d@kernel.org>
References: <20261107051515-failed-6.18-08a44bde821d@kernel.org>
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
index ac28b3cadb69f..e63b616afa79f 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -638,10 +638,21 @@ static const struct snd_soc_component_driver hdac_hda_hdmi_codec = {
 
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
index 37674ea452d6a..2f5a1db235351 100644
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

