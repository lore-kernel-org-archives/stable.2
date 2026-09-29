Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5851475B
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681905; cv=none; b=B4S116FFyHrCtqf6H2zMLAwjgwaRywTt3Y6C5g6N0ive3QOCaJ542M85PeE9kl0HNUE0ydudqk9dLMBlCRHaIOvTVHi/mLB6AD3/og311rHOnDiM/JzXgvTdbSdJxgG5rYhwAmNBK/kp7HS07j61lW2YgmW7tcyb0Y3RTQBFtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681905; c=relaxed/simple;
	bh=G6N5lyNpl2Mqw3K/vtBhk8hJCxLY5PoC+mKwTfAGvLU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FVmuzdLRBe2zak1WOmy+YZLjhnqasWq6X2zksFGcBjoYE/PK0Ti//3DLseCF7zVuMhbquI/VqFgu7N6oC1Onui3vn2tN+vN/E2aQI9/Z5NIg2e+PH/XFYjzy1N/o8tqvNMSP4E0DR20F+W7NH2ny74CnOiVS2Tgq8E6bVXIk6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uyZat6zW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uyZat6zW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F6F1F000FF;
	Tue, 29 Sep 2026 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790681903;
	bh=YPzU5X5NEF10y/zc+7cADxR2TOslOiKsZEHNsz+nqCE=;
	h=Subject:To:Cc:From:Date;
	b=uyZat6zWma5fN6qQ1q0szRiJI41R7/YgBDa2qw/9lyPRzPU6NFxO+Jx9zIJeAUlwX
	 2lEe6K7jKzOqdTKV0z7RdhFBiX+UplAIkUzALQ+KxvuM8Udubol6UooVrfEqml1m74
	 zioHpnczI9UGi80Ru/3fhNlrFtvOLbg6RwOn3k3k=
Subject: FAILED: patch "[PATCH] KVM: SEV: Do cache maintenance on the source VM during" failed to apply to 6.12-stable tree
To: seanjc@google.com,fane@google.com,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:38:18 +0200
Message-ID: <2026092918-chain-guts-3b79@gregkh>
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
git cherry-pick -x 93de2a6a4b91b72607136dd656edf03fb399d27f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092918-chain-guts-3b79@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

