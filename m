Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562154E1C92;
	Tue, 29 Sep 2026 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674602; cv=none; b=cJjEVjLFhe3qR/YIdL0ATINMrMiufDI1blzvUzseBK+mkY716GLNFI/JVIPh0M7q1WX/aCzL8WUbxwaXlF7kJi4kynF33uqtD5KLiGKKDM1tye2kQH0OL/d/cOYL1pFj4hGW4cW2pxhflce2V5LC5C2fZM+YOLGLMDqXGrencaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674602; c=relaxed/simple;
	bh=wXH79VRe2k3zUfZQYgmqEV6aoX6o24uoOwxSZftwQxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9bN+KdjZpD2mM/GabCmdvUHeG88Yyv006zi8UguL1UuAuPZnyWjoaOTrenkOyDObeeEkk451ggFr0z904RJy3USky2yB1wbBHphxS3ZCqmxjWK/DNBbKn9zGSytGCRarVlsFqf6AK+g3ZZ6WBjCbHaXWp1oGYGAArD+VubtDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcSjqq4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcSjqq4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113611F0089B;
	Tue, 29 Sep 2026 09:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674601;
	bh=WgWgUyqIwCZYbNJUU+AhLYr08CuhiyxlVws3w1/8zMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YcSjqq4RxJ21ikWGFG6m6KbS8CBC9eeUfwrzCva77FwZ+iwr0+SakAModKOrDq+jj
	 HkOObJJ2EVGrbKZ8W6dbX68rquEJaJir67oPw+M1EvNY8p1iBVeKVLDNRQjWJVCdrX
	 dTWnUUR2rYXuYTNrqZpOYAOgXg8378ITasJbr3R8bMdU0bFkM9ZPLwrsqQHZ6WGnnx
	 0z1r7ySZwbTHSxDq732p4tA+AcJbrwikN4P9yp5Zzmn+WgeEGYjaP0dijCEkRjuRez
	 e8ge5Nv4D2k4XDZGvrpYZ6GC3Yl6KnY4sDPJlO/lW2FYpwPFDohaGcoSnLlk62wEml
	 fVtoo7Zl1N2tQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xBUGN-0000000ElEa-14PP;
	Tue, 29 Sep 2026 09:36:39 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Yuchao Zhang <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/7] KVM: arm64: vgic: Take a refcount on IRQs referenced by last_lr_irq
Date: Tue, 29 Sep 2026 10:35:45 +0100
Message-ID: <20260929093548.3598547-5-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929093548.3598547-1-maz@kernel.org>
References: <20260929093548.3598547-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, fuad.tabba@linux.dev, ndaugoing@gmail.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Referencing the last interrupt inserted in an LR is rather fragile, as
this interrupt can vanish if a concurrently unmapped LPI.

Solve this by bumping up the refcount on the interrupt when populating
last_lr_irq, and drop it at vgic_prune_ap_list() time, when LPIs are
being reclaimed.

Fixes: 6da5e537f5afe ("KVM: arm64: vgic: Pick EOIcount deactivations from AP-list tail")
Reported-by: Yuchao Zhang <ndaugoing@gmail.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/vgic/vgic.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
index 425503e0c5825..5cf5a1ef86cdd 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -853,6 +853,17 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 		goto retry;
 	}
 
+	/*
+	 * Fix the last_lr_irq refcount which was obtained while
+	 * populating the LRs. This can also result in the LPI being
+	 * deleted.
+	 */
+	irq = *host_data_ptr(last_lr_irq);
+	if (irq) {
+		deleted_lpis |= vgic_put_irq_norelease(vcpu->kvm, irq);
+		*host_data_ptr(last_lr_irq) = NULL;
+	}
+
 	raw_spin_unlock(&vgic_cpu->ap_list_lock);
 
 	if (unlikely(deleted_lpis))
@@ -1018,8 +1029,10 @@ static void vgic_flush_lr_state(struct kvm_vcpu *vcpu)
 		scoped_guard(raw_spinlock,  &irq->irq_lock) {
 			if (likely(vgic_target_oracle(irq) == vcpu)) {
 				vgic_populate_lr(vcpu, irq, count++);
-				if (count == kvm_vgic_global_state.nr_lr)
+				if (count == kvm_vgic_global_state.nr_lr) {
+					vgic_get_irq_ref(irq);
 					*host_data_ptr(last_lr_irq) = irq;
+				}
 			}
 		}
 
-- 
2.47.3

