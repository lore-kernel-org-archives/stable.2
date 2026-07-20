Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DA2414A0B
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550086; cv=none; b=g7lsAvT/EA48SfikgiN0tSmbpR+25bgLC4Kif6bssBaYvdjT3zCmkqs0tVDhkDRNaJYM6YkKSzjJXs+gA5QntxyU5HTuyF/72bmWQp6IGL01hI7P455++v8MhoIViVkshWTLwCFdyIrOYs2JPPJVP7Y8G+1J3txhs+Uh0pHZz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550086; c=relaxed/simple;
	bh=YauDhGwPWUCJv14J/Gnvukj95dvJgoPdwwrzOWCua8s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E8V72rfMNSeTo6ZGlBB98mCOQnp0id6w5bkTM4anYAaLC6zy+q/DclvBbVsEe8sIsX1sgZL22O8CTDNx6G46MbRP35HnOkcR2hXV/7BPn+vB1XLMmpwueXGyHaAmQzsb+5Y0aLsckSuyOKoApOu7toJMQlJcBBFxQn/n25i/WJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zs5ileIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zs5ileIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3A81F000E9;
	Mon, 20 Jul 2026 12:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550085;
	bh=xPRn2kdJxYHZtyw4xXr9TacPNh6uX2NerSwQd12Hm6c=;
	h=Subject:To:Cc:From:Date;
	b=zs5ileIexoSlYLfKY+fdFXHfNzDRTSeey0bnD4WEBFGqtEsMb3Gcg2JcKApvNYJlY
	 iBcf75jk94k6I2K7ySCaavslqx7yrbpQeIo/LPW3EQ6abtrg9VEHZN3vSBLf/AdBAf
	 XmRcwVgKFdBVBJNsUbSL10PElBlmpNMaTO3mFyC8=
Subject: FAILED: patch "[PATCH] KVM: Move kvm_io_bus_get_dev() locking responsibilities to" failed to apply to 5.15-stable tree
To: maz@kernel.org,oupton@kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:21:06 +0200
Message-ID: <2026072006-vixen-purging-6bf2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3a07249981629ace483ebbef81ef6b34c2d2afec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072006-vixen-purging-6bf2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a07249981629ace483ebbef81ef6b34c2d2afec Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Sat, 27 Jun 2026 11:51:05 +0100
Subject: [PATCH] KVM: Move kvm_io_bus_get_dev() locking responsibilities to
 callers

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

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 67d107e9a77d..c90abde39fb8 100644
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
index 89489996fbc1..5788eac0ab81 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6068,25 +6068,19 @@ struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
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
+		return NULL;
 
-	iodev = bus->range[dev_idx].dev;
-
-out_unlock:
-	srcu_read_unlock(&kvm->srcu, srcu_idx);
-
-	return iodev;
+	return bus->range[dev_idx].dev;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_io_bus_get_dev);
 

