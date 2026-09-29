Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038EA37F32C
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681955; cv=none; b=p2d7WNZSBmJAxJjzisPxVos+/xe94uzMB2YpQSoXjPmh4sWyNXeu4l1LXJfuGcKxy30necMuQgsMKhiVitdqt/43dlBkinnOPFTyhQTLEJq6b1gqJFB0N8gZ4z5woHp057LJRS2H50bAdBjxm2dmGKX/mwCflw3RfpSwv3Invcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681955; c=relaxed/simple;
	bh=PMOM7pO9q+5r3fxvsVjLzxv6LBxyXB+usTsb3wW5X7Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EWWmSM6fP5TPcY6OQ7LCWe2B7siEOZ2zOCqhLApdbmSP4HQQROoSTab/klYGqVgr5e57iT/yIYCQ++WBLgdSmoYkMLVG6E25WF1Q7yYBXa3gFxdt8Af3RdLZxLjRWKb8pS6/++3CivyyPF0z7U901yIACuM6WJAZ6frcWSYSNQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cbasBxNR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cbasBxNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108361F000FF;
	Tue, 29 Sep 2026 11:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790681953;
	bh=rQDE0XjnJa8/mu9GNoPiODJUrHRbdETqRjbu0v3eAHg=;
	h=Subject:To:Cc:From:Date;
	b=cbasBxNR06QEFYjU6nuXmRNcNuLdqgAIt7LvwaoBiJDShdChObw3KTJRF/o+Pmboq
	 BZjNeNawVOug8tFGZGcl1wyGwDT9rduGREvCBEV4J3v1KlTYNLrz+yciW4SfrzdioK
	 6RFw4+60RLd1mvLt5Fdf4nRMJblOfKrlpAlwcP3s=
Subject: FAILED: patch "[PATCH] KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said" failed to apply to 6.1-stable tree
To: seanjc@google.com,fane@google.com,rkskek9254@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:38:46 +0200
Message-ID: <2026092946-laxative-rival-2080@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 10180a277549339020b08000206092c07e0bff5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092946-laxative-rival-2080@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 10180a277549339020b08000206092c07e0bff5a Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 14:16:07 -0700
Subject: [PATCH] KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said
 pages fails

Re-pend GET_NESTED_STATE_PAGES before exiting to userspace if getting the
nested pages fails in the KVM_RUN path.  If userspace re-runs the vCPU, and
vmcs02 holds valid PFNs from the *previous* run of L2, then KVM could
re-enter L2 with stale, unpinned PFNs mapped into e.g. the vAPIC page.

Note, both SVM and VMX (as of commit 11722439fb20 ("KVM: nVMX: Ensure
KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exit") ensure the request
is cleared on VM-Exit (including the "forced" case), i.e. there is no risk
of double-mapping due to emulated VMLAUNCH/VMRESUME/VMRUN *and* the request
trying to map the nested pages.

Fixes: 671ddc700fd0 ("KVM: nVMX: Don't leak L1 MMIO regions to L2")
Cc: stable@vger.kernel.org
Reported-by: Jinwoo Lee <rkskek9254@gmail.com>
Closes: https://lore.kernel.org/all/20260813043932.3214460-1-rkskek9254@gmail.com
Reported-by: Stefan Teodorescu <fane@google.com>
Link: https://patch.msgid.link/20260921211608.1030158-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a137dc6dd8c6..4ec17aaff413 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8072,6 +8072,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
 			}

