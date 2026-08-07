Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073A10F0
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110406; cv=none; b=hWmg9gAtIT6Is3CDCz21k01p2S3fSx2L+CgrmPsIKBHv15kYOqs+0r5f45wXMytnFdaRFuay9DuN94SqJOJqYNdB7xPZ/gY3gnF7tolipDkQQDr3p7BDVeRoDOIhy6i+GcVKr3FLJ5JB1LKB171sLJJZM9sPc1aL/K38zkl0OPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110406; c=relaxed/simple;
	bh=8ZCbd1r0p1hFVRN42Nrj31bGv4uQWdavK7XAJwkweJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovbz8iL4jahWrVdbP+FaT7kMbqk//UcVaeWL9Er6GK6MI4D1MMzHeG9REZpbSFxoli9bVJUZnUDeT058VOQUIyvgx28hTvWXRYNMmar64BXt8A0Fpl+c4rkMFxJQt4Mbw8LKAoL1/oKem0TRgWlBhMT95sDKGO7j1whugOLnSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V37ZHrRA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+UNdQf0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V37ZHrRA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+UNdQf0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786110399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ryyH3WMM5bXwtJyWfdY/n49oHZTrsfyGZBILZcJ/9Sk=;
	b=V37ZHrRAf4q4q0WIDzNf7qE1Y+Xo7hGAe2LcdvM7+JVSz/53bbpL3OALVVgPAlCV94gpDX
	HrMzQ9RDsmsvWU5xXHBh+s1Nd1arOz4miYwKnEv6VLs6NTNJeCra3znY0UnYUfOkKtsv/0
	7rTG24/A6KTsidZwr5hSYO/55D0rXIk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-SjfABk2JM8KZs4DbY67GhA-1; Fri, 07 Aug 2026 09:46:37 -0400
X-MC-Unique: SjfABk2JM8KZs4DbY67GhA-1
X-Mimecast-MFC-AGG-ID: SjfABk2JM8KZs4DbY67GhA_1786110396
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4729d2a64efso1221710f8f.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786110396; x=1786715196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryyH3WMM5bXwtJyWfdY/n49oHZTrsfyGZBILZcJ/9Sk=;
        b=D+UNdQf0mvpMwUgs1vqS2AlbkeO5rnbvV3DEByzYgApIpWNGu3faXsEpCHIsjAm0gK
         Ul0Pk3pfYcKaUgEX5YMNsdv2oFCXKFrWxwmlXtCOfLiewdPjQnmbpLrEjAMcSFdgG2om
         Tf3uW2xVQPUP4Km/vhdstLgRAGDN4glXj26LwjI9KYE2ZGbZkjpUXArOEGkyeIEih6Be
         ItaJw7Kb5qpfxBUKaJBXKUCjpm8ItC1Xz6rNfDha2JQE9OFRS5duqbV3eM1TJ7ggYTbr
         BuQihWOry+HZsx77ErZESfHn+yF+0GACE4yx9F/cMfs3cYYCjDEGXzduXAbcpbBUJfY7
         DaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110396; x=1786715196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryyH3WMM5bXwtJyWfdY/n49oHZTrsfyGZBILZcJ/9Sk=;
        b=cQFfDCov96q4RMhGxDgPHhQjXciyNOIZhGPWmbPZWyLzE4G7ZLWbXyABNQFUv8eHBB
         JJwyL4F8ExKcwIASafvz0Z6BE3mOyiUMLOpVmxB2KlTLlKvxoagXe+q1lZVrGv5Mc0W5
         hS3xDvhYc2NQpvM/5zc69Vwuw6VWp9x2oenKJjJH3ZtBWuxASJYFgAl5+mAWrdw/wWNR
         kyhES81i5gRNePzrxV9bJxNgFsMn5sRChYQ8cfmB5w+q8GWUS7PEdp7F0ZmduSyIFB+P
         6LIAYQmnsbeFf5pqwWbWVD0CCGmfEStGnsDZe5RarsNpYjeMqiXYu3anDW8+UUl7wLYI
         wwYg==
X-Forwarded-Encrypted: i=1; AHgh+RqikYkowtiDf45aUQvY2MgIqbTLbCHbbU73tn3WV73AaD/bouccjYSNMmhsTErQXsuzogV+Qbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNSPffRd8PTJQAt8UFkVM9mbqICmjIcyo85cdpVeJjbu9t9cBz
	a9thhTpJSpknfgP3QwRRwZrqEB7J3uC95vNtVGsk/XNyGp1UNgqsIWg32f0dPOdHaJBBuUl6FX/
	cVjufVvFQP9aLKuFpmEss0Dz7cICygyytE4GqUKpQ13PTg4URIU014qvqvg==
X-Gm-Gg: AR+sD115HRGQpnceI31+HuDgR7Dy/qcJjEwOx6fmnWNMuUMXIoG+r1ZBA7Z3nGTeAZ0
	KyPO7tySTEeO5ck8u3A0/oPajOBz7QGKZpjejijKfz2JxuXqFGsNiE8KndbP/HDMoTI7eXEYXEr
	+ht9ztgwAIg4UO3cH7R+AUfChQ8RDjKrHqpd0Ns9FTATyW064Ovrvag8LfdfWn4PGyhEh/K5ujE
	cUjUlhP+P/IuJ2/H+QPgIFIBjl96KdO5GC6JmBZGRVn2+9laIHi30Ok/b2d1TtDIR6O0ZkpeWfn
	TFELIHxjp8ocyKh7If6x6WVbW1sVTTaKckbpz4akaZtc1EH/+L6br84Xl4lT22/PAc6MM6ganYz
	0vG7dzp0PMbd63vsc0ZnLw4dW3yFKamRlZmTeiq1QVmZShwN/1cbTH55ccXEkAosPt9H5BsJjgh
	q8DlE=
X-Received: by 2002:a05:6000:4204:b0:47f:8603:a879 with SMTP id ffacd0b85a97d-48130b2ccfdmr187590f8f.11.1786110396363;
        Fri, 07 Aug 2026 06:46:36 -0700 (PDT)
X-Received: by 2002:a05:6000:4204:b0:47f:8603:a879 with SMTP id ffacd0b85a97d-48130b2ccfdmr187464f8f.11.1786110395790;
        Fri, 07 Aug 2026 06:46:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021fd392sm5928108f8f.31.2026.08.07.06.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:46:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86/mmu: WARN and clear role.invalid when creating a child shadow page
Date: Fri,  7 Aug 2026 15:46:33 +0200
Message-ID: <20260807134633.2622273-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

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
---
 arch/x86/kvm/mmu/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

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
-- 
2.55.0

