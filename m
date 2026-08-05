Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039F93BB9E3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897793; cv=none; b=tK9xGk57oR4c2tz83ID7AWvfBwt+IFQYV/pBTYbZo0hnw6/ye/7CVASpOhPjZxUd+7M9qeij2To7vfTkKs5atiVyWfj4gug31Yp+2IXhovYw5HsCbxRH/eIJI4A8eYQN9N6HecTO1eN04WTMpexsMtr1PbhvU7aBOEczVt3i/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897793; c=relaxed/simple;
	bh=OTvueQaWEo2A95Vvm7ff4qK9tNIntG/jgm/nLHvjE7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dzvkbnl4lZn2sw1FJY55ehUfkOYkj94NGjcrmftFaQWGjvmW34n6m4qKobTSmB7TC9Dib6yfTkNCIpWZZro9rBIdotZAk/OPOieTF70rTNzLUwtF5dmVo7cuHCsnbpMNUU4HlrVpWg1rSjlUUwkOoAOF8wpsFTaWT/TJOlchQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VH71f1R1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VH71f1R1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897792; x=1817433792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OTvueQaWEo2A95Vvm7ff4qK9tNIntG/jgm/nLHvjE7Q=;
  b=VH71f1R1EPwkOhr9u+TQSNbU2gHWBuKtNkULQZ1hoRBUb6F/KgpXX2ZR
   r0aY6M6FCCjXm/Ggr8d+Wul4UeQrA/M/0IYnxHKoMjjtwwC6KfE7n+L4x
   4LHHJzkyjSDWw5TxOXX66WJviZZEWstMhAv4Q83lCdCj78WxnRtX9Xq8m
   zrYuqo95yib0HZdbtWoxTV8i4OuPVRZm6OJXFJclwdyCqSFAE5jDYc/Rk
   wyNQA11gcUkKQHapd1GU5+erPMEcQkWpWwpb9GP0YX0IEb80WL6f9YzVg
   sO3uqDSq9Yb0J38Dp1/9aL94Y5k7lgh5W2zbaGLyecbiIU+uFRlHZcorl
   A==;
X-CSE-ConnectionGUID: yJKrbiulRUm5n4A1C7lsVw==
X-CSE-MsgGUID: 8lQgVCLETU2zF0yqf4RYhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85585778"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85585778"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:06 -0700
X-CSE-ConnectionGUID: scFASE/lTvW+8wprdls6lw==
X-CSE-MsgGUID: vDjn9oiXRUiJLF96fN1Sfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="291612678"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:05 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y v2 4/8] drm/xe/rtp: Save OA nonpriv registers to register save/restore lists
Date: Tue,  4 Aug 2026 19:42:56 -0700
Message-ID: <20260805024300.3406307-5-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024300.3406307-1-ashutosh.dixit@intel.com>
References: <20260805024300.3406307-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit a19a83721a28ccaddace846da70da5c53d7dd052 ]

Now we can save OA whitelisting nonpriv registers to register save/restore
lists. OA nonpriv registers are saved to both hwe->oa_sr as well as
hwe->reg_sr.

During probe, resume and gt-reset flows KMD will apply hwe->reg_sr,
ensuring OA registers are de-whitelisted after these events. For
engine-reset, hwe->reg_sr is registered with GuC and GuC will apply these
registers, ensuring OA registers are de-whitelisted after engine resets.

hwe->oa_sr is used for whitelisting or de-whitelisting OA registers during
OA operation, by toggling the 'deny' bit on oa stream open/close.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-6-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 1a7d69ef4fe82..dbaa387a35613 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -203,6 +203,17 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_to_sr(&ctx, oa_whitelist, ARRAY_SIZE(oa_whitelist),
 			     &hwe->oa_whitelist, false);
+	/*
+	 * Save oa nonpriv registers to hwe->oa_sr, from which oa registers are whitelisted
+	 * or de-whitelisted, by toggling the 'deny' bit on oa stream open/close
+	 */
+	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->oa_sr, first_oa_slot);
+
+	/*
+	 * Also save oa nonpriv registers to hwe->reg_sr, to ensure oa registers are not
+	 * whitelisted by default after probe, gt reset, resume and engine reset
+	 */
+	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->reg_sr, first_oa_slot);
 }
 
 /**
-- 
2.54.0

