Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5D3E8324;
	Tue,  2 Jun 2026 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412281; cv=none; b=X0OX9Hg4LHrRHiQLYqJ1USk0tAHkeAc6IRNcBWLQbopTOgdzd8MHb2CoBgbO8M6DPBoBLttSqyghChiDYA7CG6UBM+95TJ9CVa6y4DRofqEH96z8mMBzAuu0h9qCRXy6Qntxv0SDRmIwxvPKQSIsx4zLIm1wAPNksDXgEd+RSoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412281; c=relaxed/simple;
	bh=vNq45d1mDRlq9GGhmU4BKWAv1tSbLrh6BxZtzTADikg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6j/RJkDnjP6qjn4G7yZSIgRCghrnkks/zMOYTmfS5B/QccxNCy7BgYOHbwKUu9+W2/T842dLtQc1U2ZBzN5ddfOFOqymjViZDsf6quypvH43pMJ9kVS7mNHCkkXM/sZwMUcC+pfRHgROE8SlZDjh9k30SpZ71WMqrsnY3GRKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPNHhWha; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPNHhWha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780412280; x=1811948280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vNq45d1mDRlq9GGhmU4BKWAv1tSbLrh6BxZtzTADikg=;
  b=JPNHhWhaQovZs+JPK0O1TBAVQGAgbcus8uC7CIRTPpl1vz1OpNi611QQ
   BnHN+DmNXZ7xs5ZiImSnKiBJg9rd1RLvqAC719pTfdDm0eWprmlmRztDa
   YyqGWm05h1bwb9h1cOUK4enDNJv7j+eZcV2F2w0NHUXhtWeF3tp6hbHPi
   1fqLwNQd+ICwf2vD0BCEt9ZIDtgYsRdL4GZLXYbOox/UY+5EP6KvV10yM
   KrgNY1knsmFKJnnIFQvtVXwBKN6LTA7bVbZcvUGCwB45FUpvUfm1v2J8D
   L9k1csPDkLgCyar0xWv/ssjSuOmaAArtiLkiGOfayp/3i1VrODv5x9x+B
   A==;
X-CSE-ConnectionGUID: nx5bixW1QD6huXVpKwItzA==
X-CSE-MsgGUID: vq7HzWL1QbSB0X8cjtVMAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="103859996"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="103859996"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:57:55 -0700
X-CSE-ConnectionGUID: JYOz9VHrSrqdfu0w+Gv+YQ==
X-CSE-MsgGUID: zqwUxP+STFuStepAZAu9ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243095628"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:57:54 -0700
From: Zide Chen <zide.chen@intel.com>
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH V3 4/7] perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()
Date: Tue,  2 Jun 2026 07:49:05 -0700
Message-ID: <20260602144908.263680-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602144908.263680-1-zide.chen@intel.com>
References: <20260602144908.263680-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some Raptor Cove CPUs, enabling uncore PMON globally at driver init
may increase power consumption even when no perf events are in use.

Drop adl_uncore_msr_init_box() and defer programming the global control
register to enable_box(), so it is only set when a box is actually used.

IMC and IMC freerunning counters use a separate control path and are
unaffected.

Cc: stable@vger.kernel.org
Fixes: 772ed05f3c5c ("perf/x86/intel/uncore: Add Alder Lake support")
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V3:
- Add Fixes tag. (Dapeng)
---
 arch/x86/events/intel/uncore_snb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 3dbc6bacbd9d..edddd4f9ab5f 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -563,12 +563,6 @@ void tgl_uncore_cpu_init(void)
 	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
 }
 
-static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
-{
-	if (box->pmu->pmu_idx == 0)
-		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
-}
-
 static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
 	wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
@@ -587,7 +581,6 @@ static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
 }
 
 static struct intel_uncore_ops adl_uncore_msr_ops = {
-	.init_box	= adl_uncore_msr_init_box,
 	.enable_box	= adl_uncore_msr_enable_box,
 	.disable_box	= adl_uncore_msr_disable_box,
 	.exit_box	= adl_uncore_msr_exit_box,
-- 
2.54.0

