Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672FB3EDE66;
	Tue,  9 Jun 2026 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994107; cv=none; b=uddLqQKJYX2WFdxjR6Da0NzuuhlpRwyuuRqj/JqwsXfxkfGC4JLNrpQ1IiZ+fIZ5b5MkpC5xE2Y2OtuUWOawp4DZLnG/+MchRLx9UL0ey4Jg7ddlo7628mSeBxc8MrrE10a+wXp2G/4nav6up2rO1e3RUZW5v/r6RiUPAsZ12hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994107; c=relaxed/simple;
	bh=pUtToWDvfOdwgV1A9IcxbMAryV6EiPvW3GE4CbtESgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz7A4IxwNue8SzDyKaMFDeAfO8XEtQW5gJ9LOUu+nxvXA3Fbby9zz01AbPuNPjBVuRtYA8sAnSJwfuMkHrEkrhpAyzRtaFKnOfMRf+lHrHTK2WNOkgxWpxkhEWz6stYxHSUdELgk+0HNsVfICBmvcMVGnyappMY7INTYS7FM/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEBdr4bV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEBdr4bV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780994106; x=1812530106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pUtToWDvfOdwgV1A9IcxbMAryV6EiPvW3GE4CbtESgM=;
  b=EEBdr4bVzjaxbQboyJJYbN7gNqAFWi04rXTjyIVIW+mhFuIhQacxA+b4
   cLsT4ejcyXbUqG1xCA6ioPlh26trO2Za+lFdpQlIaYNA0rJCbcfw0fD0h
   US+si2GRMbg946+0aaf7w40F26+X2XhbZc6rDhJiSf38krJ6PGQRVIpJK
   +CBBONd0nXVI0Sp/GUxN9GOIuWlJnwVbBhxTAUFiC+kyFoPT3F2ZwAJWs
   jLKE4SDY8+N98W3gxAEhPj1aPCIlk8YmEOXl4tMFFLpDOOFQfZUmzvSPT
   uRdpObWZYTru3ivMfUdhdz/bID7xwbIvw+sfzQa01al6N1bkRGQcWBlkJ
   Q==;
X-CSE-ConnectionGUID: y7fm/U6JQAyFMN++OQAZTA==
X-CSE-MsgGUID: dwyx0wLWT/m1zPnW50D3fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93235452"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="93235452"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:35:06 -0700
X-CSE-ConnectionGUID: NS3nTrGIQLa9bJUJfeU+Lw==
X-CSE-MsgGUID: nCpdyqDmRTaWkWF+QOMTsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245650182"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.253])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:35:03 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 5/6] ASoC: SOF: ipc3-control: Fix TOCTOU in bytes_put and bytes_get
Date: Tue,  9 Jun 2026 11:34:57 +0300
Message-ID: <20260609083458.31193-6-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609083458.31193-1-peter.ujfalusi@linux.intel.com>
References: <20260609083458.31193-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sof_ipc3_bytes_put(), the size used for the memcpy is derived from
the old data->size already in the buffer, not the incoming new data's
size field. If the new data has a different size, the copy length is
wrong: it may truncate valid data or copy stale bytes.

Similarly, sof_ipc3_bytes_get() checks data->size against max_size
without accounting for the sizeof(struct sof_ipc_ctrl_data) offset
of the flex array within the allocation.

Fix bytes_put to validate and use the incoming data's sof_abi_hdr.size
from ucontrol before copying. Fix bytes_get to subtract sizeof(*cdata)
from the bounds check to match the actual available space.

Fixes: 544ac8858f24 ("ASoC: SOF: Add bytes_get/put control IPC ops for IPC3")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/ipc3-control.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/ipc3-control.c b/sound/soc/sof/ipc3-control.c
index 4b907d8cf58a..1f5538bbc50f 100644
--- a/sound/soc/sof/ipc3-control.c
+++ b/sound/soc/sof/ipc3-control.c
@@ -315,10 +315,13 @@ static int sof_ipc3_bytes_get(struct snd_sof_control *scontrol,
 	}
 
 	/* be->max has been verified to be >= sizeof(struct sof_abi_hdr) */
-	if (data->size > scontrol->max_size - sizeof(*data)) {
+	if (data->size > scontrol->max_size - sizeof(*cdata) -
+				    sizeof(*data)) {
 		dev_err_ratelimited(scomp->dev,
 				    "%u bytes of control data is invalid, max is %zu\n",
-				    data->size, scontrol->max_size - sizeof(*data));
+				    data->size,
+				    scontrol->max_size - sizeof(*cdata) -
+				    sizeof(*data));
 		return -EINVAL;
 	}
 
@@ -336,6 +339,8 @@ static int sof_ipc3_bytes_put(struct snd_sof_control *scontrol,
 	struct sof_ipc_ctrl_data *cdata = scontrol->ipc_control_data;
 	struct snd_soc_component *scomp = scontrol->scomp;
 	struct sof_abi_hdr *data = cdata->data;
+	const struct sof_abi_hdr *new_hdr =
+		(const struct sof_abi_hdr *)ucontrol->value.bytes.data;
 	size_t size;
 
 	if (scontrol->max_size > sizeof(ucontrol->value.bytes.data)) {
@@ -344,14 +349,18 @@ static int sof_ipc3_bytes_put(struct snd_sof_control *scontrol,
 		return -EINVAL;
 	}
 
-	/* scontrol->max_size has been verified to be >= sizeof(struct sof_abi_hdr) */
-	if (data->size > scontrol->max_size - sizeof(*data)) {
-		dev_err_ratelimited(scomp->dev, "data size too big %u bytes max is %zu\n",
-				    data->size, scontrol->max_size - sizeof(*data));
+	/* Validate the new data's size, not the old one */
+	if (new_hdr->size > scontrol->max_size - sizeof(*cdata) -
+				    sizeof(*new_hdr)) {
+		dev_err_ratelimited(scomp->dev,
+				    "data size too big %u bytes max is %zu\n",
+				    new_hdr->size,
+				    scontrol->max_size - sizeof(*cdata) -
+				    sizeof(*new_hdr));
 		return -EINVAL;
 	}
 
-	size = data->size + sizeof(*data);
+	size = new_hdr->size + sizeof(*new_hdr);
 
 	/* copy from kcontrol */
 	memcpy(data, ucontrol->value.bytes.data, size);
-- 
2.54.0

