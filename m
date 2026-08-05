Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D6C3BCD0B;
	Wed,  5 Aug 2026 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929917; cv=none; b=cJsb9yfOeaKV70LdnFuiPlkcwRnJXdAdMKvACfbB3ZigJlY5he6GjbsHhai6MpjaI/od1o6YYMalU5f1ysWmGiU6WGSWrgAXU6LdOrGupaUEEgv022qzi/fPBdr3ps9gy15Z2/zvhgKpGlCcJbssxqgaI+JcZ2WHCf+dMBjej5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929917; c=relaxed/simple;
	bh=AgEDqx12GAMcoVD6bXxpqJVbra6G7B1k02pwzwn1XCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4Tan9cTWqlkOhOgKEFsISPFp+mKbfQi2mnRfErY8UGHXNEGaZ71iK1kFU/xSdfgsImkSSVKDWnvu9crdfx3sCM5pmZbIhIdBihwuK04oP4MbCZbNhEQUeTRedGp4y0FJ2oIEubDdR1BZ+00Y+vtr7H16BXp2GGTGbgCi9S9Nlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKG/EkOD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKG/EkOD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785929916; x=1817465916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AgEDqx12GAMcoVD6bXxpqJVbra6G7B1k02pwzwn1XCM=;
  b=DKG/EkODrVXSP5FmpbInTfB2S5XR0o2PXly7Yn33aEwKdETUh1eKaotZ
   oulyT3E8XKQXe6udRPr7d1bembDm/AERRNctO/PjWh/s9P1tETPxZ7Rxx
   TcA01MwnAz4SB6j/TKBxIn3bNk2litkrARr16F+A1U01fRh+00gzCiRJE
   0gi8D9u6kpmhaGUZtz1+CfTmqVLjTDYd5P9eC00uoLcqAvXUfzFhfSnU/
   2UjBzeY/v2wLzSNGTNBI25DPPTURQYF7Jj2AVcNosShvmtGdZ6ZtCkMwW
   2B2z6Y7Vk7RgKQOl4xRQlxS5k8kkDKNqHBeV6fdfiaDhzs53wfgi2h57w
   w==;
X-CSE-ConnectionGUID: /j/FEoH1SdKbtE8WTH7p+g==
X-CSE-MsgGUID: pcfuh6z5QDyk+nV1znliBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85625859"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="85625859"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 04:38:35 -0700
X-CSE-ConnectionGUID: n84CBrf1Qz+ZDzkAreoz5Q==
X-CSE-MsgGUID: oQM+yIOzQPufSXr1U8EPeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="285157094"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 04:38:33 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: pm4125-sdw: sort the register default table
Date: Wed,  5 Aug 2026 14:39:11 +0300
Message-ID: <20260805113911.21723-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reg_defaults must be sorted by ascending register address, as
regcache_lookup_reg() locates entries in it with bsearch().  See commit
fd80df352ba1 ("regcache: Add support for sorting defaults arrays").

PM4125_SWR_HPHPA_HD2 (0x3090) is listed before
PM4125_ANA_HPHPA_SPARE_CTL (0x308e), which makes the latter unreachable.
regcache_reg_needs_sync() then cannot compare it against its default and
reports that a sync is needed, so it is written to the device on every
regcache_sync() even when it was never touched.

Sort the table by register address.

Fixes: 8ad529484937 ("ASoC: codecs: add new pm4125 audio codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/pm4125-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pm4125-sdw.c b/sound/soc/codecs/pm4125-sdw.c
index 1c612ae4a4b2..ee4cde4d8686 100644
--- a/sound/soc/codecs/pm4125-sdw.c
+++ b/sound/soc/codecs/pm4125-sdw.c
@@ -126,8 +126,8 @@ static const struct reg_default pm4125_defaults[] = {
 	{ PM4125_ANA_HPHPA_FSM_CLK,              0x12 },
 	{ PM4125_ANA_HPHPA_L_GAIN,               0x00 },
 	{ PM4125_ANA_HPHPA_R_GAIN,               0x00 },
-	{ PM4125_SWR_HPHPA_HD2,                  0x1B },
 	{ PM4125_ANA_HPHPA_SPARE_CTL,            0x02 },
+	{ PM4125_SWR_HPHPA_HD2,                  0x1B },
 	{ PM4125_ANA_SURGE_EN,                   0x38 },
 	{ PM4125_ANA_COMBOPA_CTL,                0x35 },
 	{ PM4125_ANA_COMBOPA_CTL_4,              0x84 },
-- 
2.55.0

