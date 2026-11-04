Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819870;
	b=EavgZcRwtQlPEae9vC4v1zx2mFC5nI20hxYiOl545H7r12r/ifjigRac4/XFZoysiiUu
	 oenaqEJ5JW4rVHCQQVxROFsZ7NaeNIoeK2WkGVE8z3AuHl8mX6IHRkhklRRw+IAdSTaLD
	 jGALYQISaC38wvEXFy2kGkTEyO8LxCxOklnCg+Qya1ijBU8fYukj8/Deb9jXIbxwAaR2Z
	 tk9kCG7z59wnnTUiA6UK6lxZEZEYwKtIBx3cNlewYpxHnoCYB9QGey3saONqZHraBLYGa
	 +rmBS6j1yLLa6L9uc6NqmihBKQggxqs+5++hIe913p4TnwCD3iVbFHCOO0HpXuA+3Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819870;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8zadNOOGfpnfTtXhLfHyjJhuBzjvVYuzbamBIhB5hRI=;
	b=fHzymIga0P/2joUFNKEnKyuOLrps8kVaqOJ1wJAE5lPACE75jFDIft3kPh6fPYZQM6Nb
	 R/fOHg2ijd2PKzo1etS650Mirh1vL8uc2Ma/1f37M+fwcHYz00ZSBAMXzc6WvVpHhs+3L
	 UdwOFnoz3YCzRUPqbuOS3WV8YX4GpeknsWy5UT5X4mnRe28h8hfDrkA3KN+nnz824SxIX
	 vzQ6R2kmAOENLNZGH3VcdORXGgX5sIK5c2EEPCz36AHdNe3QsO6DQdYFRDTIeKrv3XPK6
	 dgsefUw+RGjICt+kq9Uhv4GR29vkqaNx3Ts2rGLlw+pB4e2eA3/tEXV5cZ7yh6bc6AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DKAbrnt4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237D0606D81F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DKAbrnt4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757FE1F00919;
	Wed,  4 Nov 2026 19:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819869;
	bh=8zadNOOGfpnfTtXhLfHyjJhuBzjvVYuzbamBIhB5hRI=;
	h=Subject:To:Cc:From:Date;
	b=DKAbrnt4l/Go10rFlguVSI1Ox4pZxhM4rH7m+00c+aBqPOxunR5dv/2E2Sks2quop
	 fmwx1pVm5JV6s41/nfuzxm9wpVdtFnsbfas0FnzWVChuw85AievuyFINQVerYmi44p
	 1mXoxnFhfX3vAKxfuqd6k+wpnFzgA+8dPLlwxoD0=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1" failed to apply to 5.10-stable tree
To: seanjc@google.com,fane@google.com,yosry@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:17:40 -0500
Message-ID: <2026110440-diligence-kimono-b7c6@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5dc500a354cc8e109df678076ae3488094649468
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110440-diligence-kimono-b7c6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

