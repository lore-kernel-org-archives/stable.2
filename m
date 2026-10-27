Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090291;
	b=35Oo+fD1v+NEukIQeyr9dizWQga1sw8SJqviyFTrgolSCzC8HDJgrQhwWc5AFErG8ZF6
	 igbK+mOhMXfgol8HZ5EzRTE8NVZA5d29u+ytxQxJ0Fb71qdIJ5H0uzv5ryFSnhQN5KoZZ
	 RlI6F3fuZ7XFqUUeq8eVT/bBXEY+eoNGUUM+0j4HksZs9NlOEV1jqcU9GLY31n2XNjIfJ
	 ff/hGxQXutFRRGQIeJ15akKr+BvR7woGreRJILyMe5g0HV07rvyrCUCMLl+TAL7zKlu6p
	 Og624LRXpQKODKII+E5CS2uBMRGD3EhT77P9tK/d+9hddo7Nb5FvDThdyQO/Cam/bsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090291;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SQQm3WtRkyJr046QrssLNcdll1ov6N3Vsz6lOv7a/Wk=;
	b=xieABLQ4X8lyjH9m9POblOh3JBnuKtoGX7dcvYJSZByngaUF982bYXWq3t8EVnf7bgdl
	 vE67UlOzwlab3EbP5xZvxt8qPek3Hgxd2ygyuGrFsL+H4BQMffZoFXf3LPt0TMian3DKc
	 y+LE9CH+VM0pgO3rVeWk8vbtN6FafFoa8IXNV+Rc/tVNkAivtOu1ueIbhm3R8DBjOAMVw
	 7uLSXNAhuB128xu8k8yzknRex9RWHOTQkH/Un9mB3rwjLB2AysQflnnhNXsx+Z+NetRYb
	 A/sVFEINQ85Vi0kr4nIvMsuvzCT6LmAmC0JFEUx0j+3ak+9TWJG7/Go9veSQ7HJZlpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Evply8ZT;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB1606A333;
	Tue, 27 Oct 2026 08:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BDB1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Evply8ZT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793090290; x=1824626290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8iLj4Blu5XtuBJf4301/oZB1RzZHmVWvOGI4Spmmxek=;
  b=Evply8ZT1GofLsP93yqUoclIOo7VrfSirawAEFU5vamgt2PonCzAqZIS
   RoKAFcInzGBQRsUENw+7wuPkWfjMnFl8uOO4T6R4aeIlEIm0VRhWKfPPJ
   8Rr8hApPizQiW0+lJ02ufD3hNRrRHGXuCITGlM1KqAV0icRfdsjH//NEB
   lfNpIcs5hWE9lh8GKVM4QFbiXomKGscgMf/E2j2XdWYubpZzgxjNbpXAl
   /G2WHTqmtS3jn5qWjtpZRxE1WlIZ9vKTuYfdxs3GhzSsaa3+AP1Omnlnf
   AX+y8anxEqO61ggp4ztImJRRMrNOor4QaINwk1LfYXDsdIWGwTk6l5Bcr
   w==;
X-CSE-ConnectionGUID: lMiCqwtrT3uAgfItl2pI5g==
X-CSE-MsgGUID: g0yk5mkMQoG22uSoYE4h0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1672391"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1672391"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:38:10 -0700
X-CSE-ConnectionGUID: mQ5/7eyOTYeHjWx2MkUnVQ==
X-CSE-MsgGUID: R5VblLImQdq5Z4GeqsQ56A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4570792"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:38:08 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Subject: [PATCH 1/3] ASoC: hdac_hda: Allocate the private data at codec driver bind
Date: Tue, 27 Oct 2026 10:38:38 +0200
Message-ID: <20261027083840.28813-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027083840.28813-1-peter.ujfalusi@linux.intel.com>
References: <20261027083840.28813-1-peter.ujfalusi@linux.intel.com>
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

