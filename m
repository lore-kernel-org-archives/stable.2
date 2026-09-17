Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3744BA1FA
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644330; cv=none; b=aERkXbEqlO/Mg4vv29oClVERkyaEfDllivzARLdPtAhJsxSI9Et6UbbE5hbH7Z8zE01IQkAwZIXVtI6GyLJhOCB88ZjxZnUtsu4ddoNWz0Hke/J6UBJQ2OoqRPxYdTyPDE1LLc2ay3mlExcPK858dbYNimrrtkh7GsEnupHhz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644330; c=relaxed/simple;
	bh=qEkzER/NLGUIV8YKEia7wozG0iQHw6GJbS34pvoRlCM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sl+OVCMhYKLhLxDpSACUIomM95c9tiwDjeg5zRLC+a6kYS5r32O65FoW6I9lGaQkJTDxwXP4jse5O4q41kW1exg1XI5eI5nDCOGQ0oNphzajmh8n7MEwl7CZmqs9x3aXySuhrvO8aUcpJ/rYOTkROfjGG8YqUlsBRXvgaTx5uUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0cWRvnGV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0cWRvnGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FDD1F00893;
	Thu, 17 Sep 2026 11:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789644328;
	bh=1nDp1Z2GNT7TyQmIqmfDzf3h4L3rtGKxAQFtctcxOjA=;
	h=Subject:To:Cc:From:Date;
	b=0cWRvnGVmBI2TLIvdu/I3+N43mrpRh+9IvE32peocydG89JcTg9yrYL+ewmgJ/MJE
	 KT2qg6cL2auivrBLLoq6G06r1D5vTfTWbBqaHQ0eq/sOlA84G5AQjvRhqUdmKgKYhs
	 iqkANxpfL/2omRLXT8NadzojLimmGqYwrTfRG2Ws=
Subject: FAILED: patch "[PATCH] KVM: SEV: Read start/end indices of PSC requests exactly once" failed to apply to 6.12-stable tree
To: seanjc@google.com,michael.roth@amd.com,pbonzini@redhat.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Sep 2026 12:17:09 +0100
Message-ID: <2026091709-diffusive-reforest-aa65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ce6ea7b33e0075335b1eb3b227a21a98e3196e41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091709-diffusive-reforest-aa65@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ce6ea7b33e0075335b1eb3b227a21a98e3196e41 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 20:35:38 +0200
Subject: [PATCH] KVM: SEV: Read start/end indices of PSC requests exactly once
 per #VMGEXIT

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

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 9f6543cebedf..4ebe0d449789 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3841,7 +3841,7 @@ struct psc_buffer {
 	struct psc_entry entries[];
 } __packed;
 
-static int snp_begin_psc(struct vcpu_svm *svm);
+static int snp_do_psc(struct vcpu_svm *svm);
 
 static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
 {
@@ -3874,6 +3874,7 @@ static void __snp_complete_one_psc(struct vcpu_svm *svm)
 		guest_psc->entries[idx].cur_page = entry.pagesize ? 512 : 1;
 	}
 
+	sev_es->psc.cur_idx = idx;
 	guest_psc->hdr.cur_entry = idx;
 }
 
@@ -3889,37 +3890,19 @@ static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
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
@@ -3928,21 +3911,8 @@ static int snp_begin_psc(struct vcpu_svm *svm)
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
@@ -3979,7 +3949,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 		guest_psc->hdr.cur_entry++;
 	}
 
-	if (idx > idx_end) {
+	if (idx > sev_es->psc.end_idx) {
 		/* Nothing more to process. */
 		snp_complete_psc(svm, 0);
 		return 1;
@@ -3994,7 +3964,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	 * ranges/operations and can be combined into a single
 	 * KVM_HC_MAP_GPA_RANGE exit.
 	 */
-	while (++idx <= idx_end) {
+	while (++idx <= sev_es->psc.end_idx) {
 		struct psc_entry entry = READ_ONCE(guest_psc->entries[idx]);
 
 		if (entry.operation != entry_start.operation ||
@@ -4044,6 +4014,46 @@ static int snp_begin_psc(struct vcpu_svm *svm)
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
index 06192bc9c107..5137416be593 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -259,6 +259,7 @@ struct vcpu_sev_es_state {
 	/* SNP Page-State-Change buffer entries currently being processed */
 	struct {
 		u16 cur_idx;
+		u16 end_idx;
 		u16 batch_size;
 		bool is_2m;
 	} psc;

