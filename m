Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE134CDDE4;
	Tue, 29 Sep 2026 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674603; cv=none; b=F2eXofcaBtPwPSxt7D/Ohq5GOp7KK/85xDtajMoODGQD09r1u668hMWbdr8E/OXS1jIqrAtg64Gt6Uvcr4gb7nrwDkyygOA8aFjHQfXeLI9plUt+rka21+aC07yeH1VQW4Ar4Obp9mbP6PXNtRClfx9tvEUY0aK35aoZbQlaFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674603; c=relaxed/simple;
	bh=5guw0H8KXXcoeLk2Z3fzw6vhyj24zAD5pHFjtwhYKWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcoaHbYlseY7wKc4vz83gpYzFeoUO+KvYjvIxFoOhEcvSfDEaKUaZ/B3lwfovl5/nIl0/zsRFd0XtmCetGw/3u+ZT35ayPZGgPwE+UWY81bjIuLXpsG9MK7w2eBnyUD52pb1UUhIpgseHK9T/4qMNzfFFraexdKYb6ZM+NDQOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYI23eZt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYI23eZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821E61F0089A;
	Tue, 29 Sep 2026 09:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674601;
	bh=f6sEMz+sle2+vRKQR9x7yi93xoB+ZcFnzxRhK6q+PUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UYI23eZt/xXaG0hcQNuVsIHd5hhQ2VDuJyUpjdaWB9A+uDuqTVObPko0oGFhFZEy+
	 wDAV4q0TvbqUWta/xzGFvg9sVur3hAWD5y7/dHotJoSpUYiXiVgnMh4XwASpsIPri3
	 gClEEyIdWWeEi6SuOr32JNO5aKyQYxh2wjWFD5MHMj9h/fs7UMkVVVyJr7edNs6yIu
	 UCgZAOzmlKblV3zMzqnrtjznj+vqOKSBOOS7/csVIXUrFqA4ZXDKEbXEGKnA/uZdAd
	 QJCmK0QMl/SYqAMVvpP1umYKfB5s9BQYFTUJLnF9Kl3vk3ZicUWlw4Nn2u+A1ZWAzI
	 bKzOVxo0lc+zw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xBUGN-0000000ElEa-3EdP;
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
Subject: [PATCH v2 6/7] KVM: arm64: vgic-its: Fix MOVALL handling of source redistributor
Date: Tue, 29 Sep 2026 10:35:47 +0100
Message-ID: <20260929093548.3598547-7-maz@kernel.org>
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
---
 arch/arm64/kvm/vgic/vgic-its.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 9e782a4fea7e5..cc02d9b62bd95 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -319,12 +319,16 @@ static int update_lpi_config(struct kvm *kvm, struct vgic_irq *irq,
 	return ret;
 }
 
-static int update_affinity(struct vgic_irq *irq, struct kvm_vcpu *vcpu)
+static int update_affinity(struct vgic_irq *irq,
+			   struct kvm_vcpu *from_vcpu, struct kvm_vcpu *vcpu)
 {
 	struct its_vlpi_map map;
 	int ret;
 
 	guard(raw_spinlock_irqsave)(&irq->irq_lock);
+	if (from_vcpu && irq->target_vcpu != from_vcpu)
+		return 0;
+
 	irq->target_vcpu = vcpu;
 
 	if (!irq->hw)
@@ -362,7 +366,7 @@ static void update_affinity_ite(struct kvm *kvm, struct its_ite *ite)
 		return;
 
 	vcpu = collection_to_vcpu(kvm, ite->collection);
-	update_affinity(ite->irq, vcpu);
+	update_affinity(ite->irq, NULL, vcpu);
 }
 
 /*
@@ -856,7 +860,7 @@ static int vgic_its_cmd_handle_movi(struct kvm *kvm, struct vgic_its *its,
 
 	vgic_its_invalidate_cache(its);
 
-	return update_affinity(ite->irq, vcpu);
+	return update_affinity(ite->irq, NULL, vcpu);
 }
 
 static bool __is_visible_gfn_locked(struct vgic_its *its, gpa_t gpa)
@@ -1383,7 +1387,7 @@ static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
 		if (!irq)
 			continue;
 
-		update_affinity(irq, vcpu2);
+		update_affinity(irq, vcpu1, vcpu2);
 
 		vgic_put_irq(kvm, irq);
 	}
-- 
2.47.3

