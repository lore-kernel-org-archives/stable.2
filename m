Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090293;
	b=cXaJL96o54DONchpRwwqciWHaYbFIG2ofD04tUBH3k2QwSx8fgxaCWohaTMpt04i8juk
	 22yxSXdoN4BfkoC2ThQdxbsS2yRyV/28bsqQHjQJpAFjuV5pmOyblmLIxJkCWVWfp7X3T
	 ZsnJRVL9/RX5Z17i1OqFS64KeZGfRzSfYaTnTTVYgGvW1ROc3kHNKnHDYS2aNVoTMzsLY
	 LILpMZMTbyAiCPv12RwkQFghA2RLSpLL4aJoBJU/zplrPAIoQ7y3Bwldncf/Szo2sdDJA
	 V1h2hExuiyFeco4Lff7hCHaU2nwlyGi9wtOHG27Zf33H4zg03hmW6U9s8/5U3Wp13VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090293;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h0VKfLRevl/jC/izVmhP9oxgiD+shfSqIizdNJiu+lM=;
	b=DUMOVTHPxB6Y4c+gL9JneAvVPVEP7XFR7ywyHjdOFooO6YuDrBvO8bRbiD8IGBlpRhPQ
	 rLTcIyDMzpcDipeaCHodZB69Pbo6HvKyvxI3wn2pHJDb4xvFEmpjbqApO3U02E7YvDvLa
	 eyCIlKNDtdg1AAmvxEHDFt/ZhGTZKrC5PzeRTy9SD3z3e81s8MGA0hy9ZktF1MtnoCrc+
	 WXXCkVPEuHdqXBrEzBcZZC7uKapt/6ye7TIG6W4aX0Tjoe8g890zcxV4rW0H0ET997VuZ
	 CmOQpvGe2AVcyiap8hLN+ge1DJ0aHcIVWrNT1vVZGUbo/yx9/K7GIesVo92CgzDB3Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fNoq+L1L;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAA8606A321;
	Tue, 27 Oct 2026 08:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFAA8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fNoq+L1L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793090293; x=1824626293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=isiVD2VUlFIC1aqZZvfbAbjSXwFOzEU4PqQ3SGcStp0=;
  b=fNoq+L1Lyalsqy+DRFxDrHmmht2Pum2y2PKTzjVwoK+BVzTdaYNe0DuZ
   mI/3HlrP5cCVUA5F0xv4rZpgRzW8nk/uY0afRnyJo8crYzyaIKeu3krqL
   CkVAoAI2v8i8Q8SWA54BW6jUUTK4tqReTmZFNypAL0AK4Df/IWAp2iyY1
   0R6Dshpl99JsAXwKo4o9Hd5B1cYmJIwGDWET9mUQkLK9i8s1NRAzsoXJ0
   nhr/c5CyJJrXPZ6y2A4GD51+rtqk9B67VquRmu912xnDITBgly+2VyXxm
   BLw5XT/vdEyrLABvkreCrBiByIK8PIi800LO3GFi1blLkPOtTe04hdIQ/
   A==;
X-CSE-ConnectionGUID: CdW04U53Qgi4pTbNPqSdVg==
X-CSE-MsgGUID: fkTmuvF6RXqOeAsaM21qxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1672397"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1672397"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:38:12 -0700
X-CSE-ConnectionGUID: UZRaEUFkTxW1rT3dml+q6g==
X-CSE-MsgGUID: W+xOPv6xSm6+0INgnoEaCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4570815"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:38:11 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Subject: [PATCH 2/3] ASoC: hdac_hda: Restore the codec device type on unbind
Date: Tue, 27 Oct 2026 10:38:39 +0200
Message-ID: <20261027083840.28813-3-peter.ujfalusi@linux.intel.com>
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

hdac_hda_codec_probe() changes the type of the codec device to
HDA_DEV_ASOC to prevent snd_hda_codec_unregister() from unregistering
the device when the card is freed.

The type is never restored, and hda_bus_match() requires the device and
driver types to be equal. After unbinding the codec driver via sysfs the
HDA_DEV_LEGACY codec drivers no longer match the device and bind fails
with -ENODEV.

Restore HDA_DEV_LEGACY with a device managed action registered before
the component, so it runs after the component and the card are gone.

Fixes: b60ee2e281b6 ("ASoC: hdac_hda: overwrite hdev type to HDA_DEV_ASOC")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/hdac_hda.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 46617fc88277..cae5711e979c 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -617,6 +617,13 @@ static const struct snd_soc_component_driver hdac_hda_hdmi_codec = {
 	.endianness		= 1,
 };
 
+static void hdac_hda_restore_dev_type(void *data)
+{
+	struct hdac_device *hdev = data;
+
+	hdev->type = HDA_DEV_LEGACY;
+}
+
 static int hdac_hda_dev_probe(struct hdac_device *hdev)
 {
 	struct hdac_hda_priv *hda_pvt;
@@ -634,6 +641,11 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 		hda_pvt->need_display_power = true;
 	dev_set_drvdata(&hdev->dev, hda_pvt);
 
+	/* Allow the legacy codec driver to match again after unbind */
+	ret = devm_add_action(&hdev->dev, hdac_hda_restore_dev_type, hdev);
+	if (ret)
+		return ret;
+
 	/* hold the ref while we probe */
 	hlink = snd_hdac_ext_bus_get_hlink_by_name(hdev->bus, dev_name(&hdev->dev));
 	if (!hlink) {
-- 
2.56.0

