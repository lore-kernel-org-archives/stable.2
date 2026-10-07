Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425A349E13F;
	Wed,  7 Oct 2026 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379514; cv=none; b=O3PDvhQD8U0uEaQPYYV/IhqHYGBtKb/JkBKwTCDIonaUdo1hzr8atqjqjD2bWv2p+wsmmfsb2BFiOTWuw0H6ZbyRDclrFhPk0LceAiEhImpfE6ZWBERLZoSi9bxN2F1nN2odkHMPy8E3Mh5/Z4+/A8PmjplPaPPAmCa5ek/s9MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379514; c=relaxed/simple;
	bh=jXd+IEAvGCU9SMSGy7tA538pFHRZoiWT3vrex8H5hgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkVwkUlPbC2RPqQU6SFgCCq6122BKM1+n+h9pwT4jZ2w9EM4ZdEgOQCYwVC5HAbbu66qRqbVkXdRqqeo3pSy7qZhUvFu2fVoF90PHBpnKS3eCX0WXcXYamN4SziDSMFIuIRYvHnl/d6d6EiHJZjKzOuhbfqn6bZZHpFXqqQnITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJg7YIqn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJg7YIqn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791379493; x=1822915493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXd+IEAvGCU9SMSGy7tA538pFHRZoiWT3vrex8H5hgY=;
  b=bJg7YIqnwRwBNQ9fc40SDpWwxJfpFhqOiBDVHFdI0VEJlOvtLhmsxllz
   7gZEmiFMMtnaXt/FDsQieaZKPtmQgoXYOHEZhLbXllfVjo/b8/JGo2ZcL
   LtVXnemQB7zYwlOy1MX+JB8SX6CsjMQizUN4yC6RtwD6NPa/+esYlHzAh
   djFiFU4fY4dykDzZp0VoroPFo/LpG7OJbULw/JIKlJcVCVD7kdAjKDhdy
   MdNYyF4X0myhsK6J4QmA4oWMiLlSFcm36UyPgh2YX7dW3mmYOGnoGDGVs
   DbuiEA813n+IoDAcwQ4xUWIE6Jh/xnFHlzmmWt8O9TffGHWxUv0F5366K
   A==;
X-CSE-ConnectionGUID: rNE4gTTkTTC0l5C+nfBYkA==
X-CSE-MsgGUID: mjK7DqukRDeaK7zFHxXxEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="39761"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="39761"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 06:24:52 -0700
X-CSE-ConnectionGUID: X2fm5dRyRBu1KTkI9fgnIQ==
X-CSE-MsgGUID: ENocGjFqS66eKd2VyPue5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="305434448"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 06:24:51 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/4] ALSA: compress: fix buffer leak on repeated SET_PARAMS
Date: Wed,  7 Oct 2026 16:25:06 +0300
Message-ID: <20261007132509.18237-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_compr_allocate_buffer() unconditionally overwrites
stream->runtime->buffer with a freshly kmalloc'd buffer whenever the
driver has no ops->copy and no preallocated dma_buffer_p. SET_PARAMS
is permitted repeatedly while the stream is in the OPEN state, so a
local process can loop SNDRV_COMPRESS_SET_PARAMS and leak the
previous buffer on every call, exhausting kernel memory.

Free any framework-owned buffer before replacing it, mirroring the
ownership check already used in snd_compr_free().

Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/core/compress_offload.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 7c397b1c9231..c0ed76e1c844 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -613,6 +613,10 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
 			return -ENOMEM;
 	}
 
+	/* a prior SET_PARAMS may have left a framework-owned buffer behind */
+	if (!stream->runtime->dma_buffer_p)
+		kfree(stream->runtime->buffer);
+
 	stream->runtime->buffer = buffer;
 	stream->runtime->buffer_size = buffer_size;
 params:
-- 
2.56.0

