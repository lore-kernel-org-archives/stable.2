Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE15B345EB4
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400414; cv=none; b=PePMAzhLipk1paO/ntrJ/AXXtIFo4rZBBIGLau9ZNSyLz9aVW5LGSZ5YIcrE0rKLf0R6oUPuwQ0yRApmD8aIt9SWuzLdvcMdTKqAy8lGAWIctS/q3+Z1UjeWNriedB005nyixWpElRajmay25wJaA9CX3G+7imQwiVxJfccI/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400414; c=relaxed/simple;
	bh=4P9v5MNF+H4noSBR7OJYRA03UpcVDJ1wkDA1N3AMcj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HmwZcIkoWfIe/a1oI1jd12N0uDY6yHlbNDNFyqoNiZaKJ2ejNN8STFNbADvYioyrHhDqF35qklef3bj/jfKbMED5eFt0RQGRMq7OerQReXthv4Wq+ssvL2baVtjf4/DHFGMhNrPgmt2IyDilxY9yFCd24vb8WgBQX1BF4c/HgM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EA98V28q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EA98V28q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NvmGXSA00HPZOSJCm9LwOa3iASeTeG9V+ogkkFW7yoI=;
	b=EA98V28qB/0AdTy9zs/gYXej+9OkmuEoq2tsBWtvbyBtjKlyWIkSN75jcM/SlislHBnzSj
	9/WH5eMBXGwmtZC6VZ32KWjcON7T0+C8Wqvl/CUd2TQlEUdDWJ8bML3nfajFHgs7rExEXJ
	2OQOaXA058mnul3UYDTR3+nZowBkF9A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-mf8t4hv8OJ20ml8ky0IVzw-1; Sat,
 26 Sep 2026 01:26:48 -0400
X-MC-Unique: mf8t4hv8OJ20ml8ky0IVzw-1
X-Mimecast-MFC-AGG-ID: mf8t4hv8OJ20ml8ky0IVzw_1790400407
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC408195606F;
	Sat, 26 Sep 2026 05:26:46 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35B091956086;
	Sat, 26 Sep 2026 05:26:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Gabriel Schneider <gbrls@osec.io>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86/mmu: Bail from shadow walks if the root is invalid or a dummy
Date: Sat, 26 Sep 2026 01:26:45 -0400
Message-ID: <20260926052645.195528-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Sean Christopherson <seanjc@google.com>

When walking shadow page tables, immediately terminate the walk if the root
is a "dummy" root, i.e. a root whose top-level page table is backed by the
zero page, but otherwise doesn't exist.  If memslot creation races with a
stage-2 page fault (EPT violation or #NPF) from L2, then if the stars align,
KVM will attempt to walk shadow page tables using the zero page and hit a
NULL pointer deref.

  BUG: kernel NULL pointer dereference, address: 0000000000000021
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0000 [#1] SMP
  CPU: 30 UID: 1000 PID: 941 Comm: qemu Not tainted 7.2.0-rc2-1b731e5ded48-next-vm #1741 PREEMPTLAZY
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:__kvm_mmu_invalidate_addr+0xea/0x210 [kvm]
  Call Trace:
   <TASK>
   kvm_mmu_invalidate_addr+0x92/0xe0 [kvm]
   __kvm_inject_emulated_page_fault+0x67/0x80 [kvm]
   ept_page_fault+0x160/0x850 [kvm]
   kvm_mmu_do_page_fault+0x102/0x1f0 [kvm]
   kvm_mmu_page_fault+0x8e/0x6b0 [kvm]
   vmx_handle_exit+0x163/0x640 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0x960/0x2120 [kvm]
   kvm_vcpu_ioctl+0x2c7/0x970 [kvm]
   __x64_sys_ioctl+0x90/0xd0
   do_syscall_64+0x67/0x5f0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7f606d0b53bb

Opportunistically harden the shadow walks against fully invalid roots, but
WARN, as all callers are expected/required to pre-check for a valid root.
Don't WARN in the dummy root case as the whole point of using a dummy root
is to provide a root that's valid enough to enter the guest, i.e. it should
Just Work for all flows except those that *need* to know about dummy roots.

Alternatively, KVM could allocate a dedicated page and associated shadow
page structure for the dummy root, which is very tempting as it such an
approach should be more resilient against unexpected behavior.  But that
would be a much larger and thus riskier change than simply terminating
walks of dummy roots.

Fixes: 0e3223d8d00a ("KVM: x86/mmu: Use dummy root, backed by zero page, for !visible guest roots")
Reported-by: Gabriel Schneider <gbrls@osec.io>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260925234256.2384816-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8e62476e477b..a0d608e3fceb 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2512,6 +2512,12 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 
 	iterator->addr = addr;
 	iterator->shadow_addr = root;
+
+	if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(root)) {
+		iterator->level = 0;
+		return;
+	}
+
 	iterator->level = vcpu->arch.mmu->root_role.level;
 
 	if (iterator->level >= PT64_ROOT_4LEVEL &&
-- 
2.52.0

