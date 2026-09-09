Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D452B1E4
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950649; cv=none; b=Sn8cY+D8k+J2+dCOcjh/5XR620kZWscs6Sw8UShDWuOe54IWSahXDE10RfvZytNUU+w0vl6TT2Te+VSWSRrTaOeJ8KSDJ9NUAnoxcJIRHME0EM+ze53nYjREPT8nblSbMujJ42zwR6wy4Eqak9Ghx6warTbr9jRDoZj0P0ldIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950649; c=relaxed/simple;
	bh=x8EA86TpRr9zYO4fO4wQtSvyuaX48hEbriWlDCWCVtk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KMXXtuysh+1tSiTEM6r65qp8E18HQQHrD4KddgzD4yWaiij/z+3he87j0i5PEfO+ym4DQFVXK6bdi/1TWRVsTv6znoaFrI+UDRhVbatt4mIJBrHBiH9IvT3tUVOTe+JcG6Pmvdo38aoOmMChWO1c0FzMiPlnu7PhcysIYXtBzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tzSrjb7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tzSrjb7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012951F00A3A;
	Wed,  9 Sep 2026 10:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950648;
	bh=fk18NM4fNcFdWoiAUDZBK8a3hLwU+Sc1vYZdbiD2C18=;
	h=Subject:To:Cc:From:Date;
	b=tzSrjb7ByDMUkstuDqSUds74RGshYEII9FAjQ/0KyFJZquapNfFB2KM2z5SnQ4YVd
	 IBytUBexbMxJhUH38bQlRDzmraziRMvpRWCZq0KBxbDnIAVBi//5qVQQAYnpaM03rd
	 VYzBftadkSrtoacKUYBFXsCnukLO4ToNIG4H6Eq0=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Service local TLB flushes on failed nested" failed to apply to 5.10-stable tree
To: yosry@kernel.org,sashiko-bot@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:33:53 +0200
Message-ID: <2026090953-storage-unbent-4b4f@gregkh>
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
git cherry-pick -x 05a0b701d1089fb57beeb8982f23c3bbafe0fa8b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090953-storage-unbent-4b4f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 05a0b701d1089fb57beeb8982f23c3bbafe0fa8b Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 22 Jul 2026 23:01:28 +0000
Subject: [PATCH] KVM: nVMX: Service local TLB flushes on failed nested
 VM-Enter

KVM services local TLB flushes on "full" nested VM-Exits (through
__nested_vmx_vmexit()), but not if a nested VM-Enter fails (e.g. due to
failed VMCS checks in nested_vmx_enter_non_root_mode()).

However, it is possible that KVM had queued TLB flushes that need to be
performed, even if the nested VM-Enter was not successful. For example,
if VPID is disabled for L2 (via nested_vmx_transition_tlb_flush(), or if
via the MSR load lists, as the SDM says:

  If any MSR is being loaded in such a way that would architecturally
  require a TLB flush, the TLBs are updated so that, after VM entry, the
  logical processor will not use any translations that were cached before
  the transition.

The SDM is unclear about when the TLB flush should occur, and whether or
not a failed VM entry would flush the TLB, so it is safer to always
do the TLB flush in this case.

More concretely, KVM also updates the last VPID L1 used for L2 in
nested_vmx_transition_tlb_flush() (i.e. last_vpid), even if the VM entry
ultimately fails. With the current code, KVM could miss a TLB flush if
L1 changes L2's VPID, then does a failed VM entry followed by a
successful one, as the failed VM entry would update last_vpid but not
actually flush the TLB. Servicing local TLB flushes on failed VM entries
makes sure that the TLB is always flushed when last_vpid is updated.

Fixes: 5c614b3583e7 ("KVM: nVMX: nested VPID emulation")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org> # Internal review
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260722230128.1587363-1-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0635e92471c8..5d5b5022438d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3765,6 +3765,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 vmentry_fail_vmexit_guest_mode:
 	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
 		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
+
+	/*
+	 * Handle any TLB flush requests that were queued for L2 if KVM made it
+	 * far enough along to switch to L2 context.  Note, loading host state
+	 * will generate any flushes for L1 required by VM-Exit.
+	 */
+	kvm_service_local_tlb_flush_requests(vcpu);
+
 	leave_guest_mode(vcpu);
 
 vmentry_fail_vmexit:

