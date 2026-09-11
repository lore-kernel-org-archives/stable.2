Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEBD25776
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123301; cv=none; b=Qon8fL+HT0Too790iFKsvFaT00ecDPo5KtElXnPXOBqmc5ZvHtdrgnBHfv3TkasLCmvOPF/cZFzQvuTFCLnEVahuUOtZiUO2p4embaWuTYJLOqy0fjdGKiIqgns3uP0vtVvR51XvbYta/dfnUBYRP4szTiHi52kOCWz1CsA2pto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123301; c=relaxed/simple;
	bh=hj4wxlFYz6XVXgxdWuTUS9DLtlj8IH3BpmvHr2Bjz9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGE0eNmv+WNWT9uPWB4zB4Qmlym2YDH15jjgg2apkmBUnQKIM3NNtFtSG5iAbUT4ebYzCFqF7ffedzhPPQ9flLu7G1AIcxiYf6IW4j/x0qOYaYHe/rUeRIbdgxNZXVC9cvLKX4STRBTY6n9PzsX98f95ZsQerus9J7sPEsVVklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUVzpTEy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUVzpTEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4C01F0089A;
	Fri, 11 Sep 2026 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123299;
	bh=WpLEy1hpwkkTyEYo1IpPLBWNLsyIuOGKohFnKuu5ajI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AUVzpTEyeiMYd2ZgYjCQCNoq5jmvqTzq0fJhTAby50dt/8mv4ZRqk/ZZ2kiNW9Js2
	 G4qrVmqMynb7TMRWPPV/YsRmnBN4vzqj0eGBe0TfjRZa69/xynLsOo3GCaeZxkXfGD
	 +q4bhEk2lBPYTtXIabkV6x5+afnKV2M50ZgrgLiP4QdV3qlpmz5YJtZxS5Lqfj2i8h
	 VTi+TV8m1jEQFZrmPoVApX+ksgKfUWwKnpj4fJHuY+qk7hqSVZVxgnwdWx2EsHPyUs
	 3gAxvpFu8VNvzl/yFmQLCivXgdVmYSmfn0xZIPqFds8ssqYNzzHYh8h05ao1g7lPX9
	 X3QzyJH2kL6GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/7] KVM: x86: Move eager_page_split to mmu.{c,h}
Date: Fri, 11 Sep 2026 06:41:31 -0400
Message-ID: <20260911104136.194961-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104136.194961-1-sashal@kernel.org>
References: <2026090906-angling-trickily-a20c@gregkh>
 <20260911104136.194961-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit cde542b6526639571a848e1d70f8ff6817e40e4e ]

Move KVM's eager_page_split module param to the MMU, as it is very much an
MMU knob.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Message-ID: <20260613000329.732085-10-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: a4b8acd428ba ("KVM: x86: Always initialize EFER reserved bits on vendor initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu.h     | 1 +
 arch/x86/kvm/mmu/mmu.c | 3 +++
 arch/x86/kvm/x86.c     | 3 ---
 arch/x86/kvm/x86.h     | 2 --
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 016a9fe60222e..d2721d79dc448 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -14,6 +14,7 @@ extern bool tdp_mmu_enabled;
 #define tdp_mmu_enabled false
 #endif
 extern bool __read_mostly enable_mmio_caching;
+extern bool eager_page_split;
 
 #define PT_WRITABLE_SHIFT 1
 #define PT_USER_SHIFT 2
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a61750f8e1e37..d479fe7d423d2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -115,6 +115,9 @@ module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0444);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(tdp_mmu_enabled);
 #endif
 
+bool __read_mostly eager_page_split = true;
+module_param(eager_page_split, bool, 0644);
+
 static int max_huge_page_level __read_mostly;
 static int tdp_root_level __read_mostly;
 static int max_tdp_level __read_mostly;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 47cb9eba113b1..5cec74e1afc86 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -181,9 +181,6 @@ module_param(force_emulation_prefix, int, 0644);
 int __read_mostly pi_inject_timer = -1;
 module_param(pi_inject_timer, bint, 0644);
 
-bool __read_mostly eager_page_split = true;
-module_param(eager_page_split, bool, 0644);
-
 /* Enable/disable SMT_RSB bug mitigation */
 static bool __read_mostly mitigate_smt_rsb;
 module_param(mitigate_smt_rsb, bool, 0444);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 9de577ef9c974..65003b2dd1b19 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -463,8 +463,6 @@ extern int pi_inject_timer;
 
 extern bool report_ignored_msrs;
 
-extern bool eager_page_split;
-
 static inline void kvm_pr_unimpl_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
 	if (report_ignored_msrs)
-- 
2.53.0

