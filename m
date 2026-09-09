Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC9526A96
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950559; cv=none; b=Fmo+mias8vrtLC3bpsvFlXyu/fSp/eK/ss18ulY344RgEs7f7NDzriEjb98adcJR1HzoajQoEDA4KzV+yyTs+TVlPx926/sTzYGIlYNf2CHLsZJpZ1Vkv9sjJLC41kjtGNpzxtZw8e4Uh2+7luS3IO0LIpbNtVC0aCi7FT/LDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950559; c=relaxed/simple;
	bh=yENwILQxnJ/kUxRMQKlxdmVksXAFT7l/QtS7GYiH6Qg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a+O0Flh9STwuQOWflSQq9mhT21NEHarNTmMoDSWf70jSJxDwQZpPJoN6zAFiNpKPYUfyxeVwKRh0BRbWNPXlazimUSkgAdvsdJp/ZPz4eluR85tlaQu/W1GvgjnLNn4VdfoJdIcQNeRN8/svSDSp3OGRh0MFtH50Fy/X9Y2BPHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TN29bfka; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TN29bfka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648751F00A3D;
	Wed,  9 Sep 2026 10:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950557;
	bh=kf/Y5aKUb/pW2c07Uh8KGC0yRcCEYWo18bG1nvNVV5w=;
	h=Subject:To:Cc:From:Date;
	b=TN29bfkaCZnPgNig7G+RooFFdaagubfg8a9zfIfVI/xftWSmzE5YZQwoKH2N6Mnyd
	 gXEXFM0PM3WVm8sXhZL5yVRTi3us1EJO/0fAlsZhBLUSu9HEGbY1f2uaI4bAuKuFbI
	 GuVEJrll7V/vQ7zbyVKXqQ5B4Unlcbrz10+vZb6E=
Subject: FAILED: patch "[PATCH] KVM: x86: Check EFER validity on KVM_SET_SREGS*" failed to apply to 6.12-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:32:11 +0200
Message-ID: <2026090911-keg-hunk-4c3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 184bd464bdb66daa9173670904f24c29c7b7f7d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090911-keg-hunk-4c3e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

