Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD253E2ADB
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123303; cv=none; b=C5weJhB6Iwp+wWKXlzIw9GetMddL6NFUHxywvSwmGyTXBdr9sUszCaQgRk3wf9MN7+WJrsdy4m3hwlA6mYc94i1Zowu/jHayJUI0AqACDmmatLh7aZWvJx6orHJSZmEenXMScQSBCDYhBA1pqL2Iyesfn+ZbWmxRhq0hyC4LLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123303; c=relaxed/simple;
	bh=oM5HI+qaVHdRZnWhw54chIbBxPbAodj/cycDcbuM0KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZPQs1WlFzukkX9gmR55Nh2d3k6sIwfrFQIU8GS3+uV5UnJAHOFNpVGm6POofymSZPoF7nqyK6JCk1YgHnQ7M2QkXxKLz1qf5eFmvUdLg1G/8/w84edxu0Sv2SCPxGnKV+mWl+ZJR+PTzpQW6Yngv+jbvkL1Uxj28LEhW1TkQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT1UWkh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT1UWkh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F94E1F00893;
	Fri, 11 Sep 2026 10:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123301;
	bh=SPwd0XbKMGRRr1UTRGExADo0mgxqdz9glYAy1mAOLNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WT1UWkh0ZFvp1M+Jw1DUdXn+qeLkmemdxxrdiTi+RQzTn6+UEed0nAAESiq3sRNVB
	 hdUK9XYTCgdUZa7AtvfQjv+Ehfb6MXf7aD6X41W90Y2jIM8mAaCw6xLhOxhxHur/s7
	 FeKgRGwQ3mqYjgCBh7XTlKtqZO9lzITc24Hr7acVsGYN5he0DBTmF9lqsN7HrB8rh/
	 6fmS/3BcmxylYxwSagcU+msX2o9wnGvkxWOxx+IMcZKNHpSL79v7/HBwd67N64oQak
	 z5r/aLT3kRvwum9Sa+D3GNWB7szyaBP17dqx8IzIWos14zQKA98xQSyM447lh3Tj2r
	 GqpAPt3olzLeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 4/7] KVM: x86: Extract get/set MSR (list) ioctl logic to helpers
Date: Fri, 11 Sep 2026 06:41:33 -0400
Message-ID: <20260911104136.194961-4-sashal@kernel.org>
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
Stable-dep-of: a4b8acd428ba ("KVM: x86: Always initialize EFER reserved bits on vendor initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 135 ++++++++++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 894b6b5b125ec..14ba2476c5e45 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5014,6 +5014,61 @@ static int kvm_x86_dev_has_attr(struct kvm_device_attr *attr)
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
@@ -5021,32 +5076,9 @@ long kvm_arch_dev_ioctl(struct file *filp,
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
@@ -5074,30 +5106,11 @@ long kvm_arch_dev_ioctl(struct file *filp,
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
@@ -6181,6 +6194,20 @@ static int kvm_get_reg_list(struct kvm_vcpu *vcpu,
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
@@ -6285,18 +6312,12 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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

