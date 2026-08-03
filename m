Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E02FC01B
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771047; cv=none; b=mxod0eULBsb2DS2DA2REfeQUQ53y90OIAX54w5W3nqD7UOZjt4oocnzW/aSXH2Cmox2fjygNBoXW4aQQObigGj6Xsf/wmJhB3Kh5Hgy2MomHXvRLOg2kcAW7Sz7I9chbgOrkQdgES3m8nEc8LLwMSNHjCHPcFH/DNCiWEj1sW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771047; c=relaxed/simple;
	bh=Gp3XTrInhJNSFM7OXO9A3RParpfCePCEy4hkY4+JGQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ie8A1EyRvm87RSnRu7+mOpThwVp6SE4w4F7aOes4unPlAarUfZ44Bnlcv6iTqWkaNPPJFHTmKFJnyBhZHciT6kNULBf924BtrSc3zlXNFbn/Q6TONv5zuYj/OwR/nsXdWKEnS0gcA3JeNRckWWmowZfOtIQ3np++ICbqZBP6zvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciyh8HQD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciyh8HQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6CC1F00A3E;
	Mon,  3 Aug 2026 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785771046;
	bh=vKThLuGdb4vaVPE+I48srIjFavFmr8wMDjVQmuDMUUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ciyh8HQDkW5gS+AntmY7EJAgGOTdYiEgYhKC3iVmSEuQ9JIuZmqtq1tPThKSdek7j
	 Axu47/nBpbDnF7loI2rT0to/h0kdN3ydL/YSZAYmbA4Z9XDb5P48sFrDYF3fj/MpUS
	 1EKL+BnrAcEhQDhdNZIlRuitsVhI0wQiSJ0AuIkWgu3UdnWjIo7n6WVkv/3q0lHhnC
	 Ej26w3R6v8wOOCu/nJAXz+4HyQ5pE4ZtkEEddeadWm0rWpP+Gw16jiMi3mNkQ4m3Ny
	 7scYFRvMxFuUu6Grq5E9NUrrx33So2RVyjkx78Ol7XdkknQ4epTmVzoB1SajCxeUgx
	 pZDqBWWLVjbZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zongyao Bai <zongyao.bai@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/xe/pt: Reset current_op in xe_pt_update_ops_init()
Date: Mon,  3 Aug 2026 11:30:42 -0400
Message-ID: <20260803153043.878690-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803153043.878690-1-sashal@kernel.org>
References: <2026072945-delicacy-outlook-06e9@gregkh>
 <20260803153043.878690-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zongyao Bai <zongyao.bai@intel.com>

[ Upstream commit 6384271ac1ac0099198d15df79212a19ebdb929d ]

xe_pt_update_ops_init() fails to reset current_op to 0. On the
vm_bind path, ops_execute() calls xe_pt_update_ops_prepare() inside
the xe_validation_guard() / drm_exec_until_all_locked() loop. When
that loop retries due to lock contention or OOM eviction
(drm_exec_retry_on_contention() / xe_validation_retry_on_oom()),
xe_pt_update_ops_prepare() runs again on the same vops, and each
call to bind_op_prepare() increments current_op without resetting it.

After N retries current_op exceeds the array size allocated by
xe_vma_ops_alloc(), causing an out-of-bounds write into
SLUB-poisoned memory and a subsequent UAF crash in
xe_migrate_update_pgtables_cpu() when reading the corrupted pt_op->bind.

Also reset needs_svm_lock and needs_invalidation which are derived in
the same prepare pass and would otherwise cause wrong migrate ops
selection and redundant TLB invalidation on retry.

Fix this by resetting current_op, needs_svm_lock and needs_invalidation
in xe_pt_update_ops_init().

v2 (Matt):
   - Add details in commit message.
   - Add Fixes tag and Cc to stable@vger.kernel.org

Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-sonnet-4.6
Signed-off-by: Zongyao Bai <zongyao.bai@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260714232433.2737533-1-zongyao.bai@intel.com
(cherry picked from commit 046045543e530605c441063535e7dca0075369a6)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 422dc351dc0e0..de445e4d1ae0d 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1823,8 +1823,11 @@ static void
 xe_pt_update_ops_init(struct xe_vm_pgtable_update_ops *pt_update_ops)
 {
 	init_llist_head(&pt_update_ops->deferred);
+	pt_update_ops->current_op = 0;
 	pt_update_ops->start = ~0x0ull;
 	pt_update_ops->last = 0x0ull;
+	pt_update_ops->needs_userptr_lock = false;
+	pt_update_ops->needs_invalidation = false;
 }
 
 /**
-- 
2.53.0

