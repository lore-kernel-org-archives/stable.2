Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273306;
	b=uAqza0Ej9z4hw2IJ2TZ15EXpiU9vf8myOtTaxmV3BmckF1jzUoKOhNAiAff91fT77/rp
	 pZFx5aYTsKyvM/RMSvx1Rv+aN5jJzOm1WFWbjWSxl/DYn0O5S5+V5uu7Dyd8PI4YYDqux
	 qEIBo89fhJIMWzMvVyrzCr/TUT3kyDci4rnW2U53FE1Ty/srgzxYdOixJH/ld84n5bVZz
	 5RKSVXpbX9W9vfvqggJr+j76lsyV719t+TgHugO+Ruh4DHXqIhuGR7mUkPjAc1pLx6ef3
	 A6PvhbOF79QDcCZ6Q6E0zB9BNxrnpZ6axcJ5ePWHpRFA0H1ok1fE3szqf82ziQNdY4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273306;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Yvi3bSoVjPm/Kqg8iGfm7x1wwfS9fC6tiHZOaXUIOAw=;
	b=P4y0Pj4ajdlRhJg/fEVypM2or8q3srL53tNNEiEuf4XwiDHUkYl46dONFvpLfqsRhn+p
	 svXA1MpGMK5rid/rGda/kCwZbLWeXSrjuOffpI6FBPxe7xjOotC1NYqOYfoJzKHP13EDC
	 pImCaME+qpqqaB+UdJQJ/6n6RHymIY3L7mL52tVF33QLB2R4VKj3lRVGoBa/zOShhm/OK
	 PRaqToYNM2zo33urh0ZWYs3IowMDGZAEYtBvjL1WZRTcUipN8r+Plb/tTIjzwboi1fFW6
	 emb/8YIyEPqKmBuUhTLNhYf7kb3TjnKmP54M+EAz2nqnWVh5Cgyzo77Nt/l0m+W6T4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oF2o+R2r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928D5606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oF2o+R2r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A941F0089F;
	Tue, 10 Nov 2026 01:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273305;
	bh=Yvi3bSoVjPm/Kqg8iGfm7x1wwfS9fC6tiHZOaXUIOAw=;
	h=From:To:Cc:Subject:Date;
	b=oF2o+R2rfrp2g0Sts5cVtlFCZZpsYSS07NThz73Dl4C6JM7sCIY4gWFW81IzZP7fs
	 efsQQC693y8geD7yYb97zULhlezNI10AGVrBiR4TtiVtqKNbtTC0fYENke+sG+RdkT
	 /2JYT3VZ1vU1EkcULXF+90Ib6mvDfuXHmDqUoPTijl+6Jr2HEZlAiHJ9wy2V0oVCKp
	 rbk3hHaNYUIZVzUHui35pZwVTf6+ehE+rXWZxrKJ8v/MN2N/x96+4e9fCHWc3qW4Df
	 +7CQDPv5aAd65BbJJ3JLbzomBMhOQepxczvTAr9SNaogs9pJn0BllVqK0UOD8MX9xi
	 J7zuH/w90Th1g==
From: Sasha Levin <sashal@kernel.org>
To: yuz08559@gmail.com,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: target: Fix demo-mode dynamic ACL dev-entry UAF vs LUN teardown" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:15:03 -0500
Message-ID: <20261109201503-failed-6.1-6a6e7d7230cd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6a6e7d7230cd4e0a6c003bae5b85bf37a1e77b94
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201503-failed-6.1-6a6e7d7230cd@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6a6e7d7230cd4e0a6c003bae5b85bf37a1e77b94 Mon Sep 17 00:00:00 2001
From: Yu Zhang <yuz08559@gmail.com>
Date: Wed, 14 Oct 2026 11:37:46 +1000
Subject: [PATCH] scsi: target: Fix demo-mode dynamic ACL dev-entry UAF vs LUN
 teardown

A demo-mode (generate_node_acls=1) login that allocates a dynamic NodeACL
populates that ACL's per-LUN dev entries in core_tpg_add_node_to_devs()
*before* the ACL is linked onto tpg->acl_node_list by
target_add_node_acl():

	core_tpg_check_initiator_node_acl():
		...
		core_tpg_add_node_to_devs(acl, tpg, NULL); /* builds deves */
		target_add_node_acl(acl);                  /* only now listed */

The LUN teardown sweep, core_clear_lun_from_tpg(), enumerates only
tpg->acl_node_list, so a dev entry whose ACL is still in the window above
is invisible to the sweep and is never disabled.  It is left on the
se_lun->lun_deve_list after core_tpg_remove_lun() frees the se_lun; when
the same unpacked_lun is later re-added and the se_lun is reallocated at
the same address, the stale dev entry is rediscovered by
target_nacl_find_deve() and core_enable_device_list_for_node() corrupts
lun_deve_list:

  BUG: KASAN: slab-use-after-free ...
   core_enable_device_list_for_node+0x5ce/0x880
   core_tpg_add_node_to_devs+0x169/0x190
   core_dev_add_lun+0x146/0x190
   target_fabric_port_link+0xe9/0x1b0
   configfs_symlink+0x381/0xae0
   __x64_sys_symlink+0x55/0x80

The demo-mode login path that drives the ACL/dev-entry creation is
reachable by an unauthenticated initiator; the colliding LUN add/remove is
a local configfs operation.

