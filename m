Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282A2D0C7E;
	Tue,  9 Jun 2026 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994101; cv=none; b=c5t3YHLTJtJXxWiCVVborCSmZV1ALh0+RA380CsEB7fKI/Xsm+6jiC8rNA6ouN8V+VYuOzZkAY34skEBPcFTtG0NruW+GLeM5H2fiFLFX4VvJrYAHVnFLod/yj1+lgK7C+VC/Rp5VwPrqU7uu3wlbbuFR83M3G+kXpLODW2pOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994101; c=relaxed/simple;
	bh=oHh6/Se/PM14+NAThoDFWYq3ezQPcsi2g8XJXYKXzkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MynfglK7Wmzyu0bY1wGWWaJFFnNKKganBuAgWGjftWNGVCioFmi+71LDgpzeDFZqKmjClctMWHA+bLYBq4BMNsKJiiqDrhcIibwelXwzcfLa8dbQJ3sO2tuRhs9m9Fp2CSyI6oujzuBnkbo0+QfS7V8L6V2LS9gBqTXXIj40/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RL8OoaMZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RL8OoaMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780994100; x=1812530100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oHh6/Se/PM14+NAThoDFWYq3ezQPcsi2g8XJXYKXzkA=;
  b=RL8OoaMZLs70gar2SFciDkO0lr9rLG6eFlKat6XI/splHifaTfo/H77T
   vVWtb7jk6xchijn5IcnyEb4+mdyIHhfm1Lxpq+4EYXaLYDSbG3xfyNj5c
   WgUXykUR0DuYapU25iiF7BlV6tqCaVjxOai+c7y/NsWQnV4aH2ObyMLQ3
   rcGSyFAM1sE2OpMA0aHa+Vk5zShaKG5a5dJEPnNSoUrQHM3Aoh3QlxDxs
   PCHYTC+qaO0Is3ccVjw/kFwVj3zq1UabVlKlpF6AWYizZkn7XdL48521C
   FAmH7uGE1IOVEIelaOFDsrlMC3+V556SYZANMKELK7EUak1amMKbbsB/p
   w==;
X-CSE-ConnectionGUID: TynAjBWETN6ynoArzLUi1g==
X-CSE-MsgGUID: Pf7dkPDbStOP5uMJYIcAwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93235440"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="93235440"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:34:59 -0700
X-CSE-ConnectionGUID: OLqehf8hRTaZKQEyFDLVkA==
X-CSE-MsgGUID: Mb+xqn9VQGeBBPIKaIWazA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245650096"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.253])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:34:57 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 3/6] ASoC: SOF: ipc3-control: Use overflow checks in control_update size calc
Date: Tue,  9 Jun 2026 11:34:55 +0300
Message-ID: <20260609083458.31193-4-peter.ujfalusi@linux.intel.com>
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

In sof_ipc3_control_update(), the expected_size calculation uses
firmware-provided cdata->num_elems in arithmetic that could overflow
on 32-bit platforms, wrapping to a small value. This would allow the
cdata->rhdr.hdr.size comparison to pass with mismatched sizes,
potentially leading to out-of-bounds access in snd_sof_update_control.

Use check_mul_overflow() and check_add_overflow() to detect and reject
overflowed size calculations.

Fixes: 10f461d79c2d ("ASoC: SOF: Add IPC3 topology control ops")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/ipc3-control.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/ipc3-control.c b/sound/soc/sof/ipc3-control.c
index 2b1befad6d5c..23b0ae3ad414 100644
--- a/sound/soc/sof/ipc3-control.c
+++ b/sound/soc/sof/ipc3-control.c
@@ -626,16 +626,28 @@ static void sof_ipc3_control_update(struct snd_sof_dev *sdev, void *ipc_control_
 		return;
 	}
 
-	expected_size = sizeof(struct sof_ipc_ctrl_data);
 	switch (cdata->type) {
 	case SOF_CTRL_TYPE_VALUE_CHAN_GET:
 	case SOF_CTRL_TYPE_VALUE_CHAN_SET:
-		expected_size += cdata->num_elems *
-				 sizeof(struct sof_ipc_ctrl_value_chan);
+		if (check_mul_overflow((size_t)cdata->num_elems,
+				       sizeof(struct sof_ipc_ctrl_value_chan),
+				       &expected_size))
+			return;
+		if (check_add_overflow(expected_size,
+				       sizeof(struct sof_ipc_ctrl_data),
+				       &expected_size))
+			return;
 		break;
 	case SOF_CTRL_TYPE_DATA_GET:
 	case SOF_CTRL_TYPE_DATA_SET:
-		expected_size += cdata->num_elems + sizeof(struct sof_abi_hdr);
+		if (check_add_overflow((size_t)cdata->num_elems,
+				       sizeof(struct sof_abi_hdr),
+				       &expected_size))
+			return;
+		if (check_add_overflow(expected_size,
+				       sizeof(struct sof_ipc_ctrl_data),
+				       &expected_size))
+			return;
 		break;
 	default:
 		return;
-- 
2.54.0

