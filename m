Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722882E401
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170186; cv=none; b=qBWC93ju1//OPIIeRzllcp+vb7hQxdiHVQWWk6I4uDPt7Nwk12bk+H0dQBn8rgkVW0+BYu0JM67ryFUPDbJgzmr4A/zqAPsWonDWWTly+qDqD4UbYg87ciyNHXxEf5p+3uWfKJEySIXMg988wrdpWIJbriaJQSYHOa/Rc+msXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170186; c=relaxed/simple;
	bh=6nL+LNrvxZ9GwLnH+y8n4JqZKw7DsDOgjvV3lhPSQd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/x5b4I/i1PqYxvFsPMUDUKCwwc/9CDiooLqkpmXZK4OfwwJUdE2XD+LxoM6IwVQ9L1Ch0LZvVt5wywkikNRxhNDTbkybxaHqv1e/73tcDVCYpYwgj5VWqxZFgpFccmXw3D6PgwGydql9eQsZ8k4bPNFNjCh8f2F9WWiYoOy7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZBvYvbh/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZBvYvbh/"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf27856f9cso3436605ad.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 23:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786170184; x=1786774984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hhYOeI398YmfhRP0mti85SmeGWCzsczByG2uoD9wePY=;
        b=ZBvYvbh/M07B8SgGVi9iS8q+prjyXtXJIE/pUeqSH0SVOe4qbS+P1f8NDewuiLvHht
         tqIRgLW9M7zLd6GRVAtkDMHxWH12XQ9SRxriuUP94Gx8NfT27/i8yzFr3PwbsGWMDYhq
         kewV0vCKi2zHW2FDoP4qkpQnsc989RYqYnYRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170184; x=1786774984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhYOeI398YmfhRP0mti85SmeGWCzsczByG2uoD9wePY=;
        b=fP97F+hAtFnzvf91uLUkX9jz25gpyilxMw/hXEdtYDJFCe5NC+xnuoqybXRbp4sV+K
         bAWjsM0JtwqpPUEhIXhlDZYfnFDvGEP+5lj7DBcKvRQoRCZo4VXHgrK5GkwR6gv+MzoT
         l9e8nXDZB/LO9jhSrYtH7+gHILS2B8wxwuVYNLDMU/LHatdLMm+BSrmr46aGWQQv4T5f
         mRKDtm3SW07RGTRZ6Dbib9y2V/pOdJovOgHcZL7EZQ+hkEHLWC7qXthCV0gFXcBq/w8C
         5oLKS3ASm7WlJjNEazgstr8MAqFD0PYlhffvmj/YKAgwispYDB1cpFtsheXov4oXz13C
         xoHA==
X-Gm-Message-State: AOJu0Yz508jTgzMFy+lBYAO/G9/PbcBYjJbp/H6e9C0ipZuB+kRh9OQ+
	HNh/etFoGXC5Vl9hnR0hq09jggnOqxlwC2r6SZogvVm5mPiv168l/WE+qqrN1LuKBGPmESSQByM
	YckY=
X-Gm-Gg: AR+sD13XBn4MrBozVOCSEv4vXu13F0cLZf1ZwwFrmk4LIOikyDRz9VOxqC81EurK1v1
	IOePrLCvJXyD2OCjA1ebkxB6qlp/MSvJIo226k2ElbGdJqmJ2G5ZHAURwNQCX4Mz79GPw8hcddI
	6FsoJDEVxK/nsChfv2LetREoNFTrm3rQnkrMj5HhEiSjNYGq8U9QVEC49NfaBPEF+10suOzEQh5
	1w/iHnorghyPhe+PU9RscEpQzcfpSM0FyiWn/4E0f3dKzPAYul8w+fF7FfZeiK+d11cupsJX6L9
	rnVQVczIxeFV6VNhC3zLkVeaWmnqtaUm83SU0aCpqlTwyKwyiknkwACgrbYVlslUNqDSt3WoFen
	74PWO5MWvL4B3bibO1r0u9CdBUd3XmaelviYFXFv+8sNgOnLtRFJveKv2rSfWDGrG+NO1i5v77w
	aw0AuSP+uEFQA6SmboL7BbGBxnFXZ7FnTm004kSQJHrqVj2ir5c5IwIrCu/ZTXrWQ97Q5cscOXu
	Z3PBkidDW2E5n86sepGGH6J1B4wpMKHJM8cnmg6LUMhXDl09TnF
