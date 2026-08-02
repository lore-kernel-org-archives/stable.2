Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555343BB690
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683345; cv=none; b=qK6sFGRc46dlFF+XDnDuwwcBjUlwZyd+CmlUMrk+2XSL+WlqfgqO8KgDu3exGUHo2a3DIKRhGpF7CcAgJGHo9wt3imX4EMgKWqLUoasJzSbZWnNyXodiZP7e/Eb2ZiOosutzXfcwRafHHthofQCN5jDNPyqfyse8wHcuUw8L6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683345; c=relaxed/simple;
	bh=FLLmXGagEOlYSTN9NzFDSiVZQufg9oxohGb0jewo8S8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kjBcL4qwiDochs6K36PXddJZFdmQAhXpD+2x4Bj8HyDCEOJtWLn0yTVnHqFfYP/NljS60gAeb2M0V5YgvH5kmX2LwcJOsXoX5Cm6lw9dgNa+y0LF7o21kH3W3+M/RZGlONHmhjKt3/rOxh9y5s4NJyXiA1ug6A3rRFZpOTF/E98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gMKSneXP; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gMKSneXP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785683329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UHMm2Z1OTcyZHwDxnaYxeN3t4Vh1LnM+EKpoEcU3r9c=;
	b=gMKSneXPJFyeWLDYzxirNzasdTlr+W9DcufRPbjyJf1BfLd/u1/KeSM/pbKdNb3SA9gXYe
	W7NNh/2uQ4M0PsIYWE4gfoHErIm4C8IDArTrzSgAjN8YSdQEPOULsPYYpKeZjSlemCpj5N
	/TwGZzBRaAYdkao9EDGLC+gG/Cb04aQ=
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: stable@vger.kernel.org,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] KVM: arm64: vgic: Reset in_kernel on private IRQ allocation failure
Date: Sun,  2 Aug 2026 16:08:45 +0100
Message-Id: <20260802150845.3485757-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

kvm_vgic_create() sets vgic.in_kernel before allocating the per-vCPU
private IRQs, but the allocation-failure path resets only vgic_model and
leaves in_kernel set. As irqchip_in_kernel() is !!in_kernel, the VM is
left with an in-kernel irqchip but no model, and the -EEXIST guard at the
top of kvm_vgic_create() rejects every retry, so userspace cannot recover
from a transient -ENOMEM.

Reset in_kernel alongside vgic_model on the failure path.

Fixes: 9435c1e1431003 ("KVM: arm64: gic: Set vgic_model before initing private IRQs")
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/vgic/vgic-init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 907057881b26a..fdac6e24762da 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -176,6 +176,7 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 		}
 
 		kvm->arch.vgic.vgic_model = 0;
+		kvm->arch.vgic.in_kernel = false;
 		goto out_unlock;
 	}
 

base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.39.5

