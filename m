Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593846;
	b=41No2lD/GI6kbKMQk8Oaf5g9bGR+JWxhiI6KBsaxUBp/N6h4ERgJAS8Mr0mbaAc/hNTQ
	 E3l0wwQ/e/+8QUTDEZ0X5ynOwlCBTjI/abncErWuAd4xLbVBMSmaq/IFvl9EwvzU5Y3ZL
	 WdsXIfLXRIJUQkexminIWHg6xX4UqD4duvu2Ic1VSQ4Db8MwKJVvx5QZqc8Teq0bFg5Lf
	 N7R8HdENcGWgAKGm0XdYRHkbtqi+junzIoW5NJBUgLdTse3vQZTCkFI+rC4XD/AvZLare
	 jAJGHeFcmGCp4Y2Dem6HqtGjLyFh43DSdmYPcbL31IkaYjn4fb1ELzqL7V6CnijdTow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593846;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=l6CNGkphXPj/lI9umcnYKkzEK/ujeQ2poIyFQgRGPsg=;
	b=Pb8gqUzxl5G/gR9E5Gno7cFMis13JYLYJuVq3CsgKzZSFh7jfBeS6rT8IDPddW8jXOUt
	 uJtr0Wdc/zWt1kwayJ9uOF+8CVp2rsy1ghzNONxrioZSw6IJVPYLAbXiYFUApmjDelova
	 aUCrjrZY/RD4rUfVb9eveCCoWvKEsB0XREqGQvxqCPM5bcKGwOfSm+K2V+UQcEVogh3rR
	 V9MdHSpaoH0XZNHU7JOOOxPNXYHnmxt8cByhfo8Te2fTadEP68rmhS/TyBM23mepgp9Ab
	 BmEZ2rgVPyvO2RAIPg4ukjCczc8gAfhu570FW9UIE4sauc4AMbca7jIqxKv1gtDgwfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kni74IQS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4FD606A33D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kni74IQS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE421F000C4;
	Fri, 13 Nov 2026 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794593845;
	bh=l6CNGkphXPj/lI9umcnYKkzEK/ujeQ2poIyFQgRGPsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kni74IQSjU55VTedNFRD21W39VftnLbZNJjyDC1ohQoAhaGyDYOo7y/ggmcopwuOf
	 kQaTF3sWcOM24eUVsIjF1FtlDlOZrd8tAqp6Dj9pPEv37ScgsmaHDZnuYNowi99WYu
	 +YUXMbaDY5TMqhqQSzh0nMaa447BkiU84/0yEkQqUePsOcO1ht9VMt26Ntl00bowy+
	 yRyqM8x8+dKxjyIrNfRgj7rj/33avovl+02t9YLj2YPY2rFJdXOtO+O4tCIFPkM9nq
	 4LSS2OhvDxVFNuB3wMcKS7jIkDmwnksSt35vcBlCvo9TJazwnZRlSnWuPRBzDqmcg2
	 yPsS7rZRZV5aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Zhang <yuz08559@gmail.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: target: Fix demo-mode dynamic ACL dev-entry UAF vs LUN teardown
Date: Fri, 13 Nov 2026 13:17:24 -0500
Message-ID: <20261113181700.2168703-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202518-failed-5.10-6a6e7d7230cd@kernel.org>
References: <20261109202518-failed-5.10-6a6e7d7230cd@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Zhang <yuz08559@gmail.com>

[ Upstream commit 6a6e7d7230cd4e0a6c003bae5b85bf37a1e77b94 ]

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
[ sashal: Replaced the free_stats cleanup path with kfree(new) and a direct -ENODEV return because statistics are embedded in the device entry. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_device.c | 18 +++++++++++++++---
 drivers/target/target_core_tpg.c    | 10 +++++++++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 50135f8df1b4a..877d4d8e8ebb7 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -330,6 +330,19 @@ int core_enable_device_list_for_node(
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
+		kfree(new);
+		return -ENODEV;
+	}
 	orig = target_nacl_find_deve(nacl, mapped_lun);
 	if (orig && orig->se_lun) {
 		struct se_lun *orig_lun = rcu_dereference_check(orig->se_lun,
@@ -357,12 +370,12 @@ int core_enable_device_list_for_node(
 		rcu_assign_pointer(new->se_lun_acl, lun_acl);
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
@@ -375,11 +388,10 @@ int core_enable_device_list_for_node(
 	rcu_assign_pointer(new->se_lun, lun);
 	rcu_assign_pointer(new->se_lun_acl, lun_acl);
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
index 62aa5fa63ac09..9b1c23fafbbe6 100644
--- a/drivers/target/target_core_tpg.c
+++ b/drivers/target/target_core_tpg.c
@@ -265,6 +265,15 @@ struct se_node_acl *core_tpg_check_initiator_node_acl(
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
@@ -274,7 +283,6 @@ struct se_node_acl *core_tpg_check_initiator_node_acl(
 	    (tpg->se_tpg_tfo->tpg_check_demo_mode_login_only(tpg) != 1))
 		core_tpg_add_node_to_devs(acl, tpg, NULL);
 
-	target_add_node_acl(acl);
 	return acl;
 }
 EXPORT_SYMBOL(core_tpg_check_initiator_node_acl);
-- 
2.53.0

