Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEE3306746
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941880; cv=none; b=nVTsXwEg8yb9Iw0RERQFiImtb3VLWe9XOG0RbyvkVKhmkcMZni4Dn1ozwghUvVtmSnLqrH9Fvr1MGi5gfuOa4FK5NitM7CPz8ALGX403jxOP+tpyePnM+uYRE/91CNe5GU09f6dItKQV0v7VvFBFjuy8awNCk6HHFpAU/pxnMJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941880; c=relaxed/simple;
	bh=/OZocwssauKut9omL+lEctVuKNcS9FDNbSCdoNKeBVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/FcWCsJ9EuLrEF8kk+Hx9ZecNwHVDttazx1UZW1lsm4dJJEjW0HC8jXOZZ0wwDrU0ssado0/0fEWbhkD1QIcyZBrQKm5ZTo6/2p28eHUYn+IyGH3tUG9xSBVzuBTcA9F6JzjMU2mD6rX9OULXS5H1UqCktlE++0TcJz3lhAX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi2s/sY+; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi2s/sY+"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4e9e56e9aso1265396a12.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791941877; x=1792546677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kd9+l5QTagk+LtJ2OjYkYrsvBCuyDHb1Y4sh7dmacA8=;
        b=gi2s/sY+r3Pb+VC5xH+nh7naC/YZ9jPZB7BOPm0URwTJWFFSu5QBjkHWE9/3Uw/SWv
         eBJbXs7lhvQBRhIo0xIgixh2gYwhlUfPT303TYGfKUH0bZSb1A3FE+JDb+2adQ6nGiCb
         RGlV3vqnOVp/C9yIU2Hcu3U3vZ4DPV9b/HNe4Ut+Y/D/MJ7EmU3syBF2+nPc7TzgH8FE
         a7dYyvtOK8Wbj2HKtCbo2Xx//nfBXeFAQCcNjMJ6a107V5CJyf6suerjfCQz1O/mIeDv
         Lxc086di0K+xUmom5/i/gRjHm3K720r4ZGyEHv80I8J5RzW1c7zcFE+6+ovOhST2nE8I
         d5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791941877; x=1792546677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kd9+l5QTagk+LtJ2OjYkYrsvBCuyDHb1Y4sh7dmacA8=;
        b=ZyMet/tcgelllIL/tm4OBQI9JD07eBEw6bfwn8jrm+vZ6ghOBIe41764RtgbK/7jmI
         cXpFHr7qq1d5CvgphkV2AmaYZCMr1W67mDmWaoEzKlPWfaaFEwZtc2swgz7DQf9dUk9L
         SEd1DNR5PRBtT0D4qYq0UB8RQ9D523WCs8a+QoU/5oo95Lh4lu1tnPVheweqt6qhWaN1
         LIugoTmodMYl/VS4cgME/Agkc7HfA5ed0c/1eMypr9lTUK2Tl3kxBMDB0W5E5ADlPs6Y
         zs8rUGbDdJ8enhqNVdgVaTFaR1+XKUP007iVbCcs6MV0neChXAP3dmD/yUonJkgbwxCY
         kw4A==
X-Forwarded-Encrypted: i=1; AKwUvByD4ZPHlHzejxo4UZzKjEazh9XL9ofWMAQP+1eATHJNkjEmfK5T658vxk6lmzDoqikp2kRTdSg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeeLsQBf27GiMt8JSUURNUZ/M4a1spkaQHKjA6dmYahl6f/p+H
	/ybgKMplLT7KaROlSC9iUOOTkIT9cpQfW+pMfG32cWwaPatop1nXRkZM
X-Gm-Gg: AYBFou3xd0ALE1incRVwPBerhAfsK5Rf+yXO5frtPhxL5k+5aIQB+4UsblPP7zy7dHe
	x4jZAOqkn9afUfTIz/1/jDg1cg9867j3ZiX6QyPjnJCpiM+eH3iCH9qVrnqmz9A0NxhDcQZtRkZ
	5sZO73MsGo0Tgmcel+bAa7ACnD8QRuYUfvg+976Ijro+8NMKhFqWwWN6WXmYZfHfdr7MOrqHH8D
	PXn3D8AGSEXHk9PjTIs98JmdwIO4lxLEwA+6IuKEP5qlS3ldJp7yREkMW79K+Qr6OOj2lrnCpeg
	nP3Odq7OQedLLjInOE9r0HljNWiaVYKUkFTjAYtVOX929dAxcysQB/PLNF73iHYVy4BFfF2fkDT
	1WUMrExP0ZKb5ZvbJXelju5mFH1wKlVZ4x/tOXzJbhgu1aLP84LMU6epuEi4s178YBVqEgDW7VU
	e1XJTECJtS7PRL221qdCQL1wad3+uE74bveH2inYfebAMMVqqwE+W48MLy4oG4sedDpn9VZ6zTT
	x3V9Yx2IkI/WU5NxM21EmNkQqG28umM3FmOJSClXTBbU9JfYzP2KSppF86XkAN6rgLGo2WDhTfz
	Qpl0AXMqiCmTDAmQHUqVJTwChalfRHZ2O/WyaJBG9cPs+wrf