X-Received: by 2002:a17:902:e88f:b0:2ce:b7b7:30e3 with SMTP id d9443c01a7336-2d0ca9904femr310789315ad.17.1786170184385;
        Fri, 07 Aug 2026 23:23:04 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:f4e3:f7a5:b8dd:b3e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14dbedec6sm15790475ad.44.2026.08.07.23.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:23:03 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] KVM: x86: Check for invalid/obsolete root *after* making MMU pages available
Date: Sat,  8 Aug 2026 15:22:08 +0900
Message-ID: <20260808062208.522577-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Check for a "stale" page fault, i.e. for an invalid and/or obsolete root,
after making MMU pages available for the shadow MMU.  If reclaiming shadow
pages zaps an in-use root, i.e. marks it invalid, then KVM will attempt to
map memory into an invalid root.  On its own, populating an invalid root is
"fine", but because child shadow pages inherit their parent's role, any
children created during the map/fetch will be created as invalid pages,
thus violating KVM's invariant that invalid pages are never on the list of
active MMU pages.

Note, the underlying flaw has existed since KVM first started tracking
invalid roots in 2008 (commit 2e53d63acba7, "KVM: MMU: ignore zapped root
pagetables"), but the true badness only came along in 2020 (Linux 5.9)
with the invariant that invalid shadow pages can't be on the list of
active pages.

Note #2, inheriting role.invalid when creating child shadow pages is also
far from ideal; that flaw will be addressed separately.

Conflicts:
	arch/x86/kvm/mmu/mmu.c
	arch/x86/kvm/mmu/paging_tmpl.h

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Fixes: f95eec9bed76 ("KVM: x86/mmu: Don't put invalid SPs back on the list of active pages")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 2abd5287f08319fa35764566b15c6e22cb1068db)
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 arch/x86/kvm/mmu/mmu.c         | 11 ++++++-----
 arch/x86/kvm/mmu/paging_tmpl.h | 10 ++++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7785da8f0ad3..1f4d306e5c81 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4272,22 +4272,23 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 	orig_pfn = fault->pfn;
 
-	r = RET_PF_RETRY;
-
 	if (is_tdp_mmu_fault)
 		read_lock(&vcpu->kvm->mmu_lock);
 	else
 		write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault, mmu_seq))
-		goto out_unlock;
-
 	if (is_tdp_mmu_fault) {
 		r = kvm_tdp_mmu_map(vcpu, fault);
 	} else {
 		r = make_mmu_pages_available(vcpu);
 		if (r)
 			goto out_unlock;
+
+		if (is_page_fault_stale(vcpu, fault)) {
+			r = RET_PF_RETRY;
+			goto out_unlock;
+		}
+
 		r = __direct_map(vcpu, fault);
 	}
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 1c7d73b8081c..a048305e08dd 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -869,15 +869,17 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 	orig_pfn = fault->pfn;
 
-	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault, mmu_seq))
-		goto out_unlock;
-
 	r = make_mmu_pages_available(vcpu);
 	if (r)
 		goto out_unlock;
+
+	if (is_page_fault_stale(vcpu, fault)) {
+		r = RET_PF_RETRY;
+		goto out_unlock;
+	}
+
 	r = FNAME(fetch)(vcpu, fault, &walker);
 
 out_unlock:
-- 
2.55.0.654.g21b8a5bc05-goog

