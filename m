Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584325;
	b=HYI2ox/c5inyP4++EILnQbichAIirtUJvsgQwrtznuzuyQgEGJlPLKOJxqGL6VdT/y1v
	 RJHa+aUicHq9LhAHuMcrP/HniCloYPEAN+8Ebjv2eANVuqdRs/vJtYZgdPSCn/i5XOCpr
	 9dC8Kslvv6pR4GPlKUSteeEEK84AQ0h0f1F0y0NTEYYu1+4zNm5r444BF1PxCqVrevWHb
	 T3g98+1QdKMo99s3eRSqTGlqlGWdOGXSzTBijpKbD/KYKTuzeq5NmpSE6e/4o33TFk8C6
	 CfI8GwjD24FCtljcWSTGx3+5j/VwJkD/feQB3m2pG9v4u0iEyWFouJMblWIycvV+xhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584325;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AHtgZ/M1gk0ZYsYF1fzUA/+x7MYoqtaP561yS8IaDhw=;
	b=OO04zBsUL9Y7Buw6cz5mBpAy8kfDcBto8yQxD85xTnd3AveCXiKZX+5eobbUfEON1z9/
	 +sYCAkO6BgDlJuqDfRWudme8XuuLFUVSotPTMeXx7sglNmxXa1H8QHA/lDDPd5aUO9QO5
	 ktBwlSfjd6zXVXNw4Qx/zwyf3KsdTp2Rq/0ig49L67HjgdDqKa4F4kx2DqxhMr71ea9Xl
	 UwpKtDHYG/b+ljSXQUCqkn1Gv/DXEWerBWOkob91QTh12Fa5CxTtq5ZA5pqDajMmUZsao
	 jTvtRvvkXpprdgjOsi55U2pr4mHpEMdWjG037joJZAbOkOjZwdRIeEz1KZnStcJCOSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaA2rNNQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F5606A32E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaA2rNNQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7C21F000C6;
	Fri, 13 Nov 2026 15:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584324;
	bh=AHtgZ/M1gk0ZYsYF1fzUA/+x7MYoqtaP561yS8IaDhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KaA2rNNQ1oA5/uuU0GqOxvzdOM2qUYy15Sp8+WNlxmMLnYP2YVcRkLAAYFnxBEmX1
	 rRI3G+JHVnsFjbLIriQoAQDWCqNwZ3iS+ECywIY+aLQGt8Z3ZYngeMuWwtTXubFxHV
	 D6Ssiz8U/5T/xUDgenWuZjHwoDrbQqrwPGaTRgeLN1OIBFxXKFzELC0/zZ+w17EE0A
	 EgIrHOI+M/59iuFxDDjTD01p/508/757NcveZLlZciRlWNDUPbxRLDHy1/jYcvdzCB
	 zOhMeJWVWGBcqnDdwg5rX3al8rmjK/MtAZDRXuPSJI3N22lLdNYeuPyvzaHeLhqmZf
	 L7VytyuJpqR+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Zhang <yuz08559@gmail.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] scsi: target: Fix demo-mode dynamic ACL dev-entry UAF vs LUN teardown
Date: Fri, 13 Nov 2026 10:38:42 -0500
Message-ID: <20261113153803.1958765-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113153803.1958765-1-sashal@kernel.org>
References: <20261109201023-failed-6.6-6a6e7d7230cd@kernel.org>
 <20261113153803.1958765-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_device.c | 18 +++++++++++++++---
 drivers/target/target_core_tpg.c    | 10 +++++++++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 60ea1a317065a..c7fb180c19b18 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -350,6 +350,19 @@ int core_enable_device_list_for_node(
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
@@ -376,12 +389,12 @@ int core_enable_device_list_for_node(
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
@@ -394,11 +407,10 @@ int core_enable_device_list_for_node(
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
index c0e429e5ef310..d8f4538e48dc7 100644
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

