Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9369488210
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772345; cv=none; b=Icw62cK6WjZqAScUL3ETe7NFPTVDiuqefJ54S+V7r0mboHDxKVsSWZee5wwhAw7ULtmEfOi//kuNuqshh4jdt/YI5l7XuEcbJ3Z2s1LqZm3l71eACAySiqtntua3kyvFySPSI3bTisPLwivfSiqXwBfJ7nNKIE0W8csYwZinvd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772345; c=relaxed/simple;
	bh=tpMGQpsVVwUzcLseu3MQ+Yq7jwCjPVAGkHjUKmNHbDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eatkBa+uYC2c9iy/YyquS+0q2+bURV7/zVWKpKVgxosZD+YCSJuvgQOB/0mvs3qJSXA6kpmb4JA5/lFTa87qDs0wPLRExtgtdL/zkgz06VdAbanJqSfDhESM3wwGPCmoVYPhxrJFTZj0SBEr3Qa7B7wmyh5ga+9b9L3rdAUL2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM5FhsUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM5FhsUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81CC1F000FF;
	Wed, 30 Sep 2026 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790772344;
	bh=h3rXky3B26JTli4AKmR34Lc+XHqb3bTzs50jqr7bF6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YM5FhsUqTKCoQ3sG6yn1hXQYf7lh8Hrai/UesRBZL+aFTgPryePW7GO2MjMJBtk1R
	 bJqx4E/BsmbTDpwvyEV2HbN40xmBXSsLyGfur8FJgDlwZ/Ji3jdv98qYbdJX464ifv
	 LaQ85OMXcLU+Kb2zi8NsFswS/EdSoow0oK3B9VVHJPbbq0pG6T45CiyOOBoexd4r4e
	 RPVEMx0LP9wKJtWD/1Zmo0/WPUyKALKn9fokMJ8jMabVe7avb10YtjPtEZJZobA0pt
	 gGP666FQbnCilZ+Os4u/Fg+U8ipkjEdAN095W0n3ZmYZQlveJnYT3bf+W/wcZaFfCb
	 azRprY5EXo+Ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Stefan Teodorescu <fane@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KVM: SEV: Do cache maintenance on the source VM during intra-host migration
Date: Wed, 30 Sep 2026 08:45:42 -0400
Message-ID: <20260930124542.1671035-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092918-providing-domelike-5f91@gregkh>
References: <2026092918-providing-domelike-5f91@gregkh>
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
[ Replaced unavailable sev_writeback_caches(src_kvm) with wbinvd_on_all_cpus(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0ba286bd50c27..2bc25a89f36b3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1723,6 +1723,12 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	src->pages_locked = 0;
 	src->es_active = false;
 
+	/*
+	 * Do cache maintenance on the source VM as it is no longer an SEV VM,
+	 * i.e. memory reclaim flows won't trigger cache maintenance on the VM.
+	 */
+	wbinvd_on_all_cpus();
+
 	list_cut_before(&dst->regions_list, &src->regions_list, &src->regions_list);
 
 	mutex_lock(&sev_mirror_lock);
-- 
2.53.0

