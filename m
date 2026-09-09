Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E986524B07
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950556; cv=none; b=Y1DpaAhE3XVJaYMlmP0u8EnF4eW1ls7n65XIH5np7iDaVONI37oeqQmnkO+HhVWszGXeNkWxLhuTZjJnJKey2zfZXbctebm4XvepgVJbzMxzZQX8Ehl1+uApn8LfUYszRIQORI6DuAO6DSL79/g5gcQehRcQAdBWLfAevNfm1j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950556; c=relaxed/simple;
	bh=W3W6wO9aTxEKn+cUCIdvDSZ95PSVAKqIcEkzVHYPx7g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=usy2KALT0qUWw2ZzReiBPffY1keYbM47jqNfx0UbWrtAmnXqcyIGMAFkUChulNaxJ1Vg6WK9sjRbBl4xnXQffClsULGY6BIBsdHjmshzVgx/YvcHoE9sZAtacfV6SDcNbrcCU836G/AHnMLUrvT5p/NlMl7QJRJi33cr4C0x874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zVY+meFT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zVY+meFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997AB1F00A3A;
	Wed,  9 Sep 2026 10:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950555;
	bh=7hhWaZwp+iEB7SwOmOx3FCMl6Ipb7ZPgK4i3IiBamOQ=;
	h=Subject:To:Cc:From:Date;
	b=zVY+meFTXQzGrzCAjIrQIrRAHKE7vvtCruuJDrPaD94h/sh6r7ie/coxg4FugINud
	 YwnFwLpnTYUmKv6DPYkLzP3tHDy4IxNjJzB0LoFs11ueDsMVo78k2CDl0WzKqijzur
	 1WFgnhPgh42jyeqsMMCuZ0IoSVOkdUudOGEkjojI=
Subject: FAILED: patch "[PATCH] KVM: x86: Check EFER validity on KVM_SET_SREGS*" failed to apply to 7.2-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:32:10 +0200
Message-ID: <2026090910-manned-fang-c784@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 184bd464bdb66daa9173670904f24c29c7b7f7d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090910-manned-fang-c784@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 184bd464bdb66daa9173670904f24c29c7b7f7d4 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 13 Jul 2026 18:01:52 +0000
Subject: [PATCH] KVM: x86: Check EFER validity on KVM_SET_SREGS*

When handling userspace SREGS writes, check the validity of EFER (i.e.
allowed bits) before writing the new value of EFER through the
per-vendor set_efer callbacks. This prevents userspace from writing
bogus values (e.g. EFER.SVME=1 with nested=0).

Note: on KVM_SET_MSRS, KVM only checks EFER validity in terms of KVM
caps, not guest caps, so it is possible to set EFER bits that are
supported by KVM but not by the guest CPUID. Potentially allowing
userspace to set msrs before CPUID.

However, for KVM_SET_SREGS*, check the validity of the set bits against
both KVM and guest caps. This is consistent with other validity checks
(e.g. for CR4) that check validity against guest caps, which already
imposes the need to set CPUID before SREGS.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260713180153.2728382-2-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index bd8147798cc3..8f66438989e4 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -564,7 +564,8 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	}
 
 	return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
-	       kvm_is_valid_cr0(vcpu, sregs->cr0);
+	       kvm_is_valid_cr0(vcpu, sregs->cr0) &&
+	       kvm_valid_efer(vcpu, sregs->efer);
 }
 
 static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,

