Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105659;
	b=CY7AEi0rm862QTGQViV5xi948Tm53l2GKhJn38cKNfGKjgC9jwvqgausK++QLiW04ABz
	 w3Y4/skwixpdbtgWYpf+GOkKyOvvxOBP8CXsiq0B085DB5c9A7sZSLRQ0awsyzXWbTsVw
	 KZXHuQLgdOEBLTiijhLC13BraBKD4IH5Tg1EOd9qpzXr5ad/zOnSXmEKV2hi3uErZ9jKh
	 LIyB9SmCOUfhbpohf3jkvVXY6BOV3Xpm9XTqYCl+fLTSwKv4ZKcq0qhSNtuiDHMn5oh3X
	 MF0SyRDs/Lq7B/4/GZ/ECSpLdOSCTFfGQUOkStDt5dYeROjNW+V78Aic9XTpcVsVrBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105659;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SQQm3WtRkyJr046QrssLNcdll1ov6N3Vsz6lOv7a/Wk=;
	b=ZO8TaZe4IZ6K/U0cKKW8UbQz69xI9KmsI/Ery6Q0kuSsUTk+fFN7fMESokMyoMMzM9nL
	 h+PP4hG03qexVIEDfg1awVhsqjUYX72CmTB9ufX6wGjJXHvWFXtb8i+JjZEgVbbAM63b4
	 SyOkb7h9nq49W2weCLJsXMOakd53+ZhrMs/bcjW1h+oELYqPUn5KKf2/A9ImXNHQK9xlR
	 UeOc+dg9xdwOHzWuwORema8718osCiH9UlHQMbuZwCQT+sxMsefJPW3NP6RityXKcoMNs
	 PMKT8EbvR/2jlX46ATwiuMfIxwS9vhKGBwcX32toYq3ct3WERrf0Qx/NBu3g3ludkqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yxi+d2mg;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C33606A322;
	Tue, 27 Oct 2026 12:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C33606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yxi+d2mg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793105659; x=1824641659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8iLj4Blu5XtuBJf4301/oZB1RzZHmVWvOGI4Spmmxek=;
  b=Yxi+d2mgvAgsc7JrrC10pZKVIumC9WR71vpHQRQ2Dg4VfEKr3ENRp+Kw
   ZC/3gUawa/BHonDPP7ytvSjHrMc5wKjGmHoJlBg2110vEKO8Docw4YnUz
   ji7BHK5/dGN7J5zDUAFQX0nJg8cCIzuI92OP5HxEYwr01NGllXSFOfe4d
   EY4PjKBngtDZctfvx+nFbIpCYWFyzotFdg6Z8Qux3hZIOjpXROhcw1wKg
   AzoaTUyqecKddrjI19Kt1k/qCfatXJrJU+mVgFPmLCaKo7qYG0B6aLcva
   qleacFmsRsQAQgEoLhvTecze6PF2M8PNbLUKbhtquD+o994YZ+ULCNq7b
   Q==;
X-CSE-ConnectionGUID: vxDpHu2vQCi9O0NaKTSg8w==
X-CSE-MsgGUID: p0MgB2ovQR6uzvYG818Ugg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1684663"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1684663"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:54:18 -0700
X-CSE-ConnectionGUID: OwsyYy2+QTi25cf9CJRTcA==
X-CSE-MsgGUID: nCvqpfhXQQ2u3ku/AG3G/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6294858"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:54:17 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Subject: [PATCH v2 1/3] ASoC: hdac_hda: Allocate the private data at codec driver bind
Date: Tue, 27 Oct 2026 14:54:46 +0200
Message-ID: <20261027125448.11018-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027125448.11018-1-peter.ujfalusi@linux.intel.com>
References: <20261027125448.11018-1-peter.ujfalusi@linux.intel.com>
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
---
 sound/soc/codecs/hdac_hda.c     | 13 ++++++++++++-
 sound/soc/sof/intel/hda-codec.c | 23 ++++-------------------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 7414be08d3d5..46617fc88277 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -619,10 +619,21 @@ static const struct snd_soc_component_driver hdac_hda_hdmi_codec = {
 
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
index 91f7ca22a4a7..a2b2ecf1e7e6 100644
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
2.56.0

