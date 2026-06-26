Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC29249E5;
	Fri, 26 Jun 2026 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472449; cv=none; b=cAKnBKXzxSVi5pRHPWgSS+H4dAeAJKbCWBghPmDELShluq/ZWCY2owxyF1n0ln72YuU9ZQb+VOT9vRB1q5/54qsTLWAjLpGC/mtMKdew84ectf2WqexWSZ7TfOWQ9McajhgIVZSbMmK49VXo4+NCzja9WfJH+83y0H2Qn9r+YYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472449; c=relaxed/simple;
	bh=FKSRA4QIkdSVuuKM8frxdcVN/2HixuGr174Q8BfV66M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=figIAWfUD0F2rE8AsmvrlLSPhcVTF3gHDGpi0wmcCBmBCxy2Vu2YaVWm+9ETfyj4GwqlDDfQJ2cDfPXFFHimbdV7uShzLKs8wcv31PKSLwVVUlMkQdCT8qETAoPulL5+OLeVKnc4DyDuGgVryb5OeZmsPN2myp3EOAERkTdr7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gz6urgNF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz6urgNF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09C71F000E9;
	Fri, 26 Jun 2026 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782472447;
	bh=GOtd/Q5jMBs1nKTaCUlK0pT1uV18NzvSg8sXipKGWEo=;
	h=From:To:Cc:Subject:Date;
	b=gz6urgNFMazzIa1K0HLHL8V5gBEOv+F5aYHIYBaGoczUHMBBWHSmYPm8Nu9rHJykq
	 pI1qLCl3vY/xc0XiLWe+VU2FY3sw4YxvB+bDMrySux0CTSQYhwnm3jml541MGDbjtW
	 Zfo+PDmC7pKPyoZYMfCz/wYy4EAJ7alTmhR0+6EgD6k0KZJ/tp4hrsf1v9kKeeNSqo
	 AVu0caXKFR6ynQHx9eH7gBKeo0qraHt92pFv0xJqSQlKX4Rc20p7yEtbtoB9YnP1wk
	 Db3mix8fdfGVZwK1qhBSfKzJru4bHEuPso3uRhG32CBRvQX8NPxfjZEAujGuh6GSS1
	 2d2/DaHuHOXUQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wd4VZ-0000000GJ9y-2AOO;
	Fri, 26 Jun 2026 11:14:05 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Will Deacon <will@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: Make kvm_io_bus_get_dev() filter devices by ops
Date: Fri, 26 Jun 2026 12:13:44 +0100
Message-ID: <20260626111344.802555-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, pbonzini@redhat.com, will@kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

kvm_io_bus_get_dev() returns a device that is only matched by the
address, and nothing else. This can cause a lifetime issue if
the matched device is not the expected type, as by the time
the caller can introspect the object, it might be gone (the srcu
lock having been dropped).

Add an kvm_io_device_ops pointer to the list of things that this
helper must check before dropping the lock and returning the pointer,
and update the sole user to pass its own ops.

Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Fixes: 8a39d00670f07 ("KVM: kvm_io_bus: Add kvm_io_bus_get_dev() call")
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/vgic/vgic-its.c | 5 +----
 include/linux/kvm_host.h       | 1 +
 virt/kvm/kvm_main.c            | 5 ++++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 4477f870c7b36..1c1bdd420c40d 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -508,13 +508,10 @@ static struct vgic_its *__vgic_doorbell_to_its(struct kvm *kvm, gpa_t db)
 	struct kvm_io_device *kvm_io_dev;
 	struct vgic_io_device *iodev;
 
-	kvm_io_dev = kvm_io_bus_get_dev(kvm, KVM_MMIO_BUS, db);
+	kvm_io_dev = kvm_io_bus_get_dev(kvm, KVM_MMIO_BUS, &kvm_io_gic_ops, db);
 	if (!kvm_io_dev)
 		return ERR_PTR(-EINVAL);
 
-	if (kvm_io_dev->ops != &kvm_io_gic_ops)
-		return ERR_PTR(-EINVAL);
-
 	iodev = container_of(kvm_io_dev, struct vgic_io_device, dev);
 	if (iodev->iodev_type != IODEV_ITS)
 		return ERR_PTR(-EINVAL);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4c14aee1fb063..4c195a8723c40 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -231,6 +231,7 @@ int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 			      struct kvm_io_device *dev);
 struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
+					 const struct kvm_io_device_ops *ops,
 					 gpa_t addr);
 
 #ifdef CONFIG_KVM_ASYNC_PF
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 881f92d7a469e..26c34d500ea18 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6066,6 +6066,7 @@ int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 }
 
 struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
+					 const struct kvm_io_device_ops *ops,
 					 gpa_t addr)
 {
 	struct kvm_io_bus *bus;
@@ -6082,7 +6083,9 @@ struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 	if (dev_idx < 0)
 		goto out_unlock;
 
-	iodev = bus->range[dev_idx].dev;
+	if (bus->range[dev_idx].dev &&
+	    bus->range[dev_idx].dev->ops == ops)
+		iodev = bus->range[dev_idx].dev;
 
 out_unlock:
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
-- 
2.47.3

