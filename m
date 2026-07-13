Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1C35201A;
	Mon, 13 Jul 2026 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966230; cv=none; b=gSvBPwgsH5pA5E956od1SeI254sygMIHd9PJr6r3TnU2wU3nkCJma8fi2KVeh00BHTRyw6of99xqOcdlzOgZe6VryAfw5n6nGLHt1VozoVQj0ihzgTQHSDAf9evrFSysroWzXr+qotQbsB8nHHIWUueNiOzLQMSaB7f3b0ui14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966230; c=relaxed/simple;
	bh=IDqxay3NTB4CCLgYPJY66JPKcvOLrwrNCqZ0HbvZ75E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deo1OdZNk0/+GjKKlACOkOu6w/2Qq2jN9oDt0okhEFDWSYWTd0oaxqVSfK/BRfK8VlGVY6Viy32NFxgYYtPo3M8u7FVU8HEI/nnsLmLsph3IrPwySjPIViqnb0QJJmE0JGZgK6cUeB9WVl7y2fEFJ9ZXTGGUOgPVH6wEn5xus5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tf7aWMwD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf7aWMwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F821F00A3E;
	Mon, 13 Jul 2026 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966229;
	bh=vzhwlEbKTgZAWFKcMtzkcmv3HB8/WBKsAoQsDcJh8r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tf7aWMwDbRRaTXcFMO3xahCA/yefHkm/0pAexF+k6S/M3jAoXoLZFRtbKME9d4+2k
	 rWcdHgtk1U3MIwvkEMcD85/KPi/ftnrJoihwoY0zJubF9M5sl2GM6mpezFJ5p4KP4G
	 6Iv3SFpXZbsAlTeUV5FqEwve6rdXZ32Mumhx22Trv/E3YJo2aimoWIXdYENu/eBeXB
	 FtnJVvHpPUPa3VVnkTq/gc/zFsAwfwYeWZ+o4S198wFOOPMJS18G0SYjSY6I9hKm7X
	 kAlNeFp1GvYFPZcLIo9Qqb/neU7SuPRERpqa+n8HR1n8pez4D1OEdGXnmWY7YH+iE3
	 233A5Dcxrvo3w==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/5] KVM: x86: Always initialize EFER reserved bits on vendor initialization
Date: Mon, 13 Jul 2026 18:10:18 +0000
Message-ID: <20260713181020.2735367-4-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260713181020.2735367-1-yosry@kernel.org>
References: <20260713181020.2735367-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EFER reserved bits are statically initialized, and do not reset if a
vendor module is re-loaded. For example, loading kvm_amd with nested=1
removes EFER.SVME (and potentially EFER.LMSLE) from the reserved bits.
Reloading kvm_amd with nested=0 does not add them back, allowing
userspace to set EFER.SVME with nested=0.

Re-initializing EFER reserved bits before configuring them on vendor
initialization.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/msrs.c | 10 ++++++++--
 arch/x86/kvm/msrs.h |  1 +
 arch/x86/kvm/x86.c  |  2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 67481429ad6b8..a7394bdae0295 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -19,8 +19,7 @@ bool __read_mostly report_ignored_msrs = true;
 module_param(report_ignored_msrs, bool, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(report_ignored_msrs);
 
-/* Enable syscall by default because its emulated by KVM */
-static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
+static u64 __read_mostly efer_reserved_bits;
 
 #define MAX_IO_MSRS 256
 
@@ -650,6 +649,13 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 0;
 }
 
+void kvm_init_efer_bits(void)
+{
+	/* Enable syscall by default because its emulated by KVM */
+	efer_reserved_bits = ~((u64)EFER_SCE);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_efer_bits);
+
 void kvm_enable_efer_bits(u64 mask)
 {
        efer_reserved_bits &= ~mask;
diff --git a/arch/x86/kvm/msrs.h b/arch/x86/kvm/msrs.h
index 9c5c6b33e58f5..1f772e1717588 100644
--- a/arch/x86/kvm/msrs.h
+++ b/arch/x86/kvm/msrs.h
@@ -58,6 +58,7 @@ int kvm_get_set_one_reg(struct kvm_vcpu *vcpu, unsigned int ioctl,
 int kvm_get_reg_list(struct kvm_vcpu *vcpu,
 		     struct kvm_reg_list __user *user_list);
 
+void kvm_init_efer_bits(void);
 void kvm_enable_efer_bits(u64);
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
 int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f68424a985cda..83f608dad0605 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6913,6 +6913,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_setup_xss_caps);
 
 static void kvm_setup_efer_caps(void)
 {
+	kvm_init_efer_bits();
+
 	if (kvm_cpu_cap_has(X86_FEATURE_LM))
 		kvm_enable_efer_bits(EFER_LME | EFER_LMA);
 
-- 
2.55.0.141.g00534a21ce-goog

