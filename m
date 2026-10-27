Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090295;
	b=Lf6fT/hyCYhsw0DTZGuPyk0Dtg8YRZ9bmZYlzmyGt1l+k6aV7GKXpqyNAZb1dfYYMueb
	 GzqLRoIwhiA3y9/MHAGMjyomdJ1U8JfnFPHYpEVPSNzPBhgjplkNo9Np+OBwm+5oYiIvh
	 7pYBdsTtJ/MzBiwV8BroCP/FNmBjuOA4FAwPJq/aziLmzqZZjVWqVlJIq9EGcv7/5iAZV
	 4RaVqRFVOCJbg4J3ONOo0xgRhwWpZ6PJklSh7wU+RP3WoPNaLOAs0+zbNh7imU1UFn3IS
	 SXtQmc8dboEcP+4wLTM2E16pJS/DiVsTgOSpViM3HTyoLH7ZIXAxIN4IyIsFCEgjKWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090295;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0jvUE7BAMfXfeQ7E5zBu/mVl8NbznBTqo/0Pqg6+g9Y=;
	b=KIHgivgbuF3o2EUdB3VKb/1EKJCwWRkiisPcORLtV7uowGaLq5u1HpZRZ7qs55ffbcEy
	 BuLgpF9+NAhoe+l0c97L/YxGkcKsKZlaeezj9cpCdX4W9q9EkyGvUoPoYJ99xoYNckWj/
	 kN1pSbJOt/qWUYlas5kDVP0DXeQjXFNq+VIqbyBxCJnQmCth537atc+ZGBhvNHiCrSIoH
	 vvMm+6lYiaQarHrl68fMjOkCTVQDG7zLQNA7HFGvlNI4K98ILWKo/f8l6UoorfBYpgPwD
	 Ao8lij7mFKHSK+zDpN3sre2x9XqVm/EpBcX/qW3GdaHzPQZyz1nrt5af81N0Ko1OyPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gZS4+wDS;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3076B606A31A;
	Tue, 27 Oct 2026 08:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3076B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gZS4+wDS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793090295; x=1824626295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QF9WraV6r1mF6ekngCDfbiFVTkXFMr/IAGfvAPiXb8o=;
  b=gZS4+wDS16qSARpEBUTeh0esgbrNEH2BWVegwgJzoiQChHB8FmBoiDqy
   ppdQMARsp0cq9yd2v+ZvfCT+tZO/pWfVfpzguTmOhuVP1OEzZRdjCKcc0
   uxnXW00nxRbtU9EMLbkN2XuPdiD+7RmlogZZzExqCl+XZZ2dFyfKHCe+T
   nou7P17a43DSwpE0gAotcQGfrMbKlt37umV/rZ109xYQaqd2ZJdimq7B3
   tmZw1ZA9f5BU6ffe0CE7fMrzyIrVZybB1vHnyjY/PQ9JNzHFEInNcEV25
   Y67yq7sOmJlZgfTqE51rxPSjI1TdDBqgtaScoqBGJ1HM7YSYhn2Rai6yo
   g==;
X-CSE-ConnectionGUID: Jn9nCk3pQcGQTY95ppoiXw==
X-CSE-MsgGUID: vLc0VgqJSkqKn/Y+Uo9D1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1672403"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1672403"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:38:15 -0700
X-CSE-ConnectionGUID: 2SDZ2rOAQJG1M/VwS53ajg==
X-CSE-MsgGUID: KgFkfEJbRCmqPB2wjLQ6uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4570816"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:38:13 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Subject: [PATCH 3/3] ASoC: hdac_hda: Balance the runtime PM disable in codec remove
Date: Tue, 27 Oct 2026 10:38:40 +0200
Message-ID: <20261027083840.28813-4-peter.ujfalusi@linux.intel.com>
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

Fixes: c3ec8ac82105 ("ASoC: hdac_hda: fix memleak on module unload")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/hdac_hda.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index cae5711e979c..bd4b113401a8 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -554,6 +554,7 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
 		return;
 	}
 
+	/* prevent runtime PM callbacks while the link and the codec are torn down */
 	pm_runtime_disable(&hdev->dev);
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
 
@@ -561,6 +562,9 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
 		driver->ops->remove(codec);
 
 	snd_hda_codec_cleanup_for_unbind(codec);
+
+	/* Balances the disable above, cleanup_for_unbind keeps runtime PM disabled */
+	pm_runtime_enable(&hdev->dev);
 }
 
 static const struct snd_soc_dapm_route hdac_hda_dapm_routes[] = {
-- 
2.56.0

