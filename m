Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819858;
	b=dtwM3UvcXudH6vYzNQZXrNtGxW7Zs41CCCYSYUxQfQx020T31WbVm2AHwS/2OnOWrmM6
	 i/FxX8OpsGLIzIEQmVBe4eZwk05RF2t3XilXFOW8+zNFpNzhTp5+luclSZpzw//LSZlyP
	 W+bPc2FlNwDG597R0YGItELxGpeuSiKcfVGHvoVfSI2QcfLA6CRldPl+N3lKklaUuIeKB
	 BGkQRVwehhT35TKt8cmgpIjyS+/4d7dS9eo7lLAg38cpV8B/OCl+JZ/3JX4vVF2qP9sdf
	 Bpa7jT8+N6KwLx8WqNozZ2kOQWqPZA6a0EN9GQBwVFVza0/1+mpbPNGQqDcw+TQzVlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819858;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XX6MHhEcTwviLZTgZ1WtUR05w2HpQZTSiYVyDlpQbhU=;
	b=MpRbOQMXaQWFnfDgjyfGGSHyA/B+2GkYENTorS5kHBDrGv8yE3xGumzSh/8vwNLARVYE
	 MwQ4fGLDejnX8LYgYYBgyHMXL7u1nVQ6zoe50YNyGJCFxHWSZUBSEBbARh/IPGB8eAo1n
	 LiBzuf/wIibYI9hAmZsAcKXM55yNgoaJjOT3jvjjxLjJj8bNSNcG2eLXacH9Z3/lgJicT
	 CO9I6+OaY7hiM//VGycHlcR9HROvUbTD47zAYbfc8au6MnE2xnINAJmPTRxZPAniFjAC0
	 mcur4AmvIySD+nBqHWiDAhXeeecGGvAFN3WDjBDXHzi07hHYK/MkKW4755WDS0Dqjyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oW5QqBbr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119FE60A3825
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oW5QqBbr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61181F000C1;
	Wed,  4 Nov 2026 19:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819857;
	bh=XX6MHhEcTwviLZTgZ1WtUR05w2HpQZTSiYVyDlpQbhU=;
	h=Subject:To:Cc:From:Date;
	b=oW5QqBbr2/rzwGaE6oQ9OYYu9mVEl1+DvO7Hgzq9PBkydgLcRS4NYNgl+kae53r3m
	 0i57XN9gjYegVw3O4DcqFy8ysJaNHX0kxqS8DmyTEGUs1MXdFrMB1uBQuwzn2uMhWT
	 E3tNBq/zTdoXMiXAA7eOFEIELG3rxmmDTr9gneqU=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1" failed to apply to 6.18-stable tree
To: seanjc@google.com,fane@google.com,yosry@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:17:36 -0500
Message-ID: <2026110436-sequel-runner-492c@gregkh>
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
git cherry-pick -x 5dc500a354cc8e109df678076ae3488094649468
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110436-sequel-runner-492c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5dc500a354cc8e109df678076ae3488094649468 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 2 Sep 2026 16:20:24 -0700
Subject: [PATCH] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1
 && EFER.LME=0

Reject KVM_SET_NESTED_STATE if the incoming L1 host state has what is
effectively an impossible EFER combination of LMA=1 but LME=0, i.e. if the
state says long mode is active but not enabled.  Unlike VMX, SVM doesn't
have an explicit consistent check for the illegal combination; presumably
hardware simply ignores EFER.LMA if EFER.LME=0.

Unfortunately, KVM doesn't ignore EFER.LMA in this case and consumes the
illegal state when constructing the shadow MMU for L2.  E.g. if userspace
also clears CR4.PAE, then kvm_calc_cpu_role() will compute a role with 4 or
5 levels of paging, but shadow_mmu_init_context() will wire up the MMU to
use the paging32 template, which maxes out its levels at 2.

Note, the "real badness" is effectively the same as what happened with the
nVMX bug fixed by commit 112e66017bff ("KVM: nVMX: add missing consistency
checks for CR0 and CR4").  Unfortunately, the sanity check added by commit
72e2fb24a0b0 ("KVM: x86/mmu: Bug the VM if a vCPU ends up in long mode
without PAE enabled") doesn't work for this case, since L2 state is active
at the time of the page fault, but it's L1 that has the bad state.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
Cc: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>
Reported-by: Stefan Teodorescu <fane@google.com>
Link: https://patch.msgid.link/20260902232028.2767071-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 73f37b050d0a..49fb10ad1f9f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2028,6 +2028,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(save->cr0 & X86_CR0_PG) ||
 	    !(save->cr0 & X86_CR0_PE) ||
 	    (save->rflags & X86_EFLAGS_VM) ||
+	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
 	    !nested_vmcb_check_save(vcpu, &save_cached, false))
 		goto out_free;
 

