Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3CE274670
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766876; cv=none; b=WLPMG3nwONgc5gFHRKO0C/m77XeVO7z1yOOPHJWlkfUzYz+BxLo9azxyXmhgN9X8mPS107CRrldDG7TUyJDu8X9m+gDbgcHJvbG5/db0R1q6JncWY+15JOjHzH2iecmW2yQt2QhqgFo32+DA3pwNyYXuV5SUOOWzSWnbxbeMGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766876; c=relaxed/simple;
	bh=TTIF2yuTKSKh3UdoeYTn71nH45zzJjrLx+K0e7I9I44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V80MbRQQNCcR6yAeKxvLiKqX0VQ3Z0dtIFnihPSwqqvdxMI/EEKqbbgy05m4ULLiBcF6lWknDC85jjU3ZOs5tutJbykz+rz/VNKhm9hnNSOdQLLxNN3TOMgSYUQZKgAjiPlWt43l3X+VZF5Lyr1GpnUb5ru4rlk/PMHWyfabjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6puIbYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6puIbYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3E61F00893;
	Wed, 30 Sep 2026 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766875;
	bh=Q1j8yPQBJeT5FAQtWjDL0WMTgC94c+XRyuhbcG42fCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l6puIbYwfxsZCxfAdbdOEWGPXRQOyXgKTwSOXLE07IJCGGr0RamMGHtZW/XIqjnc5
	 gf2vMvfkTSfxDw6q0wg5vHvI1/XOA1oHMSfjJPHXRkmSWj5/nL4KSHNO0bRcMqLUNC
	 03LG1Xrkj3lihDTAS27sn4hTcGrx+VGuZcT7ECijlE14QNeCiX4ARA2WxDPSfadAcQ
	 hCH+rTsA6HO04JuQd6jm5c/uijaCe4ifAQDMgExtArFQwgq1dgKhmZe+IqKUXiJeKb
	 QF1tI1qX+QT6baXkDoFqF8t0cANDRrz8PjlqYx8Qi8lAHmlOUeE/aITXYyflMQk1Ax
	 PdCD0QzTaCLQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Stefan Teodorescu <fane@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] KVM: SEV: Do cache maintenance on the source VM during intra-host migration
Date: Wed, 30 Sep 2026 07:14:32 -0400
Message-ID: <20260930111432.1208885-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930111432.1208885-1-sashal@kernel.org>
References: <2026092918-chain-guts-3b79@gregkh>
 <20260930111432.1208885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 93de2a6a4b91b72607136dd656edf03fb399d27f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b34df9f57c280..4ec60482fb041 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2020,6 +2020,12 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
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
@@ -2159,6 +2165,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
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
-- 
2.53.0

