Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20A73C455C
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787392444; cv=none; b=H3bTaBHbX+WG1kDm64P6E6/87qHd6SWSOOcis1Liz8eQbhhPGbbJYx+pee2GtQL/qtFvT+TaEl/6hzMd6xI22BKMOKPNf2nbewk+CU6rnfqoFHdEbhXXKSgCk5Hg7XMAZzxtOo9N0OOU5/fqh49qxLFCY2zflZyvUnAO+A493DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787392444; c=relaxed/simple;
	bh=JkiYpsUShZAsY1TjWqWCJe4NOQB0f5121pa5w8xGrzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iM+MTqhtVTQnmG7bQ2KTAZypyf9et5bj0Zm4NDao/PZs67TApzi0Jn2eQNk04NCQmURYvnqfuacIXsAD0jYHCAHgK07e/yn8qf438qACbtXDModRstTaTIBippbrw8RLV/OI6a4+bL9Q5Tx28rlRDJCpa5U1sUndjD9njqioN5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wynl2c6E; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wynl2c6E"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso3366813a12.1
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787392438; x=1787997238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t0Fit0ozccWqcIUOha2+PzcipOyCFUk6rmWi2DZINrs=;
        b=Wynl2c6Ew/l3SIbwApLc4p2Gnvhh0iEsUfYpHrWL/fuUZkPb0DqI+Jzd+VzPGddCUv
         q1vjxy3OFxXmtv+w0Dm4uBFNZ80KkUdzpQaIDFh5jMR0wZMezZzgE9o0eZ1niFncNIp7
         giFtqbUFVK98o639LEun7Iq0mUamvlUU8bHMCSXCAfdsfs9RbO7ue6Wn+9V/K3OwCpud
         yK9ngMM4qbWWoE+gN6UfmmY3/XQolzDFrZm16uc9qhtA04WNjS3uUR8KdlSdYgYR2qrn
         q6guiwQuy7IdY8AevkA1I+KcqQHUp23ZHoD3dJg1HWu77hZu30vHzuYhTP6ckv45Qncp
         O0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787392438; x=1787997238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t0Fit0ozccWqcIUOha2+PzcipOyCFUk6rmWi2DZINrs=;
        b=QOsKAl4xixYlBk9CkADmM6lrWqZMxggMF/cGPnbuegjHcH29kh5xQhri7nSmwpZ3dz
         2a2Jp0lVFZyAdlMOheyFRM02KbpOBSybLBojUf0IUOAcOKZ9rFUNV8VofTHmxTCeo7et
         J2TI5YjpMxor7RJ81ZwaMP8U7dHGhayUJZTgXpqy9kOZ3f08GZQGEBmZUuUXtQU+IMtn
         qEZKjxHKxvVLsQSVnIrKERL8MhL0TimOZ2EIe8S8hqdbzp0qG5MXuVvHt2m/I31R+nkS
         g8Fy0G22h1ydZKjHDns4VNSlqeVsAv2HpkYS7p40TBQgGg6V7N+URoOc9zNZO+jTZTSR
         Sy6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqU3428kE5TuN0pg3rTxb5Rl1J3j4ZBD1ThUTNxMXbk8hnbJGDl92xwWqqgZihA9p51TwcuQJ4=@vger.kernel.org
X-Gm-Message-State: AFuF++kPO6mEryGir0HK8yYUdX3egOAsZ5GvUFpXTaBYexAKhFZLU8Si
	bdEkmyH9z071V9kpTBAHV2f05Y5grSWbaxwStnibOr8of8hOzyRBGY7V
