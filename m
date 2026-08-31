Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726B1EEA3C
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179141; cv=none; b=AoT5kEYAJYWr5CI8+YG3o+CPLmELrJPAIyeH0xXEkz+rdXtf9CaCFRW/Ub2UxZP8+1V4d9Noa7rkoENcg1roZwTUv1fOn3UKk3L6JQ4pIOSCErw0AZStdrUj/MvKSHW+d4JD4mZnRhT0qoQM/agK5W7tKER1uyUweN6JAaGX0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179141; c=relaxed/simple;
	bh=hMg+feanPv/ir6qruvDT9hI9Cdi6tKe5+ICh7/ibTqI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Qb/99MeadjayXYXS0zQojd/+NHxtku/IaslXSKiBKwXWIPsdu4T1qBLJRvtKGueEgZ6yfUdxLKTgyIH3RlzKhKfCLTBAbvVfYqjui7HfXpzmnVbFrWB2FaQGudsEhN5Cm0+S76vfLHdicSP3KBT6mW8NWuJ3w/8hISw3XQlghak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B1LwI0zZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B1LwI0zZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F8E1F000E9;
	Mon, 31 Aug 2026 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788179139;
	bh=xgdqwquYGm4PlBo1qQpAf59KzAhVRdMwFx6LeDKbrdA=;
	h=Subject:To:Cc:From:Date;
	b=B1LwI0zZ5rlJL7Ud7Fo+VHei6evhc2dLAHdIK1Yth1wRe+/5UtNhcEdJXw9wBhOMh
	 1sEE+ix16JSLfYChvUilJUDZ3EorOAe8harrjNQgUx1r4sOa90O4+1rbhB/AUi8VmX
	 eQnEmVcBI8iwtABW0cZmSwLuSRhL6dilqew9NhHo=
Subject: FAILED: patch "[PATCH] KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is" failed to apply to 6.12-stable tree
To: seanjc@google.com,michael.roth@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:25:35 +0200
Message-ID: <2026083135-thud-surplus-53de@gregkh>
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
git cherry-pick -x 98ade8c48c28c227fe2e80e545ff0c57cd4712a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083135-thud-surplus-53de@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98ade8c48c28c227fe2e80e545ff0c57cd4712a3 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 9 Jul 2026 13:49:33 -0700
Subject: [PATCH] KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is
 unusable

Always mark the vCPU as RUNNABLE after responding to AP_CREATE, even if the
guest-specified VMSA is unusable, e.g. isn't backed by a memslot or doesn't
have a backing guest_memfd page.  If the VMSA is unusable, leaving the vCPU
in a non-running state will effectively hang the vCPU instead of reporting
an error to userspace.  This will also allow retrying the VMSA load in the
future, to fix a bug where KVM doesn't honor guest_memfd invalidation
events, e.g. if AP_CREATION races with PUNCH_HOLE.

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Michael Roth <michael.roth@amd.com>
Link: https://patch.msgid.link/20260709204948.1988414-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d8ed00f76aa3..30792adcfc8e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4028,9 +4028,6 @@ static void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	svm->sev_es.snp_guest_vmsa_gpa = gpa;
 	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 
-	/* Mark the vCPU as runnable */
-	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
-
 	/*
 	 * gmem pages aren't currently migratable, but if this ever changes
 	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
@@ -4062,6 +4059,15 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
 
 	sev_snp_reload_vmsa(vcpu, gpa);
+
+	/*
+	 * Mark the vCPU as runnable for CREATE requests, indicated by a valid
+	 * VMSA GPA, even if installing the VMSA failed, so that KVM_RUN will
+	 * fail instead of blocking indefinitely and hanging the vCPU, e.g. if
+	 * the backing guest_memfd page is unavailable.
+	 */
+	if (VALID_PAGE(gpa))
+		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 }
 
 static int sev_snp_ap_creation(struct vcpu_svm *svm)

