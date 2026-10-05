Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031C25393E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210987; cv=none; b=DO9ta6ObBvVyLXyW790ic29g5VH5Lh1nsE6yipHo+4Y3ln9BRV2D3tZejReItb9waECj3Vaum3WBj4lWwaSrA/grpCW6+CB1LHRtxovyi/734/tYaAAwBWRi0iw91QFiuo7FozI8B5wq2HgH7xQx29Y72Vw0S6RKzhdOQBGcJcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210987; c=relaxed/simple;
	bh=3AP69YioBqmYb8aBaeTX7AW2AEQeVyRBX4p8oC2n40Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hATiVjToQD/umjf7jpQrtDZbiyrpw6P7W4D3itp2O/xKjGxZVZiGXzM1uIkNNown+pwywaOBzzjrZFEWrMgCosW/q4nI9n0LjbtCGmuTy80S17XMpJV5fXLA0ESJpAOr1oDI3gui7Z9bVkMmhCg6EsJ1LPChBgX/DgkDGwHGolY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c1B+X68R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c1B+X68R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEF61F00893;
	Mon,  5 Oct 2026 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791210982;
	bh=upYz3JIXutwGoq3hQzaQZNNqKx2Fswfe+8NYSDN1hOA=;
	h=Subject:To:Cc:From:Date;
	b=c1B+X68R38BVj3+Q6NjNMeY7blXW3HzDFELpY/b4ZlaXn6Bsm/4+9/vXXbgYih6TU
	 yuj8aWbcphOb/ccifBOshDYH51DA7iB4slkhsUg4UCjjF0wiEzXqOypnJO+3IVJGUZ
	 fbdQ2Sk34BU24sgvU0A79CPyI7lfQ/q2eWAtzykU=
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-its: Fix MOVALL handling of source" failed to apply to 6.12-stable tree
To: maz@kernel.org,oupton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:36:19 +0200
Message-ID: <2026100519-line-generous-1624@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 751f4641560be8568dcc5af400c0e55a283abf51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100519-line-generous-1624@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 751f4641560be8568dcc5af400c0e55a283abf51 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Tue, 29 Sep 2026 10:35:47 +0100
Subject: [PATCH] KVM: arm64: vgic-its: Fix MOVALL handling of source
 redistributor

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

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 0904ae850c35..c10a11373e10 100644
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

