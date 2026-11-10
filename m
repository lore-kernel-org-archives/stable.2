Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273920;
	b=ec8YEHpGOiBgt5Cbl2VS9907D0Ua9aqHIZd1XrNgp8+bRS6OJHblA/G9IDf8Dnn2o2Ew
	 CzXPckrU9WPYVxl4T/Xh1KZeu6A1j0AsUjoItUOOl0SlCWiBOGRi3IBmO8f8Z/hjkvmFa
	 oPZK8k0X0VxapyM2p/tm5RLybQ5iVGLwpeECqrMiq2uC+uQ0OLw1AfO667eVvXsLPZhnK
	 N5eeX7hBEH/eKQx29lkZHoS3fAB7f9JLTMYa6rmT3fLLRg3XJm2k3hQpHvZGNAmbo5icm
	 Nokgm15AAa6Iv7pfOdHDInW7AVjwqVmwk/sTB2AxBPM+DnD1SFJcCNepCkTFxyQDfGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273920;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tjaFq5xwa/IOrelTAneOdf39PfpGs/XfLW/2WNlZ0Xs=;
	b=GPXdFpgahGyo8cRXNXlS2XfIXRUFvWbuBfTqAKEXJBfL/eXe6tm+dAKOMfTu0+M6jwDw
	 4jVW34IUL2kRwP1KupI+RoR2PU3v1+wZ70A1ZdQltl3VVdo5+GCDyxuik21NwIDDJoVfD
	 tOPdGO9W3YvvNJsNms4SVFQ1mdB+F3c6SiXPg61oG7Mz+Rb7TC+TU/njL5HL5ReLmCEpv
	 SNtQ3T1d0mTSmIh8w9LCjDOQVmpW8rVQlFci3/1/Le5xo04nLFJR4BVr4OWutfSnaTxKi
	 pxUXYitzeAvUtVScq+OjOD19WuXqmhfuqyxZtb1tmLHMmjpCmDVqp9IGOf9LrkUquRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cjqtr1BD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774826071860
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cjqtr1BD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF201F0089F;
	Tue, 10 Nov 2026 01:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273920;
	bh=tjaFq5xwa/IOrelTAneOdf39PfpGs/XfLW/2WNlZ0Xs=;
	h=From:To:Cc:Subject:Date;
	b=Cjqtr1BDXipstkoZ7zXDQwcAF7+PzB6CRK8KTyOjpGsB9Pw5EBwNLpPzooYizcN/P
	 63DdA5HpTHXbGfRsUCA7E766r2R8YHoJ2BTlvCFlyFWgvSa4VSaCT951S0BWZNXjzN
	 SD4n5hLBRt78+iyoApLvGVQ+tIlfYEocE+CLHJdv1PoF1aIcPP27swPvgKJwLun1uH
	 n99sNWd5tiGRLqRSlCWLTUEI2cIs4H3gZQdmgS2HLYGhWGRv0aKgr61aRklaBjB+vu
	 mJ+Lz/XjbNcoU1+DFVPsCpUt79dFveWhxZdXSJ1kof+hnJouaW+a1yhidUQK0Zf5Ug
	 Bmn+3HuhL1STg==
From: Sasha Levin <sashal@kernel.org>
To: yuz08559@gmail.com,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: target: Fix demo-mode dynamic ACL dev-entry UAF vs LUN teardown" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:18 -0500
Message-ID: <20261109202518-failed-5.10-6a6e7d7230cd@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6a6e7d7230cd4e0a6c003bae5b85bf37a1e77b94
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202518-failed-5.10-6a6e7d7230cd@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




