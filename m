Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28675172EA
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682060; cv=none; b=V1IyN+ZDO6wmEZXeZVH3Ojh/VZ5upXyQE3eKY+aRqcRAEds/ZWW6elTka6O79x2CvidsmtCxhOKCVshmDZc4s4uFJzXdFd7BcZXffXUsy7RJP4nMVS3MwX2YLQD/wvLCQewGzEx1VAm05KGshP8S99+LP8VUcT6oRRlXs92/4qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682060; c=relaxed/simple;
	bh=C8PSopHMvmpT1QUhcN9iB0Kx+35aY5+qAKeUEQrkCQM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dh1ezKCc5Z2FDaBRZ0O3pDi7CI7XEybmxHBa8lRDLibThmKgIPd2mCZwWzOjZetU0rSdzxqsf1NR6bOCFM3ul7BMw2zXt9nOhZPMBja1P93P8sx+yCHNIC0jADnZaPW0eSqfdxCf8d3alT7WNdtQf8wXMVlLzf5mNAblfDRAV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QCJkvb9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QCJkvb9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE51D1F000FF;
	Tue, 29 Sep 2026 11:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682058;
	bh=hQzylNs/71TkkNzAIFRF+pkWzJLl4Wlzk89omEL2VV4=;
	h=Subject:To:Cc:From:Date;
	b=QCJkvb9T3FdQuSmsqj45t+XkDowy/DFrOfmMTQ6Epi7yQf7KpUxNw5RxaAiC7RH5b
	 +12JhLXArH+F3PLt6BngW6TKDNeQ6LRzXuYq21kIt44Msi4VoLbGWdJyvBBV5dsG9M
	 nlrilZ7t/vKMYpMYHtFa4r3H8ZCjoaidZ2Otf5pk=
Subject: FAILED: patch "[PATCH] RISC-V: KVM: Release unused page after MMU invalidation" failed to apply to 6.12-stable tree
To: xb@ultrarisc.com,anup@brainfault.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:40:39 +0200
Message-ID: <2026092939-uncouple-mummy-4b72@gregkh>
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
git cherry-pick -x ed54fdb460a6e81d5f8f38388d1f10b385dd4a58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092939-uncouple-mummy-4b72@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ed54fdb460a6e81d5f8f38388d1f10b385dd4a58 Mon Sep 17 00:00:00 2001
From: Xie Bo <xb@ultrarisc.com>
Date: Mon, 10 Aug 2026 13:15:43 +0800
Subject: [PATCH] RISC-V: KVM: Release unused page after MMU invalidation

If an MMU invalidation races with a G-stage fault, the fault handler skips
installing the page but leaves ret set to zero. As a result,
kvm_release_faultin_page() treats the page as used and can unnecessarily
mark it dirty.

Track the invalidation retry separately and release the page as unused,
while preserving the existing return value so that the vCPU retries the
fault.

Fixes: 2ed90cb0938a ("KVM: RISC-V: Retry fault if vma_lookup() results become invalid")
Cc: stable@vger.kernel.org
Signed-off-by: Xie Bo <xb@ultrarisc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20260810051544.3953925-2-xb@ultrarisc.com
Signed-off-by: Anup Patel <anup@brainfault.org>

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 6035b5ec9503..d189fd58d7bf 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -627,6 +627,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	int ret;
 	kvm_pfn_t hfn;
 	bool is_hugetlb;
+	bool unused = false;
 	bool writable;
 	unsigned int vma_pageshift;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
@@ -719,8 +720,10 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 
 	write_lock(&kvm->mmu_lock);
 
-	if (mmu_invalidate_retry(kvm, mmu_seq))
+	if (mmu_invalidate_retry(kvm, mmu_seq)) {
+		unused = true;
 		goto out_unlock;
+	}
 
 	/*
 	 * Check if we are backed by a THP and thus use block mapping if
@@ -743,7 +746,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 		kvm_err("Failed to map in G-stage\n");
 
 out_unlock:
-	kvm_release_faultin_page(kvm, page, ret && ret != -EEXIST, writable);
+	kvm_release_faultin_page(kvm, page,
+				 unused || (ret && ret != -EEXIST), writable);
 	write_unlock(&kvm->mmu_lock);
 	return ret;
 }

