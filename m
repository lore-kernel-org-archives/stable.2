Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92036A36B
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283545; cv=none; b=jJumLngczFSUtLd/iHpSSxVvRP0xPBBm3YKhsMbgxGC0bGUGCr1csajZtVtnHxBoUNf6PwRa5GAAUe4f9aYz/f4mq2DIiz8uqdlJp7lNkQmZpBfw90e1WkWS+lfKFOjUfpG08KXblSpdTMI3qOlPzXwNR+KHYHUfSjrXbdhzTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283545; c=relaxed/simple;
	bh=+MjGIxK9Jk63M4CtfaLkqfeF1NAeiO7gV3AJG3b5cbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erhx1QzleeaxnHNG1Lr/QWVT//DFGjzW30/Q2mBhNRpTKMpt91FWGXGN5thMtz0qFAd7FGGE0RsOrbSPhqr5CIn9eklU8c/XvOQrcrCfrk4hJhRkwAL6WUHnIO3N8WWTtrqDP1GuVHwjN/BfUtQyCY20G+CzSdROFMHjmWWwvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXD2vQvV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXD2vQvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129941F00898;
	Tue,  6 Oct 2026 10:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791283544;
	bh=w3+73jkUyx5gK4A8w3tH5oevnMFHXHRGR8fkQlrmHzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MXD2vQvVKTMuKiK68Uqc5eShLAOGJWuQ8Rml7m96S94oODTamaFUK4XT/kILo4Q6G
	 S3xgXKCbjraMjOQxD23ngwSObOeI929Ld5jqVKDRAChgAqSCb6Rt3ilCYXGO5H5ZkD
	 Ca52V1JXa2SbLTC4IGuB++YfDQGb2CkFAYEsQBZZQ3uXmc0GHjdhL7y89MbOZFwFEu
	 2YK5uL7OFlmwf51Cy8lDdFTyEK5RQYzE8PqQqaH/RF+Xb8iS9dSSnSUiOHHiYLkwNV
	 lcOkjnhBukM1Kpxyw+RmKjkdzK0Lvr367DVTLxS7cbotj5v18+MZsNfSv3jrh684jc
	 pQ7699RLGC8nQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xE2g2-0000000HNla-1k0Q;
	Tue, 06 Oct 2026 10:45:42 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Upton <oupton@kernel.org>
Subject: [PATCH 6.12.y] KVM: arm64: vgic-its: Fix MOVALL handling of source redistributor
Date: Tue,  6 Oct 2026 11:45:38 +0100
Message-ID: <20261006104538.685611-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026100519-line-generous-1624@gregkh>
References: <2026100519-line-generous-1624@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, oupton@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

The MOVALL command moves the pending state of all LPIs targeting a given
redistributor to another one. However, we seem to have lost the
filtering on the source RD, which means we move all LPIs to the target.

Not quite what the spec mandates.

Hack update_affinity() to take an optional source vcpu that is used as a
filter when non-NULL, restoring the filtering that was performed by
vgic_copy_lpi_list() back in the days.

Fixes: 11f4f8f3e6e06 ("KVM: arm64: vgic-its: Walk LPI xarray in vgic_its_cmd_handle_movall()")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260929093548.3598547-7-maz@kernel.org
Signed-off-by: Oliver Upton <oupton@kernel.org>
(cherry picked from commit 751f4641560be8568dcc5af400c0e55a283abf51)
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-its.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 4b56de3352053..5ba833a288813 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -344,12 +344,18 @@ static int update_lpi_config(struct kvm *kvm, struct vgic_irq *irq,
 	return 0;
 }
 
-static int update_affinity(struct vgic_irq *irq, struct kvm_vcpu *vcpu)
+static int update_affinity(struct vgic_irq *irq,
+			   struct kvm_vcpu *from_vcpu, struct kvm_vcpu *vcpu)
 {
 	int ret = 0;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&irq->irq_lock, flags);
+	if (from_vcpu && irq->target_vcpu != from_vcpu) {
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
+		return 0;
+	}
+
 	irq->target_vcpu = vcpu;
 	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 
@@ -391,7 +397,7 @@ static void update_affinity_ite(struct kvm *kvm, struct its_ite *ite)
 		return;
 
 	vcpu = collection_to_vcpu(kvm, ite->collection);
-	update_affinity(ite->irq, vcpu);
+	update_affinity(ite->irq, NULL, vcpu);
 }
 
 /*
@@ -869,7 +875,7 @@ static int vgic_its_cmd_handle_movi(struct kvm *kvm, struct vgic_its *its,
 
 	vgic_its_invalidate_cache(its);
 
-	return update_affinity(ite->irq, vcpu);
+	return update_affinity(ite->irq, NULL, vcpu);
 }
 
 static bool __is_visible_gfn_locked(struct vgic_its *its, gpa_t gpa)
@@ -1396,7 +1402,7 @@ static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
 		if (!irq)
 			continue;
 
-		update_affinity(irq, vcpu2);
+		update_affinity(irq, vcpu1, vcpu2);
 
 		vgic_put_irq(kvm, irq);
 	}
-- 
2.47.3

