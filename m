Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E66B11CBA
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618992; cv=none; b=pLaxZvIXDexEfEp0Dd2mrqXPND156lePSmter/TKmC69YqhBrWTQbuvMQ/jneLYfgLOrgR24+DfA0V/CgJA9stcOd1US6gagEgUYxg0c6bJd2QRe6/UFFHTJg9CyIFGrTJmc9agtXC8hrN5Ns3GAzob86MQvawVbhlMRKBK1UxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618992; c=relaxed/simple;
	bh=8idf/JXKepVraLCx4YouCoCY6wzZkS5Wy5D90f06+QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFudwPEbiT8nTEwUgoGaOAOPNfxohaZvuPUyrRA7aPUqiFJ2xPa0IVb8g2EvW2Dp7Y3zNikLaqO3SF5upBgr9wEBeTiMrv9yvwD5g9QZ2tsFdcfy+c398ZrAGZRzcEAs6ClBQLb1xonGaJ22DFJ3G6GO2SNyGqxtbgc/lHpDric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGreCU/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGreCU/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9761F000E9;
	Tue, 21 Jul 2026 07:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784618990;
	bh=3I12mlVz54ugrulJtJ0TQU5rB7USg/jQRnIceht5gec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JGreCU/JPEhmRIqpeNFU20Kc5fwruOf5A1EZqK6oK1La77kMaQQRbkp9lHzoxg3R4
	 xlglDgp3qptvOdj9hDVjcecsCrWaRn11qz5yhwMRjV31XD3bxUBvx8G6JdTDyXgnnN
	 OD8j1O2sbbl1a7ui/qNlq38qH98myxUMy6vMhslPRxYfPQvvCOsOSo9PAkDCP4kZHb
	 PvGxM4dcgEAsHA0AhogHFJyTB9/+jRJJztLxyo+N74KkS66SjAU89iP29c1oX8fEs2
	 +capyJz7xn3GjzPfWazQLbDvvET5wwUId3EkvoK/g9Uf6LgF1fJowUMjXt0ESyvpTG
	 o2DNNCuJAWIlg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wm4vE-000000076bk-2zrM;
	Tue, 21 Jul 2026 07:29:48 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Subject: [PATCH 6.12.y] KVM: Move kvm_io_bus_get_dev() locking responsibilities to callers
Date: Tue, 21 Jul 2026 08:29:44 +0100
Message-ID: <20260721072944.2577766-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072005-magician-appease-c082@gregkh>
References: <2026072005-magician-appease-c082@gregkh>
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
index dcd6b23ad2e1e..7282305de3471 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -510,6 +510,8 @@ static struct vgic_its *__vgic_doorbell_to_its(struct kvm *kvm, gpa_t db)
 	struct kvm_io_device *kvm_io_dev;
 	struct vgic_io_device *iodev;
 
+	guard(srcu)(&kvm->srcu);
+
 	kvm_io_dev = kvm_io_bus_get_dev(kvm, KVM_MMIO_BUS, db);
 	if (!kvm_io_dev)
 		return ERR_PTR(-EINVAL);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 84e6b8684ef65..f1351d0ceb303 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6063,25 +6063,19 @@ struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
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

