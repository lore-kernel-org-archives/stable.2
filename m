Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF433D331A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123304; cv=none; b=RT0Ob5OBu9r3METKdf+VR5NUbtv+UkBm6WN0uSG7SRtiopArg16OkKJQAwUG5bDDRciV9Nbcq61RoOOsXcIeBzcGffpcJWAArX+AhcZuyJTL/L1+o9d6nJOt0sav8xgaae/I4jpiRK37/SiluU8rYZhIuNA6FXmESADZjbJEhZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123304; c=relaxed/simple;
	bh=CH2GDLqFhtZkB4RI4Wgu/lZJ2LG3Yxao+GL8UF6pGLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCau+V1gnwv5S7ZyPuALeasdZsluheCphEBtjqZRtyA1avb4e9GzzCkELXGSlYGgdPH/PwkotEl/IO4XZdczHdhfcjulw/R+MDzyZfdwkWVnBlOn0i23tdM9JPfyoBKN8uaXzbi0puwgOr6TLvvXP+w9pmUtzE5rGujbkddKkgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8ECJ9xf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8ECJ9xf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4DE1F000FF;
	Fri, 11 Sep 2026 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123302;
	bh=3bAd7Wxcr4vz6SfqJmFuHYtwiQekLgh9epHDk5KfV6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j8ECJ9xf9UjEdw1lKvEOP93Q9Pk9jq+iuIPXuCfNncQ0ZeXtrRtIXLrY8J+Mx6Wn3
	 8IR3R1vAnBj4nZkyYhBDb32fB+NvlgKAxrN1GTwv6T7x93xbVKNVlFAsQ75IH6lZW+
	 TflVtuXOLv3ho0LTF7ZVh3QXRaUCCNiYAzSgGJMc5Z8Vdd78iKm0Teoysy/TD9VRNg
	 fRCq4ev1F/54Dw63Pu+dWgIOi6HXPzOlpVfsB9r4JfLDfqVuvmcZVYMjAWt72Xzb5H
	 ahpkE4dsqqCSHkMXnI+ePHflA+DoqbtPj9Ouzd8KqSTNqqvkWnRL8hRvwRiHM0Nba3
	 1RkC5em1oj1Kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 5/7] KVM: x86: Expose several TSC helpers via x86.h for use by MSR code
Date: Fri, 11 Sep 2026 06:41:34 -0400
Message-ID: <20260911104136.194961-5-sashal@kernel.org>
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
Stable-dep-of: a4b8acd428ba ("KVM: x86: Always initialize EFER reserved bits on vendor initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 22 +++-------------------
 arch/x86/kvm/x86.h | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 14ba2476c5e45..a3b8f67e9fb79 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2637,7 +2637,7 @@ u64 kvm_scale_tsc(u64 tsc, u64 ratio)
 	return _tsc;
 }
 
-static u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
+u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
 {
 	u64 tsc;
 
@@ -2678,7 +2678,7 @@ u64 kvm_calc_nested_tsc_multiplier(u64 l1_multiplier, u64 l2_multiplier)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_tsc_multiplier);
 
-static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset)
+void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset)
 {
 	if (vcpu->arch.guest_tsc_protected)
 		return;
@@ -2792,7 +2792,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	kvm_track_tsc_matching(vcpu, !matched);
 }
 
-static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
+void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 {
 	u64 data = user_value ? *user_value : 0;
 	struct kvm *kvm = vcpu->kvm;
@@ -2860,22 +2860,6 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
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
index 65003b2dd1b19..73af2c17d6dfb 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -391,6 +391,25 @@ uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm);
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

