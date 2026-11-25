Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603151;
	b=divvXzF/9yJvB+s8X6xdj7xIc7+V9QaS/rH2IO08jw2OE5y1pkkJUc4n0cawVYmJUHem
	 KphssfNkJcuhi3cgB5Lclalj2caeXBs1hPAnZcArdsf0/tYu41p/Fi/cwH32hhWJOtq52
	 1wBaX2WiCx/jp4e9Oc+x4WnAPjj2IKzllXSWQWAfzxaAtuHouuLu4zEeGZWrD4gPu32XV
	 7jLMarZ5HGOzRX1mfSvTckJBvLe2TPgYZJ3Nu6gtKngGQzqnWoWLvf5lOeIssosKehAzO
	 be7P154sivtlnVVpdT6nvh7qe9iCLfteEVLW5Xl7r2PuXZHvDGIbg3EFBss6qfKIVrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603151;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=n+dZ8k/OElg3IPFIaIr90/YLXuPseDB5sK8iXFBb5jA=;
	b=Aaq2nplW3YMDT2cAxpGtUq9efUm0hLq876tPafNhHAFndtWQHNCBnFVtlNrW8gwm30IG
	 6elYniNQivY9MYOfNv7KRDb07Q59eTG3pFvU6SmQevDjKIi+CDtc+zHBSB9HR0DKD8ka3
	 TzV591dyRFgJjt7ulJbzKzHjDwWNmqH+xxL7ws8yKZsRaSddXu72TYQtujUlc7yE9HpcK
	 LLKOcELcFIA5TltV2TuRFLeoJcwx+Ra2zMARtu6WQOh5n049bWy+bFIKJWhEV8xv5yYfp
	 gOV5pvO8wY13lEn0/msTqDld18CLvA25bn3KM8Mg5jhFOlOc0mAD0YPM/ZQY/R6aS2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fl8GGc2D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99F606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fl8GGc2D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8261F000C0;
	Wed, 25 Nov 2026 10:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603151;
	bh=n+dZ8k/OElg3IPFIaIr90/YLXuPseDB5sK8iXFBb5jA=;
	h=Subject:To:Cc:From:Date;
	b=fl8GGc2DT86/6uP2E6+WCXvSpSMn+yp7OYt0b4wNywgjDhkffaw4cAOgTbEZNqnk9
	 +n1TtwSw/9xHp7oQV+VXuEpuV0/Ah5F2bGB335mwGoKk4fdqG5NpT6Dw6qd1ru4C1i
	 oImPzXcG3tZ/kCsFT1+NeDOnOHl0Bo6n+m42LXQI=
Subject: FAILED: patch "[PATCH] LoongArch: KVM: Clear device pointer in irqchip destroy" failed to apply to 6.18-stable tree
To: cuitao@kylinos.cn,chenhuacai@loongson.cn,maobibo@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:27:32 +0100
Message-ID: <2026112532-hamster-banister-f7da@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a9ce1a00afb0402668877d37c04ffd0e53d48832
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112532-hamster-banister-f7da@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9ce1a00afb0402668877d37c04ffd0e53d48832 Mon Sep 17 00:00:00 2001
From: Tao Cui <cuitao@kylinos.cn>
Date: Tue, 10 Nov 2026 17:20:39 +0800
Subject: [PATCH] LoongArch: KVM: Clear device pointer in irqchip destroy
 callbacks

The destroy callbacks of the four irqchip devices free the device
structure without clearing kvm->arch.{ipi,eiointc,pch_pic,dmsintc},
leaving a dangling pointer. ops->destroy() is not only called at VM
teardown but also when KVM_CREATE_DEVICE succeeds and the following
anon_inode_getfd() fails (e.g. under RLIMIT_NOFILE); the VM stays
alive, kvm_arch_irqchip_in_kernel() still reports true, and interrupt
injection dereferences the freed device.

Clear the pointer when destroying.

Cc: stable@vger.kernel.org
Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
Fixes: 2e8b9df82631 ("LoongArch: KVM: Add EIOINTC device support")
Fixes: e785dfacf7e7 ("LoongArch: KVM: Add PCHPIC device support")
Fixes: 229132c309d6 ("LoongArch: KVM: Add DMSINTC device support")
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index ff327b4c05f7..c182185a3d59 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -146,6 +146,7 @@ static void kvm_dmsintc_destroy(struct kvm_device *dev)
 		return;
 
 	kfree(dev->kvm->arch.dmsintc);
+	dev->kvm->arch.dmsintc = NULL;
 	kfree(dev);
 }
 
diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index 80f78e07c74a..fe0a1918f26f 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -675,6 +675,7 @@ static void kvm_eiointc_destroy(struct kvm_device *dev)
 
 	kvm = dev->kvm;
 	eiointc = kvm->arch.eiointc;
+	kvm->arch.eiointc = NULL;
 	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device_vext);
diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
index 80faa770c0cd..7a2dd72a4952 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -441,6 +441,7 @@ static void kvm_ipi_destroy(struct kvm_device *dev)
 
 	kvm = dev->kvm;
 	ipi = kvm->arch.ipi;
+	kvm->arch.ipi = NULL;
 	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &ipi->device);
 	mutex_unlock(&kvm->slots_lock);
diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index 220fc23ffe8c..dab2d3f1b8f6 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -483,6 +483,7 @@ static void kvm_pch_pic_destroy(struct kvm_device *dev)
 
 	kvm = dev->kvm;
 	s = kvm->arch.pch_pic;
+	kvm->arch.pch_pic = NULL;
 	/* unregister pch pic device and free it's memory */
 	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &s->device);

