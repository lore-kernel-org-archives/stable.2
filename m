Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A341736A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550693; cv=none; b=seHgLH263vMNfgQrNWYJxBf8qY9RUeTp9ZvtIXTapB62jv6DdHCOJSALfCn9o8HWjbY8H3ojNHM6IdEMGLO29zgQWVj97zeQZ41dVVlXcP1aWH69ppcanGuapJVTWqDZ8Aja+FgFRYtWYTd8RQQO9NEFMe9OuoLBjSTaAlM79QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550693; c=relaxed/simple;
	bh=oqnNnEKB1XdRTDbEgoT5Q23E1MiZJYVWB8jNFFhR/h4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sRUk3ERRzDtS6GtgFAeRyySR1gWqpK8fqsiQaBUv9tjkQoUCRcQs8gfdHUTfIPND7ec9HsNN/KRc3S0hw/sPrYt4HlQqNMIvcI7XJuVJOPvUN2gJxkL87RyA9QkY2SpTvYW2SYgrVZhW+J7Zrxyc1OvSh6KWGBcYorfr6IJRwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eFeKPZeE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eFeKPZeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2161F000E9;
	Mon, 20 Jul 2026 12:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550691;
	bh=fWCWGwL2s30drHIBG4/f0xegVzwdP3VaZacG3wHrShs=;
	h=Subject:To:Cc:From:Date;
	b=eFeKPZeE4ELp4W9pJLI1Gz9ND8npKoJE5NlYk0pgk6046GI3XvSTk3qkN5V5VA9xy
	 KyGALXFA3oE8m/Rp9I7BGgsIJLshnoTGOCOn8YcDY1ZC5aYbimBE5bDmwK1ZNrWg5v
	 V28sf/nHVOCQlCjmsHBDKnLLrUmEWzRr3U84tcmE=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to" failed to apply to 5.15-stable tree
To: seanjc@google.com,minhnguyen.080505@gmail.com,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:27:14 +0200
Message-ID: <2026072014-animation-handshake-ad93@gregkh>
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
git cherry-pick -x 2f2312c422fd2695da772cecb30c69994b795964
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072014-animation-handshake-ad93@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f2312c422fd2695da772cecb30c69994b795964 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Jul 2026 09:03:06 -0700
Subject: [PATCH] KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to
 invalid guest state

Put all vmcs12 pages if KVM synthesizes a nested VM-Exit due to invalid
guest while emulating VMLAUNCH or VMRESUME.  The invalid guest state path
doesn't use nested_vmx_vmexit() as that API is intended to be used if and
only if L2 is active, and the open coded equivalent neglects to put the
vmcs12 pages.  Failure to put the vmcs12 pages leaks any pinned pages
(and/or mappings) if L1 retries VMLAUNCH/VMRESUME.

Note, the !from_vmenter scenario doesn't suffer the same problem, as
vmx_get_nested_state_pages() only gets/pins/maps the vmcs12 pages if L2 is
active, i.e. if a "full" VM-Exit is guaranteed before KVM will retry
getting vmcs12 pages.

Fixes: 96c66e87deee ("KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page")
Fixes: 3278e0492554 ("KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt descriptor table")
Fixes: fe1911aa443e ("KVM: nVMX: Use kvm_vcpu_map() to get/pin vmcs12's APIC-access page")
Reported-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bb0eb40b4448..220d42ebc82e 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3761,6 +3761,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	if (!from_vmentry)
 		return NVMX_VMENTRY_VMEXIT;
 
+	nested_put_vmcs12_pages(vcpu);
+
 	load_vmcs12_host_state(vcpu, vmcs12);
 	vmcs12->vm_exit_reason = exit_reason.full;
 	if (enable_shadow_vmcs || nested_vmx_is_evmptr12_valid(vmx))

