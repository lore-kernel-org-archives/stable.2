Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612CA417D68
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550690; cv=none; b=sW5lM3HfhCemRsparzMFYIwV3UpG/4z5RqeENk5C+M+ZcNnu4wCOam547ypp9JdQwL1u9c2uuDw136g9uPbxEWbf7GgiTRx5HAy/GBibLqj9OW6QPFW5oeFywwFkClOMxzoClHRkC6XIVjWBOFeAdLjhiSWMsGC6oxEEcbvVooM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550690; c=relaxed/simple;
	bh=qJ8sEr8MTVgMrql8CuQRCZmzWCuxKUeJH+VqYYtFwAU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X5vdx7g/pkZFgAuuZ+dusIs+WJTPY6pxbg20c0cNHRrKhT16mH3b3Q0Q3lZlS0Kf9hN4G7hPWEo4GV1zMapkaYFVADyFwtJne2cVk2rKuv1hr0VjssBM6MMBJ+r2mZN5oPtSCZzOsZzHUUADdAMQh6PAKVkWfXB4yU3MejtgiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RY+dZQR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RY+dZQR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C709D1F000E9;
	Mon, 20 Jul 2026 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550689;
	bh=4s7WvDDz6YXzW68PB3V6vINt5fRka3V2mlCikcu9i6Q=;
	h=Subject:To:Cc:From:Date;
	b=RY+dZQR59cMyISyWGA6pyagIJuzCS32ZEZvk5SMfkEkuCLs2sluH22bE1URaHETZv
	 ziXeUf9RLvVtat4o+rMOSxBx3XM6sUHT6Qe3XX3W6FYeB2EvBUznUdOdSRxPzi6T4U
	 cDp2MoQXuUHLrZiGRFIdGQoSoMvSCSfDj4LZ2xFs=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to" failed to apply to 5.10-stable tree
To: seanjc@google.com,minhnguyen.080505@gmail.com,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:27:14 +0200
Message-ID: <2026072014-rejoice-bridged-72a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 2f2312c422fd2695da772cecb30c69994b795964
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072014-rejoice-bridged-72a9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

