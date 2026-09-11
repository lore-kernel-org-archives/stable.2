Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C041228D
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123293; cv=none; b=alsciWxie4xlztpP03zeMKSMHvCbq8yQwZn6T3REuk7hM/9plEJZm/sDf1dhtds2BpJfIBtxWEe0bNsGf9n48AG2iWF/z1amfIagIkugA4h7fjqyuZ5jZ+90ijq3a0EuSRGx1Gu9u6pHDs98oKAaKmbATb2mijNpwDpKrmI+lZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123293; c=relaxed/simple;
	bh=wi1WUKnXi8rveko8eBC0Pfr0S7x1Rs6QXEjcG4xeM2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPaF8lm4QEDaBfabgJ3NZ/wHfbZ2gEUr5/gyqlS2atGC1WhzFzHkHe78/Jecdfg3RczA7Tgg+HzptWBrrEyZVzqDceB4da3+Vn5Zldwa02Vknfe4WDagRS2NBmHOMJWyQqgjU4X7pfxmgMQ3srnnm6n/bSAoA6GsRT1k8Wi36hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivyVwL1b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivyVwL1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CCF1F00893;
	Fri, 11 Sep 2026 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123291;
	bh=Vj1EChAAX97RoWanTbbkoZPZTjmCL+v0EotWRC/t+HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ivyVwL1b+QZadN4uRHwI3KQ99oVIUk02+r3oZyrDFICKgZE2VP99JMsDOS3wlBxh1
	 c0pBPYTt1op0VFTlOTor4HNw0eO3xLYZANFLqtHP4KYGdgP4vmXbvzI1Ac9cpxC4Kn
	 ERxrBTdAktvkG+FlFq4l9UYacbZ/5iAoXBkU/fbvdmPkqcxzGmx0s+rj/hC30h3V+R
	 F6cl2zwmY6OqRgLr/Md2E+CRAhGf26XRMVWu1i6j7jIsd9luU0qtLpBVMESjKXbBSX
	 /KXQntCVD18UJuMXOEj0KCv9c2ueKpbOfJQsbHwQrPBobzp/uzoLRH6dHKP9F8IBw4
	 +iCyI+i/yPWaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 6/9] KVM: x86: Extract get/set MSR (list) ioctl logic to helpers
Date: Fri, 11 Sep 2026 06:41:20 -0400
Message-ID: <20260911104123.189614-6-sashal@kernel.org>
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

[ Upstream commit 57412a311f8f575a97b64fdc46c9a45a40076559 ]

Extract the code for getting/setting MSRs and MSR lists to dedicated
helpers in anticipation of moving the MSR code to a new msrs.c.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Message-ID: <20260613000329.732085-13-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e62392bf39eb ("KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 135 ++++++++++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6c27b4aa98743..e78dd0c9a066e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5016,6 +5016,61 @@ static int kvm_x86_dev_has_attr(struct kvm_device_attr *attr)
 	return __kvm_x86_dev_get_attr(attr, &val);
 }
 
