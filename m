Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105664;
	b=FP/STPu26ELr/Sk6sDagVGlNbPLIqMwA/frT0zwJ1PQBPmWa7tx4mGylmoHR/YWqCgIp
	 fdWBkDcanctBf/Eq46joMluCUSa4TLClM9AM3qCVy33QXiB+ESpNF4ySq/aMiOMKWKG3V
	 9dir7ToNTBo7exkFmyoJ0a+/Lrxy8dCU10gBFM7PzObOFfC8IxMQEYqgasdofPXKzVesg
	 4NsxbMYZ/id693sTbzLfaBUgnbuKAXfLHXJZOzx5BteZqRSWcj/CczeEb7dfTzb7laiut
	 u/LExtXJ769csxzGBaZX5i02Amep3jeX1H54EOD+UGg7pKbu1GT5gRPGwHYS082Sajg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105664;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jZTxu8qUT3nFZmTHkuhIQHPZ7BGHiDBpLhkFu0ULAqM=;
	b=iUMbk/sPK/LmQSk47yHtznKgso5IkhEik7ukXy3CUvwdNAb0rCaMIG1J89DcAwLeA1bl
	 3Igw5zn0kXbDl793yx6GWdOqSTrZANoShO0Fbz4eqa8wzvMvHWLT9kI2pjufLZzDR99qe
	 6ieWWelk6jBa5K1wNOGrPFj0XHPUE+f+MeqTbYcliRUGJZPamMqshGFlPxjfNWuHTfmbU
	 QgUzCZGrxPo9htc5Tw45GdATQTe62yQQFxMibo87yi9kDrDL2IHeQFyg4sx4ItsBfue1y
	 1prYw8dl1SIwTcU8NAItZdLwt0XlB0SWHfUodliQdZgtLF5CAc8PVtNHtx83ruzDXrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DeH+4ah3;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BDE606A31D;
	Tue, 27 Oct 2026 12:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51BDE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DeH+4ah3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793105663; x=1824641663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M0vW7tj6rTYhwP/CVcwl8dAaWP3LiMQ/AkJZpYCDUIk=;
  b=DeH+4ah3OfyVnczn8fG0Meb04khBhXuQX8XkRWist5jP2Tp6HlXZLJss
   7eORYWgo75G+bsliSyjjWGmn6gPH6EF+2yKtFUO0VzaymYWOB9FGLwL+B
   fs2ND4kZ/hwU3zbbf+T2ppq675UXFRJ21FVlNANQT3VG3nxUUiUZjlk0h
   P+GTN1sWVPMbmxX6iva2zfGsBrpsSViv71xF1+dL0q3L2S9geUjvg2pLE
   HLOj6jujw+PXber9RCO3wm+heIGmHGIXJpaChxMMoIy7xuToJdRIHC83H
   wUVCdOyPXotbXea8pQZHS53Ozbm5KFlAqaolLVsiSU55wZVIr4nECHQOI
   Q==;
X-CSE-ConnectionGUID: /GpXL5wBRb+UREsRnpKAzA==
X-CSE-MsgGUID: YdElB0WWTBmJvsfar5eN8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1684677"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1684677"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:54:23 -0700
X-CSE-ConnectionGUID: XTvx6Ps9TQOPeQjd1VFE4g==
X-CSE-MsgGUID: +bcdhmBwSL+XMBadGFOX3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6294872"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:54:22 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Subject: [PATCH v2 3/3] ASoC: hdac_hda: Fix codec runtime PM across remove and probe
Date: Tue, 27 Oct 2026 14:54:48 +0200
Message-ID: <20261027125448.11018-4-peter.ujfalusi@linux.intel.com>
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

hdac_hda_codec_remove() disables runtime PM of the codec device before
releasing the HDA link and calling the codec driver's remove callback,
so that no runtime resume can race with the teardown and access the
link or the already freed codec driver data.
snd_hda_codec_cleanup_for_unbind() then disables runtime PM again.

On the next probe snd_hda_codec_register() enables runtime PM only once,
leaving it disabled after the ASoC card or the codec driver has been
unbound and bound again: the codec stays powered and runtime_status
reads 'unsupported'.

Re-enable runtime PM at the end of hdac_hda_codec_remove() to balance
its own disable. The codec remains disabled until it is registered again.

With runtime PM enabled again the codec still does not suspend: the
runtime status is RPM_SUSPENDED after the remove, while
snd_hda_codec_device_new() powers the codec to D0 on probe. The
pm_runtime_put()/snd_hda_power_down() calls see an already suspended
device and the codec, its HDA link and the display power reference
stay powered, preventing the controller from runtime suspending.
Mark the device active after the codec has been powered up.

Fixes: c3ec8ac82105 ("ASoC: hdac_hda: fix memleak on module unload")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/hdac_hda.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index cae5711e979c..fe5796cad1ff 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -435,6 +435,13 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 		goto error_no_pm;
 	}
 
+	/* The codec is in D0, the status is RPM_SUSPENDED after a previous unbind */
+	ret = pm_runtime_set_active(&hdev->dev);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "%s: failed to set runtime PM active %d\n", __func__, ret);
+		goto error_no_pm;
+	}
+
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
 	if (loadable_patch[hda_pvt->dev_index] && *loadable_patch[hda_pvt->dev_index]) {
 		const struct firmware *fw __free(firmware) = NULL;
@@ -554,6 +561,7 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
 		return;
 	}
 
+	/* prevent runtime PM callbacks while the link and the codec are torn down */
 	pm_runtime_disable(&hdev->dev);
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
 
@@ -561,6 +569,9 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
 		driver->ops->remove(codec);
 
 	snd_hda_codec_cleanup_for_unbind(codec);
+
+	/* Balances the disable above, cleanup_for_unbind keeps runtime PM disabled */
+	pm_runtime_enable(&hdev->dev);
 }
 
 static const struct snd_soc_dapm_route hdac_hda_dapm_routes[] = {
-- 
2.56.0

