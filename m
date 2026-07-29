Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604D4471CFC
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323524; cv=none; b=JfWdYs/cfhuSls9IcodvJDSzbQcYghXONVPek+7/pueqyjH2W0qSzctPhWzYnZPaagjPPwRCkg/F5IUrewUb8psprlN9DovaCVr6d34UogyOgijKpziBxJooLniVuENZg3MwOZXJY1xZd6uu89dI62vCiBucd/s4C0ViaV1tCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323524; c=relaxed/simple;
	bh=uumfLho2KyyiB09EoqVZhNg6WUEMCajcMeHsNtUtu0I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=btcfkEVUBLa3ZPOlwJElVosTnfxmp+DHF4sFe3S/j0fxEqTsx5ZmQENfMmg8rTGFhqC4sUBTL/Wmtda2GwPblsPVYQPc8owMhJXsQJelCQ7U6VOvLp8IqW/HN3YCgWzloqNIDp5rrN3+jNfDUWV7bvSyRLEzIVqiwh8tgaLRWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xujeo3nX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xujeo3nX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD401F000E9;
	Wed, 29 Jul 2026 11:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323523;
	bh=zZ4W5xnY89S01zE5Jh8DvpHAeCGpjXL67QVs2olpW/o=;
	h=Subject:To:Cc:From:Date;
	b=Xujeo3nXnIaKH6+XTmI5eVxhGZHSBkY73Py+1h6Se9GfiXTIzxgs5JBAWEL1aV8hd
	 /mh0TeGDPrSvqpg+fLlrAiKKC78EGOKg1GRwexqcTeDFohK+YB2tZml/JEikcjOo6s
	 20Ie7+31Jq+v3DEUu7VIgiLFFVmQ0NFx4/f3vE5I=
Subject: FAILED: patch "[PATCH] drm/xe/pt: Reset current_op in xe_pt_update_ops_init()" failed to apply to 6.12-stable tree
To: zongyao.bai@intel.com,matthew.auld@intel.com,matthew.brost@intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:11:45 +0200
Message-ID: <2026072945-delicacy-outlook-06e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6384271ac1ac0099198d15df79212a19ebdb929d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072945-delicacy-outlook-06e9@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6384271ac1ac0099198d15df79212a19ebdb929d Mon Sep 17 00:00:00 2001
From: Zongyao Bai <zongyao.bai@intel.com>
Date: Tue, 14 Jul 2026 23:24:32 +0000
Subject: [PATCH] drm/xe/pt: Reset current_op in xe_pt_update_ops_init()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index e787c0c27c42..39c9c8f0ea2d 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -2365,8 +2365,11 @@ static void
 xe_pt_update_ops_init(struct xe_vm_pgtable_update_ops *pt_update_ops)
 {
 	init_llist_head(&pt_update_ops->deferred);
+	pt_update_ops->current_op = 0;
 	pt_update_ops->start = ~0x0ull;
 	pt_update_ops->last = 0x0ull;
+	pt_update_ops->needs_svm_lock = false;
+	pt_update_ops->needs_invalidation = false;
 	xe_page_reclaim_list_init(&pt_update_ops->prl);
 }
 

