Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6523BF69C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623948; cv=none; b=c/owmTphcjkUycaLRaSAvgUL9oZU9f7j8U1Bjx7cAxIHQb+ljUjVRffDsJo1ImZ22WqbZ152tNTpQPgy3mxe/SqcW1X0WdivLgpqIrDEEVPQmyQjFVEwt30LdZcZwYKf6yXxtutxcfPeJvE+/gxBcgTHg0J1OKB8gciYn2Muj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623948; c=relaxed/simple;
	bh=4NliFZPaPnWcmyUws0J5B9Gl9ip0X94g7hEdeE4izjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glTElZ7d0Tg7pXVmTezepDVTt5/l9lyTPHuKHptrducqUWI6/9GULX0zUk+li9YX2pHe888gtHVspjj0bDd1hiPR+QObBLv+PE2XdXzYf88c50mHfzxlxj+q3tIkrU+ZBNySP4puAK8bqPVRE5+KszRocvhub29bwooyr2NxRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFShpKud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFShpKud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAC41F000E9;
	Tue, 21 Jul 2026 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784623947;
	bh=RMa5ACXtx6h9YIm/JkueoEigvroqPjYeGnOF4FqysYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CFShpKudxw+/Wd8+0/iD2JgitHe3SQEpBSiimHL48ZVOBZQcLohduYJEZwWMt0K95
	 u6i0whZLoDV+SeUdikLzf1v6ebr0g/ufBOz9YeSrokgoxgMHBWMYEYskWniw5Olxxv
	 2hn9pGtX4j4T8lLq1xvyy8zaHsbklArXrEg5zME13zPA3KggSF1zWr3OFzqgVvj/R6
	 OhCIhcknxuR1ALIgMt7qHZutLQreBFPdHkaPz96HYeAjgV6vkvtFipnEQ/rB+w6WUy
	 aFa9G8jMP9kBQODGu5ll5Np73sMG+IKG4g0/PdKfBmp5KmJoWHOvN3KLZj1hmw/ort
	 XaLzkOXQ7ZugA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wm6DB-000000078aW-0Lfo;
	Tue, 21 Jul 2026 08:52:25 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Subject: [PATCH 5.10.y] KVM: Move kvm_io_bus_get_dev() locking responsibilities to callers
Date: Tue, 21 Jul 2026 09:52:10 +0100
Message-ID: <20260721085210.2808477-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072007-gift-earwig-6100@gregkh>
References: <2026072007-gift-earwig-6100@gregkh>
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
[maz: replaced guard() with lock/unlock to avoid C99 warnings]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-its.c | 15 +++++++++++----
 virt/kvm/kvm_main.c            | 16 +++++-----------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 399f70b60dcb3..e6ec0701f5616 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -704,6 +704,8 @@ struct vgic_its *vgic_msi_to_its(struct kvm *kvm, struct kvm_msi *msi)
 	u64 address;
 	struct kvm_io_device *kvm_io_dev;
 	struct vgic_io_device *iodev;
+	struct vgic_its *its = NULL;
+	int srcu_idx;
 
 	if (!vgic_has_its(kvm))
 		return ERR_PTR(-ENODEV);
@@ -713,18 +715,23 @@ struct vgic_its *vgic_msi_to_its(struct kvm *kvm, struct kvm_msi *msi)
 
 	address = (u64)msi->address_hi << 32 | msi->address_lo;
 
+	srcu_idx = srcu_read_lock(&kvm->srcu);
+
 	kvm_io_dev = kvm_io_bus_get_dev(kvm, KVM_MMIO_BUS, address);
 	if (!kvm_io_dev)
-		return ERR_PTR(-EINVAL);
+		goto out;
 
 	if (kvm_io_dev->ops != &kvm_io_gic_ops)
-		return ERR_PTR(-EINVAL);
+		goto out;
 
 	iodev = container_of(kvm_io_dev, struct vgic_io_device, dev);
 	if (iodev->iodev_type != IODEV_ITS)
-		return ERR_PTR(-EINVAL);
+		goto out;
 
-	return iodev->its;
+	its = iodev->its;
+out:
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+	return its ?: ERR_PTR(-EINVAL);
 }
 
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ef66abe687d78..b340be2d81a3b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4558,25 +4558,19 @@ struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
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

