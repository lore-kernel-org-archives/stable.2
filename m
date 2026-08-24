Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1945A299
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590342; cv=none; b=TMI/VzTwOha3PGg1Vnnuf/pcx5tIHrT/6jPi3ubu1oPPDq4WCxz7mRDl8st4pthMWfZ5XV3d/6P8wKrV+3caX4F1GcyGs9h3yf/WsdiqggbEd1srtUcU7EqXW1QIMzsslaEzo7xK5W+fZ3KvVaQj7KToYSudZ+FCOPZNg2tXEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590342; c=relaxed/simple;
	bh=g+Zvczh6A7coCLeKduqBrq/FGaLwDjCA5vq7GVQoWlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNObmPGtZ49L/yH+05CdgLQ3JiIRCxkZsP1/1i9hOM+rKqt2kDA2QDho9o+eCPhaMSdUrWAvDnJR5ihnqmH8YouBa49qXsIvtSD6XeqJPbjUk8E2U7zALvAXKPID3GVQRs077nKitgFkll7n/216XzgXs/NhezIgCtyCp7de+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+VZZKui; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+VZZKui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787590341; x=1819126341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g+Zvczh6A7coCLeKduqBrq/FGaLwDjCA5vq7GVQoWlA=;
  b=c+VZZKuieBSLR7Uev6cjwscyrSx5bdS3g8W0/q3S7d8ayfeECcCGMvuM
   vYfa9BIP6sY0aN9/j8H7x/wew6W2LbPvrsUqfevwdGRbRzp/5isLsVwdV
   V6/iRabT6JMGU+SNCVK1dTZ4v1Yu704s2PzME99b9Gez9JYMExBbWPOP6
   abL/BqlZn2/whNGkxVPc9ETAiEdSdU/J0Ud5lUn5lbgVUlxLE1zyyHAPQ
   WLrXme0mJukq/pm/JnnzTFINTUv5Ato10jfzalwOmUXBNZnOwqMEqEiey
   Ftl++dqtx5LSYgZX2ZtWYKjKetLQZf3e/MbpPWsybm7fH2qZYi9GIF+A3
   w==;
X-CSE-ConnectionGUID: PcHjIh6MQZaMeQi6cSZBZQ==
X-CSE-MsgGUID: 76Bm7iTmRxiwg/CSPT6V1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98723383"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98723383"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 09:52:20 -0700
X-CSE-ConnectionGUID: P2vPhE4GQ3SKz24DAQtw5g==
X-CSE-MsgGUID: RRuxVoNbQK2BTqI4qBpCZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="268995302"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.39])
  by fmviesa004.fm.intel.com with ESMTP; 24 Aug 2026 09:52:19 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 3/3] drm/xe/guc_ads: use uncached mapping for UM queue BO
Date: Mon, 24 Aug 2026 16:52:08 +0000
Message-ID: <20260824165208.498797-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824165208.498797-1-jia.yao@intel.com>
References: <2026082036-afterglow-tapered-84a0@gregkh>
 <20260824165208.498797-1-jia.yao@intel.com>
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
index 4c3e21b5e60e..ecd07d76ec4a 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -405,7 +405,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
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