+static int kvm_get_msr_index_list(struct kvm_msr_list __user *user_msr_list)
+{
+	struct kvm_msr_list msr_list;
+	unsigned int n;
+
+	if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
+		return -EFAULT;
+
+	n = msr_list.nmsrs;
+	msr_list.nmsrs = num_msrs_to_save + num_emulated_msrs;
+	if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
+		return -EFAULT;
+
+	if (n < msr_list.nmsrs)
+		return -E2BIG;
+
+	if (copy_to_user(user_msr_list->indices, &msrs_to_save,
+			 num_msrs_to_save * sizeof(u32)))
+		return -EFAULT;
+
+	if (copy_to_user(user_msr_list->indices + num_msrs_to_save,
+			 &emulated_msrs, num_emulated_msrs * sizeof(u32)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int kvm_get_feature_msr_index_list(struct kvm_msr_list __user *user_msr_list)
+{
+	struct kvm_msr_list msr_list;
+	unsigned int n;
+
+	if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
+		return -EFAULT;
+
+	n = msr_list.nmsrs;
+	msr_list.nmsrs = num_msr_based_features;
+	if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
+		return -EFAULT;
+
+	if (n < msr_list.nmsrs)
+		return -E2BIG;
+
+	if (copy_to_user(user_msr_list->indices, &msr_based_features,
+			 num_msr_based_features * sizeof(u32)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int kvm_get_feature_msrs(struct kvm_msrs __user *user_msrs)
+{
+	return msr_io(NULL, user_msrs, do_get_feature_msr, 1);
+}
+
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg)
 {
@@ -5023,32 +5078,9 @@ long kvm_arch_dev_ioctl(struct file *filp,
 	long r;
 
 	switch (ioctl) {
-	case KVM_GET_MSR_INDEX_LIST: {
-		struct kvm_msr_list __user *user_msr_list = argp;
-		struct kvm_msr_list msr_list;
-		unsigned n;
-
-		r = -EFAULT;
-		if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
-			goto out;
-		n = msr_list.nmsrs;
-		msr_list.nmsrs = num_msrs_to_save + num_emulated_msrs;
-		if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
-			goto out;
-		r = -E2BIG;
-		if (n < msr_list.nmsrs)
-			goto out;
-		r = -EFAULT;
-		if (copy_to_user(user_msr_list->indices, &msrs_to_save,
-				 num_msrs_to_save * sizeof(u32)))
-			goto out;
-		if (copy_to_user(user_msr_list->indices + num_msrs_to_save,
-				 &emulated_msrs,
-				 num_emulated_msrs * sizeof(u32)))
-			goto out;
-		r = 0;
+	case KVM_GET_MSR_INDEX_LIST:
+		r = kvm_get_msr_index_list(argp);
 		break;
-	}
 	case KVM_GET_SUPPORTED_CPUID:
 	case KVM_GET_EMULATED_CPUID: {
 		struct kvm_cpuid2 __user *cpuid_arg = argp;
@@ -5076,30 +5108,11 @@ long kvm_arch_dev_ioctl(struct file *filp,
 			goto out;
 		r = 0;
 		break;
-	case KVM_GET_MSR_FEATURE_INDEX_LIST: {
-		struct kvm_msr_list __user *user_msr_list = argp;
-		struct kvm_msr_list msr_list;
-		unsigned int n;
-
-		r = -EFAULT;
-		if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
-			goto out;
-		n = msr_list.nmsrs;
-		msr_list.nmsrs = num_msr_based_features;
-		if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
-			goto out;
-		r = -E2BIG;
-		if (n < msr_list.nmsrs)
-			goto out;
-		r = -EFAULT;
-		if (copy_to_user(user_msr_list->indices, &msr_based_features,
-				 num_msr_based_features * sizeof(u32)))
-			goto out;
-		r = 0;
+	case KVM_GET_MSR_FEATURE_INDEX_LIST:
+		r = kvm_get_feature_msr_index_list(argp);
 		break;
-	}
 	case KVM_GET_MSRS:
-		r = msr_io(NULL, argp, do_get_feature_msr, 1);
+		r = kvm_get_feature_msrs(argp);
 		break;
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_GET_SUPPORTED_HV_CPUID:
@@ -6183,6 +6196,20 @@ static int kvm_get_reg_list(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static int kvm_get_msrs(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs)
+{
+	guard(srcu)(&vcpu->kvm->srcu);
+
+	return msr_io(vcpu, user_msrs, do_get_msr, 1);
+}
+
+static int kvm_set_msrs(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs)
+{
+	guard(srcu)(&vcpu->kvm->srcu);
+
+	return msr_io(vcpu, user_msrs, do_set_msr, 0);
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
@@ -6287,18 +6314,12 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
-	case KVM_GET_MSRS: {
-		int idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = msr_io(vcpu, argp, do_get_msr, 1);
-		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	case KVM_GET_MSRS:
+		r = kvm_get_msrs(vcpu, argp);
 		break;
-	}
-	case KVM_SET_MSRS: {
-		int idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = msr_io(vcpu, argp, do_set_msr, 0);
-		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	case KVM_SET_MSRS:
+		r = kvm_set_msrs(vcpu, argp);
 		break;
-	}
 	case KVM_GET_ONE_REG:
 	case KVM_SET_ONE_REG:
 		r = kvm_get_set_one_reg(vcpu, ioctl, argp);
-- 
2.53.0

