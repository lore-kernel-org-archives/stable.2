Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C9B353A8D
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250927; cv=none; b=U//X32D0NlIxgFq77T1kuZ80rnTjvLhdXSIdUQZjOHeQrMDJflFdwfJA28Nps7dp4k3P6ZaWKqBB60w9S2WAKfQMpnILaUwGldAKBe+Lj8lbe0hpEfTtC+0U1WJdEQZ9JO5mnpkB9tK/BIBD9vPtsU5Jiwt2kBlBVTse1NbGoL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250927; c=relaxed/simple;
	bh=TciwayOsxxorse3GHwPR+ReTFwDlI/7fhMU/ChCAlRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAWK+qqTpgcHBYXz04ogXoxA9BbxycHP271IO5ZHkvAqSBWJH4mGinT4cQS9fkOlzwahCdCmif/27SAggqyfOF1kU1pHnUxAdjOeEreEnnlAgokLr5O4cL7VnVjboJ0KeBZXKxomnSFNP8TnIa8rovuntj/8ubD6wU5VNOHYWvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3fq3Mm9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3fq3Mm9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787250926; x=1818786926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TciwayOsxxorse3GHwPR+ReTFwDlI/7fhMU/ChCAlRI=;
  b=Q3fq3Mm97yOuCuVEB4Z32u8RDFTiYRBeg/1H0NDLUo/Ko6zs+jGpxyOV
   bpkgZIdg+OL7nYe7WES1ZyUb0I1fB9TErQlFNzKdiCOime+lPeI1oEeYj
   HjBtew6U++VsXz4kWvmahc2puTS2Ivs63sC1+eI3VYT/apzhmwQIbALvp
   E522hhcun4OAV765p5LbNx3QWlCE2rgHLGvYrtZg+tQZhdSGdJcsyd+K/
   uDag367+1TXyMbcwK2iJV6y/2xuXHga2UK1KvXeMrngEy4aaXzRTZvGft
   mgy77oeLc8srFCnDHsfuuukpIQj3XP0K8FRpTOTM5MOHyBL7xO/6k0zDD
   A==;
X-CSE-ConnectionGUID: eWs2SxZYRjK1WV7ZYola8g==
X-CSE-MsgGUID: mITImniuT2yQ4vNzM4aueg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87668370"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="87668370"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 11:35:25 -0700
X-CSE-ConnectionGUID: KkKckGODSMqu7NocCHoDcQ==
X-CSE-MsgGUID: yH4gU0HcSPm28f/WRgCaQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="266722252"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.54.89])
  by orviesa009.jf.intel.com with ESMTP; 20 Aug 2026 11:35:25 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.12.y] drm/xe/guc_ads: use uncached mapping for UM queue BO
Date: Thu, 20 Aug 2026 18:35:22 +0000
Message-ID: <20260820183522.1386121-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026082055-unhinge-monstrous-7eeb@gregkh>
References: <2026082055-unhinge-monstrous-7eeb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Pre-Xe3p platform, the GAM write the UM queue through DPA using UC.
if GuC reads the queue via GGTT (WB), stale data may be observed
when the cacheline has been polluted by another agent.

To match the GAM's UC writes, configure the GuC mapping as UC as well.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260804165057.129529-4-jia.yao@intel.com
(cherry picked from commit 9daa302a82590eeee7bdc68023ddad302df4b88c)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
(cherry picked from commit 8d5134ae4177fa4f5a9bc8e71e6656cfc2852882)
---
 drivers/gpu/drm/xe/xe_guc_ads.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 35168447a90b..a4932a45120b 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -413,7 +413,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
 			       XE_BO_FLAG_GGTT |
 			       XE_BO_FLAG_GGTT_INVALIDATE |
-			       XE_BO_FLAG_PINNED_NORESTORE;
+			       XE_BO_FLAG_PINNED_NORESTORE |
+			       XE_BO_FLAG_NEEDS_UC;
 
 		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
 		if (IS_ERR(bo))
-- 
2.43.0

