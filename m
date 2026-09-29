Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB51F515965
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682045; cv=none; b=Ufp4x5JZoI1VN6auMGA4YdtSFX72vLXfPADvBbbpK/qm9rCXFeVdtZMR5ZwXWNrz0HnYCnIG+LyHB7rDTbg47Vro6yF3ItOXyU2WPOzKRqWWbJA15BkfkAtnu7pMMoyRSnVLYOKg0USfnFAbLoop2aB9k55yFOKMdp/S8hssaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682045; c=relaxed/simple;
	bh=MI4hWOy0flZVvSYFZ+2LjmHTmj672KA7BrXb37cT/lA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GLX6xFsOLrdRufaG8w0W0PwV7msBTURmpTk4WV11lADEbPkvYPBdbthFyUapSx5xq9IiqXZFtyoRdFYAT6jjyAa4zENY3C0c34ISGcPvs+04Lj8ln0lIzUEHVGR/ChFtGb6VfJFyJBulMqlfXhUqI5+57d4LsknHOCsSsuFN8Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2b841oIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2b841oIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BBE1F000FF;
	Tue, 29 Sep 2026 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682044;
	bh=NijgC5b0PU2VuDS1dj5QyeqXsWCaOivZfIvj2pdFGoo=;
	h=Subject:To:Cc:From:Date;
	b=2b841oIWdAyMj6T8/2Xni+Qj0sUndmvEuoY8of61AadV4bXGC4PxrICbwupiXVCyX
	 5IueocEMR69d/b2Gf1FkN0SR0thcv4681sKqpTOpdAud29eR6siPHzl0R2ruHATaiz
	 7F0AOdG5XcglluYl/kgvAynvlTI6Hlb6ZIzV5yCA=
Subject: FAILED: patch "[PATCH] RISC-V: KVM: Release unused page after MMU invalidation" failed to apply to 6.18-stable tree
To: xb@ultrarisc.com,anup@brainfault.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:40:38 +0200
Message-ID: <2026092938-clause-lego-70c6@gregkh>
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
git cherry-pick -x ed54fdb460a6e81d5f8f38388d1f10b385dd4a58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092938-clause-lego-70c6@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

