Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3025B2F4
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210916; cv=none; b=atlspa/WPFwLK1dUO5nzXkqI4NA8pJKo0lQIr2zpeOGnjyOMz4/cbMbhMdw5Rv0wVlekQ5umjfCE+scLiQxbPlFTYvEFWXpcR60DmXZ56vZZyYvuReOsJZjlqhiAQVT9daF0B6VRK8EK57Ebxvnu2wTwXZfVnIeYUTy+Z/gQQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210916; c=relaxed/simple;
	bh=1BHaUamwyO2bP2R5qbhMQ2ESmRAcqjHW7zY4z8Ow8UI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r5mKvMJCIbOB0l08pRsyNC/lHFDSx4v2FzZSgWCjvCPIpszJ0NeGt+6b+neBlGRcInc7ecNyIsCwZvBNxwqHnRBP8wsvgipd+h90tiMxqXwdJKqtxk/f3x8PMJo4yzPQVbIWcaGGh+iUbkt5fnrZKHxBNocBHLPJVURGWUxamN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N9zown2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N9zown2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416891F00899;
	Mon,  5 Oct 2026 14:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791210906;
	bh=ilF7jikRxREEf5lwvCiGQ6jaqf1f0fVpGqJ7YnYAMq4=;
	h=Subject:To:Cc:From:Date;
	b=N9zown2knbqgC+40M2IFh+MeSCMFRnyStj9G3zdjQn1fzl7ga9WX/f5pAmdxS8E67
	 Kb1ESNBfDOJKKFc7wHjinKJ+WAY2oyhVMbT86bUBF2l4RIuJnC8zgHOj33M5+klvVU
	 c61r4tOC3bMU4thiMdqdo5obN5X0kbZPLjex19mI=
Subject: FAILED: patch "[PATCH] KVM: SVM: Use the active VMCB's MSR bitmap when checking if" failed to apply to 5.10-stable tree
To: seanjc@google.com,fane@google.com,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:34:46 +0200
Message-ID: <2026100546-opt-ungraded-e3bc@gregkh>
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
git cherry-pick -x 9e06bbb9ade7cdf28d4a3b5b14e5812881c8df85
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100546-opt-ungraded-e3bc@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9e06bbb9ade7cdf28d4a3b5b14e5812881c8df85 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 12:58:33 -0700
Subject: [PATCH] KVM: SVM: Use the active VMCB's MSR bitmap when checking if
 MSR is intercepted

Use the MSR permission bitmap of the active VMCB instead of assuming that
KVM is always using vmcb02's bitmap when L2 is active, as KVM uses msrpm02
if and only if L1 wants to intercept MSR accesses, i.e. if and only if KVM
needs to merge msprm01 with msrpm12.

Don't bother tracking the virtual address of the bitmap that's being used,
as __va() is cheap on x86, and caching the virtual address would introduce
yet another source of potentially stale information.

Fixes: b2ac58f90540 ("KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260826195833.844526-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f4f488328ea4..fe0cba4731b2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -673,16 +673,7 @@ static void clr_dr_intercepts(struct vcpu_svm *svm)
 
 static bool msr_write_intercepted(struct vcpu_svm *svm, u32 msr)
 {
-	/*
-	 * For non-nested case:
-	 * If the L01 MSR bitmap does not intercept the MSR, then we need to
-	 * save it.
-	 *
-	 * For nested case:
-	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
-	 * save it.
-	 */
-	void *msrpm = is_guest_mode(&svm->vcpu) ? svm->nested.msrpm : svm->msrpm;
+	void *msrpm = __va(__sme_clr(svm->vmcb->control.msrpm_base_pa));
 
 	return svm_test_msr_bitmap_write(msrpm, msr);
 }

