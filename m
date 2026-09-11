Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A543304B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123294; cv=none; b=D0OkEj0hF+XtIM4LuxCvq+Lus1jcS2z2zGFaM7czo4eF4bZNjgCTv+OCMCd0GGw9L535JfzalVzrpcXt9m0ahqdpVkVKDc02vivFkMnbImaimK7hJT95mtvyuQe4iYTleNDhCc6lGjIIHXohgNplwaZtTWOS5m/6Id2muQO8nA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123294; c=relaxed/simple;
	bh=dS/ScemAf5D0SQoQmtdlyg6wBCgtGNCchXDeYllNhcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjDjypQcL4nV/O0woQ+MugZXJYBHWHN3qkO6WXKgG7aEt4MB5XYxSO/XP/Wg+QPeLn7RnSFpX6zaQ6tKlZSeKmWwhGmgo5RqSe0pUT5SIaZpP2Quw4/KmpzlMGLG2z2N34EGHERqf53/+kF21BsfbXWCNEN09xfdjr1KU13pvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDo15Zuw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDo15Zuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA1C1F00898;
	Fri, 11 Sep 2026 10:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123291;
	bh=KrFCtf4oLERZkRyTi5QV8rHUhrC4z+xFCrHlnRqiS5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WDo15ZuwwYXk6XgDANcVCyafTmALfPy7LonZRx6fUp6rxtc4dpVGe8e7FpO+tq0qz
	 6z6sERKyVZvL8B/iUy6KT77HtONa045Lp09a1pBiu6pnijly4SZZckqqyvswPJg0t5
	 mUWAyUnCxb7zT5c5FvkX/NIWooYhMtjN4lRjxS2D22yqg6KMz4+G5W9nFQ6J6y1ORB
	 zq862y/PKwUu1jxydSs/9D5tUI53fYKsBMi1fUJVk2JR05Et0ceUwWwNw5Fzja4A+R
	 jVl5dvi8X81n/1WhKCTnWlk/c1EoI5IzBDlMvCF7vTdhK8NK1fWVafnHAed1qcxwx1
	 CWseGrid4E9nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 7/9] KVM: x86: Expose several TSC helpers via x86.h for use by MSR code
Date: Fri, 11 Sep 2026 06:41:21 -0400
Message-ID: <20260911104123.189614-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104123.189614-1-sashal@kernel.org>
References: <2026090914-waviness-supermom-9b84@gregkh>
 <20260911104123.189614-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 9d13832ced63160ca67b6c72868b794cbcda556d ]

Begrudgingly move adjust_tsc_offset_{guest,host}() to x86.h as inlines,
and expose several other TSC helpers in anticipation of moving KVM's MSR
code to a dedicated msrs.c.  Unfortunately for KVM, several MSRs that KVM
emulates can affect TSC state.

Opportunistically drop a superfluous local "tsc_offset" variable, whose
existence causes checkpatch to complain about lack of a blank line.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260613000329.732085-14-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e62392bf39eb ("KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 22 +++-------------------
 arch/x86/kvm/x86.h | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e78dd0c9a066e..7c31ec98ba723 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2639,7 +2639,7 @@ u64 kvm_scale_tsc(u64 tsc, u64 ratio)
 	return _tsc;
 }
 
-static u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
+u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
 {
 	u64 tsc;
 
@@ -2680,7 +2680,7 @@ u64 kvm_calc_nested_tsc_multiplier(u64 l1_multiplier, u64 l2_multiplier)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_tsc_multiplier);
 
-static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset)
+void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset)
 {
 	if (vcpu->arch.guest_tsc_protected)
 		return;
@@ -2794,7 +2794,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	kvm_track_tsc_matching(vcpu, !matched);
 }
 
-static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
+void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 {
 	u64 data = user_value ? *user_value : 0;
 	struct kvm *kvm = vcpu->kvm;
@@ -2862,22 +2862,6 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
 }
 
-static inline void adjust_tsc_offset_guest(struct kvm_vcpu *vcpu,
-					   s64 adjustment)
-{
-	u64 tsc_offset = vcpu->arch.l1_tsc_offset;
-	kvm_vcpu_write_tsc_offset(vcpu, tsc_offset + adjustment);
-}
-
-static inline void adjust_tsc_offset_host(struct kvm_vcpu *vcpu, s64 adjustment)
-{
-	if (vcpu->arch.l1_tsc_scaling_ratio != kvm_caps.default_tsc_scaling_ratio)
-		WARN_ON(adjustment < 0);
-	adjustment = kvm_scale_tsc((u64) adjustment,
-				   vcpu->arch.l1_tsc_scaling_ratio);
-	adjust_tsc_offset_guest(vcpu, adjustment);
-}
-
 #ifdef CONFIG_X86_64
 
 static u64 read_tsc(void)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index b7e0f554f804f..fe6ecd1efdb14 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -345,6 +345,25 @@ uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm);
 bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
 int kvm_guest_time_update(struct kvm_vcpu *v);
 
+void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value);
+u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc);
+void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset);
+
+static inline void adjust_tsc_offset_guest(struct kvm_vcpu *vcpu,
+					   s64 adjustment)
+{
+	kvm_vcpu_write_tsc_offset(vcpu, vcpu->arch.l1_tsc_offset + adjustment);
+}
+
+static inline void adjust_tsc_offset_host(struct kvm_vcpu *vcpu, s64 adjustment)
+{
+	if (vcpu->arch.l1_tsc_scaling_ratio != kvm_caps.default_tsc_scaling_ratio)
+		WARN_ON(adjustment < 0);
+	adjustment = kvm_scale_tsc((u64) adjustment,
+				   vcpu->arch.l1_tsc_scaling_ratio);
+	adjust_tsc_offset_guest(vcpu, adjustment);
+}
+
 int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
-- 
2.53.0

