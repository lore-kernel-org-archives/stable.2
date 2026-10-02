Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7147DD6E
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936620; cv=none; b=of8AtSd9tCOtQ4RfUThTOBhMmIwTMVBU83pcUOhxXnhpkp5uZnqxfMedH5pN1n4Ky4se3L5+uI8nvE6GdyE1GaQKOeNjOXIX37Gr+Qym76pZubbjhF7a+jWTH85jjwaqnaUfuzgdrYboeus2yyb3Y8aRjeQNJSYtWDqefLHBVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936620; c=relaxed/simple;
	bh=rV3lJLtiRV9ld2FxkquPn7vZAA4/F744Ka5X3H89nwU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5hCS7tqUNAnf4ZAiab9WKUUcQGhPhRPaBT0RqbEs+UcsYU5weQE0ClJUenf+R2h9CbCvtkynzCWTvQ3DfcJliNPmaYahj6ZmJXMLs7sMyjcPAN9bqXRx8JGZjMfKLI85OxL4tw8OOhvFJCKR5/x5Zz0zH2gXWPWiQI8oyKox8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjX3T1pT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjX3T1pT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790936619; x=1822472619;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=rV3lJLtiRV9ld2FxkquPn7vZAA4/F744Ka5X3H89nwU=;
  b=bjX3T1pTSKmxd+Gl/IX3+hja9YIsERVJWRaGQi3Ym0mWutsL9gU3OaLg
   3+FBMXuy/D91cqeIawOBBK2J7FvranbZJdn1faMsVbWKXEPSPKCYRq6EU
   E7MNGAuXBN9x3U32IZg+1HFZUayoVjGg2zcY21nCBXrOzgMe8FcTP72s4
   MT5EV8RX3WDzm/FwSty3hFNv1BiIsMFGhJZZlbOCAVfXTyRSy+CzgOBZl
   cswLOevnUB+KiCYFllFeZ1jPy/n8XKckynBWVRZNHd5U49YzkabPLyR8h
   bRRWbBi6wiapnqe7CQFP97mLq0peBIj8sqdiUeYcyKm59mHsYXxH/aGdo
   g==;
X-CSE-ConnectionGUID: FFjv8uNETWG8wOhANF8Tjw==
X-CSE-MsgGUID: EZnVkBHyTLWtdyi0eB1wQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="101864387"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="101864387"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:23:38 -0700
X-CSE-ConnectionGUID: xPnoGB7dSTSwN4FYKTmxtA==
X-CSE-MsgGUID: BS6pf3j7Tly4kp3mT5dOQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="302475337"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.171])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:23:36 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: stable@vger.kernel.org
Subject: [PATCH stable v6.12 backport 1/2] ASoC: SOF: ipc4-priv: Add kernel doc for fw_context_save of sof_ipc4_fw_data
Date: Fri,  2 Oct 2026 13:23:52 +0300
Message-ID: <20261002102353.26919-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002102353.26919-1-peter.ujfalusi@linux.intel.com>
References: <20261002102353.26919-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel documentation is missing entry for the fw_context_save.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://patch.msgid.link/20250619105623.4546-2-peter.ujfalusi@linux.intel.com
Link: https://github.com/thesofproject/sof/issues/11229
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit cec49fa47bccadb288fd984ef2a5c45e8a2e2099)
Cc: stable@vger.kernel.org # v6.12
---
 sound/soc/sof/ipc4-priv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/ipc4-priv.h b/sound/soc/sof/ipc4-priv.h
index ea3323b90343..0889de04b017 100644
--- a/sound/soc/sof/ipc4-priv.h
+++ b/sound/soc/sof/ipc4-priv.h
@@ -71,6 +71,7 @@ struct sof_ipc4_fw_library {
  * @max_num_pipelines: max number of pipelines
  * @max_libs_count: Maximum number of libraries support by the FW including the
  *		    base firmware
+ * @fw_context_save: Firmware supports full context save and restore
  *
  * @load_library: Callback function for platform dependent library loading
  * @pipeline_state_mutex: Mutex to protect pipeline triggers, ref counts, states and deletion
-- 
2.55.0

