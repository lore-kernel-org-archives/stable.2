Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A4413D99
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620007; cv=none; b=KIM2IWQ85RTmCZPsQCF4ju1Nw6jM818+HIIrdS7t41c7dzpFNopPKSFc868P93+OELfZa6kTdhZPQCcE2PkZInEiyNRsCCm60Bot49L/GJ3v5VKmW06zwd+I0ovAA7XNmdHLsTyhdZRg1VeVHY5spCfkm8cOA+0Q0oYtIXyq3+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620007; c=relaxed/simple;
	bh=9zJuOZsd4XWQjiXgu97n1iLizqVlzMUiNgCTkeXf4DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2rD6JsQNf/pB7gxbGcUmnjPHEWzlBr3VkZLwEGRzOZAgcGFv7FU0xDKOjf+Nc9BQ3k3cqMl9UGpGQqXywyWqe1SZCyeEqwAfZGkhCU+QavwirsJyeZL+T2/nUR74185B/vc3ajbsQH0gbnTJuZoNRQLjBpNOa5uscypPXK1/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQgqPfpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQgqPfpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5601F000E9;
	Tue, 21 Jul 2026 07:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620006;
	bh=cJ5otZYnN3yIq0h5Xm/zrUZhLX/FLxODUxEHpczKkvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EQgqPfpDrerqetwzaVgRauJuXsiYCTdMDmuPsHYnptw+93/cG+C6PzmCaq9zBKR8N
	 6yB2i+PM9OEIjSZKVS0W8L/ZbUu0TxVbzqtz2IxIOzr0HVF1a+dJPusMxFKoPN8UFO
	 H71Ik8kYaEI6SVBd0qHQP7LOo2V4Kb7sfv6uVVVfrsCcDmrTbJYp0p+vguSdjnG4mL
	 50Fa1zRPYWkGEfU+OudZzt2Kmy7eaxfcP2Md2kiMu6uOXDg3Lko9LfE4ujMOVYYfUk
	 4BS9S3gbeXuqcbYu5bgSHdaKY1XeH7nY2n/dmRpnht3V190dNc5MsH10zjaynJ0+vC
	 Kdv7JeOkbvu6w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wm5Bc-000000076wF-2dGD;
	Tue, 21 Jul 2026 07:46:44 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Subject: [PATCH 6.1.y] KVM: Move kvm_io_bus_get_dev() locking responsibilities to callers
Date: Tue, 21 Jul 2026 08:46:36 +0100
Message-ID: <20260721074636.2686021-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072006-overtake-skillet-e49c@gregkh>
References: <2026072006-overtake-skillet-e49c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, will@kernel.org, oupton@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

kvm_io_bus_get_dev() returns a device that is only matched by the
address, and nothing else. This can cause a lifetime issue if
the matched device is not the expected type, as by the time
the caller can introspect the object, it might be gone (the srcu
lock having been dropped).

Given that there is only a single user of this helper, the simplest
option is to move the locking responsibility to the caller, which
can keep the srcu lock held for as long as it wants.

Note that this aligns with other kvm_io_bus*() helpers, which
already require the srcu lock to be held by the callers.

Reported-by: Will Deacon <will@kernel.org>
Fixes: 8a39d00670f07 ("KVM: kvm_io_bus: Add kvm_io_bus_get_dev() call")
Link: https://lore.kernel.org/all/20260626111344.802555-1-maz@kernel.org
Cc: stable@vger.kernel.org
Reviewed-by: Oliver Upton <oupton@kernel.org>
Link: https://patch.msgid.link/20260627105105.1005990-1-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
(cherry picked from commit 3a07249981629ace483ebbef81ef6b34c2d2afec)
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-its.c |  2 ++
 virt/kvm/kvm_main.c            | 16 +++++-----------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index c3b469b32b83f..15c047d7539d1 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -713,6 +713,8 @@ struct vgic_its *vgic_msi_to_its(struct kvm *kvm, struct kvm_msi *msi)
 
 	address = (u64)msi->address_hi << 32 | msi->address_lo;
 
+	guard(srcu)(&kvm->srcu);
+
 	kvm_io_dev = kvm_io_bus_get_dev(kvm, KVM_MMIO_BUS, address);
 	if (!kvm_io_dev)
 		return ERR_PTR(-EINVAL);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7a4fd1dbe0d78..f060c914d6810 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5465,25 +5465,19 @@ struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 					 gpa_t addr)
 {
 	struct kvm_io_bus *bus;
-	int dev_idx, srcu_idx;
-	struct kvm_io_device *iodev = NULL;
+	int dev_idx;
 
-	srcu_idx = srcu_read_lock(&kvm->srcu);
+	lockdep_assert_held(&kvm->srcu);
 
 	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
 	if (!bus)
-		goto out_unlock;
+		return NULL;
 
 	dev_idx = kvm_io_bus_get_first_dev(bus, addr, 1);
 	if (dev_idx < 0)
-		goto out_unlock;
+		return NULL;
 
-	iodev = bus->range[dev_idx].dev;
-
-out_unlock:
-	srcu_read_unlock(&kvm->srcu, srcu_idx);
-
-	return iodev;
+	return bus->range[dev_idx].dev;
 }
 EXPORT_SYMBOL_GPL(kvm_io_bus_get_dev);
 
-- 
2.47.3

