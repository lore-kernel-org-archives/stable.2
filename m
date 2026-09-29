Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C351475B
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681916; cv=none; b=nXXjQMbcX9eWtYWI9uDpuPPmfl5P5K24XjHMtnjPTdtd+AyOtfOOmejafafQs+eU8ywiO63Jgpk6oRNaFZs2XgsLJr2eaqCwxTvQZpIedh3aM1emvRG1XTa8Ut39T473ohYL7sKB4yuYa+v91eTPuVprZEt1V1iMWBiF8b1z+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681916; c=relaxed/simple;
	bh=2qYAeGrfBsQCAM0iSLUWVda2RIfRZbTLBpIDxyVHX5g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VEJyAbV/5OrtidlJE1VoB5WxWeNbxP/Si4BJYy4FbeN3H+mAT9/5dzpiQP4XuEfnqPR2I0NUMbfR4GlCdYbqtqgQKzAdsnWb13TVeVHDt5lMKVwaDSyMdx7RC2w6CvZNx7VYJsL5XJRvQc4bDYCmycdJ0ccMDCedcDDuUrsASJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xk3+Mlot; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xk3+Mlot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552DB1F000FF;
	Tue, 29 Sep 2026 11:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790681914;
	bh=r9cbkGGsNxMr1/ayQCVm0OkduDzkPl9JJSt448oUsZM=;
	h=Subject:To:Cc:From:Date;
	b=xk3+Mlotd1apAwgtl01uI9hac7ZFHP/BR6i3aufuSmdxD209lA+b+9PRKpTb/ktFq
	 ClYvjR5Ohwj6eJsNCNyuFrKPG2boFze5YBXXGLpkCWDFXGjw8L7f/fWD3477jKuJf3
	 u1OOmVSvXuKUWH+o60vqmK6y4ihXUSwqKiyoPRGs=
Subject: FAILED: patch "[PATCH] KVM: SEV: Do cache maintenance on the source VM during" failed to apply to 6.1-stable tree
To: seanjc@google.com,fane@google.com,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:38:19 +0200
Message-ID: <2026092918-shimmer-unhitched-7560@gregkh>
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
git cherry-pick -x 93de2a6a4b91b72607136dd656edf03fb399d27f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092918-shimmer-unhitched-7560@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 93de2a6a4b91b72607136dd656edf03fb399d27f Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 23 Sep 2026 09:37:21 -0700
Subject: [PATCH] KVM: SEV: Do cache maintenance on the source VM during
 intra-host migration

Manually perform cache maintenance on the source VM during intra-host
migration to ensure no stale data is left in CPU caches after the VM is
destroyed.  Because the source VM is "converted" to a non-SEV VM, KVM's
memory reclaim flows won't trigger cache maintenance, e.g. when all guest
memory is reclaimed in response to detaching from the mmu_notifier.

Note, relying on the destination VM to do cache maintenance isn't an option
as KVM doesn't require identical guest memory configurations, i.e. the
source VM may have access to memory that the destination VM does not.
Enforcing equivalent memory configurations is infeasible, as it would
require a *deep* comparison of memslots, e.g. to verify that not only are
the memslot identical, but what the memslots point at is also identical.

Fixes: b56639318bb2 ("KVM: SEV: Add support for SEV intra host migration")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260923163721.1584779-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index cdc1c04f60da..63eb2155a774 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2048,6 +2048,12 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	src->pages_locked = 0;
 	src->es_active = false;
 
+	/*
+	 * Do cache maintenance on the source VM as it is no longer an SEV VM,
+	 * i.e. memory reclaim flows won't trigger cache maintenance on the VM.
+	 */
+	sev_writeback_caches(src_kvm);
+
 	list_cut_before(&dst->regions_list, &src->regions_list, &src->regions_list);
 
 	mutex_lock(&sev_mirror_lock);
@@ -2187,6 +2193,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	 * the set of CPUs from the source.  If a CPU was used to run a vCPU in
 	 * the source VM but is never used for the destination VM, then the CPU
 	 * can only have cached memory that was accessible to the source VM.
+	 * Furthermore, KVM *must* perform cache maintenance on the source VM,
+	 * as the source VM may have access to memory that the destination VM
+	 * does not, i.e. KVM could skip flushes if memory is reclaimed from
+	 * the old VM but not the new VM.
 	 */
 	if (!zalloc_cpumask_var(&dst_sev->have_run_cpus, GFP_KERNEL_ACCOUNT)) {
 		ret = -ENOMEM;

