Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A44D0CE2;
	Tue, 29 Sep 2026 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674602; cv=none; b=uIowrMhGZHiuWRJmVDFutC9uST/TcPAE3tUt+B/Z/tIgtWcTlyjqBEu9DQH9xqKkva7p/TtRaKq+o5Lp2nVH4VKbVYIycSqA09voRC+nEgvGP3B6iLj5AuG7FTwx3JjU8IZlshFuTzL6J1kMvl7rDqBHTXpXgwJjpSl3PcTTsUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674602; c=relaxed/simple;
	bh=EAVIhCYjnPTzLgJDhLrHuY+z77qpu9v/v8IJ9BzqlDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qX63mqZZ6AHOhvkCvqfQ0IVXAhsd0OdtwpLo+5tMxt/NVxLA62kDHyjFPgl/c04Fz0odFjcpe4flkrdz6qCB/FG0dozu5rRz5hjb6SDwRdJQzUk32+TITBY8cYNKID7XenTBTeMXwmFzlE6XFawUUUP3P40KCmN4SnDYl3qQyFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqGyBLhM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqGyBLhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28781F000FF;
	Tue, 29 Sep 2026 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674600;
	bh=iA22YnUtIcv1KaIC572i8+H/hJXB2ylgtwm/SjWDh5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AqGyBLhMa6JAddOBE0ZJWBzURTAlY47Sy867BzpHUvmOP2zJmo0Ljg4p/b6r1DG61
	 dC001KH/TGkldqMpM7YqFLWsoLkezaDZ19Sls+4cD4N/ubivVlwTzwzko/6/mnYj6W
	 vWeQlkaJPAfrt+O36vgs8kgM0Ok64dPmMtCZh7FtmHQjR+UmpZlFs4LMnFQ/kmbdLM
	 Djwdw+DlopMmy0PsS6HUJDPS9Rk9uQw9a177BjIz1GwIowDIs0Hn9T2uOs2N4IMEJe
	 SwTEot2l972cjWlJyx1w/WRvV0DFTDC0uNeNGNyJ5sJgm5ds0dHpTEsSpak8MJHboB
	 TolD6fk1piX4g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xBUGN-0000000ElEa-06TF;
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
Subject: [PATCH v2 3/7] KVM: arm64: vgic: Allow last_lr_irq to be NULL when LRs are not overflowing
Date: Tue, 29 Sep 2026 10:35:44 +0100
Message-ID: <20260929093548.3598547-4-maz@kernel.org>
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

last_lr_irq is always populated when there is any interrupt populated in
the AP list. Not only this is not necessary (it is only useful when we
completely fill the LRs), but this is in the way of further fixes.

Make sure last_lr_irq is kept to NULL when we LRs are not completely
full.

Fixes: 6da5e537f5afe ("KVM: arm64: vgic: Pick EOIcount deactivations from AP-list tail")
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/vgic/vgic-v2.c | 6 ++++--
 arch/arm64/kvm/vgic/vgic-v3.c | 6 ++++--
 arch/arm64/kvm/vgic/vgic.c    | 8 +++-----
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index 7182f63fc9382..70cc53ba810ad 100644
--- a/arch/arm64/kvm/vgic/vgic-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-v2.c
@@ -122,6 +122,10 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
 	for (int lr = 0; lr < vgic_cpu->vgic_v2.used_lrs; lr++)
 		vgic_v2_fold_lr(vcpu, cpuif->vgic_lr[lr]);
 
+	cpuif->used_lrs = 0;
+	if (!irq)
+		return;
+
 	/* See the GICv3 equivalent for the EOIcount handling rationale */
 	list_for_each_entry_continue(irq, &vgic_cpu->ap_list_head, ap_list) {
 		u32 lr;
@@ -144,8 +148,6 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
 		vgic_v2_fold_lr(vcpu, lr);
 		eoicount--;
 	}
-
-	cpuif->used_lrs = 0;
 }
 
 void vgic_v2_deactivate(struct kvm_vcpu *vcpu, u32 val)
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 726e20a1da6e7..346bacb3198f2 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -155,6 +155,10 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
 	for (int lr = 0; lr < cpuif->used_lrs; lr++)
 		vgic_v3_fold_lr(vcpu, cpuif->vgic_lr[lr]);
 
+	cpuif->used_lrs = 0;
+	if (!irq)
+		return;
+
 	/*
 	 * EOIMode=0: use EOIcount to emulate deactivation. We are
 	 * guaranteed to deactivate in reverse order of the activation, so
@@ -188,8 +192,6 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
 		vgic_v3_fold_lr(vcpu, lr);
 		eoicount--;
 	}
-
-	cpuif->used_lrs = 0;
 }
 
 void vgic_v3_deactivate(struct kvm_vcpu *vcpu, u64 val)
diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
index b25303d9919fd..425503e0c5825 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -866,9 +866,6 @@ static void vgic_fold_state(struct kvm_vcpu *vcpu)
 		return;
 	}
 
-	if (!*host_data_ptr(last_lr_irq))
-		return;
-
 	if (kvm_vgic_global_state.type == VGIC_V2)
 		vgic_v2_fold_lr_state(vcpu);
 	else
@@ -1021,11 +1018,12 @@ static void vgic_flush_lr_state(struct kvm_vcpu *vcpu)
 		scoped_guard(raw_spinlock,  &irq->irq_lock) {
 			if (likely(vgic_target_oracle(irq) == vcpu)) {
 				vgic_populate_lr(vcpu, irq, count++);
-				*host_data_ptr(last_lr_irq) = irq;
+				if (count == kvm_vgic_global_state.nr_lr)
+					*host_data_ptr(last_lr_irq) = irq;
 			}
 		}
 
-		if (count == kvm_vgic_global_state.nr_lr)
+		if (*host_data_ptr(last_lr_irq))
 			break;
 	}
 
-- 
2.47.3

