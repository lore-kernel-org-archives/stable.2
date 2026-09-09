Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745C2526AB6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950553; cv=none; b=mSH4HfyEwRYdt/PzQiwQbGURHaXrh2Bh6DtA/p3MwjEIv6hWzZajOjgClLFtR4TQTNexXNdLqAqHtoV2LevU64n3XDCFJLTdU5RNPrGCBgxDapIr0obrt7YafAm9RPzQqCIKyhNLygCLv4PqwEjdZ895OaIGPJn4QikdJoywSsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950553; c=relaxed/simple;
	bh=omax+hk4MzpOpXGQE79hyGggRaEmJcyuszZaTNvbneU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HXhTe8ZvnysuOcjj6E8h3exyXG1mIwg/jB4WCGhehhD0UyRiyapxd7KGFZlgFzv5MWFZky1fkCtxVdbvYBHkdi03hBV1HRLww8O5MpgxTsfCV292b31ijX/zDN1GRxwcSDucwABNdtGK+dY0cAjJ8gnTsz5mjaHnuE6cd/q+CYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J6VNXnlu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J6VNXnlu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C266C1F00A3A;
	Wed,  9 Sep 2026 10:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950552;
	bh=esKG4No0XX1UXRDW9g/CANF1WWZc81kOyjPPeqd6LEQ=;
	h=Subject:To:Cc:From:Date;
	b=J6VNXnlujKKZJRKB+t3AoiRj/b7rYukJ2p+HbXfk2bAzae0R8iAPxA1Xj22uvhQ98
	 Ru/7Bm9itVsoPipCXPMd2Pq2tdz3k1ambBEel6kUtrWXLekgruHQePHaX7TLH3M/4x
	 z3ihsQ/fWLNzjFcwN5m6HJNmvgKhNJJh3VFfynyI=
Subject: FAILED: patch "[PATCH] KVM: x86: Always initialize EFER reserved bits on vendor" failed to apply to 6.18-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:32:07 +0200
Message-ID: <2026090907-raving-uncanny-528d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a4b8acd428ba3f03952ef309d7f438dbc357557b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090907-raving-uncanny-528d@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a4b8acd428ba3f03952ef309d7f438dbc357557b Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 13 Jul 2026 18:10:18 +0000
Subject: [PATCH] KVM: x86: Always initialize EFER reserved bits on vendor
 initialization

EFER reserved bits are statically initialized, and do not reset if a
vendor module is re-loaded. For example, loading kvm_amd with nested=1
removes EFER.SVME (and potentially EFER.LMSLE) from the reserved bits.
Reloading kvm_amd with nested=0 does not add them back, allowing
userspace to set EFER.SVME with nested=0.

Re-initializing EFER reserved bits before configuring them on vendor
initialization.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260713181020.2735367-4-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 67481429ad6b..a7394bdae029 100644
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
index 9c5c6b33e58f..1f772e171758 100644
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
index 0845551c6cab..cf5fa038ff17 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6910,6 +6910,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_setup_xss_caps);
 
 static void kvm_setup_efer_caps(void)
 {
+	kvm_init_efer_bits();
+
 	if (kvm_cpu_cap_has(X86_FEATURE_LM))
 		kvm_enable_efer_bits(EFER_LME | EFER_LMA);
 