X-Gm-Gg: AR+sD12ydZIonceXOXxqKCT3AXfCre80JZcUtRXHmdAYFdau3U48g2VngCadIstxUoY
	1X0l4P1KXKLqB7J9nsUXY6ogtOEtiX2upfsHRAkfag/yrTS8tz98aulnVd225LeG1kTI35CIT1C
	sH4EPNuZ22TtLbL4mzsjg/1xKiq4qpS7K8Eyx9jPRRZtYxRlQfdbz9Zyz3v0cyxXg6/VB9F7BFG
	z5Yzi77E6gPu9zDH1CaIfxjqrp6tDJAnHN4TjXceOf5HM7vDlqN75UWS+7RNmC3Q8kDsDKpHNiL
	aKfXD+zQDPB1SvIvvUTN+GfbnRxuRjntobIXi11EY30MjJ44oF1nTnpG5cVXMKWkmHNVk4rKCFd
	QQLdh32QDCuDIxcPepikDH76kpXNrgcuqgaFbL9qxMiqXxIdhso5cJr4phtl3iEc9zqmGo/xUw1
	4C1dFaIikSRz0/uHiz52OzZ6SEWycNNcS9afE57STcgWtAVYpdjx7VOTec6/0Mf7vU3sK9F8/bP
	+aCnHFux/qz7p7hQS4QoZtIJ2KqXmpIqDCKBx55nZy5eXF3BP4XLrlmF5KSBztz+XCEijScTySO
	kFF8iesGbNzph8PVCsYaAFEZbgtdVKpZIPfyk8hMEDkwWfj//M5IvoliIwwhdSWn0MmRiw==
X-Received: by 2002:a05:6402:2186:b0:6a1:2400:baea with SMTP id 4fb4d7f45d1cf-6a42f18a70cmr11760162a12.10.1787392437812;
        Sat, 22 Aug 2026 02:53:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c327asm11151586a12.8.2026.08.22.02.53.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 02:53:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/5] KVM: arm64: vgic-v3: Reset redistributors after failed region setup
Date: Sat, 22 Aug 2026 11:53:43 +0200
Message-Id: <20260822095346.53882-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260822095346.53882-1-kmehltretter@gmail.com>
References: <20260822095346.53882-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A REDIST_REGION write can fail after redistributor iodevs have been
registered. The existing rollback unregisters only vCPUs processed before
the failure, leaving their cached assignments and free_index values intact.
A retry then skips the unregistered iodevs.

Userspace has no guarantee that redistributor assignments survive a failed
region update. On failure, unregister every redistributor iodev and clear
every cached vCPU assignment. Reset all region free_index values and free
the newly inserted region. The next successful region update rebuilds all
possible assignments in region-index order.

While a vCPU is being created, its redistributor iodev may be registered
before the vCPU is visible to kvm_for_each_vcpu(). Reject REDIST and
REDIST_REGION writes while creation is in flight, so rollback can reset every
assignment.

The registration failure for the current vCPU is already undone by
vgic_register_redist_iodev().

Fixes: c011f4ea106b ("KVM: arm/arm64: Check vcpu redist base before registering an iodev")
Suggested-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-kvm-device.c | 20 ++++++++++
 arch/arm64/kvm/vgic/vgic-mmio-v3.c    | 53 +++++++++++++++++++--------
 2 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-kvm-device.c b/arch/arm64/kvm/vgic/vgic-kvm-device.c
