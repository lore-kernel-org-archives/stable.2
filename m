Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5738D688
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898168; cv=none; b=ExzoJvXwEaUxmQAs9gxTPdlKneCc0I0nL1s3a9jw7xwsRnIrxrUfJ1gntsYzHB7Ru9L8UyxuNVI5g63wqtyt0CP1qWlzBy3Umk2v+0OoH76p60Zjy+uYTz15+EhztP9Kwop1i9DYUBGSoLbH5ZGEsK1E+6s7SjNmmeh3IyuO3WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898168; c=relaxed/simple;
	bh=H42sTDEQfXu6VF2BThXhu9Bt4CnDM/nQwT6wGhHlUhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcCgdTdfM+LaQZVZ2438pbAXQx+474PCMsSQ/eemWSItHcoGru+HMJfc0xfsX4z5McnBosm8u+xsB6ITMFxygydWv5ceFcLinybEFzMIml9D/igJaifIoT1FeM9pGZFCCPgS0ufNP2lWVZfCjTOc5yV0adWfQNxFVKE8H4nOkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJSF43Ry; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJSF43Ry"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785898166; x=1817434166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H42sTDEQfXu6VF2BThXhu9Bt4CnDM/nQwT6wGhHlUhw=;
  b=FJSF43RyNSt3Pcf0mzzdP1UCbqO/XVuqm5foz9XEssrFE/LlPFrdSFqt
   /mQcbJ520DYAJV9Baej1I70RJWLrJrJ3e+LGL1Lm4/zHtKR7ghvbatO7g
   5Fw31JCuMNH/X6kgPwFQQDQrYT1Sja9aCxR9grApjYGDjRvdwhRJcbQur
   22uxd/XdjahQk71fJTtE/U2zeVUddeUbF9wQgh478I+KT4wkwcEmFuMxV
   kd5BaY01OfW0PQI86XRA5DMgLe/eV4dAWWOjyLN1rUZ9tyrw4zbGnAhqu
   oB5EReeW0ukWi1/oHtSMbLhwHUT5Qo91ykDkmqyI6VLJz9Hrchfr07BP+
   g==;
X-CSE-ConnectionGUID: iNH5trwtQDmdZr5VcDu3vg==
X-CSE-MsgGUID: tbTcp0acQeKQzR0sR6VtXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97826127"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97826127"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
X-CSE-ConnectionGUID: UjyvUokvR3O5a/WCSnWkzg==
X-CSE-MsgGUID: pxaC+DQ1TZGvcbmUuZRABg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259911790"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y v2 04/12] drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists
Date: Tue,  4 Aug 2026 19:49:07 -0700
Message-ID: <20260805024915.3407033-5-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
References: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit e70086a3a06d276b4a5d9a2c51c9330c6cf72780 ]

Unconditionally whitelisting OA registers is a security violation. Set
RING_FORCE_TO_NONPRIV_DENY bit in OA nonpriv slots, so that OA registers
don't get whitelisted by default after probe, gt reset, resume and engine
reset.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Suggested-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-2-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index ef1bb1b47af09..d75bc87cb3cb1 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -67,10 +67,12 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 	  XE_RTP_ACTIONS(WHITELIST(CSBE_DEBUG_STATUS(RENDER_RING_BASE), 0))
 	},
 
+#define WHITELIST_DENY(r, f) WHITELIST(r, (f) | RING_FORCE_TO_NONPRIV_DENY)
+
 #define WHITELIST_OA_MMIO_TRG(trg, status, head) \
-	WHITELIST(trg, RING_FORCE_TO_NONPRIV_ACCESS_RW), \
-	WHITELIST(status, RING_FORCE_TO_NONPRIV_ACCESS_RD), \
-	WHITELIST(head, RING_FORCE_TO_NONPRIV_ACCESS_RD | RING_FORCE_TO_NONPRIV_RANGE_4)
+	WHITELIST_DENY(trg, RING_FORCE_TO_NONPRIV_ACCESS_RW), \
+	WHITELIST_DENY(status, RING_FORCE_TO_NONPRIV_ACCESS_RD), \
+	WHITELIST_DENY(head, RING_FORCE_TO_NONPRIV_ACCESS_RD | RING_FORCE_TO_NONPRIV_RANGE_4)
 
 #define WHITELIST_OAG_MMIO_TRG \
 	WHITELIST_OA_MMIO_TRG(OAG_MMIOTRIGGER, OAG_OASTATUS, OAG_OAHEADPTR)
-- 
2.54.0

