Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE7B4DDB40
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661322; cv=none; b=IQZBXRKRIXr4otKUYXuwXZ9jFYb1Gdylg4CpUc7qOiJbBflBnyag/HqdWlEctFXYlLEApc7Pxuxsmmt2j5/7nM+IDGdL9zlKwLbBjGsRZr5W0uMrZVdUm/f+iMA4leWr/ThrdzGSsh247LbhLoVn/X1ckXmRI5EUiIwsyM+b3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661322; c=relaxed/simple;
	bh=xOKi78ObdFVsUm8XKOeGJumfV7faAfYxfBrz/W9WiSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+VE72H0rjwYJ1Ki6NrneC0p2OC4WmIN/hhiMJ60D0syYsxQo9QWyaaT6ulr8nYsI9Mf5H2ngIW1WKm1xTERg5+cQ/kQ9fnYvRFLZhFJDMvGFLCfUhlNcnlw1sK2GFxlwQEnyAoawHsm4y/xsFtQz7jtBNvGllhv9ylDjJ2sZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjIaW8w7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjIaW8w7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420151F0089B;
	Thu, 17 Sep 2026 16:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661320;
	bh=VSFLf4kLJivRN6lqjmWiBwDW296iOLN6/OkIRB8P0ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kjIaW8w7+18k8GEwu0bn+Lt0GyZ3meKkNtxbXTtMNpntf1mgB0A81jYFnOeF0KBLP
	 Ip2RWChAREW6K10Nvl0bjjWAmll7Gjb40/WHLrOjI7QaCdkos6leExcxQyuMMMfv3b
	 dUcFc7LlljNx48PHkKVDx7yAlZx61dHk8V2F83WqRS73qC7IF/7UBxvb56FLKNqKvp
	 imzg2q9sNMsZgRlqQyw95ljGo2a6UM4P6re6xSCFYVQEj8Jh+O2AxOVmXqm9hklNVX
	 PRI20IAqaDpdIA1nrJbMufM2WO8/u0rfIcxuJ2Fqyr1xns6P3Yz/AEpyvShTr9TRLl
	 LWVxjiirZqbVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] KVM: SEV: Read start/end indices of PSC requests exactly once per #VMGEXIT
Date: Thu, 17 Sep 2026 12:08:35 -0400
Message-ID: <20260917160835.967199-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917160835.967199-1-sashal@kernel.org>
References: <2026091709-diffusive-reforest-aa65@gregkh>
 <20260917160835.967199-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit ce6ea7b33e0075335b1eb3b227a21a98e3196e41 ]

Rework Page State Change (PSC) handling to read the guest-provided start
and end indices exactly once, at the beginning of the request.  Re-reading
the indices is "fine", _if_ the guest is well-behaved.  KVM _should_ be
safe against concurrent guest modification of the indices, but there is
zero reason to introduce unnecessary risk.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-14-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260529183549.1104619-14-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 86 +++++++++++++++++++++++-------------------
 arch/x86/kvm/svm/svm.h |  1 +
 2 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 66aab76b8a9c1..4ea8f2287d435 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3724,7 +3724,7 @@ struct psc_buffer {
 	struct psc_entry entries[];
 } __packed;
 
-static int snp_begin_psc(struct vcpu_svm *svm);
+static int snp_do_psc(struct vcpu_svm *svm);
 
 static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
 {
@@ -3757,6 +3757,7 @@ static void __snp_complete_one_psc(struct vcpu_svm *svm)
 		guest_psc->entries[idx].cur_page = entry.pagesize ? 512 : 1;
 	}
 
+	sev_es->psc.cur_idx = idx;
 	guest_psc->hdr.cur_entry = idx;
 }
 
@@ -3772,37 +3773,19 @@ static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
 	__snp_complete_one_psc(svm);
 
 	/* Handle the next range (if any). */
-	return snp_begin_psc(svm);
+	return snp_do_psc(svm);
 }
 