index 90be99443df3..48c3b2a48c20 100644
--- a/arch/arm64/kvm/vgic/vgic-kvm-device.c
+++ b/arch/arm64/kvm/vgic/vgic-kvm-device.c
@@ -97,6 +97,9 @@ static int kvm_vgic_addr(struct kvm *kvm, struct kvm_device_attr *attr, bool wri
 	phys_addr_t *addr_ptr, alignment, size;
 	u64 undef_value = VGIC_ADDR_UNDEF;
 	u64 addr;
+	bool redist_write = write &&
+		(attr->attr == KVM_VGIC_V3_ADDR_TYPE_REDIST ||
+		 attr->attr == KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION);
 	int r;
 
 	/* Reading a redistributor region addr implies getting the index */
@@ -104,6 +107,19 @@ static int kvm_vgic_addr(struct kvm *kvm, struct kvm_device_attr *attr, bool wri
 		if (get_user(addr, uaddr))
 			return -EFAULT;
 
+	/*
+	 * A vCPU can have an RD assignment before it is visible to
+	 * kvm_for_each_vcpu(). Reject redistributor updates while vCPU creation
+	 * is in progress, so rollback can reset every assignment.
+	 */
+	if (redist_write) {
+		mutex_lock(&kvm->lock);
+		if (kvm->created_vcpus != atomic_read(&kvm->online_vcpus)) {
+			r = -EBUSY;
+			goto out_unlock_kvm;
+		}
+	}
+
 	/*
 	 * Since we can't hold config_lock while registering the redistributor
 	 * iodevs, take the slots_lock immediately.
@@ -201,6 +217,10 @@ static int kvm_vgic_addr(struct kvm *kvm, struct kvm_device_attr *attr, bool wri
 out:
 	mutex_unlock(&kvm->slots_lock);
 
+out_unlock_kvm:
+	if (redist_write)
+		mutex_unlock(&kvm->lock);
+
 	if (!r && !write)
 		r =  put_user(addr, uaddr);
 
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 22897ce64dbf..6c009deb11d4 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -855,6 +855,40 @@ void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
 	kvm_io_bus_unregister_dev(vcpu->kvm, KVM_MMIO_BUS, &rd_dev->dev);
 }
 
+static void vgic_reset_redist_iodev(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+
+	lockdep_assert_held(&vcpu->kvm->arch.config_lock);
+
+	vgic_cpu->rdreg = NULL;
+	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+}
+
+static void vgic_v3_rollback_redist_region(struct kvm *kvm, u32 index)
+{
+	struct vgic_redist_region *rdreg, *iter;
+	struct kvm_vcpu *vcpu;
+	unsigned long c;
+
+	lockdep_assert_held(&kvm->slots_lock);
+
+	rdreg = vgic_v3_rdist_region_from_index(kvm, index);
+
+	kvm_for_each_vcpu(c, vcpu, kvm)
+		vgic_unregister_redist_iodev(vcpu);
+
+	guard(mutex)(&kvm->arch.config_lock);
+
+	kvm_for_each_vcpu(c, vcpu, kvm)
+		vgic_reset_redist_iodev(vcpu);
+
+	list_for_each_entry(iter, &kvm->arch.vgic.rd_regions, list)
+		iter->free_index = 0;
+
+	vgic_v3_free_redist_region(kvm, rdreg);
+}
+
 static int vgic_register_all_redist_iodevs(struct kvm *kvm)
 {
 	struct kvm_vcpu *vcpu;
@@ -869,16 +903,6 @@ static int vgic_register_all_redist_iodevs(struct kvm *kvm)
 			break;
 	}
 
-	if (ret) {
-		/* The current c failed, so iterate over the previous ones. */
-		int i;
-
-		for (i = 0; i < c; i++) {
-			vcpu = kvm_get_vcpu(kvm, i);
-			vgic_unregister_redist_iodev(vcpu);
-		}
-	}
-
 	return ret;
 }
 
@@ -986,6 +1010,8 @@ int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 {
 	int ret;
 
+	lockdep_assert_held(&kvm->lock);
+
 	mutex_lock(&kvm->arch.config_lock);
 	ret = vgic_v3_alloc_redist_region(kvm, index, addr, count);
 	mutex_unlock(&kvm->arch.config_lock);
@@ -998,12 +1024,7 @@ int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 	 */
 	ret = vgic_register_all_redist_iodevs(kvm);
 	if (ret) {
-		struct vgic_redist_region *rdreg;
-
-		mutex_lock(&kvm->arch.config_lock);
-		rdreg = vgic_v3_rdist_region_from_index(kvm, index);
-		vgic_v3_free_redist_region(kvm, rdreg);
-		mutex_unlock(&kvm->arch.config_lock);
+		vgic_v3_rollback_redist_region(kvm, index);
 		return ret;
 	}
 
-- 
2.39.5 (Apple Git-154)

