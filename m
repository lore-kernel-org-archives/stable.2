Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989921;
	b=ndD9ch1LEhCqGiqkznvhfDVEbt6vh3cGAiTc02NLx4L1ZH9XIZtGCfEI6C8oFaNgwsT5
	 hv9Up4ewvjtgGr7N20P45I81TlaWcoXWhvyT4olR8eF/jtsY4ty95kE/4WyP4XorYiCSK
	 Pqnxw2KeCgo1FAF7rhZAde/YG1bszeJSH15vD0BbAMpSq9pdMJY+WEK1B4QyK76mQ+YmI
	 /dx940WDJ179DWcYuuyQwfrTw/bNuRooWhBb8ZXPNpluWY4JTmqfn7LHAW01XOQAqb5kW
	 qEttRuSE9W0J4L4VI2OkSBnVsqV2bhxfF/LtAFBvHv4z35/ixH715AY+ybc0K+9x4Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989921;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HmaZ4Psp27d2G47+NkoABJyAh37GpTuzTWDBQEHhSPE=;
	b=wSfAqiDvXm8wHT26lFKbWP4lOS58ekvoc1dngkPOqrFQC2090wsDN56RV9hnaYSspgnD
	 Ii0322G4iEaRmo5h5sr/aFhSVUcjCdNxl2B4Fi7BMLE3q81n8KfEXYmo1KAHeT0fkyAD+
	 zWmOgCtMHfDoS9BDNlun2fWHrGAyYsKELVapj+ef/A5/SmBXJSYsJQ4wvDIrBj+89aE0U
	 uSKALhWvsWFiTgnayKMNhyDAKqGH9d1xFFtgVXKcTIiMgXdY3GJ8dOxZtHYax1G4Ad4wF
	 g9gca9ukEy8xuu7XBbGFHvvq8aPacRz89pzMY0i6DCbStZmkE8hMZ0MctSUp1JNWDOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJ+BJuL6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5C606A329;
	Fri,  6 Nov 2026 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJ+BJuL6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2431F008A3;
	Fri,  6 Nov 2026 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989921;
	bh=HmaZ4Psp27d2G47+NkoABJyAh37GpTuzTWDBQEHhSPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QJ+BJuL6h+sj+cemaml6/z9FJazHbjqxX5efdm2kcTBuK4xPuyUnFUvre4lrUrNZU
	 TNp1tOF3PmDY+2dlGpZSipw5C9qOAIPjGA3aZT6M+5OKlEYvpzs0MkvwrXr5IjWnPr
	 HWBLB0qLpNcALDWpOMdE9qYyhtCUdtCS0l5vKOA0m6t/M7zAEOmHQJY8C0hoFmo9/v
	 2xo+88G78ZttpQ24629c5CQatVEt7D2lErAmICBWPcrltvhJX3tFpvh9QKXab9HwJj
	 bDvt2TyaoXv9JAPMekT1OubdB7NUMxi7JdOLHGRiPplqoKyyMPo4en0MYXuRGvgEe3
	 dHmes0gydTiHQ==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/8] KVM: arm64: nv: Disallow KVM_CAP_ARM_MTE + FEAT_EL2
Date: Fri,  6 Nov 2026 10:31:47 -0800
Message-ID: <20261106183154.3590825-2-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106183154.3590825-1-oupton@kernel.org>
References: <20261106183154.3590825-1-oupton@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM's nested implementation already hides FEAT_MTE and its laundry list
of derivatives from an NV guest. While good, this is insonsistent with
the UAPI which does not explicitly prevent the combination of MTE and
NV.

Bite the bullet and refuse to create a nested VM if KVM_CAP_ARM_MTE has
been enabled.

Cc: stable@vger.kernel.org
Fixes: a7484c80e5ca ("KVM: arm64: Allow userspace to request KVM_ARM_VCPU_EL2*")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 Documentation/virt/kvm/api.rst |  1 +
 arch/arm64/kvm/arm.c           | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e95c9cda085d..4ce4166d415f 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3602,6 +3602,7 @@ Possible features:
 	- KVM_ARM_VCPU_HAS_EL2: Enable Nested Virtualisation support,
 	  booting the guest from EL2 instead of EL1.
 	  Depends on KVM_CAP_ARM_EL2.
+          Cannot be enabled if KVM_CAP_ARM_MTE has been enabled for the VM.
 	  The VM is running with HCR_EL2.E2H being RES1 (VHE) unless
 	  KVM_ARM_VCPU_HAS_EL2_E2H0 is also set.
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 157bf4b81202..4108ff30830c 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -480,7 +480,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = cpus_have_final_cap(ARM64_HAS_32BIT_EL1);
 		break;
 	case KVM_CAP_ARM_EL2:
-		r = cpus_have_final_cap(ARM64_HAS_NESTED_VIRT);
+		/* Nested virt is incompatible with MTE */
+		if (kvm && kvm_has_mte(kvm))
+			r = 0;
+		else
+			r = cpus_have_final_cap(ARM64_HAS_NESTED_VIRT);
 		break;
 	case KVM_CAP_ARM_EL2_E2H0:
 		r = cpus_have_final_cap(ARM64_HAS_HCR_NV1);
@@ -1793,13 +1797,15 @@ static int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
 	    !test_bit(KVM_ARM_VCPU_PMU_V3, &features))
 		return -EINVAL;
 
+	/* MTE is incompatible with AArch32 and nested virt */
+	if (kvm_has_mte(vcpu->kvm) &&
+	    (test_bit(KVM_ARM_VCPU_EL1_32BIT, &features) ||
+	     test_bit(KVM_ARM_VCPU_HAS_EL2, &features)))
+		return -EINVAL;
+
 	if (!test_bit(KVM_ARM_VCPU_EL1_32BIT, &features))
 		return 0;
 
-	/* MTE is incompatible with AArch32 */
-	if (kvm_has_mte(vcpu->kvm))
-		return -EINVAL;
-
 	/* NV is incompatible with AArch32 */
 	if (test_bit(KVM_ARM_VCPU_HAS_EL2, &features))
 		return -EINVAL;
-- 
2.47.3