-static int snp_begin_psc(struct vcpu_svm *svm)
+static int snp_do_psc(struct vcpu_svm *svm)
 {
 	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
 	struct psc_buffer *guest_psc = sev_es->ghcb_sa;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct psc_entry entry_start;
-	u16 idx, idx_start, idx_end, max_nr_entries;
 	int npages;
 	bool huge;
 	u64 gfn;
-
-	if (!user_exit_on_hypercall(vcpu->kvm, KVM_HC_MAP_GPA_RANGE)) {
-		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
-		return 1;
-	}
-
-	/*
-	 * GHCB v2 requires the scratch area to reside within the GHCB itself,
-	 * and PSC requests are only supported for GHCB v2+.  Thus it should be
-	 * impossible to exceed the max PSC entry count (which is derived from
-	 * the size of the shared GHCB buffer).
-	 */
-	max_nr_entries = (sev_es->ghcb_sa_len - sizeof(struct psc_hdr)) /
-			 sizeof(struct psc_entry);
-	if (WARN_ON_ONCE(max_nr_entries > VMGEXIT_PSC_MAX_COUNT)) {
-		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
-		return 1;
-	}
+	u16 idx;
 
 next_range:
 	/* There should be no other PSCs in-flight at this point. */
@@ -3811,21 +3794,8 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 		return 1;
 	}
 
-	/*
-	 * The PSC descriptor buffer can be modified by a misbehaved guest after
-	 * validation, so take care to only use validated copies of values used
-	 * for things like array indexing.
-	 */
-	idx_start = READ_ONCE(guest_psc->hdr.cur_entry);
-	idx_end = READ_ONCE(guest_psc->hdr.end_entry);
-
-	if (idx_end >= max_nr_entries) {
-		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
-		return 1;
-	}
-
 	/* Find the start of the next range which needs processing. */
-	for (idx = idx_start; idx <= idx_end; idx++) {
+	for (idx = sev_es->psc.cur_idx; idx <= sev_es->psc.end_idx; idx++) {
 		entry_start = READ_ONCE(guest_psc->entries[idx]);
 
 		gfn = entry_start.gfn;
@@ -3862,7 +3832,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 		guest_psc->hdr.cur_entry++;
 	}
 
-	if (idx > idx_end) {
+	if (idx > sev_es->psc.end_idx) {
 		/* Nothing more to process. */
 		snp_complete_psc(svm, 0);
 		return 1;
@@ -3877,7 +3847,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	 * ranges/operations and can be combined into a single
 	 * KVM_HC_MAP_GPA_RANGE exit.
 	 */
-	while (++idx <= idx_end) {
+	while (++idx <= sev_es->psc.end_idx) {
 		struct psc_entry entry = READ_ONCE(guest_psc->entries[idx]);
 
 		if (entry.operation != entry_start.operation ||
@@ -3920,6 +3890,46 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	BUG();
 }
 
+static int snp_begin_psc(struct vcpu_svm *svm)
+{
+	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
+	struct psc_buffer *guest_psc = sev_es->ghcb_sa;
+	u16 max_nr_entries;
+
+	if (!user_exit_on_hypercall(svm->vcpu.kvm, KVM_HC_MAP_GPA_RANGE)) {
+		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
+		return 1;
+	}
+
+	/*
+	 * GHCB v2 requires the scratch area to reside within the GHCB itself,
+	 * and PSC requests are only supported for GHCB v2+.  Thus it should be
+	 * impossible to exceed the max PSC entry count (which is derived from
+	 * the size of the shared GHCB buffer).
+	 */
+	max_nr_entries = (sev_es->ghcb_sa_len - sizeof(struct psc_hdr)) /
+			 sizeof(struct psc_entry);
+	if (WARN_ON_ONCE(max_nr_entries > VMGEXIT_PSC_MAX_COUNT)) {
+		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
+		return 1;
+	}
+
+	/*
+	 * The PSC descriptor buffer can be modified by a misbehaved guest after
+	 * validation, so take care to only use validated copies of values used
+	 * for things like array indexing.
+	 */
+	sev_es->psc.cur_idx = READ_ONCE(guest_psc->hdr.cur_entry);
+	sev_es->psc.end_idx = READ_ONCE(guest_psc->hdr.end_entry);
+
+	if (sev_es->psc.end_idx >= max_nr_entries) {
+		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
+		return 1;
+	}
+
+	return snp_do_psc(svm);
+}
+
 /*
  * Invoked as part of svm_vcpu_reset() processing of an init event.
  */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 912262c7dc8a2..145993b976228 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -233,6 +233,7 @@ struct vcpu_sev_es_state {
 	/* SNP Page-State-Change buffer entries currently being processed */
 	struct {
 		u16 cur_idx;
+		u16 end_idx;
 		u16 batch_size;
 		bool is_2m;
 	} psc;
-- 
2.53.0

