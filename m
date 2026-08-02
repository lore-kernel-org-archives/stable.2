Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B63C07A
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635363; cv=none; b=BIOHf+usRQH103dnshNoAeG5JxkY2RvXYKQsta21P1tio0UVwd8xsnml5n5TlM3FpLtANNHgF5h1+ntGqYWqW0nSsFjn6/apv4OBeT4F8zVM5BRMnlz4kCiyXoUokyHE2BoKm93ZY7bXxSWyQ44hm5bPkWn1ooIX9Vvx+y1xXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635363; c=relaxed/simple;
	bh=0hS01KNtLV5wQOv2UuzuATKb6nhy7su07NbkykuNnKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcEXksmcxnCnKyiQ3P0Rkcc831G6AACC8px6AcJAxUYikxVzKebpiNZwkQpzGB0PumwWswDS76cBSkbIcxkmeTnupiHHjVecLykH+yVYN/xuRbNNgVHYJjbyHaPtfK32MGiCF6Neold4XoioQ97iGNknl6LSuYRzC49jol3EgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCA6nJeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCA6nJeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5420E1F00AC4;
	Sun,  2 Aug 2026 01:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785635362;
	bh=XaS3NbYzTiFcxwVdklwukz/89H0uzt1bb7oCKDug9rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YCA6nJeBW7Ra544pKilDPE4WbTnaQeoWMFbTb8WKPECIzobSCUxmmI1SrE0qSaYJ4
	 m3iXTkzf2JVBfozIK8z30TPUf88gdwR0+TXOAwqiooTu4FaTgHQ+Zzc709EhuwkxE8
	 LBKxsxWOJH8msRuPZVeVhJNcNJw6qawgMAVtBsrvRG0QT7aYOABvvHS2vy+mQ/LmCt
	 OF6Eaw61xymnl5/S9khumuphz/vVb6OUfkPuI6RYeW2VFj1XjaDQiU4ZOvmE7dQRfJ
	 DIn6WN824ts3Ns4SUNRd0ON7WQfhvpTfHzb5JzwKw5EmpbYpcLOYgXD6tH/6+R/Wvs
	 SMghoKC5bio3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zongyao Bai <zongyao.bai@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] drm/xe/pt: Reset current_op in xe_pt_update_ops_init()
Date: Sat,  1 Aug 2026 21:49:15 -0400
Message-ID: <20260802014916.504747-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802014916.504747-1-sashal@kernel.org>
References: <2026072945-jaybird-vaguely-739f@gregkh>
 <20260802014916.504747-1-sashal@kernel.org>
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
index a32752c57ea4..c21f46a56be3 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -2143,8 +2143,11 @@ static void
 xe_pt_update_ops_init(struct xe_vm_pgtable_update_ops *pt_update_ops)
 {
 	init_llist_head(&pt_update_ops->deferred);
+	pt_update_ops->current_op = 0;
 	pt_update_ops->start = ~0x0ull;
 	pt_update_ops->last = 0x0ull;
+	pt_update_ops->needs_svm_lock = false;
+	pt_update_ops->needs_invalidation = false;
 }
 
 /**
-- 
2.53.0

