Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105661;
	b=SszCGhmaCq903pPseqn5ncBhwKJD/LwWFy+w0mJUh1cLlCoj3hlIXyhvJzcGe76FkYEl
	 KZ+4gnKMIUEbLy8oqzZEWOrn4BBoPjc2WvagW7xkQ0GfM3+i4zX/6u9F653YLz89MPWNe
	 8xXvL9munvhJ5llSg1nkkUr4Y1FPUP3jSqg1R0qVaLF9XbxZPP/varAhD/BTtkKNOfxGJ
	 8/A9aC9B1Vrz6HaaCTT2vL8Osm7NsE/UYMQA1PQMaWEhxqhODO0H6eOfgy9fVe2RA6uEF
	 ovB48b/pvaX9st/z013s0mJPGJ8FOV7KltgXzwauFmNr6vI4xt4wXcATTOulpgET6og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105661;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h0VKfLRevl/jC/izVmhP9oxgiD+shfSqIizdNJiu+lM=;
	b=dOR3BwkhcrO+h2QP9Y3xUFipEJvQigQvvX7Hr4nuqyG+p4oSa1H7EgRu0Xt3C8B+Nhps
	 e62uEZ/P3VsvKu2B0k6eUyfMNh982KjhAHPysRTzxkXxTqRuDgnTS7OYQnBZWaD0EIYa8
	 yPhofs/8dBtzxeeIUQ650AitM8PXwQBEHAd+nPpTCkDLQ5Fd6BEVfJyKaOq5jxs/YHeeK
	 fHwHELYdAIp4ZYWpKKdGA9nWcDeI8Ubmdj/o0xXX1mcY0CdAuDUeACMEUFDzyuH+/8xqR
	 0rZbMeTsyelV4QmMBaSsMpqxewXQ+JdzEQe+HaXhHkn9IcpU9hsQNZ8ygyrrzw2C1nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="gJtgfHi/";
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65E606A31B;
	Tue, 27 Oct 2026 12:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C65E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gJtgfHi/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793105661; x=1824641661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=isiVD2VUlFIC1aqZZvfbAbjSXwFOzEU4PqQ3SGcStp0=;
  b=gJtgfHi/AgRxPDb4F+/cbMFdqSbgYmxG8P5Zcem3/Kj8gRV7OCa3Tmkr
   4c59Es3DJPZOmyucFAJpnrYtG8A7lUUBX5+GFsuJVvFM1vdDPgWGaDYfJ
   QdjQSstcIQRmASEsCNNCgz8wDZzkDjkNy1IB3lRrL6T9zCNMWXBflw3LF
   5T6TdW9iz5bcbHBheUzy4Td7w5MMoSKfZl/r+SPsEDqZbHHnhHUm1v7PZ
   2bCf9vbbRHVrVgBt8DdmOYDpp112HUNZuGr6ADLFCBJBHsgBZeKC1CCsH
   dA9IjkhMUju5o96IYiaVrakzkPVaG4X34hdITy2G6DM3f4QCv/y2FnbWk
   Q==;
X-CSE-ConnectionGUID: D3JdUGkhSrmUvtsKjm2dRA==
X-CSE-MsgGUID: vJKIVwf7SXW02sHdh6GUfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1684671"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1684671"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:54:21 -0700
X-CSE-ConnectionGUID: 4rp9qI0dQaCB9CjzBsJMKw==
X-CSE-MsgGUID: aajRh4BIQO+nX5g2r0Nwhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6294864"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:54:19 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Subject: [PATCH v2 2/3] ASoC: hdac_hda: Restore the codec device type on unbind
Date: Tue, 27 Oct 2026 14:54:47 +0200
Message-ID: <20261027125448.11018-3-peter.ujfalusi@linux.intel.com>
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

