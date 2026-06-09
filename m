Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D5282F1C;
	Tue,  9 Jun 2026 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994095; cv=none; b=TKJk/O+UyVLzwj/k8c6QEIIDi3K2c7To+d7Hnz3F8ZwqgCZNKCU69C9gOTM9bozmCufqekAB7yocVqC8591i/V8MWwr6jpu8Hm7oKtxAahvSx49VknVJvsKvbXOMlR3PxrHDttojLVPAssga2uXUMOjRU6d/sJR670BAtc5Ka58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994095; c=relaxed/simple;
	bh=MUuBZ6EdnzeH59BuAGvXEHAYBkKiY4JfsRIBHHWS79o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2KjSdiMuJAdD4TK0vwjPfJ9O5bFhlXuDUH1EySMJhHuzLkawNKwwAeZzyBU468US6y9RPQwwNwvt7/77cZbjHbllX5okbUc3+zfjS5REJjL9sSOBMXOOcPxPS4asK31J3pjjpR88sddlV9AjfVFoNbl08x9QchN44rMitpQYV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZroeuH1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZroeuH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780994094; x=1812530094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MUuBZ6EdnzeH59BuAGvXEHAYBkKiY4JfsRIBHHWS79o=;
  b=MZroeuH1bBIpBvaSHTJfWKz4Z4oeqDY5j7UFzM/j8fBzplrlPh9ogClU
   9F8zTqiOhmTF8NeGxnomc9uObRHkEeqpr4NasBRveymR9w3UIueRv9Imf
   z1NtFtbWFBrI3uBkDNkd4pGa2qwZU6D6kjVModP5xqER+n8W4VaXSaeOv
   uSoolb4PAtxJElPKJGJTrt4Qs/LoPJqm2uDNKCs9vT5COKWoqCtld5eox
   YCfMOq3HoyXlw32oZiGV8XkvinVDKlPErprtmCkULLrL5V1MzvLBtXYUH
   XhY/SOfcKAd5HbDDPdy3QNVjE/VCWJQPaPovwW5822v6WMosAS3pjSBWN
   Q==;
X-CSE-ConnectionGUID: N0ZOFUwxQOmMM3Z49lfoSg==
X-CSE-MsgGUID: P3VuYkDBSBqKW8On1ZmA/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93235419"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="93235419"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:34:53 -0700
X-CSE-ConnectionGUID: hZc1SlDSS8msSIaSg/7uJg==
X-CSE-MsgGUID: ljTsqvqvT6GoDtDXhu4akQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245650064"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.253])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:34:51 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 1/6] ASoC: SOF: ipc4-control: Fix TOCTOU in sof_ipc4_bytes_put
Date: Tue,  9 Jun 2026 11:34:53 +0300
Message-ID: <20260609083458.31193-2-peter.ujfalusi@linux.intel.com>
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

In sof_ipc4_bytes_put(), the copy size is derived from the old
data->size in the buffer rather than the incoming new data's size
field from ucontrol. If the new data has a different size, the copy
uses the wrong length: it may truncate valid data or copy stale bytes.

Fix by validating and using the incoming data's sof_abi_hdr.size from
ucontrol before copying.

Fixes: a062c8899fed ("ASoC: SOF: ipc4-control: Add support for bytes control get and put")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/ipc4-control.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index 4ce821f96a91..aa31eed05730 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -554,6 +554,8 @@ static int sof_ipc4_bytes_put(struct snd_sof_control *scontrol,
 	struct snd_soc_component *scomp = scontrol->scomp;
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
 	struct sof_abi_hdr *data = cdata->data;
+	const struct sof_abi_hdr *new_hdr =
+		(const struct sof_abi_hdr *)ucontrol->value.bytes.data;
 	size_t size;
 	int ret;
 
@@ -564,15 +566,16 @@ static int sof_ipc4_bytes_put(struct snd_sof_control *scontrol,
 		return -EINVAL;
 	}
 
-	/* scontrol->max_size has been verified to be >= sizeof(struct sof_abi_hdr) */
-	if (data->size > scontrol->max_size - sizeof(*data)) {
+	/* Validate the new data's size, not the old one */
+	if (new_hdr->size > scontrol->max_size - sizeof(*new_hdr)) {
 		dev_err_ratelimited(scomp->dev,
 				    "data size too big %u bytes max is %zu\n",
-				    data->size, scontrol->max_size - sizeof(*data));
+				    new_hdr->size,
+				    scontrol->max_size - sizeof(*new_hdr));
 		return -EINVAL;
 	}
 
-	size = data->size + sizeof(*data);
+	size = new_hdr->size + sizeof(*new_hdr);
 
 	/* copy from kcontrol */
 	memcpy(data, ucontrol->value.bytes.data, size);
-- 
2.54.0

