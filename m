Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F071B78F3;
	Fri, 21 Aug 2026 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351447; cv=none; b=eMrTKA6SludnFF4XKb012AWp1FvziQo3EnFZViK3h5gU9qktDFUqZBVoAJYmqdwz6In6X0qhzEJC6WNA4tCq1rByC/+RGuFwo7E83C00kgNaIm1EKnS+gkeE2YMNXe2FPxuO21IEMef+d8PVP7cFLMEaHUC1B4KUg++YgGENBzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351447; c=relaxed/simple;
	bh=SktehEt/+fCtLHeuJbZyO62rajg0B2bxkz5egzx+Nwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tk6rYjByK92VyWqoL4t7/+Sgkp1gWjO3b+LYm6NN8Oag7ClC2UwfWAvR/baQNGi/Rk9CPVN2B/gnrhvim5QwutVWoaQwxVObQCiRrtOp5Z2IR7G8JSIxHW5YvgXmt8cfNbIS9lPqKf/lHU0fuAdBgWXhlSg9ZwnEDyOHP9jwdoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqWbMjjd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqWbMjjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351445; x=1818887445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SktehEt/+fCtLHeuJbZyO62rajg0B2bxkz5egzx+Nwo=;
  b=EqWbMjjdVFxDydzxrqJh9ciJhpPeMzeVmxyi27rxZgLSE8iG6MVFJ1+D
   C5d6g4UXTDisH31RgYwkQgh8xitJ24zYZCFJnrRk0XFtV/+rNyKspkwvQ
   65avrXIMgG5/bz83ijX+IBWSBLHaxctDPkPVAVdsROIwZuLG8fXESy14j
   Sq8SubKIlXGB9nz/jNj9uPIiwv2JHdbgg30BNxGLls2PCo1Xa0zEU7jMU
   gwvFssn6Jw9KAuImGgSCRN5hfBsnQMVt9Z4sPjMir45lItknMDRl8OHso
   dPEbZXOdXI9taBaQVlHfe7W+SY7m2Cbork3tDUrk7xPFD0rEs49LNmq2j
   A==;
X-CSE-ConnectionGUID: U5xAmAAvRVOAgUtYYaEx4w==
X-CSE-MsgGUID: KNTy1kNtSiWcrKF3lEqy3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032557"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032557"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:44 -0700
X-CSE-ConnectionGUID: UTbHwndFRQWfOs0ReG6BIQ==
X-CSE-MsgGUID: kJa9PSjaSSim0kZj0k6B7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679724"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:44 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/23] perf/x86/intel: Guard counter masks against zero counters
Date: Fri, 21 Aug 2026 15:19:40 -0700
Message-ID: <20260821222002.54907-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821222002.54907-1-zide.chen@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running as a guest with a vPMU exposed, the host may expose zero
general-purpose counters or zero fixed counters. In that case,
GENMASK_ULL() is called with a negative high-bit argument, resulting
in an out-of-range shift and undefined behavior.

On systems with PMU partitioning enabled, this configuration is more
likely. Change GENMASK_ULL() to BIT_ULL() to guard mask generation
against zero counters.

Fixes: 722e42e45c2f ("perf/x86: Support counter mask")
Cc: stable@vger.kernel.org
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2b35483e2b70..8b13bcc5259c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7905,7 +7905,7 @@ __init int intel_pmu_init(void)
 		x86_pmu = intel_pmu;
 
 	x86_pmu.version			= version;
-	x86_pmu.cntr_mask64		= GENMASK_ULL(eax.split.num_counters - 1, 0);
+	x86_pmu.cntr_mask64		= BIT_ULL(eax.split.num_counters) - 1;
 	x86_pmu.cntval_bits		= eax.split.bit_width;
 	x86_pmu.cntval_mask		= (1ULL << eax.split.bit_width) - 1;
 
@@ -7924,7 +7924,7 @@ __init int intel_pmu_init(void)
 		int assume = 3 * !boot_cpu_has(X86_FEATURE_HYPERVISOR);
 
 		x86_pmu.fixed_cntr_mask64 =
-			GENMASK_ULL(max((int)edx.split.num_counters_fixed, assume) - 1, 0);
+			BIT_ULL(max((int)edx.split.num_counters_fixed, assume)) - 1;
 	} else if (version >= 5)
 		x86_pmu.fixed_cntr_mask64 = fixed_mask;
 
-- 
2.55.0

