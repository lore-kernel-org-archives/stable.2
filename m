Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045896;
	b=Mtjc4EwGDbFttwDt2PrNAfgWyR7yauPp6Z4tPhmeXcrcOoPL9uJNJjkNea8uoaywyGKm
	 XZqCPYscOVCY+1e7dvi4UoILCYMddFVLp5pQpXJl0RLIIPXrBI/PbWkuT64wsBXCjS/nB
	 ioB/AZPxFiscwQFtWJYplavKXtpoD/++FAht0PhyLBQ7UrPk7VtWc9P/9u+x+ve10vEWQ
	 TwnYr1ZiBhrQOcRMZOc3TRDEYic3mW2aVGzWDQ06OkTBSDY+LtojvHxw76ux5hPWor+2+
	 izEWaDnck2i+LCq/j0F4UJ9cc/UopHoMKCSA6yZ+0pFgZXYVbMHZUPFk3iWDEK1unHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045896;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Mb4KdWH/f83YVwEgUrk/PijBYFwimeMrr6ICHV7NJRs=;
	b=FApRie31qmDTnM31kM8jvzbbYooMFZrpCCGr53jWL4I/cFOmRcT52pLYk8L9v6VoVq4q
	 218xS30RhiOViT9WBZcd1h21LrupM2iL8tVXK3oulCqyCITU+dFyTg4AGtvk3FFtvANvp
	 1wEgID1kSdAEq6RwzmHWipPnN2epGEPGveAniZ6WLmtpbhIm6wLqSPR0Qw8bydd8v+qgL
	 YlsW0fAiU7rTAfkBYnqAEqqgjIWaK8joX2pM7bPcHPoaqN60You98SX7+J9R/SKwOOHbY
	 pJCjtLZUmkWRV/8Pzuy07qoqKfTB+Jy1KQijbtCTUEkDSPdpj1Vl4CND4UDUoAI5/nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUtS67wt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF1606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUtS67wt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B871F0089F;
	Sat,  7 Nov 2026 10:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045895;
	bh=Mb4KdWH/f83YVwEgUrk/PijBYFwimeMrr6ICHV7NJRs=;
	h=From:To:Cc:Subject:Date;
	b=QUtS67wtMUFkBUuQo9D/6inVtnCVvbLgAYdqrUihujtHIKPsy5RpD2Zz/dpoB2u+4
	 Jc9T651MhJbe9e7E7if9q/gw5AfA51hjNMqS8GkJ4D9CsIG3peyMdbTkVWSiDoKBtx
	 QzB8Vh0WfXECXedlAnye+UWRJhFJ/8SUTXsMP05oa4jLfVwbDguKWY0f3Jc8akD4lK
	 vtt2eEzXZFOCcMIMxOEKtMvgXsib6GzA9gMwHjsbJf9vV1yQP7o25Sp+RjW9jx8luG
	 9rTmTjgf4iJOQdCVe8bXYSh7nTODNQZVyisLd4Obp5F527CjIzn4glvcvE2GQJA8pr
	 cbfSrgg9pPCbw==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	oupton@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic: Stop the target vcpu when disabling LPIs" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:54 -0500
Message-ID: <20261107050454-failed-7.3-a1b4bd2c2c26@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x a1b4bd2c2c262b8094c86afb99364d16ac08cb66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050454-failed-7.3-a1b4bd2c2c26@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a1b4bd2c2c262b8094c86afb99364d16ac08cb66 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 15 Oct 2026 11:05:38 +0100
Subject: [PATCH] KVM: arm64: vgic: Stop the target vcpu when disabling LPIs

Disabling LPIs is pretty nasty, as it directly messes with the AP list
of the affected CPU, which could be running... This has the potential to
lead to really bad behaviours, and we should not be doing that.

Take example on the way the Active state is handled and simply pause the
the vcpu so that we are sure it is in a quiescent state, and the state be
safely manipulated.

Nobody has any expectation of performance for this anyway.

Fixes: 96085b949672d ("KVM: arm/arm64: vgic-v3: Retire pending interrupts on disabling LPIs")
Co-developed-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Oliver Upton <oupton@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20261015100539.1011760-7-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5913a20d83019..f5bd29fbe3a90 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -303,9 +303,19 @@ static void vgic_mmio_write_v3r_ctlr(struct kvm_vcpu *vcpu,
 		if (ctlr != GICR_CTLR_ENABLE_LPIS)
 			return;
 
+		/*
+		 * Yes, disabling LPIs is painful, since it can be done from
+		 * a *remote* vcpu! So let's not take any chance, and make
+		 * sure that the target vCPU has written their LRs back to the
+		 * irq structures, and release any reference they would have.
+		 *
+		 * If it hurts, don't do it.
+		 */
+		kvm_pause_vcpu(vcpu);
 		vgic_flush_pending_lpis(vcpu);
 		vgic_its_invalidate_all_caches(vcpu->kvm);
 		atomic_set_release(&vgic_cpu->ctlr, 0);
+		kvm_resume_vcpu(vcpu);
 	} else {
 		ctlr = atomic_cmpxchg_acquire(&vgic_cpu->ctlr, 0,
 					      GICR_CTLR_ENABLE_LPIS);
-- 
2.53.0




