Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6942475CB
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681949; cv=none; b=QSvvdxv0MirPlUEUeJkiJH6+uZxjw3m143MTFwfJ3oWlhEo62hLIQnbiU6XfVYN+QZnPD6AvD5aA/1VPNgKCdmxu/aJmn1jajojBcASX1ytT9oStrS7uAibgwE5pIc5vBIxASBFT5SZKLchoUk3Q64UK7kwAQ5XlgiNMVZpcIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681949; c=relaxed/simple;
	bh=blpRqCGYbqWxOMWebkbgaSvmHpoqU498mTUWtkhlIVs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D1TC5Cu+Cs3S8uiXpgN2TIphcFAzVZ/SP37XMxzk8JgRawPgyJGZ4zSvBo0605Kg+BS0c7ZQcNL89JiEgy/lIm0KrDtw6QEvAHqd2IlVxFGIBVHvEn3PKnZYpIYHN3KjPxXAAfvNsjNYYMVz2EE/EMJjQ+m2/Xy6HkNu7NIOj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qo/Pbsi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qo/Pbsi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675A41F00893;
	Tue, 29 Sep 2026 11:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790681947;
	bh=bHOQXx2D6sEoX2GoJjhLIYbb2jniuU7VDr0Vvb4jzys=;
	h=Subject:To:Cc:From:Date;
	b=qo/Pbsi87gEe5gm0AYX0Ymjsdk4IWc6l4WhPUai+g/gi91QP3lhE0K6lrQpD8HG8n
	 scLoHCwU+InVGt6XAwgdRHK5xybPKCtxfpgvpWcDlkg4vxrShHsnVXQyxUtYAJtV8x
	 cwdEuAwPLmsFAlulHpz/XWpDHQOI4YFX/fI2ugUk=
Subject: FAILED: patch "[PATCH] KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said" failed to apply to 6.18-stable tree
To: seanjc@google.com,fane@google.com,rkskek9254@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:38:45 +0200
Message-ID: <2026092945-breath-candle-8e2c@gregkh>
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
git cherry-pick -x 10180a277549339020b08000206092c07e0bff5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092945-breath-candle-8e2c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

