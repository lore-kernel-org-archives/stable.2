Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FEB37D135;
	Fri,  5 Jun 2026 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622229; cv=none; b=Y6ZItHq/fmcebfubWUlIEvNEP0UdzvbZx0/vtlDOExrPgylXDW2KnajN5UxJSI/UKRDBTf/CJuM8nHabJCGVTbQ6D89ipv1wQnG7iBTuKe9G0gzhlIVOVXqsNimPxO9lgdkO/oITJeAUc0Fzb4L2KfGOyRE7FaUnW8QDIVRpAvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622229; c=relaxed/simple;
	bh=mM9Pr8lZ3nTTBIy6EC6BHzVoL0MBKDOZfyc0JGyxsaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTXr28zDIIySZGzLJ7/pmHp1ZvAxZX3d+IcUcbEzby0cGat8nkJxa2cx7P87ZDbYATaKc9AKTIkwyeMkyN2T9wGMC5AkhTWohrZejQPmYMZXkglpL6BqoiJYJmtRHYPBlZZDWhhoLTlOf97M2J5HP2Hni3paDEQl8JWlaLB1+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJavDAK5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJavDAK5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780622224; x=1812158224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mM9Pr8lZ3nTTBIy6EC6BHzVoL0MBKDOZfyc0JGyxsaQ=;
  b=KJavDAK5Qnr5Xl28Md+Vx2Vq3O2qutRjGrCZR8ygfIwmlk1gNFVIcY1v
   1TCaOcc1A1/Qrc6qDkusl5Hu20LfA2Ls5iQJog//htjAbk7XpX+PV7XiQ
   UVIj82AFdHF5c/4AjYsQ9oV+S1LYmDYXqoGeFc7hib+Tv6TZecgHSgq9V
   XGNw4dakb2ACstAqLXdbjnCuD/yFdx6J4JS1oor5zxZnQ8ty9APyc623U
   d4EzWtqvMSQc0gnOlQ+pLv0lWpQV1g/snLRCppRqXpoW55gOy3ephr2E3
   DpKJrVmBRqLgNeEdT1N5ctdX0t9woCMavuoFMvejJty9hb9ZgIWXTRVj9
   A==;
X-CSE-ConnectionGUID: 4pTuYWYdSaeTQzB68l6VQA==
X-CSE-MsgGUID: EYHGe2/fSs2uUtxnEVU3jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="91772193"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="91772193"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 18:17:04 -0700
X-CSE-ConnectionGUID: 3VAqbbqQQ/y3fHUdgJuUdQ==
X-CSE-MsgGUID: zhh635Q9RGm8rq8RXowFXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="244817125"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 04 Jun 2026 18:17:01 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/8] perf/x86/intel: Fix redundant branch type check in intel_pmu_lbr_filter()
Date: Fri,  5 Jun 2026 09:11:32 +0800
Message-Id: <20260605011136.2043393-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In intel_pmu_lbr_filter(), the 'type' variable is bitwise ORed with
'to_plm' (which contains X86_BR_USER and/or X86_BR_KERNEL bits). Because
of this, 'type' can never equal X86_BR_NONE (0) after the assignment.

As a result, the subsequent check 'if (type == X86_BR_NONE)' is dead code
and the entries with X86_BR_NONE type would not be skipped eventually.

Correct this by masking out the X86_BR_KERNEL and X86_BR_USER bits
before performing the X86_BR_NONE comparison.

Cc: stable@vger.kernel.org
Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

Original patch link:
https://lore.kernel.org/all/20260414021440.928068-1-dapeng1.mi@linux.intel.com/

 arch/x86/events/intel/lbr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 72f2adcda7c6..16977e4c6f8a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1245,7 +1245,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 		}
 
 		/* if type does not correspond, then discard */
-		if (type == X86_BR_NONE || (br_sel & type) != type) {
+		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type) {
 			cpuc->lbr_entries[i].from = 0;
 			compress = true;
 		}
-- 
2.34.1

