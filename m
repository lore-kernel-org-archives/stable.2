Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D4211466;
	Sat, 27 Jun 2026 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782557477; cv=none; b=MwHt9ndROQrMb17fJ3Rn67ZrXh6o/pr6xpSs9EZEyzuobdpCm6DaICP4O2jwPSHCRI1Zp/TXZ7SHgpVsVz9U2XvuGTF3XTx5EFhr7U0qkmC/yHuhvh/XNfEpN1yDlBVoJFbupk1UOH9d2gBLOZ3qJYEOHv9waLJZOPtYq7d+7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782557477; c=relaxed/simple;
	bh=eiQ91xo216xndNpSYDtCd7KMFnHhu+ZE9kzJMfsSQzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GsXXZbCofJaJeWEY+XXuN2XKn0Hu9CEfbY513Wlv3wgI0Jp/aggoEWrxquPk6G+heeYie4cB/Y7RX6+DUETK8KdXkV/YkCXuVX5PrNPVHoHkpMlVsZXGksD4WvqfrDuPgsFBOYOVzngPc/+pqUcxEVWZuQMrv1rmzSeFMEdJo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1+X2Lz2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1+X2Lz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFF51F000E9;
	Sat, 27 Jun 2026 10:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782557476;
	bh=D+aL5SBZJsWFJfZTfZtbheXuQGiHvpX7mm9bteynJkE=;
	h=From:To:Cc:Subject:Date;
	b=M1+X2Lz2a0tn1R7bVkejNLsLXl+Pk2NjtutG83/iQM/nReueTZGoIpT0LnUJuPCSS
	 qjtpmXHJcQic8UxtzgWxykBQ17PbpwKmxjWXHPpbAVzAmyKgg6Vrja47WYCQQ5uTW0
	 t9/SJymPGoU7/0DpNbvmGy0RO50SklyVQttYal3cg67fNBKRGM/mXaCLaYt5BmDQl+
	 DCb9IZdT/fcCYIwKikrl1Mktm58YtVrI6ciLD1Jnqdr9sglR790Ur1cb12QfItEONp
	 LIAVU045udJvqKVmxWAz9l1xQ0jykRBDLG8ta/IACZkXJQ+dlngYCDAnw/+Xn5X6aY
	 gi2aEmrQT7aNQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wdQd0-0000000GZWr-09QM;
	Sat, 27 Jun 2026 10:51:14 +0000
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
Subject: [PATCH v2] KVM: Move kvm_io_bus_get_dev() locking responsibilities to callers
Date: Sat, 27 Jun 2026 11:51:05 +0100
Message-ID: <20260627105105.1005990-1-maz@kernel.org>
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

Given that there is only a single user of this helper, the simplest
option is to move the locking responsibility to the caller, which
can keep the srcu lock held for as long as it wants.

Note that this aligns with other kvm_io_bus*() helpers, which
already require the srcu lock to be held by the callers.

Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Fixes: 8a39d00670f07 ("KVM: kvm_io_bus: Add kvm_io_bus_get_dev() call")
Link: https://lore.kernel.org/all/20260626111344.802555-1-maz@kernel.org
Cc: stable@vger.kernel.org
---

Notes:
    v2: Drop the previous filtering approach, and move the locking into
        the only caller, similar to kvm_io_bus_{read,write}().

 arch/arm64/kvm/vgic/vgic-its.c |  2 ++
 virt/kvm/kvm_main.c            | 16 +++++-----------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 4477f870c7b36..740b39875728d 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -508,6 +508,8 @@ static struct vgic_its *__vgic_doorbell_to_its(struct kvm *kvm, gpa_t db)
 	struct kvm_io_device *kvm_io_dev;
 	struct vgic_io_device *iodev;
 
+	guard(srcu)(&kvm->srcu);
+
 	kvm_io_dev = kvm_io_bus_get_dev(kvm, KVM_MMIO_BUS, db);
 	if (!kvm_io_dev)
 		return ERR_PTR(-EINVAL);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 881f92d7a469e..1a529098eec98 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6069,25 +6069,19 @@ struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 					 gpa_t addr)
 {
 	struct kvm_io_bus *bus;
-	int dev_idx, srcu_idx;
-	struct kvm_io_device *iodev = NULL;
+	int dev_idx;
 
-	srcu_idx = srcu_read_lock(&kvm->srcu);
+	lockdep_assert_held(&kvm->srcu);
 
 	bus = kvm_get_bus_srcu(kvm, bus_idx);
 	if (!bus)
-		goto out_unlock;
+		return NULL;
 
 	dev_idx = kvm_io_bus_get_first_dev(bus, addr, 1);
 	if (dev_idx < 0)
-		goto out_unlock;
-
-	iodev = bus->range[dev_idx].dev;
-
-out_unlock:
-	srcu_read_unlock(&kvm->srcu, srcu_idx);
+		return NULL;
 
-	return iodev;
+	return bus->range[dev_idx].dev;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_io_bus_get_dev);
 
-- 
2.47.3