Commit 49cb77e297dc ("target: Avoid mappedlun symlink creation during lun
shutdown") introduced se_lun->lun_shutdown and guarded the *explicit* ACL
MappedLUN path (target_fabric_mappedlun_link()), but the demo-mode
automatic path, core_tpg_add_node_to_devs() ->
core_enable_device_list_for_node(), was never given the equivalent guard,
and the publish-after-populate ordering in
core_tpg_check_initiator_node_acl() was left unchanged.

Fix it in three cooperating parts:

 1) Publish the dynamic NodeACL onto acl_node_list *before* creating its
    dev entries, so the teardown sweep can observe them.

 2) Refuse to attach a dev entry to an se_lun that is shutting down,
    checked under nacl->lun_entry_mutex -- the same lock the sweep takes --
    so once the sweep has passed an ACL any later enable for that LUN
    observes lun_shutdown and skips it.

 3) In core_enable_device_list_for_node(), insert the new dev entry onto
    lun->lun_deve_list while still holding nacl->lun_entry_mutex, in both
    the replace and the new-entry branch.  Previously the entry was added
    to nacl->lun_entry_hlist under the mutex but to lun->lun_deve_list only
    after dropping it; with the ACL now published early, the sweep could
    take the mutex in that gap, find the entry on the hlist,
    core_disable_device_list_for_node() it (list_del() on the not-yet-
    linked lun_link succeeds and the entry is freed), and then the enable
    would list_add_tail() the freed entry back onto lun_deve_list.  Linking
    both lists under the mutex makes enable and the sweep mutually
    exclusive, closing that window.

core_tpg_add_node_to_devs() already ignores the return value of
core_enable_device_list_for_node(), so a shutting-down LUN is simply
skipped.

Cc: stable@vger.kernel.org
Fixes: 49cb77e297dc ("target: Avoid mappedlun symlink creation during lun shutdown")
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
Tested-by: Yu Zhang <yuz08559@gmail.com>
Link: https://patch.msgid.link/20261014013746.46705-1-yuz08559@gmail.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/target/target_core_device.c | 18 +++++++++++++++---
 drivers/target/target_core_tpg.c    | 10 +++++++++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 9db2201aa553f..c5d5d6a91fee7 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -349,6 +349,19 @@ int core_enable_device_list_for_node(
 	new->attach_count++;
 
 	mutex_lock(&nacl->lun_entry_mutex);
+	/*
+	 * Do not attach a new dev entry to an se_lun that is being torn down.
+	 * lun_shutdown is set by core_tpg_remove_lun() before its
+	 * core_clear_lun_from_tpg() sweep; checking it here under the same
+	 * nacl->lun_entry_mutex the sweep takes guarantees that once the sweep
+	 * has passed this ACL no dev entry can be left dangling on the
+	 * se_lun->lun_deve_list that is about to be freed.
+	 */
+	if (lun->lun_shutdown) {
+		mutex_unlock(&nacl->lun_entry_mutex);
+		ret = -ENODEV;
+		goto free_stats;
+	}
 	orig = target_nacl_find_deve(nacl, mapped_lun);
 	if (orig && orig->se_lun) {
 		struct se_lun *orig_lun = orig->se_lun;
@@ -375,12 +388,12 @@ int core_enable_device_list_for_node(
 		new->se_lun_acl = lun_acl;
 		hlist_del_rcu(&orig->link);
 		hlist_add_head_rcu(&new->link, &nacl->lun_entry_hlist);
-		mutex_unlock(&nacl->lun_entry_mutex);
 
 		spin_lock(&lun->lun_deve_lock);
 		list_del(&orig->lun_link);
 		list_add_tail(&new->lun_link, &lun->lun_deve_list);
 		spin_unlock(&lun->lun_deve_lock);
+		mutex_unlock(&nacl->lun_entry_mutex);
 
 		kref_put(&orig->pr_kref, target_pr_kref_release);
 		wait_for_completion(&orig->pr_comp);
@@ -393,11 +406,10 @@ int core_enable_device_list_for_node(
 	new->se_lun = lun;
 	new->se_lun_acl = lun_acl;
 	hlist_add_head_rcu(&new->link, &nacl->lun_entry_hlist);
-	mutex_unlock(&nacl->lun_entry_mutex);
-
 	spin_lock(&lun->lun_deve_lock);
 	list_add_tail(&new->lun_link, &lun->lun_deve_list);
 	spin_unlock(&lun->lun_deve_lock);
+	mutex_unlock(&nacl->lun_entry_mutex);
 
 	target_luns_data_has_changed(nacl, new, true);
 	return 0;
diff --git a/drivers/target/target_core_tpg.c b/drivers/target/target_core_tpg.c
index ccff9f6e48266..e615e5e304273 100644
--- a/drivers/target/target_core_tpg.c
+++ b/drivers/target/target_core_tpg.c
@@ -266,6 +266,15 @@ struct se_node_acl *core_tpg_check_initiator_node_acl(
 	kref_get(&acl->acl_kref);
 	acl->dynamic_node_acl = 1;
 
+	/*
+	 * Publish the dynamic NodeACL on tpg->acl_node_list before creating
+	 * its demo-mode MappedLUN dev entries below, so that a concurrent LUN
+	 * teardown sweep (core_clear_lun_from_tpg(), which walks acl_node_list)
+	 * can observe and disable those dev entries.  Otherwise a dev entry can
+	 * be left on an se_lun->lun_deve_list that is about to be freed.
+	 */
+	target_add_node_acl(acl);
+
 	/*
 	 * Here we only create demo-mode MappedLUNs from the active
 	 * TPG LUNs if the fabric is not explicitly asking for
@@ -275,7 +284,6 @@ struct se_node_acl *core_tpg_check_initiator_node_acl(
 	    (tpg->se_tpg_tfo->tpg_check_demo_mode_login_only(tpg) != 1))
 		core_tpg_add_node_to_devs(acl, tpg, NULL);
 
-	target_add_node_acl(acl);
 	return acl;
 }
 EXPORT_SYMBOL(core_tpg_check_initiator_node_acl);
-- 
2.53.0




