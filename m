Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AFE356777
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798113; cv=none; b=mhmk8Sr7TMt0ixLRcLR77ucvAC3AJbiKbggkBMkyiy+VRrNJqHtAYstLc4tRmI+GCIsdnYJH5fnUvJAofWq2NtSvArn34aw97RYxDUP2/Ybj1K4AMu7vTc+TdZmYeKTMvF4zsrijio0VrM1M5W1WSMZH9Tq2MQnmjiWKRwBggHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798113; c=relaxed/simple;
	bh=DJM6qUoAyC+1gfcsEIfCkOab+JqJy62H4IDVrRsiByk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQHfaLZFvcGSwTAUdEDuG4KPct6P1dfhlauxLIvTLifLN6YYe6KkpEumy+0jOu7Cwwc/C0G1Ns351THYO2WZrmpB8fFpa+BYtr7K7D9uWfjY5Q+zQ1nLDnY2mR0+xvmG3GZpgyikTSaxqbONBi/EMsYjX3AT7YSmTWU9TYdEXqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqoDBjCL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqoDBjCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785798111; x=1817334111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DJM6qUoAyC+1gfcsEIfCkOab+JqJy62H4IDVrRsiByk=;
  b=kqoDBjCLla9sK7k2N+IWOzjejTwfwhoJhHSHG1zTgV+tkuG8cNB/OF5R
   90f9nWI7j790apDBrl28R707wNUBeTOwFJFiAQha4VVoS2WTWswox547d
   qvoKZc1Y3KaQLZAxXSYmtRgFbDwW97zpqQhZTTlj1xzIC92bY5/DuYaI9
   aOV9KWyCZljEO1yuGisJ5ILrJCk2E9MivJdUgX/nIBrM5IIS2dr0oMv/k
   6yI179CWkjOvcYviOe568EEXieVzscCa9H+R7nWsHFuoTR3f4J7jiZ0Me
   EWN/VwbpCRVMTPMStCWDAoB+JRK1HANBD4FiHUeeMmpoQHAvO/W2Tcb0w
   A==;
X-CSE-ConnectionGUID: HozudmgqSyesRF9KNAz9dQ==
X-CSE-MsgGUID: daxo6XIRSraWpveT+h9vBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="88871297"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="88871297"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:45 -0700
X-CSE-ConnectionGUID: YKRZxkINTQmhjKZKfHpLNw==
X-CSE-MsgGUID: p9vXn2EIQECJBVO6j0qsSw==
X-ExtLoop1: 1
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:45 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7.1.y 5/8] drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
Date: Mon,  3 Aug 2026 16:01:33 -0700
Message-ID: <20260803230136.3270230-6-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803230136.3270230-1-ashutosh.dixit@intel.com>
References: <20260803230136.3270230-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit aeaa7d2bb017272ab9e18759fe00bf758cd3299f ]

Whitelist or de-whitelist OA registers by setting or resetting the 'deny'
bit in OA nonpriv registers and writing new register values to HW.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-7-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index dbaa387a35613..1a53abbd9a74f 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -216,6 +216,21 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->reg_sr, first_oa_slot);
 }
 
+__maybe_unused static void __whitelist_oa_regs(struct xe_hw_engine *hwe, bool whitelist)
+{
+	struct xe_reg_sr_entry *entry;
+	unsigned long reg;
+
+	xa_for_each(&hwe->oa_sr.xa, reg, entry) {
+		if (whitelist)
+			entry->set_bits &= ~RING_FORCE_TO_NONPRIV_DENY;
+		else
+			entry->set_bits |= RING_FORCE_TO_NONPRIV_DENY;
+	}
+
+	xe_reg_sr_apply_mmio(&hwe->oa_sr, hwe->gt);
+}
+
 /**
  * xe_reg_whitelist_print_entry - print one whitelist entry
  * @p: DRM printer
-- 
2.54.0

