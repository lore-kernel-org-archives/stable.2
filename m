Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3C3D813C;
	Tue,  9 Jun 2026 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994104; cv=none; b=mdCf1Itl8LiE0Lk7hUgIbdxZCtShCJc06ylxhreyRCLcKOTMfQtWgJyKAPfd8m/z3HRI68Xl6V2QPCmbdZ8qjxI2xSooB1MzLV/F65CHC2M2x+oJMziTj2Ed4BCtEyHbYCpHZ/CjZuqX1Zk0geHYTHY4EE/e7hBF5VigCobeUX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994104; c=relaxed/simple;
	bh=syH3b0q8CEWrlZaM9ZSxSIJbEQiBcOO508S9HYoT5e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaHpIEL9WDcTd5Nvd6SoixoXm2MyHbq+/N4I08O9kuYwPL+63UCyaq7j38ZaBPMVTatRV3UR7HoQqKIcUnUu5wAJKyD+Nrk1EI8actZm004DvIqHoAe7szmqERJsU63o13lGU1SsxCqx5LnpLwCpmkJ7CbqmHgKVjs/pA+xv/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3JVR471; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3JVR471"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780994103; x=1812530103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=syH3b0q8CEWrlZaM9ZSxSIJbEQiBcOO508S9HYoT5e4=;
  b=S3JVR471TgyQCvuZOsJxEKfa2nzjKtC3nIq3EY7E9f/+0d4WRlvZrFEP
   9UTpVnfAdGAdbbFiHxOjbj0p0HWBfJaGxKa30qTzmbWPW7e+ojnwQCZDr
   pVPEI3eVGaQZ/NaYfnGaJ/kTJCFJDwh8g5n1+hJl9HhF5d8QLf7q9c7Rg
   nEIbaiMo60w5RyqK+KPjU1uuJlhO+m5Mbg5rCg7/wh2t/MppTwspokYEl
   hyorKMCeEAKZoApkvk6VVVKcJHRi8VlyDF7du7WV+T7fOcgzl8zNawOjQ
   le0tUDsoP7oBur06rGLcrFfHVCvMApxq9flI96+prHat057j6sa6BRJO9
   Q==;
X-CSE-ConnectionGUID: EXTR+THjTd+vt5dm+DJsog==
X-CSE-MsgGUID: y4XGF9I9Rxa6+nMMy+DZ8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93235446"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="93235446"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:35:02 -0700
X-CSE-ConnectionGUID: ZgN6mppFSn+dYU52cJQO2w==
X-CSE-MsgGUID: GNAEbmUZQIq/NnLLWoBSAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245650132"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.253])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:35:00 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 4/6] ASoC: SOF: ipc3-control: Validate size in snd_sof_update_control
Date: Tue,  9 Jun 2026 11:34:56 +0300
Message-ID: <20260609083458.31193-5-peter.ujfalusi@linux.intel.com>
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

In snd_sof_update_control(), firmware-provided cdata->num_elems is
checked against local_cdata->data->size but never against the actual
allocation size. If local_cdata->data->size was previously set to an
inconsistent value, the memcpy could write past the allocated buffer.

Add a bounds check to ensure num_elems fits within the available space
in the ipc_control_data allocation before copying.

Fixes: 10f461d79c2d ("ASoC: SOF: Add IPC3 topology control ops")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/ipc3-control.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/sof/ipc3-control.c b/sound/soc/sof/ipc3-control.c
index 23b0ae3ad414..4b907d8cf58a 100644
--- a/sound/soc/sof/ipc3-control.c
+++ b/sound/soc/sof/ipc3-control.c
@@ -535,6 +535,15 @@ static void snd_sof_update_control(struct snd_sof_control *scontrol,
 			return;
 		}
 
+		/* Verify the size fits within the allocation */
+		if (cdata->num_elems > scontrol->max_size - sizeof(*local_cdata) -
+					sizeof(*local_cdata->data)) {
+			dev_err(scomp->dev,
+				"cdata binary size %u exceeds buffer\n",
+				cdata->num_elems);
+			return;
+		}
+
 		/* copy the new binary data */
 		memcpy(local_cdata->data, cdata->data, cdata->num_elems);
 	} else if (cdata->num_elems != scontrol->num_channels) {
-- 
2.54.0

