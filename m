Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A632B127;
	Tue, 30 Jun 2026 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863244; cv=none; b=FsgbH2phLmkx5MZSImLlzujsNhUsTUHH2V65rmgba2YWrjT/eXxZ1rmNgN8/B1RmYa0+udkKgdCs//+ib6vIPfhDym0mZiigONArCQe74Gfrj525EorJVMNmGxsKW7pLFrmwQuz1zKsJoD4dOzglTIz5YbIA9CPuhDK3GoZn/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863244; c=relaxed/simple;
	bh=ziZ0VY+k2nYvA2E6+rpgJ9jFYYtLYJIUH7M24UCuT/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUOQCk3ENMcz+8iHgCpJmOXu5bGMtqFadCr5zyFmI6F20wGJs11hUwZiippLZqaYIV14xFNFG8PCy7WhwbmAuEsmijDAf81YwZBIqni1VZ6NjCYbGJNyx8+K8HGguUuPl3KwX7/b6YUBN0w1dyVhamOCr9FSx2/zdcZpTH3Yiqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJmyNgln; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJmyNgln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B911F00A3E;
	Tue, 30 Jun 2026 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863242;
	bh=GwPuPzC8V9+z1YHScfEDt0U/4ZsW2Xdlun/suokXWlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LJmyNgln77AeB2+m1lbDx17C+mHWGDLVaYJw9YaCvK96nYb0bJYYQXCKen8AbLYtc
	 SnrkQzJdTjBHHddDUEjhw/kf9nc5DHGjgCCFz2MXPDRqHu0pULwO3C+cuTqviugdWo
	 QbKi6OGm6TJsS8IcS1HILi8nHH3cUyLkc2e0sU04n1GNTKb9wIEFin9vAiRDb/MYS8
	 92bd2SZsrWNrxOHxM7uwq8Qrecy99sMF5MXvBYQXpSNVYuk3znL3QY63rbGQbZvYaw
	 laR2XsOxPt7FlyyiChn/7E5paxZzO0xiiK99FAJoTMIOjtG2KysUVom9st8rbah3zK
	 QCjq6z7VKRNyA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/7] KVM: SVM: Disallow EFER.SVME and EFER.LSMLE if nested is disabled
Date: Tue, 30 Jun 2026 23:47:10 +0000
Message-ID: <20260630234716.3039031-3-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260630234716.3039031-1-yosry@kernel.org>
References: <20260630234716.3039031-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly disallow setting EFER.SVME and EFER.LSMLE if nested
virtualization is disabled on SVM, to prevent the bits remaining allowed
if kvm_amd is loaded with nested=1 and then reloaded with nested=0.

This is a minimal fix for the benefit of stable backports, which will be
followed by a more systematic fix (moving efer_reserved_bits to
kvm_caps).

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/msrs.c    | 8 +++++++-
 arch/x86/kvm/msrs.h    | 1 +
 arch/x86/kvm/svm/svm.c | 3 +++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c230b18d87e38..45170df0ce40b 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -660,10 +660,16 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 void kvm_enable_efer_bits(u64 mask)
 {
-       efer_reserved_bits &= ~mask;
+	efer_reserved_bits &= ~mask;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_enable_efer_bits);
 
+void kvm_disable_efer_bits(u64 mask)
+{
+	efer_reserved_bits |= mask;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_disable_efer_bits);
+
 bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type)
 {
 	struct kvm_x86_msr_filter *msr_filter;
diff --git a/arch/x86/kvm/msrs.h b/arch/x86/kvm/msrs.h
index b698983e37fb6..89f10447cdddf 100644
--- a/arch/x86/kvm/msrs.h
+++ b/arch/x86/kvm/msrs.h
@@ -59,6 +59,7 @@ int kvm_get_reg_list(struct kvm_vcpu *vcpu,
 		     struct kvm_reg_list __user *user_list);
 
 void kvm_enable_efer_bits(u64);
+void kvm_disable_efer_bits(u64);
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
 int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
 int kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f9..1d51500238462 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5645,6 +5645,9 @@ static __init int svm_hardware_setup(void)
 		r = nested_svm_init_msrpm_merge_offsets();
 		if (r)
 			return r;
+	} else {
+		kvm_disable_efer_bits(EFER_SVME);
+		kvm_disable_efer_bits(EFER_LMSLE);
 	}
 
 	/*
-- 
2.55.0.rc0.799.gd6f94ed593-goog

