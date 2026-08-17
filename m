Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0252F42D76C
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972212; cv=none; b=a8nYPeIWPEV/r/0ac567gv9k3H90Be5ZSzYhjVi6UVp19SEa01Pq2xPxdpGZH2XTCW3T+V/pO/4V9x+WmXkFszLhBdWo5Q7iLs/CvgBw95easpOmMf+KFoUMGINemb6jLtVrcXJMPx15Ms0lmj5/O+72icNI0j+8Ehj3kSGNUPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972212; c=relaxed/simple;
	bh=4qjL9/23Q5XBBmE+HMivWrmIG0Jx1p9uBeS9Z9boFR0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hox3K6SsFtxR4slVo2m01jbVgiRs5+bjNiShUAjx2UVFCc3QmeJKu/YBKsVUwCVqkiUr71KyG3MVqtYfcgN5Ik7fLGB15FQcB1Yd2/vRhr2qqLqgxgO2DawtXIUKuI3at0MISHVV+Cukisv3odrALkpzdsSSkJKy7nsYzbv5+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X6WeHn/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X6WeHn/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3D11F0156B;
	Mon, 17 Aug 2026 13:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786972203;
	bh=GW8Oa9DjGV8xq4x6HSlYTEEdZD1PYw6EIoQ/TGDAH6s=;
	h=Subject:To:Cc:From:Date;
	b=X6WeHn/dSIrWRw0jGbxf60JSQldJh0IHd7AV+y3IbGeN+NZD0NJKfcGBPT1iu9eTl
	 TFxzfJLNsgcWbXgOu1+v+uMzoqelWB9oa1Jg/EK4KpdiDJj1VrgKMSEte6a0XC/juc
	 kRTon+BeW3wI/aLbyQS/aEtthsKpysC9Vwv8dMP4=
Subject: FAILED: patch "[PATCH] KVM: x86/mmu: WARN and clear role.invalid when creating a" failed to apply to 5.10-stable tree
To: seanjc@google.com,imv4bel@gmail.com,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:56:20 +0200
Message-ID: <2026081720-ethics-exhaust-35f0@gregkh>
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
git cherry-pick -x 5ec42d57655c690234c14aece6dd3f209778c1d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081720-ethics-exhaust-35f0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ec42d57655c690234c14aece6dd3f209778c1d8 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 13 Jul 2026 08:25:49 -0700
Subject: [PATCH] KVM: x86/mmu: WARN and clear role.invalid when creating a
 child shadow page

Explicitly clear role.invalid when deriving a child shadow page's role from
its parent to harden against bugs elsewhere in KVM, as violating KVM's
invariant that invalid pages are NOT on the list of active MMU pages leads
to use-after-free due to __kvm_mmu_prepare_zap_page() using list_add()
instead of list_move() when processing an invalid shadow page, i.e. makes a
bad situation far worse.

Yell loudly if the parent is invalid, as it means KVM has missed a validity
check, i.e. KVM is attempting to map memory using an invalid/obsolete root,
but continue on as the child is otherwise still a valid shadow page.

  ==================================================================
  BUG: KASAN: slab-use-after-free in __kvm_mmu_get_shadow_page+0x1817/0x1860 [kvm]
  Write of size 8 at addr ff11000153dd1368 by task repro/853

  CPU: 1 UID: 1000 PID: 853 Comm: repro Not tainted 7.2.0-rc2-3aec122bdcaf-next-vm #5 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4b/0x70
   print_report+0x153/0x49c
   kasan_report+0xbc/0xf0
   __kvm_mmu_get_shadow_page+0x1817/0x1860 [kvm]
   mmu_alloc_root+0x141/0x320 [kvm]
   kvm_mmu_load+0x612/0x20f0 [kvm]
   kvm_arch_vcpu_ioctl_run+0x3dd5/0x6150 [kvm]
   kvm_vcpu_ioctl+0x5e4/0x10d0 [kvm]
   __x64_sys_ioctl+0x131/0x1b0
   do_syscall_64+0x67/0x5f0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>

  Allocated by task 853:
   kasan_save_stack+0x20/0x40
   kasan_save_track+0x14/0x30
   __kasan_slab_alloc+0x5f/0x70
   kmem_cache_alloc_noprof+0xfe/0x2e0
   __kvm_mmu_topup_memory_cache+0x135/0x530 [kvm]
   paging64_page_fault+0x318/0x1e30 [kvm]
   kvm_mmu_do_page_fault+0x21d/0x630 [kvm]
   kvm_mmu_page_fault+0x18c/0x17b0 [kvm]
   kvm_arch_vcpu_ioctl_run+0x1f35/0x6150 [kvm]
   kvm_vcpu_ioctl+0x5e4/0x10d0 [kvm]
   __x64_sys_ioctl+0x131/0x1b0
   do_syscall_64+0x67/0x5f0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53

  Freed by task 853:
   kasan_save_stack+0x20/0x40
   kasan_save_track+0x14/0x30
   kasan_save_free_info+0x3b/0x60
   __kasan_slab_free+0x43/0x70
   kmem_cache_free+0xe2/0x400
   kvm_mmu_commit_zap_page.part.0+0x1e2/0x310 [kvm]
   kvm_mmu_free_roots+0x283/0x560 [kvm]
   kvm_arch_vcpu_ioctl_run+0x33c8/0x6150 [kvm]
   kvm_vcpu_ioctl+0x5e4/0x10d0 [kvm]
   __x64_sys_ioctl+0x131/0x1b0
   do_syscall_64+0x67/0x5f0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Fixes: a770f6f28b1a ("KVM: MMU: Inherit a shadow page's guest level count from vcpu setup")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c9e4739b26d7..a61750f8e1e3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2442,6 +2442,9 @@ static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direct,
 	role.direct = direct;
 	role.passthrough = 0;
 
+	WARN_ON_ONCE(role.invalid);
+	role.invalid = 0;
+
 	/*
 	 * If the guest has 4-byte PTEs then that means it's using 32-bit,
 	 * 2-level, non-PAE paging. KVM shadows such guests with PAE paging