X-Received: by 2002:a17:90b:314d:b0:3ac:7556:8eed with SMTP id 98e67ed59e1d1-3ac7556a42cmr112034a91.44.1791941877436;
        Tue, 13 Oct 2026 18:37:57 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f203d38sm2062988a91.6.2026.10.13.18.37.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 18:37:55 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Christie <michael.christie@oracle.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH v2] scsi: target: fix demo-mode dynamic ACL dev-entry UAF vs LUN teardown
Date: Wed, 14 Oct 2026 11:37:46 +1000
Message-ID: <20261014013746.46705-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013120528.37749-1-yuz08559@gmail.com>
References: <20261013120528.37749-1-yuz08559@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A demo-mode (generate_node_acls=1) login that allocates a dynamic
NodeACL populates that ACL's per-LUN dev entries in
core_tpg_add_node_to_devs() *before* the ACL is linked onto
tpg->acl_node_list by target_add_node_acl():

	core_tpg_check_initiator_node_acl():
		...
		core_tpg_add_node_to_devs(acl, tpg, NULL); /* builds deves */
		target_add_node_acl(acl);                  /* only now listed */

The LUN teardown sweep, core_clear_lun_from_tpg(), enumerates only
tpg->acl_node_list, so a dev entry whose ACL is still in the window
above is invisible to the sweep and is never disabled.  It is left on
the se_lun->lun_deve_list after core_tpg_remove_lun() frees the se_lun;
when the same unpacked_lun is later re-added and the se_lun is
reallocated at the same address, the stale dev entry is rediscovered by
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
reachable by an unauthenticated initiator; the colliding LUN add/remove
is a local configfs operation.

Commit 49cb77e297dc ("target: Avoid mappedlun symlink creation during
lun shutdown") introduced se_lun->lun_shutdown and guarded the
*explicit* ACL MappedLUN path (target_fabric_mappedlun_link()), but the
demo-mode automatic path, core_tpg_add_node_to_devs() ->
core_enable_device_list_for_node(), was never given the equivalent
guard, and the publish-after-populate ordering in
core_tpg_check_initiator_node_acl() was left unchanged.

Fix it in three cooperating parts:

 1) Publish the dynamic NodeACL onto acl_node_list *before* creating its
    dev entries, so the teardown sweep can observe them.

 2) Refuse to attach a dev entry to an se_lun that is shutting down,
    checked under nacl->lun_entry_mutex -- the same lock the sweep takes
    -- so once the sweep has passed an ACL any later enable for that LUN
    observes lun_shutdown and skips it.

 3) In core_enable_device_list_for_node(), insert the new dev entry onto
    lun->lun_deve_list while still holding nacl->lun_entry_mutex, in both
    the replace and the new-entry branch.  Previously the entry was added
    to nacl->lun_entry_hlist under the mutex but to lun->lun_deve_list
    only after dropping it; with the ACL now published early, the sweep
    could take the mutex in that gap, find the entry on the hlist,
    core_disable_device_list_for_node() it (list_del() on the not-yet-
    linked lun_link succeeds and the entry is freed), and then the enable
    would list_add_tail() the freed entry back onto lun_deve_list.
    Linking both lists under the mutex makes enable and the sweep
    mutually exclusive, closing that window.

core_tpg_add_node_to_devs() already ignores the return value of
core_enable_device_list_for_node(), so a shutting-down LUN is simply
skipped.

Cc: stable@vger.kernel.org
Fixes: 49cb77e297dc ("target: Avoid mappedlun symlink creation during lun shutdown")
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
Tested-by: Yu Zhang <yuz08559@gmail.com>
---
v2: core_enable_device_list_for_node() now links the new dev entry onto
    lun->lun_deve_list while still holding nacl->lun_entry_mutex (part 3
    above), closing a TOCTOU window the v1 reorder opened where the
    teardown sweep could free a dev entry between its hlist insert and
    its lun_deve_list insert.  Caught by automated review.  No functional
    change to the v1 tpg.c reorder or the lun_shutdown guard.
 drivers/target/target_core_device.c | 18 +++++++++++-------
 drivers/target/target_core_tpg.c    | 10 +++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 1111111..2222222 100644
@@ -349,6 +349,19 @@
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
@@ -375,12 +388,12 @@
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
@@ -393,11 +406,10 @@
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
index 3333333..4444444 100644
@@ -267,6 +267,15 @@
 	acl->dynamic_node_acl = 1;
 
 	/*
+	 * Publish the dynamic NodeACL on tpg->acl_node_list before creating
+	 * its demo-mode MappedLUN dev entries below, so that a concurrent LUN
+	 * teardown sweep (core_clear_lun_from_tpg(), which walks acl_node_list)
+	 * can observe and disable those dev entries.  Otherwise a dev entry can
+	 * be left on an se_lun->lun_deve_list that is about to be freed.
+	 */
+	target_add_node_acl(acl);
+
+	/*
 	 * Here we only create demo-mode MappedLUNs from the active
 	 * TPG LUNs if the fabric is not explicitly asking for
 	 * tpg_check_demo_mode_login_only() == 1.
@@ -275,7 +284,6 @@
 	    (tpg->se_tpg_tfo->tpg_check_demo_mode_login_only(tpg) != 1))
 		core_tpg_add_node_to_devs(acl, tpg, NULL);
 
-	target_add_node_acl(acl);
 	return acl;
 }
 EXPORT_SYMBOL(core_tpg_check_initiator_node_acl);
-- 
2.43.0
