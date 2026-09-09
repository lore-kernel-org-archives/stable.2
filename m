Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922213AA9E2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950755; cv=none; b=Zfs/Jc0BISb37W/tW4wKQ9XpqLafi5veHHhnz2Tqb9h0Tf/D3eIgizNd6awzTh2T3zSSCnEoKFRDnucEKSrX+oyU4DhaQDQhoKTCbvOVM9qDe4TijLPu6B99bUO6KUH0cimEMysJDwKp6jCWQOv+G545T6Qzwk6vRuj7jCOTiX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950755; c=relaxed/simple;
	bh=KhgO520HssDdJ5B4MsQ+4mMfie7Fg+V76uPiBFiFkbw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ocCFKU/8r1kDDdzFP5jvyhroDSk5v+malJwym8mhihGdMx9+G5nXFhT4axKWWlWwwhzsVGdDOmkyiMFcUWBWms/KiLkc7H2KiMvAJOQiiMzz5Z5s1iu6D9hQZIqYMWak9WqBN6VWa0IRsUzTs1s1MH+ds35SNJGHMXs+0fNWleE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KkEzwM8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KkEzwM8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA311F00A3D;
	Wed,  9 Sep 2026 10:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950753;
	bh=ot4MkM3Kfsk4Xs0jpG270RL63rte1Ko6WdHJV6s97YY=;
	h=Subject:To:Cc:From:Date;
	b=KkEzwM8ZtsoXV/OmMPQk2wgUouQfJ4g0yg7J3ppYZ3y6/GTErkNLoO05muTFvs8pd
	 kClDSXSJJlCIO/Sjq7TIYLz6GZ9Rtp63Kk0TFdzZBUZF68m0t47b+8biQ16AHP6/XY
	 a5gMssjcDzNH4fudQp13DrCjPPrUfc8Jw7g7+dwM=
Subject: FAILED: patch "[PATCH] LoongArch: KVM: Validate MSI data before routing it to" failed to apply to 6.18-stable tree
To: zengchi@kylinos.cn,chenhuacai@loongson.cn,cuitao@kylinos.cn,maobibo@loongson.cn,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:38:55 +0200
Message-ID: <2026090955-troubling-exposure-3a3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 501514d6ebd2111c353a1296f25dbe22fbd64657
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090955-troubling-exposure-3a3b@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 501514d6ebd2111c353a1296f25dbe22fbd64657 Mon Sep 17 00:00:00 2001
From: Zeng Chi <zengchi@kylinos.cn>
Date: Fri, 4 Sep 2026 21:45:13 +0800
Subject: [PATCH] LoongArch: KVM: Validate MSI data before routing it to
 EIOINTC

pch_msi_set_irq() passes e->msi.data straight into eiointc_set_irq() as
the irq number. The MSI data comes from userspace, that either via a
KVM_IRQ_ROUTING_MSI entry set with KVM_SET_GSI_ROUTING (used by irqfd
and KVM_IRQ_LINE) or directly via KVM_SIGNAL_MSI, and is never checked
against EIOINTC_IRQS.

eiointc_set_irq() uses the value with __set_bit()/__clear_bit() on the
256-bit isr bitmap, eiointc_update_irq() then indexes sw_coremap[] and
the per-cpu coreisr/sw_coreisr bitmaps with it. Therefore a data value
>= 256 reads and writes memory past the end of those arrays, i.e. any
process holding a VM fd can corrupt kernel memory beyond the allocation
of loongarch_eiointc.

Reject MSI data that doesn't fit in the EIOINTC irq space. The DMSINTC
path is unaffected as it decodes the vector from the address and masks
it.

Cc: stable@vger.kernel.org
Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260531140921.1B1181F00893@smtp.kernel.org/
Reviewed-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index 83fa2386cf81..2b63b0c2c7ce 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -78,6 +78,9 @@ int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e, int
 		return dmsintc_set_irq(kvm, msg_addr, e->msi.data, level);
 	}
 
+	if (e->msi.data >= EIOINTC_IRQS)
+		return -EINVAL;
+
 	eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);
 
 	return 0;

